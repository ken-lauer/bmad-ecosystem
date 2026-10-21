!+
! Subroutine fft_1d (arr, isign)
!
! 1D discrete FFT of a complex array.
!   fft(k) = sum(j = 0, N-1): A(j) * Exp(isign * 2 * pi * j * k * i_imag / N)
! Where N is the number of data points.
! The algorithm will be most efficient when N is a power of 2.
!
! FFTW plans are cached by size and direction since planning (even with FFTW_ESTIMATE) costs
! much more than a small transform. Plans are made with FFTW_UNALIGNED so that a cached plan
! may be executed on any array of the same size.
!
! Input:
!   arr(:)    -- complex(rp): Input array.
!   isign     -- integer: -1 => "Forward" transform, +1 => "Backwards" transform.
!
! Output:
!   arr(:)    -- complex(rp): FFT of array.
!-

subroutine fft_1d (arr, isign)

use output_mod, only: out_io, rp, global_com, s_error$, real_garbage$
use, intrinsic :: iso_c_binding

implicit none
include 'fftw3.f03'

integer, parameter :: n_cache = 16

complex(rp) arr(:)
complex(rp), allocatable :: tmp(:)
integer isign
integer i, n, dir, ix
integer(8) plan

! Plans are never destroyed: another thread may be executing one. When the cache is full,
! fall back to a plan per call.
integer, save :: cache_size(n_cache) = 0, cache_dir(n_cache) = 0, n_cached = 0
integer(8), save :: cache_plan(n_cache) = 0

character(*), parameter :: r_name = 'fft_1d'

!

select case (isign)
case (1)
  dir = FFTW_BACKWARD
case (-1)
  dir = FFTW_FORWARD
case default
  call out_io(s_error$, r_name, 'BAD ISIGN ARGUMENT.')
  if (global_com%exit_on_error) call err_exit
  arr = real_garbage$
  return
end select

n = size(arr)
plan = 0

! FFTW planning is not thread safe; executing a plan is.
!$OMP CRITICAL (fft_1d_plan)
ix = 0
do i = 1, n_cached
  if (cache_size(i) == n .and. cache_dir(i) == dir) then
    ix = i
    exit
  endif
enddo

if (ix == 0 .and. n_cached < n_cache) then
  allocate (tmp(n))
  n_cached = n_cached + 1
  call dfftw_plan_dft_1d(cache_plan(n_cached), n, tmp, tmp, dir, FFTW_ESTIMATE + FFTW_UNALIGNED)
  cache_size(n_cached) = n
  cache_dir(n_cached) = dir
  ix = n_cached
endif

if (ix == 0) then
  call dfftw_plan_dft_1d(plan, n, arr, arr, dir, FFTW_ESTIMATE)
else
  plan = cache_plan(ix)
endif
!$OMP END CRITICAL (fft_1d_plan)

call dfftw_execute_dft(plan, arr, arr)
if (ix == 0) call dfftw_destroy_plan(plan)

end subroutine
