module open_spacecharge_mod

use, intrinsic :: iso_fortran_env
use, intrinsic :: iso_c_binding, only: c_ptr, c_null_ptr
use open_spacecharge_core_mod

implicit none

! FFTW plans for the zero padded convolution in osc_freespace_solver2. See osc_padded_fft_plan.
type (c_ptr), private, save :: pfft_r2c_x = c_null_ptr, pfft_fwd_y = c_null_ptr, pfft_fwd_z = c_null_ptr
type (c_ptr), private, save :: pfft_bwd_z = c_null_ptr, pfft_bwd_y = c_null_ptr, pfft_c2r_x = c_null_ptr


! Fortran 2008
!integer, parameter, private :: sp = REAL32
integer, parameter, private :: dp = REAL64
!integer, parameter, private :: qp = REAL128

type mesh3d_struct
  integer :: nlo(3) = [ 1,  1,  1]       ! Lowest  grid index in x, y, z (m) of rho and the quantity being computed (phi or E)
  integer :: nhi(3) = [64, 64, 64]       ! Highest grid index in x, y, z (m) of rho and the quantity being computed (phi or E)
  integer :: npad(3) = [ 1,  1,  1]      ! Array padding for cyclic convolution
  real(dp) :: min(3)                    ! Minimim in each dimension
  real(dp) :: max(3)                    ! Maximum in each dimension
  real(dp) :: delta(3)                  ! Grid spacing
  real(dp) :: gamma                     ! Relativistic gamma
  real(dp) :: charge                    ! Total charge on mesh
  real(dp), allocatable, dimension(:,:,:) :: rho        ! Charge density grid
  real(dp), allocatable, dimension(:,:,:) :: phi        ! electric potential grid
  real(dp), allocatable, dimension(:,:,:,:) :: efield   ! electric field grid
  real(dp), allocatable, dimension(:,:,:,:) :: bfield   ! magnetic field grid
end type

contains


!+
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------

subroutine print_mesh3d(mesh3d)
type(mesh3d_struct) :: mesh3d
print *, '------------------------'
print *, 'Mesh: '
print *, 'nlo: ', mesh3d%nlo
print *, 'nhi: ', mesh3d%nhi
print *, 'min: ', mesh3d%min
print *, 'max: ', mesh3d%max
print *, 'delta: ', mesh3d%delta
print *, 'gamma: ', mesh3d%gamma
print *, 'charge: ', mesh3d%charge
if (allocated(mesh3d%rho)) print *, 'rho allocated'
if (allocated(mesh3d%phi)) print *, 'phi allocated'
if (allocated(mesh3d%efield)) print *, 'efield allocated'
if (allocated(mesh3d%bfield)) print *, 'bfield allocated'
print *, '------------------------'
end subroutine


!+
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------

subroutine space_charge_freespace(mesh3d, direct_field_calc, integrated_green_function)
type(mesh3d_struct) :: mesh3d
integer :: idirectfieldcalc=1
integer :: igfflag=1
logical, optional :: direct_field_calc, integrated_green_function

idirectfieldcalc=1 ! =0 to compute phi and use finite differences for E; =1 to compute E directly
if(present(direct_field_calc) .and. .not. direct_field_calc)idirectfieldcalc=0

igfflag=1 ! =0 for ordinary Green function; =1 for integrated Green function
if(present(integrated_green_function) .and. .not. integrated_green_function) igfflag = 0

call osc_freespace_solver(mesh3d%rho, mesh3d%gamma, &
  mesh3d%delta, mesh3d%phi, mesh3d%efield, mesh3d%bfield, &
  mesh3d%nlo, mesh3d%nhi, mesh3d%nlo, mesh3d%nhi, mesh3d%npad, idirectfieldcalc,igfflag)
end subroutine


!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+

subroutine space_charge_cathodeimages(mesh3d, direct_field_calc, integrated_green_function, image_method)
type(mesh3d_struct) :: mesh3d
integer :: idirectfieldcalc=1
integer :: igfflag=1
logical, optional :: direct_field_calc, integrated_green_function
integer, optional :: image_method
integer :: imethod

idirectfieldcalc=1 ! =0 to compute phi and use finite differences for E; =1 to compute E directly
if(present(direct_field_calc) .and. .not. direct_field_calc)idirectfieldcalc=0

igfflag=1 ! =0 for ordinary Green function; =1 for integrated Green function
if(present(integrated_green_function) .and. .not. integrated_green_function) igfflag = 0

imethod=1 ! =1 for convolution/correlation, =2 for shift method
if(present(image_method) .and. image_method.eq.2)imethod=2

call osc_cathodeimages_solver(mesh3d%rho, mesh3d%gamma, &
  mesh3d%min,mesh3d%delta, mesh3d%phi, mesh3d%efield, mesh3d%bfield, &
  mesh3d%nlo, mesh3d%nhi, mesh3d%nlo, mesh3d%nhi, mesh3d%npad, idirectfieldcalc,igfflag,imethod)
end subroutine

!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+

subroutine space_charge_rectpipe(mesh3d, apipe, bpipe, direct_field_calc, integrated_green_function)
type(mesh3d_struct) :: mesh3d
real(dp) :: apipe, bpipe
integer :: idirectfieldcalc=1
integer :: igfflag=1
logical, optional :: direct_field_calc, integrated_green_function

idirectfieldcalc=1 ! =0 to compute phi and use finite differences for E; =1 to compute E directly
if(present(direct_field_calc) .and. .not. direct_field_calc)idirectfieldcalc=0

igfflag=1 ! =0 for ordinary Green function; =1 for integrated Green function
if(present(integrated_green_function) .and. .not. integrated_green_function) igfflag = 0

call osc_rectpipe_solver(mesh3d%rho, apipe, bpipe, mesh3d%gamma, &
  mesh3d%delta(1), mesh3d%min, mesh3d%phi, mesh3d%efield, mesh3d%bfield, &
  mesh3d%nlo, mesh3d%nhi, mesh3d%nlo, mesh3d%nhi, idirectfieldcalc,igfflag)

end subroutine



!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine deposit_particles(xa, ya, za, mesh3d, total_charge, qa, resize_mesh, mesh_growth_factor, mesh_shrink_factor)
!
! Deposits particle arrays onto mesh
!
! Input:
!   xa                  -- REAL64: x coordinate array
!   ya                  -- REAL64: y coordinate array
!   za                  -- REAL64: z coordinate array
!   qa                  -- REAL64, optional: charge coordinate array
!   total_charge        -- REAL64, optional: total charge of particles, used only if qa is not present
!   resize_mesh         -- logical, optional : Set mesh bounds to fit bunch. 
!                                   default  : .true.
!   mesh_growth_factor  -- REAL64, optional: Fractional padding when growing mesh (default: 0 = tight fit).
!   mesh_shrink_factor  -- REAL64, optional: Fractional threshold for shrinking mesh (default: 0 = tight fit).
!
! Output:
!   mesh3d      -- mesh3d_struct:   
!                     %rho(:,:,:) 
!                     %charge
!
!-

!routine for charge deposition
subroutine deposit_particles(xa, ya, za, mesh3d, qa, total_charge, resize_mesh, mesh_growth_factor, mesh_shrink_factor)

!$ use omp_lib
real(dp) :: xa(:),ya(:),za(:)
type(mesh3d_struct) :: mesh3d
real(dp), optional :: qa(:), total_charge
logical, optional :: resize_mesh
real(dp), intent(in), optional :: mesh_growth_factor, mesh_shrink_factor
logical :: resize, good_mesh_sizes, needs_resize
real(dp) :: growth_factor, shrink_factor

real(dp) :: dx,dy,dz,xmin,ymin,zmin, xmax,ymax,zmax, charge1, min(3), max(3), delta(3), pad(3)
real(dp) :: dxi,dyi,dzi,ab,de,gh
real(dp) :: oab  ! 1-ab
integer :: i, ilo, jlo, klo, ihi, jhi, khi, nlo(3), nhi(3)
integer :: n,ip,jp,kp, n_particles
real(dp), allocatable :: rho_all(:,:,:,:)
integer :: it, t, k, nt, nt_team

! Saved mesh geometry for lazy resizing. Persists between calls so delta
! stays constant when the bunch barely changes, enabling Green function caching.
real(dp), save :: saved_mesh_min(3) = 0, saved_mesh_max(3) = 0
logical, save :: saved_mesh_valid = .false.

if (present(resize_mesh)) then
    resize = resize_mesh
else
    ! Default
    resize = .true.
endif

growth_factor = 0
if (present(mesh_growth_factor)) growth_factor = mesh_growth_factor
shrink_factor = 0
if (present(mesh_shrink_factor)) shrink_factor = mesh_shrink_factor

if (resize) then
  call osc_coord_bounds(xa, ya, za, min, max)

  if (growth_factor == 0 .and. shrink_factor == 0) then
    ! Original tight-fit behavior: compute delta, add tiny relative padding.
    delta = (max - min) / (mesh3d%nhi - mesh3d%nlo)
    min = min - 1.0e-6_dp * delta
    max = max + 1.0e-6_dp * delta
  else
    ! Lazy resize: only change mesh bounds when the bunch no longer fits or is much smaller.
    ! This keeps delta stable across calls, enabling Green function FFT caching.
    needs_resize = .not. saved_mesh_valid
    if (.not. needs_resize) then
      ! Grow: bunch exceeds saved mesh bounds
      if (any(min < saved_mesh_min) .or. any(max > saved_mesh_max)) then
        needs_resize = .true.
      else
        ! Shrink: bunch range significantly smaller than mesh range in any dimension
        delta = saved_mesh_max - saved_mesh_min  ! reuse delta temporarily for mesh_range
        if (any(max - min < delta * (1.0_dp - shrink_factor))) needs_resize = .true.
      endif
    endif

    if (needs_resize) then
      pad = (max - min) * (growth_factor * 0.5_dp)
      ! Ensure minimum padding for numerical safety (handles zero-range dimensions)
      where (pad < 1.0e-10_dp) pad = 1.0e-6_dp
      min = min - pad
      max = max + pad
      saved_mesh_min = min
      saved_mesh_max = max
      saved_mesh_valid = .true.
    else
      min = saved_mesh_min
      max = saved_mesh_max
    endif
  endif

  delta = (max - min) / (mesh3d%nhi - mesh3d%nlo)
  mesh3d%min = min
  mesh3d%max = max
  mesh3d%delta = delta
endif


! If allocated, check that the mesh sizes agree. Otherwise deallocate and below will allocate. 
if (allocated(mesh3d%rho)) then
  nlo = mesh3d%nlo
  nhi = mesh3d%nhi  
  good_mesh_sizes= .true. 
  do i=1, 3
    if (lbound(mesh3d%rho, i) /= nlo(i) ) good_mesh_sizes = .false.
    if (ubound(mesh3d%rho, i) /= nhi(i) ) good_mesh_sizes = .false.
  enddo
  
  if (.not. good_mesh_sizes) then
    deallocate(mesh3d%rho)
    deallocate(mesh3d%phi)
    deallocate(mesh3d%efield)
    deallocate(mesh3d%bfield)
  endif
endif

if (.not. allocated(mesh3d%rho)) then
  nlo = mesh3d%nlo
  nhi = mesh3d%nhi 
  allocate(mesh3d%rho(nlo(1):nhi(1),nlo(2):nhi(2), nlo(3):nhi(3)))
  allocate(mesh3d%phi(nlo(1):nhi(1),nlo(2):nhi(2), nlo(3):nhi(3)))
  allocate(mesh3d%efield(nlo(1):nhi(1),nlo(2):nhi(2), nlo(3):nhi(3), 3))
  allocate(mesh3d%bfield(nlo(1):nhi(1),nlo(2):nhi(2), nlo(3):nhi(3), 3))
endif


if (mesh3d%delta(1) == 0) mesh3d%delta(1) = 1d-10
if (mesh3d%delta(2) == 0) mesh3d%delta(2) = 1d-10
if (mesh3d%delta(3) == 0) mesh3d%delta(3) = 1d-10

dx = mesh3d%delta(1)
dy = mesh3d%delta(2)
dz = mesh3d%delta(3)

dxi=1.d0/dx
dyi=1.d0/dy
dzi=1.d0/dz

ilo = mesh3d%nlo(1)
jlo = mesh3d%nlo(2)
klo = mesh3d%nlo(3)
ihi = mesh3d%nhi(1)
jhi = mesh3d%nhi(2)
khi = mesh3d%nhi(3)

xmin = mesh3d%min(1)
ymin = mesh3d%min(2)
zmin = mesh3d%min(3)

n_particles = size(xa)



if (present(qa)) then
    mesh3d%charge = sum(qa)
elseif (present(total_charge) .and. .not. present(qa)) then
    mesh3d%charge = total_charge
    charge1 = total_charge/n_particles
else
    write(*, *) 'Error, must specify qa or total_charge'
    return
endif

! Clear 
mesh3d%rho(ilo:ihi,jlo:jhi,klo:khi) = 0

! Deposit particles onto mesh using trilinear weighting.
if (n_particles >= 50000) then
  ! OpenMP path: each thread accumulates into its own copy of the mesh, then the copies are summed
  ! plane by plane in parallel, in thread order (deterministic for a given number of threads).
  nt = 1
  !$ nt = omp_get_max_threads()
  allocate(rho_all(ilo:ihi+1, jlo:jhi+1, klo:khi+1, 0:nt-1))

  !$OMP PARALLEL PRIVATE(it, t, k, n, ip, jp, kp, ab, de, gh, oab, charge1) &
  !$OMP& SHARED(nt_team, rho_all, mesh3d, xa, ya, za, qa, n_particles, dxi, dyi, dzi, dx, dy, dz, xmin, ymin, zmin, ilo, ihi, jlo, jhi, klo, khi)
  it = 0
  !$ it = omp_get_thread_num()
  !$OMP SINGLE
  nt_team = 1
  !$ nt_team = omp_get_num_threads()
  !$OMP END SINGLE
  rho_all(:,:,:,it) = 0

  if (present(qa)) then
    !$OMP DO SCHEDULE(STATIC)
    do n = 1, n_particles
      ip = floor((xa(n)-xmin)*dxi+1)
      jp = floor((ya(n)-ymin)*dyi+1)
      kp = floor((za(n)-zmin)*dzi+1)
      ab = ((xmin-xa(n))+ip*dx)*dxi
      de = ((ymin-ya(n))+jp*dy)*dyi
      gh = ((zmin-za(n))+kp*dz)*dzi
      oab = 1.0_dp - ab
      charge1 = qa(n)
      rho_all(ip,  jp,  kp,  it) = rho_all(ip,  jp,  kp,  it) + ab *de     *gh     *charge1
      rho_all(ip,  jp+1,kp,  it) = rho_all(ip,  jp+1,kp,  it) + ab *(1-de) *gh     *charge1
      rho_all(ip,  jp+1,kp+1,it) = rho_all(ip,  jp+1,kp+1,it) + ab *(1-de) *(1-gh) *charge1
      rho_all(ip,  jp,  kp+1,it) = rho_all(ip,  jp,  kp+1,it) + ab *de     *(1-gh) *charge1
      rho_all(ip+1,jp,  kp+1,it) = rho_all(ip+1,jp,  kp+1,it) + oab*de     *(1-gh) *charge1
      rho_all(ip+1,jp+1,kp+1,it) = rho_all(ip+1,jp+1,kp+1,it) + oab*(1-de) *(1-gh) *charge1
      rho_all(ip+1,jp+1,kp,  it) = rho_all(ip+1,jp+1,kp,  it) + oab*(1-de) *gh     *charge1
      rho_all(ip+1,jp,  kp,  it) = rho_all(ip+1,jp,  kp,  it) + oab*de     *gh     *charge1
    enddo
    !$OMP END DO
  else
    charge1 = mesh3d%charge / n_particles
    !$OMP DO SCHEDULE(STATIC)
    do n = 1, n_particles
      ip = floor((xa(n)-xmin)*dxi+1)
      jp = floor((ya(n)-ymin)*dyi+1)
      kp = floor((za(n)-zmin)*dzi+1)
      ab = ((xmin-xa(n))+ip*dx)*dxi
      de = ((ymin-ya(n))+jp*dy)*dyi
      gh = ((zmin-za(n))+kp*dz)*dzi
      oab = 1.0_dp - ab
      rho_all(ip,  jp,  kp,  it) = rho_all(ip,  jp,  kp,  it) + ab *de     *gh     *charge1
      rho_all(ip,  jp+1,kp,  it) = rho_all(ip,  jp+1,kp,  it) + ab *(1-de) *gh     *charge1
      rho_all(ip,  jp+1,kp+1,it) = rho_all(ip,  jp+1,kp+1,it) + ab *(1-de) *(1-gh) *charge1
      rho_all(ip,  jp,  kp+1,it) = rho_all(ip,  jp,  kp+1,it) + ab *de     *(1-gh) *charge1
      rho_all(ip+1,jp,  kp+1,it) = rho_all(ip+1,jp,  kp+1,it) + oab*de     *(1-gh) *charge1
      rho_all(ip+1,jp+1,kp+1,it) = rho_all(ip+1,jp+1,kp+1,it) + oab*(1-de) *(1-gh) *charge1
      rho_all(ip+1,jp+1,kp,  it) = rho_all(ip+1,jp+1,kp,  it) + oab*(1-de) *gh     *charge1
      rho_all(ip+1,jp,  kp,  it) = rho_all(ip+1,jp,  kp,  it) + oab*de     *gh     *charge1
    enddo
    !$OMP END DO
  endif

  !$OMP DO SCHEDULE(STATIC)
  do k = klo, khi
    mesh3d%rho(ilo:ihi,jlo:jhi,k) = rho_all(ilo:ihi,jlo:jhi,k,0)
    do t = 1, nt_team-1
      mesh3d%rho(ilo:ihi,jlo:jhi,k) = mesh3d%rho(ilo:ihi,jlo:jhi,k) + rho_all(ilo:ihi,jlo:jhi,k,t)
    enddo
  enddo
  !$OMP END DO
  !$OMP END PARALLEL

else
  ! Serial path for small particle counts (avoids OpenMP overhead)
  do n = 1, n_particles
    ip = floor((xa(n)-xmin)*dxi+1)
    jp = floor((ya(n)-ymin)*dyi+1)
    kp = floor((za(n)-zmin)*dzi+1)
    ab = ((xmin-xa(n))+ip*dx)*dxi
    de = ((ymin-ya(n))+jp*dy)*dyi
    gh = ((zmin-za(n))+kp*dz)*dzi
    oab = 1.0_dp - ab
    if (present(qa)) charge1 = qa(n)
    mesh3d%rho(ip,  jp,  kp)   = mesh3d%rho(ip,  jp,  kp)   + ab *de     *gh     *charge1
    mesh3d%rho(ip,  jp+1,kp)   = mesh3d%rho(ip,  jp+1,kp)   + ab *(1-de) *gh     *charge1
    mesh3d%rho(ip,  jp+1,kp+1) = mesh3d%rho(ip,  jp+1,kp+1) + ab *(1-de) *(1-gh) *charge1
    mesh3d%rho(ip,  jp,  kp+1) = mesh3d%rho(ip,  jp,  kp+1) + ab *de     *(1-gh) *charge1
    mesh3d%rho(ip+1,jp,  kp+1) = mesh3d%rho(ip+1,jp,  kp+1) + oab*de     *(1-gh) *charge1
    mesh3d%rho(ip+1,jp+1,kp+1) = mesh3d%rho(ip+1,jp+1,kp+1) + oab*(1-de) *(1-gh) *charge1
    mesh3d%rho(ip+1,jp+1,kp)   = mesh3d%rho(ip+1,jp+1,kp)   + oab*(1-de) *gh     *charge1
    mesh3d%rho(ip+1,jp,  kp)   = mesh3d%rho(ip+1,jp,  kp)   + oab*de     *gh     *charge1
  enddo
endif


end subroutine deposit_particles

!------------------------------------------------------------------------
!+
! Subroutine osc_coord_bounds(xa, ya, za, lo, hi)
!
! Componentwise minimum and maximum of particle coordinates. Large arrays are scanned in parallel;
! min/max reductions are exact so the result does not depend on the thread count.
!
! Input:
!   xa(:), ya(:), za(:) -- real(dp): Particle coordinates. Must not be empty.
!
! Output:
!   lo(3), hi(3)        -- real(dp): Minimum and maximum of (x, y, z).
!-

subroutine osc_coord_bounds(xa, ya, za, lo, hi)

real(dp), intent(in) :: xa(:), ya(:), za(:)
real(dp), intent(out) :: lo(3), hi(3)
real(dp) :: x_lo, x_hi, y_lo, y_hi, z_lo, z_hi
integer :: n

x_lo = xa(1); x_hi = xa(1)
y_lo = ya(1); y_hi = ya(1)
z_lo = za(1); z_hi = za(1)

!$OMP PARALLEL DO REDUCTION(min:x_lo, y_lo, z_lo) REDUCTION(max:x_hi, y_hi, z_hi) IF (size(xa) > 10000)
do n = 2, size(xa)
  x_lo = min(x_lo, xa(n)); x_hi = max(x_hi, xa(n))
  y_lo = min(y_lo, ya(n)); y_hi = max(y_hi, ya(n))
  z_lo = min(z_lo, za(n)); z_hi = max(z_hi, za(n))
enddo
!$OMP END PARALLEL DO

lo = [x_lo, y_lo, z_lo]
hi = [x_hi, y_hi, z_hi]

end subroutine osc_coord_bounds




!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine interpolate_field(x, y, z, mesh3d, E, B)
!
! Interpolate field on mesh
!
! Input:
!   x, y, z   -- REAL64: coordinates to interpolate
!   mesh3d    -- mesh3d_struct:  contains efield, bfield
!
! Output:
!   E(3)      -- REAL64, optional: interpolated electric field at x, y, z   
!   B(3)      -- REAL64, optional: interpolated magnetic field at x, y, z   
!
!-

subroutine interpolate_field(x, y, z, mesh3d, E, B)
type(mesh3d_struct) ::  mesh3d
real(dp) :: x, y, z
real(dp), optional :: E(3), B(3)
real(dp) :: hxi,hyi,hzi,ab,de,gh
integer :: ip,jp,kp,ip1,jp1,kp1
integer :: nflag
nflag=0
hxi=1.d0/mesh3d%delta(1); hyi=1.d0/mesh3d%delta(2); hzi=1.d0/mesh3d%delta(3)      
ip=floor((x-mesh3d%min(1))*hxi+1)
jp=floor((y-mesh3d%min(2))*hyi+1)
kp=floor((z-mesh3d%min(3))*hzi+1)

if(ip<1 .or. ip>mesh3d%nhi(1)-1)then
  nflag=1
  write(6,*)'ierror: ip=', ip, (x-mesh3d%min(1)), (x-mesh3d%min(1))/mesh3d%delta(1)
  if(ip<1)then
    ip=1
  else
    ip=mesh3d%nhi(1)-1
  endif
endif
if(jp<1 .or. jp>mesh3d%nhi(2)-1)then
  nflag=1
  write(6,*)'jerror: jp=', jp, (y-mesh3d%min(2)), (y-mesh3d%min(2))/mesh3d%delta(2)
  write(6,*)ab,de,gh
  if(jp<1)then
    jp=1
  else
    jp=mesh3d%nhi(2)-1
  endif
endif
  
if(kp<1 .or. kp>mesh3d%nhi(3)-1)then
    nflag=1
    write(6,*)'kerror:  kp=',kp
    write(6,*)'z=',z
    write(6,*)'mesh3d%min(3)=',mesh3d%min(3)
!!!!!!!!!!write(6,*)ab,de,gh
  if(kp<1)then
    kp=1
  else
    kp=mesh3d%nhi(3)-1
  endif
endif
ab=((mesh3d%min(1)-x)+ip*mesh3d%delta(1))*hxi
de=((mesh3d%min(2)-y)+jp*mesh3d%delta(2))*hyi
gh=((mesh3d%min(3)-z)+kp*mesh3d%delta(3))*hzi
if(nflag.eq.1)then
  write(6,*)ab,de,gh
  nflag=0
endif

ip1=ip+1
jp1=jp+1
kp1=kp+1

if (present(E)) then 
  E=mesh3d%efield(ip, jp,  kp,  :)*ab*de*gh                 &
   +mesh3d%efield(ip, jp1, kp,  :)*ab*(1.-de)*gh            &
   +mesh3d%efield(ip, jp1, kp1, :)*ab*(1.-de)*(1.-gh)       &
   +mesh3d%efield(ip, jp,  kp1, :)*ab*de*(1.-gh)            &
   +mesh3d%efield(ip1,jp,  kp1, :)*(1.-ab)*de*(1.-gh)       &
   +mesh3d%efield(ip1,jp1, kp1, :)*(1.-ab)*(1.-de)*(1.-gh)  &
   +mesh3d%efield(ip1,jp1, kp,  :)*(1.-ab)*(1.-de)*gh       &
   +mesh3d%efield(ip1,jp,  kp,  :)*(1.-ab)*de*gh
endif

if (present(B)) then 
  B=mesh3d%bfield(ip, jp,  kp,  :)*ab*de*gh                 &
   +mesh3d%bfield(ip, jp1, kp,  :)*ab*(1.-de)*gh            &
   +mesh3d%bfield(ip, jp1, kp1, :)*ab*(1.-de)*(1.-gh)       &
   +mesh3d%bfield(ip, jp,  kp1, :)*ab*de*(1.-gh)            &
   +mesh3d%bfield(ip1,jp,  kp1, :)*(1.-ab)*de*(1.-gh)       &
   +mesh3d%bfield(ip1,jp1, kp1, :)*(1.-ab)*(1.-de)*(1.-gh)  &
   +mesh3d%bfield(ip1,jp1, kp,  :)*(1.-ab)*(1.-de)*gh       &
   +mesh3d%bfield(ip1,jp,  kp,  :)*(1.-ab)*de*gh
endif

end subroutine


!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine interpolate_field_batch(x, y, z, mesh3d, n_pts, E, B)
!
! Vectorized batch interpolation of fields at multiple points.
! OpenMP parallelized over the particle dimension.
!
! Input:
!   x(n_pts), y(n_pts), z(n_pts) -- REAL64: coordinate arrays
!   mesh3d                        -- mesh3d_struct: contains efield, bfield
!   n_pts                         -- integer: number of points to interpolate
!
! Output:
!   E(3,n_pts) -- REAL64, optional: interpolated electric field
!   B(3,n_pts) -- REAL64, optional: interpolated magnetic field
!-
subroutine interpolate_field_batch(x, y, z, mesh3d, n_pts, E, B)
type(mesh3d_struct), intent(in) :: mesh3d
integer, intent(in) :: n_pts
real(dp), intent(in) :: x(n_pts), y(n_pts), z(n_pts)
real(dp), optional, intent(out) :: E(3, n_pts), B(3, n_pts)

real(dp) :: hxi, hyi, hzi, ab, de, gh, oab, ode, ogh
real(dp) :: w000, w010, w011, w001, w101, w111, w110, w100
integer :: n, ip, jp, kp, ip1, jp1, kp1

hxi = 1.0_dp / mesh3d%delta(1)
hyi = 1.0_dp / mesh3d%delta(2)
hzi = 1.0_dp / mesh3d%delta(3)

!$OMP PARALLEL DO PRIVATE(n, ip, jp, kp, ip1, jp1, kp1, ab, de, gh, oab, ode, ogh, &
!$OMP& w000, w010, w011, w001, w101, w111, w110, w100) &
!$OMP& SHARED(mesh3d, x, y, z, E, B, n_pts, hxi, hyi, hzi) SCHEDULE(STATIC)
do n = 1, n_pts
  ip = floor((x(n) - mesh3d%min(1)) * hxi + 1)
  jp = floor((y(n) - mesh3d%min(2)) * hyi + 1)
  kp = floor((z(n) - mesh3d%min(3)) * hzi + 1)

  ! Clamp to valid range
  ip = max(1, min(ip, mesh3d%nhi(1) - 1))
  jp = max(1, min(jp, mesh3d%nhi(2) - 1))
  kp = max(1, min(kp, mesh3d%nhi(3) - 1))

  ab  = ((mesh3d%min(1) - x(n)) + ip * mesh3d%delta(1)) * hxi
  de  = ((mesh3d%min(2) - y(n)) + jp * mesh3d%delta(2)) * hyi
  gh  = ((mesh3d%min(3) - z(n)) + kp * mesh3d%delta(3)) * hzi
  oab = 1.0_dp - ab
  ode = 1.0_dp - de
  ogh = 1.0_dp - gh

  ip1 = ip + 1; jp1 = jp + 1; kp1 = kp + 1

  ! Precompute trilinear weights
  w000 = ab  * de  * gh;   w010 = ab  * ode * gh
  w011 = ab  * ode * ogh;  w001 = ab  * de  * ogh
  w101 = oab * de  * ogh;  w111 = oab * ode * ogh
  w110 = oab * ode * gh;   w100 = oab * de  * gh

  if (present(E)) then
    E(1,n) = mesh3d%efield(ip,jp,kp,1)*w000 + mesh3d%efield(ip,jp1,kp,1)*w010 &
           + mesh3d%efield(ip,jp1,kp1,1)*w011 + mesh3d%efield(ip,jp,kp1,1)*w001 &
           + mesh3d%efield(ip1,jp,kp1,1)*w101 + mesh3d%efield(ip1,jp1,kp1,1)*w111 &
           + mesh3d%efield(ip1,jp1,kp,1)*w110 + mesh3d%efield(ip1,jp,kp,1)*w100
    E(2,n) = mesh3d%efield(ip,jp,kp,2)*w000 + mesh3d%efield(ip,jp1,kp,2)*w010 &
           + mesh3d%efield(ip,jp1,kp1,2)*w011 + mesh3d%efield(ip,jp,kp1,2)*w001 &
           + mesh3d%efield(ip1,jp,kp1,2)*w101 + mesh3d%efield(ip1,jp1,kp1,2)*w111 &
           + mesh3d%efield(ip1,jp1,kp,2)*w110 + mesh3d%efield(ip1,jp,kp,2)*w100
    E(3,n) = mesh3d%efield(ip,jp,kp,3)*w000 + mesh3d%efield(ip,jp1,kp,3)*w010 &
           + mesh3d%efield(ip,jp1,kp1,3)*w011 + mesh3d%efield(ip,jp,kp1,3)*w001 &
           + mesh3d%efield(ip1,jp,kp1,3)*w101 + mesh3d%efield(ip1,jp1,kp1,3)*w111 &
           + mesh3d%efield(ip1,jp1,kp,3)*w110 + mesh3d%efield(ip1,jp,kp,3)*w100
  endif

  if (present(B)) then
    B(1,n) = mesh3d%bfield(ip,jp,kp,1)*w000 + mesh3d%bfield(ip,jp1,kp,1)*w010 &
           + mesh3d%bfield(ip,jp1,kp1,1)*w011 + mesh3d%bfield(ip,jp,kp1,1)*w001 &
           + mesh3d%bfield(ip1,jp,kp1,1)*w101 + mesh3d%bfield(ip1,jp1,kp1,1)*w111 &
           + mesh3d%bfield(ip1,jp1,kp,1)*w110 + mesh3d%bfield(ip1,jp,kp,1)*w100
    B(2,n) = mesh3d%bfield(ip,jp,kp,2)*w000 + mesh3d%bfield(ip,jp1,kp,2)*w010 &
           + mesh3d%bfield(ip,jp1,kp1,2)*w011 + mesh3d%bfield(ip,jp,kp1,2)*w001 &
           + mesh3d%bfield(ip1,jp,kp1,2)*w101 + mesh3d%bfield(ip1,jp1,kp1,2)*w111 &
           + mesh3d%bfield(ip1,jp1,kp,2)*w110 + mesh3d%bfield(ip1,jp,kp,2)*w100
    B(3,n) = mesh3d%bfield(ip,jp,kp,3)*w000 + mesh3d%bfield(ip,jp1,kp,3)*w010 &
           + mesh3d%bfield(ip,jp1,kp1,3)*w011 + mesh3d%bfield(ip,jp,kp1,3)*w001 &
           + mesh3d%bfield(ip1,jp,kp1,3)*w101 + mesh3d%bfield(ip1,jp1,kp1,3)*w111 &
           + mesh3d%bfield(ip1,jp1,kp,3)*w110 + mesh3d%bfield(ip1,jp,kp,3)*w100
  endif
enddo
!$OMP END PARALLEL DO

end subroutine interpolate_field_batch


!------------------------------------------------------------------------
!+
! Subroutine space_charge_3d(mesh3d, offset, at_cathode, calc_bfield, image_efield)
!
! Performs the space charge calculation using the integrated Green function method
! and FFT-based convolutions. 
!
! Input:
!   mesh3d        -- mesh3d_struct: populated with %rho
!
!   offset        -- real(3), optional: Offset coordinates x0, y0, z0 to evaluate the field,
!                    relative to rho. 
!                    Default: (0,0,0)
!                        For example, an offset of (0,0,10) can be used to compute 
!                        the field at z=+10 m relative to rho. 
!
!   at_cathode    -- logical, optional: Maintain constant voltage at the cathode 
!                       using image charges. Default is False. 
!
!   calc_bfield   -- logical, optional: Calculate the magnetic field mesh3d%bfield
!
!                     Default: False
!
!   image_efield(:,:,:,:) -- real(dp), allocatable, optional: Must be present when at_cathode if true.
!                       
!
! Output:
!   mesh3d        -- mesh3d_struct: populated with %efield, and optionally %bfield                             
!
!
!
! Notes: 
!   The magnetic field components can be calculated by:
!     Bx = -(beta/c) * Ey
!     By =  (beta/c) * Ex
!     Bz = 0
!   The image charges move in the opposite direction, so the signs are flipped. 
!     
!
!-
subroutine space_charge_3d(mesh3d, offset, at_cathode, calc_bfield, image_efield)
type(mesh3d_struct) :: mesh3d
real(dp), allocatable, dimension(:,:,:,:), optional :: image_efield   ! electric field grid
real(dp), optional :: offset(3)
real(dp) :: offset0(3), beta
real(dp), parameter :: c_light = 299792458.0
logical, optional :: at_cathode, calc_bfield
logical :: bcalc

if (present(calc_bfield)) then
  bcalc = calc_bfield
else
  bcalc = .false.
endif

if (.not. present(offset)) then
  offset0 = 0
else
  offset0 = offset
endif

! Free space field
call osc_freespace_solver2(mesh3d%rho, mesh3d%gamma, mesh3d%delta, efield=mesh3d%efield, offset=offset0)

! Optional B field
if (bcalc) then
  beta = sqrt(1-1/mesh3d%gamma**2)
  mesh3d%bfield = 0
  mesh3d%bfield(:,:,:,1) = -(beta/c_light)*mesh3d%efield(:,:,:,2)
  mesh3d%bfield(:,:,:,2) =  (beta/c_light)*mesh3d%efield(:,:,:,1)
endif

! Cathode calc
if (.not. present(at_cathode)) return
if (.not. at_cathode) return

! Allocate scratch array for the image field
if (present(image_efield)) then
  if (.not. allocated(image_efield)) allocate(image_efield, mold=mesh3d%efield)
endif

! Image field, with an offset assuming the cathode is at z=0.
! The offset is the z width of the mesh, plus 2 times the distance of the mesh from the cathode.
offset0(3) = offset0(3) + 2*mesh3d%min(3) + (mesh3d%max(3)-mesh3d%min(3))

! Flip the charge mesh in z, with opposite charge sign
call osc_freespace_solver2(-mesh3d%rho(:,:,size(mesh3d%rho,3):1:-1), &
  mesh3d%gamma, mesh3d%delta, efield=image_efield, offset=offset0)  
  
  
! Finally add fields
if (bcalc) then
  ! Opposite sign for beta, because image charges are moving in the negative z direction
  mesh3d%bfield(:,:,:,1) = mesh3d%bfield(:,:,:,1) + (beta/c_light)*image_efield(:,:,:,2)
  mesh3d%bfield(:,:,:,2) = mesh3d%bfield(:,:,:,2) - (beta/c_light)*image_efield(:,:,:,1)
endif  
    
mesh3d%efield = mesh3d%efield + image_efield

end subroutine



!------------------------------------------------------------------------
!+
! Subroutine osc_freespace_solver2(rho, gamma, delta, efield, phi, offset)
!
! Deposits particle arrays onto mesh
!
! Input:
!   rho          -- REAL64(:,:,:): charge density array in x, y, z
!   delta        -- REAL64(3): vector of grid spacings dx, dy, dz
!   gamma        -- REAL64: relativistic gamma
!   icomp        -- integer: Field component requested:
!                        0: phi (scalar potential)
!                       
!
!   efield        -- REAL64(:,:,:,3), optional: allocated electric field array to populate.
!                      
!                                     The final index corresponds to components
!                                     1: Ex
!                                     2: Ey
!                                     3: Ez                                   
!                                     If present, all components will be computed.    
!
!   phi           -- REAL64(:,:,:), optional: allocated potential array to populate
!
!   offset        -- real(3), optional: Offset coordinates x0, y0, z0 to evaluate the field,
!                    relative to rho. 
!                    Default: (0,0,0)
!                        For example, an offset of (0,0,10) can be used to compute 
!                        the field at z=+10 m relative to rho. 
!
! Output:
!   efield        -- REAL64(:,:,:,:) : electric field                                 
!   phi           -- REAL64(:,:,:)   : potential
!
!
! Notes: 
!   The magnetic field components can be calculated by:
!     Bx = -(beta/c) * Ey
!     By =  (beta/c) * Ex
!     Bz = 0
!
!-
subroutine osc_freespace_solver2(rho, gamma, delta, efield, phi, offset)


real(dp), intent(in), dimension(:,:,:) :: rho
real(dp), intent(in) :: gamma, delta(3)
real(dp), optional, intent(out), dimension(:,:,:,:) :: efield
real(dp), optional, intent(out), dimension(:,:,:) :: phi
real(dp), intent(in), optional :: offset(3)
! The density, Green functions, and fields are all real so real-to-complex FFTs are used, which
! only store the non-redundant half (nh = nx2/2+1) of each spectrum along x.
! Persistent scratch arrays — only reallocated when doubled mesh size changes
real(dp), allocatable, save, dimension(:,:,:) :: rbuf      ! (nx2, ny2, nz2): padded rho, Green function, field
complex(dp), allocatable, save, dimension(:,:,:) :: crho, cprod  ! (nh, ny2, nz2)
integer, save :: alloc_nx2 = 0, alloc_ny2 = 0, alloc_nz2 = 0
! Green function FFT cache — avoids recomputing when (delta, gamma, offset, mesh size) unchanged
complex(dp), allocatable, save, dimension(:,:,:,:) :: grn_fft_cache  ! (nh, ny2, nz2, 0:3)
real(dp), save :: grn_cache_delta(3) = 0
real(dp), save :: grn_cache_gamma = -1
real(dp), save :: grn_cache_offset(3) = 0
integer, save :: grn_cache_nx2 = 0, grn_cache_ny2 = 0, grn_cache_nz2 = 0
logical, save :: grn_cache_valid(0:3) = .false.
real(dp) :: factr, offset_eff(3)
real(dp), parameter :: clight=299792458.0
real(dp), parameter :: fpei=299792458.0**2*1.00000000055d-7  ! this is 1/(4 pi eps0) after the 2019 SI changes

integer :: nx, ny, nz, nx2, ny2, nz2, nh
integer :: icomp, ishift, jshift, kshift, j, k
logical :: cache_hit

! Sizes
nx = size(rho, 1); ny = size(rho, 2); nz = size(rho, 3)
nx2 = 2*nx; ny2 = 2*ny; nz2 = 2*nz; 
nh = nx2/2 + 1

! Allocate scratch arrays only when size changes.
! Thread safety: guard with OMP CRITICAL in case this is ever called from a parallel region.
!$OMP CRITICAL (solver2_scratch_lock)
if (nx2 /= alloc_nx2 .or. ny2 /= alloc_ny2 .or. nz2 /= alloc_nz2) then
  if (allocated(rbuf)) deallocate(rbuf, crho, cprod)
  allocate(rbuf(nx2, ny2, nz2), crho(nh, ny2, nz2), cprod(nh, ny2, nz2))
  call osc_padded_fft_plan(rbuf, crho, cprod, nx, ny, nz)
  alloc_nx2 = nx2; alloc_ny2 = ny2; alloc_nz2 = nz2
endif
!$OMP END CRITICAL (solver2_scratch_lock)

! Effective offset (treat absent as zero for cache key)
if (present(offset)) then
  offset_eff = offset
else
  offset_eff = 0
endif

! Check if Green function FFT cache is valid for current parameters
cache_hit = (nx2 == grn_cache_nx2 .and. ny2 == grn_cache_ny2 .and. nz2 == grn_cache_nz2 .and. &
             all(delta == grn_cache_delta) .and. gamma == grn_cache_gamma .and. &
             all(offset_eff == grn_cache_offset))
if (.not. cache_hit) then
  grn_cache_valid = .false.
  grn_cache_delta = delta
  grn_cache_gamma = gamma
  grn_cache_offset = offset_eff
  grn_cache_nx2 = nx2; grn_cache_ny2 = ny2; grn_cache_nz2 = nz2
  if (allocated(grn_fft_cache)) then
    if (size(grn_fft_cache, 1) /= nh .or. size(grn_fft_cache, 2) /= ny2 .or. &
        size(grn_fft_cache, 3) /= nz2) then
      deallocate(grn_fft_cache)
      allocate(grn_fft_cache(nh, ny2, nz2, 0:3))
    endif
  else
    allocate(grn_fft_cache(nh, ny2, nz2, 0:3))
  endif
endif

! rho -> rbuf -> FFT -> crho
! The padded transform only reads the x lines that hold data, so only those are filled.
!$OMP PARALLEL DO PRIVATE(j)
do k = 1, nz
  do j = 1, ny
    rbuf(1:nx, j, k) = rho(:, j, k)
    rbuf(nx+1:nx2, j, k) = 0
  enddo
enddo
!$OMP END PARALLEL DO
call osc_padded_fft_forward(rbuf, crho, nx, ny, nz)

! Loop over phi, Ex, Ey, Ez
do icomp=0, 3
  if ((icomp == 0) .and. (.not. present(phi))) cycle
  if ((icomp == 1) .and. (.not. present(efield))) exit

  if (.not. grn_cache_valid(icomp)) then
    ! Cache miss: compute Green function, forward FFT into the cache
    call osc_get_rgrn_freespace(rbuf, delta, gamma, icomp, offset=offset_eff)
    call rcfft3d(rbuf, grn_fft_cache(:,:,:,icomp), nx2, ny2, nz2)
    grn_cache_valid(icomp) = .true.
  endif
  !$OMP PARALLEL DO
  do k = 1, nz2
    cprod(:, :, k) = crho(:, :, k) * grn_fft_cache(:, :, k, icomp)
  enddo
  !$OMP END PARALLEL DO

  ! Inverse FFT. Only the octant extracted below is computed.
  call osc_padded_fft_backward(cprod, rbuf, nx, ny, nz)
  
  ! This is where the output is shifted to
  ishift = nx-1
  jshift = ny-1
  kshift = nz-1
  
  ! Extract field
  factr = fpei/(nx2*ny2*nz2)
  
  !$OMP PARALLEL DO
  do k = 1, nz
    if (icomp == 0) then
      phi(:,:,k) = factr * rbuf(1+ishift:nx+ishift, 1+jshift:ny+jshift, k+kshift)
    else
      efield(:,:,k,icomp) = factr * rbuf(1+ishift:nx+ishift, 1+jshift:ny+jshift, k+kshift)
    endif
  enddo
  !$OMP END PARALLEL DO
    
enddo

end subroutine osc_freespace_solver2


!------------------------------------------------------------------------
!+
! Subroutine osc_padded_fft_plan(rbuf, crho, cprod, nx, ny, nz)
!
! Makes the FFTW plans used by osc_padded_fft_forward and osc_padded_fft_backward on the
! solver's own scratch arrays, which must not be moved or reallocated while the plans are in use.
! The arrays are overwritten (FFTW_MEASURE).
!
! The convolution in osc_freespace_solver2 transforms a (2nx, 2ny, 2nz) array that is zero outside
! (1:nx, 1:ny, 1:nz), and only uses one (nx, ny, nz) octant of the inverse transform. Doing the 3D
! transforms one dimension at a time allows skipping the 1D transforms of lines that are all zero
! (forward) or that are not used (backward): x lines only for 1/4 of the (j, k), y lines only for 1/2
! of the k. This is about 40% less work than full 3D transforms and gives the same result up to
! round-off.
!
! Input:
!   rbuf(2nx, 2ny, 2nz)       -- real(dp): Real scratch array.
!   crho(nx+1, 2ny, 2nz)      -- complex(dp): Forward transform output.
!   cprod(nx+1, 2ny, 2nz)     -- complex(dp): Backward transform input (overwritten by the transform).
!   nx, ny, nz                -- integer: Unpadded mesh size.
!-

subroutine osc_padded_fft_plan(rbuf, crho, cprod, nx, ny, nz)
use, intrinsic :: iso_c_binding
use fft_interface_mod, only: fft_cache_init
include 'fftw3.f03'

integer :: nx, ny, nz
real(C_DOUBLE) :: rbuf(2*nx, 2*ny, 2*nz)
complex(C_DOUBLE_COMPLEX) :: crho(nx+1, 2*ny, 2*nz), cprod(nx+1, 2*ny, 2*nz)
type(fftw_iodim) :: dim(1), hm(2)
integer(C_INT) :: n1, n2, n3, nh

n1 = 2*nx; n2 = 2*ny; n3 = 2*nz; nh = nx+1

call fft_cache_init()
if (c_associated(pfft_r2c_x)) then
  call fftw_destroy_plan(pfft_r2c_x); call fftw_destroy_plan(pfft_fwd_y); call fftw_destroy_plan(pfft_fwd_z)
  call fftw_destroy_plan(pfft_bwd_z); call fftw_destroy_plan(pfft_bwd_y); call fftw_destroy_plan(pfft_c2r_x)
endif

! Forward: x (data lines only), y (data planes only), z (all lines).
dim(1) = fftw_iodim(n1, 1, 1)
hm(1) = fftw_iodim(ny, n1, nh)
hm(2) = fftw_iodim(nz, n1*n2, nh*n2)
pfft_r2c_x = fftw_plan_guru_dft_r2c(1, dim, 2, hm, rbuf, crho, FFTW_MEASURE)

dim(1) = fftw_iodim(n2, nh, nh)
hm(1) = fftw_iodim(nh, 1, 1)
hm(2) = fftw_iodim(nz, nh*n2, nh*n2)
pfft_fwd_y = fftw_plan_guru_dft(1, dim, 2, hm, crho, crho, FFTW_FORWARD, FFTW_MEASURE)

dim(1) = fftw_iodim(n3, nh*n2, nh*n2)
hm(1) = fftw_iodim(nh*n2, 1, 1)
pfft_fwd_z = fftw_plan_guru_dft(1, dim, 1, hm, crho, crho, FFTW_FORWARD, FFTW_MEASURE)

! Backward: z (all lines), y (output planes k = nz:2nz-1 only), x (output lines j = ny:2ny-1 only).
pfft_bwd_z = fftw_plan_guru_dft(1, dim, 1, hm, cprod, cprod, FFTW_BACKWARD, FFTW_MEASURE)

dim(1) = fftw_iodim(n2, nh, nh)
hm(1) = fftw_iodim(nh, 1, 1)
hm(2) = fftw_iodim(nz, nh*n2, nh*n2)
pfft_bwd_y = fftw_plan_guru_dft(1, dim, 2, hm, cprod(1,1,nz), cprod(1,1,nz), FFTW_BACKWARD, FFTW_MEASURE)

dim(1) = fftw_iodim(n1, 1, 1)
hm(1) = fftw_iodim(ny, nh, n1)
hm(2) = fftw_iodim(nz, nh*n2, n1*n2)
pfft_c2r_x = fftw_plan_guru_dft_c2r(1, dim, 2, hm, cprod(1,ny,nz), rbuf(1,ny,nz), FFTW_MEASURE)

end subroutine osc_padded_fft_plan

!------------------------------------------------------------------------
!+
! Subroutine osc_padded_fft_forward(rbuf, crho, nx, ny, nz)
!
! Real-to-complex transform of rbuf into crho (see osc_padded_fft_plan). Same result as
! rcfft3d(rbuf, crho, 2nx, 2ny, 2nz) when rbuf is zero outside (1:nx, 1:ny, 1:nz). Only the lines
! rbuf(:, 1:ny, 1:nz) are read, and must be zero for x > nx.
!
! Input:
!   rbuf(2nx, 2ny, 2nz)  -- real(dp): The array the plans were made with.
!   crho(nx+1, 2ny, 2nz) -- complex(dp): The array the plans were made with.
!   nx, ny, nz           -- integer: Unpadded mesh size.
!
! Output:
!   crho                 -- complex(dp): Half spectrum.
!-

subroutine osc_padded_fft_forward(rbuf, crho, nx, ny, nz)
use, intrinsic :: iso_c_binding
include 'fftw3.f03'

integer :: nx, ny, nz, k
real(C_DOUBLE) :: rbuf(2*nx, 2*ny, 2*nz)
complex(C_DOUBLE_COMPLEX) :: crho(nx+1, 2*ny, 2*nz)

call fftw_execute_dft_r2c(pfft_r2c_x, rbuf, crho)

! The y and z transforms read lines the x transform did not write. Those are zero.
!$OMP PARALLEL DO
do k = 1, 2*nz
  if (k <= nz) then
    crho(:, ny+1:2*ny, k) = 0
  else
    crho(:, :, k) = 0
  endif
enddo
!$OMP END PARALLEL DO

call fftw_execute_dft(pfft_fwd_y, crho, crho)
call fftw_execute_dft(pfft_fwd_z, crho, crho)

end subroutine osc_padded_fft_forward

!------------------------------------------------------------------------
!+
! Subroutine osc_padded_fft_backward(cprod, rbuf, nx, ny, nz)
!
! Complex-to-real transform of cprod into rbuf (see osc_padded_fft_plan). Same as
! crfft3d(cprod, rbuf, 2nx, 2ny, 2nz) in rbuf(:, ny:2ny-1, nz:2nz-1). The rest of rbuf is not set.
!
! Input:
!   cprod(nx+1, 2ny, 2nz) -- complex(dp): The array the plans were made with. Overwritten.
!   rbuf(2nx, 2ny, 2nz)   -- real(dp): The array the plans were made with.
!   nx, ny, nz            -- integer: Unpadded mesh size.
!
! Output:
!   rbuf                  -- real(dp): Transform in the octant above.
!-

subroutine osc_padded_fft_backward(cprod, rbuf, nx, ny, nz)
use, intrinsic :: iso_c_binding
include 'fftw3.f03'

integer :: nx, ny, nz
real(C_DOUBLE) :: rbuf(2*nx, 2*ny, 2*nz)
complex(C_DOUBLE_COMPLEX) :: cprod(nx+1, 2*ny, 2*nz)

call fftw_execute_dft(pfft_bwd_z, cprod, cprod)
call fftw_execute_dft(pfft_bwd_y, cprod(1,1,nz), cprod(1,1,nz))
call fftw_execute_dft_c2r(pfft_c2r_x, cprod(1,ny,nz), rbuf(1,ny,nz))

end subroutine osc_padded_fft_backward

!------------------------------------------------------------------------
!+
! Subroutine osc_get_rgrn_freespace(rgrn, delta, gamma, icomp, offset)
!
! Computes the free space Green function on a mesh with given spacings in the lab frame.
! The computation is performed in the rest fram by boosting the coordinates by gamma.
!
!
! Input:
!   rgrn         -- REAL64(:,:,:): pre-allocated array
!   delta        -- REAL64(3): vector of grid spacings dx, dy, dz
!   gamma        -- REAL64: relativistic gamma
!   icomp        -- integer: Field component requested:
!                        0: phi (scalar potential)
!                        1: Ex
!                        2: Ey
!                        3: Ez
!   offset        -- real(3), optional: Offset coordinates for the center of the grid in [m]. 
!                    Default: (0,0,0)
!                        For example, an offset of (0,0,10) can be used to compute 
!                        the field at z=+10 m relative to the rho_mesh center. 
!                              
! Output:
!   rgrn         -- REAL64(:,:,:): Green function array
!   
!                
! Notes:
!   Internally, dz -> dz*gamma.             
!   For efficients, the indefinite functions lafun2, xlafun2 are actually evaluated 
!   on a grid slightly offset by -dx/2, -dy/2, -dz/2,
!   and these points are used to evaluate the integral with array addition and subtraction. 
!
!-
subroutine osc_get_rgrn_freespace(rgrn, delta, gamma, icomp, offset)

real(dp), intent(out), dimension(:,:,:) :: rgrn
real(dp), intent(in), dimension(3) :: delta
integer, intent(in) :: icomp
real(dp), intent(in) :: gamma
real(dp), intent(in), optional :: offset(3)
! Local
real(dp) :: dx,dy,dz
real(dp) :: u,v,w, umin, vmin, wmin
real(dp) :: gval, factor
integer :: imin, imax, jmin, jmax, kmin, kmax
real(dp), allocatable, save :: rdiff(:,:,:), fq(:,:,:)
integer :: i,j,k, isize, jsize, ksize, ih, jh, kh, mi, mj, mk
real(dp) :: si, sj, sk, px, py, pz
logical :: use_symmetry

! Mesh spacings. dz is stretched in the rest frame.
dx=delta(1); dy=delta(2); dz=delta(3)*gamma

! Special cases: Ex and Ey are enhanced by gamma
if ((icomp==1) .or. (icomp==2)) then
  factor = gamma /(dx*dy*dz)
else
  factor = 1.0 /(dx*dy*dz)
endif

! Evaluate on an offset grid, for use in the indefinite integral evaluation below. 
isize = size(rgrn,1); jsize=size(rgrn,2); ksize=size(rgrn,3)
umin = (0.5-isize/2) *dx
vmin = (0.5-jsize/2) *dy
wmin = (0.5-ksize/2) *dz

! Add optional offset
if (present(offset)) then
  umin = umin + offset(1)
  vmin = vmin + offset(2) 
  wmin = wmin + offset(3)*gamma ! Don't forget this!
endif

! Without an offset (and with even sizes) the evaluation grid is symmetric about zero and cell i
! mirrors cell isize-i. The cell integrals then have the parity of the integrand: 1/r is even in all
! coordinates, and the Ex, Ey, Ez kernels are odd in x, y, z respectively. So only the upper octant of
! cells needs evaluating (~1/8 of the work); the rest follow by reflection.

use_symmetry = (mod(isize, 2) == 0 .and. mod(jsize, 2) == 0 .and. mod(ksize, 2) == 0)
if (present(offset)) use_symmetry = use_symmetry .and. all(offset == 0)

if (use_symmetry) then
  call rgrn_by_symmetry()
  return
endif

!$OMP PARALLEL DO &
!$OMP DEFAULT(FIRSTPRIVATE), &
!$OMP SHARED(rgrn)
do k = 1, ksize
  w = (k-1)*dz + wmin

  do j=1, jsize
    v=(j-1)*dy + vmin

   do i=1, isize
     u = (i-1)*dx + umin

     if(icomp == 0) gval=lafun2(u,v,w)*factor
     if(icomp == 1) gval=xlafun2(u,v,w)*factor
     if(icomp == 2) gval=xlafun2(v,w,u)*factor
     if(icomp == 3) gval=xlafun2(w,u,v)*factor
     rgrn(i,j,k) = gval

    enddo
  enddo
enddo
!$OMP END PARALLEL DO

! Evaluate the indefinite integral over the cube     
!rgrn = rgrn(1:,1:,1:) - rgrn(:-1,1:,1:) - rgrn(1:,:-1,1:) - rgrn(1:,1:,:-1) - rgrn(:-1,:-1,:-1) + rgrn(:-1,:-1,1:) + rgrn(:-1,1:,:-1)  + rgrn(1:,:-1,:-1)
!       (x2,y2,z2) -      (x1,y2,z2) -     (x2,y1,z2) -    (x2,y2,z1) -    (x1,y1,z1)   +    (x1,y1,z2)   +    (x1,y2,z1)  +    (x2,y1,z1)
! Computed into a scratch array (not in place) so that planes can be done in parallel.
if (allocated(rdiff)) then
  if (any(shape(rdiff) /= [isize-1, jsize-1, ksize-1])) deallocate(rdiff)
endif
if (.not. allocated(rdiff)) allocate(rdiff(isize-1, jsize-1, ksize-1))

!$OMP PARALLEL DO
do k = 1, ksize-1
  rdiff(:, :, k) = &
    + rgrn(2:isize,   2:jsize,   k+1) &
    - rgrn(1:isize-1, 2:jsize,   k+1) &
    - rgrn(2:isize,   1:jsize-1, k+1) &
    - rgrn(2:isize,   2:jsize,   k) &
    - rgrn(1:isize-1, 1:jsize-1, k) &
    + rgrn(1:isize-1, 1:jsize-1, k+1) &
    + rgrn(1:isize-1, 2:jsize,   k)  &
    + rgrn(2:isize,   1:jsize-1, k)
enddo
!$OMP END PARALLEL DO

!$OMP PARALLEL DO
do k = 1, ksize-1
  rgrn(1:isize-1, 1:jsize-1, k) = rdiff(:, :, k)
enddo
!$OMP END PARALLEL DO

!------------------------------------------------------------------------
contains

! Indefinite integral at grid point (u, v, w), scaled. Same expression as the full evaluation above.

function grn_point(u, v, w) result (gval)
real(dp) :: u, v, w, gval
select case (icomp)
case (0); gval = lafun2(u,v,w)*factor
case (1); gval = xlafun2(u,v,w)*factor
case (2); gval = xlafun2(v,w,u)*factor
case default; gval = xlafun2(w,u,v)*factor
end select
end function grn_point

!------------------------------------------------------------------------
! Symmetric evaluation. Upper-octant cells and the undifferenced last planes are computed exactly as in
! the full evaluation; the other cells are reflections of upper-octant cells.

subroutine rgrn_by_symmetry()

real(dp) :: u, v, w

ih = isize / 2;  jh = jsize / 2;  kh = ksize / 2

if (allocated(fq)) then
  if (any(lbound(fq) /= [ih, jh, kh]) .or. any(ubound(fq) /= [isize, jsize, ksize])) deallocate(fq)
endif
if (.not. allocated(fq)) allocate(fq(ih:isize, jh:jsize, kh:ksize))

!$OMP PARALLEL DO PRIVATE(i, j, u, v, w)
do k = kh, ksize
  w = (k-1)*dz + wmin
  do j = jh, jsize
    v = (j-1)*dy + vmin
    do i = ih, isize
      u = (i-1)*dx + umin
      fq(i,j,k) = grn_point(u, v, w)
    enddo
  enddo
enddo
!$OMP END PARALLEL DO

!$OMP PARALLEL DO
do k = kh, ksize-1
  rgrn(ih:isize-1, jh:jsize-1, k) = &
    + fq(ih+1:isize,   jh+1:jsize,   k+1) &
    - fq(ih:isize-1,   jh+1:jsize,   k+1) &
    - fq(ih+1:isize,   jh:jsize-1,   k+1) &
    - fq(ih+1:isize,   jh+1:jsize,   k) &
    - fq(ih:isize-1,   jh:jsize-1,   k) &
    + fq(ih:isize-1,   jh:jsize-1,   k+1) &
    + fq(ih:isize-1,   jh+1:jsize,   k)  &
    + fq(ih+1:isize,   jh:jsize-1,   k)
enddo
!$OMP END PARALLEL DO

px = 1;  py = 1;  pz = 1
if (icomp == 1) px = -1
if (icomp == 2) py = -1
if (icomp == 3) pz = -1

! Cells with any index below the center. Their mirror cells are all in the upper octant, which is
! only read here, so the loop is free of races.
!$OMP PARALLEL DO PRIVATE(i, j, mi, mj, mk, si, sj, sk)
do k = 1, ksize-1
  mk = k;  sk = 1
  if (k < kh) then
    mk = ksize - k;  sk = pz
  endif
  do j = 1, jsize-1
    mj = j;  sj = 1
    if (j < jh) then
      mj = jsize - j;  sj = py
    endif
    do i = 1, isize-1
      if (i >= ih .and. j >= jh .and. k >= kh) cycle
      mi = i;  si = 1
      if (i < ih) then
        mi = isize - i;  si = px
      endif
      rgrn(i,j,k) = (si * sj * sk) * rgrn(mi,mj,mk)
    enddo
  enddo
enddo
!$OMP END PARALLEL DO

! The last plane in each dimension is never differenced and holds the indefinite integral itself.
!$OMP PARALLEL DO PRIVATE(i, j, u, v, w)
do k = 1, ksize
  w = (k-1)*dz + wmin
  do j = 1, jsize
    v = (j-1)*dy + vmin
    if (j == jsize .or. k == ksize) then
      do i = 1, isize
        u = (i-1)*dx + umin
        rgrn(i,j,k) = grn_point(u, v, w)
      enddo
    else
      u = (isize-1)*dx + umin
      rgrn(isize,j,k) = grn_point(u, v, w)
    endif
  enddo
enddo
!$OMP END PARALLEL DO

end subroutine rgrn_by_symmetry

end subroutine osc_get_rgrn_freespace


!------------------------------------------------------------------------
!+
! elemental real(dp) function xlafun2(x, y, z)
!
! The indefinite integral:
! \int x/r^3 dx dy dz = x*atan((y*z)/(r*x)) -z*log(r+y) + y*log((r-z)/(r+z))/2
!
! This corresponds to the electric field component Ex.
! Other components can be computed by permuting the arguments
!
!-
elemental real(dp) function xlafun2(x, y, z)
  real(dp), intent(in) :: x, y, z
  real(dp) :: r
  r=sqrt(x**2+y**2+z**2)
  xlafun2 = x*atan((y*z)/(r*x)) -z*log(r+y) + y*log((r-z)/(r+z))/2
end function

!------------------------------------------------------------------------
!+
! elemental real(dp) function lafun2(x,y,z)
!
! The indefinite integral:
! \int 1/r dx dy dz = 
!          -z**2*atan(x*y/(z*r))/2 - y**2*atan(x*z/(y*r))/2 -x**2*atan(y*z/(x*r))/2 
!           +y*z*log(x+r) + x*z*log(y+r) + x*y*log(z+r)
!
! This corresponds to the scalar potential.
! Other components can be computed by permuting the arguments
!
!-
elemental real(dp) function lafun2(x,y,z)
  real(dp), intent(in) :: x, y, z
  real(dp) :: r
  r=sqrt(x**2+y**2+z**2)
  lafun2 = -z**2*atan(x*y/(z*r))/2 - y**2*atan(x*z/(y*r))/2 -x**2*atan(y*z/(x*r))/2 &
           +y*z*log(x+r) + x*z*log(y+r) + x*y*log(z+r)
end function 


end module
