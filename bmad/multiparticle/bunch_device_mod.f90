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
use open_spacecharge_mod, only: mesh3d_struct, osc_get_rgrn_freespace, osc_mesh_resize, osc_ordered_sum, &
                                deposit_particles, space_charge_3d, interpolate_field_batch
use bunch_soa_mod, only: fast_track_enabled, fast_track_device
use, intrinsic :: iso_c_binding
!$ use omp_lib, only: omp_in_parallel

implicit none

! Mirror of bmad_dev_sc_par in bmad/gpu/bmad_device.h. Change both together.
type, bind(c) :: bmad_dev_sc_par_struct
  real(c_double) :: mesh_min(3), delta(3), gamma, kick_scale, grn_scale, q_total_abs
  integer(c_int32_t) :: n, pad(3)
end type

interface
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

private :: c_str, from_c, ensure_arrays

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

mesh_n = mesh3d%nhi - mesh3d%nlo + 1
if (.not. dev_inited .or. any(mesh_n /= dev_mesh_n) .or. n_tot > dev_n_max) then
  reason = ''
  ierr = bmad_dev_init(int(n_tot, c_int), int(mesh_n, c_int32_t), reason, len(reason))
  if (ierr /= 0) then
    call fail ('Device init failed: ' // trim(from_c(reason)))
    return
  endif
  dev_inited = .true.
  dev_mesh_n = mesh_n
  dev_n_max = n_tot
  grn_delta = -1;  grn_gamma = -1
endif

! Green functions: double precision on the host, transformed on the device, cached by (delta, gamma).

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
    call fail ('Green function upload failed: ' // trim(from_c(reason)))
    return
  endif
  grn_delta = mesh3d%delta;  grn_gamma = mesh3d%gamma
endif

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
