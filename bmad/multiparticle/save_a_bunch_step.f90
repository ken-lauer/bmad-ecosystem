!+
! Subroutine save_a_bunch_step (ele, bunch, bunch_track, s_body, is_time_coords)
!
! Routine to save the bunch parameters when tracking a bunch step-by-step.
!     
!
! Input:
!   ele             -- ele_struct: Element being tracked through.
!   bunch           -- bunch_struct: Bunch whose parameters are to be saved.
!   bunch_track     -- bunch_track_struct, optional: Track up to now. If bunch_track%n_pt < 0, the structure will be reinitialized.
!   s_body          -- real(rp), optional: Body s-position from beginning of element.
!   is_time_coords  -- logical, optional: Default is False. If True, input bunch is using time coordinates in which
!                       case there will be a conversion to s-coords before bunch_params are computed.
!
! Output:
!   bunch_track     -- bunch_track_struct, optional: Track with current bunch info appended on. This routine does nothing
!                       if this argument is not present.
!-

subroutine save_a_bunch_step (ele, bunch, bunch_track, s_body, is_time_coords)

use beam_utils, dummy => save_a_bunch_step

implicit none

type (ele_struct), target :: ele
type (bunch_struct) bunch
type (bunch_track_struct), optional, target :: bunch_track

integer n_pt, n, i
real(rp), optional :: s_body
real(rp) s_last, s_here, s_due, s_lo, s_hi, s_err
logical, optional :: is_time_coords
logical err, not_finite

! Init

if (.not. present(bunch_track)) return
if (bunch_track%ds_save < 0) return

if (.not. allocated (bunch_track%pt)) then
  allocate(bunch_track%pt(0:100))
  bunch_track%n_pt = -1
endif

if (bunch_track%n_pt < 0) then
  bunch_track%n_pt = -1
  s_last = -1e30  ! Something large and negative
else
  s_last = bunch_track%pt(bunch_track%n_pt)%s
endif

s_due = s_last + bunch_track%ds_save

if (present(s_body)) then
  s_here = s_body + ele%s_start
  if (s_here < s_due) return
else
  ! The test is on the mean s of the live particles. The mean is within the range of s, give or take the
  ! round-off of the serial sum (less than n*epsilon*max|s|), so for a large bunch the range, which can be
  ! found in parallel, usually decides the test. Otherwise the mean is computed as before.
  n = 0;  s_lo = huge(1.0_rp);  s_hi = -huge(1.0_rp);  not_finite = .false.
  !$OMP parallel do reduction(+:n) reduction(min:s_lo) reduction(max:s_hi) reduction(.or.:not_finite) &
  !$OMP if (size(bunch%particle) > 10000)
  do i = 1, size(bunch%particle)
    if (bunch%particle(i)%state /= alive$) cycle
    n = n + 1
    s_lo = min(s_lo, bunch%particle(i)%s)
    s_hi = max(s_hi, bunch%particle(i)%s)
    if (.not. (abs(bunch%particle(i)%s) <= huge(1.0_rp))) not_finite = .true.
  enddo
  !$OMP end parallel do
  if (n == 0) return

  s_err = 2 * n * epsilon(1.0_rp) * max(abs(s_lo), abs(s_hi))
  if (not_finite .or. (s_hi + s_err >= s_due .and. s_lo - s_err < s_due)) then
    s_here = sum(bunch%particle(:)%s, bunch%particle(:)%state==alive$)/n
    if (s_here < s_due) return
  elseif (s_hi + s_err < s_due) then
    return
  endif
endif

! Save a track point

call bunch_track_add_pt (bunch_track, n_pt)
call calc_bunch_params (bunch, bunch_track%pt(n_pt), err, is_time_coords = is_time_coords, ele = ele)

end subroutine save_a_bunch_step
