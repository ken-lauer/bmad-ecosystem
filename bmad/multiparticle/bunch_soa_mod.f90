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
!   call fast_slice_prepare(ele, param, fs, err, why)    ! Once per element/slice. Serial.
!   if (.not. err) then
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
!   * param%unstable_factor is NOT updated by the kernels (in track1_bunch_hom it is a shared,
!     racy write already).
! Places where exactness is believed but not proven are marked "UNVERIFIED".
!-

module bunch_soa_mod

use bmad_interface
use random_mod, only: ran_gauss
use radiation_mod, only: radiation_map_setup
use, intrinsic :: iso_fortran_env, only: int64

implicit none

private :: powi, quad_z_coef, low_e_dz, orbit_too_large_lane, aperture_lane, apertures_lane, ab_kick_lane, radiation_lane
private :: track_block_drift, track_block_quad, track_block_thick, track_block_bend, bend_body_lane, entrance_block, exit_block, fast_note_why
private :: bend_fringe_lane, bend_fringe_setup, track_block_lcav_std, lcav_std_lane

integer, parameter :: fast_none$ = 0, fast_drift$ = 1, fast_quad$ = 2, fast_thick$ = 3, fast_bend$ = 4, fast_lcav$ = 5
integer, parameter :: fast_lcav_std$ = 6         ! bmad_standard lcavity (track_a_lcavity)
integer, parameter :: fast_max_rf = 130          ! Max RF stair step entries in one slice

integer, parameter :: fast_block_size = 256

! Max number of apertures checked at one track edge (lord_defined apertures of a super_slave
! resolve to one per super_lord).
integer, parameter :: fast_max_ap = 4

! Drift-like slices are not worth the bunch <-> SoA conversion when converting per slice.
logical :: fast_track_drifts = .false.

logical, private, save :: fast_track_on = .false., fast_track_verbose = .false., fast_track_env_checked = .false.

! BMAD_FAST_TRACK_FP32=1: round the six phase space coordinates to single precision after every kernel
! slice and every CSR/space charge kick. A proxy for a single precision (GPU) kernel: the same storage
! precision at every sync point, with the arithmetic in between still in double precision.
logical, save :: fast_track_fp32_proxy = .false.

! BMAD_FAST_TRACK=metal (or cuda): also use that device backend (see bunch_device_mod).
character(16), save :: fast_track_device = ''

! With BMAD_FAST_TRACK=verbose, each distinct reason for not using the kernels is printed once.
integer, parameter, private :: n_why_max = 64
character(100), private, save :: why_seen(n_why_max) = ''
integer, private, save :: n_why_seen = 0

! Structure-of-arrays bunch.
! Time: t(:) holds the coord_struct%t value (quad precision). The kernels update it with qp_add_dp.

type bunch_soa_struct
  integer :: n = 0
  real(rp), allocatable :: x(:), px(:), y(:), py(:), z(:), pz(:)
  real(rp), allocatable :: s(:)
  real(qp), allocatable :: t(:)
  real(rp), allocatable :: charge(:), p0c(:), beta(:)
  real(rp), allocatable :: field(:,:)          ! (2, n). Not changed by the kernels; for bunch statistics.
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
  ! Bend (track_a_bend body without k1, multipole kicks or misalignment).
  real(rp) :: g = 0, dg = 0, g_tot = 0, angle = 0, beta_ref = 0
  real(rp) :: sinc_a = 0, cos_a = 0, sin_a = 0, cosc_a = 0, sincc_a = 0
  ! Bend fringe (bend_edge_kick): fr_type 1 = exact_bend_edge_kick (fringe_type full), 2 = hwang_bend_edge_kick
  ! (basic_bend, hard_edge_only). fr_on(ie): kick at the first / second track edge of this slice (fringe_here).
  integer :: fr_type = 0
  logical :: fr_on(2) = .false.
  real(rp) :: fr_e(2) = 0, fr_fg(2) = 0      ! Edge angle and fint * hgap of each edge (0 for hard_edge_only)
  real(rp) :: fr_g = 0                      ! g + dg if on, else 0 (exact kick, charge independent)
  real(rp) :: fr_g_dir = 0                  ! (g + dg) * charge_dir (hwang kick)
  real(rp) :: fr_beta0 = 0                  ! p0c / e_tot of the slice
  ! Radiation kicks (track1_radiation) at the entrance (1) and exit (2) from ele%rad_map rm0/rm1.
  logical :: rad_damp = .false., rad_fluct = .false., rad_damp_vec = .false.
  ! Per edge: whether the damping kick is nonzero (adding an all-zero kick does not change the orbit so
  ! it is skipped). The stochastic kick is applied whenever fluctuations are on, so that the random
  ! numbers are drawn exactly as track1_radiation draws them.
  logical :: rad_on_edge(2) = .false., rad_damp_edge(2) = .false., rad_fluct_edge(2) = .false.
  real(rp) :: rad_scale = 0
  real(rp) :: rad_ref(6,2) = 0, rad_dmat(6,6,2) = 0, rad_dvec(6,2) = 0, rad_smat(6,6,2) = 0
  ! Runge-Kutta lcavity (track1_runge_kutta with the bmad_standard cavity field). Device kernel only.
  logical :: lc_abs_time = .false., lc_travel = .false., lc_ap_cont = .false.
  logical :: lc_kick(2) = .false.           ! Edge kick applied at the entrance / exit edge (fringe_at of slice and lord)
  integer :: lc_long_mode = 0, lc_max_steps = 0
  real(rp) :: lc_grad = 0, lc_k = 0, lc_omega = 0, lc_phase = 0, lc_rf_freq = 0
  real(rp) :: lc_s_off = 0                  ! s_eff = s_body + lc_s_off (active region coordinate)
  real(rp) :: lc_l_active = 0
  real(rp) :: lc_time0 = 0, lc_inv_cb0 = 0  ! RF time = lc_time0 + t (absolute) or lc_time0 + s_body*lc_inv_cb0 - z/(beta c)
  real(rp) :: lc_ib0m1 = 0                  ! 1/beta0 - 1 of the reference time rate (kick_vector_calc)
  real(rp) :: lc_dt_ref_rk = 0              ! Reference time advance over the slice as odeint_bmad takes it
  real(rp) :: lc_edge1 = 0, lc_edge2 = 0    ! Entrance and exit edge kick positions in the slice (calc_next_fringe_edge)
  real(rp) :: lc_zk = 0                     ! z shift to the lord's reference for the edge field (relative time only)
  real(rp) :: lc_rel_tol = 0, lc_abs_tol = 0, lc_init_ds = 0, lc_min_ds = 0, lc_fatal_ds = 0, lc_ds_tiny = 0
  real(rp) :: lc_charge = 0
  real(rp) :: lc_rel_floor = 0             ! float32 floor of the relative tolerance after the sqrt(N) scaling
  ! bmad_standard lcavity (track_a_lcavity, forward). One entry per RF stair step the slice touches: a drift
  ! of rf_ds, then the actions in rf_flags (bit 0 entrance fringe, 1 energy kick, 2 exit fringe, 3 pondermotive
  ! kick before the energy kick, 4 after).
  integer :: rf_n = 0
  logical :: rf_abs = .false., rf_tw = .false.
  real(rp) :: rf_volt = 0, rf_fauto = 0, rf_grad = 0, rf_pond = 0, rf_nstep = 0, rf_freq = 0, rf_omega = 0
  real(rp) :: rf_phi0 = 0, rf_ref_shift = 0, rf_ff = 0
  integer :: rf_flags(fast_max_rf) = 0
  real(rp) :: rf_ds(fast_max_rf) = 0, rf_scale(fast_max_rf) = 0, rf_p1c(fast_max_rf) = 0
  real(rp) :: rf_ts(fast_max_rf) = 0, rf_tm(fast_max_rf) = 0   ! step%time and the multipass lord's step%time
  real(rp) :: rf_p0c(fast_max_rf) = 0, rf_e0(fast_max_rf) = 0  ! Reference momentum and energy of the drift region
end type

contains

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function fast_track_eligible (ele, param, why) result (is_eligible)
!
! Routine to decide if ele may be tracked with the SoA kernels instead of per-particle track1.
! This checks everything that does not depend on the bunch (see also fast_soa_compatible) by running
! fast_slice_prepare, which callers that go on to track should use directly.
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
type (fast_slice_struct) fs

logical is_eligible, err
character(*), optional :: why

!

call fast_slice_prepare (ele, param, fs, err, why)
is_eligible = .not. err

end function fast_track_eligible

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Function bend_supported (ele, param, why, check_fringe, fs) result (is_ok)
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
!   fs           -- fast_slice_struct, optional: Slice being prepared, with %length set.
!
! Output:
!   why     -- character(*), optional: Reason if not.
!   is_ok   -- logical: True if supported.
!   fs      -- fast_slice_struct, optional: If supported, the bend quantities are filled in.
!-

function bend_supported (ele, param, why, check_fringe, fs) result (is_ok)

type (ele_struct) ele
type (lat_param_struct) param
type (fast_slice_struct), optional :: fs
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
  select case (nint(ele%value(fringe_type$)))
  case (none$, full$, basic_bend$, hard_edge_only$)
  case default
    call set_why('bend fringe type');  return
  end select
endif
if (ele%bookkeeping_state%has_misalign) then
  call set_why('misaligned bend');  return
endif

orb0%direction = 1;  orb0%time_dir = 1;  orb0%species = param%particle
rel_charge_dir = ele%orientation * rel_tracking_charge_to_mass(orb0, param%particle)
b1 = 0
if (nint(ele%value(exact_multipoles$)) /= off$) then
  ! track_a_bend then kicks with every pole, the dipole kick included, through bend_exact_multipole_field.
  call multipole_ele_to_ab(ele, .false., ix_mag_max, an, bn, magnetic$, include_kicks$)
  if (ix_mag_max > -1) then
    call set_why('bend exact multipoles');  return
  endif
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
if (.not. present(fs)) return

! The values track_a_bend computes per particle.

fs%charge_dir = rel_charge_dir
fs%ix_mag_max = ix_mag_max
fs%g = ele%value(g$)
fs%dg = dg
fs%g_tot = (fs%g + fs%dg) * fs%charge_dir
fs%n_step = 1
if (ix_mag_max > -1) fs%n_step = max(nint(abs(fs%length) / ele%value(ds_step$)), 1)
fs%step_len = fs%length / fs%n_step
fs%angle = fs%g * fs%step_len
fs%beta_ref = ele%value(p0c$) / ele%value(E_tot$)
fs%sinc_a = sinc(fs%angle)
fs%cos_a = cos(fs%angle)
fs%sin_a = sin(fs%angle)
fs%cosc_a = cosc(fs%angle)
fs%sincc_a = sincc(fs%angle)
call bend_fringe_setup (ele, fs)

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
! Function fast_kind (ele, for_device) result (kind)
!
! Routine to map an element onto the fast kernel that reproduces its track1_bmad branch.
!
! Input:
!   ele   -- ele_struct: Element.
!
! Output:
!   kind  -- integer: fast_drift$, fast_quad$, fast_thick$, fast_bend$ or fast_none$.
!-

function fast_kind (ele, for_device) result (kind)

type (ele_struct) ele
integer kind
logical, optional :: for_device

kind = fast_none$

! track1: "if (.not. ele%is_on) tracking_method = bmad_standard$"
if (ele%is_on .and. ele%tracking_method /= bmad_standard$) then
  ! Runge-Kutta lcavity: device kernel only.
  if (logic_option(.false., for_device) .and. ele%key == lcavity$ .and. ele%tracking_method == runge_kutta$) kind = fast_lcav$
  return
endif

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
case (lcavity$);     kind = fast_lcav_std$
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
! Subroutine fast_slice_prepare (ele, param, fs, err_flag, why, for_device)
!
! Routine to check that ele is supported by the fast kernels (fast_track_eligible lists what is
! supported) and to compute all slice-invariant quantities used by them.
! With for_device = True, element kinds that only the device kernels support (Runge-Kutta lcavity)
! are accepted too; fast_track_soa must not be called with such a slice.
! Must be called serially (outside any OpenMP parallel region) since it calls Bmad routines
! that initialize SAVEd tables (c_multi) and may allocate ele%multipole_cache.
!
! Input:
!   ele       -- ele_struct: Element or slice to track through.
!   param     -- lat_param_struct: Branch parameters. param%particle is the tracking species.
!
! Output:
!   fs        -- fast_slice_struct: Prepared data.
!   err_flag  -- logical: Set True if ele is not supported.
!   why       -- character(*), optional: Reason if ele is not supported. Blank if supported.
!-

subroutine fast_slice_prepare (ele, param, fs, err_flag, why, for_device)

type (ele_struct), target :: ele
type (lat_param_struct) param
type (fast_slice_struct) fs
type (coord_struct) orb0
type (fringe_field_info_struct) fringe_info

real(rp) an(0:n_pole_maxx), bn(0:n_pole_maxx), xp, yp, ds_center_set, s_pos0
integer ix_elec_max, n, m
logical err_flag
logical, optional :: for_device
character(*), optional :: why

character(*), parameter :: r_name = 'fast_slice_prepare'

!

err_flag = .true.
if (present(why)) why = ''
fs = fast_slice_struct()

if (bmad_com%spin_tracking_on) then
  call set_why('spin tracking on');  return
endif
if (bmad_com%high_energy_space_charge_on) then
  call set_why('high energy space charge on');  return
endif
if (associated(track1_preprocess_ptr) .or. associated(track1_postprocess_ptr)) then
  call set_why('track1 hooks set');  return
endif

fs%kind = fast_kind(ele, for_device)
if (fs%kind == fast_none$) then
  call set_why('element type / tracking method not supported');  return
endif

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

if (.not. fast_aperture_setup(ele, fs, why)) return
if (.not. radiation_setup()) return

if (fs%kind == fast_drift$) then
  err_flag = .false.
  return
endif

!------------------------------------------
! Bend

if (fs%kind == fast_bend$) then
  if (.not. bend_supported(ele, param, why, fs = fs)) return
  err_flag = .false.
  return
endif

!------------------------------------------
! Runge-Kutta lcavity (device kernel)

if (fs%kind == fast_lcav_std$) then
  if (.not. lcav_std_setup()) return
  call misalign_setup ()
  err_flag = .false.
  return
endif

if (fs%kind == fast_lcav$) then
  if (ele%orientation /= 1) then
    call set_why('reversed element');  return
  endif
  if (ele%bookkeeping_state%has_misalign .and. .not. has_orientation_attributes(ele)) then
    call set_why('misaligned without orientation attributes');  return
  endif
  if (.not. lcav_setup()) return
  call misalign_setup ()
  err_flag = .false.
  return
endif

!------------------------------------------
! Quadrupole / thick multipole

if (ele%orientation /= 1) then
  call set_why('reversed element');  return
endif
if (fs%kind == fast_quad$ .and. ele%value(l$) == 0) then
  call set_why('zero length quadrupole');  return
endif
call init_fringe_info (fringe_info, ele)
if (fringe_info%has_fringe) then
  call set_why('fringe fields');  return
endif
if (ele%bookkeeping_state%has_misalign .and. .not. has_orientation_attributes(ele)) then
  call set_why('misaligned without orientation attributes');  return
endif

if (fs%kind == fast_quad$) then
  fs%charge_dir = rel_tracking_charge_to_mass(orb0, param%particle) * (ele%orientation * orb0%direction * orb0%time_dir)
  call multipole_ele_to_ab (ele, .false., fs%ix_mag_max, fs%an, fs%bn, magnetic$, include_kicks$, fs%b1)
else
  call multipole_ele_to_ab (ele, .false., fs%ix_mag_max, fs%an, fs%bn, magnetic$, include_kicks$)
endif
call multipole_ele_to_ab (ele, .false., ix_elec_max, an, bn, electric$)
if (ix_elec_max > -1) then
  call set_why('electric multipoles');  return
endif
if (fs%ix_mag_max > -1 .and. ele%value(ds_step$) <= 0) then
  call set_why('ds_step <= 0');  return
endif

if (fs%kind == fast_quad$) then
  fs%n_step = 1
  if (fs%ix_mag_max > -1) fs%n_step = max(nint(abs(fs%length) / ele%value(ds_step$)), 1)
  fs%r_step = real(orb0%time_dir, rp) / fs%n_step
  fs%step_len = ele%value(l$) * fs%r_step
  if (fs%length == 0) fs%n_step = 0
else
  ! track_a_thick_multipole. Note the different n_step and step_len expressions from track_a_quadrupole.
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

call misalign_setup ()

err_flag = .false.



!------------------------
contains

subroutine set_why(str)
character(*) str
if (present(why)) why = str
end subroutine set_why

!------------------------
! Misalignment of the slice (offset_particle set/unset as the kernels apply it).

subroutine misalign_setup ()

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

end subroutine misalign_setup

!------------------------
! bmad_standard lcavity: the RF stair steps of track_a_lcavity this slice touches, with everything
! this_energy_kick, this_pondermotive_transverse_kick, fringe_kick and this_rf_phase use, for a forward
! particle (s_dir = body_dir = 1).

function lcav_std_setup () result (ok)

type (ele_struct), pointer :: lord, mlord
type (rf_stair_step_struct), pointer :: step
type (ele_pointer_struct), allocatable :: chain(:)
real(rp) s_now, s_end, ds
integer ix_start, ix_end, n_steps, ix, k, ix_pass, n_links, fl, n_step_v, ix_mag, ix_elec
logical ok, fr_in, fr_out

ok = .false.
lord => pointer_to_super_lord(ele)
if (ele%orientation /= 1 .or. lord%orientation /= 1) then
  call set_why('reversed element');  return
endif
if (ele%value(l$) == 0) then
  call set_why('zero length lcavity');  return
endif
if (nint(lord%value(n_rf_steps$)) == 0 .or. .not. associated(lord%rf)) then
  call set_why('lcavity without RF stair steps');  return
endif
if (ele%value(rf_frequency$) == 0 .or. lord%value(rf_frequency$) == 0) then
  call set_why('lcavity with zero rf_frequency');  return
endif
if (lord%value(ks$) /= 0) then
  call set_why('lcavity with solenoid field');  return
endif
if (lord%value(coupler_strength$) /= 0 .or. ele%value(coupler_strength$) /= 0) then
  call set_why('rf coupler kick');  return
endif
if (ele%value(hkick$) /= 0 .or. ele%value(vkick$) /= 0) then
  call set_why('lcavity with kicks');  return
endif
if (ele%bookkeeping_state%has_misalign .and. .not. has_orientation_attributes(ele)) then
  call set_why('misaligned without orientation attributes');  return
endif
call multipole_ele_to_ab (ele, .false., ix_mag, an, bn, magnetic$, include_kicks$)
call multipole_ele_to_ab (ele, .false., ix_elec, an, bn, electric$)
if (ix_mag > -1 .or. ix_elec > -1) then
  call set_why('lcavity multipoles');  return
endif

mlord => lord
if (lord%slave_status == multipass_slave$) mlord => pointer_to_lord(lord, 1)
fs%rf_abs = absolute_time_tracking(lord)
fs%rf_ref_shift = 0
if (fs%rf_abs .and. bmad_com%absolute_time_ref_shift) then
  if (lord%slave_status == multipass_slave$) then
    call multipass_chain(lord, ix_pass, n_links, chain)
    fs%rf_ref_shift = chain(1)%ele%value(ref_time_start$)
  else
    fs%rf_ref_shift = lord%value(ref_time_start$)
  endif
endif
fs%rf_phi0 = lord%value(phi0_err$) + lord%value(phi0$)
if (.not. bmad_com%absolute_time_tracking) fs%rf_phi0 = fs%rf_phi0 + lord%value(phi0_multipass$)
fs%rf_freq = lord%value(rf_frequency$)
fs%rf_omega = twopi * ele%value(rf_frequency$) / c_light
fs%rf_volt = lord%value(voltage$) + lord%value(voltage_err$)
fs%rf_fauto = lord%value(field_autoscale$)
fs%rf_tw = (nint(lord%value(cavity_type$)) == traveling_wave$)
fs%rf_ff = charge_of(param%particle) / (2.0_rp * charge_of(lord%ref_species))
n_step_v = nint(lord%value(n_rf_steps$))
fs%rf_nstep = n_step_v
if (lord%value(l_active$) /= 0) then
  fs%rf_grad = lord%value(voltage_tot$) * lord%value(field_autoscale$) / lord%value(l_active$)
  fs%rf_pond = (lord%value(field_autoscale$)*lord%value(voltage_tot$)/lord%value(l_active$))**2 * lord%value(l_active$)
endif

fr_in  = (nint(lord%value(fringe_type$)) /= none$ .and. at_this_ele_end(entrance_end$, nint(lord%value(fringe_at$))))
fr_out = (nint(lord%value(fringe_type$)) /= none$ .and. at_this_ele_end(exit_end$, nint(lord%value(fringe_at$))))
fr_in = fr_in .and. lord%value(l_active$) /= 0
fr_out = fr_out .and. lord%value(l_active$) /= 0

n_steps = ubound(lord%rf%steps, 1) - 1
s_now = ele%s_start - lord%s_start
s_end = ele%s       - lord%s_start
ix_start = ele_rf_step_index(ele%value(E_tot_start$), s_now, lord)
ix_end   = ele_rf_step_index(ele%value(E_tot$), s_end, lord)
if (ix_start < 0 .or. ix_end < 0) then
  call set_why('RF step bookkeeping');  return
endif
if (ix_end - ix_start + 1 > fast_max_rf) then
  call set_why('too many RF steps');  return
endif

k = 0
do ix = ix_start, ix_end
  step => lord%rf%steps(ix)
  if (ix == ix_end) then
    ds = s_end - s_now
    s_now = s_end
  else
    ds = step%s - s_now
    s_now = step%s
  endif
  fl = 0
  if (ix == 0 .and. s_now == step%s .and. fr_in) fl = ibset(fl, 0)
  if (ix /= ix_end) then
    fl = ibset(fl, 1)
    if (.not. fs%rf_tw .and. lord%value(l_active$) /= 0) then
      if (step%ix_step /= 0) fl = ibset(fl, 3)
      if (step%ix_step /= n_step_v) fl = ibset(fl, 4)
    endif
  endif
  if (ix == n_steps .and. s_now == step%s .and. fr_out) fl = ibset(fl, 2)
  k = k + 1
  fs%rf_ds(k) = ds
  fs%rf_flags(k) = fl
  fs%rf_scale(k) = step%scale
  fs%rf_p1c(k) = step%p1c
  fs%rf_ts(k) = step%time
  fs%rf_tm(k) = mlord%rf%steps(step%ix_step)%time
  fs%rf_p0c(k) = step%p0c
  fs%rf_e0(k) = step%E_tot0
enddo
fs%rf_n = k
ok = .true.

end function lcav_std_setup

!------------------------
! Runge-Kutta lcavity: everything odeint_bmad, kick_vector_calc, em_field_calc (bmad_standard cavity),
! calc_next_fringe_edge and apply_element_edge_kick need, for a forward particle through this slice.

function lcav_setup () result (ok)

type (ele_struct), pointer :: lord, flord, lord2
type (coord_struct) orb0
real(rp) gradient, s_act_off, s_lord_off, s1, s2, beta0, beta_ref
real(qp) t0, t1
integer ix_mag_max, i, n_flord
logical ok

! lord: the element the slice is cut from (geometry, reference energy and time, fringe_at, edges).
! flord: the element whose field em_field_calc evaluates (a multipass lord when lord refers to it).

ok = .false.
lord => ele
if (ele%slave_status == slice_slave$) lord => ele%lord
if (fs%length <= 0) then
  call set_why('zero or negative length lcavity');  return
endif
flord => lord
if (lord%field_calc == refer_to_lords$) then
  n_flord = 0
  do i = 1, lord%n_lord
    lord2 => pointer_to_lord(lord, i)
    if (lord2%field_calc == no_field$) cycle
    n_flord = n_flord + 1
    flord => lord2
  enddo
  if (n_flord /= 1 .or. flord%lord_status /= multipass_lord$ .or. flord%key /= lcavity$) then
    call set_why('lcavity field from other than one multipass lord');  return
  endif
endif
if (flord%field_calc /= bmad_standard$) then
  call set_why('lcavity field_calc not bmad_standard');  return
endif
if (lord%n_lord_field /= 0 .or. flord%n_lord_field /= 0) then
  call set_why('overlapping fields');  return
endif
if (flord%value(rf_frequency$) == 0 .or. flord%value(l_active$) <= 0 .or. lord%value(l_active$) <= 0) then
  call set_why('lcavity without rf_frequency or active length');  return
endif
if (lord%value(coupler_strength$) /= 0 .or. flord%value(coupler_strength$) /= 0) then
  call set_why('rf coupler kick');  return
endif
call multipole_ele_to_ab (ele, .false., ix_elec_max, an, bn, electric$)
if (ix_elec_max > -1) then
  call set_why('electric multipoles');  return
endif
call multipole_ele_to_ab (ele, .false., ix_mag_max, an, bn, magnetic$)
if (ix_mag_max > -1) then
  call set_why('magnetic multipoles');  return
endif
fs%lc_travel = (nint(flord%value(cavity_type$)) == traveling_wave$)
fs%lc_long_mode = nint(flord%value(longitudinal_mode$))
if (.not. fs%lc_travel .and. fs%lc_long_mode /= 0 .and. fs%lc_long_mode /= 1) then
  call set_why('longitudinal_mode not 0 or 1');  return
endif

! Field (em_field_calc, case lcavity$, called with the lord through field_from_lords).

gradient = e_accel_field (flord, gradient$)
if (.not. flord%is_on) gradient = 0
gradient = (gradient + gradient_shift_sr_wake(flord, param)) / charge_of(flord%ref_species)
fs%lc_grad = gradient * flord%value(l$) / flord%value(l_active$)
fs%lc_phase = twopi * (flord%value(phi0$) + flord%value(phi0_err$) + flord%value(phi0_autoscale$))
if (.not. bmad_com%absolute_time_tracking) fs%lc_phase = fs%lc_phase + twopi * ele%value(phi0_multipass$)
fs%lc_rf_freq = flord%value(rf_frequency$)
fs%lc_omega = twopi * fs%lc_rf_freq
fs%lc_k = fs%lc_omega / c_light
fs%lc_l_active = flord%value(l_active$)
s_act_off = (flord%value(l$) - flord%value(l_active$)) / 2
s_lord_off = ele%s_start - lord%s_start
fs%lc_s_off = s_lord_off - s_act_off

! Edges (calc_next_fringe_edge from the slice entrance): the active edges clamped to the slice. The
! integrator stops there; the kick (apply_element_edge_kick) is applied only where fringe_at of the
! slice (set by makeup_super_slave1 from the ends the slice contains) and of the lord allow it.
! The field is zero outside the active region.

s1 = -(s_lord_off - (lord%value(l$) - lord%value(l_active$)) / 2)
s2 = s1 + lord%value(l_active$)
fs%lc_edge1 = min(max(s1, 0.0_rp), fs%length)
fs%lc_edge2 = min(max(s2, 0.0_rp), fs%length)
fs%lc_kick(1) = at_this_ele_end(entrance_end$, nint(ele%value(fringe_at$))) .and. at_this_ele_end(entrance_end$, nint(lord%value(fringe_at$)))
fs%lc_kick(2) = at_this_ele_end(exit_end$, nint(ele%value(fringe_at$))) .and. at_this_ele_end(exit_end$, nint(lord%value(fringe_at$)))

! Reference time rate of kick_vector_calc (the lord's average) and the z shift of the edge field.

if (lord%value(delta_ref_time$) == 0) then
  beta0 = lord%value(p0c$) / lord%value(e_tot$)
else
  beta0 = lord%value(l$) / (c_light * lord%value(delta_ref_time$))
endif
fs%lc_ib0m1 = 1 / beta0 - 1
fs%lc_dt_ref_rk = fs%length / (beta0 * c_light)
beta_ref = lord%value(p0c$) / lord%value(e_tot$)
fs%lc_zk = (ele%value(ref_time_start$) - lord%value(ref_time_start$)) - s_lord_off / (beta_ref * c_light)

! RF time (particle_rf_time). Absolute time: lc_time0 is set by the caller from the bunch's reference time.
! Relative time: probe the s dependence at z = 0.

fs%lc_abs_time = absolute_time_tracking(ele)
if (.not. fs%lc_abs_time) then
  orb0 = coord_struct()
  orb0%vec = 0;  orb0%beta = 1;  orb0%t = 0;  orb0%p0c = ele%value(p0c_start$)
  orb0%species = param%particle;  orb0%direction = 1;  orb0%time_dir = 1
  t0 = particle_rf_time (orb0, ele, .true., 0.0_rp)
  t1 = particle_rf_time (orb0, ele, .true., 1.0_rp)
  fs%lc_inv_cb0 = real(t1 - t0, rp)
  fs%lc_time0 = real(modulo2(t0, 0.5_qp / fs%lc_rf_freq), rp)
endif

! Integrator parameters. float32 cannot resolve a relative error below ~1e-6 of the step increments
! (and the field phase k s has the resolution of s, epsilon * length), so the relative tolerance
! is floored there after rk_adaptive_step's sqrt(N) scaling; the step controller would otherwise
! chase round-off until the step size collapses.

fs%lc_rel_tol = bmad_com%rel_tol_adaptive_tracking
fs%lc_rel_floor = max(2.0e-6_rp, 10 * fs%lc_k * 1.2e-7_rp * fs%length)
fs%lc_abs_tol = bmad_com%abs_tol_adaptive_tracking
fs%lc_init_ds = bmad_com%init_ds_adaptive_tracking
fs%lc_min_ds = bmad_com%min_ds_adaptive_tracking
fs%lc_fatal_ds = bmad_com%fatal_ds_adaptive_tracking
fs%lc_max_steps = bmad_com%max_num_runge_kutta_step
fs%lc_ds_tiny = bmad_com%significant_length / 100
fs%lc_charge = charge_of(param%particle)
fs%lc_ap_cont = bmad_com%aperture_limit_on .and. (ele%aperture_at == continuous$ .or. ele%aperture_at == lord_defined$)
ok = .true.

end function lcav_setup

!------------------------
! As track1 / track1_radiation: kicks at both edges for elements that radiate, with the maps from
! radiation_map_setup (which only recomputes stale maps, as track1_bunch_hom relies on).

function radiation_setup() result (ok)
logical ok, rad_err
integer ie
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
  call set_why('radiation map error')
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
do ie = 1, 2
  fs%rad_damp_edge(ie) = fs%rad_damp .and. (any(fs%rad_dmat(:,:,ie) /= 0) .or. &
                                            (fs%rad_damp_vec .and. any(fs%rad_dvec(:,ie) /= 0)))
  fs%rad_fluct_edge(ie) = fs%rad_fluct
  fs%rad_on_edge(ie) = fs%rad_damp_edge(ie) .or. fs%rad_fluct_edge(ie)
enddo
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
! Function fast_soa_compatible (soa, ele, fs, why) result (is_ok)
!
! Bunch dependent eligibility checks. All live particles must:
!   have direction = +1 and time_dir = +1,
!   be of species fs%species (= param%particle), not photons,
!   have p0c consistent with the element (else track1 prints an error and skips the particle).
! The p0c test is only evaluated when p0c changes from one particle to the next in a thread's block.
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
! Coord_struct components not used by the kernels (phase, dt_ref, r, E_potential, ix_turn, ix_user)
! are not copied. soa_to_bunch leaves them, and field (copied for calc_bunch_params_soa), untouched in
! bunch%particle.
!
! Input:
!   bunch     -- bunch_struct: Bunch.
!   with_spin -- logical, optional: Copy spin? Default is False.
!
! Output:
!   soa       -- bunch_soa_struct: SoA bunch. Reallocated as needed.
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
  soa%charge(i)    = p%charge
  soa%field(:, i)  = p%field
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
! Routine to store a SoA bunch back into bunch%particle(:).
! Only components that the kernels may change are written.
!
! Input:
!   soa       -- bunch_soa_struct: SoA bunch.
!
! Output:
!   bunch     -- bunch_struct: bunch%particle(:) updated.
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
            soa%charge(n), soa%p0c(n), soa%beta(n), soa%state(n), &
            soa%species(n), soa%location(n), soa%ix_ele(n), soa%ix_branch(n), soa%direction(n), soa%time_dir(n), &
            soa%field(2, n))
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
            soa%charge, soa%p0c, soa%beta, soa%state, &
            soa%species, soa%location, soa%ix_ele, soa%ix_branch, soa%direction, soa%time_dir, soa%field)
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
! Subroutine fast_track1_soa_fallback (soa, bunch, ele, param, thread_safe)
!
! Routine to track the live particles of a SoA bunch through ele with track1 (for elements the kernels
! do not support) without converting the whole bunch. Each particle's coord_struct in bunch%particle(i)
! is loaded with the SoA values, tracked with track1, and stored back in both bunch%particle(i) and soa.
!
! Results are identical to soa_to_bunch + track1_bunch_hom (without wakes) + bunch_to_soa: the same
! track1 calls are made in the same order and thread assignment as track1_bunch_particles (first live
! particle serially while the multipole memo records, then a parallel loop with schedule(static, 64)),
! so even random numbers (radiation) are drawn identically. As in track1_bunch_hom, the caller must set
! up radiation maps (radiation_map_setup) and must not use this for elements with wakes or for Taylor
! tracking (which may need ele_to_taylor).
!
! Input:
!   soa         -- bunch_soa_struct: Bunch, authoritative for the SoA components.
!   bunch       -- bunch_struct: Same bunch, authoritative for the other coord_struct components.
!   ele         -- ele_struct: Element or slice.
!   param       -- lat_param_struct: Branch parameters.
!   thread_safe -- logical: False to track serially.
!
! Output:
!   soa, bunch  -- Tracked particles updated in both.
!-

subroutine fast_track1_soa_fallback (soa, bunch, ele, param, thread_safe)

use multipole_memo_mod

type (bunch_soa_struct) soa
type (bunch_struct), target :: bunch
type (ele_struct), target :: ele
type (lat_param_struct) param

integer j, j0
logical thread_safe, use_memo

!

use_memo = (thread_safe .and. soa%n > 1000 .and. multipole_memo_state == memo_off$ .and. &
            .not. associated(track1_preprocess_ptr) .and. .not. associated(track1_postprocess_ptr) .and. &
            .not. associated(track1_custom_ptr) .and. .not. associated(apply_element_edge_kick_hook_ptr))

j0 = 0
if (use_memo) then
  do j = 1, soa%n
    if (soa%state(j) == alive$) then
      j0 = j
      exit
    endif
  enddo
  if (j0 == 0) return

  call multipole_memo_begin ()
  call track1_one (j0)
  call multipole_memo_freeze ()
endif

!$OMP parallel do if (thread_safe) schedule(static, 64)
do j = 1, soa%n
  if (j == j0) cycle
  if (soa%state(j) /= alive$) cycle
  call track1_one (j)
enddo
!$OMP end parallel do

if (use_memo) call multipole_memo_end ()

!------------------------
contains

subroutine track1_one (i)

type (coord_struct) orb
integer i

orb = bunch%particle(i)
orb%vec = [soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%z(i), soa%pz(i)]
orb%s = soa%s(i);  orb%t = soa%t(i);  orb%p0c = soa%p0c(i);  orb%beta = soa%beta(i)
orb%state = soa%state(i);  orb%location = soa%location(i)
orb%ix_ele = soa%ix_ele(i);  orb%ix_branch = soa%ix_branch(i)
if (soa%has_spin) orb%spin = soa%spin(:, i)

call track1 (orb, ele, param, orb)

bunch%particle(i) = orb
soa%x(i) = orb%vec(1);  soa%px(i) = orb%vec(2);  soa%y(i) = orb%vec(3);  soa%py(i) = orb%vec(4)
soa%z(i) = orb%vec(5);  soa%pz(i) = orb%vec(6)
soa%s(i) = orb%s;  soa%t(i) = orb%t;  soa%p0c(i) = orb%p0c;  soa%beta(i) = orb%beta
soa%state(i) = orb%state;  soa%location(i) = orb%location
soa%ix_ele(i) = orb%ix_ele;  soa%ix_branch(i) = orb%ix_branch
soa%charge(i) = orb%charge;  soa%species(i) = orb%species;  soa%field(:, i) = orb%field
soa%direction(i) = orb%direction;  soa%time_dir(i) = orb%time_dir
if (soa%has_spin) soa%spin(:, i) = orb%spin

end subroutine track1_one

end subroutine fast_track1_soa_fallback

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
call fast_slice_prepare (ele, param, fs, err, reason)
if (err) then
  call fast_note_why (ele, reason, why)
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
    fast_track_device = ''
    if (val == 'metal' .or. val == 'cuda') fast_track_device = val
    call get_environment_variable ('BMAD_FAST_TRACK_FP32', val, status = stat)
    fast_track_fp32_proxy = (stat == 0 .and. val /= '' .and. val /= '0')
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
  case (fast_lcav_std$)
    call track_block_lcav_std (soa, fs, i0, i1)
  end select
enddo
!$OMP end parallel do

if (fast_track_fp32_proxy) call soa_round_fp32 (soa)

end subroutine fast_track_soa

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine soa_round_fp32 (soa)
!
! Routine to round the phase space coordinates of a SoA bunch to single precision (see fast_track_fp32_proxy).
!
! Input:
!   soa   -- bunch_soa_struct.
!
! Output:
!   soa   -- bunch_soa_struct: %x, %px, %y, %py, %z, %pz rounded to real32 and widened back.
!-

subroutine soa_round_fp32 (soa)

use, intrinsic :: iso_fortran_env, only: real32

type (bunch_soa_struct) soa
integer i

!$OMP parallel do if (soa%n > 10000)
do i = 1, soa%n
  soa%x(i)  = real(real(soa%x(i),  real32), rp);  soa%px(i) = real(real(soa%px(i), real32), rp)
  soa%y(i)  = real(real(soa%y(i),  real32), rp);  soa%py(i) = real(real(soa%py(i), real32), rp)
  soa%z(i)  = real(real(soa%z(i),  real32), rp);  soa%pz(i) = real(real(soa%pz(i), real32), rp)
enddo
!$OMP end parallel do

end subroutine soa_round_fp32

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
  if (fs%rad_on_edge(1)) call radiation_lane (soa, fs, i, 1)
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
  if (fs%rad_on_edge(2)) then
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

if (fs%rad_damp_edge(ie)) then
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

if (fs%rad_fluct_edge(ie)) then
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
  if (fs%fr_on(1)) then
    call bend_fringe_lane (soa, fs, i, 1, lost)
    if (lost) cycle
    call orbit_too_large_lane (soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%pz(i), fs%max_ap, soa%state(i), too_large)
    if (too_large) cycle
  endif
  do n = 1, fs%n_step
    call bend_body_lane (soa, fs, i, lost)
    if (lost) exit
  enddo
  if (lost) cycle
  call orbit_too_large_lane (soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%pz(i), fs%max_ap, soa%state(i), too_large)
  if (too_large) cycle
  if (fs%fr_on(2)) then
    call bend_fringe_lane (soa, fs, i, 2, lost)
    if (lost) cycle
  endif
  call add_time2 (soa, i, fs%delta_ref_time, (z0 - soa%z(i)) / (soa%beta(i) * c_light))
enddo

call exit_block (soa, fs, i0, i1, go)

end subroutine track_block_bend

!--------------------------------------------------------------------------
! Bend fringe parameters of a slice: which edges kick (fringe_here with the slice's fringe_at, which
! makeup_super_slave1 sets from the ends the slice contains) and the per-edge angle and fint * hgap.

subroutine bend_fringe_setup (ele, fs)

type (ele_struct) ele
type (fast_slice_struct) fs
integer fringe_type, fringe_at

fringe_type = nint(ele%value(fringe_type$))
fringe_at = nint(ele%value(fringe_at$))
fs%fr_type = 0
fs%fr_on = .false.
if (fringe_type == none$) return
fs%fr_on(1) = at_this_ele_end(entrance_end$, fringe_at)
fs%fr_on(2) = at_this_ele_end(exit_end$, fringe_at)
if (.not. any(fs%fr_on)) return
select case (fringe_type)
case (full$);                       fs%fr_type = 1
case (basic_bend$, hard_edge_only$); fs%fr_type = 2
end select
fs%fr_e = [ele%value(e1$), ele%value(e2$)]
fs%fr_fg = [ele%value(fint$) * ele%value(hgap$), ele%value(fintx$) * ele%value(hgapx$)]
if (fringe_type == hard_edge_only$) fs%fr_fg = 0
if (ele%is_on) then
  fs%fr_g = ele%value(g$) + ele%value(dg$)
else
  fs%fr_g = 0
endif
fs%fr_g_dir = fs%fr_g * fs%charge_dir
fs%fr_beta0 = ele%value(p0c$) / ele%value(e_tot$)

end subroutine bend_fringe_setup

!--------------------------------------------------------------------------
! bend_edge_kick at edge ie (1 = first track edge, 2 = second) for a forward particle, k1 = 0.
! The time is left to the caller (track_a_bend recomputes t from the net change of z).

subroutine bend_fringe_lane (soa, fs, i, ie, lost)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
real(rp) vec(6), e, fg, g, beta0, rel_p
real(rp) f, c_y2, c_x3, c_xy2, c_b, cos_e, sin_e, tan_e, sec_e, b_sign
integer i, ie
logical lost, err

lost = .false.
vec = [soa%x(i), soa%px(i), soa%y(i), soa%py(i), soa%z(i), soa%pz(i)]
e = fs%fr_e(ie);  fg = fs%fr_fg(ie);  beta0 = fs%fr_beta0

select case (fs%fr_type)
case (1)
  ! exact_bend_edge_kick
  g = fs%fr_g
  if (ie == 1) then
    call wedger_lane (e, 0.0_rp, beta0, vec, err)
    if (err) then; call exit_lost; return; endif
    call fringe_dipoler_lane (vec, g, beta0, fg, 1, err)
    if (err) then; call exit_lost; return; endif
    call wedger_lane (-e, g, beta0, vec, err)
    if (err) then; call exit_lost; return; endif
  else
    call wedger_lane (-e, g, beta0, vec, err)
    if (err) then; call exit_lost; return; endif
    call fringe_dipoler_lane (vec, g, beta0, fg, 2, err)
    if (err) then; call exit_lost; return; endif
    call wedger_lane (e, 0.0_rp, beta0, vec, err)
    if (err) then; call exit_lost; return; endif
  endif

case (2)
  ! hwang_bend_edge_kick with k1 = 0, time_dir = 1.
  g = fs%fr_g_dir
  b_sign = merge(1.0_rp, -1.0_rp, ie == 1)
  cos_e = cos(e);  sin_e = sin(e);  tan_e = sin_e / cos_e;  sec_e = 1 / cos_e
  f = g * tan_e
  c_y2 = fg * g**2 * sec_e**3 * (1 + sin_e**2)
  c_x3 = -g**2 * tan_e**3 / 12
  c_xy2 = g**2 * tan_e * sec_e**2 / 4
  c_b = b_sign * g / 2
  rel_p = 1 + vec(6)
  call k_kick (0.5_rp)
  call b1_flow (c_b * tan_e**2, err);  if (err) then; soa%state(i) = lost$; lost = .true.; return; endif
  call b2_flow (-c_b * sec_e**2)
  call b3_flow (-2 * c_b * tan_e**2)
  call k_kick (0.5_rp)
end select

soa%x(i) = vec(1);  soa%px(i) = vec(2);  soa%y(i) = vec(3);  soa%py(i) = vec(4);  soa%z(i) = vec(5);  soa%pz(i) = vec(6)

!------------------------
contains

subroutine exit_lost
soa%state(i) = lost_pz$
lost = .true.
end subroutine exit_lost

subroutine k_kick (a)
real(rp) a, x, y, q, qx, qy
x = vec(1); y = vec(3)
q  = c_y2 * y**2 + c_x3 * x**3 + c_xy2 * x * y**2
qx = 3 * c_x3 * x**2 + c_xy2 * y**2
qy = 2 * c_y2 * y + 2 * c_xy2 * x * y
vec(2) = vec(2) + a * (f * x + qx / rel_p)
vec(4) = vec(4) + a * (-f * y + qy / rel_p)
vec(5) = vec(5) + a * q / rel_p**2
end subroutine k_kick

subroutine b1_flow (c, err)
real(rp) c, b, u, x, px
logical err
b = c / rel_p
x = vec(1); px = vec(2)
u = 1 + b * x
err = (u <= 0)
if (err) return
vec(1) = x / u
vec(2) = px * u**2
vec(5) = vec(5) + b * x**2 * px / rel_p
end subroutine b1_flow

subroutine b2_flow (c)
real(rp) c, b, y, px
b = c / rel_p
y = vec(3); px = vec(2)
vec(1) = vec(1) - b * y**2
vec(4) = vec(4) + 2 * b * y * px
vec(5) = vec(5) + b * y**2 * px / rel_p
end subroutine b2_flow

subroutine b3_flow (c)
real(rp) c, b, ex, x, y, py
b = c / rel_p
x = vec(1); y = vec(3); py = vec(4)
ex = exp(-b * x)
vec(2) = vec(2) + b * y * py
vec(3) = y * ex
vec(4) = py / ex
vec(5) = vec(5) + b * x * y * py / rel_p
end subroutine b3_flow

end subroutine bend_fringe_lane

!--------------------------------------------------------------------------
! bmad_wedger (bmad_rot_xz for g_tot = 0) without the matrix.

subroutine wedger_lane (a, g_tot, beta0, vec, err)

real(rp) a, g_tot, beta0, vec(6)
real(rp) b1, x, px, py, pp, ps, pt, ca, sa, s2a, s2, pxn, psn, den, num, L
logical err

err = .true.
b1 = g_tot
x = vec(1); px = vec(2); py = vec(4)
pp = 1 + vec(6)
ps = pp**2 - px**2 - py**2
if (ps <= 0) return
ps = sqrt(ps)
ca = cos(a); sa = sin(a)

if (b1 == 0) then
  den = ps*ca - px*sa
  L = x*sa/den
  vec(1) = x*ps/den
  vec(2) = px*ca + ps*sa
  vec(3) = vec(3) + py*L
  vec(5) = vec(5) - pp*L
  err = .false.
  return
endif

pt = pp**2 - py**2
if (pt < 1e-10) return
pt = sqrt(pt)
s2a = sin(2.0_rp*a); s2 = sa**2
pxn = px*ca + (ps - b1*x)*sa
psn = pt**2 - pxn**2
if (psn < 1e-10) return
psn = sqrt(psn)
den = psn + ps*ca - px*sa
num = x*px*s2a + s2*(2*x*ps - b1*x**2)
L = (a + asin(px/pt) - asin(pxn/pt)) / b1
vec(1) = x*ca + num/den
vec(2) = pxn
vec(3) = vec(3) + py*L
vec(5) = vec(5) - pp*L
err = .false.

end subroutine wedger_lane

!--------------------------------------------------------------------------
! bmad_fringe_dipoler without the matrix. particle_at: 1 = first track edge, 2 = second.

subroutine fringe_dipoler_lane (vec, g_tot, beta0, fint_hgap, particle_at, err)

real(rp) vec(6), g_tot, beta0, fint_hgap
real(rp) b, x, px, y, py, z, pp, ee, beta, ps, xp, yp, kap, fac2
real(rp) d(3,3), fi(3), fi0, fi0t, co1, co2, bb1, bb2, bb3, ynew, sq
integer particle_at
logical err

err = .true.
b = merge(g_tot, -g_tot, particle_at == 1)
x = vec(1); px = vec(2); y = vec(3); py = vec(4); z = vec(5)
pp = 1 + vec(6)
ps = pp**2 - px**2 - py**2
if (ps <= 0) return
ps = sqrt(ps)
ee = sqrt(pp**2 + 1/beta0**2 - 1)
beta = pp / ee
xp = px/ps; yp = py/ps
kap = b*fint_hgap
fac2 = 1 + yp**2
d(1,1) = (1+xp**2)/ps;  d(2,1) = xp*yp/ps;      d(3,1) = -xp
d(1,2) = xp*yp/ps;      d(2,2) = fac2/ps;       d(3,2) = -yp
d(1,3) = -ee*xp/ps**2;  d(2,3) = -ee*yp/ps**2;  d(3,3) = ee/ps
fi0 = atan(xp/fac2) - 2*kap*(1 + xp**2*(2+yp**2))*ps
co2 = b/cos(fi0)**2
co1 = co2/(1 + (xp/fac2)**2)
fi(1) = co1/fac2 - 4*kap*co2*xp*(2+yp**2)*ps
fi(2) = -2*co1*xp*yp/fac2**2 - 4*kap*co2*xp**2*yp*ps
fi(3) = -2*kap*co2*(1 + xp**2*(2+yp**2))
fi0t = b*tan(fi0)
bb2 = fi(1)*d(1,2) + fi(2)*d(2,2) + fi(3)*d(3,2)
sq = 1 - 2*bb2*y
if (sq < 0) return
sq = sqrt(sq)
ynew = 2*y/(1 + sq)
bb1 = fi(1)*d(1,1) + fi(2)*d(2,1) + fi(3)*d(3,1)
bb3 = fi(1)*d(1,3) + fi(2)*d(2,3) + fi(3)*d(3,3)
vec(1) = x + 0.5_rp*bb1*ynew**2
vec(3) = ynew
vec(4) = py - fi0t*ynew
vec(5) = z + 0.5_rp*beta*bb3*ynew**2
err = .false.

end subroutine fringe_dipoler_lane

!--------------------------------------------------------------------------
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
! track1_bmad lcavity$ branch with n_rf_steps > 0: track_a_lcavity for a forward particle, without
! multipoles, solenoid field, coupler kick or spin. The RF phase uses the particle time relative to the
! block's first live particle in double precision (one quad precision modulo per block instead of one per
! particle per stair step); the time itself is advanced in quad precision as track_a_drift does.

subroutine track_block_lcav_std (soa, fs, i0, i1)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
real(qp) t_ref
real(rp) m_ref
integer i0, i1, i
logical go(i0:i1)

call entrance_block (soa, fs, i0, i1, go)

t_ref = 0;  m_ref = 0
if (fs%rf_abs) then
  do i = i0, i1
    if (.not. go(i)) cycle
    t_ref = soa%t(i)
    m_ref = modulo2(soa%t(i), 0.5_qp / fs%rf_freq) - fs%rf_ref_shift
    exit
  enddo
endif

do i = i0, i1
  if (go(i)) call lcav_std_lane (soa, fs, i, t_ref, m_ref)
enddo

call exit_block (soa, fs, i0, i1, go)

end subroutine track_block_lcav_std

!--------------------------------------------------------------------------

subroutine lcav_std_lane (soa, fs, i, t_ref, m_ref)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
real(qp) t_ref, dq
real(rp) m_ref, phase, mc2, d0, t_acc
integer i, k, fl

mc2 = fs%mass
! Particle time relative to the block reference: exact at the start, then the increments in double.
d0 = 0;  t_acc = 0
if (fs%rf_abs) then
  dq = soa%t(i) - t_ref
  if (abs(dq) > 0.5_qp / fs%rf_freq) dq = modulo2(dq, 0.5_qp / fs%rf_freq)   ! Keeps d0 small (exact phase).
  d0 = real(dq, rp)
endif
if (fs%offset_on) call offset_set_lane (soa, fs, i, t_acc)

do k = 1, fs%rf_n
  call drift_lane (soa, fs, i, fs%rf_ds(k), .true., t_acc)
  if (soa%state(i) /= alive$) return
  fl = fs%rf_flags(k)
  if (btest(fl, 0)) then
    phase = rf_phase(k)
    call fringe_kick (1.0_rp)
    if (soa%state(i) /= alive$) return
  endif
  if (btest(fl, 1)) then
    if (btest(fl, 3)) call pondermotive_kick ()
    phase = rf_phase(k)
    call energy_kick (k)
    if (soa%state(i) /= alive$) return
    if (btest(fl, 4)) call pondermotive_kick ()
  endif
  if (btest(fl, 2)) then
    phase = rf_phase(k)
    call fringe_kick (-1.0_rp)
    if (soa%state(i) /= alive$) return
  endif
enddo

if (fs%offset_on) call offset_unset_lane (soa, fs, i, t_acc)

!------------------------
contains

! this_rf_phase
function rf_phase (k) result (ph)
integer k
real(rp) ph, particle_time
if (fs%rf_abs) then
  particle_time = m_ref + (d0 + t_acc)
  particle_time = particle_time - fs%rf_tm(k)
else
  particle_time = -soa%z(i) / (soa%beta(i) * c_light) + fs%rf_ts(k) - fs%rf_tm(k)
endif
ph = twopi * (fs%rf_phi0 + particle_time * fs%rf_freq)
ph = modulo2(ph, pi)
end function rf_phase

! this_energy_kick (s_dir = 1, no multipoles), to_energy_coords, to_momentum_coords and
! orbit_reference_energy_correction.
subroutine energy_kick (k)
integer k
real(rp) dE, rel_p, pc_start, pz_end, p0c, p1c, pc, v6, p_rel
p0c = soa%p0c(i)
dE = fs%rf_volt * fs%rf_scale(k) * fs%rf_fauto * cos(phase)
rel_p = 1 + soa%pz(i)
pc_start = rel_p * p0c
if (sqrt(pc_start**2 + mc2**2) + dE <= mc2) then
  soa%state(i) = lost_pz$
  return
endif
pz_end = soa%pz(i) + dpc_given_dE(p0c*rel_p, mc2, dE) / p0c
soa%z(i) = soa%z(i) / soa%beta(i)
v6 = (1 + soa%pz(i)) / soa%beta(i)
v6 = v6 + dE / p0c
pc = (1 + pz_end) * p0c
soa%beta(i) = pc / (p0c * v6)
soa%z(i) = soa%z(i) * soa%beta(i)
soa%pz(i) = pz_end
p1c = fs%rf_p1c(k)
p_rel = p0c / p1c
soa%px(i) = soa%px(i) * p_rel
soa%py(i) = soa%py(i) * p_rel
soa%pz(i) = (soa%pz(i) * p0c - (p1c - p0c)) / p1c
soa%p0c(i) = p1c
end subroutine energy_kick

! this_pondermotive_transverse_kick (body_dir = time_dir = 1).
subroutine pondermotive_kick ()
real(rp) coef, rel_p, dz
rel_p = 1.0_rp + soa%pz(i)
coef = fs%rf_pond / (16.0_rp * soa%p0c(i)**2 * rel_p * fs%rf_nstep)
soa%px(i) = soa%px(i) - coef * soa%x(i)
soa%py(i) = soa%py(i) - coef * soa%y(i)
dz = -0.5_rp * coef * (soa%x(i)**2 + soa%y(i)**2) / rel_p
soa%z(i) = soa%z(i) + dz
call add_time (soa, i, -dz / (c_light * soa%beta(i)))
t_acc = t_acc - dz / (c_light * soa%beta(i))
end subroutine pondermotive_kick

! fringe_kick (body_dir = time_dir = 1), edge = +1 entrance, -1 exit.
subroutine fringe_kick (edge)
real(rp) edge, ff, f, pc, ez_field, dez_dz_field, dE, pz_end, p0c, v6, pcn
p0c = soa%p0c(i)
ff = edge * fs%rf_ff
f = ff / p0c
pc = p0c * (1 + soa%pz(i))
ez_field = fs%rf_grad * cos(phase)
dez_dz_field = fs%rf_grad * sin(phase) * fs%rf_omega
dE = -ff * 0.5_rp * dez_dz_field * (soa%x(i)**2 + soa%y(i)**2)
if (sqrt(pc**2 + mc2**2) + dE <= mc2) then
  soa%state(i) = lost_pz$
  return
endif
pz_end = soa%pz(i) + dpc_given_dE(pc, mc2, dE) / p0c
soa%z(i) = soa%z(i) / soa%beta(i)
v6 = (1 + soa%pz(i)) / soa%beta(i)
soa%px(i) = soa%px(i) - f * ez_field * soa%x(i)
soa%py(i) = soa%py(i) - f * ez_field * soa%y(i)
v6 = v6 + dE / p0c
pcn = (1 + pz_end) * p0c
soa%beta(i) = pcn / (p0c * v6)
soa%z(i) = soa%z(i) * soa%beta(i)
soa%pz(i) = pz_end
end subroutine fringe_kick

end subroutine lcav_std_lane

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

subroutine drift_lane (soa, fs, i, length, do_time, dt_sum)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs

real(rp) length, delta, rel_pc, px_rel, py_rel, pxy2, ps_rel, dz, dt, mc2
real(rp), optional :: dt_sum
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
    if (present(dt_sum)) dt_sum = dt_sum + dt
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

subroutine offset_set_lane (soa, fs, i, dt_sum)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
real(rp), optional :: dt_sum

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
if (abs(ds) > 1d-14 .and. soa%state(i) == alive$) call offset_drift_lane (soa, i, ds, dt_sum)

if (fs%do_tilt .and. fs%tilt_tot /= 0) call tilt_lane (soa, i, fs%cos_t, fs%sin_t)

end subroutine offset_set_lane

!--------------------------------------------------------------------------
! offset_particle, unset$, mirror of offset_set_lane.

subroutine offset_unset_lane (soa, fs, i, dt_sum)

type (bunch_soa_struct) soa
type (fast_slice_struct) fs
real(rp), optional :: dt_sum

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
if (abs(ds) > 1d-14 .and. soa%state(i) == alive$) call offset_drift_lane (soa, i, ds, dt_sum)

end subroutine offset_unset_lane

!--------------------------------------------------------------------------
! track_a_drift (orbit, ds, ele_orientation = 1, include_ref_motion = .false.)
! The time update in track_a_drift is not applied: track_a_quadrupole overwrites orbit%t.

subroutine offset_drift_lane (soa, i, length, dt_sum)

type (bunch_soa_struct) soa
real(rp), optional :: dt_sum
real(rp) dt
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
! track_a_drift (include_ref_motion = False) also advances t; the kernels that get t from the net z
! change leave it out (dt_sum absent).
if (present(dt_sum) .and. soa%beta(i) > 0) then
  dt = rel_z_vel * length / (soa%beta(i) * ps_rel * c_light)
  call add_time (soa, i, dt)
  dt_sum = dt_sum + dt
endif

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
! Time updates, identical to Bmad: t = t + dt  (drift)  and  t = (t + a) + b  (quadrupole).

subroutine add_time (soa, i, dt)

type (bunch_soa_struct) soa
real(rp) dt
integer i

soa%t(i) = qp_add_dp(soa%t(i), dt)

end subroutine add_time

subroutine add_time2 (soa, i, a, b)

type (bunch_soa_struct) soa
real(rp) a, b
integer i

soa%t(i) = qp_add_dp(qp_add_dp(soa%t(i), a), b)

end subroutine add_time2

!--------------------------------------------------------------------------
! t + d as the quad precision add computes it (round to nearest even), done in integer arithmetic for the
! common case of a normal t and a normal d with |d| < |t|/2, which avoids the cost of the software quad
! precision add (mostly in raising the floating point exception flags). Other cases use the quad add.

elemental function qp_add_dp (t, d) result (r)

real(qp), intent(in) :: t
real(rp), intent(in) :: d
real(qp) r
integer, parameter :: i16 = selected_int_kind(38)
integer(i16) bt, mt, x, xd, one
integer(int64) bd, md
integer et, ed, diff, sh, low

if (d == 0) then
  r = t
  if (t == 0) r = t + d   ! Sign of zero.
  return
endif

bt = transfer(t, bt)
bd = transfer(d, bd)
et = int(iand(shiftr(bt, 112), int(z'7FFF', i16)))   ! Biased exponents
ed = int(iand(shiftr(bd, 52), int(z'7FF', int64)))
diff = (et - 16383) - (ed - 1023)

if (et == 0 .or. et == 32767 .or. ed == 0 .or. ed == 2047 .or. diff < 2) then
  r = t + d
  return
endif

! Significands, with t's scaled by 8 for guard, round and sticky bits: units of 2^(exponent(t)-116).

one = 1
mt = ior(iand(bt, shiftl(one, 112) - 1), shiftl(one, 112))
md = ior(iand(bd, shiftl(1_int64, 52) - 1), shiftl(1_int64, 52))
x = shiftl(mt, 3)
sh = 63 - diff
if (sh >= 0) then
  xd = shiftl(int(md, i16), sh)
elseif (sh <= -64) then
  xd = 1
else
  xd = shiftr(int(md, i16), -sh)
  if (iand(md, shiftl(1_int64, -sh) - 1) /= 0) xd = ior(xd, one)
endif

if ((bt < 0) .eqv. (bd < 0)) then
  x = x + xd
else
  x = x - xd
endif

if (x >= shiftl(one, 116)) then
  x = ior(shiftr(x, 1), iand(x, one))
  et = et + 1
elseif (x < shiftl(one, 115)) then
  x = shiftl(x, 1)
  et = et - 1
endif

low = int(iand(x, 7_i16))
x = shiftr(x, 3)
if (low > 4 .or. (low == 4 .and. iand(x, one) == 1)) then
  x = x + 1
  if (x == shiftl(one, 113)) then
    x = shiftr(x, 1)
    et = et + 1
  endif
endif

if (et <= 0 .or. et >= 32767) then
  r = t + d
  return
endif

x = ior(iand(x, shiftl(one, 112) - 1), shiftl(int(et, i16), 112))
if (bt < 0) x = ior(x, shiftl(one, 127))
r = transfer(x, r)

end function qp_add_dp

!--------------------------------------------------------------------------
! The quad precision value rounded to double (nearest even), in integer arithmetic: the software
! conversion raises the inexact flag, which costs more than the rest of a statistics loop.

elemental function qp_to_dp (t) result (d)

real(qp), intent(in) :: t
real(rp) d
integer, parameter :: i16 = selected_int_kind(38)
integer(i16) bt, m, low, half, one
integer(int64) md, bd
integer et, ed

bt = transfer(t, bt)
et = int(iand(shiftr(bt, 112), int(z'7FFF', i16)))
if (et < 16383 - 1021 .or. et > 16383 + 1023) then   ! Zero, tiny, huge, inf, nan: let the compiler do it.
  d = real(t, rp)
  return
endif

one = 1
m = iand(bt, shiftl(one, 112) - 1)
md = int(shiftr(m, 60), int64)
low = iand(m, shiftl(one, 60) - 1)
half = shiftl(one, 59)
if (low > half .or. (low == half .and. iand(md, 1_int64) == 1)) md = md + 1
ed = et - 16383 + 1023
if (md == shiftl(1_int64, 52)) then
  md = 0;  ed = ed + 1
endif
if (ed >= 2047) then
  d = real(t, rp)
  return
endif
bd = ior(shiftl(int(ed, int64), 52), md)
if (bt < 0) bd = ior(bd, shiftl(1_int64, 63))
d = transfer(bd, d)

end function qp_to_dp

end module bunch_soa_mod
