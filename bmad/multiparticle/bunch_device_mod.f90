!+
! Module bunch_device_mod
!
! The only Fortran caller of the device seam (bmad/gpu/bmad_device.h): GPU backends for the collective
! effect kernels (and later the tracking kernels), selected with BMAD_FAST_TRACK=metal (or cuda). This
! module owns every conversion to and from the backend's float32 arrays and reports refusals; the rest of
! Bmad asks bunch_device_on() and calls the bunch_device_* routines, falling back to the CPU path whenever
! they decline (done = False).
!
! Supported today: the 3D free-space space charge kick of apply_fft_3d_kicks. Deposit, Poisson solve,
! interpolation and kick run on the device in single precision; the integrated Green functions are
! evaluated in double precision on the host (osc_get_rgrn_freespace) and transformed on the device
! whenever the mesh spacing or gamma changes. The deposit is fixed point, so runs are deterministic.
!-

module bunch_device_mod

use bmad_interface
use open_spacecharge_mod, only: mesh3d_struct, osc_get_rgrn_freespace, osc_mesh_resize, osc_mesh_resize_bounds, &
                                osc_ordered_sum, deposit_particles, space_charge_3d, interpolate_field_batch
use bunch_soa_mod, only: fast_track_enabled, fast_track_device, bunch_soa_struct, fast_slice_struct, fast_slice_prepare, &
                         fast_none$, fast_drift$, fast_quad$, fast_thick$, fast_bend$, fast_lcav$, fast_lcav_std$, fast_max_ap, qp_add_dp
use random_mod, only: ran_seed_get
use beam_utils, only: calc_emittances_and_twiss_from_sigma_matrix
use, intrinsic :: iso_c_binding
!$ use omp_lib, only: omp_in_parallel

implicit none

! Mirror of bmad_dev_sc_par in bmad/gpu/bmad_device.h. Change both together.
type, bind(c) :: bmad_dev_sc_par_struct
  real(c_double) :: mesh_min(3), delta(3), gamma, kick_scale, grn_scale, q_total_abs, dct_ave, track_step, mass
  integer(c_int32_t) :: n, pad(3)
end type

! Mirror of bmad_dev_slice_par in bmad/gpu/bmad_device.h. Change both together (and the SlicePar shader struct).
type, bind(c) :: bmad_dev_slice_par_struct
  integer(c_int32_t) :: kind, n_step, ix_mag_max, offset_on, do_tilt, is_misaligned
  integer(c_int32_t) :: n_ap0, n_ap1
  integer(c_int32_t) :: rad_damp0, rad_damp1, rad_fluct0, rad_fluct1, rad_damp_vec
  integer(c_int32_t) :: ele_tag
  integer(c_int32_t) :: rng_seed, rng_ctr
  real(c_float) :: length, s_start, s_end, p0c_ele, e_tot_ele, mass, max_ap
  real(c_float) :: charge_dir, b1, r_step, step_len, ab_f
  real(c_float) :: an(22), bn(22), cm(484)
  real(c_float) :: tilt_tot, cos_t, sin_t, cos_mt, sin_mt
  real(c_float) :: x_off, y_off, z_off, zc_set, l_half, ds_center_unset, s_target_set, s_target_unset
  real(c_float) :: w_inv(9), w_mat(9)
  integer(c_int32_t) :: ap_type(8)
  real(c_float) :: ap_lim(64)
  real(c_float) :: g, dg, g_tot, angle, beta_ref, sinc_a, cos_a, sin_a, cosc_a, sincc_a
  real(c_float) :: rad_scale
  real(c_float) :: rad_ref(12), rad_dmat(72), rad_dvec(12), rad_smat(72)
  integer(c_int32_t) :: lc_abs_time, lc_long_mode, lc_travel, lc_ap_cont, lc_max_steps, lc_kick
  real(c_float) :: lc_grad, lc_k, lc_omega, lc_phase, lc_s_off, lc_l_active, lc_time0, lc_inv_cb0, lc_ib0m1, lc_edge1
  real(c_float) :: lc_edge2, lc_zk, lc_rel_tol, lc_abs_tol, lc_init_ds, lc_min_ds, lc_fatal_ds, lc_ds_tiny, lc_charge, lc_rel_floor
  integer(c_int32_t) :: fr_type, fr_on
  real(c_float) :: fr_e(2), fr_fg(2), fr_g, fr_g_dir, fr_beta0, fr_pad
  integer(c_int32_t) :: rf_n, rf_abs
  real(c_float) :: rf_grad, rf_omega_e, rf_omega_t, rf_ff, rf_p0c_end, rf_pad
end type

! Mirror of bmad_dev_rf_step.
type, bind(c) :: bmad_dev_rf_step_struct
  real(c_float) :: ds = 0, cphase = 0, damp = 0, rr = 0, dd = 0, cpond = 0, p0c = 0
  integer(c_int32_t) :: flags = 0
end type
integer, parameter, private :: dev_max_rf = 120

! Mirror of bmad_dev_csr_par.
type, bind(c) :: bmad_dev_csr_par_struct
  real(c_double) :: z_min, dz_slice, dz_particle, scale(4), zc1
  integer(c_int32_t) :: n_bin, pbs, pass, pad
end type

interface
  function bmad_dev_csr_step (mass, n_bin, pbs, n_bin_eff, out_stats, out_layout, out1, out2, reason, reason_len) &
                                                                      bind(c, name = 'bmad_dev_csr_step') result (ierr)
    import :: c_char, c_int, c_double
    real(c_double), value :: mass
    integer(c_int), value :: n_bin, pbs, n_bin_eff
    real(c_double) :: out_stats(*), out_layout(*), out1(*), out2(*)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_moments (pass, mass, avg, out, reason, reason_len) bind(c, name = 'bmad_dev_bunch_moments') result (ierr)
    import :: c_char, c_int, c_double
    integer(c_int), value :: pass, reason_len
    real(c_double), value :: mass
    real(c_double) :: avg(*), out(*)
    character(kind=c_char) :: reason(*)
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_stats (mass, dct, out, reason, reason_len) bind(c, name = 'bmad_dev_bunch_stats') result (ierr)
    import :: c_char, c_int, c_double
    real(c_double), value :: mass, dct
    real(c_double) :: out(9)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_csr_kick (par, kick, reason, reason_len) bind(c, name = 'bmad_dev_csr_kick') result (ierr)
    import :: c_char, c_int, c_float, bmad_dev_csr_par_struct
    type (bmad_dev_csr_par_struct) :: par
    real(c_float) :: kick(*)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_upload (n, x, px, y, py, z, pz, state, q, p0c, reason, reason_len) &
                                                              bind(c, name = 'bmad_dev_bunch_upload') result (ierr)
    import :: c_char, c_int, c_float, c_int32_t
    integer(c_int), value :: n, reason_len
    real(c_float) :: x(*), px(*), y(*), py(*), z(*), pz(*), q(*), p0c(*)
    integer(c_int32_t) :: state(*)
    character(kind=c_char) :: reason(*)
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_download (n, x, px, y, py, z, pz, state, loc, lost_tag, p0c, reason, reason_len) &
                                                              bind(c, name = 'bmad_dev_bunch_download') result (ierr)
    import :: c_char, c_int, c_float, c_int32_t
    integer(c_int), value :: n, reason_len
    real(c_float) :: x(*), px(*), y(*), py(*), z(*), pz(*), p0c(*)
    integer(c_int32_t) :: state(*), loc(*), lost_tag(*)
    character(kind=c_char) :: reason(*)
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_set_tz0 (n, tz0, reason, reason_len) bind(c, name = 'bmad_dev_bunch_set_tz0') result (ierr)
    import :: c_char, c_int, c_float
    integer(c_int), value :: n, reason_len
    real(c_float) :: tz0(*)
    character(kind=c_char) :: reason(*)
    integer(c_int) :: ierr
  end function
  function bmad_dev_track_slice (par, rf, reason, reason_len) bind(c, name = 'bmad_dev_track_slice') result (ierr)
    import :: c_char, c_int, bmad_dev_slice_par_struct, bmad_dev_rf_step_struct
    type (bmad_dev_slice_par_struct) :: par
    type (bmad_dev_rf_step_struct) :: rf(*)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_sums (mass, out, reason, reason_len) bind(c, name = 'bmad_dev_bunch_sums') result (ierr)
    import :: c_char, c_int, c_double
    real(c_double), value :: mass
    real(c_double) :: out(3)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_bunch_bounds (mass, dct, out, reason, reason_len) bind(c, name = 'bmad_dev_bunch_bounds') result (ierr)
    import :: c_char, c_int, c_double
    real(c_double), value :: mass, dct
    real(c_double) :: out(6)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_sc_step_resident (par, reason, reason_len) bind(c, name = 'bmad_dev_sc_step_resident') result (ierr)
    import :: c_char, c_int, bmad_dev_sc_par_struct
    type (bmad_dev_sc_par_struct) :: par
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_available (backend, reason, reason_len) bind(c, name = 'bmad_dev_available') result (ierr)
    import :: c_char, c_int
    character(kind=c_char) :: backend(*), reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_init (n_max, mesh_n, reason, reason_len) bind(c, name = 'bmad_dev_init') result (ierr)
    import :: c_char, c_int, c_int32_t
    integer(c_int), value :: n_max, reason_len
    integer(c_int32_t) :: mesh_n(3)
    character(kind=c_char) :: reason(*)
    integer(c_int) :: ierr
  end function
  subroutine bmad_dev_close () bind(c, name = 'bmad_dev_close')
  end subroutine
  function bmad_dev_set_green (gx, gy, gz, reason, reason_len) bind(c, name = 'bmad_dev_set_green') result (ierr)
    import :: c_char, c_int, c_float
    real(c_float) :: gx(*), gy(*), gz(*)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_sc_step (par, x, y, z, q, factor, px, py, pz, reason, reason_len) &
                                                              bind(c, name = 'bmad_dev_sc_step') result (ierr)
    import :: c_char, c_int, c_float, bmad_dev_sc_par_struct
    type (bmad_dev_sc_par_struct) :: par
    real(c_float) :: x(*), y(*), z(*), q(*), factor(*), px(*), py(*), pz(*)
    character(kind=c_char) :: reason(*)
    integer(c_int), value :: reason_len
    integer(c_int) :: ierr
  end function
  function bmad_dev_get_field (comp, E, reason, reason_len) bind(c, name = 'bmad_dev_get_field') result (ierr)
    import :: c_char, c_int, c_float
    integer(c_int), value :: comp, reason_len
    real(c_float) :: E(*)
    character(kind=c_char) :: reason(*)
    integer(c_int) :: ierr
  end function
  function bmad_dev_seconds () bind(c, name = 'bmad_dev_seconds') result (t)
    import :: c_double
    real(c_double) :: t
  end function
  subroutine bmad_dev_timing (t) bind(c, name = 'bmad_dev_timing')
    import :: c_double
    real(c_double) :: t(4)
  end subroutine
  function bmad_dev_fault () bind(c, name = 'bmad_dev_fault') result (f)
    import :: c_int
    integer(c_int) :: f
  end function
end interface

logical, private, save :: dev_checked = .false., dev_ok = .false., dev_inited = .false.
logical, private, save :: dev_check = .false.     ! BMAD_DEVICE_CHECK: also run the CPU step and print the difference
integer, private, save :: check_count = 0
integer, private, save :: dev_n_max = 0, dev_mesh_n(3) = 0
real(rp), private, save :: grn_delta(3) = -1, grn_gamma = -1

! Packed live particles (double) and the single precision staging arrays. Reused between calls.
real(rp), allocatable, private, save :: x_pk(:), y_pk(:), z_pk(:), q_pk(:), beta_pk(:), gbuf(:,:,:)
real(c_float), allocatable, private, save :: x32(:), y32(:), z32(:), q32(:), f32(:), px32(:), py32(:), pz32(:)
real(c_float), allocatable, private, save :: g32(:,:,:,:)
integer, allocatable, private, save :: idx_pk(:)

real(rp), parameter, private :: fpei = 299792458.0_rp**2 * 1.00000000055d-7   ! 1/(4 pi eps0), as in osc_freespace_solver2

! Resident bunch. The device copy (float32 x, px, y, py, z, pz, state) and the host SoA copy take turns
! being current; t, s, location and ix_ele are host-side and reconstructed at each download. Slices
! tracked on the device get a tag so a particle lost there can be placed afterwards.
integer, parameter, private :: n_tag_max = 4096
logical, private, save :: res_active = .false., res_dev_current = .false., res_host_current = .true.
integer, private, save :: res_n = 0, res_tag = 0, res_species = 0, res_seed = 0, res_rng_ctr = 0
real(rp), private, save :: res_dt_ref = 0, res_mass = 0
real(rp), private, save :: tag_s_start(n_tag_max) = 0, tag_s_end(n_tag_max) = 0, tag_p0c(n_tag_max) = 0
integer, private, save :: tag_ix_ele(n_tag_max) = 0, tag_ix_branch(n_tag_max) = 0
real(rp), allocatable, private, save :: z_up(:), beta_up(:)
real(c_float), allocatable, private, save :: p0c32(:)
! Time base of the device: t_i - res_t_base - res_dt_ref is the particle's time relative to the reference
! time at the current slice start, and tz0 = t_i - res_t_base + z_i/(beta_i c) (invariant across device
! slices) is kept on the device for the lcavity kernel, computed when first needed after an upload.
real(rp), private, save :: res_t_base = 0
logical, private, save :: tz0_valid = .false.
real(c_float), allocatable, private, save :: tz032(:)
integer(c_int32_t), allocatable, private, save :: st32(:), loc32(:), tag32(:)
! Statistics of the resident bunch (dct = 0), valid until the device changes it.
logical, private, save :: stats_valid = .false.
real(c_double), private, save :: stats9(9) = 0

private :: c_str, from_c, ensure_arrays, ensure_resident_arrays, slice_to_par, device_mesh_setup, tz0_upload

contains

!--------------------------------------------------------------------------
!+
! Function bunch_device_on () result (is_on)
!
! True if BMAD_FAST_TRACK names a device backend ("metal", "cuda") and that backend is loaded and usable.
! The backend is probed once; a refusal is reported once and the CPU path is used from then on.
! Never True inside a parallel region (the device state is shared).
!-

function bunch_device_on () result (is_on)

logical is_on, nested
integer ierr
character(256) reason
character(*), parameter :: r_name = 'bunch_device_on'

!

is_on = .false.
if (.not. fast_track_enabled()) return
if (fast_track_device == '') return

nested = .false.
!$ nested = omp_in_parallel()
if (nested) return

if (.not. dev_checked) then
  dev_checked = .true.
  reason = ''
  if (bmad_dev_available(c_str(fast_track_device), reason, len(reason)) == 0) then
    dev_ok = .true.
    call get_environment_variable ('BMAD_DEVICE_CHECK', reason, status = ierr)
    dev_check = (ierr == 0 .and. reason /= '')
    call out_io (s_info$, r_name, 'Using the ' // trim(fast_track_device) // ' device backend for space charge.')
  else
    call out_io (s_error$, r_name, 'Device backend "' // trim(fast_track_device) // '" not available: ' // &
                                    trim(from_c(reason)), 'Using the CPU path instead.')
  endif
endif

is_on = dev_ok

end function bunch_device_on

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_sc_kick (mesh3d, track_step, growth, shrink, x, y, z, px, py, pz, p0c, beta,
!                                                                         charge, species, state, done)
!
! The 3D free-space space charge kick of apply_fft_3d_kicks on the device. The mesh is fitted to the live
! particles exactly as deposit_particles does (osc_mesh_resize). On the device: deposit, solve,
! interpolate, kick px, py, pz. The new beta and the z rescaling are then done here in double precision.
!
! Input:
!   mesh3d          -- mesh3d_struct: Space charge mesh (%nlo, %nhi, %gamma set).
!   track_step      -- real(rp): csr%actual_track_step.
!   growth, shrink  -- real(rp): space_charge_com%mesh_growth_factor / mesh_shrink_factor.
!   x, y, z, px, py, pz, p0c, beta, charge, species, state -- Particle arrays (all particles), as pointers:
!                      the caller's view may be a strided section of a coord_struct array, and gfortran
!                      drops the stride when such a pointer is passed to an assumed-shape dummy.
!
! Output:
!   mesh3d          -- mesh3d_struct: %min, %max, %delta, %charge updated.
!   px, py, pz, z, beta -- Kicked live particles.
!   done            -- logical: True if the device did the step. False: nothing was changed, use the CPU.
!-

subroutine bunch_device_sc_kick (mesh3d, track_step, growth, shrink, x, y, z, px, py, pz, p0c, beta, &
                                                                                  charge, species, state, done)

type (mesh3d_struct) mesh3d
type (bmad_dev_sc_par_struct) par

real(rp) track_step, growth, shrink
real(rp), pointer :: x(:), y(:), z(:), px(:), py(:), pz(:), p0c(:), beta(:), charge(:)
real(rp) dct_ave, new_beta, qabs
real(rp), allocatable :: part(:)

integer, pointer :: species(:), state(:)
integer n_tot, n, i, k, nb, ib, icomp, nx2, ny2, nz2, mesh_n(3), ierr

logical done
character(256) reason
character(*), parameter :: r_name = 'bunch_device_sc_kick'

!

done = .false.
n_tot = size(x)
call ensure_arrays (n_tot)

n = 0
do i = 1, n_tot
  if (state(i) /= alive$) cycle
  n = n + 1
  x_pk(n) = x(i);  y_pk(n) = y(i);  z_pk(n) = z(i)
  q_pk(n) = charge(i);  beta_pk(n) = beta(i);  idx_pk(n) = i
enddo

if (n == 0) then
  done = .true.
  return
endif

! Relative to the average of (time - time_ref), as apply_fft_3d_kicks: blocked sums added in order.

nb = (n + 4095) / 4096
allocate (part(nb))
!$OMP PARALLEL DO PRIVATE(k) IF (nb > 1)
do ib = 1, nb
  part(ib) = 0
  do k = (ib-1)*4096+1, min(ib*4096, n)
    part(ib) = part(ib) + z_pk(k) / beta_pk(k)
  enddo
enddo
!$OMP END PARALLEL DO
dct_ave = 0
do ib = 1, nb
  dct_ave = dct_ave + part(ib)
enddo
dct_ave = dct_ave / n

!$OMP PARALLEL DO IF (n > 10000)
do k = 1, n
  z_pk(k) = z_pk(k) - dct_ave * beta_pk(k)
enddo
!$OMP END PARALLEL DO

! Mesh geometry, as deposit_particles sets it.

call osc_mesh_resize (x_pk(1:n), y_pk(1:n), z_pk(1:n), mesh3d, growth, shrink)
where (mesh3d%delta == 0) mesh3d%delta = 1d-10
mesh3d%charge = osc_ordered_sum(q_pk(1:n))

call device_mesh_setup (mesh3d, n_tot, .true., ierr)
if (ierr /= 0) then
  done = .false.
  return
endif
mesh_n = mesh3d%nhi - mesh3d%nlo + 1
nx2 = 2 * mesh_n(1);  ny2 = 2 * mesh_n(2);  nz2 = 2 * mesh_n(3)

! Stage the particles in single precision.

qabs = 0
!$OMP PARALLEL DO PRIVATE(i) REDUCTION(+:qabs) IF (n > 10000)
do k = 1, n
  i = idx_pk(k)
  x32(k) = real(x_pk(k), c_float);  y32(k) = real(y_pk(k), c_float);  z32(k) = real(z_pk(k), c_float)
  q32(k) = real(q_pk(k), c_float)
  f32(k) = real(track_step / (p0c(i) * beta(i)), c_float)
  px32(k) = real(px(i), c_float);  py32(k) = real(py(i), c_float);  pz32(k) = real(pz(i), c_float)
  qabs = qabs + abs(q_pk(k))
enddo
!$OMP END PARALLEL DO

par%mesh_min = mesh3d%min
par%delta = mesh3d%delta
par%gamma = mesh3d%gamma
par%kick_scale = 1 / mesh3d%gamma**2
par%grn_scale = fpei / (real(nx2, rp) * real(ny2, rp) * real(nz2, rp))
par%q_total_abs = qabs
par%n = n
par%pad = 0

reason = ''
ierr = bmad_dev_sc_step (par, x32, y32, z32, q32, f32, px32, py32, pz32, reason, len(reason))
if (ierr /= 0) then
  call fail ('Space charge step failed: ' // trim(from_c(reason)))
  return
endif
if (bmad_dev_fault() /= 0) call out_io (s_warn$, r_name, 'Particle outside the space charge mesh on the device.')

! Unpack. The beta update and the z rescaling stay in double precision.

!$OMP PARALLEL DO PRIVATE(i, new_beta) IF (n > 10000)
do k = 1, n
  i = idx_pk(k)
  px(i) = px32(k);  py(i) = py32(k);  pz(i) = pz32(k)
  call convert_pc_to (p0c(i) * (1 + pz(i)), species(i), beta = new_beta)
  z(i) = z(i) * new_beta / beta(i)
  beta(i) = new_beta
enddo
!$OMP END PARALLEL DO

done = .true.
if (dev_check) call check_against_cpu()

!--------------------------
contains

! Debug: redo the step on the CPU (deposit_particles, space_charge_3d, interpolate_field_batch, the kick
! of apply_fft_3d_kicks) from the same packed input and print the difference to the device result.

subroutine check_against_cpu()

type (mesh3d_struct) mc
real(rp), allocatable :: E(:,:), pxc(:), pyc(:), pzc(:)
real(rp) fct, pz0, ef, dpx(3), kr(3), q0
integer k, i

mc%nhi = mesh3d%nhi;  mc%nlo = mesh3d%nlo;  mc%gamma = mesh3d%gamma
allocate (E(3, n), pxc(n), pyc(n), pzc(n))
call deposit_particles (x_pk(1:n), y_pk(1:n), z_pk(1:n), mc, qa = q_pk(1:n), mesh_growth_factor = growth, mesh_shrink_factor = shrink)
call space_charge_3d (mc)
call interpolate_field_batch (x_pk(1:n), y_pk(1:n), z_pk(1:n), mc, n, E = E)
dpx = 0;  kr = 0
do k = 1, n
  i = idx_pk(k)
  fct = real(f32(k), rp)
  pz0 = sqrt((1.0_rp + real(pz32(k), rp))**2 - real(px32(k), rp)**2 - real(py32(k), rp)**2)
  pxc(k) = real(px32(k), rp) + E(1,k) * fct / mesh3d%gamma**2
  pyc(k) = real(py32(k), rp) + E(2,k) * fct / mesh3d%gamma**2
  ef = E(3,k) * fct
  pzc(k) = real(pz32(k), rp) + sqrt_alpha(1 + real(pz32(k), rp), ef*ef + 2 * ef * pz0)
enddo
! px32 etc. now hold the device output (updated in place by sc_step); compare kicks.
kr = 0;  dpx = 0
do k = 1, n
  i = idx_pk(k)
  kr(1) = kr(1) + (pxc(k) - real(px32(k), rp))**2
enddo
print '(a, i6, a, i7, a, 3es11.3, a, 3es11.3, a, 3es10.2)', 'DEVCHECK step ', check_count, ' n ', n, &
      '  delta dev-cpu ', mesh3d%delta - mc%delta, '  min ', mesh3d%min - mc%min, &
      '  rms|dev-cpu| px py pz ', sqrt(sum((real(px32(1:n), rp) - pxc)**2)/n), sqrt(sum((real(py32(1:n), rp) - pyc)**2)/n), &
                                 sqrt(sum((real(pz32(1:n), rp) - pzc)**2)/n)
check_count = check_count + 1

end subroutine check_against_cpu

subroutine fail (msg)
character(*) msg
call out_io (s_warn$, r_name, msg, 'Using the CPU path from now on.')
dev_ok = .false.
end subroutine fail

end subroutine bunch_device_sc_kick

!--------------------------------------------------------------------------
!+
! Function bunch_device_seconds () result (t)
!
! Accumulated device busy time [s].
!-

function bunch_device_seconds () result (t)
real(rp) t
t = 0
if (dev_ok) t = bmad_dev_seconds()
end function bunch_device_seconds

!--------------------------------------------------------------------------
! Device allocation for the mesh of mesh3d and n_tot particles, and the Green functions (double precision on
! the host, transformed on the device, cached by (delta, gamma)). A reallocation discards the resident
! bunch, so it is brought to the host first. ierr /= 0: reported, device switched off.

subroutine device_mesh_setup (mesh3d, n_tot, with_green, ierr)

type (mesh3d_struct) mesh3d
integer n_tot, ierr, mesh_n(3), nx2, ny2, nz2, icomp
logical with_green
character(256) reason
character(*), parameter :: r_name = 'device_mesh_setup'

ierr = 0
mesh_n = mesh3d%nhi - mesh3d%nlo + 1
if (.not. dev_inited .or. any(mesh_n /= dev_mesh_n) .or. n_tot > dev_n_max) then
  if (res_active .and. res_dev_current) then
    call out_io (s_error$, r_name, 'Device reallocation while a bunch is resident is not supported.')
    ierr = 1;  dev_ok = .false.
    return
  endif
  reason = ''
  ierr = bmad_dev_init(int(n_tot, c_int), int(mesh_n, c_int32_t), reason, len(reason))
  if (ierr /= 0) then
    call out_io (s_warn$, r_name, 'Device init failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
    dev_ok = .false.
    return
  endif
  dev_inited = .true.
  dev_mesh_n = mesh_n
  dev_n_max = n_tot
  grn_delta = -1;  grn_gamma = -1
endif

if (.not. with_green) return

nx2 = 2 * mesh_n(1);  ny2 = 2 * mesh_n(2);  nz2 = 2 * mesh_n(3)
if (any(mesh3d%delta /= grn_delta) .or. mesh3d%gamma /= grn_gamma) then
  if (allocated(gbuf)) then
    if (any(shape(gbuf) /= [nx2, ny2, nz2])) deallocate (gbuf, g32)
  endif
  if (.not. allocated(gbuf)) allocate (gbuf(nx2, ny2, nz2), g32(nx2, ny2, nz2, 3))
  do icomp = 1, 3
    call osc_get_rgrn_freespace (gbuf, mesh3d%delta, mesh3d%gamma, icomp)
    g32(:,:,:,icomp) = real(gbuf, c_float)
    ! The last plane in each dimension holds the undifferenced indefinite integral (huge, up to 1e14),
    ! which the extracted octant never multiplies in exact arithmetic but whose round-off would
    ! swamp a single precision transform. Zero it.
    g32(nx2, :, :, icomp) = 0;  g32(:, ny2, :, icomp) = 0;  g32(:, :, nz2, icomp) = 0
  enddo
  reason = ''
  ierr = bmad_dev_set_green (g32(:,:,:,1), g32(:,:,:,2), g32(:,:,:,3), reason, len(reason))
  if (ierr /= 0) then
    call out_io (s_warn$, r_name, 'Green function upload failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
    dev_ok = .false.
    return
  endif
  grn_delta = mesh3d%delta;  grn_gamma = mesh3d%gamma
endif

end subroutine device_mesh_setup

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_resident_begin (soa, mesh3d, particle)
!
! Routine to bind a SoA bunch to the device for a sequence of slices and space charge steps. The host
! copy is current; nothing is uploaded until the first device operation. The device allocation is sized
! for soa%n particles and the mesh of mesh3d (%nhi set).
!
! Input:
!   soa       -- bunch_soa_struct: Bunch.
!   mesh3d    -- mesh3d_struct: Space charge mesh (%nlo, %nhi).
!   particle  -- integer: Species (param%particle).
!
! Output:
!   ok        -- logical: False if the device cannot take the bunch (the caller stays on the CPU).
!-

subroutine bunch_device_resident_begin (soa, mesh3d, particle, ok)

type (bunch_soa_struct) soa
type (mesh3d_struct) mesh3d
integer particle, ierr
logical ok

ok = .false.
if (.not. bunch_device_on()) return
res_active = .false.
call device_mesh_setup (mesh3d, soa%n, .false., ierr)
if (ierr /= 0) return
call ensure_resident_arrays (soa%n)
res_active = .true.
res_n = soa%n
res_species = particle
res_mass = mass_of(particle)
res_dev_current = .false.
res_host_current = .true.
res_tag = 0
res_dt_ref = 0
res_t_base = 0
tz0_valid = .false.
call ran_seed_get (res_seed)
ok = .true.

end subroutine bunch_device_resident_begin

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_resident_end (soa)
!
! Routine to bring the resident bunch back to the host and unbind it.
!-

subroutine bunch_device_resident_end (soa)
type (bunch_soa_struct) soa
if (.not. res_active) return
call bunch_device_sync_host (soa)
res_active = .false.
res_dev_current = .false.
end subroutine bunch_device_resident_end

!--------------------------------------------------------------------------
!+
! Function bunch_device_resident () result (active)
!
! True while a bunch is bound to the device (between resident_begin and resident_end).
!-

function bunch_device_resident () result (active)
logical active
active = res_active .and. dev_ok
end function bunch_device_resident

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_host_changed ()
!
! Routine to note that the host SoA copy of the resident bunch was modified (the device copy is stale).
!-

subroutine bunch_device_host_changed ()
if (.not. res_active) return
res_dev_current = .false.
res_host_current = .true.
end subroutine bunch_device_host_changed

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_sync_device (soa)
!
! Routine to upload the host SoA copy if the device copy is stale.
!-

subroutine bunch_device_sync_device (soa)

type (bunch_soa_struct) soa
integer i, ierr
character(256) reason
character(*), parameter :: r_name = 'bunch_device_sync_device'

if (.not. res_active .or. res_dev_current) return

!$OMP PARALLEL DO IF (soa%n > 10000)
do i = 1, soa%n
  x32(i) = real(soa%x(i), c_float);   px32(i) = real(soa%px(i), c_float)
  y32(i) = real(soa%y(i), c_float);   py32(i) = real(soa%py(i), c_float)
  z32(i) = real(soa%z(i), c_float);   pz32(i) = real(soa%pz(i), c_float)
  q32(i) = real(soa%charge(i), c_float)
  p0c32(i) = real(soa%p0c(i), c_float)
  st32(i) = soa%state(i)
  z_up(i) = soa%z(i)
  beta_up(i) = soa%beta(i)
enddo
!$OMP END PARALLEL DO

reason = ''
ierr = bmad_dev_bunch_upload (int(soa%n, c_int), x32, px32, y32, py32, z32, pz32, st32, q32, p0c32, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'Upload failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.;  res_active = .false.
  return
endif
res_dev_current = .true.
res_host_current = .true.
res_dt_ref = 0
res_tag = 0
stats_valid = .false.
tz0_valid = .false.

end subroutine bunch_device_sync_device

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_sync_host (soa)
!
! Routine to download the device copy if the host copy is stale. Particles the device touched get their
! coordinates, state and location; t is reconstructed from the invariant t - t_ref + z/(beta c) that the
! kernels preserve: t = t_up + sum(delta_ref_time) - (z/beta - z_up/beta_up)/c.
!-

subroutine bunch_device_sync_host (soa)

type (bunch_soa_struct) soa
real(rp) beta_now
integer i, ierr, tg
character(256) reason
character(*), parameter :: r_name = 'bunch_device_sync_host'

if (.not. res_active .or. res_host_current .or. .not. res_dev_current) return

reason = ''
ierr = bmad_dev_bunch_download (int(soa%n, c_int), x32, px32, y32, py32, z32, pz32, st32, loc32, tag32, p0c32, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_error$, r_name, 'Download failed: ' // trim(from_c(reason)), 'Bunch state is undefined from here on.')
  dev_ok = .false.;  res_active = .false.
  return
endif

!$OMP PARALLEL DO PRIVATE(beta_now, tg) IF (soa%n > 10000)
do i = 1, soa%n
  if (loc32(i) == 0 .and. soa%state(i) /= alive$) cycle    ! dead before the upload: untouched
  soa%x(i) = x32(i);  soa%px(i) = px32(i)
  soa%y(i) = y32(i);  soa%py(i) = py32(i)
  soa%z(i) = z32(i);  soa%pz(i) = pz32(i)
  if (loc32(i) /= 0) then
    soa%location(i) = loc32(i)
    if (st32(i) /= alive$) then
      tg = tag32(i)
      soa%state(i) = st32(i)
      if (tg >= 1 .and. tg <= n_tag_max) then
        soa%ix_ele(i) = tag_ix_ele(tg);  soa%ix_branch(i) = tag_ix_branch(tg)
        if (loc32(i) == upstream_end$) then
          soa%s(i) = tag_s_start(tg)
        else
          soa%s(i) = tag_s_end(tg)
        endif
        ! The reference momentum where the particle was lost: the slice's (exact) unless the kernel
        ! left it at the entrance value (lost before the energy correction).
        if (p0c32(i) == real(tag_p0c(tg), c_float)) then
          soa%p0c(i) = tag_p0c(tg)
        else
          soa%p0c(i) = p0c32(i)
        endif
      endif
    else if (res_tag > 0) then
      soa%ix_ele(i) = tag_ix_ele(res_tag);  soa%ix_branch(i) = tag_ix_branch(res_tag)
      soa%s(i) = tag_s_end(res_tag)
      soa%p0c(i) = tag_p0c(res_tag)
    endif
  endif
  call convert_pc_to (soa%p0c(i) * (1 + soa%pz(i)), res_species, beta = beta_now)
  soa%t(i) = qp_add_dp(soa%t(i), res_dt_ref - (soa%z(i) / beta_now - z_up(i) / beta_up(i)) / c_light)
  soa%beta(i) = beta_now
  z_up(i) = soa%z(i)
  beta_up(i) = beta_now
enddo
!$OMP END PARALLEL DO

res_t_base = res_t_base + res_dt_ref
res_dt_ref = 0
res_tag = 0
res_host_current = .true.

end subroutine bunch_device_sync_host

!--------------------------------------------------------------------------
! tz0 = t - res_t_base + z/(beta c) of every particle at the upload, from the host copy (soa%t is the
! upload-time value while the device copy is current). res_t_base is the first live particle's time.

subroutine tz0_upload (soa)

type (bunch_soa_struct) soa
integer i, ierr
character(256) reason
character(*), parameter :: r_name = 'tz0_upload'

res_t_base = 0
do i = 1, soa%n
  if (soa%state(i) /= alive$) cycle
  res_t_base = real(soa%t(i), rp)
  exit
enddo

!$OMP PARALLEL DO IF (soa%n > 10000)
do i = 1, soa%n
  if (beta_up(i) == 0) then
    tz032(i) = 0
  else
    tz032(i) = real(real(soa%t(i) - res_t_base, rp) + z_up(i) / (beta_up(i) * c_light), c_float)
  endif
enddo
!$OMP END PARALLEL DO

reason = ''
ierr = bmad_dev_bunch_set_tz0 (int(soa%n, c_int), tz032, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'Time upload failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.;  res_active = .false.
  return
endif
tz0_valid = .true.

end subroutine tz0_upload

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_track_slice (soa, ele, param, tracked)
!
! Routine to track the resident bunch through a slice on the device, if the kernels support it (the
! same conditions as fast_slice_prepare).
!
! Output:
!   tracked   -- logical: True if the device tracked the slice. False: nothing done.
!-

subroutine bunch_device_track_slice (soa, ele, param, tracked)

type (bunch_soa_struct) soa
type (ele_struct) ele
type (lat_param_struct) param
type (fast_slice_struct) fs
type (bmad_dev_slice_par_struct) par
type (bmad_dev_rf_step_struct) rf(dev_max_rf)
type (coord_struct) orb0
real(rp) r_ref, beta0, ph
real(qp) t_k
integer ierr, k
logical tracked, err
character(256) reason
character(200) why
character(8) val
logical, save :: why_init = .false., why_on = .false., nofr_init = .false.
integer, save :: n_why = 0, nofr_mode = 0
character(*), parameter :: r_name = 'bunch_device_track_slice'

tracked = .false.
if (.not. res_active .or. .not. dev_ok) return
call fast_slice_prepare (ele, param, fs, err, why, for_device = .true.)
if (.not. err .and. fs%kind == fast_lcav_std$ .and. fs%rf_n > dev_max_rf) then
  err = .true.;  why = 'too many RF steps for the device'
endif
if (err) then
  ! BMAD_DEVICE_WHY=1: report why slices are left to the CPU (debug).
  if (.not. why_init) then
    call get_environment_variable ('BMAD_DEVICE_WHY', val)
    why_on = (val == '1');  why_init = .true.
  endif
  if (why_on .and. n_why < 40) then
    n_why = n_why + 1
    print '(a, a, a, a, a, a)', 'device declined ', trim(ele%name), ' (', trim(key_name(ele%key)), '): ', trim(why)
  endif
  return
endif
if (fs%species /= res_species) return

! BMAD_DEVICE_NO_FRINGE=1: bend end slices stay on the CPU; 2: tracked on the device without the fringe kicks (debug).
if (.not. nofr_init) then
  call get_environment_variable ('BMAD_DEVICE_NO_FRINGE', val)
  nofr_mode = 0
  if (val == '1') nofr_mode = 1
  if (val == '2') nofr_mode = 2
  nofr_init = .true.
endif
if (fs%kind == fast_bend$ .and. any(fs%fr_on)) then
  if (nofr_mode == 1) return
  if (nofr_mode == 2) fs%fr_on = .false.
endif

if (res_tag >= n_tag_max) call bunch_device_sync_host (soa)   ! tag table full: new baseline
call bunch_device_sync_device (soa)
if (.not. res_active) return

if (fs%kind == fast_lcav$) then
  if (.not. tz0_valid) call tz0_upload (soa)
  if (.not. res_active) return
  if (fs%lc_abs_time) then
    ! The RF time of a particle with t = reference time at the slice start (particle_rf_time).
    orb0 = coord_struct()
    orb0%vec = 0;  orb0%beta = 1;  orb0%p0c = ele%value(p0c_start$)
    orb0%species = param%particle;  orb0%direction = 1;  orb0%time_dir = 1
    orb0%t = real(res_t_base, qp) + real(res_dt_ref, qp)
    fs%lc_time0 = real(particle_rf_time (orb0, ele, .true., 0.0_rp, rf_freq = fs%lc_rf_freq), rp)
  endif
endif

! bmad_standard lcavity: the step table. The reference time advance over a drift is ds/(beta0 c) with the
! drift region's reference velocity (track_a_drift keeps t + z/(beta c) - that); r_ref accumulates it.
r_ref = 0
if (fs%kind == fast_lcav_std$) then
  if (.not. tz0_valid) call tz0_upload (soa)
  if (.not. res_active) return
  do k = 1, fs%rf_n
    beta0 = fs%rf_p0c(k) / fs%rf_e0(k)
    r_ref = r_ref + fs%rf_ds(k) / (beta0 * c_light)
    if (fs%rf_abs) then
      t_k = real(res_t_base, qp) + real(res_dt_ref, qp) + real(r_ref, qp)
      ph = twopi * (fs%rf_phi0 + (real(modulo2(t_k, 0.5_qp / fs%rf_freq), rp) - fs%rf_ref_shift - fs%rf_tm(k)) * fs%rf_freq)
    else
      ph = twopi * (fs%rf_phi0 + (fs%rf_ts(k) - fs%rf_tm(k)) * fs%rf_freq)
    endif
    rf(k)%ds = real(fs%rf_ds(k), c_float)
    rf(k)%cphase = real(modulo2(ph, pi), c_float)
    rf(k)%damp = real(fs%rf_volt * fs%rf_scale(k) * fs%rf_fauto, c_float)
    rf(k)%rr = real(fs%rf_p0c(k) / fs%rf_p1c(k), c_float)
    rf(k)%dd = real((fs%rf_p1c(k) - fs%rf_p0c(k)) / fs%rf_p1c(k), c_float)
    rf(k)%cpond = real(fs%rf_pond / (16.0_rp * fs%rf_p0c(k)**2 * fs%rf_nstep), c_float)
    rf(k)%p0c = real(fs%rf_p0c(k), c_float)
    rf(k)%flags = fs%rf_flags(k)
  enddo
endif

res_tag = res_tag + 1
res_rng_ctr = res_rng_ctr + 1
tag_s_start(res_tag) = fs%s_start;  tag_s_end(res_tag) = fs%s_end
tag_ix_ele(res_tag) = fs%ix_ele;    tag_ix_branch(res_tag) = fs%ix_branch
tag_p0c(res_tag) = fs%p0c_ele
call slice_to_par (fs, par)

reason = ''
ierr = bmad_dev_track_slice (par, rf, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'Slice tracking failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.
  return
endif
if (fs%kind == fast_lcav$) then
  res_dt_ref = res_dt_ref + fs%lc_dt_ref_rk     ! odeint_bmad advances t_ref at the lord's average rate
elseif (fs%kind == fast_lcav_std$) then
  res_dt_ref = res_dt_ref + r_ref
else
  res_dt_ref = res_dt_ref + fs%delta_ref_time
endif
res_host_current = .false.
stats_valid = .false.
tracked = .true.

end subroutine bunch_device_track_slice

!--------------------------------------------------------------------------
!+
! Function bunch_device_n_live (soa) result (n_live)
!
! Number of live particles of the resident bunch, from the device if that copy is the current one.
!-

function bunch_device_n_live (soa) result (n_live)
type (bunch_soa_struct) soa
integer n_live, ierr
character(256) reason
if (res_active .and. res_dev_current .and. .not. res_host_current) then
  if (.not. stats_valid) then
    ierr = bmad_dev_bunch_stats (real(res_mass, c_double), 0.0_c_double, stats9, reason, len(reason))
    stats_valid = (ierr == 0)
  endif
  if (stats_valid) then
    n_live = nint(stats9(1))
    return
  endif
endif
n_live = count(soa%state == alive$)
end function bunch_device_n_live

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_sc_kick_resident (mesh3d, track_step, growth, shrink, soa, done)
!
! The 3D free-space space charge kick of apply_fft_3d_kicks on the resident bunch: the mean time
! offset, the mesh bounds, the deposit, the solve and the kick are all done on the device.
!-

subroutine bunch_device_sc_kick_resident (mesh3d, track_step, growth, shrink, soa, done)

type (mesh3d_struct) mesh3d
type (bunch_soa_struct) soa
type (bmad_dev_sc_par_struct) par
real(rp) track_step, growth, shrink, dct_ave, qabs
real(c_double) sums(3), bnd(6)
integer ierr, mesh_n(3), nx2, ny2, nz2
logical done
character(256) reason
character(*), parameter :: r_name = 'bunch_device_sc_kick_resident'

done = .false.
if (.not. res_active .or. .not. dev_ok) return
call bunch_device_sync_device (soa)
if (.not. res_active) return

reason = ''
ierr = bmad_dev_bunch_sums (real(res_mass, c_double), sums, reason, len(reason))
if (ierr /= 0) then
  call fail ('Reduction failed: ' // trim(from_c(reason)));  return
endif
if (sums(1) < 1) then
  done = .true.
  return
endif
dct_ave = sums(2) / sums(1)
qabs = sums(3)

ierr = bmad_dev_bunch_bounds (real(res_mass, c_double), real(dct_ave, c_double), bnd, reason, len(reason))
if (ierr /= 0) then
  call fail ('Bounds reduction failed: ' // trim(from_c(reason)));  return
endif
call osc_mesh_resize_bounds (bnd(1:3), bnd(4:6), mesh3d, growth, shrink)
where (mesh3d%delta == 0) mesh3d%delta = 1d-10
mesh3d%charge = sign(qabs, soa%charge(1))

call device_mesh_setup (mesh3d, soa%n, .true., ierr)
if (ierr /= 0) return
mesh_n = mesh3d%nhi - mesh3d%nlo + 1
nx2 = 2 * mesh_n(1);  ny2 = 2 * mesh_n(2);  nz2 = 2 * mesh_n(3)

par%mesh_min = mesh3d%min
par%delta = mesh3d%delta
par%gamma = mesh3d%gamma
par%kick_scale = 1 / mesh3d%gamma**2
par%grn_scale = fpei / (real(nx2, rp) * real(ny2, rp) * real(nz2, rp))
par%q_total_abs = qabs
par%dct_ave = dct_ave
par%track_step = track_step
par%mass = res_mass
par%n = 0
par%pad = 0

ierr = bmad_dev_sc_step_resident (par, reason, len(reason))
if (ierr /= 0) then
  call fail ('Space charge step failed: ' // trim(from_c(reason)));  return
endif
res_host_current = .false.
stats_valid = .false.
done = .true.

!--------------------------
contains

subroutine fail (msg)
character(*) msg
call out_io (s_warn$, r_name, msg, 'Using the CPU path from now on.')
dev_ok = .false.
end subroutine fail

end subroutine bunch_device_sc_kick_resident

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_bunch_params (soa, bunch, bunch_params, done)
!
! calc_bunch_params_soa of the resident bunch computed from device moments, without bringing the host
! copy up to date. done is False (nothing computed) if the device copy is not current or the charge
! is not set; the caller then uses the host path.
!-

subroutine bunch_device_bunch_params (soa, bunch, bunch_params, done)

type (bunch_soa_struct) soa
type (bunch_struct) bunch
type (bunch_params_struct) bunch_params
real(c_double) m1(25), m2(22), avg(7)
real(rp) charge_live, t0, average_pc
integer i, ierr, n_live, idx, r, c
logical done, error
character(256) reason
character(*), parameter :: r_name = 'bunch_device_bunch_params'

done = .false.
if (.not. res_active .or. .not. dev_ok .or. .not. res_dev_current) return
if (.not. tz0_valid) call tz0_upload (soa)
if (.not. res_active) return

reason = ''
avg = 0
ierr = bmad_dev_bunch_moments (1_c_int, real(res_mass, c_double), avg, m1, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'Moments failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.
  return
endif

n_live = nint(m1(1))
charge_live = m1(3)
if (m1(2) == 0 .or. (n_live > 0 .and. charge_live == 0)) return   ! calc_bunch_params reports these.

bunch_params = bunch_params_struct()
bunch_params%twiss_valid = .false.
do i = soa%n, 1, -1
  if (soa%state(i) /= alive$) cycle
  bunch_params%centroid = bunch%particle(i)
  bunch_params%centroid%state = alive$
  if (res_tag > 0) then
    bunch_params%centroid%p0c = tag_p0c(res_tag)
    bunch_params%centroid%s = tag_s_end(res_tag)
    bunch_params%centroid%location = downstream_end$
    bunch_params%centroid%ix_ele = tag_ix_ele(res_tag);  bunch_params%centroid%ix_branch = tag_ix_branch(res_tag)
  else
    bunch_params%centroid%p0c = soa%p0c(i)
    bunch_params%centroid%s = soa%s(i)
    bunch_params%centroid%location = soa%location(i)
    bunch_params%centroid%ix_ele = soa%ix_ele(i);  bunch_params%centroid%ix_branch = soa%ix_branch(i)
  endif
  bunch_params%ix_ele = bunch_params%centroid%ix_ele
  bunch_params%location = bunch_params%centroid%location
  exit
enddo

bunch_params%n_good_steps = bunch%n_good
bunch_params%n_bad_steps = bunch%n_bad
bunch_params%n_particle_tot = soa%n
bunch_params%n_particle_live = n_live
bunch_params%charge_live = charge_live
bunch_params%charge_tot = m1(2)
bunch%charge_tot = bunch_params%charge_tot
bunch%charge_live = bunch_params%charge_live
bunch_params%centroid%charge = charge_live
done = .true.
if (n_live == 0) return

! Centroid, time (relative to the reference time at the current slice start) and extrema.
avg = m1(4:10) / charge_live
t0 = res_t_base + res_dt_ref
bunch_params%centroid%vec = avg(1:6)
bunch_params%centroid%t = t0 + avg(7)
bunch_params%s = bunch_params%centroid%s
bunch_params%t = bunch_params%centroid%t
bunch_params%rel_min = m1(12:18) - avg
bunch_params%rel_max = m1(19:25) - avg

ierr = bmad_dev_bunch_moments (2_c_int, real(res_mass, c_double), avg, m2, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'Moments failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.;  done = .false.
  return
endif
idx = 0
do r = 1, 6
  do c = r, 6
    idx = idx + 1
    bunch_params%sigma(r, c) = m2(idx) / charge_live
    bunch_params%sigma(c, r) = bunch_params%sigma(r, c)
  enddo
enddo
bunch_params%sigma_t = sqrt(max(0.0_rp, m2(22) / charge_live))

average_pc = (1 + bunch_params%centroid%vec(6)) * bunch_params%centroid%p0c
call convert_pc_to (average_pc, res_species, beta = bunch_params%centroid%beta)
if (n_live < 6) return
call calc_emittances_and_twiss_from_sigma_matrix (bunch_params%sigma, bunch_params, error, .false.)

end subroutine bunch_device_bunch_params

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_csr_step (soa, n_bin, pbs, n_bin_eff, z_lo, z_hi, x_abs, y_abs, n_live, q_abs,
!                                   z_min, dz_slice, dz_particle, sums1, sums2, done)
!
! One CSR step of csr_bin_view on the resident bunch in one device submission: the live count, extent
! and |charge| of the bunch, the bin layout (laid out on the device as csr_bin_view does it, so the
! caller must use these values), and the bin sums: sums1(1:4, ib) = overlap, charge, x*charge, y*charge;
! sums2(1:2, ib) = |x - x0|*charge, |y - y0|*charge with the per-bin centroids formed on the device.
!-

subroutine bunch_device_csr_step (soa, n_bin, pbs, n_bin_eff, z_lo, z_hi, x_abs, y_abs, n_live, q_abs, &
                                                                  z_min, dz_slice, dz_particle, sums1, sums2, done)

type (bunch_soa_struct) soa
real(rp) z_lo, z_hi, x_abs, y_abs, q_abs, z_min, dz_slice, dz_particle, sums1(:,:), sums2(:,:)
real(c_double) layout(4)
real(c_double), allocatable :: out1(:), out2(:)
integer n_bin, pbs, n_bin_eff, n_live, ierr
logical done
character(256) reason
character(*), parameter :: r_name = 'bunch_device_csr_step'

done = .false.
if (.not. res_active .or. .not. dev_ok) return
call bunch_device_sync_device (soa)
if (.not. res_active) return

allocate (out1(4 * n_bin), out2(2 * n_bin))
reason = ''
ierr = bmad_dev_csr_step (real(res_mass, c_double), int(n_bin, c_int), int(pbs, c_int), int(n_bin_eff, c_int), &
                                                                 stats9, layout, out1, out2, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'CSR step failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.
  return
endif
stats_valid = .true.
n_live = nint(stats9(1))
q_abs = stats9(3)
z_lo = stats9(6);  z_hi = stats9(9)
x_abs = max(abs(stats9(4)), abs(stats9(7)));  y_abs = max(abs(stats9(5)), abs(stats9(8)))
z_min = layout(1);  dz_slice = layout(2);  dz_particle = layout(3)
sums1(1:4, 1:n_bin) = reshape(out1, [4, n_bin])
sums2(1:2, 1:n_bin) = reshape(out2, [2, n_bin])
if (iand(bmad_dev_fault(), 2) /= 0) call out_io (s_warn$, r_name, 'Particle outside the CSR bins on the device.')
done = .true.

end subroutine bunch_device_csr_step

!--------------------------------------------------------------------------
!+
! Subroutine bunch_device_csr_kick (soa, n_bin, kick, zc1, dz_slice, done)
!
! The CSR-only kick of csr_and_sc_apply_kicks_view on the resident bunch: pz += interpolated kick(ib).
!-

subroutine bunch_device_csr_kick (soa, n_bin, kick, zc1, dz_slice, done)

type (bunch_soa_struct) soa
type (bmad_dev_csr_par_struct) par
real(rp) kick(:), zc1, dz_slice
real(c_float), allocatable :: k32(:)
integer n_bin, ierr
logical done
character(256) reason
character(*), parameter :: r_name = 'bunch_device_csr_kick'

done = .false.
if (.not. res_active .or. .not. dev_ok) return
call bunch_device_sync_device (soa)
if (.not. res_active) return
par%z_min = 0;  par%dz_slice = dz_slice;  par%dz_particle = 1;  par%scale = 1;  par%zc1 = zc1
par%n_bin = n_bin;  par%pbs = 0;  par%pass = 0;  par%pad = 0
allocate (k32(n_bin))
k32 = real(kick(1:n_bin), c_float)
reason = ''
ierr = bmad_dev_csr_kick (par, k32, reason, len(reason))
if (ierr /= 0) then
  call out_io (s_warn$, r_name, 'CSR kick failed: ' // trim(from_c(reason)), 'Using the CPU path from now on.')
  dev_ok = .false.
  return
endif
res_host_current = .false.
stats_valid = .false.
done = .true.

end subroutine bunch_device_csr_kick

!--------------------------------------------------------------------------
! fast_slice_struct -> device slice parameters.

subroutine slice_to_par (fs, par)

type (fast_slice_struct) fs
type (bmad_dev_slice_par_struct) par
integer k, ie, idx

par%kind = fs%kind
par%n_step = fs%n_step
par%ix_mag_max = fs%ix_mag_max
par%offset_on = merge(1, 0, fs%offset_on)
par%do_tilt = merge(1, 0, fs%do_tilt)
par%is_misaligned = merge(1, 0, fs%is_misaligned)
par%n_ap0 = fs%n_ap(1);  par%n_ap1 = fs%n_ap(2)
par%rad_damp0 = merge(1, 0, fs%rad_damp_edge(1));   par%rad_damp1 = merge(1, 0, fs%rad_damp_edge(2))
par%rad_fluct0 = merge(1, 0, fs%rad_fluct_edge(1)); par%rad_fluct1 = merge(1, 0, fs%rad_fluct_edge(2))
par%rad_damp_vec = merge(1, 0, fs%rad_damp_vec)
par%ele_tag = res_tag
par%rng_seed = res_seed
par%rng_ctr = res_rng_ctr
par%length = real(fs%length, c_float);  par%s_start = real(fs%s_start, c_float);  par%s_end = real(fs%s_end, c_float)
par%p0c_ele = real(fs%p0c_ele, c_float);  par%e_tot_ele = real(fs%e_tot_ele, c_float)
par%mass = real(fs%mass, c_float);  par%max_ap = real(fs%max_ap, c_float)
par%charge_dir = real(fs%charge_dir, c_float);  par%b1 = real(fs%b1, c_float)
par%r_step = real(fs%r_step, c_float);  par%step_len = real(fs%step_len, c_float);  par%ab_f = real(fs%ab_f, c_float)
par%an = real(fs%an, c_float);  par%bn = real(fs%bn, c_float)
par%cm = real(reshape(fs%cm, [484]), c_float)
par%tilt_tot = real(fs%tilt_tot, c_float)
par%cos_t = real(fs%cos_t, c_float);  par%sin_t = real(fs%sin_t, c_float)
par%cos_mt = real(fs%cos_mt, c_float);  par%sin_mt = real(fs%sin_mt, c_float)
par%x_off = real(fs%x_off, c_float);  par%y_off = real(fs%y_off, c_float);  par%z_off = real(fs%z_off, c_float)
par%zc_set = real(fs%zc_set, c_float);  par%l_half = real(fs%l_half, c_float)
par%ds_center_unset = real(fs%ds_center_unset, c_float)
par%s_target_set = real(fs%s_target_set, c_float);  par%s_target_unset = real(fs%s_target_unset, c_float)
par%w_inv = real(reshape(fs%w_inv, [9]), c_float);  par%w_mat = real(reshape(fs%w_mat, [9]), c_float)
par%ap_type = 0;  par%ap_lim = 0
do ie = 1, 2
  do k = 1, fast_max_ap
    idx = (k-1) + 4*(ie-1)
    par%ap_type(idx+1) = fs%ap(k, ie)%ap_type
    par%ap_lim(8*idx+1:8*idx+8) = real([fs%ap(k,ie)%x1_lim, fs%ap(k,ie)%x2_lim, fs%ap(k,ie)%y1_lim, fs%ap(k,ie)%y2_lim, &
                                        fs%ap(k,ie)%ex_w2, fs%ap(k,ie)%ex_c, fs%ap(k,ie)%ey_w2, fs%ap(k,ie)%ey_c], c_float)
  enddo
enddo
par%g = real(fs%g, c_float);  par%dg = real(fs%dg, c_float);  par%g_tot = real(fs%g_tot, c_float)
par%angle = real(fs%angle, c_float);  par%beta_ref = real(fs%beta_ref, c_float)
par%sinc_a = real(fs%sinc_a, c_float);  par%cos_a = real(fs%cos_a, c_float);  par%sin_a = real(fs%sin_a, c_float)
par%cosc_a = real(fs%cosc_a, c_float);  par%sincc_a = real(fs%sincc_a, c_float)
par%rad_scale = real(fs%rad_scale, c_float)
par%rad_ref = real(reshape(fs%rad_ref, [12]), c_float)
par%rad_dmat = real(reshape(fs%rad_dmat, [72]), c_float)
par%rad_dvec = real(reshape(fs%rad_dvec, [12]), c_float)
par%rad_smat = real(reshape(fs%rad_smat, [72]), c_float)
par%lc_abs_time = merge(1, 0, fs%lc_abs_time);  par%lc_long_mode = fs%lc_long_mode
par%lc_travel = merge(1, 0, fs%lc_travel);      par%lc_ap_cont = merge(1, 0, fs%lc_ap_cont)
par%lc_max_steps = fs%lc_max_steps
par%lc_kick = merge(1, 0, fs%lc_kick(1)) + merge(2, 0, fs%lc_kick(2))
par%lc_grad = real(fs%lc_grad, c_float);        par%lc_k = real(fs%lc_k, c_float)
par%lc_omega = real(fs%lc_omega, c_float);      par%lc_phase = real(fs%lc_phase, c_float)
par%lc_s_off = real(fs%lc_s_off, c_float);      par%lc_l_active = real(fs%lc_l_active, c_float)
par%lc_time0 = real(fs%lc_time0, c_float);      par%lc_inv_cb0 = real(fs%lc_inv_cb0, c_float)
par%lc_ib0m1 = real(fs%lc_ib0m1, c_float);      par%lc_edge1 = real(fs%lc_edge1, c_float)
par%lc_edge2 = real(fs%lc_edge2, c_float);      par%lc_zk = real(fs%lc_zk, c_float)
par%lc_rel_tol = real(fs%lc_rel_tol, c_float);  par%lc_abs_tol = real(fs%lc_abs_tol, c_float)
par%lc_init_ds = real(fs%lc_init_ds, c_float);  par%lc_min_ds = real(fs%lc_min_ds, c_float)
par%lc_fatal_ds = real(fs%lc_fatal_ds, c_float); par%lc_ds_tiny = real(fs%lc_ds_tiny, c_float)
par%lc_charge = real(fs%lc_charge, c_float);    par%lc_rel_floor = real(fs%lc_rel_floor, c_float)
par%rf_n = fs%rf_n;  par%rf_abs = merge(1, 0, fs%rf_abs)
par%rf_grad = real(fs%rf_grad, c_float);  par%rf_omega_e = real(fs%rf_omega, c_float)
par%rf_omega_t = real(twopi * fs%rf_freq, c_float);  par%rf_ff = real(fs%rf_ff, c_float)
par%rf_p0c_end = real(fs%p0c_ele, c_float);  par%rf_pad = 0
par%fr_type = fs%fr_type
par%fr_on = merge(1, 0, fs%fr_on(1)) + merge(2, 0, fs%fr_on(2))
par%fr_e = real(fs%fr_e, c_float);  par%fr_fg = real(fs%fr_fg, c_float)
par%fr_g = real(fs%fr_g, c_float);  par%fr_g_dir = real(fs%fr_g_dir, c_float)
par%fr_beta0 = real(fs%fr_beta0, c_float);  par%fr_pad = 0

end subroutine slice_to_par

!--------------------------------------------------------------------------

subroutine ensure_resident_arrays (n)
integer n
call ensure_arrays (n)
if (allocated(z_up)) then
  if (size(z_up) >= n) return
  deallocate (z_up, beta_up, p0c32, st32, loc32, tag32, tz032)
endif
allocate (z_up(n), beta_up(n), p0c32(n), st32(n), loc32(n), tag32(n), tz032(n))
end subroutine ensure_resident_arrays

!--------------------------------------------------------------------------
! Grow the packed and staging arrays to hold n particles.

subroutine ensure_arrays (n)

integer n

if (allocated(x_pk)) then
  if (size(x_pk) >= n) return
  deallocate (x_pk, y_pk, z_pk, q_pk, beta_pk, idx_pk, x32, y32, z32, q32, f32, px32, py32, pz32)
endif
allocate (x_pk(n), y_pk(n), z_pk(n), q_pk(n), beta_pk(n), idx_pk(n))
allocate (x32(n), y32(n), z32(n), q32(n), f32(n), px32(n), py32(n), pz32(n))

end subroutine ensure_arrays

!--------------------------------------------------------------------------

function c_str (s) result (cs)
character(*) s
character(kind=c_char, len=len_trim(s)+1) cs
cs = trim(s) // c_null_char
end function c_str

function from_c (cs) result (s)
character(*) cs
character(len(cs)) s
integer i
i = index(cs, c_null_char)
if (i == 0) then
  s = cs
else
  s = cs(1:i-1)
endif
end function from_c

end module bunch_device_mod
