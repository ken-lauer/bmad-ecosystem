!+
! Module bunch_soa_mod
!
! Phase 3 of the fast large-N bunch tracking project. Used by track1_bunch_particles (beam_utils) only
! when enabled: set the environment variable BMAD_FAST_TRACK=1 (see fast_track_enabled).
!
! Structure-of-arrays (SoA) bunch representation plus "prepared slice" kernels that reproduce
! track1 (bmad_standard) results for a restricted set of elements:
!   drift       (and any element that track1_bmad tracks as a drift because ele%is_on = False)
!   quadrupole  (bmad_standard, magnetic multipoles + hkick/vkick allowed, no fringe, no electric multipoles)
!
! Usage pattern (see fast_track1_bunch):
!   if (fast_track_eligible(ele, param, why)) then
!     call fast_slice_prepare(ele, param, fs, err)        ! Once per element/slice. Serial.
!     call bunch_to_soa(bunch, soa)                       ! Or keep soa alive across many slices.
!     call fast_track_soa(soa, fs)                        ! OpenMP over particle blocks.
!     call soa_to_bunch(soa, bunch)
!   endif
!
! Exactness: Every floating point expression is copied from the corresponding Bmad routine in the
! same evaluation order. Bit-identical agreement with track1 additionally requires:
!   * Same FMA contraction decisions. GCC contracts a*b+c by default (-ffp-contract=fast) on targets
!     with FMA (aarch64, x86-64 with -march=haswell+), and may contract differently in an inlined kernel
!     than in the original routine. Build both with -ffp-contract=off to verify bit-identity.
!   * fast_track_time_mode = fast_time_qp$ (default). fast_time_dd$ accumulates time deltas in
!     double-double and is NOT bit-identical (error ~ 2^-106 relative).
!   * param%unstable_factor is NOT updated by the kernels (in track1_bunch_hom it is a shared,
!     racy write already).
! Places where exactness is believed but not proven are marked "UNVERIFIED".
!-

module bunch_soa_mod

use bmad_interface
use random_mod, only: ran_gauss
use radiation_mod, only: radiation_map_setup

implicit none

private :: two_sum, dd_add, powi, quad_z_coef, low_e_dz, orbit_too_large_lane, aperture_lane, apertures_lane, ab_kick_lane, radiation_lane
private :: track_block_drift, track_block_quad, track_block_thick, track_block_bend, bend_body_lane, entrance_block, exit_block, fast_note_why

integer, parameter :: fast_none$ = 0, fast_drift$ = 1, fast_quad$ = 2, fast_thick$ = 3, fast_bend$ = 4

integer, parameter :: fast_time_qp$ = 1, fast_time_dd$ = 2
integer :: fast_track_time_mode = fast_time_qp$

integer, parameter :: fast_block_size = 256

! Max number of apertures checked at one track edge (lord_defined apertures of a super_slave
! resolve to one per super_lord).
integer, parameter :: fast_max_ap = 4

! Drift-like slices are not worth the bunch <-> SoA conversion when converting per slice.
logical :: fast_track_drifts = .false.

logical, private, save :: fast_track_on = .false., fast_track_verbose = .false., fast_track_env_checked = .false.

! With BMAD_FAST_TRACK=verbose, each distinct reason for not using the kernels is printed once.
integer, parameter, private :: n_why_max = 64
character(100), private, save :: why_seen(n_why_max) = ''
integer, private, save :: n_why_seen = 0

! Structure-of-arrays bunch.
! Time: t(:) holds the coord_struct%t value (quad precision) as loaded. In fast_time_dd$ mode the
! kernels never touch t(:); they accumulate the change in time in the double-double pair
! (dt_hi, dt_lo) which is folded into t(:) by soa_flush_time / soa_to_bunch. This keeps the
! conversion coord -> soa -> coord lossless while removing quad precision ops from the hot loops.

type bunch_soa_struct
  integer :: n = 0
  real(rp), allocatable :: x(:), px(:), y(:), py(:), z(:), pz(:)
  real(rp), allocatable :: s(:)
  real(qp), allocatable :: t(:)
  real(rp), allocatable :: dt_hi(:), dt_lo(:)
  real(rp), allocatable :: charge(:), p0c(:), beta(:)
  integer, allocatable :: state(:), species(:), location(:), ix_ele(:), ix_branch(:)
  integer, allocatable :: direction(:), time_dir(:)
  logical :: has_spin = .false.
  real(rp), allocatable :: spin(:,:)          ! (3, n). Only allocated if has_spin.
end type

! One aperture check, from check_aperture_limit for a rectangular/auto/elliptical aperture.

type fast_aperture_struct
  integer :: ap_type = 0
  real(rp) :: x1_lim = 0, x2_lim = 0, y1_lim = 0, y2_lim = 0
  real(rp) :: ex_w2 = 0, ex_c = 0, ey_w2 = 0, ey_c = 0   ! Elliptical widths/centers.
end type

! Slice-invariant data. Everything a per-particle call to track1 would recompute.
! Filled by fast_slice_prepare. Plain data, no pointers: safe to share read-only across threads.

type fast_slice_struct
  integer :: kind = fast_none$
  integer :: ix_ele = -1, ix_branch = -1
  integer :: species = not_set$
  real(rp) :: length = 0                    ! ele%value(l$) * time_dir (time_dir = 1 enforced)
  real(rp) :: s_start = 0, s_end = 0
  real(rp) :: p0c_ele = 0, e_tot_ele = 0, delta_ref_time = 0
  real(rp) :: mass = 0
  real(rp) :: max_ap = 0                    ! bmad_com%max_aperture_limit
  ! Quadrupole
  real(rp) :: charge_dir = 0                ! rel_tracking_charge * orientation
  real(rp) :: b1 = 0
  integer :: ix_mag_max = -1
  integer :: n_step = 0
  real(rp) :: r_step = 0, step_len = 0
  real(rp) :: ab_f = 0                      ! Charge factor used by ab_multipole_kick.
  real(rp) :: an(0:n_pole_maxx) = 0, bn(0:n_pole_maxx) = 0
  real(rp) :: cm(0:n_pole_maxx, 0:n_pole_maxx) = 0   ! c_multi(n, m, .true.)
  ! Misalignment (offset_particle, non-bend branch, set_hvkicks = False, set_tilt = True)
  logical :: offset_on = .false.            ! ele%bookkeeping_state%has_misalign
  logical :: do_tilt = .false.              ! set_t .and. do_misalignment
  logical :: is_misaligned = .false.
  real(rp) :: tilt_tot = 0, cos_t = 1, sin_t = 0, cos_mt = 1, sin_mt = 0
  real(rp) :: x_off = 0, y_off = 0, z_off = 0, zc_set = 0, l_half = 0
  real(rp) :: ds_center_unset = 0, s_target_set = 0, s_target_unset = 0
  real(rp) :: w_inv(3,3) = 0, w_mat(3,3) = 0
  ! Apertures checked at the first (1) and second (2) track edge, in check_aperture_limit order.
  integer :: n_ap(2) = 0
  type (fast_aperture_struct) :: ap(fast_max_ap, 2)
  ! Bend (track_a_bend body without fringe, k1, multipole kicks or misalignment).
  real(rp) :: g = 0, dg = 0, g_tot = 0, angle = 0, beta_ref = 0
  real(rp) :: sinc_a = 0, cos_a = 0, sin_a = 0, cosc_a = 0, sincc_a = 0
  ! Radiation kicks (track1_radiation) at the entrance (1) and exit (2) from ele%rad_map rm0/rm1.
  logical :: rad_damp = .false., rad_fluct = .false., rad_damp_vec = .false.
  real(rp) :: rad_scale = 0
  real(rp) :: rad_ref(6,2) = 0, rad_dmat(6,6,2) = 0, rad_dvec(6,2) = 0, rad_smat(6,6,2) = 0
end type

contains

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_track_eligible (ele, param, why) result (is_eligible)
!
! Routine to decide if ele may be tracked with the SoA kernels instead of per-particle track1.
! This checks everything that does not depend on the bunch. See also fast_bunch_compatible.
! Anything not listed here as supported must fall back to track1.
!
! Supported:
!   tracking path = bmad_standard (ele%tracking_method == bmad_standard$, or ele%is_on = False which
!                   forces bmad_standard in track1).
!   ele%key       = drift$, or quadrupole$. A quadrupole with is_on = False is tracked as a drift.
!   quadrupole:   orientation = +1, nonzero length, no fringe (init_fringe_info has_fringe = False),
!                 no electric multipoles, ds_step > 0 if there are magnetic multipoles/kicks.
!                 Misalignments: offsets, pitches, tilt (non-bend offset_particle branch).
!   apertures:    bmad_com%aperture_limit_on = False, or aperture_type rectangular$/auto_aperture$/elliptical$
!                 with aperture_at no_aperture$/entrance_end$/exit_end$/both_ends$/continuous$ and
!                 offset_moves_aperture = False (when an aperture is actually checked at this slice).
!   globals:      no spin tracking, no high energy space charge, no track1_preprocess/postprocess hooks.
!                 Radiation damping and fluctuations are applied as track1_radiation does.
!
! Input:
!   ele     -- ele_struct: Element (lattice element or slice "runt").
!   param   -- lat_param_struct: Branch parameters.
!
! Output:
!   is_eligible -- logical: True if the fast kernels may be used.
!   why         -- character(*), optional: Reason for ineligibility. Blank if eligible.
!-

function fast_track_eligible (ele, param, why) result (is_eligible)

type (ele_struct) ele
type (lat_param_struct) param
type (fringe_field_info_struct) fringe_info
type (fast_slice_struct) fs_ap

real(rp) an(0:n_pole_maxx), bn(0:n_pole_maxx), b1
integer ix_mag_max, ix_elec_max, kind
logical is_eligible
character(*), optional :: why

!

is_eligible = .false.
if (present(why)) why = ''

if (bmad_com%spin_tracking_on) then
  call set_why('spin tracking on');  return
endif
if (bmad_com%high_energy_space_charge_on) then
  call set_why('high energy space charge on');  return
endif
if (associated(track1_preprocess_ptr) .or. associated(track1_postprocess_ptr)) then
  call set_why('track1 hooks set');  return
endif

kind = fast_kind(ele)
if (kind == fast_none$) then
  call set_why('element type / tracking method not supported');  return
endif

! Aperture. Mirrors check_aperture_limit for the particle_at values used by track1.

if (.not. fast_aperture_setup(ele, fs_ap, why)) return

! Quadrupole and thick multipole specific

if (kind == fast_quad$ .or. kind == fast_thick$) then
  if (ele%orientation /= 1) then
    call set_why('reversed element');  return
  endif
  if (kind == fast_quad$ .and. ele%value(l$) == 0) then
    call set_why('zero length quadrupole');  return
  endif

  call init_fringe_info (fringe_info, ele)
  if (fringe_info%has_fringe) then
    call set_why('fringe fields');  return
  endif

  if (kind == fast_quad$) then
    call multipole_ele_to_ab (ele, .false., ix_mag_max, an, bn, magnetic$, include_kicks$, b1)
  else
    call multipole_ele_to_ab (ele, .false., ix_mag_max, an, bn, magnetic$, include_kicks$)
  endif
  call multipole_ele_to_ab (ele, .false., ix_elec_max, an, bn, electric$)
  if (ix_elec_max > -1) then
    call set_why('electric multipoles');  return
  endif
  if (ix_mag_max > -1 .and. ele%value(ds_step$) <= 0) then
    call set_why('ds_step <= 0');  return
  endif

  if (ele%bookkeeping_state%has_misalign .and. .not. has_orientation_attributes(ele)) then
    call set_why('misaligned without orientation attributes');  return
  endif
endif

if (kind == fast_bend$) then
  if (.not. bend_supported(ele, param, why)) return
endif

is_eligible = .true.

!------------------------
contains

subroutine set_why(str)
character(*) str
if (present(why)) why = str
end subroutine set_why

end function fast_track_eligible

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function bend_supported (ele, param, why, check_fringe) result (is_ok)
!
! Routine to decide if the bend kernel reproduces track_a_bend for ele. Supported: bmad_standard sbend
! with nonzero length and g + dg, orientation = +1, no fringe at this slice (interior slices of a bend,
! or fringe_type = none), no misalignment, no electric multipoles, no k1 (sbend_body_with_k1_map) and
! no magnetic multipoles or kicks apart from the dipole error folded into dg.
!
! Input:
!   ele          -- ele_struct: Element or slice.
!   param        -- lat_param_struct: Branch parameters.
!   check_fringe -- logical, optional: Default True. False skips the fringe test, to ask whether the
!                     interior slices of ele are supported.
!
! Output:
!   why     -- character(*), optional: Reason if not.
!   is_ok   -- logical: True if supported.
!-

function bend_supported (ele, param, why, check_fringe) result (is_ok)

type (ele_struct) ele
type (lat_param_struct) param
type (fringe_field_info_struct) fringe_info
type (coord_struct) orb0

real(rp) an(0:n_pole_maxx), bn(0:n_pole_maxx), b1, dg, rel_charge_dir
integer ix_mag_max, ix_elec_max
logical is_ok
logical, optional :: check_fringe
character(*), optional :: why

!

is_ok = .false.
if (ele%orientation /= 1) then
  call set_why('reversed bend');  return
endif
if (ele%value(l$) == 0) then
  call set_why('zero length bend');  return
endif
if (associated(apply_element_edge_kick_hook_ptr)) then
  call set_why('edge kick hook set');  return
endif
if (logic_option(.true., check_fringe)) then
  call init_fringe_info (fringe_info, ele)
  if (fringe_info%has_fringe) then
    call set_why('bend fringe at this slice');  return
  endif
endif
if (ele%bookkeeping_state%has_misalign) then
  call set_why('misaligned bend');  return
endif

orb0%direction = 1;  orb0%time_dir = 1;  orb0%species = param%particle
rel_charge_dir = ele%orientation * rel_tracking_charge_to_mass(orb0, param%particle)
b1 = 0
if (nint(ele%value(exact_multipoles$)) /= off$) then
  call multipole_ele_to_ab(ele, .false., ix_mag_max, an, bn, magnetic$, include_kicks$)
else
  call multipole_ele_to_ab(ele, .false., ix_mag_max, an, bn, magnetic$, include_kicks$, b1)
  b1 = b1 * rel_charge_dir
  if (abs(b1) < 1d-10) then
    bn(1) = b1
    b1 = 0
  endif
endif
if (b1 /= 0) then
  call set_why('bend with k1');  return
endif
dg = bn(0) / ele%value(l$)
bn(0) = 0
if (any(an /= 0) .or. any(bn /= 0)) then
  call set_why('bend multipoles or kicks');  return
endif
call multipole_ele_to_ab(ele, .false., ix_elec_max, an, bn, electric$)
if (ix_elec_max > -1) then
  call set_why('bend electric multipoles');  return
endif
if (ix_mag_max > -1 .and. ele%value(ds_step$) <= 0) then
  call set_why('ds_step <= 0');  return
endif
if (ele%value(g$) == 0 .and. dg == 0) then
  call set_why('bend with g = 0');  return
endif

is_ok = .true.

!------------------------
contains

subroutine set_why(str)
character(*) str
if (present(why)) why = str
end subroutine set_why

end function bend_supported

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_kind (ele) result (kind)
!
! Routine to map an element onto the fast kernel that reproduces its track1_bmad branch.
!
! Input:
!   ele   -- ele_struct: Element.
!
! Output:
!   kind  -- integer: fast_drift$, fast_quad$, fast_thick$, fast_bend$ or fast_none$.
!-

function fast_kind (ele) result (kind)

type (ele_struct) ele
integer kind

kind = fast_none$

! track1: "if (.not. ele%is_on) tracking_method = bmad_standard$"
if (ele%is_on .and. ele%tracking_method /= bmad_standard$) return

if (.not. ele%is_on) then
  ! track1_bmad maps most "off" elements to drift$. Only accept keys where that is certain.
  select case (ele%key)
  case (drift$, quadrupole$, sextupole$, octupole$, thick_multipole$, solenoid$, sol_quad$, &
        monitor$, instrument$, pipe$, kicker$, hkicker$, vkicker$, ecollimator$, rcollimator$)
    kind = fast_drift$
  end select
  return
endif

select case (ele%key)
case (drift$);       kind = fast_drift$
case (quadrupole$);  kind = fast_quad$
case (sbend$);       kind = fast_bend$
! track_a_thick_multipole keys, minus elseparator (electric kick), ac_kicker (time dependent amplitude)
! and collimators (momentum apertures in check_aperture_limit).
case (pipe$, monitor$, instrument$, kicker$, hkicker$, vkicker$, sextupole$, octupole$, thick_multipole$)
  kind = fast_thick$
end select

end function fast_kind

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine fast_slice_prepare (ele, param, fs, err_flag)
!
! Routine to compute all slice-invariant quantities used by the fast kernels.
! Must be called serially (outside any OpenMP parallel region) since it calls Bmad routines
! that initialize SAVEd tables (c_multi) and may allocate ele%multipole_cache.
! fast_track_eligible(ele, param) must be True.
!
! Input:
!   ele       -- ele_struct: Element or slice to track through.
!   param     -- lat_param_struct: Branch parameters. param%particle is the tracking species.
!
! Output:
!   fs        -- fast_slice_struct: Prepared data.
!   err_flag  -- logical: Set True if ele is not supported.
!-

subroutine fast_slice_prepare (ele, param, fs, err_flag)

type (ele_struct) ele
type (lat_param_struct) param
type (fast_slice_struct) fs
type (coord_struct) orb0

real(rp) an(0:n_pole_maxx), bn(0:n_pole_maxx), xp, yp, ds_center_set, s_pos0
integer ix_elec_max, n, m
logical err_flag

character(*), parameter :: r_name = 'fast_slice_prepare'

!

err_flag = .true.
fs = fast_slice_struct()
fs%kind = fast_kind(ele)
if (fs%kind == fast_none$) return

if (ele%slave_status == slice_slave$) then
  fs%ix_ele    = ele%lord%ix_ele
  fs%ix_branch = ele%lord%ix_branch
else
  fs%ix_ele    = ele%ix_ele
  fs%ix_branch = ele%ix_branch
endif

fs%species        = param%particle
fs%length         = ele%value(l$)
fs%s_start        = ele%s_start
fs%s_end          = ele%s
fs%p0c_ele        = ele%value(p0c$)
fs%e_tot_ele      = ele%value(e_tot$)
fs%delta_ref_time = ele%value(delta_ref_time$)
fs%mass           = mass_of(param%particle)
fs%max_ap         = bmad_com%max_aperture_limit

orb0%direction = 1
orb0%time_dir = 1
orb0%species = param%particle

if (.not. fast_aperture_setup(ele, fs)) return
if (.not. radiation_setup()) return

if (fs%kind == fast_drift$) then
  err_flag = .false.
  return
endif

!------------------------------------------
! Bend. The values set here are what track_a_bend computes per particle (bend_supported has excluded
! everything else: fringe at this slice, k1, multipole kicks, electric multipoles, misalignment).

if (fs%kind == fast_bend$) then
  fs%charge_dir = ele%orientation * orb0%direction * rel_tracking_charge_to_mass(orb0, param%particle)
  if (nint(ele%value(exact_multipoles$)) /= off$) then
    call multipole_ele_to_ab(ele, .false., fs%ix_mag_max, fs%an, fs%bn, magnetic$, include_kicks$)
  else
    call multipole_ele_to_ab(ele, .false., fs%ix_mag_max, fs%an, fs%bn, magnetic$, include_kicks$, fs%b1)
  endif
  call multipole_ele_to_ab(ele, .false., ix_elec_max, an, bn, electric$)
  fs%g = ele%value(g$)
  fs%dg = fs%bn(0) / ele%value(l$)
  fs%g_tot = (fs%g + fs%dg) * fs%charge_dir
  fs%n_step = 1
  if (fs%ix_mag_max > -1 .or. ix_elec_max > -1) fs%n_step = max(nint(abs(fs%length) / ele%value(ds_step$)), 1)
  fs%step_len = fs%length / fs%n_step
  fs%angle = fs%g * fs%step_len
  fs%beta_ref = ele%value(p0c$) / ele%value(E_tot$)
  fs%sinc_a = sinc(fs%angle)
  fs%cos_a = cos(fs%angle)
  fs%sin_a = sin(fs%angle)
  fs%cosc_a = cosc(fs%angle)
  fs%sincc_a = sincc(fs%angle)
  err_flag = .false.
  return
endif

!------------------------------------------
! Quadrupole / thick multipole

if (fs%kind == fast_quad$) then
  fs%charge_dir = rel_tracking_charge_to_mass(orb0, param%particle) * (ele%orientation * orb0%direction * orb0%time_dir)

  call multipole_ele_to_ab (ele, .false., fs%ix_mag_max, fs%an, fs%bn, magnetic$, include_kicks$, fs%b1)
  call multipole_ele_to_ab (ele, .false., ix_elec_max, an, bn, electric$)
  if (ix_elec_max > -1) return

  fs%n_step = 1
  if (fs%ix_mag_max > -1) fs%n_step = max(nint(abs(fs%length) / ele%value(ds_step$)), 1)
  fs%r_step = real(orb0%time_dir, rp) / fs%n_step
  fs%step_len = ele%value(l$) * fs%r_step
  if (fs%length == 0) fs%n_step = 0

else
  ! track_a_thick_multipole. Note the different n_step and step_len expressions from track_a_quadrupole.
  call multipole_ele_to_ab (ele, .false., fs%ix_mag_max, fs%an, fs%bn, magnetic$, include_kicks$)
  call multipole_ele_to_ab (ele, .false., ix_elec_max, an, bn, electric$)
  if (ix_elec_max > -1) return

  if (fs%ix_mag_max == -1) then
    fs%n_step = 1
  else
    fs%n_step = max(nint(abs(fs%length / ele%value(ds_step$))), 1)
  endif
  fs%r_step = real(orb0%time_dir, rp) / fs%n_step
  fs%step_len = fs%length / fs%n_step
endif

! Same expression as ab_multipole_kick: coord%direction * ele_orientation * charge_to_mass_of(coord%species) / charge_to_mass_of(ref_species)
fs%ab_f = orb0%direction * ele%orientation * charge_to_mass_of(param%particle) / charge_to_mass_of(ele%ref_species)

do n = 0, n_pole_maxx
  do m = 0, n
    fs%cm(n, m) = c_multi(n, m, .true.)
  enddo
enddo

! Misalignment. Mirrors offset_particle for set_hvkicks = F, set_tilt = T, s_pos absent,
! direction = time_dir = orientation = 1, non-bend key.

fs%offset_on = ele%bookkeeping_state%has_misalign
if (fs%offset_on) then
  fs%do_tilt = (has_orientation_attributes(ele) .and. ele%value(dispatch$) /= no_misalignment$)
  fs%tilt_tot = ele%value(tilt_tot$)
  fs%cos_t  = cos(fs%tilt_tot);   fs%sin_t  = sin(fs%tilt_tot)
  fs%cos_mt = cos(-fs%tilt_tot);  fs%sin_mt = sin(-fs%tilt_tot)

  fs%l_half = 0.5_rp * fs%length
  if (fs%do_tilt) then
    fs%x_off = ele%value(x_offset_tot$)
    fs%y_off = ele%value(y_offset_tot$)
    fs%z_off = ele%value(z_offset_tot$)
    xp       = ele%value(x_pitch_tot$)
    yp       = ele%value(y_pitch_tot$)
    fs%is_misaligned = (fs%x_off /= 0 .or. fs%y_off /= 0 .or. fs%z_off /= 0 .or. xp /= 0 .or. yp /= 0)
    call floor_angles_to_w_mat (xp, yp, 0.0_rp, w_mat_inv = fs%w_inv)
    call floor_angles_to_w_mat (xp, yp, 0.0_rp, w_mat = fs%w_mat)
  endif

  ! set: s_pos0 = 0, unset: s_pos0 = length.
  s_pos0 = 0
  ds_center_set = fs%l_half - s_pos0
  fs%zc_set = fs%z_off + ele%orientation * ds_center_set
  fs%s_target_set = (1 - (ele%orientation * orb0%direction) * orb0%time_dir) * fs%l_half

  s_pos0 = fs%length
  fs%ds_center_unset = fs%l_half - s_pos0
  fs%s_target_unset = (1 + orb0%direction * orb0%time_dir) * fs%l_half
endif

err_flag = .false.



!------------------------
contains

! As track1 / track1_radiation: kicks at both edges for elements that radiate, with the maps from
! radiation_map_setup (which only recomputes stale maps, as track1_bunch_hom relies on).

function radiation_setup() result (ok)
logical ok, rad_err
ok = .true.
fs%rad_damp = .false.;  fs%rad_fluct = .false.
if (.not. bmad_com%radiation_damping_on .and. .not. bmad_com%radiation_fluctuations_on) return
if (.not. ele%is_on .or. ele%value(l$) == 0) return
select case (ele%key)
case (drift$, pipe$, taylor$, multipole$, ab_multipole$, mask$, marker$, patch$, fixer$, fiducial$);  return
end select

call radiation_map_setup(ele, rad_err)
if (rad_err .or. .not. associated(ele%rad_map)) then
  ok = .false.   ! track1_radiation marks the particle lost; leave that to track1.
  return
endif

fs%rad_damp = bmad_com%radiation_damping_on
fs%rad_fluct = bmad_com%radiation_fluctuations_on
fs%rad_damp_vec = .not. bmad_com%radiation_zero_average
fs%rad_scale = bmad_com%synch_rad_scale
fs%rad_ref(:,1) = ele%rad_map%rm0%ref_orb;      fs%rad_ref(:,2) = ele%rad_map%rm1%ref_orb
fs%rad_dmat(:,:,1) = ele%rad_map%rm0%damp_dmat; fs%rad_dmat(:,:,2) = ele%rad_map%rm1%damp_dmat
fs%rad_dvec(:,1) = ele%rad_map%rm0%xfer_damp_vec; fs%rad_dvec(:,2) = ele%rad_map%rm1%xfer_damp_vec
fs%rad_smat(:,:,1) = ele%rad_map%rm0%stoc_mat;  fs%rad_smat(:,:,2) = ele%rad_map%rm1%stoc_mat
end function radiation_setup

end subroutine fast_slice_prepare

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_aperture_setup (ele, fs, why) result (is_ok)
!
! Routine to resolve the aperture checks check_aperture_limit makes at the two track edges of ele
! (particles moving forward) into fs%n_ap / fs%ap. lord_defined apertures (super_slaves and their
! slices) are resolved to the super_lords as check_aperture_limit does: all particles at an edge have
! the same s (ele%s_start at the first edge, ele%s at the second), so the lord selection is the same
! for every particle.
!
! Input:
!   ele     -- ele_struct: Element or slice.
!
! Output:
!   fs      -- fast_slice_struct: %n_ap and %ap set.
!   why     -- character(*), optional: Reason if an aperture is not supported.
!   is_ok   -- logical: True if all apertures are supported by the kernels.
!-

function fast_aperture_setup (ele, fs, why) result (is_ok)

type (ele_struct) ele
type (fast_slice_struct) fs
type (ele_struct), pointer :: lord
type (coord_struct) orb0

real(rp) s_edge
integer ie, i, particle_at, physical_end
logical is_ok
character(*), optional :: why

!

is_ok = .false.
fs%n_ap = 0
if (present(why)) why = ''

if (.not. bmad_com%aperture_limit_on) then
  is_ok = .true.
  return
endif

orb0%direction = 1
orb0%time_dir = 1

do ie = 1, 2
  if (ie == 1) then
    particle_at = first_track_edge$
    s_edge = ele%s_start
  else
    particle_at = second_track_edge$
    s_edge = ele%s
  endif

  if (ele%aperture_at == lord_defined$ .or. ele%aperture_type == lord_defined$) then
    do i = 1, ele%n_lord
      lord => pointer_to_lord(ele, i)
      if (lord%lord_status /= super_lord$) cycle

      if (s_edge == lord%s_start) then
        select case (lord%orientation)
        case (1);  physical_end = entrance_end$
        case (-1); physical_end = exit_end$
        end select
      else if (s_edge == lord%s) then
        select case (lord%orientation)
        case (1);  physical_end = exit_end$
        case (-1); physical_end = entrance_end$
        end select
      else
        physical_end = in_between$
      endif

      if (.not. lord_edge_aligned (ele, physical_end, lord) .and. &
          lord%aperture_at /= continuous$ .and. lord%aperture_at /= wall_transition$) cycle
      if (.not. add_aperture(lord)) return
    enddo

  else
    if (.not. add_aperture(ele)) return
  endif
enddo

is_ok = .true.

!------------------------
contains

! check_aperture_limit for ap_ele below its lord_defined branch.

function add_aperture (ap_ele) result (ok)

type (ele_struct) ap_ele
logical ok

ok = .false.

if (ap_ele%aperture_at == lord_defined$ .or. ap_ele%aperture_type == lord_defined$) then
  call set_why('lord_defined aperture in a lord');  return
endif
if (ap_ele%aperture_type == custom_aperture$) then
  call set_why('custom aperture');  return
endif
select case (ap_ele%aperture_at)
case (no_aperture$, entrance_end$, exit_end$, both_ends$, continuous$)
case default
  call set_why('aperture_at not supported');  return
end select

physical_end = physical_ele_end(particle_at, orb0, ap_ele%orientation)
if (.not. at_this_ele_end(physical_end, ap_ele%aperture_at)) then
  ok = .true.
  return
endif

select case (ap_ele%key)
case (ecollimator$, rcollimator$, crystal$, mirror$, multilayer_mirror$)
  call set_why('collimator or photon element aperture');  return
end select

if (ap_ele%offset_moves_aperture) then
  call set_why('offset_moves_aperture');  return
endif

select case (ap_ele%aperture_type)
case (rectangular$, auto_aperture$)
case (elliptical$)
  if ((ap_ele%value(x1_limit$) == 0 .neqv. ap_ele%value(x2_limit$) == 0) .or. &
      (ap_ele%value(y1_limit$) == 0 .neqv. ap_ele%value(y2_limit$) == 0)) then
    call set_why('ill-formed elliptical aperture (track1 prints an error)');  return
  endif
case default
  call set_why('aperture_type not supported');  return
end select

if (fs%n_ap(ie) == fast_max_ap) then
  call set_why('too many apertures at one edge');  return
endif

fs%n_ap(ie) = fs%n_ap(ie) + 1
associate (ap => fs%ap(fs%n_ap(ie), ie))
ap%ap_type = ap_ele%aperture_type
ap%x1_lim = -ap_ele%value(x1_limit$)
ap%x2_lim =  ap_ele%value(x2_limit$)
ap%y1_lim = -ap_ele%value(y1_limit$)
ap%y2_lim =  ap_ele%value(y2_limit$)
if (ap%ap_type == elliptical$) then
  call ellipse_setup(ap%x1_lim, ap%x2_lim, ap%ex_w2, ap%ex_c)
  call ellipse_setup(ap%y1_lim, ap%y2_lim, ap%ey_w2, ap%ey_c)
endif
end associate
ok = .true.

end function add_aperture

! Copy of check_aperture_limit's elliptical_params_setup (error case excluded above).

subroutine ellipse_setup (lim1, lim2, width2, center)
real(rp) lim1, lim2, width2, center
width2 = (lim2 - lim1) / 2
center = (lim2 + lim1) / 2
if (width2 == 0) width2 = bmad_com%max_aperture_limit
width2 = max(width2, 0.0_rp)
end subroutine ellipse_setup

subroutine set_why(str)
character(*) str
if (present(why)) why = str
end subroutine set_why

end function fast_aperture_setup

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_bunch_compatible (bunch, ele, fs, why) result (is_ok)
!
! Bunch dependent eligibility checks. All live particles must:
!   have direction = +1 and time_dir = +1,
!   be of species fs%species (= param%particle), not photons,
!   have p0c consistent with the element (else track1 prints an error and skips the particle).
!
! Input:
!   bunch   -- bunch_struct: Bunch to track.
!   ele     -- ele_struct: Element.
!   fs      -- fast_slice_struct: Prepared slice.
!
! Output:
!   is_ok   -- logical: True if the bunch can be tracked with the fast kernels.
!   why     -- character(*), optional: Reason if not.
!-

function fast_bunch_compatible (bunch, ele, fs, why) result (is_ok)

type (bunch_struct) bunch
type (ele_struct) ele
type (fast_slice_struct) fs

integer i, n_bad
logical is_ok
character(*), optional :: why

!

is_ok = .false.
if (present(why)) why = ''
n_bad = 0

!$OMP parallel do reduction(+:n_bad)
do i = 1, size(bunch%particle)
  associate (p => bunch%particle(i))
  if (p%state /= alive$) cycle
  if (p%direction /= 1 .or. p%time_dir /= 1 .or. p%species /= fs%species .or. p%species == photon$) then
    n_bad = n_bad + 1
  elseif (significant_difference(ele%value(p0c_start$), p%p0c, rel_tol = small_rel_change$)) then
    n_bad = n_bad + 1
  endif
  end associate
enddo
!$OMP end parallel do

if (n_bad > 0) then
  if (present(why)) why = 'particles with direction/time_dir/species/p0c not supported'
  return
endif

is_ok = .true.

end function fast_bunch_compatible

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_soa_compatible (soa, ele, fs, why) result (is_ok)
!
! Same checks as fast_bunch_compatible but on a SoA bunch (cheaper: contiguous arrays, and the
! p0c test is only evaluated when p0c changes from one particle to the next in a thread's block).
!
! Input:
!   soa     -- bunch_soa_struct: Bunch to track.
!   ele     -- ele_struct: Element.
!   fs      -- fast_slice_struct: Prepared slice.
!
! Output:
!   is_ok   -- logical: True if the bunch can be tracked with the fast kernels.
!   why     -- character(*), optional: Reason if not.
!-

function fast_soa_compatible (soa, ele, fs, why) result (is_ok)

type (bunch_soa_struct) soa
type (ele_struct) ele
type (fast_slice_struct) fs

real(rp) p0c_ok
integer i, n_bad
logical is_ok, have_p0c
character(*), optional :: why

!

is_ok = .false.
if (present(why)) why = ''
n_bad = 0
have_p0c = .false.
p0c_ok = 0

!$OMP parallel do reduction(+:n_bad) firstprivate(have_p0c, p0c_ok) if (soa%n > 10000)
do i = 1, soa%n
  if (soa%state(i) /= alive$) cycle
  if (soa%direction(i) /= 1 .or. soa%time_dir(i) /= 1 .or. soa%species(i) /= fs%species .or. soa%species(i) == photon$) then
    n_bad = n_bad + 1
  elseif (.not. have_p0c .or. soa%p0c(i) /= p0c_ok) then
    if (significant_difference(ele%value(p0c_start$), soa%p0c(i), rel_tol = small_rel_change$)) then
      n_bad = n_bad + 1
    else
      have_p0c = .true.
      p0c_ok = soa%p0c(i)
    endif
  endif
enddo
!$OMP end parallel do

if (n_bad > 0) then
  if (present(why)) why = 'particles with direction/time_dir/species/p0c not supported'
  return
endif

is_ok = .true.

end function fast_soa_compatible

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine bunch_to_soa (bunch, soa, with_spin)
!
! Routine to load a SoA bunch from bunch%particle(:).
! Coord_struct components not used by the kernels (field, phase, dt_ref, r, E_potential, ix_turn, ix_user)
! are not copied. soa_to_bunch leaves them untouched in bunch%particle.
!
! Input:
!   bunch     -- bunch_struct: Bunch.
!   with_spin -- logical, optional: Copy spin? Default is False.
!
! Output:
!   soa       -- bunch_soa_struct: SoA bunch. Reallocated as needed. dt_hi/dt_lo are zeroed.
!-

subroutine bunch_to_soa (bunch, soa, with_spin)

type (bunch_struct), target :: bunch
type (bunch_soa_struct) soa

integer i, n
logical, optional :: with_spin

!

n = size(bunch%particle)
call soa_allocate (soa, n, logic_option(.false., with_spin))

!$OMP parallel do
do i = 1, n
  associate (p => bunch%particle(i))
  soa%x(i)  = p%vec(1);  soa%px(i) = p%vec(2)
  soa%y(i)  = p%vec(3);  soa%py(i) = p%vec(4)
  soa%z(i)  = p%vec(5);  soa%pz(i) = p%vec(6)
  soa%s(i)  = p%s
  soa%t(i)  = p%t
  soa%dt_hi(i) = 0;  soa%dt_lo(i) = 0
  soa%charge(i)    = p%charge
  soa%p0c(i)       = p%p0c
  soa%beta(i)      = p%beta
  soa%state(i)     = p%state
  soa%species(i)   = p%species
  soa%location(i)  = p%location
  soa%ix_ele(i)    = p%ix_ele
  soa%ix_branch(i) = p%ix_branch
  soa%direction(i) = p%direction
  soa%time_dir(i)  = p%time_dir
  if (soa%has_spin) soa%spin(:, i) = p%spin
  end associate
enddo
!$OMP end parallel do

end subroutine bunch_to_soa

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine soa_to_bunch (soa, bunch)
!
! Routine to store a SoA bunch back into bunch%particle(:). Time deltas accumulated in
! double-double (fast_time_dd$ mode) are folded into %t first.
! Only components that the kernels may change are written.
!
! Input:
!   soa       -- bunch_soa_struct: SoA bunch.
!
! Output:
!   bunch     -- bunch_struct: bunch%particle(:) updated.
!   soa       -- bunch_soa_struct: dt_hi/dt_lo zeroed, t updated.
!-

subroutine soa_to_bunch (soa, bunch)

type (bunch_soa_struct) soa
type (bunch_struct), target :: bunch

integer i

character(*), parameter :: r_name = 'soa_to_bunch'

!

if (size(bunch%particle) /= soa%n) then
  call out_io (s_fatal$, r_name, 'SIZE MISMATCH BETWEEN SOA AND BUNCH!')
  if (global_com%exit_on_error) call err_exit
  return
endif

call soa_flush_time (soa)

!$OMP parallel do
do i = 1, soa%n
  associate (p => bunch%particle(i))
  p%vec = [soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%z(i), soa%pz(i)]
  p%s         = soa%s(i)
  p%t         = soa%t(i)
  p%p0c       = soa%p0c(i)
  p%beta      = soa%beta(i)
  p%state     = soa%state(i)
  p%location  = soa%location(i)
  p%ix_ele    = soa%ix_ele(i)
  p%ix_branch = soa%ix_branch(i)
  if (soa%has_spin) p%spin = soa%spin(:, i)
  end associate
enddo
!$OMP end parallel do

end subroutine soa_to_bunch

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine soa_flush_time (soa)
!
! Routine to fold the double-double time accumulator into soa%t (quad precision).
! The (hi, lo) pair is renormalized so hi + lo is exact in quad precision; only the final
! addition to %t rounds.
!
! Input:
!   soa   -- bunch_soa_struct.
!
! Output:
!   soa   -- bunch_soa_struct: %t updated, %dt_hi and %dt_lo zeroed.
!-

subroutine soa_flush_time (soa)

type (bunch_soa_struct) soa
integer i

!$OMP parallel do
do i = 1, soa%n
  if (soa%dt_hi(i) == 0 .and. soa%dt_lo(i) == 0) cycle
  soa%t(i) = soa%t(i) + (real(soa%dt_hi(i), qp) + real(soa%dt_lo(i), qp))
  soa%dt_hi(i) = 0
  soa%dt_lo(i) = 0
enddo
!$OMP end parallel do

end subroutine soa_flush_time

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine soa_allocate (soa, n, with_spin)
!
! Routine to (re)allocate the arrays of a SoA bunch.
!
! Input:
!   n         -- integer: Number of particles.
!   with_spin -- logical: Allocate spin array?
!
! Output:
!   soa       -- bunch_soa_struct: Allocated.
!-

subroutine soa_allocate (soa, n, with_spin)

type (bunch_soa_struct) soa
integer n
logical with_spin

!

if (allocated(soa%x)) then
  if (size(soa%x) /= n) call soa_deallocate(soa)
endif

if (.not. allocated(soa%x)) then
  allocate (soa%x(n), soa%px(n), soa%y(n), soa%py(n), soa%z(n), soa%pz(n), soa%s(n), soa%t(n), &
            soa%dt_hi(n), soa%dt_lo(n), soa%charge(n), soa%p0c(n), soa%beta(n), soa%state(n), &
            soa%species(n), soa%location(n), soa%ix_ele(n), soa%ix_branch(n), soa%direction(n), soa%time_dir(n))
endif

soa%n = n
soa%has_spin = with_spin
if (with_spin) then
  if (allocated(soa%spin)) then
    if (size(soa%spin, 2) /= n) deallocate(soa%spin)
  endif
  if (.not. allocated(soa%spin)) allocate (soa%spin(3, n))
elseif (allocated(soa%spin)) then
  deallocate(soa%spin)
endif

end subroutine soa_allocate

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine soa_deallocate (soa)
!
! Routine to deallocate the arrays of a SoA bunch.
!
! Input:
!   soa   -- bunch_soa_struct.
!
! Output:
!   soa   -- bunch_soa_struct: Deallocated. %n = 0.
!-

subroutine soa_deallocate (soa)

type (bunch_soa_struct) soa

if (allocated(soa%x)) deallocate (soa%x, soa%px, soa%y, soa%py, soa%z, soa%pz, soa%s, soa%t, &
            soa%dt_hi, soa%dt_lo, soa%charge, soa%p0c, soa%beta, soa%state, &
            soa%species, soa%location, soa%ix_ele, soa%ix_branch, soa%direction, soa%time_dir)
if (allocated(soa%spin)) deallocate (soa%spin)
soa%n = 0
soa%has_spin = .false.

end subroutine soa_deallocate

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine fast_track1_bunch (bunch, ele, param, tracked, why)
!
! Drop-in replacement for the "no wake" particle loop of track1_bunch_hom:
!   do j = 1, size(bunch%particle)
!     if (bunch%particle(j)%state /= alive$) cycle
!     call track1 (bunch%particle(j), ele, param, bunch%particle(j))
!   enddo
! If ele or bunch is not supported nothing is done and tracked = False so the caller must fall back.
! bunch%charge_live is not updated (track1_bunch_hom does that after the loop).
!
! Input:
!   bunch     -- bunch_struct: Starting bunch.
!   ele       -- ele_struct: Element or slice.
!   param     -- lat_param_struct: Branch parameters.
!
! Output:
!   bunch     -- bunch_struct: Ending bunch if tracked = True.
!   tracked   -- logical: True if the fast kernels were used.
!   why       -- character(*), optional: Reason if not tracked.
!-

subroutine fast_track1_bunch (bunch, ele, param, tracked, why)

type (bunch_struct) bunch
type (ele_struct) ele
type (lat_param_struct) param
type (fast_slice_struct) fs
type (bunch_soa_struct), save :: soa

logical tracked
character(*), optional :: why
character(100) reason

!

tracked = .false.
if (.not. fast_slice_setup(ele, param, fs, why)) return
if (fs%kind == fast_drift$ .and. .not. fast_track_drifts) then
  call fast_note_why (ele, 'drift-like slices disabled (fast_track_drifts)', why)
  return
endif
call bunch_to_soa (bunch, soa)
if (.not. fast_soa_compatible(soa, ele, fs, reason)) then
  call fast_note_why (ele, reason, why)
  return
endif
call fast_track_soa (soa, fs)
call soa_to_bunch (soa, bunch)
tracked = .true.

end subroutine fast_track1_bunch

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine fast_track1_soa (soa, ele, param, tracked, why, p0c_checked)
!
! Routine to track a SoA bunch through an element or slice with the fast kernels, if they support it.
! Same as fast_track1_bunch but without the bunch <-> SoA conversion, so a SoA bunch can be kept
! across many slices. Drift-like slices are always tracked (fast_track_drifts is not used).
! If ele or the bunch is not supported nothing is done and tracked = False so the caller must fall back.
!
! The kernels do not change what fast_soa_compatible checks (direction, time_dir, species, p0c), so a
! caller tracking the same SoA bunch through many slices can pass p0c_checked to skip the check when
! the slice has the p0c_start that last passed. Set p0c_checked to a negative value whenever soa is
! changed by anything but the kernels.
!
! Input:
!   soa         -- bunch_soa_struct: Starting bunch.
!   ele         -- ele_struct: Element or slice.
!   param       -- lat_param_struct: Branch parameters.
!   p0c_checked -- real(rp), optional: ele%value(p0c_start$) of the last slice that passed the check.
!
! Output:
!   soa         -- bunch_soa_struct: Ending bunch if tracked = True.
!   tracked     -- logical: True if the fast kernels were used.
!   why         -- character(*), optional: Reason if not tracked.
!   p0c_checked -- real(rp), optional: Updated.
!-

subroutine fast_track1_soa (soa, ele, param, tracked, why, p0c_checked)

type (bunch_soa_struct) soa
type (ele_struct) ele
type (lat_param_struct) param
type (fast_slice_struct) fs

real(rp), optional :: p0c_checked
logical tracked, skip_check
character(*), optional :: why
character(100) reason

!

tracked = .false.
if (.not. fast_slice_setup(ele, param, fs, why)) return
skip_check = .false.
if (present(p0c_checked)) skip_check = (p0c_checked >= 0 .and. p0c_checked == ele%value(p0c_start$))
if (.not. skip_check) then
  if (.not. fast_soa_compatible(soa, ele, fs, reason)) then
    call fast_note_why (ele, reason, why)
    return
  endif
  if (present(p0c_checked)) p0c_checked = ele%value(p0c_start$)
endif
call fast_track_soa (soa, fs)
tracked = .true.

end subroutine fast_track1_soa

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_slice_setup (ele, param, fs, why) result (is_ok)
!
! Routine to check element eligibility and prepare the slice data for the fast kernels.
!
! Input:
!   ele       -- ele_struct: Element or slice.
!   param     -- lat_param_struct: Branch parameters.
!
! Output:
!   fs        -- fast_slice_struct: Prepared slice if is_ok = True.
!   why       -- character(*), optional: Reason if not.
!   is_ok     -- logical: True if ele can be tracked with the fast kernels.
!-

function fast_slice_setup (ele, param, fs, why) result (is_ok)

type (ele_struct) ele
type (lat_param_struct) param
type (fast_slice_struct) fs

logical is_ok, err
character(*), optional :: why
character(100) reason

!

is_ok = .false.
reason = ''
if (.not. fast_track_eligible(ele, param, reason)) then
  call fast_note_why (ele, reason, why)
  return
endif
call fast_slice_prepare (ele, param, fs, err)
if (err) then
  call fast_note_why (ele, 'fast_slice_prepare failed', why)
  return
endif
is_ok = .true.

end function fast_slice_setup

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine fast_note_why (ele, str, why)
!
! Routine to record why the fast kernels were not used. With BMAD_FAST_TRACK=verbose, each
! distinct reason is printed once.
!
! Input:
!   ele   -- ele_struct: Element not tracked with the kernels.
!   str   -- character(*): Reason.
!
! Output:
!   why   -- character(*), optional: Set to str.
!-

subroutine fast_note_why (ele, str, why)

type (ele_struct) ele
character(*) str
character(*), optional :: why
integer i

!

if (present(why)) why = str
if (.not. fast_track_verbose) return
!$OMP CRITICAL (fast_track_why_lock)
do i = 1, n_why_seen
  if (why_seen(i) == str) exit
enddo
if (i > n_why_seen .and. n_why_seen < n_why_max) then
  n_why_seen = n_why_seen + 1
  why_seen(n_why_seen) = str
  call out_io (s_info$, 'fast_track1_bunch', 'Not using fast kernels for ' // trim(key_name(ele%key)) // &
                                             ' (e.g. ' // trim(ele%name) // '): ' // trim(str))
endif
!$OMP END CRITICAL (fast_track_why_lock)

end subroutine fast_note_why

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_track_enabled () result (is_on)
!
! Routine to tell if the SoA kernels should be used. Off unless the environment variable
! BMAD_FAST_TRACK is set to something other than "" or "0". Read once.
!
! Output:
!   is_on   -- logical: True if enabled.
!-

function fast_track_enabled () result (is_on)

logical is_on
character(16) val
integer stat

!

if (.not. fast_track_env_checked) then
  !$OMP CRITICAL (fast_track_env_lock)
  if (.not. fast_track_env_checked) then
    call get_environment_variable ('BMAD_FAST_TRACK', val, status = stat)
    fast_track_on = (stat == 0 .and. val /= '' .and. val /= '0')
    fast_track_verbose = (fast_track_on .and. val == 'verbose')
    fast_track_env_checked = .true.
  endif
  !$OMP END CRITICAL (fast_track_env_lock)
endif
is_on = fast_track_on

end function fast_track_enabled

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine fast_track_soa (soa, fs)
!
! Routine to track a SoA bunch through a prepared slice. Equivalent to calling track1 for every
! particle with state = alive$. Particles that are not alive are untouched.
! OpenMP parallel over blocks of fast_block_size particles.
!
! Input:
!   soa   -- bunch_soa_struct: Starting bunch.
!   fs    -- fast_slice_struct: Prepared slice (from fast_slice_prepare).
!
! Output:
!   soa   -- bunch_soa_struct: Ending bunch.
!-

subroutine fast_track_soa (soa, fs)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

integer ib, i0, i1, n_block

!

n_block = (soa%n + fast_block_size - 1) / fast_block_size

!$OMP parallel do private(i0, i1) schedule(static)
do ib = 1, n_block
  i0 = (ib - 1) * fast_block_size + 1
  i1 = min(ib * fast_block_size, soa%n)
  select case (fs%kind)
  case (fast_drift$)
    call track_block_drift (soa, fs, i0, i1)
  case (fast_quad$)
    call track_block_quad (soa, fs, i0, i1)
  case (fast_thick$)
    call track_block_thick (soa, fs, i0, i1)
  case (fast_bend$)
    call track_block_bend (soa, fs, i0, i1)
  end select
enddo
!$OMP end parallel do

end subroutine fast_track_soa

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
! Kernel internals.
!
! Phase structure (per block) mirrors track1:
!   entrance_block   -- track1 lines up to the tracking_method select (s/location/ix_ele set,
!                       check_aperture_limit(first_track_edge$)).
!   body             -- track1_bmad branch.
!   exit_block       -- orbit_too_large, location, check_aperture_limit(second_track_edge$).
! go(i) = particle reached the body (track1_bmad was called).
!--------------------------------------------------------------------------

subroutine entrance_block (soa, fs, i0, i1, go)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
integer i0, i1, i
logical go(i0:i1), too_large

do i = i0, i1
  go(i) = .false.
  if (soa%state(i) /= alive$) cycle
  soa%location(i)  = upstream_end$
  soa%s(i)         = fs%s_start
  soa%ix_ele(i)    = fs%ix_ele
  soa%ix_branch(i) = fs%ix_branch
  call orbit_too_large_lane (soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%pz(i), fs%max_ap, soa%state(i), too_large)
  if (.not. too_large) call apertures_lane (soa%x(i), soa%y(i), fs, 1, soa%state(i))
  ! track1 applies the entrance radiation kick before checking the state.
  if (fs%rad_damp .or. fs%rad_fluct) call radiation_lane (soa, fs, i, 1)
  go(i) = (soa%state(i) == alive$)
enddo

end subroutine entrance_block

!--------------------------------------------------------------------------

subroutine exit_block (soa, fs, i0, i1, go)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
integer i0, i1, i
logical go(i0:i1), too_large

do i = i0, i1
  if (.not. go(i)) cycle
  soa%s(i) = fs%s_end                 ! track1_bmad sets orbit%s = ele%s

  call orbit_too_large_lane (soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%pz(i), fs%max_ap, soa%state(i), too_large)
  if (too_large) cycle                ! track1 returns without updating %location.

  if (soa%state(i) /= alive$) then
    soa%location(i) = inside$
    cycle
  endif
  soa%location(i) = downstream_end$

  ! check_aperture_limit(second_track_edge$) starts with orbit_too_large, which already passed unless
  ! the radiation kick changed the orbit.
  if (fs%rad_damp .or. fs%rad_fluct) then
    call radiation_lane (soa, fs, i, 2)
    call orbit_too_large_lane (soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%pz(i), fs%max_ap, soa%state(i), too_large)
    if (too_large) cycle
  endif
  call apertures_lane (soa%x(i), soa%y(i), fs, 2, soa%state(i))
enddo

end subroutine exit_block

!--------------------------------------------------------------------------
! track1_radiation for edge ie (1 = start_edge$, 2 = end_edge$), with time_dir = 1.
! matmul is written out with the same summation order as gfortran's inline matmul.

subroutine radiation_lane (soa, fs, i, ie)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
integer i, ie, j, k
real(rp) v(6), w(6), dv(6), ran6(6), rr

v = [soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%z(i), soa%pz(i)]

if (fs%rad_damp) then
  rr = fs%rad_scale
  w = v - fs%rad_ref(:,ie)
  do j = 1, 6
    dv(j) = 0
    do k = 1, 6
      dv(j) = dv(j) + fs%rad_dmat(j,k,ie) * w(k)
    enddo
  enddo
  v = v + rr * dv
  if (fs%rad_damp_vec) v = v + rr * fs%rad_dvec(:,ie)
endif

if (fs%rad_fluct) then
  call ran_gauss (ran6)
  do j = 1, 6
    dv(j) = 0
    do k = 1, 6
      dv(j) = dv(j) + fs%rad_smat(j,k,ie) * ran6(k)
    enddo
  enddo
  v = v + fs%rad_scale * dv
endif

soa%x(i) = v(1);  soa%px(i) = v(2);  soa%y(i) = v(3);  soa%py(i) = v(4);  soa%z(i) = v(5);  soa%pz(i) = v(6)

if (v(6) < -1.0_rp) then
  call out_io (s_warn$, 'track1_radiation', 'Particle is kaput due to radiation loss!')
  soa%state(i) = lost_pz$
endif

end subroutine radiation_lane

!--------------------------------------------------------------------------
! track1_bmad sbend$ branch: track_a_bend for the cases bend_supported accepts. The entrance and exit
! edge kicks do nothing (no fringe at this slice), there is no offset_particle, and the multipole
! kicks are absent or have all-zero fields (so they do not change the orbit).

subroutine track_block_bend (soa, fs, i0, i1)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) z0
integer i0, i1, i, n
logical go(i0:i1), lost, too_large

!

call entrance_block (soa, fs, i0, i1, go)

do i = i0, i1
  if (.not. go(i)) cycle
  z0 = soa%z(i)
  ! track_a_bend's orbit_too_large check after the entrance edge kick passes: the orbit has not
  ! changed since track1's check.
  lost = .false.
  do n = 1, fs%n_step
    call bend_body_lane (soa, fs, i, lost)
    if (lost) exit
  enddo
  if (lost) cycle
  call orbit_too_large_lane (soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%pz(i), fs%max_ap, soa%state(i), too_large)
  if (too_large) cycle
  call add_time2 (soa, i, fs%delta_ref_time, (z0 - soa%z(i)) / (soa%beta(i) * c_light))
enddo

call exit_block (soa, fs, i0, i1, go)

end subroutine track_block_bend

!--------------------------------------------------------------------------
! One step of the track_a_bend body (b1 = 0, g or dg nonzero). lost = True if track_a_bend returns
! from inside the body (the particle state is set).

subroutine bend_body_lane (soa, fs, i, lost)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
integer i
logical lost

real(rp) x, px, y, py, z, pz, rel_p, rel_p2, ll, gam2, m56, g, angle, step_len
real(rp) pt, g_p, phi_1, cos_plus, sin_plus, alpha, r, rad, denom, xi, L_u, L_v, L_c, angle_p, L_p

g = fs%g;  angle = fs%angle;  step_len = fs%step_len
x  = soa%x(i);  px = soa%px(i);  y = soa%y(i);  py = soa%py(i);  z = soa%z(i);  pz = soa%pz(i)
rel_p  = 1 + pz
rel_p2 = rel_p**2

! Use semi-linear map if near zero orbit.

if (fs%dg == 0 .and. abs(x * g) < 1d-9 .and. abs(px) < 1d-9 .and. abs(py) < 1d-9 .and. abs(pz) < 1d-9) then
  ll = step_len
  gam2 = fs%mass**2 / ((rel_p * soa%p0c(i))**2 + fs%mass**2)  ! 1/gamma^2
  m56 = ll * (gam2 - (g*ll)**2 * fs%sincc_a)
  soa%x(i) = fs%cos_a * x      + ll * fs%sinc_a * px + g * ll**2 * fs%cosc_a * pz
  soa%px(i) = -g * fs%sin_a * x + fs%cos_a * px       + g * ll * fs%sinc_a * pz
  soa%y(i) = y + ll * py
  soa%z(i) = -g * ll * fs%sinc_a * x - g * ll**2 * fs%cosc_a * px + z + m56 * pz
  return
endif

! General case

pt = sqrt(rel_p2 - py**2)
if (abs(px) > pt) then
  soa%state(i) = lost_pz$
  lost = .true.
  return
endif

g_p = fs%g_tot / pt
phi_1  = asin(px / pt)
cos_plus = cos(angle + phi_1)
sin_plus = sin(angle + phi_1)
alpha = 2 * (1 + g*x) * sin_plus * step_len * fs%sinc_a - g_p * ((1 + g*x) * step_len * fs%sinc_a)**2
r = cos_plus**2 + g_p*alpha
if (r < 0 .or. (abs(g_p) < 1d-5 .and. abs(cos_plus) < 1d-5)) then  ! Particle does not intersect exit face.
  soa%state(i) = lost$
  soa%x(i) = 2 * fs%max_ap
  lost = .true.
  return
endif

rad = sqrt(r)
if (cos_plus > 0) then
  denom = rad + cos_plus
  xi = alpha / denom
else
  denom = rad - cos_plus
  xi = denom / g_p
endif

soa%x(i) = x * fs%cos_a - step_len**2 * g * fs%cosc_a + xi
if (abs(soa%x(i)) > fs%max_ap) then
  soa%state(i) = lost$
  lost = .true.
  return
endif

L_u = xi
L_v = -(step_len * fs%sinc_a + x * fs%sin_a)
L_c = sqrt(L_v**2 + L_u**2)
angle_p = 2 * (angle + phi_1 - atan2(L_u, -L_v))
L_p = L_c / sinc(angle_p/2)

soa%px(i) = pt * sin(phi_1 + angle - angle_p)
soa%y(i) = y + py * L_p / pt
soa%z(i) = z + soa%beta(i) * step_len / fs%beta_ref - rel_p * L_p / pt 

end subroutine bend_body_lane

!--------------------------------------------------------------------------
! track1_bmad drift$ branch: track_a_drift (orbit, ele%value(l$)*orbit%time_dir)
! with orbit%direction = 1, ele_orientation absent (rel_z_vel = 1), include_ref_motion = True.

subroutine track_block_drift (soa, fs, i0, i1)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

integer i0, i1, i
logical go(i0:i1)

!

call entrance_block (soa, fs, i0, i1, go)

do i = i0, i1
  if (go(i)) call drift_lane (soa, fs, i, fs%length, .true.)
enddo

call exit_block (soa, fs, i0, i1, go)

end subroutine track_block_drift

!--------------------------------------------------------------------------
! track_a_drift (orbit, length) with include_ref_motion = True, ele_orientation absent.
! do_time = False omits the orbit%t update (used where the caller overwrites orbit%t afterwards).
! orb%s is not updated: track1_bmad overwrites it.

subroutine drift_lane (soa, fs, i, length, do_time)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) length, delta, rel_pc, px_rel, py_rel, pxy2, ps_rel, dz, dt, mc2
integer i, rel_z_vel
logical do_time

!

if (length == 0) return
mc2 = fs%mass
rel_z_vel = 1
delta = soa%pz(i)
rel_pc = 1 + delta
px_rel = rel_z_vel * soa%px(i) / rel_pc
py_rel = rel_z_vel * soa%py(i) / rel_pc
pxy2 = px_rel**2 + py_rel**2
if (pxy2 >= 1) then
  soa%state(i) = lost_pz$
  return
endif
ps_rel = sqrt(1 - pxy2)

soa%x(i) = soa%x(i) + length * px_rel / ps_rel
soa%y(i) = soa%y(i) + length * py_rel / ps_rel

if (soa%beta(i) > 0) then
  dz = length * (sqrt_one((mc2**2 * (2*delta+delta**2))/((soa%p0c(i)*rel_pc)**2 + mc2**2)) + sqrt_one(-pxy2)/ps_rel)
  if (do_time) then
    dt = rel_z_vel * length / (soa%beta(i) * ps_rel * c_light)
    call add_time (soa, i, dt)
  endif
else
  dz = length * (1 - 1/ps_rel)
endif

soa%z(i) = soa%z(i) + rel_z_vel * dz

end subroutine drift_lane

!--------------------------------------------------------------------------
! track1_bmad thick multipole branch: track_a_thick_multipole with direction = time_dir = orientation = 1,
! no fringe, no electric multipoles, not an elseparator, ac_amp = 1 (not an ac_kicker), make_matrix = False.
! As in Bmad there is no state check in the step loop: a particle marked lost_pz$ by a drift step still
! receives the remaining kicks.

subroutine track_block_thick (soa, fs, i0, i1)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) z0(i0:i1), step_scale
integer i0, i1, i, istep
logical go(i0:i1)

!

call entrance_block (soa, fs, i0, i1, go)

do i = i0, i1
  if (go(i)) z0(i) = soa%z(i)
enddo

if (fs%offset_on) then
  do i = i0, i1
    if (go(i)) call offset_set_lane (soa, fs, i)
  enddo
endif

if (fs%ix_mag_max > -1) then
  do i = i0, i1
    if (go(i)) call ab_kick_lane (soa, fs, i, fs%r_step/2)
  enddo
endif

do istep = 1, fs%n_step
  if (istep == fs%n_step) then
    step_scale = fs%r_step/2
  else
    step_scale = fs%r_step
  endif

  do i = i0, i1
    if (.not. go(i)) cycle
    call drift_lane (soa, fs, i, fs%step_len, .false.)
    if (fs%ix_mag_max > -1) call ab_kick_lane (soa, fs, i, step_scale)
  enddo
enddo

if (fs%offset_on) then
  do i = i0, i1
    if (go(i)) call offset_unset_lane (soa, fs, i)
  enddo
endif

do i = i0, i1
  if (.not. go(i)) cycle
  call add_time2 (soa, i, fs%delta_ref_time, (z0(i) - soa%z(i)) / (soa%beta(i) * c_light))
enddo

call exit_block (soa, fs, i0, i1, go)

end subroutine track_block_thick

!--------------------------------------------------------------------------
! track1_bmad quadrupole$ branch: track_a_quadrupole with direction = time_dir = orientation = 1,
! no fringe, no electric multipoles, make_matrix = False.

subroutine track_block_quad (soa, fs, i0, i1)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) z0(i0:i1), rel_p, k1, zx(3), zy(3), mx(4), my(4), x, px, y, py
real(rp) dz_low_e
integer i0, i1, i, istep
logical go(i0:i1)

!

call entrance_block (soa, fs, i0, i1, go)

do i = i0, i1
  if (go(i)) z0(i) = soa%z(i)
enddo

! Entrance offset. offset_particle(ele, set$, orbit, set_hvkicks = .false.)

if (fs%offset_on) then
  do i = i0, i1
    if (.not. go(i)) cycle
    call offset_set_lane (soa, fs, i)
  enddo
endif

! Entrance half kick.

if (fs%ix_mag_max > -1) then
  do i = i0, i1
    if (go(i)) call ab_kick_lane (soa, fs, i, fs%r_step/2)
  enddo
endif

! Body. Without electric fields pz (hence rel_p, k1, the 2x2 maps, z coefficients and the low energy
! z correction) is constant through the body, so these are computed once per particle instead of once
! per step. Bmad recomputes them each step from the same inputs, so results are identical.

do i = i0, i1
  if (.not. go(i)) cycle

  rel_p = 1 + soa%pz(i)
  k1 = fs%charge_dir * fs%b1 / (fs%length * rel_p)
  call quad_z_coef (-k1, fs%step_len, rel_p, mx(1), mx(2), mx(3), mx(4), zx)
  call quad_z_coef ( k1, fs%step_len, rel_p, my(1), my(2), my(3), my(4), zy)
  dz_low_e = low_e_dz (soa%pz(i), soa%p0c(i), soa%beta(i), fs%mass, fs%e_tot_ele, fs%step_len)

  do istep = 1, fs%n_step
    x = soa%x(i);  px = soa%px(i);  y = soa%y(i);  py = soa%py(i)

    soa%z(i) = soa%z(i) + &
               (zx(1) * x**2 + zx(2) * x * px + zx(3) * px**2 + &
                zy(1) * y**2 + zy(2) * y * py + zy(3) * py**2)

    ! matmul(kmat(1:2,1:2), vec(1:2)). FMA contraction may differ from Bmad unless -ffp-contract=off.
    soa%x(i)  = mx(1) * x + mx(2) * px
    soa%px(i) = mx(3) * x + mx(4) * px
    soa%y(i)  = my(1) * y + my(2) * py
    soa%py(i) = my(3) * y + my(4) * py

    soa%z(i) = soa%z(i) + dz_low_e

    if (fs%ix_mag_max > -1) then
      if (istep == fs%n_step) then
        call ab_kick_lane (soa, fs, i, fs%r_step/2)
      else
        call ab_kick_lane (soa, fs, i, fs%r_step)
      endif
    endif
  enddo
enddo

! Exit offset.

if (fs%offset_on) then
  do i = i0, i1
    if (.not. go(i)) cycle
    call offset_unset_lane (soa, fs, i)
  enddo
endif

! orbit%t = start_orb%t + orbit%direction*orbit%time_dir*ele%value(delta_ref_time$) + (start_orb%vec(5) - orbit%vec(5)) / (orbit%beta * c_light)
! Any time change from offset drifts is discarded by this assignment, so the kernel never adds it.

do i = i0, i1
  if (.not. go(i)) cycle
  call add_time2 (soa, i, fs%delta_ref_time, (z0(i) - soa%z(i)) / (soa%beta(i) * c_light))
enddo

call exit_block (soa, fs, i0, i1, go)

end subroutine track_block_quad

!--------------------------------------------------------------------------
! offset_particle, set$, non-bend, orientation = direction = time_dir = 1, set_hvkicks = False.

subroutine offset_set_lane (soa, fs, i)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) rel_p, r(3), r2(3), pz, p0(3), p(3), s_body, ds
integer i

!

rel_p = 1 + soa%pz(i)

if (fs%is_misaligned) then
  r = [soa%x(i), soa%y(i), 0.0_rp] - [fs%x_off, fs%y_off, fs%zc_set]
  call mat3_vec (fs%w_inv, r, r2)
  r2(3) = r2(3) + fs%l_half
  s_body = r2(3)

  pz = rel_p**2 - soa%px(i)**2 - soa%py(i)**2
  if (pz <= 0) then
    soa%state(i) = lost_pz$
  else
    p0 = [soa%px(i), soa%py(i), sqrt(pz)]     ! sign_z_vel = 1
    call mat3_vec (fs%w_inv, p0, p)         ! position%w = matmul(w_inv, unit) = w_inv exactly.
    soa%px(i) = p(1);  soa%py(i) = p(2)
    soa%x(i)  = r2(1); soa%y(i)  = r2(2)
  endif
else
  s_body = 0                                 ! s_pos0 for orientation = 1
endif

ds = fs%s_target_set - s_body
if (abs(ds) > 1d-14 .and. soa%state(i) == alive$) call offset_drift_lane (soa, i, ds)

if (fs%do_tilt .and. fs%tilt_tot /= 0) call tilt_lane (soa, i, fs%cos_t, fs%sin_t)

end subroutine offset_set_lane

!--------------------------------------------------------------------------
! offset_particle, unset$, mirror of offset_set_lane.

subroutine offset_unset_lane (soa, fs, i)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) rel_p, r(3), r2(3), pz, p0(3), p(3), s_lab, ds
integer i

!

rel_p = 1 + soa%pz(i)

! tilt_coords(-tilt_tot) is called without a tilt /= 0 test but tilt_coords returns on zero.
if (fs%do_tilt .and. -fs%tilt_tot /= 0) call tilt_lane (soa, i, fs%cos_mt, fs%sin_mt)

if (fs%is_misaligned) then
  r = [soa%x(i), soa%y(i), 0.0_rp]
  r(3) = r(3) - fs%ds_center_unset
  call mat3_vec (fs%w_mat, r, r2)
  r2 = r2 + [fs%x_off, fs%y_off, fs%z_off + fs%l_half]
  s_lab = r2(3)

  pz = rel_p**2 - soa%px(i)**2 - soa%py(i)**2
  if (pz <= 0) then
    soa%state(i) = lost_pz$
  else
    p0 = [soa%px(i), soa%py(i), sqrt(pz)]
    call mat3_vec (fs%w_mat, p0, p)
    soa%px(i) = p(1);  soa%py(i) = p(2)
    soa%x(i)  = r2(1); soa%y(i)  = r2(2)
  endif
else
  s_lab = fs%length                          ! s_pos0 for unset, orientation = 1
endif

ds = fs%s_target_unset - s_lab
if (abs(ds) > 1d-14 .and. soa%state(i) == alive$) call offset_drift_lane (soa, i, ds)

end subroutine offset_unset_lane

!--------------------------------------------------------------------------
! track_a_drift (orbit, ds, ele_orientation = 1, include_ref_motion = .false.)
! The time update in track_a_drift is not applied: track_a_quadrupole overwrites orbit%t.

subroutine offset_drift_lane (soa, i, length)

type (bunch_soa_struct) soa
real(rp) length, rel_pc, px_rel, py_rel, pxy2, ps_rel, dz
integer i, rel_z_vel

!

if (length == 0) return
rel_pc = 1 + soa%pz(i)
rel_z_vel = 1
px_rel = rel_z_vel * soa%px(i) / rel_pc
py_rel = rel_z_vel * soa%py(i) / rel_pc
pxy2 = px_rel**2 + py_rel**2
if (pxy2 >= 1) then
  soa%state(i) = lost_pz$
  return
endif
ps_rel = sqrt(1 - pxy2)

soa%x(i) = soa%x(i) + length * px_rel / ps_rel
soa%y(i) = soa%y(i) + length * py_rel / ps_rel
dz = -length /ps_rel
soa%z(i) = soa%z(i) + rel_z_vel * dz

end subroutine offset_drift_lane

!--------------------------------------------------------------------------
! tilt_coords with precomputed cos/sin. Same expression as matmul(rot_mat, coord(1:3:2)).

subroutine tilt_lane (soa, i, cos_ang, sin_ang)

type (bunch_soa_struct) soa
real(rp) cos_ang, sin_ang, a, b
integer i

a = soa%x(i);  b = soa%y(i)
soa%x(i) =  cos_ang * a + sin_ang * b
soa%y(i) = -sin_ang * a + cos_ang * b
a = soa%px(i);  b = soa%py(i)
soa%px(i) =  cos_ang * a + sin_ang * b
soa%py(i) = -sin_ang * a + cos_ang * b

end subroutine tilt_lane

!--------------------------------------------------------------------------
! res = matmul(w, v) in the accumulation order of gfortran's inlined matmul. UNVERIFIED w.r.t. FMA contraction.

subroutine mat3_vec (w, v, res)

real(rp) w(3,3), v(3), res(3)
integer i, k

res = 0
do k = 1, 3
  do i = 1, 3
    res(i) = res(i) + w(i,k) * v(k)
  enddo
enddo

end subroutine mat3_vec

!--------------------------------------------------------------------------
! quad_mat2_calc copy returning the 2x2 matrix elements and z_coef.

subroutine quad_z_coef (k1, length, rel_p, m11, m12, m21, m22, zc)

real(rp) k1, length, rel_p, m11, m12, m21, m22, zc(3)
real(rp) sqrt_k, sk_l, k_l2, cx, sx

sqrt_k = sqrt(abs(k1))
sk_l = sqrt_k * length

if (abs(sk_l) < 1d-10) then
  k_l2 = k1 * length**2
  cx = 1 + k_l2 / 2
  sx = (1 + k_l2 / 6) * length
elseif (k1 < 0) then
  cx = cos(sk_l)
  sx = sin(sk_l) / sqrt_k
else
  cx = cosh(sk_l)
  sx = sinh(sk_l) / sqrt_k
endif

m11 = cx
m12 = sx / rel_p
m21 = k1 * sx * rel_p
m22 = cx

zc(1) = k1 * (-cx * sx + length) / 4
zc(2) = -k1 * sx**2 / (2 * rel_p)
zc(3) = -(cx * sx + length) / (4 * rel_p**2)

end subroutine quad_z_coef

!--------------------------------------------------------------------------
! low_energy_z_correction copy (make_matrix = False).

elemental function low_e_dz (pz, p0c, beta, mass, e_tot, ds) result (dz)

real(rp), intent(in) :: pz, p0c, beta, mass, e_tot, ds
real(rp) dz, f, beta0

beta0 = p0c / e_tot
if (mass * (beta0*pz)**2 < 3d-7 * e_tot) then
  f = beta0**2 * (2 * beta0**2 - (mass / e_tot)**2 / 2)
  dz = ds * pz * (1 - 3 * (pz * beta0**2) / 2 + pz**2 * f) * (mass / e_tot)**2
else
  dz = ds * (beta - beta0) / beta0
endif

end function low_e_dz

!--------------------------------------------------------------------------
! ab_multipole_kicks, magnetic, make_matrix = False.

subroutine ab_kick_lane (soa, fs, i, scale)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) scale, r, a, b, a2, b2, f, kx, ky, kx_tot, ky_tot, x, y
integer i, n, m

!

kx_tot = 0
ky_tot = 0
r = fs%p0c_ele / soa%p0c(i)
x = soa%x(i)
y = soa%y(i)

do n = 0, fs%ix_mag_max
  a = r * fs%an(n)
  b = r * fs%bn(n)
  kx = 0
  ky = 0
  if (a /= 0 .or. b /= 0) then
    a2 = a * fs%ab_f
    b2 = b * fs%ab_f
    a2 = scale * a2
    b2 = scale * b2

    do m = 0, n, 2
      f = fs%cm(n, m) * powi(x, n-m) * powi(y, m)
      kx = kx + b2 * f
      ky = ky - a2 * f
    enddo

    do m = 1, n, 2
      f = fs%cm(n, m) * powi(x, n-m) * powi(y, m)
      kx = kx + a2 * f
      ky = ky + b2 * f
    enddo
  endif

  kx_tot = kx_tot + kx
  ky_tot = ky_tot + ky
enddo

soa%px(i) = soa%px(i) + kx_tot
soa%py(i) = soa%py(i) + ky_tot

end subroutine ab_kick_lane

!--------------------------------------------------------------------------
! mexp(x, m) = x**m with a run-time m. gfortran lowers that to libgcc __powidf2, whose
! square-and-multiply order is reproduced here so inlining with a constant m cannot change the
! multiplication chain. UNVERIFIED: confirm mexp is not built with -ffast-math.

elemental function powi (x, m) result (y)

real(rp), intent(in) :: x
integer, intent(in) :: m
real(rp) y, xx
integer n

if (m < 0) then
  y = 0
  return
elseif (m == 0) then
  y = 1
  return
endif

xx = x
n = m
if (mod(n, 2) == 1) then
  y = xx
else
  y = 1
endif
do
  n = n / 2
  if (n == 0) exit
  xx = xx * xx
  if (mod(n, 2) == 1) y = y * xx
enddo

end function powi

!--------------------------------------------------------------------------
! orbit_too_large copy (check_momentum = True, charged particle). Does not set param%unstable_factor.

subroutine orbit_too_large_lane (x, px, y, py, pz, max_ap, state, is_too_large)

real(rp) x, px, y, py, pz, max_ap, rel_p, f_unstable
integer state
logical is_too_large

is_too_large = .true.

if (x > max_ap) then
  state = lost_pos_x$;  return
elseif (-x > max_ap) then
  state = lost_neg_x$;  return
endif

if (y > max_ap) then
  state = lost_pos_y$;  return
elseif (-y > max_ap) then
  state = lost_neg_y$;  return
endif

rel_p = 1 + pz
if (rel_p < 0) then
  state = lost_pz$;  return
endif

f_unstable = px**2 + py**2 - rel_p**2
if (f_unstable > 0) then
  if (abs(px) > abs(py)) then
    if (px > 0) then
      state = lost_pos_x$
    else
      state = lost_neg_x$
    endif
  else
    if (py > 0) then
      state = lost_pos_y$
    else
      state = lost_neg_y$
    endif
  endif
  return
endif

is_too_large = .false.

end subroutine orbit_too_large_lane

!--------------------------------------------------------------------------
! check_aperture_limit after the orbit_too_large test, for rectangular/auto/elliptical apertures,
! non-collimator keys, offset_moves_aperture = False, aperture_at /= wall_transition$.

subroutine apertures_lane (x, y, fs, ie, state)

type (fast_slice_struct) fs
real(rp) x, y
integer ie, state, k

do k = 1, fs%n_ap(ie)
  call aperture_lane (x, y, fs%ap(k, ie), state)
  if (state /= alive$) return
enddo

end subroutine apertures_lane

!--------------------------------------------------------------------------

subroutine aperture_lane (x, y, fs, state)

type (fast_aperture_struct) fs
real(rp) x, y, xp, yp, r, f, unstable_factor
integer state

unstable_factor = 0

select case (fs%ap_type)
case (elliptical$)
  xp = x - fs%ex_c
  yp = y - fs%ey_c
  r = (xp / fs%ex_w2)**2 + (yp / fs%ey_w2)**2
  if (r < 1) return

  if (abs(xp / fs%ex_w2) > abs(yp / fs%ey_w2)) then
    if (xp > 0) then; state = lost_pos_x$
    else;             state = lost_neg_x$
    endif
  else
    if (yp > 0) then; state = lost_pos_y$
    else;             state = lost_neg_y$
    endif
  endif

case (rectangular$, auto_aperture$)
  if (fs%x1_lim /= 0 .and. x < fs%x1_lim) then
    f = abs((x - fs%x1_lim) / (fs%x2_lim - fs%x1_lim))
    if (f > unstable_factor) then
      state = lost_neg_x$
      unstable_factor = f
    endif
  endif

  if (fs%x2_lim /= 0 .and. x > fs%x2_lim) then
    f = abs((x - fs%x2_lim) / (fs%x2_lim - fs%x1_lim))
    if (f > unstable_factor) then
      state = lost_pos_x$
      unstable_factor = f
    endif
  endif

  if (fs%y1_lim /= 0 .and. y < fs%y1_lim) then
    f = abs((y - fs%y1_lim) / (fs%y2_lim - fs%y1_lim))
    if (f > unstable_factor) then
      state = lost_neg_y$
      unstable_factor = f
    endif
  endif

  if (fs%y2_lim /= 0 .and. y > fs%y2_lim) then
    f = abs((y - fs%y2_lim) / (fs%y2_lim - fs%y1_lim))
    if (f > unstable_factor) then
      state = lost_pos_y$
      unstable_factor = f
    endif
  endif
end select

end subroutine aperture_lane

!--------------------------------------------------------------------------
! Time updates.
! fast_time_qp$: identical to Bmad: t = t + dt  (drift)  and  t = (t + a) + b  (quadrupole).
! fast_time_dd$: accumulate in (dt_hi, dt_lo). Not bit-identical.

subroutine add_time (soa, i, dt)

type (bunch_soa_struct) soa
real(rp) dt
integer i

if (fast_track_time_mode == fast_time_qp$) then
  soa%t(i) = soa%t(i) + dt
else
  call dd_add (soa%dt_hi(i), soa%dt_lo(i), dt)
endif

end subroutine add_time

subroutine add_time2 (soa, i, a, b)

type (bunch_soa_struct) soa
real(rp) a, b
integer i

if (fast_track_time_mode == fast_time_qp$) then
  soa%t(i) = (soa%t(i) + a) + b
else
  call dd_add (soa%dt_hi(i), soa%dt_lo(i), a)
  call dd_add (soa%dt_hi(i), soa%dt_lo(i), b)
endif

end subroutine add_time2

!--------------------------------------------------------------------------
! Knuth two-sum: s + e = a + b exactly. Must not be compiled with -ffast-math / -fassociative-math.

elemental subroutine two_sum (a, b, s, e)

real(rp), intent(in) :: a, b
real(rp), intent(out) :: s, e
real(rp) bb

s = a + b
bb = s - a
e = (a - (s - bb)) + (b - bb)

end subroutine two_sum

!--------------------------------------------------------------------------
! (hi, lo) += d, renormalized so |lo| <= ulp(hi)/2.

elemental subroutine dd_add (hi, lo, d)

real(rp), intent(inout) :: hi, lo
real(rp), intent(in) :: d
real(rp) s, e

call two_sum (hi, d, s, e)
e = e + lo
hi = s + e
lo = e - (hi - s)

end subroutine dd_add

end module bunch_soa_mod
