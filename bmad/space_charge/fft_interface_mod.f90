module fft_interface_mod

use fast_fourier_am

implicit none
! Fortran 2008
integer, parameter, private :: dp = REAL64

contains



! Old routines, using numerical recipes routines 
#ifdef NO_USE_FFTW

!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
subroutine ccfft3d(a,b,idir,n1,n2,n3,iskiptrans)
implicit none
integer, dimension(3) :: idir
complex(dp), dimension(:,:,:) :: a,b
complex(dp), allocatable :: tmp1(:,:,:), tmp2(:,:,:)
integer :: n1,n2,n3
integer :: iskiptrans
integer :: ileft,iright,i,j,k
b(:,:,:)=a(:,:,:)
allocate(tmp1(n2,n1,n3))
allocate(tmp2(n3,n2,n1))
if(idir(1).eq.0.and.idir(2).eq.0.and.idir(3).eq.0)return
call mccfft1d(b,n2*n3,n1,idir(1))
forall(k=1:n3, j=1:n2, i=1:n1)
! there's some problem with the commented out statements
!       iright=(k-1)*n1*n2+(j-1)*n2+i
!       ileft =(k-1)*n2*n1+(i-1)*n1+j
!       tmp(ileft)=b(iright)
  tmp1(j,i,k)=b(i,j,k)
end forall

call mccfft1d(tmp1,n3*n1,n2,idir(2))
forall(k=1:n3, j=1:n2, i=1:n1)
!       iright=(k-1)*n2*n1+(i-1)*n1+j
!       ileft =(i-1)*n2*n3+(j-1)*n3+k
!       b(ileft)=tmp(iright)
  tmp2(k,j,i)=tmp1(j,i,k)
end forall

call mccfft1d(tmp2,n1*n2,n3,idir(3))
if(iskiptrans.eq.1)return
forall(k=1:n3, j=1:n2, i=1:n1)
!       ileft =(k-1)*n1*n2+(j-1)*n2+i
!       iright=(i-1)*n2*n3+(j-1)*n3+k
!       b(ileft)=tmp(iright)
        b(i,j,k)=tmp2(k,j,i)
end forall

end subroutine 
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!-------------------------------ccfftnr-----------------------------------------
!+
subroutine mccfft1d(a,ntot,lenfft,idir)
implicit none
complex(dp), dimension(*) :: a
integer :: ntot,lenfft,idir
integer :: n,ierr
do n=1,ntot*lenfft,lenfft
  call ccfftam(a(n),lenfft,idir,ierr)  ! Alan Miller version of FFT package
  !call my_fft(a(n),lenfft,idir) ! FFTW
  !ierr =  0
  
  if(ierr.ne.0)then
    write(6,*)'Error return from FFT package due to transform length.'
    write(6,*)'Try increasing the padding by 1 in each dimension and re-run'
    stop
  endif
! call ccfftnr(a(n),lenfft,idir) !numerical recipes power-of-2 routine
! call gsl_fft(a(n),lenfft,idir)
enddo

end

!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine rcfft3d (a, b, n1, n2, n3)
!
! Real-to-complex 3D FFT of a(n1,n2,n3) into the non-redundant half spectrum b(n1/2+1,n2,n3).
! Pair with crfft3d, which uses the opposite sign. See the FFTW version for details.
!-
subroutine rcfft3d(a, b, n1, n2, n3)
implicit none
real(dp), dimension(:,:,:) :: a
complex(dp), dimension(:,:,:) :: b
complex(dp), allocatable :: c(:,:,:)
integer :: n1, n2, n3

allocate(c(n1,n2,n3))
c = a
call ccfft3d(c, c, [-1,-1,-1], n1, n2, n3, 0)
b = c(1:n1/2+1, :, :)
end subroutine

!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine crfft3d (a, b, n1, n2, n3)
!
! Complex-to-real 3D FFT of the half spectrum a(n1/2+1,n2,n3) into b(n1,n2,n3), using
! Hermitian symmetry for the other half. Unnormalized. See the FFTW version for details.
!-
subroutine crfft3d(a, b, n1, n2, n3)
implicit none
complex(dp), dimension(:,:,:) :: a
real(dp), dimension(:,:,:) :: b
complex(dp), allocatable :: c(:,:,:)
integer :: n1, n2, n3, i, j, k

allocate(c(n1,n2,n3))
c(1:n1/2+1, :, :) = a
do k = 1, n3
  do j = 1, n2
    do i = n1/2+2, n1
      c(i,j,k) = conjg(a(n1-i+2, modulo(n2-j+1, n2)+1, modulo(n3-k+1, n3)+1))
    enddo
  enddo
enddo
call ccfft3d(c, c, [1,1,1], n1, n2, n3, 0)
b = real(c, dp)
end subroutine




#else

! FFTW



!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
!
!subroutine gsl_fft(cdata, n_size, i_sign)
!implicit none
!integer :: n_size
!integer(fgsl_size_t):: n
!complex(fgsl_double) :: cdata(n_size)
!integer(fgsl_int) :: status, i_sign
!
!n = n_size
!status = fgsl_fft_complex_radix2_transform(cdata, 1_fgsl_size_t, n, i_sign)
!
!end subroutine


subroutine fft_cache_init()
use, intrinsic :: iso_c_binding
use omp_lib
implicit none
include 'fftw3.f03'
integer :: n_threads
logical, save :: initialized = .false.
! Thread safety: guard module-level state with OMP CRITICAL in case this is
! ever called from a parallel region. fftw_plan_with_nthreads is not thread-safe.
!$OMP CRITICAL (fft_cache_init_lock)
if (.not. initialized) then
  initialized = .true.
  !$ n_threads = omp_get_max_threads()
  !$ if (n_threads > 1) call fftw_plan_with_nthreads(n_threads)
endif
!$OMP END CRITICAL (fft_cache_init_lock)
end subroutine


subroutine ccfft3d(a,b,idir,n1,n2,n3,iskiptrans)
use, intrinsic :: iso_c_binding
implicit none
include 'fftw3.f03'

integer :: idir(3)
complex(C_DOUBLE_COMPLEX), dimension(:,:,:) ::a, b
integer :: fdir, n1, n2, n3, iskiptrans

! Cached plan state
type(C_PTR), save :: plan_fwd = C_NULL_PTR
type(C_PTR), save :: plan_bwd = C_NULL_PTR
integer, save :: cached_n1 = 0, cached_n2 = 0, cached_n3 = 0
complex(C_DOUBLE_COMPLEX), allocatable, save :: plan_buf(:,:,:)

call fft_cache_init()

if (idir(1) == 1) then
  fdir = FFTW_BACKWARD
else
  fdir = FFTW_FORWARD
endif

! Rebuild plans if mesh dimensions changed.
! Thread safety: guard with OMP CRITICAL since FFTW plan creation is not thread-safe.
!$OMP CRITICAL (fft_plan_cache_lock)
if (n1 /= cached_n1 .or. n2 /= cached_n2 .or. n3 /= cached_n3) then
  if (C_ASSOCIATED(plan_fwd)) call fftw_destroy_plan(plan_fwd)
  if (C_ASSOCIATED(plan_bwd)) call fftw_destroy_plan(plan_bwd)
  if (allocated(plan_buf)) deallocate(plan_buf)
  allocate(plan_buf(n1, n2, n3))
  plan_fwd = fftw_plan_dft_3d(n3, n2, n1, plan_buf, plan_buf, FFTW_FORWARD,  FFTW_MEASURE)
  plan_bwd = fftw_plan_dft_3d(n3, n2, n1, plan_buf, plan_buf, FFTW_BACKWARD, FFTW_MEASURE)
  cached_n1 = n1; cached_n2 = n2; cached_n3 = n3
endif
!$OMP END CRITICAL (fft_plan_cache_lock)

if (fdir == FFTW_FORWARD) then
  call fftw_execute_dft(plan_fwd, a, b)
else
  call fftw_execute_dft(plan_bwd, a, b)
endif

end subroutine

!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine rcfft3d (a, b, n1, n2, n3)
!
! Real-to-complex 3D FFT (FFTW forward sign, unnormalized) of a(n1,n2,n3) into the
! non-redundant half spectrum b(n1/2+1,n2,n3). The rest follows from Hermitian symmetry.
! This does about half the work of a complex FFT of the same real data.
!
! Pair with crfft3d for convolutions: crfft3d(rcfft3d(f) * rcfft3d(g)) = n1*n2*n3 * (f circularly convolved with g).
!
! Plans are cached (made with FFTW_MEASURE on internal buffers) and reused for any arrays of
! the same size, which, like ccfft3d, assumes a and b have the alignment of normal allocations.
!-

subroutine rcfft3d(a, b, n1, n2, n3)
use, intrinsic :: iso_c_binding
implicit none
include 'fftw3.f03'

real(C_DOUBLE), dimension(:,:,:) :: a
complex(C_DOUBLE_COMPLEX), dimension(:,:,:) :: b
integer :: n1, n2, n3

type(C_PTR), save :: plan = C_NULL_PTR
integer, save :: cached_n1 = 0, cached_n2 = 0, cached_n3 = 0
real(C_DOUBLE), allocatable :: rbuf(:,:,:)
complex(C_DOUBLE_COMPLEX), allocatable :: cbuf(:,:,:)

call fft_cache_init()

!$OMP CRITICAL (fft_plan_cache_lock)
if (n1 /= cached_n1 .or. n2 /= cached_n2 .or. n3 /= cached_n3) then
  if (C_ASSOCIATED(plan)) call fftw_destroy_plan(plan)
  allocate(rbuf(n1, n2, n3), cbuf(n1/2+1, n2, n3))
  plan = fftw_plan_dft_r2c_3d(n3, n2, n1, rbuf, cbuf, FFTW_MEASURE)
  cached_n1 = n1; cached_n2 = n2; cached_n3 = n3
endif
!$OMP END CRITICAL (fft_plan_cache_lock)

call fftw_execute_dft_r2c(plan, a, b)

end subroutine

!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Subroutine crfft3d (a, b, n1, n2, n3)
!
! Complex-to-real 3D FFT (FFTW backward sign, unnormalized) of the half spectrum
! a(n1/2+1,n2,n3) into b(n1,n2,n3). The inverse of rcfft3d up to a factor n1*n2*n3.
! a is overwritten.
!-

subroutine crfft3d(a, b, n1, n2, n3)
use, intrinsic :: iso_c_binding
implicit none
include 'fftw3.f03'

complex(C_DOUBLE_COMPLEX), dimension(:,:,:) :: a
real(C_DOUBLE), dimension(:,:,:) :: b
integer :: n1, n2, n3

type(C_PTR), save :: plan = C_NULL_PTR
integer, save :: cached_n1 = 0, cached_n2 = 0, cached_n3 = 0
real(C_DOUBLE), allocatable :: rbuf(:,:,:)
complex(C_DOUBLE_COMPLEX), allocatable :: cbuf(:,:,:)

call fft_cache_init()

!$OMP CRITICAL (fft_plan_cache_lock)
if (n1 /= cached_n1 .or. n2 /= cached_n2 .or. n3 /= cached_n3) then
  if (C_ASSOCIATED(plan)) call fftw_destroy_plan(plan)
  allocate(rbuf(n1, n2, n3), cbuf(n1/2+1, n2, n3))
  plan = fftw_plan_dft_c2r_3d(n3, n2, n1, cbuf, rbuf, FFTW_MEASURE)
  cached_n1 = n1; cached_n2 = n2; cached_n3 = n3
endif
!$OMP END CRITICAL (fft_plan_cache_lock)

call fftw_execute_dft_c2r(plan, a, b)

end subroutine



subroutine my_fft(data, n, dir)
use, intrinsic :: iso_c_binding
implicit none
include 'fftw3.f03'
integer :: dir, fdir, n
type(C_PTR) :: plan
complex(C_DOUBLE_COMPLEX), dimension(n) :: data, out


if (dir == 1) then
  fdir = FFTW_BACKWARD
else
  fdir = FFTW_FORWARD
endif

plan = fftw_plan_dft_1d(n, data,data, fdir,FFTW_ESTIMATE)
call fftw_execute_dft(plan, data, data)
call fftw_destroy_plan(plan)

end subroutine

#endif


!------------------------------------------------------------------------
!------------------------------------------------------------------------
!------------------------------------------------------------------------
!+
! Not currently used, Numerical Recipes FFT

subroutine ccfftnr(cdata,nn,isign)
implicit none
integer nn,isign,i,j,n,m,istep,mmax
complex(dp) cdata
real(dp) data
dimension cdata(nn),data(2*nn)
real(dp) tempi,tempr,theta,wpr,wpi,wr,wi,wtemp,twopi
do i=1,nn
  data(2*i-1)=real(cdata(i))
  data(2*i) =aimag(cdata(i))
enddo
! bit reversal:
n=2*nn
j=1
do i=1,n,2
  if(j>i)then
    tempr=data(j)
    tempi=data(j+1)
    data(j)=data(i)
    data(j+1)=data(i+1)
    data(i)=tempr
    data(i+1)=tempi
   endif
  m=n/2
  do while ((m.ge.2).and.(j>m)) 
    j=j-m
    m=m/2
  enddo
  j=j+m
enddo
! Danielson-Lanczos:
twopi=4.0d0*asin(1.0d0)
mmax=2
do while (n>mmax)
  istep=2*mmax
  theta=twopi/(isign*mmax)
  wpr=-2.d0*sin(0.5d0*theta)**2
  wpi=sin(theta)
  wr=1.0
  wi=0.0
  do m=1,mmax,2
    do i=m,n,istep
      j=i+mmax
      tempr=wr*data(j)-wi*data(j+1)
      tempi=wr*data(j+1)+wi*data(j)
      data(j)=data(i)-tempr
      data(j+1)=data(i+1)-tempi
      data(i)=data(i)+tempr
      data(i+1)=data(i+1)+tempi
    enddo
    wtemp=wr
    wr=wr*wpr-wi*wpi+wr
    wi=wi*wpr+wtemp*wpi+wi
  enddo
  mmax=istep
enddo 
!     ezero=0.d0
!     eunit=1.d0
do i=1,nn
  cdata(i)=data(2*i-1)+cmplx(0.d0, data(2*i), dp)
enddo

end subroutine


end module
