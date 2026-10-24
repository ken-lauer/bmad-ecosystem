!+
! Module multipole_memo_mod
!
! Memo of multipole_ele_to_ab results while a bunch is tracked through one element.
!
! multipole_ele_to_ab results depend only on the element and the call arguments, yet per-particle
! tracking recomputes them for every particle. Bunch tracking (see track1_bunch_particles in beam_utils)
! records the results while tracking one particle serially, freezes the memo, and then tracks the
! remaining particles in parallel with the memo read-only. Recorded values are exactly what
! multipole_ele_to_ab computed so results are unchanged.
!
! Results are recorded for any element multipole_ele_to_ab is called with during the recording (the
! tracked element, and for example its lords when Runge-Kutta tracking evaluates their fields).
! The memo is cleared for every tracked element, so temporary elements (slices) cannot be confused.
!-

module multipole_memo_mod

use bmad_struct

implicit none

integer, parameter :: memo_off$ = 0, memo_recording$ = 1, memo_frozen$ = 2

type multipole_memo_entry_struct
  type (ele_struct), pointer :: ele => null()
  logical :: use_ele_tilt = .false., has_b1 = .false., original = .false.
  integer :: pole_type = 0, include_kicks = 0
  integer :: ix_pole_max = -1
  real(rp) :: a(0:n_pole_maxx) = 0, b(0:n_pole_maxx) = 0
  real(rp) :: b1 = 0
end type

integer, parameter, private :: n_memo_max = 64

! Shared by all threads: written only while recording (serial), read-only when frozen.
integer :: multipole_memo_state = memo_off$
integer :: multipole_memo_n = 0
type (multipole_memo_entry_struct), target :: multipole_memo(n_memo_max)

contains

!+
! Subroutine multipole_memo_begin ()
!
! Routine to start recording multipole_ele_to_ab results.
!-

subroutine multipole_memo_begin ()
multipole_memo_n = 0
multipole_memo_state = memo_recording$
end subroutine multipole_memo_begin

!+
! Subroutine multipole_memo_freeze ()
!
! Routine to stop recording. The memo is then only read.
!-

subroutine multipole_memo_freeze ()
multipole_memo_state = memo_frozen$
end subroutine multipole_memo_freeze

!+
! Subroutine multipole_memo_end ()
!
! Routine to turn the memo off.
!-

subroutine multipole_memo_end ()
multipole_memo_state = memo_off$
multipole_memo_n = 0
end subroutine multipole_memo_end

!+
! Function multipole_memo_find (ele, use_ele_tilt, pole_type, include_kicks, has_b1, original) result (ix)
!
! Routine to find the memo entry matching a set of multipole_ele_to_ab arguments.
!
! Output:
!   ix  -- integer: Index into multipole_memo, or 0 if there is no matching entry.
!-

function multipole_memo_find (ele, use_ele_tilt, pole_type, include_kicks, has_b1, original) result (ix)
type (ele_struct), target :: ele
logical use_ele_tilt, has_b1, original
integer pole_type, include_kicks, ix, i

ix = 0
do i = 1, multipole_memo_n
  if (.not. associated(multipole_memo(i)%ele, ele)) cycle
  if ((multipole_memo(i)%use_ele_tilt .eqv. use_ele_tilt) .and. multipole_memo(i)%pole_type == pole_type .and. &
      multipole_memo(i)%include_kicks == include_kicks .and. (multipole_memo(i)%has_b1 .eqv. has_b1) .and. &
      (multipole_memo(i)%original .eqv. original)) then
    ix = i
    return
  endif
enddo
end function multipole_memo_find

!+
! Subroutine multipole_memo_add (ele, use_ele_tilt, pole_type, include_kicks, has_b1, original, ix_pole_max, a, b, b1)
!
! Routine to record a multipole_ele_to_ab result. Ignored if the memo is full.
!-

subroutine multipole_memo_add (ele, use_ele_tilt, pole_type, include_kicks, has_b1, original, ix_pole_max, a, b, b1)
type (ele_struct), target :: ele
logical use_ele_tilt, has_b1, original
integer pole_type, include_kicks, ix_pole_max
real(rp) a(0:n_pole_maxx), b(0:n_pole_maxx), b1

if (multipole_memo_n >= n_memo_max) return
multipole_memo_n = multipole_memo_n + 1
multipole_memo(multipole_memo_n) = multipole_memo_entry_struct(null(), use_ele_tilt, has_b1, original, pole_type, &
                                                               include_kicks, ix_pole_max, a, b, b1)
multipole_memo(multipole_memo_n)%ele => ele
end subroutine multipole_memo_add

end module multipole_memo_mod
