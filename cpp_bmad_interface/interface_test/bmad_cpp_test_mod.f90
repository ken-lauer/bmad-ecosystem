module bmad_cpp_test_mod

use json_module, only: json_core, json_value

use bmad_cpp_convert_mod
use equality_mod
use bmad_json
use sim_utils_json

contains

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_spline (ok)

implicit none

type(spline_struct), target :: f_spline, f2_spline

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_spline (c_spline, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_spline
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_spline_test_pattern (f2_spline, 1)

call test_c_spline(c_loc(f2_spline), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_spline_test_pattern (f_spline, 4)
if (f_spline == f2_spline) then
  print *, '[4] spline: C side convert C->F: Good'
else
  print *, '[4] spline: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call spline_struct_to_json(f_spline, json_root)
  call json%print(json_root, 'test_f_spline_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call spline_struct_to_json(f2_spline, json_root)
  call json%print(json_root, 'test_f_spline_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_spline_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_spline_test_pattern (f_spline, -1)
call set_spline_test_pattern (f2_spline, -1)

end subroutine test1_f_spline

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_spline (c_spline, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_spline
type(spline_struct), target :: f_spline, f2_spline
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call spline_to_f (c_spline, c_loc(f_spline))

call set_spline_test_pattern (f2_spline, 2)
if (f_spline == f2_spline) then
  print *, '[2] spline: F side convert C->F: Good'
else
  print *, '[2] spline: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call spline_struct_to_json(f_spline, json_root)
  call json%print(json_root, 'test_f_spline_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call spline_struct_to_json(f2_spline, json_root)
  call json%print(json_root, 'test_f_spline_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_spline_pattern_2_*.json)'

endif

call set_spline_test_pattern (f2_spline, 3)
call spline_to_c (c_loc(f2_spline), c_spline)

! clean up test pattern data - < 3 deallocates arrays and such
call set_spline_test_pattern (f_spline, -1)
call set_spline_test_pattern (f2_spline, -1)

end subroutine test2_f_spline

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_spline_test_pattern (F, ix_patt)

implicit none

type(spline_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%x0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%y0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%x1 = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 4>
do jd1 = 1, size(F%coef,1); lb1 = lbound(F%coef,1) - 1
  rhs = 100 + jd1 + 4 + offset
  F%coef(jd1+lb1) = rhs
enddo

end subroutine set_spline_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_spin_polar (ok)

implicit none

type(spin_polar_struct), target :: f_spin_polar, f2_spin_polar

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_spin_polar (c_spin_polar, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_spin_polar
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_spin_polar_test_pattern (f2_spin_polar, 1)

call test_c_spin_polar(c_loc(f2_spin_polar), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_spin_polar_test_pattern (f_spin_polar, 4)
if (f_spin_polar == f2_spin_polar) then
  print *, '[4] spin_polar: C side convert C->F: Good'
else
  print *, '[4] spin_polar: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call spin_polar_struct_to_json(f_spin_polar, json_root)
  call json%print(json_root, 'test_f_spin_polar_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call spin_polar_struct_to_json(f2_spin_polar, json_root)
  call json%print(json_root, 'test_f_spin_polar_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_spin_polar_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_spin_polar_test_pattern (f_spin_polar, -1)
call set_spin_polar_test_pattern (f2_spin_polar, -1)

end subroutine test1_f_spin_polar

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_spin_polar (c_spin_polar, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_spin_polar
type(spin_polar_struct), target :: f_spin_polar, f2_spin_polar
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call spin_polar_to_f (c_spin_polar, c_loc(f_spin_polar))

call set_spin_polar_test_pattern (f2_spin_polar, 2)
if (f_spin_polar == f2_spin_polar) then
  print *, '[2] spin_polar: F side convert C->F: Good'
else
  print *, '[2] spin_polar: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call spin_polar_struct_to_json(f_spin_polar, json_root)
  call json%print(json_root, 'test_f_spin_polar_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call spin_polar_struct_to_json(f2_spin_polar, json_root)
  call json%print(json_root, 'test_f_spin_polar_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_spin_polar_pattern_2_*.json)'

endif

call set_spin_polar_test_pattern (f2_spin_polar, 3)
call spin_polar_to_c (c_loc(f2_spin_polar), c_spin_polar)

! clean up test pattern data - < 3 deallocates arrays and such
call set_spin_polar_test_pattern (f_spin_polar, -1)
call set_spin_polar_test_pattern (f2_spin_polar, -1)

end subroutine test2_f_spin_polar

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_spin_polar_test_pattern (F, ix_patt)

implicit none

type(spin_polar_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%polarization = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%theta = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%xi = rhs

end subroutine set_spin_polar_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_ac_kicker_time (ok)

implicit none

type(ac_kicker_time_struct), target :: f_ac_kicker_time, f2_ac_kicker_time

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_ac_kicker_time (c_ac_kicker_time, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_ac_kicker_time
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_ac_kicker_time_test_pattern (f2_ac_kicker_time, 1)

call test_c_ac_kicker_time(c_loc(f2_ac_kicker_time), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_ac_kicker_time_test_pattern (f_ac_kicker_time, 4)
if (f_ac_kicker_time == f2_ac_kicker_time) then
  print *, '[4] ac_kicker_time: C side convert C->F: Good'
else
  print *, '[4] ac_kicker_time: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call ac_kicker_time_struct_to_json(f_ac_kicker_time, json_root)
  call json%print(json_root, 'test_f_ac_kicker_time_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ac_kicker_time_struct_to_json(f2_ac_kicker_time, json_root)
  call json%print(json_root, 'test_f_ac_kicker_time_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ac_kicker_time_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_ac_kicker_time_test_pattern (f_ac_kicker_time, -1)
call set_ac_kicker_time_test_pattern (f2_ac_kicker_time, -1)

end subroutine test1_f_ac_kicker_time

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_ac_kicker_time (c_ac_kicker_time, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_ac_kicker_time
type(ac_kicker_time_struct), target :: f_ac_kicker_time, f2_ac_kicker_time
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call ac_kicker_time_to_f (c_ac_kicker_time, c_loc(f_ac_kicker_time))

call set_ac_kicker_time_test_pattern (f2_ac_kicker_time, 2)
if (f_ac_kicker_time == f2_ac_kicker_time) then
  print *, '[2] ac_kicker_time: F side convert C->F: Good'
else
  print *, '[2] ac_kicker_time: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call ac_kicker_time_struct_to_json(f_ac_kicker_time, json_root)
  call json%print(json_root, 'test_f_ac_kicker_time_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ac_kicker_time_struct_to_json(f2_ac_kicker_time, json_root)
  call json%print(json_root, 'test_f_ac_kicker_time_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ac_kicker_time_pattern_2_*.json)'

endif

call set_ac_kicker_time_test_pattern (f2_ac_kicker_time, 3)
call ac_kicker_time_to_c (c_loc(f2_ac_kicker_time), c_ac_kicker_time)

! clean up test pattern data - < 3 deallocates arrays and such
call set_ac_kicker_time_test_pattern (f_ac_kicker_time, -1)
call set_ac_kicker_time_test_pattern (f2_ac_kicker_time, -1)

end subroutine test2_f_ac_kicker_time

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_ac_kicker_time_test_pattern (F, ix_patt)

implicit none

type(ac_kicker_time_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%amp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%time = rhs
!! f_side.test_pat[0D_NOT_type] CPP_spline
call set_spline_test_pattern (F%spline, ix_patt)

end subroutine set_ac_kicker_time_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_ac_kicker_freq (ok)

implicit none

type(ac_kicker_freq_struct), target :: f_ac_kicker_freq, f2_ac_kicker_freq

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_ac_kicker_freq (c_ac_kicker_freq, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_ac_kicker_freq
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_ac_kicker_freq_test_pattern (f2_ac_kicker_freq, 1)

call test_c_ac_kicker_freq(c_loc(f2_ac_kicker_freq), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_ac_kicker_freq_test_pattern (f_ac_kicker_freq, 4)
if (f_ac_kicker_freq == f2_ac_kicker_freq) then
  print *, '[4] ac_kicker_freq: C side convert C->F: Good'
else
  print *, '[4] ac_kicker_freq: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call ac_kicker_freq_struct_to_json(f_ac_kicker_freq, json_root)
  call json%print(json_root, 'test_f_ac_kicker_freq_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ac_kicker_freq_struct_to_json(f2_ac_kicker_freq, json_root)
  call json%print(json_root, 'test_f_ac_kicker_freq_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ac_kicker_freq_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_ac_kicker_freq_test_pattern (f_ac_kicker_freq, -1)
call set_ac_kicker_freq_test_pattern (f2_ac_kicker_freq, -1)

end subroutine test1_f_ac_kicker_freq

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_ac_kicker_freq (c_ac_kicker_freq, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_ac_kicker_freq
type(ac_kicker_freq_struct), target :: f_ac_kicker_freq, f2_ac_kicker_freq
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call ac_kicker_freq_to_f (c_ac_kicker_freq, c_loc(f_ac_kicker_freq))

call set_ac_kicker_freq_test_pattern (f2_ac_kicker_freq, 2)
if (f_ac_kicker_freq == f2_ac_kicker_freq) then
  print *, '[2] ac_kicker_freq: F side convert C->F: Good'
else
  print *, '[2] ac_kicker_freq: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call ac_kicker_freq_struct_to_json(f_ac_kicker_freq, json_root)
  call json%print(json_root, 'test_f_ac_kicker_freq_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ac_kicker_freq_struct_to_json(f2_ac_kicker_freq, json_root)
  call json%print(json_root, 'test_f_ac_kicker_freq_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ac_kicker_freq_pattern_2_*.json)'

endif

call set_ac_kicker_freq_test_pattern (f2_ac_kicker_freq, 3)
call ac_kicker_freq_to_c (c_loc(f2_ac_kicker_freq), c_ac_kicker_freq)

! clean up test pattern data - < 3 deallocates arrays and such
call set_ac_kicker_freq_test_pattern (f_ac_kicker_freq, -1)
call set_ac_kicker_freq_test_pattern (f2_ac_kicker_freq, -1)

end subroutine test2_f_ac_kicker_freq

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_ac_kicker_freq_test_pattern (F, ix_patt)

implicit none

type(ac_kicker_freq_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%f = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%amp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%rf_clock_harmonic = rhs

end subroutine set_ac_kicker_freq_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_ac_kicker (ok)

implicit none

type(ac_kicker_struct), target :: f_ac_kicker, f2_ac_kicker

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_ac_kicker (c_ac_kicker, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_ac_kicker
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_ac_kicker_test_pattern (f2_ac_kicker, 1)

call test_c_ac_kicker(c_loc(f2_ac_kicker), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_ac_kicker_test_pattern (f_ac_kicker, 4)
if (f_ac_kicker == f2_ac_kicker) then
  print *, '[4] ac_kicker: C side convert C->F: Good'
else
  print *, '[4] ac_kicker: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call ac_kicker_struct_to_json(f_ac_kicker, json_root)
  call json%print(json_root, 'test_f_ac_kicker_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ac_kicker_struct_to_json(f2_ac_kicker, json_root)
  call json%print(json_root, 'test_f_ac_kicker_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ac_kicker_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_ac_kicker_test_pattern (f_ac_kicker, -1)
call set_ac_kicker_test_pattern (f2_ac_kicker, -1)

end subroutine test1_f_ac_kicker

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_ac_kicker (c_ac_kicker, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_ac_kicker
type(ac_kicker_struct), target :: f_ac_kicker, f2_ac_kicker
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call ac_kicker_to_f (c_ac_kicker, c_loc(f_ac_kicker))

call set_ac_kicker_test_pattern (f2_ac_kicker, 2)
if (f_ac_kicker == f2_ac_kicker) then
  print *, '[2] ac_kicker: F side convert C->F: Good'
else
  print *, '[2] ac_kicker: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call ac_kicker_struct_to_json(f_ac_kicker, json_root)
  call json%print(json_root, 'test_f_ac_kicker_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ac_kicker_struct_to_json(f2_ac_kicker, json_root)
  call json%print(json_root, 'test_f_ac_kicker_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ac_kicker_pattern_2_*.json)'

endif

call set_ac_kicker_test_pattern (f2_ac_kicker, 3)
call ac_kicker_to_c (c_loc(f2_ac_kicker), c_ac_kicker)

! clean up test pattern data - < 3 deallocates arrays and such
call set_ac_kicker_test_pattern (f_ac_kicker, -1)
call set_ac_kicker_test_pattern (f2_ac_kicker, -1)

end subroutine test2_f_ac_kicker

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_ac_kicker_test_pattern (F, ix_patt)

implicit none

type(ac_kicker_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_ac_kicker_time>
if (ix_patt < 3) then
  if (allocated(F%amp_vs_time)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%amp_vs_time,1), ubound(F%amp_vs_time,1)
      call set_ac_kicker_time_test_pattern (F%amp_vs_time(jd1), -1)
    enddo
    deallocate (F%amp_vs_time)
  endif
else
  if (.not. allocated(F%amp_vs_time)) then
    allocate (F%amp_vs_time(-1:1))
  endif
  do jd1 = 1, size(F%amp_vs_time,1)
    lb1 = lbound(F%amp_vs_time,1) - 1
    call set_ac_kicker_time_test_pattern (F%amp_vs_time(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_ac_kicker_freq>
if (ix_patt < 3) then
  if (allocated(F%frequency)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%frequency,1), ubound(F%frequency,1)
      call set_ac_kicker_freq_test_pattern (F%frequency(jd1), -1)
    enddo
    deallocate (F%frequency)
  endif
else
  if (.not. allocated(F%frequency)) then
    allocate (F%frequency(-1:1))
  endif
  do jd1 = 1, size(F%frequency,1)
    lb1 = lbound(F%frequency,1) - 1
    call set_ac_kicker_freq_test_pattern (F%frequency(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_ac_kicker_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_interval1_coef (ok)

implicit none

type(interval1_coef_struct), target :: f_interval1_coef, f2_interval1_coef

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_interval1_coef (c_interval1_coef, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_interval1_coef
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_interval1_coef_test_pattern (f2_interval1_coef, 1)

call test_c_interval1_coef(c_loc(f2_interval1_coef), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_interval1_coef_test_pattern (f_interval1_coef, 4)
if (f_interval1_coef == f2_interval1_coef) then
  print *, '[4] interval1_coef: C side convert C->F: Good'
else
  print *, '[4] interval1_coef: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call interval1_coef_struct_to_json(f_interval1_coef, json_root)
  call json%print(json_root, 'test_f_interval1_coef_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call interval1_coef_struct_to_json(f2_interval1_coef, json_root)
  call json%print(json_root, 'test_f_interval1_coef_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_interval1_coef_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_interval1_coef_test_pattern (f_interval1_coef, -1)
call set_interval1_coef_test_pattern (f2_interval1_coef, -1)

end subroutine test1_f_interval1_coef

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_interval1_coef (c_interval1_coef, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_interval1_coef
type(interval1_coef_struct), target :: f_interval1_coef, f2_interval1_coef
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call interval1_coef_to_f (c_interval1_coef, c_loc(f_interval1_coef))

call set_interval1_coef_test_pattern (f2_interval1_coef, 2)
if (f_interval1_coef == f2_interval1_coef) then
  print *, '[2] interval1_coef: F side convert C->F: Good'
else
  print *, '[2] interval1_coef: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call interval1_coef_struct_to_json(f_interval1_coef, json_root)
  call json%print(json_root, 'test_f_interval1_coef_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call interval1_coef_struct_to_json(f2_interval1_coef, json_root)
  call json%print(json_root, 'test_f_interval1_coef_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_interval1_coef_pattern_2_*.json)'

endif

call set_interval1_coef_test_pattern (f2_interval1_coef, 3)
call interval1_coef_to_c (c_loc(f2_interval1_coef), c_interval1_coef)

! clean up test pattern data - < 3 deallocates arrays and such
call set_interval1_coef_test_pattern (f_interval1_coef, -1)
call set_interval1_coef_test_pattern (f2_interval1_coef, -1)

end subroutine test2_f_interval1_coef

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_interval1_coef_test_pattern (F, ix_patt)

implicit none

type(interval1_coef_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%c0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%c1 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%n_exp = rhs

end subroutine set_interval1_coef_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_photon_reflect_table (ok)

implicit none

type(photon_reflect_table_struct), target :: f_photon_reflect_table, f2_photon_reflect_table

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_photon_reflect_table (c_photon_reflect_table, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_photon_reflect_table
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_photon_reflect_table_test_pattern (f2_photon_reflect_table, 1)

call test_c_photon_reflect_table(c_loc(f2_photon_reflect_table), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_photon_reflect_table_test_pattern (f_photon_reflect_table, 4)
if (f_photon_reflect_table == f2_photon_reflect_table) then
  print *, '[4] photon_reflect_table: C side convert C->F: Good'
else
  print *, '[4] photon_reflect_table: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call photon_reflect_table_struct_to_json(f_photon_reflect_table, json_root)
  call json%print(json_root, 'test_f_photon_reflect_table_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_reflect_table_struct_to_json(f2_photon_reflect_table, json_root)
  call json%print(json_root, 'test_f_photon_reflect_table_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_reflect_table_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_reflect_table_test_pattern (f_photon_reflect_table, -1)
call set_photon_reflect_table_test_pattern (f2_photon_reflect_table, -1)

end subroutine test1_f_photon_reflect_table

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_photon_reflect_table (c_photon_reflect_table, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_photon_reflect_table
type(photon_reflect_table_struct), target :: f_photon_reflect_table, f2_photon_reflect_table
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call photon_reflect_table_to_f (c_photon_reflect_table, c_loc(f_photon_reflect_table))

call set_photon_reflect_table_test_pattern (f2_photon_reflect_table, 2)
if (f_photon_reflect_table == f2_photon_reflect_table) then
  print *, '[2] photon_reflect_table: F side convert C->F: Good'
else
  print *, '[2] photon_reflect_table: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call photon_reflect_table_struct_to_json(f_photon_reflect_table, json_root)
  call json%print(json_root, 'test_f_photon_reflect_table_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_reflect_table_struct_to_json(f2_photon_reflect_table, json_root)
  call json%print(json_root, 'test_f_photon_reflect_table_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_reflect_table_pattern_2_*.json)'

endif

call set_photon_reflect_table_test_pattern (f2_photon_reflect_table, 3)
call photon_reflect_table_to_c (c_loc(f2_photon_reflect_table), c_photon_reflect_table)

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_reflect_table_test_pattern (f_photon_reflect_table, -1)
call set_photon_reflect_table_test_pattern (f2_photon_reflect_table, -1)

end subroutine test2_f_photon_reflect_table

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_photon_reflect_table_test_pattern (F, ix_patt)

implicit none

type(photon_reflect_table_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%angle)) then
     deallocate (F%angle)
  endif
else
  if (.not. allocated(F%angle)) then
    allocate (F%angle(-1:1))
  endif
  do jd1 = 1, size(F%angle,1)
    lb1 = lbound(F%angle,1) - 1
    rhs = 100 + jd1 + 1 + offset
    F%angle(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%energy)) then
     deallocate (F%energy)
  endif
else
  if (.not. allocated(F%energy)) then
    allocate (F%energy(-1:1))
  endif
  do jd1 = 1, size(F%energy,1)
    lb1 = lbound(F%energy,1) - 1
    rhs = 100 + jd1 + 3 + offset
    F%energy(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_interval1_coef>
if (ix_patt < 3) then
  if (allocated(F%int1)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%int1,1), ubound(F%int1,1)
      call set_interval1_coef_test_pattern (F%int1(jd1), -1)
    enddo
    deallocate (F%int1)
  endif
else
  if (.not. allocated(F%int1)) then
    allocate (F%int1(-1:1))
  endif
  do jd1 = 1, size(F%int1,1)
    lb1 = lbound(F%int1,1) - 1
    call set_interval1_coef_test_pattern (F%int1(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[2D_ALLOC_real] VariableArray2D<Real>
if (ix_patt < 3) then
  if (allocated(F%p_reflect)) deallocate (F%p_reflect)
else
  if (.not. allocated(F%p_reflect)) allocate (F%p_reflect(-1:1, 2))
  do jd1 = 1, size(F%p_reflect,1); lb1 = lbound(F%p_reflect,1) - 1
    do jd2 = 1, size(F%p_reflect,2); lb2 = lbound(F%p_reflect,2) - 1
      rhs = 100 + jd1 + 10*jd2 + 7 + offset
      F%p_reflect(jd1+lb1,jd2+lb2) = rhs
    enddo
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%max_energy = rhs
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%p_reflect_scratch)) then
     deallocate (F%p_reflect_scratch)
  endif
else
  if (.not. allocated(F%p_reflect_scratch)) then
    allocate (F%p_reflect_scratch(-1:1))
  endif
  do jd1 = 1, size(F%p_reflect_scratch,1)
    lb1 = lbound(F%p_reflect_scratch,1) - 1
    rhs = 100 + jd1 + 11 + offset
    F%p_reflect_scratch(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%bragg_angle)) then
     deallocate (F%bragg_angle)
  endif
else
  if (.not. allocated(F%bragg_angle)) then
    allocate (F%bragg_angle(-1:1))
  endif
  do jd1 = 1, size(F%bragg_angle,1)
    lb1 = lbound(F%bragg_angle,1) - 1
    rhs = 100 + jd1 + 13 + offset
    F%bragg_angle(jd1+lb1) = rhs
  enddo
endif

end subroutine set_photon_reflect_table_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_photon_reflect_surface (ok)

implicit none

type(photon_reflect_surface_struct), target :: f_photon_reflect_surface, f2_photon_reflect_surface

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_photon_reflect_surface (c_photon_reflect_surface, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_photon_reflect_surface
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_photon_reflect_surface_test_pattern (f2_photon_reflect_surface, 1)

call test_c_photon_reflect_surface(c_loc(f2_photon_reflect_surface), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_photon_reflect_surface_test_pattern (f_photon_reflect_surface, 4)
if (f_photon_reflect_surface == f2_photon_reflect_surface) then
  print *, '[4] photon_reflect_surface: C side convert C->F: Good'
else
  print *, '[4] photon_reflect_surface: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call photon_reflect_surface_struct_to_json(f_photon_reflect_surface, json_root)
  call json%print(json_root, 'test_f_photon_reflect_surface_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_reflect_surface_struct_to_json(f2_photon_reflect_surface, json_root)
  call json%print(json_root, 'test_f_photon_reflect_surface_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_reflect_surface_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_reflect_surface_test_pattern (f_photon_reflect_surface, -1)
call set_photon_reflect_surface_test_pattern (f2_photon_reflect_surface, -1)

end subroutine test1_f_photon_reflect_surface

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_photon_reflect_surface (c_photon_reflect_surface, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_photon_reflect_surface
type(photon_reflect_surface_struct), target :: f_photon_reflect_surface, f2_photon_reflect_surface
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call photon_reflect_surface_to_f (c_photon_reflect_surface, c_loc(f_photon_reflect_surface))

call set_photon_reflect_surface_test_pattern (f2_photon_reflect_surface, 2)
if (f_photon_reflect_surface == f2_photon_reflect_surface) then
  print *, '[2] photon_reflect_surface: F side convert C->F: Good'
else
  print *, '[2] photon_reflect_surface: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call photon_reflect_surface_struct_to_json(f_photon_reflect_surface, json_root)
  call json%print(json_root, 'test_f_photon_reflect_surface_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_reflect_surface_struct_to_json(f2_photon_reflect_surface, json_root)
  call json%print(json_root, 'test_f_photon_reflect_surface_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_reflect_surface_pattern_2_*.json)'

endif

call set_photon_reflect_surface_test_pattern (f2_photon_reflect_surface, 3)
call photon_reflect_surface_to_c (c_loc(f2_photon_reflect_surface), c_photon_reflect_surface)

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_reflect_surface_test_pattern (f_photon_reflect_surface, -1)
call set_photon_reflect_surface_test_pattern (f2_photon_reflect_surface, -1)

end subroutine test2_f_photon_reflect_surface

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_photon_reflect_surface_test_pattern (F, ix_patt)

implicit none

type(photon_reflect_surface_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%description)
  F%description(jd1:jd1) = char(ichar("a") + modulo(100+2+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%reflectivity_file)
  F%reflectivity_file(jd1:jd1) = char(ichar("a") + modulo(100+3+offset+jd1, 26))
enddo
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_photon_reflect_table>
if (ix_patt < 3) then
  if (allocated(F%table)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%table,1), ubound(F%table,1)
      call set_photon_reflect_table_test_pattern (F%table(jd1), -1)
    enddo
    deallocate (F%table)
  endif
else
  if (.not. allocated(F%table)) then
    allocate (F%table(-1:1))
  endif
  do jd1 = 1, size(F%table,1)
    lb1 = lbound(F%table,1) - 1
    call set_photon_reflect_table_test_pattern (F%table(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%surface_roughness_rms = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%roughness_correlation_len = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%ix_surface = rhs

end subroutine set_photon_reflect_surface_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_coord (ok)

implicit none

type(coord_struct), target :: f_coord, f2_coord

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_coord (c_coord, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_coord
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_coord_test_pattern (f2_coord, 1)

call test_c_coord(c_loc(f2_coord), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_coord_test_pattern (f_coord, 4)
if (f_coord == f2_coord) then
  print *, '[4] coord: C side convert C->F: Good'
else
  print *, '[4] coord: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call coord_struct_to_json(f_coord, json_root)
  call json%print(json_root, 'test_f_coord_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call coord_struct_to_json(f2_coord, json_root)
  call json%print(json_root, 'test_f_coord_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_coord_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_coord_test_pattern (f_coord, -1)
call set_coord_test_pattern (f2_coord, -1)

end subroutine test1_f_coord

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_coord (c_coord, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_coord
type(coord_struct), target :: f_coord, f2_coord
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call coord_to_f (c_coord, c_loc(f_coord))

call set_coord_test_pattern (f2_coord, 2)
if (f_coord == f2_coord) then
  print *, '[2] coord: F side convert C->F: Good'
else
  print *, '[2] coord: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call coord_struct_to_json(f_coord, json_root)
  call json%print(json_root, 'test_f_coord_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call coord_struct_to_json(f2_coord, json_root)
  call json%print(json_root, 'test_f_coord_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_coord_pattern_2_*.json)'

endif

call set_coord_test_pattern (f2_coord, 3)
call coord_to_c (c_loc(f2_coord), c_coord)

! clean up test pattern data - < 3 deallocates arrays and such
call set_coord_test_pattern (f_coord, -1)
call set_coord_test_pattern (f2_coord, -1)

end subroutine test2_f_coord

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_coord_test_pattern (F, ix_patt)

implicit none

type(coord_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%vec,1); lb1 = lbound(F%vec,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%vec(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%s = rhs
!! f_side.test_pat[0D_NOT_real16] Real
rhs = 3 + offset; F%t = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%spin,1); lb1 = lbound(F%spin,1) - 1
  rhs = 100 + jd1 + 4 + offset
  F%spin(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%field,1); lb1 = lbound(F%field,1) - 1
  rhs = 100 + jd1 + 5 + offset
  F%field(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%phase,1); lb1 = lbound(F%phase,1) - 1
  rhs = 100 + jd1 + 6 + offset
  F%phase(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%charge = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%dt_ref = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%r = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%p0c = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%E_potential = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 12 + offset; F%beta = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 13 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 14 + offset; F%ix_branch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 15 + offset; F%ix_turn = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 16 + offset; F%ix_user = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 17 + offset; F%state = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 18 + offset; F%direction = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 19 + offset; F%time_dir = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 20 + offset; F%species = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 21 + offset; F%location = rhs

end subroutine set_coord_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_coord_array (ok)

implicit none

type(coord_array_struct), target :: f_coord_array, f2_coord_array

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_coord_array (c_coord_array, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_coord_array
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_coord_array_test_pattern (f2_coord_array, 1)

call test_c_coord_array(c_loc(f2_coord_array), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_coord_array_test_pattern (f_coord_array, 4)
if (f_coord_array == f2_coord_array) then
  print *, '[4] coord_array: C side convert C->F: Good'
else
  print *, '[4] coord_array: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call coord_array_struct_to_json(f_coord_array, json_root)
  call json%print(json_root, 'test_f_coord_array_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call coord_array_struct_to_json(f2_coord_array, json_root)
  call json%print(json_root, 'test_f_coord_array_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_coord_array_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_coord_array_test_pattern (f_coord_array, -1)
call set_coord_array_test_pattern (f2_coord_array, -1)

end subroutine test1_f_coord_array

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_coord_array (c_coord_array, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_coord_array
type(coord_array_struct), target :: f_coord_array, f2_coord_array
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call coord_array_to_f (c_coord_array, c_loc(f_coord_array))

call set_coord_array_test_pattern (f2_coord_array, 2)
if (f_coord_array == f2_coord_array) then
  print *, '[2] coord_array: F side convert C->F: Good'
else
  print *, '[2] coord_array: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call coord_array_struct_to_json(f_coord_array, json_root)
  call json%print(json_root, 'test_f_coord_array_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call coord_array_struct_to_json(f2_coord_array, json_root)
  call json%print(json_root, 'test_f_coord_array_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_coord_array_pattern_2_*.json)'

endif

call set_coord_array_test_pattern (f2_coord_array, 3)
call coord_array_to_c (c_loc(f2_coord_array), c_coord_array)

! clean up test pattern data - < 3 deallocates arrays and such
call set_coord_array_test_pattern (f_coord_array, -1)
call set_coord_array_test_pattern (f2_coord_array, -1)

end subroutine test2_f_coord_array

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_coord_array_test_pattern (F, ix_patt)

implicit none

type(coord_array_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_coord>
if (ix_patt < 3) then
  if (allocated(F%orbit)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%orbit,1), ubound(F%orbit,1)
      call set_coord_test_pattern (F%orbit(jd1), -1)
    enddo
    deallocate (F%orbit)
  endif
else
  if (.not. allocated(F%orbit)) then
    allocate (F%orbit(-1:1))
  endif
  do jd1 = 1, size(F%orbit,1)
    lb1 = lbound(F%orbit,1) - 1
    call set_coord_test_pattern (F%orbit(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_coord_array_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_bpm_phase_coupling (ok)

implicit none

type(bpm_phase_coupling_struct), target :: f_bpm_phase_coupling, f2_bpm_phase_coupling

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_bpm_phase_coupling (c_bpm_phase_coupling, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_bpm_phase_coupling
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_bpm_phase_coupling_test_pattern (f2_bpm_phase_coupling, 1)

call test_c_bpm_phase_coupling(c_loc(f2_bpm_phase_coupling), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_bpm_phase_coupling_test_pattern (f_bpm_phase_coupling, 4)
if (f_bpm_phase_coupling == f2_bpm_phase_coupling) then
  print *, '[4] bpm_phase_coupling: C side convert C->F: Good'
else
  print *, '[4] bpm_phase_coupling: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call bpm_phase_coupling_struct_to_json(f_bpm_phase_coupling, json_root)
  call json%print(json_root, 'test_f_bpm_phase_coupling_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bpm_phase_coupling_struct_to_json(f2_bpm_phase_coupling, json_root)
  call json%print(json_root, 'test_f_bpm_phase_coupling_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bpm_phase_coupling_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_bpm_phase_coupling_test_pattern (f_bpm_phase_coupling, -1)
call set_bpm_phase_coupling_test_pattern (f2_bpm_phase_coupling, -1)

end subroutine test1_f_bpm_phase_coupling

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_bpm_phase_coupling (c_bpm_phase_coupling, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_bpm_phase_coupling
type(bpm_phase_coupling_struct), target :: f_bpm_phase_coupling, f2_bpm_phase_coupling
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call bpm_phase_coupling_to_f (c_bpm_phase_coupling, c_loc(f_bpm_phase_coupling))

call set_bpm_phase_coupling_test_pattern (f2_bpm_phase_coupling, 2)
if (f_bpm_phase_coupling == f2_bpm_phase_coupling) then
  print *, '[2] bpm_phase_coupling: F side convert C->F: Good'
else
  print *, '[2] bpm_phase_coupling: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call bpm_phase_coupling_struct_to_json(f_bpm_phase_coupling, json_root)
  call json%print(json_root, 'test_f_bpm_phase_coupling_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bpm_phase_coupling_struct_to_json(f2_bpm_phase_coupling, json_root)
  call json%print(json_root, 'test_f_bpm_phase_coupling_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bpm_phase_coupling_pattern_2_*.json)'

endif

call set_bpm_phase_coupling_test_pattern (f2_bpm_phase_coupling, 3)
call bpm_phase_coupling_to_c (c_loc(f2_bpm_phase_coupling), c_bpm_phase_coupling)

! clean up test pattern data - < 3 deallocates arrays and such
call set_bpm_phase_coupling_test_pattern (f_bpm_phase_coupling, -1)
call set_bpm_phase_coupling_test_pattern (f2_bpm_phase_coupling, -1)

end subroutine test2_f_bpm_phase_coupling

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_bpm_phase_coupling_test_pattern (F, ix_patt)

implicit none

type(bpm_phase_coupling_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%K_22a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%K_12a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%K_11b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%K_12b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%Cbar22_a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%Cbar12_a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%Cbar11_b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%Cbar12_b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%phi_a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%phi_b = rhs

end subroutine set_bpm_phase_coupling_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_expression_atom (ok)

implicit none

type(expression_atom_struct), target :: f_expression_atom, f2_expression_atom

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_expression_atom (c_expression_atom, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_expression_atom
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_expression_atom_test_pattern (f2_expression_atom, 1)

call test_c_expression_atom(c_loc(f2_expression_atom), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_expression_atom_test_pattern (f_expression_atom, 4)
if (f_expression_atom == f2_expression_atom) then
  print *, '[4] expression_atom: C side convert C->F: Good'
else
  print *, '[4] expression_atom: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call expression_atom_struct_to_json(f_expression_atom, json_root)
  call json%print(json_root, 'test_f_expression_atom_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call expression_atom_struct_to_json(f2_expression_atom, json_root)
  call json%print(json_root, 'test_f_expression_atom_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_expression_atom_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_expression_atom_test_pattern (f_expression_atom, -1)
call set_expression_atom_test_pattern (f2_expression_atom, -1)

end subroutine test1_f_expression_atom

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_expression_atom (c_expression_atom, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_expression_atom
type(expression_atom_struct), target :: f_expression_atom, f2_expression_atom
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call expression_atom_to_f (c_expression_atom, c_loc(f_expression_atom))

call set_expression_atom_test_pattern (f2_expression_atom, 2)
if (f_expression_atom == f2_expression_atom) then
  print *, '[2] expression_atom: F side convert C->F: Good'
else
  print *, '[2] expression_atom: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call expression_atom_struct_to_json(f_expression_atom, json_root)
  call json%print(json_root, 'test_f_expression_atom_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call expression_atom_struct_to_json(f2_expression_atom, json_root)
  call json%print(json_root, 'test_f_expression_atom_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_expression_atom_pattern_2_*.json)'

endif

call set_expression_atom_test_pattern (f2_expression_atom, 3)
call expression_atom_to_c (c_loc(f2_expression_atom), c_expression_atom)

! clean up test pattern data - < 3 deallocates arrays and such
call set_expression_atom_test_pattern (f_expression_atom, -1)
call set_expression_atom_test_pattern (f2_expression_atom, -1)

end subroutine test2_f_expression_atom

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_expression_atom_test_pattern (F, ix_patt)

implicit none

type(expression_atom_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%type = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%value = rhs

end subroutine set_expression_atom_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wake_sr_z_long (ok)

implicit none

type(wake_sr_z_long_struct), target :: f_wake_sr_z_long, f2_wake_sr_z_long

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wake_sr_z_long (c_wake_sr_z_long, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wake_sr_z_long
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wake_sr_z_long_test_pattern (f2_wake_sr_z_long, 1)

call test_c_wake_sr_z_long(c_loc(f2_wake_sr_z_long), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wake_sr_z_long_test_pattern (f_wake_sr_z_long, 4)
if (f_wake_sr_z_long == f2_wake_sr_z_long) then
  print *, '[4] wake_sr_z_long: C side convert C->F: Good'
else
  print *, '[4] wake_sr_z_long: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wake_sr_z_long_struct_to_json(f_wake_sr_z_long, json_root)
  call json%print(json_root, 'test_f_wake_sr_z_long_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_sr_z_long_struct_to_json(f2_wake_sr_z_long, json_root)
  call json%print(json_root, 'test_f_wake_sr_z_long_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_sr_z_long_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_sr_z_long_test_pattern (f_wake_sr_z_long, -1)
call set_wake_sr_z_long_test_pattern (f2_wake_sr_z_long, -1)

end subroutine test1_f_wake_sr_z_long

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wake_sr_z_long (c_wake_sr_z_long, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wake_sr_z_long
type(wake_sr_z_long_struct), target :: f_wake_sr_z_long, f2_wake_sr_z_long
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wake_sr_z_long_to_f (c_wake_sr_z_long, c_loc(f_wake_sr_z_long))

call set_wake_sr_z_long_test_pattern (f2_wake_sr_z_long, 2)
if (f_wake_sr_z_long == f2_wake_sr_z_long) then
  print *, '[2] wake_sr_z_long: F side convert C->F: Good'
else
  print *, '[2] wake_sr_z_long: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wake_sr_z_long_struct_to_json(f_wake_sr_z_long, json_root)
  call json%print(json_root, 'test_f_wake_sr_z_long_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_sr_z_long_struct_to_json(f2_wake_sr_z_long, json_root)
  call json%print(json_root, 'test_f_wake_sr_z_long_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_sr_z_long_pattern_2_*.json)'

endif

call set_wake_sr_z_long_test_pattern (f2_wake_sr_z_long, 3)
call wake_sr_z_long_to_c (c_loc(f2_wake_sr_z_long), c_wake_sr_z_long)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_sr_z_long_test_pattern (f_wake_sr_z_long, -1)
call set_wake_sr_z_long_test_pattern (f2_wake_sr_z_long, -1)

end subroutine test2_f_wake_sr_z_long

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_sr_z_long_test_pattern (F, ix_patt)

implicit none

type(wake_sr_z_long_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%w)) then
     deallocate (F%w)
  endif
else
  if (.not. allocated(F%w)) then
    allocate (F%w(-1:1))
  endif
  do jd1 = 1, size(F%w,1)
    lb1 = lbound(F%w,1) - 1
    rhs = 100 + jd1 + 1 + offset
    F%w(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_ALLOC_complex] VariableArray1D<Complex>
if (ix_patt < 3) then
  if (allocated(F%fw)) then
     deallocate (F%fw)
  endif
else
  if (.not. allocated(F%fw)) then
    allocate (F%fw(-1:1))
  endif
  do jd1 = 1, size(F%fw,1)
    lb1 = lbound(F%fw,1) - 1
    rhs = 100 + jd1 + 3 + offset
    F%fw(jd1+lb1) = cmplx(rhs, 100+rhs)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_complex] VariableArray1D<Complex>
if (ix_patt < 3) then
  if (allocated(F%fbunch)) then
     deallocate (F%fbunch)
  endif
else
  if (.not. allocated(F%fbunch)) then
    allocate (F%fbunch(-1:1))
  endif
  do jd1 = 1, size(F%fbunch,1)
    lb1 = lbound(F%fbunch,1) - 1
    rhs = 100 + jd1 + 5 + offset
    F%fbunch(jd1+lb1) = cmplx(rhs, 100+rhs)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_complex] VariableArray1D<Complex>
if (ix_patt < 3) then
  if (allocated(F%w_out)) then
     deallocate (F%w_out)
  endif
else
  if (.not. allocated(F%w_out)) then
    allocate (F%w_out(-1:1))
  endif
  do jd1 = 1, size(F%w_out,1)
    lb1 = lbound(F%w_out,1) - 1
    rhs = 100 + jd1 + 7 + offset
    F%w_out(jd1+lb1) = cmplx(rhs, 100+rhs)
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%dz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%z0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%smoothing_sigma = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 12 + offset; F%position_dependence = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 13 + offset; F%time_based = (modulo(rhs, 2) == 0)

end subroutine set_wake_sr_z_long_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wake_sr_mode (ok)

implicit none

type(wake_sr_mode_struct), target :: f_wake_sr_mode, f2_wake_sr_mode

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wake_sr_mode (c_wake_sr_mode, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wake_sr_mode
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wake_sr_mode_test_pattern (f2_wake_sr_mode, 1)

call test_c_wake_sr_mode(c_loc(f2_wake_sr_mode), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wake_sr_mode_test_pattern (f_wake_sr_mode, 4)
if (f_wake_sr_mode == f2_wake_sr_mode) then
  print *, '[4] wake_sr_mode: C side convert C->F: Good'
else
  print *, '[4] wake_sr_mode: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wake_sr_mode_struct_to_json(f_wake_sr_mode, json_root)
  call json%print(json_root, 'test_f_wake_sr_mode_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_sr_mode_struct_to_json(f2_wake_sr_mode, json_root)
  call json%print(json_root, 'test_f_wake_sr_mode_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_sr_mode_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_sr_mode_test_pattern (f_wake_sr_mode, -1)
call set_wake_sr_mode_test_pattern (f2_wake_sr_mode, -1)

end subroutine test1_f_wake_sr_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wake_sr_mode (c_wake_sr_mode, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wake_sr_mode
type(wake_sr_mode_struct), target :: f_wake_sr_mode, f2_wake_sr_mode
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wake_sr_mode_to_f (c_wake_sr_mode, c_loc(f_wake_sr_mode))

call set_wake_sr_mode_test_pattern (f2_wake_sr_mode, 2)
if (f_wake_sr_mode == f2_wake_sr_mode) then
  print *, '[2] wake_sr_mode: F side convert C->F: Good'
else
  print *, '[2] wake_sr_mode: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wake_sr_mode_struct_to_json(f_wake_sr_mode, json_root)
  call json%print(json_root, 'test_f_wake_sr_mode_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_sr_mode_struct_to_json(f2_wake_sr_mode, json_root)
  call json%print(json_root, 'test_f_wake_sr_mode_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_sr_mode_pattern_2_*.json)'

endif

call set_wake_sr_mode_test_pattern (f2_wake_sr_mode, 3)
call wake_sr_mode_to_c (c_loc(f2_wake_sr_mode), c_wake_sr_mode)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_sr_mode_test_pattern (f_wake_sr_mode, -1)
call set_wake_sr_mode_test_pattern (f2_wake_sr_mode, -1)

end subroutine test2_f_wake_sr_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_sr_mode_test_pattern (F, ix_patt)

implicit none

type(wake_sr_mode_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%amp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%damp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%k = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%b_sin = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%b_cos = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%a_sin = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%a_cos = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%polarization = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 10 + offset; F%position_dependence = rhs

end subroutine set_wake_sr_mode_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wake_sr (ok)

implicit none

type(wake_sr_struct), target :: f_wake_sr, f2_wake_sr

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wake_sr (c_wake_sr, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wake_sr
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wake_sr_test_pattern (f2_wake_sr, 1)

call test_c_wake_sr(c_loc(f2_wake_sr), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wake_sr_test_pattern (f_wake_sr, 4)
if (f_wake_sr == f2_wake_sr) then
  print *, '[4] wake_sr: C side convert C->F: Good'
else
  print *, '[4] wake_sr: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wake_sr_struct_to_json(f_wake_sr, json_root)
  call json%print(json_root, 'test_f_wake_sr_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_sr_struct_to_json(f2_wake_sr, json_root)
  call json%print(json_root, 'test_f_wake_sr_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_sr_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_sr_test_pattern (f_wake_sr, -1)
call set_wake_sr_test_pattern (f2_wake_sr, -1)

end subroutine test1_f_wake_sr

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wake_sr (c_wake_sr, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wake_sr
type(wake_sr_struct), target :: f_wake_sr, f2_wake_sr
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wake_sr_to_f (c_wake_sr, c_loc(f_wake_sr))

call set_wake_sr_test_pattern (f2_wake_sr, 2)
if (f_wake_sr == f2_wake_sr) then
  print *, '[2] wake_sr: F side convert C->F: Good'
else
  print *, '[2] wake_sr: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wake_sr_struct_to_json(f_wake_sr, json_root)
  call json%print(json_root, 'test_f_wake_sr_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_sr_struct_to_json(f2_wake_sr, json_root)
  call json%print(json_root, 'test_f_wake_sr_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_sr_pattern_2_*.json)'

endif

call set_wake_sr_test_pattern (f2_wake_sr, 3)
call wake_sr_to_c (c_loc(f2_wake_sr), c_wake_sr)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_sr_test_pattern (f_wake_sr, -1)
call set_wake_sr_test_pattern (f2_wake_sr, -1)

end subroutine test2_f_wake_sr

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_sr_test_pattern (F, ix_patt)

implicit none

type(wake_sr_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_type] CPP_wake_sr_z_long
call set_wake_sr_z_long_test_pattern (F%z_long, ix_patt)
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_wake_sr_mode>
if (ix_patt < 3) then
  if (allocated(F%long)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%long,1), ubound(F%long,1)
      call set_wake_sr_mode_test_pattern (F%long(jd1), -1)
    enddo
    deallocate (F%long)
  endif
else
  if (.not. allocated(F%long)) then
    allocate (F%long(-1:1))
  endif
  do jd1 = 1, size(F%long,1)
    lb1 = lbound(F%long,1) - 1
    call set_wake_sr_mode_test_pattern (F%long(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_wake_sr_mode>
if (ix_patt < 3) then
  if (allocated(F%trans)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%trans,1), ubound(F%trans,1)
      call set_wake_sr_mode_test_pattern (F%trans(jd1), -1)
    enddo
    deallocate (F%trans)
  endif
else
  if (.not. allocated(F%trans)) then
    allocate (F%trans(-1:1))
  endif
  do jd1 = 1, size(F%trans,1)
    lb1 = lbound(F%trans,1) - 1
    call set_wake_sr_mode_test_pattern (F%trans(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%z_ref_long = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%z_ref_trans = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%z_max = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%amp_scale = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%z_scale = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 12 + offset; F%scale_with_length = (modulo(rhs, 2) == 0)

end subroutine set_wake_sr_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wake_lr_mode (ok)

implicit none

type(wake_lr_mode_struct), target :: f_wake_lr_mode, f2_wake_lr_mode

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wake_lr_mode (c_wake_lr_mode, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wake_lr_mode
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wake_lr_mode_test_pattern (f2_wake_lr_mode, 1)

call test_c_wake_lr_mode(c_loc(f2_wake_lr_mode), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wake_lr_mode_test_pattern (f_wake_lr_mode, 4)
if (f_wake_lr_mode == f2_wake_lr_mode) then
  print *, '[4] wake_lr_mode: C side convert C->F: Good'
else
  print *, '[4] wake_lr_mode: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wake_lr_mode_struct_to_json(f_wake_lr_mode, json_root)
  call json%print(json_root, 'test_f_wake_lr_mode_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_lr_mode_struct_to_json(f2_wake_lr_mode, json_root)
  call json%print(json_root, 'test_f_wake_lr_mode_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_lr_mode_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_lr_mode_test_pattern (f_wake_lr_mode, -1)
call set_wake_lr_mode_test_pattern (f2_wake_lr_mode, -1)

end subroutine test1_f_wake_lr_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wake_lr_mode (c_wake_lr_mode, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wake_lr_mode
type(wake_lr_mode_struct), target :: f_wake_lr_mode, f2_wake_lr_mode
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wake_lr_mode_to_f (c_wake_lr_mode, c_loc(f_wake_lr_mode))

call set_wake_lr_mode_test_pattern (f2_wake_lr_mode, 2)
if (f_wake_lr_mode == f2_wake_lr_mode) then
  print *, '[2] wake_lr_mode: F side convert C->F: Good'
else
  print *, '[2] wake_lr_mode: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wake_lr_mode_struct_to_json(f_wake_lr_mode, json_root)
  call json%print(json_root, 'test_f_wake_lr_mode_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_lr_mode_struct_to_json(f2_wake_lr_mode, json_root)
  call json%print(json_root, 'test_f_wake_lr_mode_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_lr_mode_pattern_2_*.json)'

endif

call set_wake_lr_mode_test_pattern (f2_wake_lr_mode, 3)
call wake_lr_mode_to_c (c_loc(f2_wake_lr_mode), c_wake_lr_mode)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_lr_mode_test_pattern (f_wake_lr_mode, -1)
call set_wake_lr_mode_test_pattern (f2_wake_lr_mode, -1)

end subroutine test2_f_wake_lr_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_lr_mode_test_pattern (F, ix_patt)

implicit none

type(wake_lr_mode_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%freq = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%freq_in = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%R_over_Q = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%Q = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%damp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%angle = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%b_sin = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%b_cos = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%a_sin = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%a_cos = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 12 + offset; F%m = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 13 + offset; F%polarized = (modulo(rhs, 2) == 0)

end subroutine set_wake_lr_mode_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wake_lr (ok)

implicit none

type(wake_lr_struct), target :: f_wake_lr, f2_wake_lr

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wake_lr (c_wake_lr, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wake_lr
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wake_lr_test_pattern (f2_wake_lr, 1)

call test_c_wake_lr(c_loc(f2_wake_lr), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wake_lr_test_pattern (f_wake_lr, 4)
if (f_wake_lr == f2_wake_lr) then
  print *, '[4] wake_lr: C side convert C->F: Good'
else
  print *, '[4] wake_lr: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wake_lr_struct_to_json(f_wake_lr, json_root)
  call json%print(json_root, 'test_f_wake_lr_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_lr_struct_to_json(f2_wake_lr, json_root)
  call json%print(json_root, 'test_f_wake_lr_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_lr_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_lr_test_pattern (f_wake_lr, -1)
call set_wake_lr_test_pattern (f2_wake_lr, -1)

end subroutine test1_f_wake_lr

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wake_lr (c_wake_lr, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wake_lr
type(wake_lr_struct), target :: f_wake_lr, f2_wake_lr
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wake_lr_to_f (c_wake_lr, c_loc(f_wake_lr))

call set_wake_lr_test_pattern (f2_wake_lr, 2)
if (f_wake_lr == f2_wake_lr) then
  print *, '[2] wake_lr: F side convert C->F: Good'
else
  print *, '[2] wake_lr: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wake_lr_struct_to_json(f_wake_lr, json_root)
  call json%print(json_root, 'test_f_wake_lr_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_lr_struct_to_json(f2_wake_lr, json_root)
  call json%print(json_root, 'test_f_wake_lr_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_lr_pattern_2_*.json)'

endif

call set_wake_lr_test_pattern (f2_wake_lr, 3)
call wake_lr_to_c (c_loc(f2_wake_lr), c_wake_lr)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_lr_test_pattern (f_wake_lr, -1)
call set_wake_lr_test_pattern (f2_wake_lr, -1)

end subroutine test2_f_wake_lr

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_lr_test_pattern (F, ix_patt)

implicit none

type(wake_lr_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_wake_lr_mode>
if (ix_patt < 3) then
  if (allocated(F%mode)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%mode,1), ubound(F%mode,1)
      call set_wake_lr_mode_test_pattern (F%mode(jd1), -1)
    enddo
    deallocate (F%mode)
  endif
else
  if (.not. allocated(F%mode)) then
    allocate (F%mode(-1:1))
  endif
  do jd1 = 1, size(F%mode,1)
    lb1 = lbound(F%mode,1) - 1
    call set_wake_lr_mode_test_pattern (F%mode(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%t_ref = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%freq_spread = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%amp_scale = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%time_scale = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 8 + offset; F%self_wake_on = (modulo(rhs, 2) == 0)

end subroutine set_wake_lr_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_lat_ele_loc (ok)

implicit none

type(lat_ele_loc_struct), target :: f_lat_ele_loc, f2_lat_ele_loc

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_lat_ele_loc (c_lat_ele_loc, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_lat_ele_loc
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_lat_ele_loc_test_pattern (f2_lat_ele_loc, 1)

call test_c_lat_ele_loc(c_loc(f2_lat_ele_loc), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_lat_ele_loc_test_pattern (f_lat_ele_loc, 4)
if (f_lat_ele_loc == f2_lat_ele_loc) then
  print *, '[4] lat_ele_loc: C side convert C->F: Good'
else
  print *, '[4] lat_ele_loc: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call lat_ele_loc_struct_to_json(f_lat_ele_loc, json_root)
  call json%print(json_root, 'test_f_lat_ele_loc_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call lat_ele_loc_struct_to_json(f2_lat_ele_loc, json_root)
  call json%print(json_root, 'test_f_lat_ele_loc_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_lat_ele_loc_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_lat_ele_loc_test_pattern (f_lat_ele_loc, -1)
call set_lat_ele_loc_test_pattern (f2_lat_ele_loc, -1)

end subroutine test1_f_lat_ele_loc

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_lat_ele_loc (c_lat_ele_loc, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_lat_ele_loc
type(lat_ele_loc_struct), target :: f_lat_ele_loc, f2_lat_ele_loc
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call lat_ele_loc_to_f (c_lat_ele_loc, c_loc(f_lat_ele_loc))

call set_lat_ele_loc_test_pattern (f2_lat_ele_loc, 2)
if (f_lat_ele_loc == f2_lat_ele_loc) then
  print *, '[2] lat_ele_loc: F side convert C->F: Good'
else
  print *, '[2] lat_ele_loc: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call lat_ele_loc_struct_to_json(f_lat_ele_loc, json_root)
  call json%print(json_root, 'test_f_lat_ele_loc_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call lat_ele_loc_struct_to_json(f2_lat_ele_loc, json_root)
  call json%print(json_root, 'test_f_lat_ele_loc_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_lat_ele_loc_pattern_2_*.json)'

endif

call set_lat_ele_loc_test_pattern (f2_lat_ele_loc, 3)
call lat_ele_loc_to_c (c_loc(f2_lat_ele_loc), c_lat_ele_loc)

! clean up test pattern data - < 3 deallocates arrays and such
call set_lat_ele_loc_test_pattern (f_lat_ele_loc, -1)
call set_lat_ele_loc_test_pattern (f2_lat_ele_loc, -1)

end subroutine test2_f_lat_ele_loc

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_lat_ele_loc_test_pattern (F, ix_patt)

implicit none

type(lat_ele_loc_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%ix_branch = rhs

end subroutine set_lat_ele_loc_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wake (ok)

implicit none

type(wake_struct), target :: f_wake, f2_wake

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wake (c_wake, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wake
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wake_test_pattern (f2_wake, 1)

call test_c_wake(c_loc(f2_wake), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wake_test_pattern (f_wake, 4)
if (f_wake == f2_wake) then
  print *, '[4] wake: C side convert C->F: Good'
else
  print *, '[4] wake: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wake_struct_to_json(f_wake, json_root)
  call json%print(json_root, 'test_f_wake_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_struct_to_json(f2_wake, json_root)
  call json%print(json_root, 'test_f_wake_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_test_pattern (f_wake, -1)
call set_wake_test_pattern (f2_wake, -1)

end subroutine test1_f_wake

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wake (c_wake, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wake
type(wake_struct), target :: f_wake, f2_wake
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wake_to_f (c_wake, c_loc(f_wake))

call set_wake_test_pattern (f2_wake, 2)
if (f_wake == f2_wake) then
  print *, '[2] wake: F side convert C->F: Good'
else
  print *, '[2] wake: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wake_struct_to_json(f_wake, json_root)
  call json%print(json_root, 'test_f_wake_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wake_struct_to_json(f2_wake, json_root)
  call json%print(json_root, 'test_f_wake_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wake_pattern_2_*.json)'

endif

call set_wake_test_pattern (f2_wake, 3)
call wake_to_c (c_loc(f2_wake), c_wake)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wake_test_pattern (f_wake, -1)
call set_wake_test_pattern (f2_wake, -1)

end subroutine test2_f_wake

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_test_pattern (F, ix_patt)

implicit none

type(wake_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_type] CPP_wake_sr
call set_wake_sr_test_pattern (F%sr, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_wake_lr
call set_wake_lr_test_pattern (F%lr, ix_patt)

end subroutine set_wake_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_taylor_term (ok)

implicit none

type(taylor_term_struct), target :: f_taylor_term, f2_taylor_term

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_taylor_term (c_taylor_term, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_taylor_term
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_taylor_term_test_pattern (f2_taylor_term, 1)

call test_c_taylor_term(c_loc(f2_taylor_term), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_taylor_term_test_pattern (f_taylor_term, 4)
if (f_taylor_term == f2_taylor_term) then
  print *, '[4] taylor_term: C side convert C->F: Good'
else
  print *, '[4] taylor_term: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call taylor_term_struct_to_json(f_taylor_term, json_root)
  call json%print(json_root, 'test_f_taylor_term_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call taylor_term_struct_to_json(f2_taylor_term, json_root)
  call json%print(json_root, 'test_f_taylor_term_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_taylor_term_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_taylor_term_test_pattern (f_taylor_term, -1)
call set_taylor_term_test_pattern (f2_taylor_term, -1)

end subroutine test1_f_taylor_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_taylor_term (c_taylor_term, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_taylor_term
type(taylor_term_struct), target :: f_taylor_term, f2_taylor_term
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call taylor_term_to_f (c_taylor_term, c_loc(f_taylor_term))

call set_taylor_term_test_pattern (f2_taylor_term, 2)
if (f_taylor_term == f2_taylor_term) then
  print *, '[2] taylor_term: F side convert C->F: Good'
else
  print *, '[2] taylor_term: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call taylor_term_struct_to_json(f_taylor_term, json_root)
  call json%print(json_root, 'test_f_taylor_term_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call taylor_term_struct_to_json(f2_taylor_term, json_root)
  call json%print(json_root, 'test_f_taylor_term_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_taylor_term_pattern_2_*.json)'

endif

call set_taylor_term_test_pattern (f2_taylor_term, 3)
call taylor_term_to_c (c_loc(f2_taylor_term), c_taylor_term)

! clean up test pattern data - < 3 deallocates arrays and such
call set_taylor_term_test_pattern (f_taylor_term, -1)
call set_taylor_term_test_pattern (f2_taylor_term, -1)

end subroutine test2_f_taylor_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_taylor_term_test_pattern (F, ix_patt)

implicit none

type(taylor_term_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%coef = rhs
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 6>
do jd1 = 1, size(F%expn,1); lb1 = lbound(F%expn,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%expn(jd1+lb1) = rhs
enddo

end subroutine set_taylor_term_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_taylor (ok)

implicit none

type(taylor_struct), target :: f_taylor, f2_taylor

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_taylor (c_taylor, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_taylor
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_taylor_test_pattern (f2_taylor, 1)

call test_c_taylor(c_loc(f2_taylor), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_taylor_test_pattern (f_taylor, 4)
if (f_taylor == f2_taylor) then
  print *, '[4] taylor: C side convert C->F: Good'
else
  print *, '[4] taylor: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call taylor_struct_to_json(f_taylor, json_root)
  call json%print(json_root, 'test_f_taylor_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call taylor_struct_to_json(f2_taylor, json_root)
  call json%print(json_root, 'test_f_taylor_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_taylor_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_taylor_test_pattern (f_taylor, -1)
call set_taylor_test_pattern (f2_taylor, -1)

end subroutine test1_f_taylor

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_taylor (c_taylor, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_taylor
type(taylor_struct), target :: f_taylor, f2_taylor
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call taylor_to_f (c_taylor, c_loc(f_taylor))

call set_taylor_test_pattern (f2_taylor, 2)
if (f_taylor == f2_taylor) then
  print *, '[2] taylor: F side convert C->F: Good'
else
  print *, '[2] taylor: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call taylor_struct_to_json(f_taylor, json_root)
  call json%print(json_root, 'test_f_taylor_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call taylor_struct_to_json(f2_taylor, json_root)
  call json%print(json_root, 'test_f_taylor_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_taylor_pattern_2_*.json)'

endif

call set_taylor_test_pattern (f2_taylor, 3)
call taylor_to_c (c_loc(f2_taylor), c_taylor)

! clean up test pattern data - < 3 deallocates arrays and such
call set_taylor_test_pattern (f_taylor, -1)
call set_taylor_test_pattern (f2_taylor, -1)

end subroutine test2_f_taylor

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_taylor_test_pattern (F, ix_patt)

implicit none

type(taylor_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%ref = rhs
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_taylor_term>
if (ix_patt < 3) then
  if (associated(F%term)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%term,1), ubound(F%term,1)
      call set_taylor_term_test_pattern (F%term(jd1), -1)
    enddo
    deallocate (F%term)
  endif
else
  if (.not. associated(F%term)) then
    allocate (F%term(-1:1))
  endif
  do jd1 = 1, size(F%term,1)
    lb1 = lbound(F%term,1) - 1
    call set_taylor_term_test_pattern (F%term(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_taylor_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_em_taylor_term (ok)

implicit none

type(em_taylor_term_struct), target :: f_em_taylor_term, f2_em_taylor_term

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_em_taylor_term (c_em_taylor_term, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_em_taylor_term
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_em_taylor_term_test_pattern (f2_em_taylor_term, 1)

call test_c_em_taylor_term(c_loc(f2_em_taylor_term), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_em_taylor_term_test_pattern (f_em_taylor_term, 4)
if (f_em_taylor_term == f2_em_taylor_term) then
  print *, '[4] em_taylor_term: C side convert C->F: Good'
else
  print *, '[4] em_taylor_term: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call em_taylor_term_struct_to_json(f_em_taylor_term, json_root)
  call json%print(json_root, 'test_f_em_taylor_term_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call em_taylor_term_struct_to_json(f2_em_taylor_term, json_root)
  call json%print(json_root, 'test_f_em_taylor_term_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_em_taylor_term_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_em_taylor_term_test_pattern (f_em_taylor_term, -1)
call set_em_taylor_term_test_pattern (f2_em_taylor_term, -1)

end subroutine test1_f_em_taylor_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_em_taylor_term (c_em_taylor_term, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_em_taylor_term
type(em_taylor_term_struct), target :: f_em_taylor_term, f2_em_taylor_term
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call em_taylor_term_to_f (c_em_taylor_term, c_loc(f_em_taylor_term))

call set_em_taylor_term_test_pattern (f2_em_taylor_term, 2)
if (f_em_taylor_term == f2_em_taylor_term) then
  print *, '[2] em_taylor_term: F side convert C->F: Good'
else
  print *, '[2] em_taylor_term: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call em_taylor_term_struct_to_json(f_em_taylor_term, json_root)
  call json%print(json_root, 'test_f_em_taylor_term_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call em_taylor_term_struct_to_json(f2_em_taylor_term, json_root)
  call json%print(json_root, 'test_f_em_taylor_term_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_em_taylor_term_pattern_2_*.json)'

endif

call set_em_taylor_term_test_pattern (f2_em_taylor_term, 3)
call em_taylor_term_to_c (c_loc(f2_em_taylor_term), c_em_taylor_term)

! clean up test pattern data - < 3 deallocates arrays and such
call set_em_taylor_term_test_pattern (f_em_taylor_term, -1)
call set_em_taylor_term_test_pattern (f2_em_taylor_term, -1)

end subroutine test2_f_em_taylor_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_em_taylor_term_test_pattern (F, ix_patt)

implicit none

type(em_taylor_term_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%coef = rhs
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 2>
do jd1 = 1, size(F%expn,1); lb1 = lbound(F%expn,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%expn(jd1+lb1) = rhs
enddo

end subroutine set_em_taylor_term_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_em_taylor (ok)

implicit none

type(em_taylor_struct), target :: f_em_taylor, f2_em_taylor

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_em_taylor (c_em_taylor, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_em_taylor
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_em_taylor_test_pattern (f2_em_taylor, 1)

call test_c_em_taylor(c_loc(f2_em_taylor), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_em_taylor_test_pattern (f_em_taylor, 4)
if (f_em_taylor == f2_em_taylor) then
  print *, '[4] em_taylor: C side convert C->F: Good'
else
  print *, '[4] em_taylor: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call em_taylor_struct_to_json(f_em_taylor, json_root)
  call json%print(json_root, 'test_f_em_taylor_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call em_taylor_struct_to_json(f2_em_taylor, json_root)
  call json%print(json_root, 'test_f_em_taylor_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_em_taylor_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_em_taylor_test_pattern (f_em_taylor, -1)
call set_em_taylor_test_pattern (f2_em_taylor, -1)

end subroutine test1_f_em_taylor

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_em_taylor (c_em_taylor, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_em_taylor
type(em_taylor_struct), target :: f_em_taylor, f2_em_taylor
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call em_taylor_to_f (c_em_taylor, c_loc(f_em_taylor))

call set_em_taylor_test_pattern (f2_em_taylor, 2)
if (f_em_taylor == f2_em_taylor) then
  print *, '[2] em_taylor: F side convert C->F: Good'
else
  print *, '[2] em_taylor: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call em_taylor_struct_to_json(f_em_taylor, json_root)
  call json%print(json_root, 'test_f_em_taylor_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call em_taylor_struct_to_json(f2_em_taylor, json_root)
  call json%print(json_root, 'test_f_em_taylor_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_em_taylor_pattern_2_*.json)'

endif

call set_em_taylor_test_pattern (f2_em_taylor, 3)
call em_taylor_to_c (c_loc(f2_em_taylor), c_em_taylor)

! clean up test pattern data - < 3 deallocates arrays and such
call set_em_taylor_test_pattern (f_em_taylor, -1)
call set_em_taylor_test_pattern (f2_em_taylor, -1)

end subroutine test2_f_em_taylor

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_em_taylor_test_pattern (F, ix_patt)

implicit none

type(em_taylor_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%ref = rhs
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_em_taylor_term>
if (ix_patt < 3) then
  if (allocated(F%term)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%term,1), ubound(F%term,1)
      call set_em_taylor_term_test_pattern (F%term(jd1), -1)
    enddo
    deallocate (F%term)
  endif
else
  if (.not. allocated(F%term)) then
    allocate (F%term(-1:1))
  endif
  do jd1 = 1, size(F%term,1)
    lb1 = lbound(F%term,1) - 1
    call set_em_taylor_term_test_pattern (F%term(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_em_taylor_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_cartesian_map_term1 (ok)

implicit none

type(cartesian_map_term1_struct), target :: f_cartesian_map_term1, f2_cartesian_map_term1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_cartesian_map_term1 (c_cartesian_map_term1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_cartesian_map_term1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_cartesian_map_term1_test_pattern (f2_cartesian_map_term1, 1)

call test_c_cartesian_map_term1(c_loc(f2_cartesian_map_term1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_cartesian_map_term1_test_pattern (f_cartesian_map_term1, 4)
if (f_cartesian_map_term1 == f2_cartesian_map_term1) then
  print *, '[4] cartesian_map_term1: C side convert C->F: Good'
else
  print *, '[4] cartesian_map_term1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call cartesian_map_term1_struct_to_json(f_cartesian_map_term1, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cartesian_map_term1_struct_to_json(f2_cartesian_map_term1, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cartesian_map_term1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_cartesian_map_term1_test_pattern (f_cartesian_map_term1, -1)
call set_cartesian_map_term1_test_pattern (f2_cartesian_map_term1, -1)

end subroutine test1_f_cartesian_map_term1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_cartesian_map_term1 (c_cartesian_map_term1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_cartesian_map_term1
type(cartesian_map_term1_struct), target :: f_cartesian_map_term1, f2_cartesian_map_term1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call cartesian_map_term1_to_f (c_cartesian_map_term1, c_loc(f_cartesian_map_term1))

call set_cartesian_map_term1_test_pattern (f2_cartesian_map_term1, 2)
if (f_cartesian_map_term1 == f2_cartesian_map_term1) then
  print *, '[2] cartesian_map_term1: F side convert C->F: Good'
else
  print *, '[2] cartesian_map_term1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call cartesian_map_term1_struct_to_json(f_cartesian_map_term1, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cartesian_map_term1_struct_to_json(f2_cartesian_map_term1, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cartesian_map_term1_pattern_2_*.json)'

endif

call set_cartesian_map_term1_test_pattern (f2_cartesian_map_term1, 3)
call cartesian_map_term1_to_c (c_loc(f2_cartesian_map_term1), c_cartesian_map_term1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_cartesian_map_term1_test_pattern (f_cartesian_map_term1, -1)
call set_cartesian_map_term1_test_pattern (f2_cartesian_map_term1, -1)

end subroutine test2_f_cartesian_map_term1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_cartesian_map_term1_test_pattern (F, ix_patt)

implicit none

type(cartesian_map_term1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%coef = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%kx = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%ky = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%kz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%x0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%y0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%phi_z = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%family = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%form = rhs

end subroutine set_cartesian_map_term1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_cartesian_map_term (ok)

implicit none

type(cartesian_map_term_struct), target :: f_cartesian_map_term, f2_cartesian_map_term

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_cartesian_map_term (c_cartesian_map_term, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_cartesian_map_term
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_cartesian_map_term_test_pattern (f2_cartesian_map_term, 1)

call test_c_cartesian_map_term(c_loc(f2_cartesian_map_term), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_cartesian_map_term_test_pattern (f_cartesian_map_term, 4)
if (f_cartesian_map_term == f2_cartesian_map_term) then
  print *, '[4] cartesian_map_term: C side convert C->F: Good'
else
  print *, '[4] cartesian_map_term: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call cartesian_map_term_struct_to_json(f_cartesian_map_term, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cartesian_map_term_struct_to_json(f2_cartesian_map_term, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cartesian_map_term_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_cartesian_map_term_test_pattern (f_cartesian_map_term, -1)
call set_cartesian_map_term_test_pattern (f2_cartesian_map_term, -1)

end subroutine test1_f_cartesian_map_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_cartesian_map_term (c_cartesian_map_term, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_cartesian_map_term
type(cartesian_map_term_struct), target :: f_cartesian_map_term, f2_cartesian_map_term
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call cartesian_map_term_to_f (c_cartesian_map_term, c_loc(f_cartesian_map_term))

call set_cartesian_map_term_test_pattern (f2_cartesian_map_term, 2)
if (f_cartesian_map_term == f2_cartesian_map_term) then
  print *, '[2] cartesian_map_term: F side convert C->F: Good'
else
  print *, '[2] cartesian_map_term: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call cartesian_map_term_struct_to_json(f_cartesian_map_term, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cartesian_map_term_struct_to_json(f2_cartesian_map_term, json_root)
  call json%print(json_root, 'test_f_cartesian_map_term_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cartesian_map_term_pattern_2_*.json)'

endif

call set_cartesian_map_term_test_pattern (f2_cartesian_map_term, 3)
call cartesian_map_term_to_c (c_loc(f2_cartesian_map_term), c_cartesian_map_term)

! clean up test pattern data - < 3 deallocates arrays and such
call set_cartesian_map_term_test_pattern (f_cartesian_map_term, -1)
call set_cartesian_map_term_test_pattern (f2_cartesian_map_term, -1)

end subroutine test2_f_cartesian_map_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_cartesian_map_term_test_pattern (F, ix_patt)

implicit none

type(cartesian_map_term_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_link = rhs
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_cartesian_map_term1>
if (ix_patt < 3) then
  if (allocated(F%term)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%term,1), ubound(F%term,1)
      call set_cartesian_map_term1_test_pattern (F%term(jd1), -1)
    enddo
    deallocate (F%term)
  endif
else
  if (.not. allocated(F%term)) then
    allocate (F%term(-1:1))
  endif
  do jd1 = 1, size(F%term,1)
    lb1 = lbound(F%term,1) - 1
    call set_cartesian_map_term1_test_pattern (F%term(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_cartesian_map_term_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_cartesian_map (ok)

implicit none

type(cartesian_map_struct), target :: f_cartesian_map, f2_cartesian_map

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_cartesian_map (c_cartesian_map, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_cartesian_map
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_cartesian_map_test_pattern (f2_cartesian_map, 1)

call test_c_cartesian_map(c_loc(f2_cartesian_map), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_cartesian_map_test_pattern (f_cartesian_map, 4)
if (f_cartesian_map == f2_cartesian_map) then
  print *, '[4] cartesian_map: C side convert C->F: Good'
else
  print *, '[4] cartesian_map: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call cartesian_map_struct_to_json(f_cartesian_map, json_root)
  call json%print(json_root, 'test_f_cartesian_map_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cartesian_map_struct_to_json(f2_cartesian_map, json_root)
  call json%print(json_root, 'test_f_cartesian_map_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cartesian_map_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_cartesian_map_test_pattern (f_cartesian_map, -1)
call set_cartesian_map_test_pattern (f2_cartesian_map, -1)

end subroutine test1_f_cartesian_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_cartesian_map (c_cartesian_map, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_cartesian_map
type(cartesian_map_struct), target :: f_cartesian_map, f2_cartesian_map
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call cartesian_map_to_f (c_cartesian_map, c_loc(f_cartesian_map))

call set_cartesian_map_test_pattern (f2_cartesian_map, 2)
if (f_cartesian_map == f2_cartesian_map) then
  print *, '[2] cartesian_map: F side convert C->F: Good'
else
  print *, '[2] cartesian_map: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call cartesian_map_struct_to_json(f_cartesian_map, json_root)
  call json%print(json_root, 'test_f_cartesian_map_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cartesian_map_struct_to_json(f2_cartesian_map, json_root)
  call json%print(json_root, 'test_f_cartesian_map_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cartesian_map_pattern_2_*.json)'

endif

call set_cartesian_map_test_pattern (f2_cartesian_map, 3)
call cartesian_map_to_c (c_loc(f2_cartesian_map), c_cartesian_map)

! clean up test pattern data - < 3 deallocates arrays and such
call set_cartesian_map_test_pattern (f_cartesian_map, -1)
call set_cartesian_map_test_pattern (f2_cartesian_map, -1)

end subroutine test2_f_cartesian_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_cartesian_map_test_pattern (F, ix_patt)

implicit none

type(cartesian_map_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%field_scale = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%master_parameter = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%ele_anchor_pt = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%field_type = rhs
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_cartesian_map_term>
if (ix_patt < 3) then
  if (associated(F%ptr)) then
    call set_cartesian_map_term_test_pattern (F%ptr, -1)
    deallocate (F%ptr)
  endif
else
  if (.not. associated(F%ptr)) allocate (F%ptr)
  rhs = 6 + offset
  call set_cartesian_map_term_test_pattern (F%ptr, ix_patt)
endif

end subroutine set_cartesian_map_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_cylindrical_map_term1 (ok)

implicit none

type(cylindrical_map_term1_struct), target :: f_cylindrical_map_term1, f2_cylindrical_map_term1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_cylindrical_map_term1 (c_cylindrical_map_term1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_cylindrical_map_term1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_cylindrical_map_term1_test_pattern (f2_cylindrical_map_term1, 1)

call test_c_cylindrical_map_term1(c_loc(f2_cylindrical_map_term1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_cylindrical_map_term1_test_pattern (f_cylindrical_map_term1, 4)
if (f_cylindrical_map_term1 == f2_cylindrical_map_term1) then
  print *, '[4] cylindrical_map_term1: C side convert C->F: Good'
else
  print *, '[4] cylindrical_map_term1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call cylindrical_map_term1_struct_to_json(f_cylindrical_map_term1, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cylindrical_map_term1_struct_to_json(f2_cylindrical_map_term1, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cylindrical_map_term1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_cylindrical_map_term1_test_pattern (f_cylindrical_map_term1, -1)
call set_cylindrical_map_term1_test_pattern (f2_cylindrical_map_term1, -1)

end subroutine test1_f_cylindrical_map_term1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_cylindrical_map_term1 (c_cylindrical_map_term1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_cylindrical_map_term1
type(cylindrical_map_term1_struct), target :: f_cylindrical_map_term1, f2_cylindrical_map_term1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call cylindrical_map_term1_to_f (c_cylindrical_map_term1, c_loc(f_cylindrical_map_term1))

call set_cylindrical_map_term1_test_pattern (f2_cylindrical_map_term1, 2)
if (f_cylindrical_map_term1 == f2_cylindrical_map_term1) then
  print *, '[2] cylindrical_map_term1: F side convert C->F: Good'
else
  print *, '[2] cylindrical_map_term1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call cylindrical_map_term1_struct_to_json(f_cylindrical_map_term1, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cylindrical_map_term1_struct_to_json(f2_cylindrical_map_term1, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cylindrical_map_term1_pattern_2_*.json)'

endif

call set_cylindrical_map_term1_test_pattern (f2_cylindrical_map_term1, 3)
call cylindrical_map_term1_to_c (c_loc(f2_cylindrical_map_term1), c_cylindrical_map_term1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_cylindrical_map_term1_test_pattern (f_cylindrical_map_term1, -1)
call set_cylindrical_map_term1_test_pattern (f2_cylindrical_map_term1, -1)

end subroutine test2_f_cylindrical_map_term1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_cylindrical_map_term1_test_pattern (F, ix_patt)

implicit none

type(cylindrical_map_term1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 1 + offset; F%e_coef = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 2 + offset; F%b_coef = cmplx(rhs, 100+rhs)

end subroutine set_cylindrical_map_term1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_cylindrical_map_term (ok)

implicit none

type(cylindrical_map_term_struct), target :: f_cylindrical_map_term, f2_cylindrical_map_term

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_cylindrical_map_term (c_cylindrical_map_term, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_cylindrical_map_term
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_cylindrical_map_term_test_pattern (f2_cylindrical_map_term, 1)

call test_c_cylindrical_map_term(c_loc(f2_cylindrical_map_term), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_cylindrical_map_term_test_pattern (f_cylindrical_map_term, 4)
if (f_cylindrical_map_term == f2_cylindrical_map_term) then
  print *, '[4] cylindrical_map_term: C side convert C->F: Good'
else
  print *, '[4] cylindrical_map_term: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call cylindrical_map_term_struct_to_json(f_cylindrical_map_term, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cylindrical_map_term_struct_to_json(f2_cylindrical_map_term, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cylindrical_map_term_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_cylindrical_map_term_test_pattern (f_cylindrical_map_term, -1)
call set_cylindrical_map_term_test_pattern (f2_cylindrical_map_term, -1)

end subroutine test1_f_cylindrical_map_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_cylindrical_map_term (c_cylindrical_map_term, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_cylindrical_map_term
type(cylindrical_map_term_struct), target :: f_cylindrical_map_term, f2_cylindrical_map_term
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call cylindrical_map_term_to_f (c_cylindrical_map_term, c_loc(f_cylindrical_map_term))

call set_cylindrical_map_term_test_pattern (f2_cylindrical_map_term, 2)
if (f_cylindrical_map_term == f2_cylindrical_map_term) then
  print *, '[2] cylindrical_map_term: F side convert C->F: Good'
else
  print *, '[2] cylindrical_map_term: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call cylindrical_map_term_struct_to_json(f_cylindrical_map_term, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cylindrical_map_term_struct_to_json(f2_cylindrical_map_term, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_term_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cylindrical_map_term_pattern_2_*.json)'

endif

call set_cylindrical_map_term_test_pattern (f2_cylindrical_map_term, 3)
call cylindrical_map_term_to_c (c_loc(f2_cylindrical_map_term), c_cylindrical_map_term)

! clean up test pattern data - < 3 deallocates arrays and such
call set_cylindrical_map_term_test_pattern (f_cylindrical_map_term, -1)
call set_cylindrical_map_term_test_pattern (f2_cylindrical_map_term, -1)

end subroutine test2_f_cylindrical_map_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_cylindrical_map_term_test_pattern (F, ix_patt)

implicit none

type(cylindrical_map_term_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_link = rhs
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_cylindrical_map_term1>
if (ix_patt < 3) then
  if (allocated(F%term)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%term,1), ubound(F%term,1)
      call set_cylindrical_map_term1_test_pattern (F%term(jd1), -1)
    enddo
    deallocate (F%term)
  endif
else
  if (.not. allocated(F%term)) then
    allocate (F%term(-1:1))
  endif
  do jd1 = 1, size(F%term,1)
    lb1 = lbound(F%term,1) - 1
    call set_cylindrical_map_term1_test_pattern (F%term(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_cylindrical_map_term_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_cylindrical_map (ok)

implicit none

type(cylindrical_map_struct), target :: f_cylindrical_map, f2_cylindrical_map

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_cylindrical_map (c_cylindrical_map, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_cylindrical_map
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_cylindrical_map_test_pattern (f2_cylindrical_map, 1)

call test_c_cylindrical_map(c_loc(f2_cylindrical_map), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_cylindrical_map_test_pattern (f_cylindrical_map, 4)
if (f_cylindrical_map == f2_cylindrical_map) then
  print *, '[4] cylindrical_map: C side convert C->F: Good'
else
  print *, '[4] cylindrical_map: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call cylindrical_map_struct_to_json(f_cylindrical_map, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cylindrical_map_struct_to_json(f2_cylindrical_map, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cylindrical_map_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_cylindrical_map_test_pattern (f_cylindrical_map, -1)
call set_cylindrical_map_test_pattern (f2_cylindrical_map, -1)

end subroutine test1_f_cylindrical_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_cylindrical_map (c_cylindrical_map, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_cylindrical_map
type(cylindrical_map_struct), target :: f_cylindrical_map, f2_cylindrical_map
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call cylindrical_map_to_f (c_cylindrical_map, c_loc(f_cylindrical_map))

call set_cylindrical_map_test_pattern (f2_cylindrical_map, 2)
if (f_cylindrical_map == f2_cylindrical_map) then
  print *, '[2] cylindrical_map: F side convert C->F: Good'
else
  print *, '[2] cylindrical_map: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call cylindrical_map_struct_to_json(f_cylindrical_map, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call cylindrical_map_struct_to_json(f2_cylindrical_map, json_root)
  call json%print(json_root, 'test_f_cylindrical_map_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_cylindrical_map_pattern_2_*.json)'

endif

call set_cylindrical_map_test_pattern (f2_cylindrical_map, 3)
call cylindrical_map_to_c (c_loc(f2_cylindrical_map), c_cylindrical_map)

! clean up test pattern data - < 3 deallocates arrays and such
call set_cylindrical_map_test_pattern (f_cylindrical_map, -1)
call set_cylindrical_map_test_pattern (f2_cylindrical_map, -1)

end subroutine test2_f_cylindrical_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_cylindrical_map_test_pattern (F, ix_patt)

implicit none

type(cylindrical_map_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%m = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%harmonic = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%phi0_fieldmap = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%theta0_azimuth = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%field_scale = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 6 + offset; F%master_parameter = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%ele_anchor_pt = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%dz = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 9 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_cylindrical_map_term>
if (ix_patt < 3) then
  if (associated(F%ptr)) then
    call set_cylindrical_map_term_test_pattern (F%ptr, -1)
    deallocate (F%ptr)
  endif
else
  if (.not. associated(F%ptr)) allocate (F%ptr)
  rhs = 10 + offset
  call set_cylindrical_map_term_test_pattern (F%ptr, ix_patt)
endif

end subroutine set_cylindrical_map_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_bicubic_cmplx_coef (ok)

implicit none

type(bicubic_cmplx_coef_struct), target :: f_bicubic_cmplx_coef, f2_bicubic_cmplx_coef

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_bicubic_cmplx_coef (c_bicubic_cmplx_coef, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_bicubic_cmplx_coef
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_bicubic_cmplx_coef_test_pattern (f2_bicubic_cmplx_coef, 1)

call test_c_bicubic_cmplx_coef(c_loc(f2_bicubic_cmplx_coef), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_bicubic_cmplx_coef_test_pattern (f_bicubic_cmplx_coef, 4)
if (f_bicubic_cmplx_coef == f2_bicubic_cmplx_coef) then
  print *, '[4] bicubic_cmplx_coef: C side convert C->F: Good'
else
  print *, '[4] bicubic_cmplx_coef: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call bicubic_cmplx_coef_struct_to_json(f_bicubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_bicubic_cmplx_coef_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bicubic_cmplx_coef_struct_to_json(f2_bicubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_bicubic_cmplx_coef_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bicubic_cmplx_coef_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_bicubic_cmplx_coef_test_pattern (f_bicubic_cmplx_coef, -1)
call set_bicubic_cmplx_coef_test_pattern (f2_bicubic_cmplx_coef, -1)

end subroutine test1_f_bicubic_cmplx_coef

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_bicubic_cmplx_coef (c_bicubic_cmplx_coef, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_bicubic_cmplx_coef
type(bicubic_cmplx_coef_struct), target :: f_bicubic_cmplx_coef, f2_bicubic_cmplx_coef
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call bicubic_cmplx_coef_to_f (c_bicubic_cmplx_coef, c_loc(f_bicubic_cmplx_coef))

call set_bicubic_cmplx_coef_test_pattern (f2_bicubic_cmplx_coef, 2)
if (f_bicubic_cmplx_coef == f2_bicubic_cmplx_coef) then
  print *, '[2] bicubic_cmplx_coef: F side convert C->F: Good'
else
  print *, '[2] bicubic_cmplx_coef: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call bicubic_cmplx_coef_struct_to_json(f_bicubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_bicubic_cmplx_coef_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bicubic_cmplx_coef_struct_to_json(f2_bicubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_bicubic_cmplx_coef_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bicubic_cmplx_coef_pattern_2_*.json)'

endif

call set_bicubic_cmplx_coef_test_pattern (f2_bicubic_cmplx_coef, 3)
call bicubic_cmplx_coef_to_c (c_loc(f2_bicubic_cmplx_coef), c_bicubic_cmplx_coef)

! clean up test pattern data - < 3 deallocates arrays and such
call set_bicubic_cmplx_coef_test_pattern (f_bicubic_cmplx_coef, -1)
call set_bicubic_cmplx_coef_test_pattern (f2_bicubic_cmplx_coef, -1)

end subroutine test2_f_bicubic_cmplx_coef

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_bicubic_cmplx_coef_test_pattern (F, ix_patt)

implicit none

type(bicubic_cmplx_coef_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[2D_NOT_complex] FixedArray2D<Complex, 4, 4>
do jd1 = 1, size(F%coef,1); lb1 = lbound(F%coef,1) - 1
  do jd2 = 1, size(F%coef,2); lb2 = lbound(F%coef,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 1 + offset
    F%coef(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)
  enddo
enddo
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 2>
do jd1 = 1, size(F%i_box,1); lb1 = lbound(F%i_box,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%i_box(jd1+lb1) = rhs
enddo

end subroutine set_bicubic_cmplx_coef_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_tricubic_cmplx_coef (ok)

implicit none

type(tricubic_cmplx_coef_struct), target :: f_tricubic_cmplx_coef, f2_tricubic_cmplx_coef

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_tricubic_cmplx_coef (c_tricubic_cmplx_coef, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_tricubic_cmplx_coef
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_tricubic_cmplx_coef_test_pattern (f2_tricubic_cmplx_coef, 1)

call test_c_tricubic_cmplx_coef(c_loc(f2_tricubic_cmplx_coef), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_tricubic_cmplx_coef_test_pattern (f_tricubic_cmplx_coef, 4)
if (f_tricubic_cmplx_coef == f2_tricubic_cmplx_coef) then
  print *, '[4] tricubic_cmplx_coef: C side convert C->F: Good'
else
  print *, '[4] tricubic_cmplx_coef: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call tricubic_cmplx_coef_struct_to_json(f_tricubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_tricubic_cmplx_coef_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call tricubic_cmplx_coef_struct_to_json(f2_tricubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_tricubic_cmplx_coef_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_tricubic_cmplx_coef_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_tricubic_cmplx_coef_test_pattern (f_tricubic_cmplx_coef, -1)
call set_tricubic_cmplx_coef_test_pattern (f2_tricubic_cmplx_coef, -1)

end subroutine test1_f_tricubic_cmplx_coef

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_tricubic_cmplx_coef (c_tricubic_cmplx_coef, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_tricubic_cmplx_coef
type(tricubic_cmplx_coef_struct), target :: f_tricubic_cmplx_coef, f2_tricubic_cmplx_coef
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call tricubic_cmplx_coef_to_f (c_tricubic_cmplx_coef, c_loc(f_tricubic_cmplx_coef))

call set_tricubic_cmplx_coef_test_pattern (f2_tricubic_cmplx_coef, 2)
if (f_tricubic_cmplx_coef == f2_tricubic_cmplx_coef) then
  print *, '[2] tricubic_cmplx_coef: F side convert C->F: Good'
else
  print *, '[2] tricubic_cmplx_coef: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call tricubic_cmplx_coef_struct_to_json(f_tricubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_tricubic_cmplx_coef_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call tricubic_cmplx_coef_struct_to_json(f2_tricubic_cmplx_coef, json_root)
  call json%print(json_root, 'test_f_tricubic_cmplx_coef_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_tricubic_cmplx_coef_pattern_2_*.json)'

endif

call set_tricubic_cmplx_coef_test_pattern (f2_tricubic_cmplx_coef, 3)
call tricubic_cmplx_coef_to_c (c_loc(f2_tricubic_cmplx_coef), c_tricubic_cmplx_coef)

! clean up test pattern data - < 3 deallocates arrays and such
call set_tricubic_cmplx_coef_test_pattern (f_tricubic_cmplx_coef, -1)
call set_tricubic_cmplx_coef_test_pattern (f2_tricubic_cmplx_coef, -1)

end subroutine test2_f_tricubic_cmplx_coef

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_tricubic_cmplx_coef_test_pattern (F, ix_patt)

implicit none

type(tricubic_cmplx_coef_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[3D_NOT_complex] FixedArray3D<Complex, 4, 4, 4>
do jd1 = 1, size(F%coef,1); lb1 = lbound(F%coef,1) - 1
  do jd2 = 1, size(F%coef,2); lb2 = lbound(F%coef,2) - 1
    do jd3 = 1, size(F%coef,3); lb3 = lbound(F%coef,3) - 1
      rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 1 + offset
      F%coef(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)
    enddo
   enddo
 enddo
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 3>
do jd1 = 1, size(F%i_box,1); lb1 = lbound(F%i_box,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%i_box(jd1+lb1) = rhs
enddo

end subroutine set_tricubic_cmplx_coef_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_grid_field_pt1 (ok)

implicit none

type(grid_field_pt1_struct), target :: f_grid_field_pt1, f2_grid_field_pt1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_grid_field_pt1 (c_grid_field_pt1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_grid_field_pt1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_grid_field_pt1_test_pattern (f2_grid_field_pt1, 1)

call test_c_grid_field_pt1(c_loc(f2_grid_field_pt1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_grid_field_pt1_test_pattern (f_grid_field_pt1, 4)
if (f_grid_field_pt1 == f2_grid_field_pt1) then
  print *, '[4] grid_field_pt1: C side convert C->F: Good'
else
  print *, '[4] grid_field_pt1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call grid_field_pt1_struct_to_json(f_grid_field_pt1, json_root)
  call json%print(json_root, 'test_f_grid_field_pt1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_field_pt1_struct_to_json(f2_grid_field_pt1, json_root)
  call json%print(json_root, 'test_f_grid_field_pt1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_field_pt1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_field_pt1_test_pattern (f_grid_field_pt1, -1)
call set_grid_field_pt1_test_pattern (f2_grid_field_pt1, -1)

end subroutine test1_f_grid_field_pt1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_grid_field_pt1 (c_grid_field_pt1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_grid_field_pt1
type(grid_field_pt1_struct), target :: f_grid_field_pt1, f2_grid_field_pt1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call grid_field_pt1_to_f (c_grid_field_pt1, c_loc(f_grid_field_pt1))

call set_grid_field_pt1_test_pattern (f2_grid_field_pt1, 2)
if (f_grid_field_pt1 == f2_grid_field_pt1) then
  print *, '[2] grid_field_pt1: F side convert C->F: Good'
else
  print *, '[2] grid_field_pt1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call grid_field_pt1_struct_to_json(f_grid_field_pt1, json_root)
  call json%print(json_root, 'test_f_grid_field_pt1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_field_pt1_struct_to_json(f2_grid_field_pt1, json_root)
  call json%print(json_root, 'test_f_grid_field_pt1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_field_pt1_pattern_2_*.json)'

endif

call set_grid_field_pt1_test_pattern (f2_grid_field_pt1, 3)
call grid_field_pt1_to_c (c_loc(f2_grid_field_pt1), c_grid_field_pt1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_field_pt1_test_pattern (f_grid_field_pt1, -1)
call set_grid_field_pt1_test_pattern (f2_grid_field_pt1, -1)

end subroutine test2_f_grid_field_pt1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_grid_field_pt1_test_pattern (F, ix_patt)

implicit none

type(grid_field_pt1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_complex] FixedArray1D<Complex, 3>
do jd1 = 1, size(F%E,1); lb1 = lbound(F%E,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%E(jd1+lb1) = cmplx(rhs, 100+rhs)
enddo
!! f_side.test_pat[1D_NOT_complex] FixedArray1D<Complex, 3>
do jd1 = 1, size(F%B,1); lb1 = lbound(F%B,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%B(jd1+lb1) = cmplx(rhs, 100+rhs)
enddo

end subroutine set_grid_field_pt1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_grid_field_pt (ok)

implicit none

type(grid_field_pt_struct), target :: f_grid_field_pt, f2_grid_field_pt

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_grid_field_pt (c_grid_field_pt, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_grid_field_pt
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_grid_field_pt_test_pattern (f2_grid_field_pt, 1)

call test_c_grid_field_pt(c_loc(f2_grid_field_pt), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_grid_field_pt_test_pattern (f_grid_field_pt, 4)
if (f_grid_field_pt == f2_grid_field_pt) then
  print *, '[4] grid_field_pt: C side convert C->F: Good'
else
  print *, '[4] grid_field_pt: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call grid_field_pt_struct_to_json(f_grid_field_pt, json_root)
  call json%print(json_root, 'test_f_grid_field_pt_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_field_pt_struct_to_json(f2_grid_field_pt, json_root)
  call json%print(json_root, 'test_f_grid_field_pt_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_field_pt_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_field_pt_test_pattern (f_grid_field_pt, -1)
call set_grid_field_pt_test_pattern (f2_grid_field_pt, -1)

end subroutine test1_f_grid_field_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_grid_field_pt (c_grid_field_pt, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_grid_field_pt
type(grid_field_pt_struct), target :: f_grid_field_pt, f2_grid_field_pt
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call grid_field_pt_to_f (c_grid_field_pt, c_loc(f_grid_field_pt))

call set_grid_field_pt_test_pattern (f2_grid_field_pt, 2)
if (f_grid_field_pt == f2_grid_field_pt) then
  print *, '[2] grid_field_pt: F side convert C->F: Good'
else
  print *, '[2] grid_field_pt: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call grid_field_pt_struct_to_json(f_grid_field_pt, json_root)
  call json%print(json_root, 'test_f_grid_field_pt_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_field_pt_struct_to_json(f2_grid_field_pt, json_root)
  call json%print(json_root, 'test_f_grid_field_pt_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_field_pt_pattern_2_*.json)'

endif

call set_grid_field_pt_test_pattern (f2_grid_field_pt, 3)
call grid_field_pt_to_c (c_loc(f2_grid_field_pt), c_grid_field_pt)

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_field_pt_test_pattern (f_grid_field_pt, -1)
call set_grid_field_pt_test_pattern (f2_grid_field_pt, -1)

end subroutine test2_f_grid_field_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_grid_field_pt_test_pattern (F, ix_patt)

implicit none

type(grid_field_pt_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_link = rhs
!! f_side.test_pat[3D_ALLOC_type] VariableArray3D<CPP_grid_field_pt1>
if (ix_patt < 3) then
  if (allocated(F%pt)) deallocate (F%pt)
else
  if (.not. allocated(F%pt)) allocate (F%pt(-1:1, 2, 1))
  do jd1 = 1, size(F%pt,1); lb1 = lbound(F%pt,1) - 1
    do jd2 = 1, size(F%pt,2); lb2 = lbound(F%pt,2) - 1
      do jd3 = 1, size(F%pt,3); lb3 = lbound(F%pt,3) - 1
        call set_grid_field_pt1_test_pattern (F%pt(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+2*jd2+3*jd3)
      enddo
    enddo
  enddo
endif

end subroutine set_grid_field_pt_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_grid_field (ok)

implicit none

type(grid_field_struct), target :: f_grid_field, f2_grid_field

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_grid_field (c_grid_field, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_grid_field
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_grid_field_test_pattern (f2_grid_field, 1)

call test_c_grid_field(c_loc(f2_grid_field), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_grid_field_test_pattern (f_grid_field, 4)
if (f_grid_field == f2_grid_field) then
  print *, '[4] grid_field: C side convert C->F: Good'
else
  print *, '[4] grid_field: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call grid_field_struct_to_json(f_grid_field, json_root)
  call json%print(json_root, 'test_f_grid_field_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_field_struct_to_json(f2_grid_field, json_root)
  call json%print(json_root, 'test_f_grid_field_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_field_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_field_test_pattern (f_grid_field, -1)
call set_grid_field_test_pattern (f2_grid_field, -1)

end subroutine test1_f_grid_field

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_grid_field (c_grid_field, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_grid_field
type(grid_field_struct), target :: f_grid_field, f2_grid_field
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call grid_field_to_f (c_grid_field, c_loc(f_grid_field))

call set_grid_field_test_pattern (f2_grid_field, 2)
if (f_grid_field == f2_grid_field) then
  print *, '[2] grid_field: F side convert C->F: Good'
else
  print *, '[2] grid_field: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call grid_field_struct_to_json(f_grid_field, json_root)
  call json%print(json_root, 'test_f_grid_field_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_field_struct_to_json(f2_grid_field, json_root)
  call json%print(json_root, 'test_f_grid_field_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_field_pattern_2_*.json)'

endif

call set_grid_field_test_pattern (f2_grid_field, 3)
call grid_field_to_c (c_loc(f2_grid_field), c_grid_field)

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_field_test_pattern (f_grid_field, -1)
call set_grid_field_test_pattern (f2_grid_field, -1)

end subroutine test2_f_grid_field

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_grid_field_test_pattern (F, ix_patt)

implicit none

type(grid_field_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%geometry = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%harmonic = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%phi0_fieldmap = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%field_scale = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%field_type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 6 + offset; F%master_parameter = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%ele_anchor_pt = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%interpolation_order = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%dr,1); lb1 = lbound(F%dr,1) - 1
  rhs = 100 + jd1 + 9 + offset
  F%dr(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 10 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 11 + offset; F%curved_ref_frame = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_grid_field_pt>
if (ix_patt < 3) then
  if (associated(F%ptr)) then
    call set_grid_field_pt_test_pattern (F%ptr, -1)
    deallocate (F%ptr)
  endif
else
  if (.not. associated(F%ptr)) allocate (F%ptr)
  rhs = 12 + offset
  call set_grid_field_pt_test_pattern (F%ptr, ix_patt)
endif
!! f_side.test_pat[3D_NOT_type] FixedArray3D<CPP_bicubic_cmplx_coef, 4, 2, 3>
do jd1 = 1, size(F%bi_coef,1); lb1 = lbound(F%bi_coef,1) - 1
  do jd2 = 1, size(F%bi_coef,2); lb2 = lbound(F%bi_coef,2) - 1
    do jd3 = 1, size(F%bi_coef,3); lb3 = lbound(F%bi_coef,3) - 1
      rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 14 + offset
      if (ix_patt < 0) then
        call set_bicubic_cmplx_coef_test_pattern (F%bi_coef(jd1+lb1,jd2+lb2,jd3+lb3), -1)
      else
        call set_bicubic_cmplx_coef_test_pattern (F%bi_coef(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+10*jd2+100*jd3)
      endif
    enddo
  enddo
enddo
!! f_side.test_pat[3D_NOT_type] FixedArray3D<CPP_tricubic_cmplx_coef, 4, 2, 3>
do jd1 = 1, size(F%tri_coef,1); lb1 = lbound(F%tri_coef,1) - 1
  do jd2 = 1, size(F%tri_coef,2); lb2 = lbound(F%tri_coef,2) - 1
    do jd3 = 1, size(F%tri_coef,3); lb3 = lbound(F%tri_coef,3) - 1
      rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 15 + offset
      if (ix_patt < 0) then
        call set_tricubic_cmplx_coef_test_pattern (F%tri_coef(jd1+lb1,jd2+lb2,jd3+lb3), -1)
      else
        call set_tricubic_cmplx_coef_test_pattern (F%tri_coef(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+10*jd2+100*jd3)
      endif
    enddo
  enddo
enddo

end subroutine set_grid_field_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_floor_position (ok)

implicit none

type(floor_position_struct), target :: f_floor_position, f2_floor_position

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_floor_position (c_floor_position, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_floor_position
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_floor_position_test_pattern (f2_floor_position, 1)

call test_c_floor_position(c_loc(f2_floor_position), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_floor_position_test_pattern (f_floor_position, 4)
if (f_floor_position == f2_floor_position) then
  print *, '[4] floor_position: C side convert C->F: Good'
else
  print *, '[4] floor_position: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call floor_position_struct_to_json(f_floor_position, json_root)
  call json%print(json_root, 'test_f_floor_position_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call floor_position_struct_to_json(f2_floor_position, json_root)
  call json%print(json_root, 'test_f_floor_position_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_floor_position_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_floor_position_test_pattern (f_floor_position, -1)
call set_floor_position_test_pattern (f2_floor_position, -1)

end subroutine test1_f_floor_position

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_floor_position (c_floor_position, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_floor_position
type(floor_position_struct), target :: f_floor_position, f2_floor_position
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call floor_position_to_f (c_floor_position, c_loc(f_floor_position))

call set_floor_position_test_pattern (f2_floor_position, 2)
if (f_floor_position == f2_floor_position) then
  print *, '[2] floor_position: F side convert C->F: Good'
else
  print *, '[2] floor_position: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call floor_position_struct_to_json(f_floor_position, json_root)
  call json%print(json_root, 'test_f_floor_position_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call floor_position_struct_to_json(f2_floor_position, json_root)
  call json%print(json_root, 'test_f_floor_position_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_floor_position_pattern_2_*.json)'

endif

call set_floor_position_test_pattern (f2_floor_position, 3)
call floor_position_to_c (c_loc(f2_floor_position), c_floor_position)

! clean up test pattern data - < 3 deallocates arrays and such
call set_floor_position_test_pattern (f_floor_position, -1)
call set_floor_position_test_pattern (f2_floor_position, -1)

end subroutine test2_f_floor_position

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_floor_position_test_pattern (F, ix_patt)

implicit none

type(floor_position_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%r,1); lb1 = lbound(F%r,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%r(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 3, 3>
do jd1 = 1, size(F%w,1); lb1 = lbound(F%w,1) - 1
  do jd2 = 1, size(F%w,2); lb2 = lbound(F%w,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 2 + offset
    F%w(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%theta = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%psi = rhs

end subroutine set_floor_position_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_high_energy_space_charge (ok)

implicit none

type(high_energy_space_charge_struct), target :: f_high_energy_space_charge, f2_high_energy_space_charge

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_high_energy_space_charge (c_high_energy_space_charge, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_high_energy_space_charge
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_high_energy_space_charge_test_pattern (f2_high_energy_space_charge, 1)

call test_c_high_energy_space_charge(c_loc(f2_high_energy_space_charge), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_high_energy_space_charge_test_pattern (f_high_energy_space_charge, 4)
if (f_high_energy_space_charge == f2_high_energy_space_charge) then
  print *, '[4] high_energy_space_charge: C side convert C->F: Good'
else
  print *, '[4] high_energy_space_charge: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call high_energy_space_charge_struct_to_json(f_high_energy_space_charge, json_root)
  call json%print(json_root, 'test_f_high_energy_space_charge_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call high_energy_space_charge_struct_to_json(f2_high_energy_space_charge, json_root)
  call json%print(json_root, 'test_f_high_energy_space_charge_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_high_energy_space_charge_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_high_energy_space_charge_test_pattern (f_high_energy_space_charge, -1)
call set_high_energy_space_charge_test_pattern (f2_high_energy_space_charge, -1)

end subroutine test1_f_high_energy_space_charge

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_high_energy_space_charge (c_high_energy_space_charge, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_high_energy_space_charge
type(high_energy_space_charge_struct), target :: f_high_energy_space_charge, f2_high_energy_space_charge
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call high_energy_space_charge_to_f (c_high_energy_space_charge, c_loc(f_high_energy_space_charge))

call set_high_energy_space_charge_test_pattern (f2_high_energy_space_charge, 2)
if (f_high_energy_space_charge == f2_high_energy_space_charge) then
  print *, '[2] high_energy_space_charge: F side convert C->F: Good'
else
  print *, '[2] high_energy_space_charge: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call high_energy_space_charge_struct_to_json(f_high_energy_space_charge, json_root)
  call json%print(json_root, 'test_f_high_energy_space_charge_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call high_energy_space_charge_struct_to_json(f2_high_energy_space_charge, json_root)
  call json%print(json_root, 'test_f_high_energy_space_charge_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_high_energy_space_charge_pattern_2_*.json)'

endif

call set_high_energy_space_charge_test_pattern (f2_high_energy_space_charge, 3)
call high_energy_space_charge_to_c (c_loc(f2_high_energy_space_charge), c_high_energy_space_charge)

! clean up test pattern data - < 3 deallocates arrays and such
call set_high_energy_space_charge_test_pattern (f_high_energy_space_charge, -1)
call set_high_energy_space_charge_test_pattern (f2_high_energy_space_charge, -1)

end subroutine test2_f_high_energy_space_charge

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_high_energy_space_charge_test_pattern (F, ix_patt)

implicit none

type(high_energy_space_charge_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%closed_orb, ix_patt)
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%kick_const = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%sig_x = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%sig_y = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%sin_phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%cos_phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%sig_z = rhs

end subroutine set_high_energy_space_charge_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_xy_disp (ok)

implicit none

type(xy_disp_struct), target :: f_xy_disp, f2_xy_disp

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_xy_disp (c_xy_disp, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_xy_disp
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_xy_disp_test_pattern (f2_xy_disp, 1)

call test_c_xy_disp(c_loc(f2_xy_disp), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_xy_disp_test_pattern (f_xy_disp, 4)
if (f_xy_disp == f2_xy_disp) then
  print *, '[4] xy_disp: C side convert C->F: Good'
else
  print *, '[4] xy_disp: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call xy_disp_struct_to_json(f_xy_disp, json_root)
  call json%print(json_root, 'test_f_xy_disp_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call xy_disp_struct_to_json(f2_xy_disp, json_root)
  call json%print(json_root, 'test_f_xy_disp_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_xy_disp_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_xy_disp_test_pattern (f_xy_disp, -1)
call set_xy_disp_test_pattern (f2_xy_disp, -1)

end subroutine test1_f_xy_disp

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_xy_disp (c_xy_disp, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_xy_disp
type(xy_disp_struct), target :: f_xy_disp, f2_xy_disp
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call xy_disp_to_f (c_xy_disp, c_loc(f_xy_disp))

call set_xy_disp_test_pattern (f2_xy_disp, 2)
if (f_xy_disp == f2_xy_disp) then
  print *, '[2] xy_disp: F side convert C->F: Good'
else
  print *, '[2] xy_disp: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call xy_disp_struct_to_json(f_xy_disp, json_root)
  call json%print(json_root, 'test_f_xy_disp_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call xy_disp_struct_to_json(f2_xy_disp, json_root)
  call json%print(json_root, 'test_f_xy_disp_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_xy_disp_pattern_2_*.json)'

endif

call set_xy_disp_test_pattern (f2_xy_disp, 3)
call xy_disp_to_c (c_loc(f2_xy_disp), c_xy_disp)

! clean up test pattern data - < 3 deallocates arrays and such
call set_xy_disp_test_pattern (f_xy_disp, -1)
call set_xy_disp_test_pattern (f2_xy_disp, -1)

end subroutine test2_f_xy_disp

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_xy_disp_test_pattern (F, ix_patt)

implicit none

type(xy_disp_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%eta = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%etap = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%deta_ds = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%sigma = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%deta_dpz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%detap_dpz = rhs

end subroutine set_xy_disp_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_twiss (ok)

implicit none

type(twiss_struct), target :: f_twiss, f2_twiss

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_twiss (c_twiss, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_twiss
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_twiss_test_pattern (f2_twiss, 1)

call test_c_twiss(c_loc(f2_twiss), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_twiss_test_pattern (f_twiss, 4)
if (f_twiss == f2_twiss) then
  print *, '[4] twiss: C side convert C->F: Good'
else
  print *, '[4] twiss: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call twiss_struct_to_json(f_twiss, json_root)
  call json%print(json_root, 'test_f_twiss_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call twiss_struct_to_json(f2_twiss, json_root)
  call json%print(json_root, 'test_f_twiss_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_twiss_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_twiss_test_pattern (f_twiss, -1)
call set_twiss_test_pattern (f2_twiss, -1)

end subroutine test1_f_twiss

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_twiss (c_twiss, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_twiss
type(twiss_struct), target :: f_twiss, f2_twiss
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call twiss_to_f (c_twiss, c_loc(f_twiss))

call set_twiss_test_pattern (f2_twiss, 2)
if (f_twiss == f2_twiss) then
  print *, '[2] twiss: F side convert C->F: Good'
else
  print *, '[2] twiss: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call twiss_struct_to_json(f_twiss, json_root)
  call json%print(json_root, 'test_f_twiss_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call twiss_struct_to_json(f2_twiss, json_root)
  call json%print(json_root, 'test_f_twiss_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_twiss_pattern_2_*.json)'

endif

call set_twiss_test_pattern (f2_twiss, 3)
call twiss_to_c (c_loc(f2_twiss), c_twiss)

! clean up test pattern data - < 3 deallocates arrays and such
call set_twiss_test_pattern (f_twiss, -1)
call set_twiss_test_pattern (f2_twiss, -1)

end subroutine test2_f_twiss

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_twiss_test_pattern (F, ix_patt)

implicit none

type(twiss_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%beta = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%alpha = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%gamma = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%eta = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%etap = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%deta_ds = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%sigma = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%sigma_p = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%norm_emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 12 + offset; F%chrom = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 13 + offset; F%dbeta_dpz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 14 + offset; F%dalpha_dpz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 15 + offset; F%deta_dpz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 16 + offset; F%detap_dpz = rhs

end subroutine set_twiss_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_mode3 (ok)

implicit none

type(mode3_struct), target :: f_mode3, f2_mode3

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_mode3 (c_mode3, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_mode3
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_mode3_test_pattern (f2_mode3, 1)

call test_c_mode3(c_loc(f2_mode3), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_mode3_test_pattern (f_mode3, 4)
if (f_mode3 == f2_mode3) then
  print *, '[4] mode3: C side convert C->F: Good'
else
  print *, '[4] mode3: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call mode3_struct_to_json(f_mode3, json_root)
  call json%print(json_root, 'test_f_mode3_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call mode3_struct_to_json(f2_mode3, json_root)
  call json%print(json_root, 'test_f_mode3_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_mode3_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_mode3_test_pattern (f_mode3, -1)
call set_mode3_test_pattern (f2_mode3, -1)

end subroutine test1_f_mode3

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_mode3 (c_mode3, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_mode3
type(mode3_struct), target :: f_mode3, f2_mode3
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call mode3_to_f (c_mode3, c_loc(f_mode3))

call set_mode3_test_pattern (f2_mode3, 2)
if (f_mode3 == f2_mode3) then
  print *, '[2] mode3: F side convert C->F: Good'
else
  print *, '[2] mode3: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call mode3_struct_to_json(f_mode3, json_root)
  call json%print(json_root, 'test_f_mode3_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call mode3_struct_to_json(f2_mode3, json_root)
  call json%print(json_root, 'test_f_mode3_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_mode3_pattern_2_*.json)'

endif

call set_mode3_test_pattern (f2_mode3, 3)
call mode3_to_c (c_loc(f2_mode3), c_mode3)

! clean up test pattern data - < 3 deallocates arrays and such
call set_mode3_test_pattern (f_mode3, -1)
call set_mode3_test_pattern (f2_mode3, -1)

end subroutine test2_f_mode3

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_mode3_test_pattern (F, ix_patt)

implicit none

type(mode3_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%v,1); lb1 = lbound(F%v,1) - 1
  do jd2 = 1, size(F%v,2); lb2 = lbound(F%v,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 1 + offset
    F%v(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%a, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%b, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%c, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%x, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%y, ix_patt)

end subroutine set_mode3_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_bookkeeping_state (ok)

implicit none

type(bookkeeping_state_struct), target :: f_bookkeeping_state, f2_bookkeeping_state

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_bookkeeping_state (c_bookkeeping_state, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_bookkeeping_state
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_bookkeeping_state_test_pattern (f2_bookkeeping_state, 1)

call test_c_bookkeeping_state(c_loc(f2_bookkeeping_state), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_bookkeeping_state_test_pattern (f_bookkeeping_state, 4)
if (f_bookkeeping_state == f2_bookkeeping_state) then
  print *, '[4] bookkeeping_state: C side convert C->F: Good'
else
  print *, '[4] bookkeeping_state: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call bookkeeping_state_struct_to_json(f_bookkeeping_state, json_root)
  call json%print(json_root, 'test_f_bookkeeping_state_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bookkeeping_state_struct_to_json(f2_bookkeeping_state, json_root)
  call json%print(json_root, 'test_f_bookkeeping_state_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bookkeeping_state_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_bookkeeping_state_test_pattern (f_bookkeeping_state, -1)
call set_bookkeeping_state_test_pattern (f2_bookkeeping_state, -1)

end subroutine test1_f_bookkeeping_state

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_bookkeeping_state (c_bookkeeping_state, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_bookkeeping_state
type(bookkeeping_state_struct), target :: f_bookkeeping_state, f2_bookkeeping_state
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call bookkeeping_state_to_f (c_bookkeeping_state, c_loc(f_bookkeeping_state))

call set_bookkeeping_state_test_pattern (f2_bookkeeping_state, 2)
if (f_bookkeeping_state == f2_bookkeeping_state) then
  print *, '[2] bookkeeping_state: F side convert C->F: Good'
else
  print *, '[2] bookkeeping_state: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call bookkeeping_state_struct_to_json(f_bookkeeping_state, json_root)
  call json%print(json_root, 'test_f_bookkeeping_state_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bookkeeping_state_struct_to_json(f2_bookkeeping_state, json_root)
  call json%print(json_root, 'test_f_bookkeeping_state_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bookkeeping_state_pattern_2_*.json)'

endif

call set_bookkeeping_state_test_pattern (f2_bookkeeping_state, 3)
call bookkeeping_state_to_c (c_loc(f2_bookkeeping_state), c_bookkeeping_state)

! clean up test pattern data - < 3 deallocates arrays and such
call set_bookkeeping_state_test_pattern (f_bookkeeping_state, -1)
call set_bookkeeping_state_test_pattern (f2_bookkeeping_state, -1)

end subroutine test2_f_bookkeeping_state

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_bookkeeping_state_test_pattern (F, ix_patt)

implicit none

type(bookkeeping_state_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%attributes = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%control = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%floor_position = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%s_position = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%ref_energy = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 6 + offset; F%mat6 = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%rad_int = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%ptc = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 9 + offset; F%has_misalign = (modulo(rhs, 2) == 0)

end subroutine set_bookkeeping_state_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rad_map (ok)

implicit none

type(rad_map_struct), target :: f_rad_map, f2_rad_map

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rad_map (c_rad_map, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rad_map
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rad_map_test_pattern (f2_rad_map, 1)

call test_c_rad_map(c_loc(f2_rad_map), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rad_map_test_pattern (f_rad_map, 4)
if (f_rad_map == f2_rad_map) then
  print *, '[4] rad_map: C side convert C->F: Good'
else
  print *, '[4] rad_map: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rad_map_struct_to_json(f_rad_map, json_root)
  call json%print(json_root, 'test_f_rad_map_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_map_struct_to_json(f2_rad_map, json_root)
  call json%print(json_root, 'test_f_rad_map_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_map_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_map_test_pattern (f_rad_map, -1)
call set_rad_map_test_pattern (f2_rad_map, -1)

end subroutine test1_f_rad_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rad_map (c_rad_map, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rad_map
type(rad_map_struct), target :: f_rad_map, f2_rad_map
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rad_map_to_f (c_rad_map, c_loc(f_rad_map))

call set_rad_map_test_pattern (f2_rad_map, 2)
if (f_rad_map == f2_rad_map) then
  print *, '[2] rad_map: F side convert C->F: Good'
else
  print *, '[2] rad_map: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rad_map_struct_to_json(f_rad_map, json_root)
  call json%print(json_root, 'test_f_rad_map_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_map_struct_to_json(f2_rad_map, json_root)
  call json%print(json_root, 'test_f_rad_map_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_map_pattern_2_*.json)'

endif

call set_rad_map_test_pattern (f2_rad_map, 3)
call rad_map_to_c (c_loc(f2_rad_map), c_rad_map)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_map_test_pattern (f_rad_map, -1)
call set_rad_map_test_pattern (f2_rad_map, -1)

end subroutine test2_f_rad_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rad_map_test_pattern (F, ix_patt)

implicit none

type(rad_map_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%ref_orb,1); lb1 = lbound(F%ref_orb,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%ref_orb(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%damp_dmat,1); lb1 = lbound(F%damp_dmat,1) - 1
  do jd2 = 1, size(F%damp_dmat,2); lb2 = lbound(F%damp_dmat,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 2 + offset
    F%damp_dmat(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%xfer_damp_vec,1); lb1 = lbound(F%xfer_damp_vec,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%xfer_damp_vec(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%xfer_damp_mat,1); lb1 = lbound(F%xfer_damp_mat,1) - 1
  do jd2 = 1, size(F%xfer_damp_mat,2); lb2 = lbound(F%xfer_damp_mat,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 4 + offset
    F%xfer_damp_mat(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%stoc_mat,1); lb1 = lbound(F%stoc_mat,1) - 1
  do jd2 = 1, size(F%stoc_mat,2); lb2 = lbound(F%stoc_mat,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 5 + offset
    F%stoc_mat(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo

end subroutine set_rad_map_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rad_map_ele (ok)

implicit none

type(rad_map_ele_struct), target :: f_rad_map_ele, f2_rad_map_ele

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rad_map_ele (c_rad_map_ele, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rad_map_ele
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rad_map_ele_test_pattern (f2_rad_map_ele, 1)

call test_c_rad_map_ele(c_loc(f2_rad_map_ele), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rad_map_ele_test_pattern (f_rad_map_ele, 4)
if (f_rad_map_ele == f2_rad_map_ele) then
  print *, '[4] rad_map_ele: C side convert C->F: Good'
else
  print *, '[4] rad_map_ele: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rad_map_ele_struct_to_json(f_rad_map_ele, json_root)
  call json%print(json_root, 'test_f_rad_map_ele_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_map_ele_struct_to_json(f2_rad_map_ele, json_root)
  call json%print(json_root, 'test_f_rad_map_ele_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_map_ele_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_map_ele_test_pattern (f_rad_map_ele, -1)
call set_rad_map_ele_test_pattern (f2_rad_map_ele, -1)

end subroutine test1_f_rad_map_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rad_map_ele (c_rad_map_ele, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rad_map_ele
type(rad_map_ele_struct), target :: f_rad_map_ele, f2_rad_map_ele
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rad_map_ele_to_f (c_rad_map_ele, c_loc(f_rad_map_ele))

call set_rad_map_ele_test_pattern (f2_rad_map_ele, 2)
if (f_rad_map_ele == f2_rad_map_ele) then
  print *, '[2] rad_map_ele: F side convert C->F: Good'
else
  print *, '[2] rad_map_ele: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rad_map_ele_struct_to_json(f_rad_map_ele, json_root)
  call json%print(json_root, 'test_f_rad_map_ele_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_map_ele_struct_to_json(f2_rad_map_ele, json_root)
  call json%print(json_root, 'test_f_rad_map_ele_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_map_ele_pattern_2_*.json)'

endif

call set_rad_map_ele_test_pattern (f2_rad_map_ele, 3)
call rad_map_ele_to_c (c_loc(f2_rad_map_ele), c_rad_map_ele)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_map_ele_test_pattern (f_rad_map_ele, -1)
call set_rad_map_ele_test_pattern (f2_rad_map_ele, -1)

end subroutine test2_f_rad_map_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rad_map_ele_test_pattern (F, ix_patt)

implicit none

type(rad_map_ele_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_type] CPP_rad_map
call set_rad_map_test_pattern (F%rm0, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_rad_map
call set_rad_map_test_pattern (F%rm1, ix_patt)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 3 + offset; F%stale = (modulo(rhs, 2) == 0)

end subroutine set_rad_map_ele_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_gen_grad1 (ok)

implicit none

type(gen_grad1_struct), target :: f_gen_grad1, f2_gen_grad1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_gen_grad1 (c_gen_grad1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_gen_grad1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_gen_grad1_test_pattern (f2_gen_grad1, 1)

call test_c_gen_grad1(c_loc(f2_gen_grad1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_gen_grad1_test_pattern (f_gen_grad1, 4)
if (f_gen_grad1 == f2_gen_grad1) then
  print *, '[4] gen_grad1: C side convert C->F: Good'
else
  print *, '[4] gen_grad1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call gen_grad1_struct_to_json(f_gen_grad1, json_root)
  call json%print(json_root, 'test_f_gen_grad1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call gen_grad1_struct_to_json(f2_gen_grad1, json_root)
  call json%print(json_root, 'test_f_gen_grad1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_gen_grad1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_gen_grad1_test_pattern (f_gen_grad1, -1)
call set_gen_grad1_test_pattern (f2_gen_grad1, -1)

end subroutine test1_f_gen_grad1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_gen_grad1 (c_gen_grad1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_gen_grad1
type(gen_grad1_struct), target :: f_gen_grad1, f2_gen_grad1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call gen_grad1_to_f (c_gen_grad1, c_loc(f_gen_grad1))

call set_gen_grad1_test_pattern (f2_gen_grad1, 2)
if (f_gen_grad1 == f2_gen_grad1) then
  print *, '[2] gen_grad1: F side convert C->F: Good'
else
  print *, '[2] gen_grad1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call gen_grad1_struct_to_json(f_gen_grad1, json_root)
  call json%print(json_root, 'test_f_gen_grad1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call gen_grad1_struct_to_json(f2_gen_grad1, json_root)
  call json%print(json_root, 'test_f_gen_grad1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_gen_grad1_pattern_2_*.json)'

endif

call set_gen_grad1_test_pattern (f2_gen_grad1, 3)
call gen_grad1_to_c (c_loc(f2_gen_grad1), c_gen_grad1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_gen_grad1_test_pattern (f_gen_grad1, -1)
call set_gen_grad1_test_pattern (f2_gen_grad1, -1)

end subroutine test2_f_gen_grad1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_gen_grad1_test_pattern (F, ix_patt)

implicit none

type(gen_grad1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%m = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%sincos = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%n_deriv_max = rhs
!! f_side.test_pat[2D_ALLOC_real] VariableArray2D<Real>
if (ix_patt < 3) then
  if (allocated(F%deriv)) deallocate (F%deriv)
else
  if (.not. allocated(F%deriv)) allocate (F%deriv(-1:1, 2))
  do jd1 = 1, size(F%deriv,1); lb1 = lbound(F%deriv,1) - 1
    do jd2 = 1, size(F%deriv,2); lb2 = lbound(F%deriv,2) - 1
      rhs = 100 + jd1 + 10*jd2 + 4 + offset
      F%deriv(jd1+lb1,jd2+lb2) = rhs
    enddo
  enddo
endif

end subroutine set_gen_grad1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_gen_grad_map (ok)

implicit none

type(gen_grad_map_struct), target :: f_gen_grad_map, f2_gen_grad_map

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_gen_grad_map (c_gen_grad_map, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_gen_grad_map
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_gen_grad_map_test_pattern (f2_gen_grad_map, 1)

call test_c_gen_grad_map(c_loc(f2_gen_grad_map), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_gen_grad_map_test_pattern (f_gen_grad_map, 4)
if (f_gen_grad_map == f2_gen_grad_map) then
  print *, '[4] gen_grad_map: C side convert C->F: Good'
else
  print *, '[4] gen_grad_map: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call gen_grad_map_struct_to_json(f_gen_grad_map, json_root)
  call json%print(json_root, 'test_f_gen_grad_map_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call gen_grad_map_struct_to_json(f2_gen_grad_map, json_root)
  call json%print(json_root, 'test_f_gen_grad_map_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_gen_grad_map_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_gen_grad_map_test_pattern (f_gen_grad_map, -1)
call set_gen_grad_map_test_pattern (f2_gen_grad_map, -1)

end subroutine test1_f_gen_grad_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_gen_grad_map (c_gen_grad_map, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_gen_grad_map
type(gen_grad_map_struct), target :: f_gen_grad_map, f2_gen_grad_map
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call gen_grad_map_to_f (c_gen_grad_map, c_loc(f_gen_grad_map))

call set_gen_grad_map_test_pattern (f2_gen_grad_map, 2)
if (f_gen_grad_map == f2_gen_grad_map) then
  print *, '[2] gen_grad_map: F side convert C->F: Good'
else
  print *, '[2] gen_grad_map: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call gen_grad_map_struct_to_json(f_gen_grad_map, json_root)
  call json%print(json_root, 'test_f_gen_grad_map_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call gen_grad_map_struct_to_json(f2_gen_grad_map, json_root)
  call json%print(json_root, 'test_f_gen_grad_map_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_gen_grad_map_pattern_2_*.json)'

endif

call set_gen_grad_map_test_pattern (f2_gen_grad_map, 3)
call gen_grad_map_to_c (c_loc(f2_gen_grad_map), c_gen_grad_map)

! clean up test pattern data - < 3 deallocates arrays and such
call set_gen_grad_map_test_pattern (f_gen_grad_map, -1)
call set_gen_grad_map_test_pattern (f2_gen_grad_map, -1)

end subroutine test2_f_gen_grad_map

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_gen_grad_map_test_pattern (F, ix_patt)

implicit none

type(gen_grad_map_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_gen_grad1>
if (ix_patt < 3) then
  if (allocated(F%gg)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%gg,1), ubound(F%gg,1)
      call set_gen_grad1_test_pattern (F%gg(jd1), -1)
    enddo
    deallocate (F%gg)
  endif
else
  if (.not. allocated(F%gg)) then
    allocate (F%gg(-1:1))
  endif
  do jd1 = 1, size(F%gg,1)
    lb1 = lbound(F%gg,1) - 1
    call set_gen_grad1_test_pattern (F%gg(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%ele_anchor_pt = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%field_type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 6 + offset; F%iz0 = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%iz1 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%dz = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 9 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%field_scale = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 11 + offset; F%master_parameter = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 12 + offset; F%curved_ref_frame = (modulo(rhs, 2) == 0)

end subroutine set_gen_grad_map_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_segmented_pt (ok)

implicit none

type(surface_segmented_pt_struct), target :: f_surface_segmented_pt, f2_surface_segmented_pt

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_segmented_pt (c_surface_segmented_pt, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_segmented_pt
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_segmented_pt_test_pattern (f2_surface_segmented_pt, 1)

call test_c_surface_segmented_pt(c_loc(f2_surface_segmented_pt), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_segmented_pt_test_pattern (f_surface_segmented_pt, 4)
if (f_surface_segmented_pt == f2_surface_segmented_pt) then
  print *, '[4] surface_segmented_pt: C side convert C->F: Good'
else
  print *, '[4] surface_segmented_pt: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_segmented_pt_struct_to_json(f_surface_segmented_pt, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pt_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_segmented_pt_struct_to_json(f2_surface_segmented_pt, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pt_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_segmented_pt_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_segmented_pt_test_pattern (f_surface_segmented_pt, -1)
call set_surface_segmented_pt_test_pattern (f2_surface_segmented_pt, -1)

end subroutine test1_f_surface_segmented_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_segmented_pt (c_surface_segmented_pt, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_segmented_pt
type(surface_segmented_pt_struct), target :: f_surface_segmented_pt, f2_surface_segmented_pt
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_segmented_pt_to_f (c_surface_segmented_pt, c_loc(f_surface_segmented_pt))

call set_surface_segmented_pt_test_pattern (f2_surface_segmented_pt, 2)
if (f_surface_segmented_pt == f2_surface_segmented_pt) then
  print *, '[2] surface_segmented_pt: F side convert C->F: Good'
else
  print *, '[2] surface_segmented_pt: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_segmented_pt_struct_to_json(f_surface_segmented_pt, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pt_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_segmented_pt_struct_to_json(f2_surface_segmented_pt, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pt_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_segmented_pt_pattern_2_*.json)'

endif

call set_surface_segmented_pt_test_pattern (f2_surface_segmented_pt, 3)
call surface_segmented_pt_to_c (c_loc(f2_surface_segmented_pt), c_surface_segmented_pt)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_segmented_pt_test_pattern (f_surface_segmented_pt, -1)
call set_surface_segmented_pt_test_pattern (f2_surface_segmented_pt, -1)

end subroutine test2_f_surface_segmented_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_segmented_pt_test_pattern (F, ix_patt)

implicit none

type(surface_segmented_pt_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%x0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%y0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%z0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%dz_dx = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%dz_dy = rhs

end subroutine set_surface_segmented_pt_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_segmented (ok)

implicit none

type(surface_segmented_struct), target :: f_surface_segmented, f2_surface_segmented

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_segmented (c_surface_segmented, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_segmented
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_segmented_test_pattern (f2_surface_segmented, 1)

call test_c_surface_segmented(c_loc(f2_surface_segmented), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_segmented_test_pattern (f_surface_segmented, 4)
if (f_surface_segmented == f2_surface_segmented) then
  print *, '[4] surface_segmented: C side convert C->F: Good'
else
  print *, '[4] surface_segmented: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_segmented_struct_to_json(f_surface_segmented, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_segmented_struct_to_json(f2_surface_segmented, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_segmented_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_segmented_test_pattern (f_surface_segmented, -1)
call set_surface_segmented_test_pattern (f2_surface_segmented, -1)

end subroutine test1_f_surface_segmented

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_segmented (c_surface_segmented, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_segmented
type(surface_segmented_struct), target :: f_surface_segmented, f2_surface_segmented
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_segmented_to_f (c_surface_segmented, c_loc(f_surface_segmented))

call set_surface_segmented_test_pattern (f2_surface_segmented, 2)
if (f_surface_segmented == f2_surface_segmented) then
  print *, '[2] surface_segmented: F side convert C->F: Good'
else
  print *, '[2] surface_segmented: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_segmented_struct_to_json(f_surface_segmented, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_segmented_struct_to_json(f2_surface_segmented, json_root)
  call json%print(json_root, 'test_f_surface_segmented_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_segmented_pattern_2_*.json)'

endif

call set_surface_segmented_test_pattern (f2_surface_segmented, 3)
call surface_segmented_to_c (c_loc(f2_surface_segmented), c_surface_segmented)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_segmented_test_pattern (f_surface_segmented, -1)
call set_surface_segmented_test_pattern (f2_surface_segmented, -1)

end subroutine test2_f_surface_segmented

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_segmented_test_pattern (F, ix_patt)

implicit none

type(surface_segmented_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 1 + offset; F%active = (modulo(rhs, 2) == 0)
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%dr,1); lb1 = lbound(F%dr,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%dr(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_ALLOC_type] VariableArray2D<CPP_surface_segmented_pt>
if (ix_patt < 3) then
  if (allocated(F%pt)) deallocate (F%pt)
else
  if (.not. allocated(F%pt)) allocate (F%pt(-1:1, 2))
  do jd1 = 1, size(F%pt,1); lb1 = lbound(F%pt,1) - 1
    do jd2 = 1, size(F%pt,2); lb2 = lbound(F%pt,2) - 1
      call set_surface_segmented_pt_test_pattern (F%pt(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)
    enddo
  enddo
endif

end subroutine set_surface_segmented_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_h_misalign_pt (ok)

implicit none

type(surface_h_misalign_pt_struct), target :: f_surface_h_misalign_pt, f2_surface_h_misalign_pt

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_h_misalign_pt (c_surface_h_misalign_pt, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_h_misalign_pt
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_h_misalign_pt_test_pattern (f2_surface_h_misalign_pt, 1)

call test_c_surface_h_misalign_pt(c_loc(f2_surface_h_misalign_pt), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_h_misalign_pt_test_pattern (f_surface_h_misalign_pt, 4)
if (f_surface_h_misalign_pt == f2_surface_h_misalign_pt) then
  print *, '[4] surface_h_misalign_pt: C side convert C->F: Good'
else
  print *, '[4] surface_h_misalign_pt: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_h_misalign_pt_struct_to_json(f_surface_h_misalign_pt, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pt_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_h_misalign_pt_struct_to_json(f2_surface_h_misalign_pt, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pt_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_h_misalign_pt_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_h_misalign_pt_test_pattern (f_surface_h_misalign_pt, -1)
call set_surface_h_misalign_pt_test_pattern (f2_surface_h_misalign_pt, -1)

end subroutine test1_f_surface_h_misalign_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_h_misalign_pt (c_surface_h_misalign_pt, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_h_misalign_pt
type(surface_h_misalign_pt_struct), target :: f_surface_h_misalign_pt, f2_surface_h_misalign_pt
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_h_misalign_pt_to_f (c_surface_h_misalign_pt, c_loc(f_surface_h_misalign_pt))

call set_surface_h_misalign_pt_test_pattern (f2_surface_h_misalign_pt, 2)
if (f_surface_h_misalign_pt == f2_surface_h_misalign_pt) then
  print *, '[2] surface_h_misalign_pt: F side convert C->F: Good'
else
  print *, '[2] surface_h_misalign_pt: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_h_misalign_pt_struct_to_json(f_surface_h_misalign_pt, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pt_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_h_misalign_pt_struct_to_json(f2_surface_h_misalign_pt, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pt_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_h_misalign_pt_pattern_2_*.json)'

endif

call set_surface_h_misalign_pt_test_pattern (f2_surface_h_misalign_pt, 3)
call surface_h_misalign_pt_to_c (c_loc(f2_surface_h_misalign_pt), c_surface_h_misalign_pt)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_h_misalign_pt_test_pattern (f_surface_h_misalign_pt, -1)
call set_surface_h_misalign_pt_test_pattern (f2_surface_h_misalign_pt, -1)

end subroutine test2_f_surface_h_misalign_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_h_misalign_pt_test_pattern (F, ix_patt)

implicit none

type(surface_h_misalign_pt_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%x0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%y0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%rot_y = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%rot_t = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%rot_y_rms = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%rot_t_rms = rhs

end subroutine set_surface_h_misalign_pt_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_h_misalign (ok)

implicit none

type(surface_h_misalign_struct), target :: f_surface_h_misalign, f2_surface_h_misalign

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_h_misalign (c_surface_h_misalign, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_h_misalign
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_h_misalign_test_pattern (f2_surface_h_misalign, 1)

call test_c_surface_h_misalign(c_loc(f2_surface_h_misalign), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_h_misalign_test_pattern (f_surface_h_misalign, 4)
if (f_surface_h_misalign == f2_surface_h_misalign) then
  print *, '[4] surface_h_misalign: C side convert C->F: Good'
else
  print *, '[4] surface_h_misalign: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_h_misalign_struct_to_json(f_surface_h_misalign, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_h_misalign_struct_to_json(f2_surface_h_misalign, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_h_misalign_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_h_misalign_test_pattern (f_surface_h_misalign, -1)
call set_surface_h_misalign_test_pattern (f2_surface_h_misalign, -1)

end subroutine test1_f_surface_h_misalign

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_h_misalign (c_surface_h_misalign, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_h_misalign
type(surface_h_misalign_struct), target :: f_surface_h_misalign, f2_surface_h_misalign
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_h_misalign_to_f (c_surface_h_misalign, c_loc(f_surface_h_misalign))

call set_surface_h_misalign_test_pattern (f2_surface_h_misalign, 2)
if (f_surface_h_misalign == f2_surface_h_misalign) then
  print *, '[2] surface_h_misalign: F side convert C->F: Good'
else
  print *, '[2] surface_h_misalign: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_h_misalign_struct_to_json(f_surface_h_misalign, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_h_misalign_struct_to_json(f2_surface_h_misalign, json_root)
  call json%print(json_root, 'test_f_surface_h_misalign_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_h_misalign_pattern_2_*.json)'

endif

call set_surface_h_misalign_test_pattern (f2_surface_h_misalign, 3)
call surface_h_misalign_to_c (c_loc(f2_surface_h_misalign), c_surface_h_misalign)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_h_misalign_test_pattern (f_surface_h_misalign, -1)
call set_surface_h_misalign_test_pattern (f2_surface_h_misalign, -1)

end subroutine test2_f_surface_h_misalign

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_h_misalign_test_pattern (F, ix_patt)

implicit none

type(surface_h_misalign_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 1 + offset; F%active = (modulo(rhs, 2) == 0)
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%dr,1); lb1 = lbound(F%dr,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%dr(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_ALLOC_type] VariableArray2D<CPP_surface_h_misalign_pt>
if (ix_patt < 3) then
  if (allocated(F%pt)) deallocate (F%pt)
else
  if (.not. allocated(F%pt)) allocate (F%pt(-1:1, 2))
  do jd1 = 1, size(F%pt,1); lb1 = lbound(F%pt,1) - 1
    do jd2 = 1, size(F%pt,2); lb2 = lbound(F%pt,2) - 1
      call set_surface_h_misalign_pt_test_pattern (F%pt(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)
    enddo
  enddo
endif

end subroutine set_surface_h_misalign_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_displacement_pt (ok)

implicit none

type(surface_displacement_pt_struct), target :: f_surface_displacement_pt, f2_surface_displacement_pt

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_displacement_pt (c_surface_displacement_pt, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_displacement_pt
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_displacement_pt_test_pattern (f2_surface_displacement_pt, 1)

call test_c_surface_displacement_pt(c_loc(f2_surface_displacement_pt), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_displacement_pt_test_pattern (f_surface_displacement_pt, 4)
if (f_surface_displacement_pt == f2_surface_displacement_pt) then
  print *, '[4] surface_displacement_pt: C side convert C->F: Good'
else
  print *, '[4] surface_displacement_pt: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_displacement_pt_struct_to_json(f_surface_displacement_pt, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pt_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_displacement_pt_struct_to_json(f2_surface_displacement_pt, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pt_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_displacement_pt_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_displacement_pt_test_pattern (f_surface_displacement_pt, -1)
call set_surface_displacement_pt_test_pattern (f2_surface_displacement_pt, -1)

end subroutine test1_f_surface_displacement_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_displacement_pt (c_surface_displacement_pt, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_displacement_pt
type(surface_displacement_pt_struct), target :: f_surface_displacement_pt, f2_surface_displacement_pt
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_displacement_pt_to_f (c_surface_displacement_pt, c_loc(f_surface_displacement_pt))

call set_surface_displacement_pt_test_pattern (f2_surface_displacement_pt, 2)
if (f_surface_displacement_pt == f2_surface_displacement_pt) then
  print *, '[2] surface_displacement_pt: F side convert C->F: Good'
else
  print *, '[2] surface_displacement_pt: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_displacement_pt_struct_to_json(f_surface_displacement_pt, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pt_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_displacement_pt_struct_to_json(f2_surface_displacement_pt, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pt_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_displacement_pt_pattern_2_*.json)'

endif

call set_surface_displacement_pt_test_pattern (f2_surface_displacement_pt, 3)
call surface_displacement_pt_to_c (c_loc(f2_surface_displacement_pt), c_surface_displacement_pt)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_displacement_pt_test_pattern (f_surface_displacement_pt, -1)
call set_surface_displacement_pt_test_pattern (f2_surface_displacement_pt, -1)

end subroutine test2_f_surface_displacement_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_displacement_pt_test_pattern (F, ix_patt)

implicit none

type(surface_displacement_pt_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%x0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%y0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%z0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%dz_dx = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%dz_dy = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%d2z_dxdy = rhs

end subroutine set_surface_displacement_pt_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_displacement (ok)

implicit none

type(surface_displacement_struct), target :: f_surface_displacement, f2_surface_displacement

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_displacement (c_surface_displacement, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_displacement
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_displacement_test_pattern (f2_surface_displacement, 1)

call test_c_surface_displacement(c_loc(f2_surface_displacement), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_displacement_test_pattern (f_surface_displacement, 4)
if (f_surface_displacement == f2_surface_displacement) then
  print *, '[4] surface_displacement: C side convert C->F: Good'
else
  print *, '[4] surface_displacement: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_displacement_struct_to_json(f_surface_displacement, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_displacement_struct_to_json(f2_surface_displacement, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_displacement_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_displacement_test_pattern (f_surface_displacement, -1)
call set_surface_displacement_test_pattern (f2_surface_displacement, -1)

end subroutine test1_f_surface_displacement

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_displacement (c_surface_displacement, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_displacement
type(surface_displacement_struct), target :: f_surface_displacement, f2_surface_displacement
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_displacement_to_f (c_surface_displacement, c_loc(f_surface_displacement))

call set_surface_displacement_test_pattern (f2_surface_displacement, 2)
if (f_surface_displacement == f2_surface_displacement) then
  print *, '[2] surface_displacement: F side convert C->F: Good'
else
  print *, '[2] surface_displacement: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_displacement_struct_to_json(f_surface_displacement, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_displacement_struct_to_json(f2_surface_displacement, json_root)
  call json%print(json_root, 'test_f_surface_displacement_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_displacement_pattern_2_*.json)'

endif

call set_surface_displacement_test_pattern (f2_surface_displacement, 3)
call surface_displacement_to_c (c_loc(f2_surface_displacement), c_surface_displacement)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_displacement_test_pattern (f_surface_displacement, -1)
call set_surface_displacement_test_pattern (f2_surface_displacement, -1)

end subroutine test2_f_surface_displacement

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_displacement_test_pattern (F, ix_patt)

implicit none

type(surface_displacement_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 1 + offset; F%active = (modulo(rhs, 2) == 0)
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%dr,1); lb1 = lbound(F%dr,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%dr(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_ALLOC_type] VariableArray2D<CPP_surface_displacement_pt>
if (ix_patt < 3) then
  if (allocated(F%pt)) deallocate (F%pt)
else
  if (.not. allocated(F%pt)) allocate (F%pt(-1:1, 2))
  do jd1 = 1, size(F%pt,1); lb1 = lbound(F%pt,1) - 1
    do jd2 = 1, size(F%pt,2); lb2 = lbound(F%pt,2) - 1
      call set_surface_displacement_pt_test_pattern (F%pt(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)
    enddo
  enddo
endif

end subroutine set_surface_displacement_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_target_point (ok)

implicit none

type(target_point_struct), target :: f_target_point, f2_target_point

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_target_point (c_target_point, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_target_point
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_target_point_test_pattern (f2_target_point, 1)

call test_c_target_point(c_loc(f2_target_point), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_target_point_test_pattern (f_target_point, 4)
if (f_target_point == f2_target_point) then
  print *, '[4] target_point: C side convert C->F: Good'
else
  print *, '[4] target_point: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call target_point_struct_to_json(f_target_point, json_root)
  call json%print(json_root, 'test_f_target_point_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call target_point_struct_to_json(f2_target_point, json_root)
  call json%print(json_root, 'test_f_target_point_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_target_point_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_target_point_test_pattern (f_target_point, -1)
call set_target_point_test_pattern (f2_target_point, -1)

end subroutine test1_f_target_point

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_target_point (c_target_point, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_target_point
type(target_point_struct), target :: f_target_point, f2_target_point
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call target_point_to_f (c_target_point, c_loc(f_target_point))

call set_target_point_test_pattern (f2_target_point, 2)
if (f_target_point == f2_target_point) then
  print *, '[2] target_point: F side convert C->F: Good'
else
  print *, '[2] target_point: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call target_point_struct_to_json(f_target_point, json_root)
  call json%print(json_root, 'test_f_target_point_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call target_point_struct_to_json(f2_target_point, json_root)
  call json%print(json_root, 'test_f_target_point_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_target_point_pattern_2_*.json)'

endif

call set_target_point_test_pattern (f2_target_point, 3)
call target_point_to_c (c_loc(f2_target_point), c_target_point)

! clean up test pattern data - < 3 deallocates arrays and such
call set_target_point_test_pattern (f_target_point, -1)
call set_target_point_test_pattern (f2_target_point, -1)

end subroutine test2_f_target_point

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_target_point_test_pattern (F, ix_patt)

implicit none

type(target_point_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%r,1); lb1 = lbound(F%r,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%r(jd1+lb1) = rhs
enddo

end subroutine set_target_point_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_surface_curvature (ok)

implicit none

type(surface_curvature_struct), target :: f_surface_curvature, f2_surface_curvature

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_surface_curvature (c_surface_curvature, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_surface_curvature
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_surface_curvature_test_pattern (f2_surface_curvature, 1)

call test_c_surface_curvature(c_loc(f2_surface_curvature), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_surface_curvature_test_pattern (f_surface_curvature, 4)
if (f_surface_curvature == f2_surface_curvature) then
  print *, '[4] surface_curvature: C side convert C->F: Good'
else
  print *, '[4] surface_curvature: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call surface_curvature_struct_to_json(f_surface_curvature, json_root)
  call json%print(json_root, 'test_f_surface_curvature_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_curvature_struct_to_json(f2_surface_curvature, json_root)
  call json%print(json_root, 'test_f_surface_curvature_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_curvature_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_curvature_test_pattern (f_surface_curvature, -1)
call set_surface_curvature_test_pattern (f2_surface_curvature, -1)

end subroutine test1_f_surface_curvature

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_surface_curvature (c_surface_curvature, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_surface_curvature
type(surface_curvature_struct), target :: f_surface_curvature, f2_surface_curvature
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call surface_curvature_to_f (c_surface_curvature, c_loc(f_surface_curvature))

call set_surface_curvature_test_pattern (f2_surface_curvature, 2)
if (f_surface_curvature == f2_surface_curvature) then
  print *, '[2] surface_curvature: F side convert C->F: Good'
else
  print *, '[2] surface_curvature: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call surface_curvature_struct_to_json(f_surface_curvature, json_root)
  call json%print(json_root, 'test_f_surface_curvature_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call surface_curvature_struct_to_json(f2_surface_curvature, json_root)
  call json%print(json_root, 'test_f_surface_curvature_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_surface_curvature_pattern_2_*.json)'

endif

call set_surface_curvature_test_pattern (f2_surface_curvature, 3)
call surface_curvature_to_c (c_loc(f2_surface_curvature), c_surface_curvature)

! clean up test pattern data - < 3 deallocates arrays and such
call set_surface_curvature_test_pattern (f_surface_curvature, -1)
call set_surface_curvature_test_pattern (f2_surface_curvature, -1)

end subroutine test2_f_surface_curvature

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_surface_curvature_test_pattern (F, ix_patt)

implicit none

type(surface_curvature_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 7, 7>
do jd1 = 1, size(F%xy,1); lb1 = lbound(F%xy,1) - 1
  do jd2 = 1, size(F%xy,2); lb2 = lbound(F%xy,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 1 + offset
    F%xy(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%spherical = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%elliptical,1); lb1 = lbound(F%elliptical,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%elliptical(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 4 + offset; F%has_curvature = (modulo(rhs, 2) == 0)

end subroutine set_surface_curvature_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_photon_target (ok)

implicit none

type(photon_target_struct), target :: f_photon_target, f2_photon_target

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_photon_target (c_photon_target, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_photon_target
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_photon_target_test_pattern (f2_photon_target, 1)

call test_c_photon_target(c_loc(f2_photon_target), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_photon_target_test_pattern (f_photon_target, 4)
if (f_photon_target == f2_photon_target) then
  print *, '[4] photon_target: C side convert C->F: Good'
else
  print *, '[4] photon_target: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call photon_target_struct_to_json(f_photon_target, json_root)
  call json%print(json_root, 'test_f_photon_target_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_target_struct_to_json(f2_photon_target, json_root)
  call json%print(json_root, 'test_f_photon_target_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_target_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_target_test_pattern (f_photon_target, -1)
call set_photon_target_test_pattern (f2_photon_target, -1)

end subroutine test1_f_photon_target

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_photon_target (c_photon_target, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_photon_target
type(photon_target_struct), target :: f_photon_target, f2_photon_target
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call photon_target_to_f (c_photon_target, c_loc(f_photon_target))

call set_photon_target_test_pattern (f2_photon_target, 2)
if (f_photon_target == f2_photon_target) then
  print *, '[2] photon_target: F side convert C->F: Good'
else
  print *, '[2] photon_target: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call photon_target_struct_to_json(f_photon_target, json_root)
  call json%print(json_root, 'test_f_photon_target_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_target_struct_to_json(f2_photon_target, json_root)
  call json%print(json_root, 'test_f_photon_target_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_target_pattern_2_*.json)'

endif

call set_photon_target_test_pattern (f2_photon_target, 3)
call photon_target_to_c (c_loc(f2_photon_target), c_photon_target)

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_target_test_pattern (f_photon_target, -1)
call set_photon_target_test_pattern (f2_photon_target, -1)

end subroutine test2_f_photon_target

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_photon_target_test_pattern (F, ix_patt)

implicit none

type(photon_target_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_corner = rhs
!! f_side.test_pat[0D_NOT_type] CPP_lat_ele_loc
call set_lat_ele_loc_test_pattern (F%ele_loc, ix_patt)
!! f_side.test_pat[1D_NOT_type] FixedArray1D<CPP_target_point, 8>
if (ix_patt < 0) then
  ! pattern < 0 means clean up memory
  do jd1 = lbound(F%corner,1), ubound(F%corner,1)
    call set_target_point_test_pattern (F%corner(jd1), -1)
  enddo
else
  do jd1 = 1, size(F%corner,1)
    lb1 = lbound(F%corner,1) - 1
    rhs = 100 + jd1 + 4 + offset
    call set_target_point_test_pattern (F%corner(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_target_point
call set_target_point_test_pattern (F%center, ix_patt)

end subroutine set_photon_target_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_photon_material (ok)

implicit none

type(photon_material_struct), target :: f_photon_material, f2_photon_material

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_photon_material (c_photon_material, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_photon_material
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_photon_material_test_pattern (f2_photon_material, 1)

call test_c_photon_material(c_loc(f2_photon_material), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_photon_material_test_pattern (f_photon_material, 4)
if (f_photon_material == f2_photon_material) then
  print *, '[4] photon_material: C side convert C->F: Good'
else
  print *, '[4] photon_material: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call photon_material_struct_to_json(f_photon_material, json_root)
  call json%print(json_root, 'test_f_photon_material_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_material_struct_to_json(f2_photon_material, json_root)
  call json%print(json_root, 'test_f_photon_material_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_material_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_material_test_pattern (f_photon_material, -1)
call set_photon_material_test_pattern (f2_photon_material, -1)

end subroutine test1_f_photon_material

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_photon_material (c_photon_material, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_photon_material
type(photon_material_struct), target :: f_photon_material, f2_photon_material
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call photon_material_to_f (c_photon_material, c_loc(f_photon_material))

call set_photon_material_test_pattern (f2_photon_material, 2)
if (f_photon_material == f2_photon_material) then
  print *, '[2] photon_material: F side convert C->F: Good'
else
  print *, '[2] photon_material: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call photon_material_struct_to_json(f_photon_material, json_root)
  call json%print(json_root, 'test_f_photon_material_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_material_struct_to_json(f2_photon_material, json_root)
  call json%print(json_root, 'test_f_photon_material_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_material_pattern_2_*.json)'

endif

call set_photon_material_test_pattern (f2_photon_material, 3)
call photon_material_to_c (c_loc(f2_photon_material), c_photon_material)

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_material_test_pattern (f_photon_material, -1)
call set_photon_material_test_pattern (f2_photon_material, -1)

end subroutine test2_f_photon_material

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_photon_material_test_pattern (F, ix_patt)

implicit none

type(photon_material_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 1 + offset; F%f0_m1 = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 2 + offset; F%f0_m2 = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 3 + offset; F%f_0 = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 4 + offset; F%f_h = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 5 + offset; F%f_hbar = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 6 + offset; F%f_hkl = cmplx(rhs, 100+rhs)
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%h_norm,1); lb1 = lbound(F%h_norm,1) - 1
  rhs = 100 + jd1 + 7 + offset
  F%h_norm(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%l_ref,1); lb1 = lbound(F%l_ref,1) - 1
  rhs = 100 + jd1 + 8 + offset
  F%l_ref(jd1+lb1) = rhs
enddo

end subroutine set_photon_material_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_pixel_pt (ok)

implicit none

type(pixel_pt_struct), target :: f_pixel_pt, f2_pixel_pt

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_pixel_pt (c_pixel_pt, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_pixel_pt
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_pixel_pt_test_pattern (f2_pixel_pt, 1)

call test_c_pixel_pt(c_loc(f2_pixel_pt), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_pixel_pt_test_pattern (f_pixel_pt, 4)
if (f_pixel_pt == f2_pixel_pt) then
  print *, '[4] pixel_pt: C side convert C->F: Good'
else
  print *, '[4] pixel_pt: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call pixel_pt_struct_to_json(f_pixel_pt, json_root)
  call json%print(json_root, 'test_f_pixel_pt_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call pixel_pt_struct_to_json(f2_pixel_pt, json_root)
  call json%print(json_root, 'test_f_pixel_pt_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_pixel_pt_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_pixel_pt_test_pattern (f_pixel_pt, -1)
call set_pixel_pt_test_pattern (f2_pixel_pt, -1)

end subroutine test1_f_pixel_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_pixel_pt (c_pixel_pt, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_pixel_pt
type(pixel_pt_struct), target :: f_pixel_pt, f2_pixel_pt
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call pixel_pt_to_f (c_pixel_pt, c_loc(f_pixel_pt))

call set_pixel_pt_test_pattern (f2_pixel_pt, 2)
if (f_pixel_pt == f2_pixel_pt) then
  print *, '[2] pixel_pt: F side convert C->F: Good'
else
  print *, '[2] pixel_pt: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call pixel_pt_struct_to_json(f_pixel_pt, json_root)
  call json%print(json_root, 'test_f_pixel_pt_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call pixel_pt_struct_to_json(f2_pixel_pt, json_root)
  call json%print(json_root, 'test_f_pixel_pt_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_pixel_pt_pattern_2_*.json)'

endif

call set_pixel_pt_test_pattern (f2_pixel_pt, 3)
call pixel_pt_to_c (c_loc(f2_pixel_pt), c_pixel_pt)

! clean up test pattern data - < 3 deallocates arrays and such
call set_pixel_pt_test_pattern (f_pixel_pt, -1)
call set_pixel_pt_test_pattern (f2_pixel_pt, -1)

end subroutine test2_f_pixel_pt

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_pixel_pt_test_pattern (F, ix_patt)

implicit none

type(pixel_pt_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer8] Int8
rhs = 1 + offset; F%n_photon = rhs
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 2 + offset; F%E_x = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 3 + offset; F%E_y = cmplx(rhs, 100+rhs)
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%intensity_x = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%intensity_y = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%intensity = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%orbit,1); lb1 = lbound(F%orbit,1) - 1
  rhs = 100 + jd1 + 7 + offset
  F%orbit(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%orbit_rms,1); lb1 = lbound(F%orbit_rms,1) - 1
  rhs = 100 + jd1 + 8 + offset
  F%orbit_rms(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%init_orbit,1); lb1 = lbound(F%init_orbit,1) - 1
  rhs = 100 + jd1 + 9 + offset
  F%init_orbit(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%init_orbit_rms,1); lb1 = lbound(F%init_orbit_rms,1) - 1
  rhs = 100 + jd1 + 10 + offset
  F%init_orbit_rms(jd1+lb1) = rhs
enddo

end subroutine set_pixel_pt_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_pixel_detec (ok)

implicit none

type(pixel_detec_struct), target :: f_pixel_detec, f2_pixel_detec

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_pixel_detec (c_pixel_detec, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_pixel_detec
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_pixel_detec_test_pattern (f2_pixel_detec, 1)

call test_c_pixel_detec(c_loc(f2_pixel_detec), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_pixel_detec_test_pattern (f_pixel_detec, 4)
if (f_pixel_detec == f2_pixel_detec) then
  print *, '[4] pixel_detec: C side convert C->F: Good'
else
  print *, '[4] pixel_detec: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call pixel_detec_struct_to_json(f_pixel_detec, json_root)
  call json%print(json_root, 'test_f_pixel_detec_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call pixel_detec_struct_to_json(f2_pixel_detec, json_root)
  call json%print(json_root, 'test_f_pixel_detec_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_pixel_detec_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_pixel_detec_test_pattern (f_pixel_detec, -1)
call set_pixel_detec_test_pattern (f2_pixel_detec, -1)

end subroutine test1_f_pixel_detec

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_pixel_detec (c_pixel_detec, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_pixel_detec
type(pixel_detec_struct), target :: f_pixel_detec, f2_pixel_detec
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call pixel_detec_to_f (c_pixel_detec, c_loc(f_pixel_detec))

call set_pixel_detec_test_pattern (f2_pixel_detec, 2)
if (f_pixel_detec == f2_pixel_detec) then
  print *, '[2] pixel_detec: F side convert C->F: Good'
else
  print *, '[2] pixel_detec: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call pixel_detec_struct_to_json(f_pixel_detec, json_root)
  call json%print(json_root, 'test_f_pixel_detec_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call pixel_detec_struct_to_json(f2_pixel_detec, json_root)
  call json%print(json_root, 'test_f_pixel_detec_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_pixel_detec_pattern_2_*.json)'

endif

call set_pixel_detec_test_pattern (f2_pixel_detec, 3)
call pixel_detec_to_c (c_loc(f2_pixel_detec), c_pixel_detec)

! clean up test pattern data - < 3 deallocates arrays and such
call set_pixel_detec_test_pattern (f_pixel_detec, -1)
call set_pixel_detec_test_pattern (f2_pixel_detec, -1)

end subroutine test2_f_pixel_detec

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_pixel_detec_test_pattern (F, ix_patt)

implicit none

type(pixel_detec_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%dr,1); lb1 = lbound(F%dr,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%dr(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_integer8] Int8
rhs = 3 + offset; F%n_track_tot = rhs
!! f_side.test_pat[0D_NOT_integer8] Int8
rhs = 4 + offset; F%n_hit_detec = rhs
!! f_side.test_pat[0D_NOT_integer8] Int8
rhs = 5 + offset; F%n_hit_pixel = rhs
!! f_side.test_pat[2D_ALLOC_type] VariableArray2D<CPP_pixel_pt>
if (ix_patt < 3) then
  if (allocated(F%pt)) deallocate (F%pt)
else
  if (.not. allocated(F%pt)) allocate (F%pt(-1:1, 2))
  do jd1 = 1, size(F%pt,1); lb1 = lbound(F%pt,1) - 1
    do jd2 = 1, size(F%pt,2); lb2 = lbound(F%pt,2) - 1
      call set_pixel_pt_test_pattern (F%pt(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)
    enddo
  enddo
endif

end subroutine set_pixel_detec_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_photon_element (ok)

implicit none

type(photon_element_struct), target :: f_photon_element, f2_photon_element

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_photon_element (c_photon_element, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_photon_element
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_photon_element_test_pattern (f2_photon_element, 1)

call test_c_photon_element(c_loc(f2_photon_element), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_photon_element_test_pattern (f_photon_element, 4)
if (f_photon_element == f2_photon_element) then
  print *, '[4] photon_element: C side convert C->F: Good'
else
  print *, '[4] photon_element: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call photon_element_struct_to_json(f_photon_element, json_root)
  call json%print(json_root, 'test_f_photon_element_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_element_struct_to_json(f2_photon_element, json_root)
  call json%print(json_root, 'test_f_photon_element_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_element_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_element_test_pattern (f_photon_element, -1)
call set_photon_element_test_pattern (f2_photon_element, -1)

end subroutine test1_f_photon_element

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_photon_element (c_photon_element, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_photon_element
type(photon_element_struct), target :: f_photon_element, f2_photon_element
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call photon_element_to_f (c_photon_element, c_loc(f_photon_element))

call set_photon_element_test_pattern (f2_photon_element, 2)
if (f_photon_element == f2_photon_element) then
  print *, '[2] photon_element: F side convert C->F: Good'
else
  print *, '[2] photon_element: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call photon_element_struct_to_json(f_photon_element, json_root)
  call json%print(json_root, 'test_f_photon_element_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call photon_element_struct_to_json(f2_photon_element, json_root)
  call json%print(json_root, 'test_f_photon_element_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_photon_element_pattern_2_*.json)'

endif

call set_photon_element_test_pattern (f2_photon_element, 3)
call photon_element_to_c (c_loc(f2_photon_element), c_photon_element)

! clean up test pattern data - < 3 deallocates arrays and such
call set_photon_element_test_pattern (f_photon_element, -1)
call set_photon_element_test_pattern (f2_photon_element, -1)

end subroutine test2_f_photon_element

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_photon_element_test_pattern (F, ix_patt)

implicit none

type(photon_element_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_type] CPP_surface_curvature
call set_surface_curvature_test_pattern (F%curvature, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_photon_target
call set_photon_target_test_pattern (F%target, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_photon_material
call set_photon_material_test_pattern (F%material, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_surface_segmented
call set_surface_segmented_test_pattern (F%segmented, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_surface_h_misalign
call set_surface_h_misalign_test_pattern (F%h_misalign, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_surface_displacement
call set_surface_displacement_test_pattern (F%displacement, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_pixel_detec
call set_pixel_detec_test_pattern (F%pixel, ix_patt)
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%reflectivity_table_type = rhs
!! f_side.test_pat[0D_NOT_type] CPP_photon_reflect_table
call set_photon_reflect_table_test_pattern (F%reflectivity_table_sigma, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_photon_reflect_table
call set_photon_reflect_table_test_pattern (F%reflectivity_table_pi, ix_patt)
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_spline>
if (ix_patt < 3) then
  if (allocated(F%init_energy_prob)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%init_energy_prob,1), ubound(F%init_energy_prob,1)
      call set_spline_test_pattern (F%init_energy_prob(jd1), -1)
    enddo
    deallocate (F%init_energy_prob)
  endif
else
  if (.not. allocated(F%init_energy_prob)) then
    allocate (F%init_energy_prob(-1:1))
  endif
  do jd1 = 1, size(F%init_energy_prob,1)
    lb1 = lbound(F%init_energy_prob,1) - 1
    call set_spline_test_pattern (F%init_energy_prob(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%integrated_init_energy_prob)) then
     deallocate (F%integrated_init_energy_prob)
  endif
else
  if (.not. allocated(F%integrated_init_energy_prob)) then
    allocate (F%integrated_init_energy_prob(-1:1))
  endif
  do jd1 = 1, size(F%integrated_init_energy_prob,1)
    lb1 = lbound(F%integrated_init_energy_prob,1) - 1
    rhs = 100 + jd1 + 13 + offset
    F%integrated_init_energy_prob(jd1+lb1) = rhs
  enddo
endif

end subroutine set_photon_element_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wall3d_vertex (ok)

implicit none

type(wall3d_vertex_struct), target :: f_wall3d_vertex, f2_wall3d_vertex

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wall3d_vertex (c_wall3d_vertex, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wall3d_vertex
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wall3d_vertex_test_pattern (f2_wall3d_vertex, 1)

call test_c_wall3d_vertex(c_loc(f2_wall3d_vertex), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wall3d_vertex_test_pattern (f_wall3d_vertex, 4)
if (f_wall3d_vertex == f2_wall3d_vertex) then
  print *, '[4] wall3d_vertex: C side convert C->F: Good'
else
  print *, '[4] wall3d_vertex: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wall3d_vertex_struct_to_json(f_wall3d_vertex, json_root)
  call json%print(json_root, 'test_f_wall3d_vertex_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wall3d_vertex_struct_to_json(f2_wall3d_vertex, json_root)
  call json%print(json_root, 'test_f_wall3d_vertex_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wall3d_vertex_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wall3d_vertex_test_pattern (f_wall3d_vertex, -1)
call set_wall3d_vertex_test_pattern (f2_wall3d_vertex, -1)

end subroutine test1_f_wall3d_vertex

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wall3d_vertex (c_wall3d_vertex, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wall3d_vertex
type(wall3d_vertex_struct), target :: f_wall3d_vertex, f2_wall3d_vertex
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wall3d_vertex_to_f (c_wall3d_vertex, c_loc(f_wall3d_vertex))

call set_wall3d_vertex_test_pattern (f2_wall3d_vertex, 2)
if (f_wall3d_vertex == f2_wall3d_vertex) then
  print *, '[2] wall3d_vertex: F side convert C->F: Good'
else
  print *, '[2] wall3d_vertex: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wall3d_vertex_struct_to_json(f_wall3d_vertex, json_root)
  call json%print(json_root, 'test_f_wall3d_vertex_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wall3d_vertex_struct_to_json(f2_wall3d_vertex, json_root)
  call json%print(json_root, 'test_f_wall3d_vertex_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wall3d_vertex_pattern_2_*.json)'

endif

call set_wall3d_vertex_test_pattern (f2_wall3d_vertex, 3)
call wall3d_vertex_to_c (c_loc(f2_wall3d_vertex), c_wall3d_vertex)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wall3d_vertex_test_pattern (f_wall3d_vertex, -1)
call set_wall3d_vertex_test_pattern (f2_wall3d_vertex, -1)

end subroutine test2_f_wall3d_vertex

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wall3d_vertex_test_pattern (F, ix_patt)

implicit none

type(wall3d_vertex_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%x = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%y = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%radius_x = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%radius_y = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%tilt = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%angle = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%x0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%y0 = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%type = rhs

end subroutine set_wall3d_vertex_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wall3d_section (ok)

implicit none

type(wall3d_section_struct), target :: f_wall3d_section, f2_wall3d_section

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wall3d_section (c_wall3d_section, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wall3d_section
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wall3d_section_test_pattern (f2_wall3d_section, 1)

call test_c_wall3d_section(c_loc(f2_wall3d_section), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wall3d_section_test_pattern (f_wall3d_section, 4)
if (f_wall3d_section == f2_wall3d_section) then
  print *, '[4] wall3d_section: C side convert C->F: Good'
else
  print *, '[4] wall3d_section: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wall3d_section_struct_to_json(f_wall3d_section, json_root)
  call json%print(json_root, 'test_f_wall3d_section_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wall3d_section_struct_to_json(f2_wall3d_section, json_root)
  call json%print(json_root, 'test_f_wall3d_section_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wall3d_section_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wall3d_section_test_pattern (f_wall3d_section, -1)
call set_wall3d_section_test_pattern (f2_wall3d_section, -1)

end subroutine test1_f_wall3d_section

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wall3d_section (c_wall3d_section, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wall3d_section
type(wall3d_section_struct), target :: f_wall3d_section, f2_wall3d_section
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wall3d_section_to_f (c_wall3d_section, c_loc(f_wall3d_section))

call set_wall3d_section_test_pattern (f2_wall3d_section, 2)
if (f_wall3d_section == f2_wall3d_section) then
  print *, '[2] wall3d_section: F side convert C->F: Good'
else
  print *, '[2] wall3d_section: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wall3d_section_struct_to_json(f_wall3d_section, json_root)
  call json%print(json_root, 'test_f_wall3d_section_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wall3d_section_struct_to_json(f2_wall3d_section, json_root)
  call json%print(json_root, 'test_f_wall3d_section_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wall3d_section_pattern_2_*.json)'

endif

call set_wall3d_section_test_pattern (f2_wall3d_section, 3)
call wall3d_section_to_c (c_loc(f2_wall3d_section), c_wall3d_section)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wall3d_section_test_pattern (f_wall3d_section, -1)
call set_wall3d_section_test_pattern (f2_wall3d_section, -1)

end subroutine test2_f_wall3d_section

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wall3d_section_test_pattern (F, ix_patt)

implicit none

type(wall3d_section_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%material)
  F%material(jd1:jd1) = char(ichar("a") + modulo(100+2+offset+jd1, 26))
enddo
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_wall3d_vertex>
if (ix_patt < 3) then
  if (allocated(F%v)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%v,1), ubound(F%v,1)
      call set_wall3d_vertex_test_pattern (F%v(jd1), -1)
    enddo
    deallocate (F%v)
  endif
else
  if (.not. allocated(F%v)) then
    allocate (F%v(-1:1))
  endif
  do jd1 = 1, size(F%v,1)
    lb1 = lbound(F%v,1) - 1
    call set_wall3d_vertex_test_pattern (F%v(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_photon_reflect_surface>
if (ix_patt < 3) then
  if (associated(F%surface)) then
    call set_photon_reflect_surface_test_pattern (F%surface, -1)
    deallocate (F%surface)
  endif
else
  if (.not. associated(F%surface)) allocate (F%surface)
  rhs = 5 + offset
  call set_photon_reflect_surface_test_pattern (F%surface, ix_patt)
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%n_vertex_input = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 10 + offset; F%ix_branch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 11 + offset; F%vertices_state = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 12 + offset; F%patch_in_region = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_real] Real
rhs = 13 + offset; F%thickness = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 14 + offset; F%s = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%r0,1); lb1 = lbound(F%r0,1) - 1
  rhs = 100 + jd1 + 15 + offset
  F%r0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 16 + offset; F%dx0_ds = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 17 + offset; F%dy0_ds = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 4>
do jd1 = 1, size(F%x0_coef,1); lb1 = lbound(F%x0_coef,1) - 1
  rhs = 100 + jd1 + 18 + offset
  F%x0_coef(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 4>
do jd1 = 1, size(F%y0_coef,1); lb1 = lbound(F%y0_coef,1) - 1
  rhs = 100 + jd1 + 19 + offset
  F%y0_coef(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 20 + offset; F%dr_ds = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%p1_coef,1); lb1 = lbound(F%p1_coef,1) - 1
  rhs = 100 + jd1 + 21 + offset
  F%p1_coef(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%p2_coef,1); lb1 = lbound(F%p2_coef,1) - 1
  rhs = 100 + jd1 + 22 + offset
  F%p2_coef(jd1+lb1) = rhs
enddo

end subroutine set_wall3d_section_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_wall3d (ok)

implicit none

type(wall3d_struct), target :: f_wall3d, f2_wall3d

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_wall3d (c_wall3d, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_wall3d
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_wall3d_test_pattern (f2_wall3d, 1)

call test_c_wall3d(c_loc(f2_wall3d), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_wall3d_test_pattern (f_wall3d, 4)
if (f_wall3d == f2_wall3d) then
  print *, '[4] wall3d: C side convert C->F: Good'
else
  print *, '[4] wall3d: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call wall3d_struct_to_json(f_wall3d, json_root)
  call json%print(json_root, 'test_f_wall3d_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wall3d_struct_to_json(f2_wall3d, json_root)
  call json%print(json_root, 'test_f_wall3d_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wall3d_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_wall3d_test_pattern (f_wall3d, -1)
call set_wall3d_test_pattern (f2_wall3d, -1)

end subroutine test1_f_wall3d

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_wall3d (c_wall3d, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_wall3d
type(wall3d_struct), target :: f_wall3d, f2_wall3d
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call wall3d_to_f (c_wall3d, c_loc(f_wall3d))

call set_wall3d_test_pattern (f2_wall3d, 2)
if (f_wall3d == f2_wall3d) then
  print *, '[2] wall3d: F side convert C->F: Good'
else
  print *, '[2] wall3d: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call wall3d_struct_to_json(f_wall3d, json_root)
  call json%print(json_root, 'test_f_wall3d_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call wall3d_struct_to_json(f2_wall3d, json_root)
  call json%print(json_root, 'test_f_wall3d_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_wall3d_pattern_2_*.json)'

endif

call set_wall3d_test_pattern (f2_wall3d, 3)
call wall3d_to_c (c_loc(f2_wall3d), c_wall3d)

! clean up test pattern data - < 3 deallocates arrays and such
call set_wall3d_test_pattern (f_wall3d, -1)
call set_wall3d_test_pattern (f2_wall3d, -1)

end subroutine test2_f_wall3d

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wall3d_test_pattern (F, ix_patt)

implicit none

type(wall3d_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%ix_wall3d = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%n_link = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%thickness = rhs
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%clear_material)
  F%clear_material(jd1:jd1) = char(ichar("a") + modulo(100+6+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%opaque_material)
  F%opaque_material(jd1:jd1) = char(ichar("a") + modulo(100+7+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 8 + offset; F%superimpose = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%ele_anchor_pt = rhs
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_wall3d_section>
if (ix_patt < 3) then
  if (allocated(F%section)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%section,1), ubound(F%section,1)
      call set_wall3d_section_test_pattern (F%section(jd1), -1)
    enddo
    deallocate (F%section)
  endif
else
  if (.not. allocated(F%section)) then
    allocate (F%section(-1:1))
  endif
  do jd1 = 1, size(F%section,1)
    lb1 = lbound(F%section,1) - 1
    call set_wall3d_section_test_pattern (F%section(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_wall3d_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_ramper_lord (ok)

implicit none

type(ramper_lord_struct), target :: f_ramper_lord, f2_ramper_lord

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_ramper_lord (c_ramper_lord, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_ramper_lord
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_ramper_lord_test_pattern (f2_ramper_lord, 1)

call test_c_ramper_lord(c_loc(f2_ramper_lord), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_ramper_lord_test_pattern (f_ramper_lord, 4)
if (f_ramper_lord == f2_ramper_lord) then
  print *, '[4] ramper_lord: C side convert C->F: Good'
else
  print *, '[4] ramper_lord: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call ramper_lord_struct_to_json(f_ramper_lord, json_root)
  call json%print(json_root, 'test_f_ramper_lord_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ramper_lord_struct_to_json(f2_ramper_lord, json_root)
  call json%print(json_root, 'test_f_ramper_lord_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ramper_lord_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_ramper_lord_test_pattern (f_ramper_lord, -1)
call set_ramper_lord_test_pattern (f2_ramper_lord, -1)

end subroutine test1_f_ramper_lord

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_ramper_lord (c_ramper_lord, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_ramper_lord
type(ramper_lord_struct), target :: f_ramper_lord, f2_ramper_lord
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call ramper_lord_to_f (c_ramper_lord, c_loc(f_ramper_lord))

call set_ramper_lord_test_pattern (f2_ramper_lord, 2)
if (f_ramper_lord == f2_ramper_lord) then
  print *, '[2] ramper_lord: F side convert C->F: Good'
else
  print *, '[2] ramper_lord: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call ramper_lord_struct_to_json(f_ramper_lord, json_root)
  call json%print(json_root, 'test_f_ramper_lord_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ramper_lord_struct_to_json(f2_ramper_lord, json_root)
  call json%print(json_root, 'test_f_ramper_lord_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ramper_lord_pattern_2_*.json)'

endif

call set_ramper_lord_test_pattern (f2_ramper_lord, 3)
call ramper_lord_to_c (c_loc(f2_ramper_lord), c_ramper_lord)

! clean up test pattern data - < 3 deallocates arrays and such
call set_ramper_lord_test_pattern (f_ramper_lord, -1)
call set_ramper_lord_test_pattern (f2_ramper_lord, -1)

end subroutine test2_f_ramper_lord

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_ramper_lord_test_pattern (F, ix_patt)

implicit none

type(ramper_lord_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%ix_con = rhs
!! f_side.test_pat[0D_PTR_real] std::optional<Real>
if (ix_patt < 3) then
  if (associated(F%attrib_ptr)) deallocate (F%attrib_ptr)
else
  if (.not. associated(F%attrib_ptr)) allocate (F%attrib_ptr)
  rhs = 3 + offset
  F%attrib_ptr = rhs
endif

end subroutine set_ramper_lord_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_control (ok)

implicit none

type(control_struct), target :: f_control, f2_control

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_control (c_control, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_control
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_control_test_pattern (f2_control, 1)

call test_c_control(c_loc(f2_control), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_control_test_pattern (f_control, 4)
if (f_control == f2_control) then
  print *, '[4] control: C side convert C->F: Good'
else
  print *, '[4] control: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call control_struct_to_json(f_control, json_root)
  call json%print(json_root, 'test_f_control_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call control_struct_to_json(f2_control, json_root)
  call json%print(json_root, 'test_f_control_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_control_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_control_test_pattern (f_control, -1)
call set_control_test_pattern (f2_control, -1)

end subroutine test1_f_control

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_control (c_control, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_control
type(control_struct), target :: f_control, f2_control
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call control_to_f (c_control, c_loc(f_control))

call set_control_test_pattern (f2_control, 2)
if (f_control == f2_control) then
  print *, '[2] control: F side convert C->F: Good'
else
  print *, '[2] control: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call control_struct_to_json(f_control, json_root)
  call json%print(json_root, 'test_f_control_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call control_struct_to_json(f2_control, json_root)
  call json%print(json_root, 'test_f_control_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_control_pattern_2_*.json)'

endif

call set_control_test_pattern (f2_control, 3)
call control_to_c (c_loc(f2_control), c_control)

! clean up test pattern data - < 3 deallocates arrays and such
call set_control_test_pattern (f_control, -1)
call set_control_test_pattern (f2_control, -1)

end subroutine test2_f_control

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_control_test_pattern (F, ix_patt)

implicit none

type(control_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%value = rhs
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%y_knot)) then
     deallocate (F%y_knot)
  endif
else
  if (.not. allocated(F%y_knot)) then
    allocate (F%y_knot(-1:1))
  endif
  do jd1 = 1, size(F%y_knot,1)
    lb1 = lbound(F%y_knot,1) - 1
    rhs = 100 + jd1 + 2 + offset
    F%y_knot(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_expression_atom>
if (ix_patt < 3) then
  if (allocated(F%stack)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%stack,1), ubound(F%stack,1)
      call set_expression_atom_test_pattern (F%stack(jd1), -1)
    enddo
    deallocate (F%stack)
  endif
else
  if (.not. allocated(F%stack)) then
    allocate (F%stack(-1:1))
  endif
  do jd1 = 1, size(F%stack,1)
    lb1 = lbound(F%stack,1) - 1
    call set_expression_atom_test_pattern (F%stack(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_lat_ele_loc
call set_lat_ele_loc_test_pattern (F%slave, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_lat_ele_loc
call set_lat_ele_loc_test_pattern (F%lord, ix_patt)
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%slave_name)
  F%slave_name(jd1:jd1) = char(ichar("a") + modulo(100+8+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%attribute)
  F%attribute(jd1:jd1) = char(ichar("a") + modulo(100+9+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 10 + offset; F%ix_attrib = rhs

end subroutine set_control_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_control_var1 (ok)

implicit none

type(control_var1_struct), target :: f_control_var1, f2_control_var1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_control_var1 (c_control_var1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_control_var1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_control_var1_test_pattern (f2_control_var1, 1)

call test_c_control_var1(c_loc(f2_control_var1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_control_var1_test_pattern (f_control_var1, 4)
if (f_control_var1 == f2_control_var1) then
  print *, '[4] control_var1: C side convert C->F: Good'
else
  print *, '[4] control_var1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call control_var1_struct_to_json(f_control_var1, json_root)
  call json%print(json_root, 'test_f_control_var1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call control_var1_struct_to_json(f2_control_var1, json_root)
  call json%print(json_root, 'test_f_control_var1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_control_var1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_control_var1_test_pattern (f_control_var1, -1)
call set_control_var1_test_pattern (f2_control_var1, -1)

end subroutine test1_f_control_var1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_control_var1 (c_control_var1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_control_var1
type(control_var1_struct), target :: f_control_var1, f2_control_var1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call control_var1_to_f (c_control_var1, c_loc(f_control_var1))

call set_control_var1_test_pattern (f2_control_var1, 2)
if (f_control_var1 == f2_control_var1) then
  print *, '[2] control_var1: F side convert C->F: Good'
else
  print *, '[2] control_var1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call control_var1_struct_to_json(f_control_var1, json_root)
  call json%print(json_root, 'test_f_control_var1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call control_var1_struct_to_json(f2_control_var1, json_root)
  call json%print(json_root, 'test_f_control_var1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_control_var1_pattern_2_*.json)'

endif

call set_control_var1_test_pattern (f2_control_var1, 3)
call control_var1_to_c (c_loc(f2_control_var1), c_control_var1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_control_var1_test_pattern (f_control_var1, -1)
call set_control_var1_test_pattern (f2_control_var1, -1)

end subroutine test2_f_control_var1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_control_var1_test_pattern (F, ix_patt)

implicit none

type(control_var1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%value = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%old_value = rhs

end subroutine set_control_var1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_control_ramp1 (ok)

implicit none

type(control_ramp1_struct), target :: f_control_ramp1, f2_control_ramp1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_control_ramp1 (c_control_ramp1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_control_ramp1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_control_ramp1_test_pattern (f2_control_ramp1, 1)

call test_c_control_ramp1(c_loc(f2_control_ramp1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_control_ramp1_test_pattern (f_control_ramp1, 4)
if (f_control_ramp1 == f2_control_ramp1) then
  print *, '[4] control_ramp1: C side convert C->F: Good'
else
  print *, '[4] control_ramp1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call control_ramp1_struct_to_json(f_control_ramp1, json_root)
  call json%print(json_root, 'test_f_control_ramp1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call control_ramp1_struct_to_json(f2_control_ramp1, json_root)
  call json%print(json_root, 'test_f_control_ramp1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_control_ramp1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_control_ramp1_test_pattern (f_control_ramp1, -1)
call set_control_ramp1_test_pattern (f2_control_ramp1, -1)

end subroutine test1_f_control_ramp1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_control_ramp1 (c_control_ramp1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_control_ramp1
type(control_ramp1_struct), target :: f_control_ramp1, f2_control_ramp1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call control_ramp1_to_f (c_control_ramp1, c_loc(f_control_ramp1))

call set_control_ramp1_test_pattern (f2_control_ramp1, 2)
if (f_control_ramp1 == f2_control_ramp1) then
  print *, '[2] control_ramp1: F side convert C->F: Good'
else
  print *, '[2] control_ramp1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call control_ramp1_struct_to_json(f_control_ramp1, json_root)
  call json%print(json_root, 'test_f_control_ramp1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call control_ramp1_struct_to_json(f2_control_ramp1, json_root)
  call json%print(json_root, 'test_f_control_ramp1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_control_ramp1_pattern_2_*.json)'

endif

call set_control_ramp1_test_pattern (f2_control_ramp1, 3)
call control_ramp1_to_c (c_loc(f2_control_ramp1), c_control_ramp1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_control_ramp1_test_pattern (f_control_ramp1, -1)
call set_control_ramp1_test_pattern (f2_control_ramp1, -1)

end subroutine test2_f_control_ramp1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_control_ramp1_test_pattern (F, ix_patt)

implicit none

type(control_ramp1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%y_knot)) then
     deallocate (F%y_knot)
  endif
else
  if (.not. allocated(F%y_knot)) then
    allocate (F%y_knot(-1:1))
  endif
  do jd1 = 1, size(F%y_knot,1)
    lb1 = lbound(F%y_knot,1) - 1
    rhs = 100 + jd1 + 1 + offset
    F%y_knot(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_expression_atom>
if (ix_patt < 3) then
  if (allocated(F%stack)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%stack,1), ubound(F%stack,1)
      call set_expression_atom_test_pattern (F%stack(jd1), -1)
    enddo
    deallocate (F%stack)
  endif
else
  if (.not. allocated(F%stack)) then
    allocate (F%stack(-1:1))
  endif
  do jd1 = 1, size(F%stack,1)
    lb1 = lbound(F%stack,1) - 1
    call set_expression_atom_test_pattern (F%stack(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%attribute)
  F%attribute(jd1:jd1) = char(ichar("a") + modulo(100+5+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%slave_name)
  F%slave_name(jd1:jd1) = char(ichar("a") + modulo(100+6+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 7 + offset; F%is_controller = (modulo(rhs, 2) == 0)

end subroutine set_control_ramp1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_controller (ok)

implicit none

type(controller_struct), target :: f_controller, f2_controller

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_controller (c_controller, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_controller
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_controller_test_pattern (f2_controller, 1)

call test_c_controller(c_loc(f2_controller), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_controller_test_pattern (f_controller, 4)
if (f_controller == f2_controller) then
  print *, '[4] controller: C side convert C->F: Good'
else
  print *, '[4] controller: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call controller_struct_to_json(f_controller, json_root)
  call json%print(json_root, 'test_f_controller_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call controller_struct_to_json(f2_controller, json_root)
  call json%print(json_root, 'test_f_controller_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_controller_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_controller_test_pattern (f_controller, -1)
call set_controller_test_pattern (f2_controller, -1)

end subroutine test1_f_controller

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_controller (c_controller, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_controller
type(controller_struct), target :: f_controller, f2_controller
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call controller_to_f (c_controller, c_loc(f_controller))

call set_controller_test_pattern (f2_controller, 2)
if (f_controller == f2_controller) then
  print *, '[2] controller: F side convert C->F: Good'
else
  print *, '[2] controller: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call controller_struct_to_json(f_controller, json_root)
  call json%print(json_root, 'test_f_controller_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call controller_struct_to_json(f2_controller, json_root)
  call json%print(json_root, 'test_f_controller_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_controller_pattern_2_*.json)'

endif

call set_controller_test_pattern (f2_controller, 3)
call controller_to_c (c_loc(f2_controller), c_controller)

! clean up test pattern data - < 3 deallocates arrays and such
call set_controller_test_pattern (f_controller, -1)
call set_controller_test_pattern (f2_controller, -1)

end subroutine test2_f_controller

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_controller_test_pattern (F, ix_patt)

implicit none

type(controller_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_control_var1>
if (ix_patt < 3) then
  if (allocated(F%var)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%var,1), ubound(F%var,1)
      call set_control_var1_test_pattern (F%var(jd1), -1)
    enddo
    deallocate (F%var)
  endif
else
  if (.not. allocated(F%var)) then
    allocate (F%var(-1:1))
  endif
  do jd1 = 1, size(F%var,1)
    lb1 = lbound(F%var,1) - 1
    call set_control_var1_test_pattern (F%var(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_control_ramp1>
if (ix_patt < 3) then
  if (allocated(F%ramp)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%ramp,1), ubound(F%ramp,1)
      call set_control_ramp1_test_pattern (F%ramp(jd1), -1)
    enddo
    deallocate (F%ramp)
  endif
else
  if (.not. allocated(F%ramp)) then
    allocate (F%ramp(-1:1))
  endif
  do jd1 = 1, size(F%ramp,1)
    lb1 = lbound(F%ramp,1) - 1
    call set_control_ramp1_test_pattern (F%ramp(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_ramper_lord>
if (ix_patt < 3) then
  if (allocated(F%ramper_lord)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%ramper_lord,1), ubound(F%ramper_lord,1)
      call set_ramper_lord_test_pattern (F%ramper_lord(jd1), -1)
    enddo
    deallocate (F%ramper_lord)
  endif
else
  if (.not. allocated(F%ramper_lord)) then
    allocate (F%ramper_lord(-1:1))
  endif
  do jd1 = 1, size(F%ramper_lord,1)
    lb1 = lbound(F%ramper_lord,1) - 1
    call set_ramper_lord_test_pattern (F%ramper_lord(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%x_knot)) then
     deallocate (F%x_knot)
  endif
else
  if (.not. allocated(F%x_knot)) then
    allocate (F%x_knot(-1:1))
  endif
  do jd1 = 1, size(F%x_knot,1)
    lb1 = lbound(F%x_knot,1) - 1
    rhs = 100 + jd1 + 7 + offset
    F%x_knot(jd1+lb1) = rhs
  enddo
endif

end subroutine set_controller_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_ellipse_beam_init (ok)

implicit none

type(ellipse_beam_init_struct), target :: f_ellipse_beam_init, f2_ellipse_beam_init

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_ellipse_beam_init (c_ellipse_beam_init, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_ellipse_beam_init
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_ellipse_beam_init_test_pattern (f2_ellipse_beam_init, 1)

call test_c_ellipse_beam_init(c_loc(f2_ellipse_beam_init), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_ellipse_beam_init_test_pattern (f_ellipse_beam_init, 4)
if (f_ellipse_beam_init == f2_ellipse_beam_init) then
  print *, '[4] ellipse_beam_init: C side convert C->F: Good'
else
  print *, '[4] ellipse_beam_init: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call ellipse_beam_init_struct_to_json(f_ellipse_beam_init, json_root)
  call json%print(json_root, 'test_f_ellipse_beam_init_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ellipse_beam_init_struct_to_json(f2_ellipse_beam_init, json_root)
  call json%print(json_root, 'test_f_ellipse_beam_init_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ellipse_beam_init_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_ellipse_beam_init_test_pattern (f_ellipse_beam_init, -1)
call set_ellipse_beam_init_test_pattern (f2_ellipse_beam_init, -1)

end subroutine test1_f_ellipse_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_ellipse_beam_init (c_ellipse_beam_init, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_ellipse_beam_init
type(ellipse_beam_init_struct), target :: f_ellipse_beam_init, f2_ellipse_beam_init
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call ellipse_beam_init_to_f (c_ellipse_beam_init, c_loc(f_ellipse_beam_init))

call set_ellipse_beam_init_test_pattern (f2_ellipse_beam_init, 2)
if (f_ellipse_beam_init == f2_ellipse_beam_init) then
  print *, '[2] ellipse_beam_init: F side convert C->F: Good'
else
  print *, '[2] ellipse_beam_init: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call ellipse_beam_init_struct_to_json(f_ellipse_beam_init, json_root)
  call json%print(json_root, 'test_f_ellipse_beam_init_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ellipse_beam_init_struct_to_json(f2_ellipse_beam_init, json_root)
  call json%print(json_root, 'test_f_ellipse_beam_init_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ellipse_beam_init_pattern_2_*.json)'

endif

call set_ellipse_beam_init_test_pattern (f2_ellipse_beam_init, 3)
call ellipse_beam_init_to_c (c_loc(f2_ellipse_beam_init), c_ellipse_beam_init)

! clean up test pattern data - < 3 deallocates arrays and such
call set_ellipse_beam_init_test_pattern (f_ellipse_beam_init, -1)
call set_ellipse_beam_init_test_pattern (f2_ellipse_beam_init, -1)

end subroutine test2_f_ellipse_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_ellipse_beam_init_test_pattern (F, ix_patt)

implicit none

type(ellipse_beam_init_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%part_per_ellipse = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_ellipse = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%sigma_cutoff = rhs

end subroutine set_ellipse_beam_init_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_kv_beam_init (ok)

implicit none

type(kv_beam_init_struct), target :: f_kv_beam_init, f2_kv_beam_init

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_kv_beam_init (c_kv_beam_init, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_kv_beam_init
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_kv_beam_init_test_pattern (f2_kv_beam_init, 1)

call test_c_kv_beam_init(c_loc(f2_kv_beam_init), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_kv_beam_init_test_pattern (f_kv_beam_init, 4)
if (f_kv_beam_init == f2_kv_beam_init) then
  print *, '[4] kv_beam_init: C side convert C->F: Good'
else
  print *, '[4] kv_beam_init: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call kv_beam_init_struct_to_json(f_kv_beam_init, json_root)
  call json%print(json_root, 'test_f_kv_beam_init_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call kv_beam_init_struct_to_json(f2_kv_beam_init, json_root)
  call json%print(json_root, 'test_f_kv_beam_init_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_kv_beam_init_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_kv_beam_init_test_pattern (f_kv_beam_init, -1)
call set_kv_beam_init_test_pattern (f2_kv_beam_init, -1)

end subroutine test1_f_kv_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_kv_beam_init (c_kv_beam_init, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_kv_beam_init
type(kv_beam_init_struct), target :: f_kv_beam_init, f2_kv_beam_init
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call kv_beam_init_to_f (c_kv_beam_init, c_loc(f_kv_beam_init))

call set_kv_beam_init_test_pattern (f2_kv_beam_init, 2)
if (f_kv_beam_init == f2_kv_beam_init) then
  print *, '[2] kv_beam_init: F side convert C->F: Good'
else
  print *, '[2] kv_beam_init: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call kv_beam_init_struct_to_json(f_kv_beam_init, json_root)
  call json%print(json_root, 'test_f_kv_beam_init_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call kv_beam_init_struct_to_json(f2_kv_beam_init, json_root)
  call json%print(json_root, 'test_f_kv_beam_init_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_kv_beam_init_pattern_2_*.json)'

endif

call set_kv_beam_init_test_pattern (f2_kv_beam_init, 3)
call kv_beam_init_to_c (c_loc(f2_kv_beam_init), c_kv_beam_init)

! clean up test pattern data - < 3 deallocates arrays and such
call set_kv_beam_init_test_pattern (f_kv_beam_init, -1)
call set_kv_beam_init_test_pattern (f2_kv_beam_init, -1)

end subroutine test2_f_kv_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_kv_beam_init_test_pattern (F, ix_patt)

implicit none

type(kv_beam_init_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 2>
do jd1 = 1, size(F%part_per_phi,1); lb1 = lbound(F%part_per_phi,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%part_per_phi(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_I2 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%A = rhs

end subroutine set_kv_beam_init_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_grid_beam_init (ok)

implicit none

type(grid_beam_init_struct), target :: f_grid_beam_init, f2_grid_beam_init

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_grid_beam_init (c_grid_beam_init, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_grid_beam_init
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_grid_beam_init_test_pattern (f2_grid_beam_init, 1)

call test_c_grid_beam_init(c_loc(f2_grid_beam_init), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_grid_beam_init_test_pattern (f_grid_beam_init, 4)
if (f_grid_beam_init == f2_grid_beam_init) then
  print *, '[4] grid_beam_init: C side convert C->F: Good'
else
  print *, '[4] grid_beam_init: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call grid_beam_init_struct_to_json(f_grid_beam_init, json_root)
  call json%print(json_root, 'test_f_grid_beam_init_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_beam_init_struct_to_json(f2_grid_beam_init, json_root)
  call json%print(json_root, 'test_f_grid_beam_init_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_beam_init_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_beam_init_test_pattern (f_grid_beam_init, -1)
call set_grid_beam_init_test_pattern (f2_grid_beam_init, -1)

end subroutine test1_f_grid_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_grid_beam_init (c_grid_beam_init, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_grid_beam_init
type(grid_beam_init_struct), target :: f_grid_beam_init, f2_grid_beam_init
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call grid_beam_init_to_f (c_grid_beam_init, c_loc(f_grid_beam_init))

call set_grid_beam_init_test_pattern (f2_grid_beam_init, 2)
if (f_grid_beam_init == f2_grid_beam_init) then
  print *, '[2] grid_beam_init: F side convert C->F: Good'
else
  print *, '[2] grid_beam_init: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call grid_beam_init_struct_to_json(f_grid_beam_init, json_root)
  call json%print(json_root, 'test_f_grid_beam_init_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call grid_beam_init_struct_to_json(f2_grid_beam_init, json_root)
  call json%print(json_root, 'test_f_grid_beam_init_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_grid_beam_init_pattern_2_*.json)'

endif

call set_grid_beam_init_test_pattern (f2_grid_beam_init, 3)
call grid_beam_init_to_c (c_loc(f2_grid_beam_init), c_grid_beam_init)

! clean up test pattern data - < 3 deallocates arrays and such
call set_grid_beam_init_test_pattern (f_grid_beam_init, -1)
call set_grid_beam_init_test_pattern (f2_grid_beam_init, -1)

end subroutine test2_f_grid_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_grid_beam_init_test_pattern (F, ix_patt)

implicit none

type(grid_beam_init_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%n_x = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%n_px = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%x_min = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%x_max = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%px_min = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%px_max = rhs

end subroutine set_grid_beam_init_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_beam_init (ok)

implicit none

type(beam_init_struct), target :: f_beam_init, f2_beam_init

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_beam_init (c_beam_init, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_beam_init
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_beam_init_test_pattern (f2_beam_init, 1)

call test_c_beam_init(c_loc(f2_beam_init), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_beam_init_test_pattern (f_beam_init, 4)
if (f_beam_init == f2_beam_init) then
  print *, '[4] beam_init: C side convert C->F: Good'
else
  print *, '[4] beam_init: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call beam_init_struct_to_json(f_beam_init, json_root)
  call json%print(json_root, 'test_f_beam_init_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call beam_init_struct_to_json(f2_beam_init, json_root)
  call json%print(json_root, 'test_f_beam_init_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_beam_init_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_beam_init_test_pattern (f_beam_init, -1)
call set_beam_init_test_pattern (f2_beam_init, -1)

end subroutine test1_f_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_beam_init (c_beam_init, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_beam_init
type(beam_init_struct), target :: f_beam_init, f2_beam_init
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call beam_init_to_f (c_beam_init, c_loc(f_beam_init))

call set_beam_init_test_pattern (f2_beam_init, 2)
if (f_beam_init == f2_beam_init) then
  print *, '[2] beam_init: F side convert C->F: Good'
else
  print *, '[2] beam_init: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call beam_init_struct_to_json(f_beam_init, json_root)
  call json%print(json_root, 'test_f_beam_init_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call beam_init_struct_to_json(f2_beam_init, json_root)
  call json%print(json_root, 'test_f_beam_init_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_beam_init_pattern_2_*.json)'

endif

call set_beam_init_test_pattern (f2_beam_init, 3)
call beam_init_to_c (c_loc(f2_beam_init), c_beam_init)

! clean up test pattern data - < 3 deallocates arrays and such
call set_beam_init_test_pattern (f_beam_init, -1)
call set_beam_init_test_pattern (f2_beam_init, -1)

end subroutine test2_f_beam_init

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_beam_init_test_pattern (F, ix_patt)

implicit none

type(beam_init_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%position_file)
  F%position_file(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[1D_NOT_character] FixedArray1D<string, 3>
do jd1 = lbound(F%distribution_type, 1), ubound(F%distribution_type, 1)
  do jd = 1, len(F%distribution_type(jd1))
    F%distribution_type(jd1)(jd:jd) = char(ichar("a") + modulo(100+2+offset+10*jd+jd1, 26))
  enddo
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%spin,1); lb1 = lbound(F%spin,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%spin(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_type] FixedArray1D<CPP_ellipse_beam_init, 3>
if (ix_patt < 0) then
  ! pattern < 0 means clean up memory
  do jd1 = lbound(F%ellipse,1), ubound(F%ellipse,1)
    call set_ellipse_beam_init_test_pattern (F%ellipse(jd1), -1)
  enddo
else
  do jd1 = 1, size(F%ellipse,1)
    lb1 = lbound(F%ellipse,1) - 1
    rhs = 100 + jd1 + 4 + offset
    call set_ellipse_beam_init_test_pattern (F%ellipse(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_kv_beam_init
call set_kv_beam_init_test_pattern (F%KV, ix_patt)
!! f_side.test_pat[1D_NOT_type] FixedArray1D<CPP_grid_beam_init, 3>
if (ix_patt < 0) then
  ! pattern < 0 means clean up memory
  do jd1 = lbound(F%grid,1), ubound(F%grid,1)
    call set_grid_beam_init_test_pattern (F%grid(jd1), -1)
  enddo
else
  do jd1 = 1, size(F%grid,1)
    lb1 = lbound(F%grid,1) - 1
    rhs = 100 + jd1 + 6 + offset
    call set_grid_beam_init_test_pattern (F%grid(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%center_jitter,1); lb1 = lbound(F%center_jitter,1) - 1
  rhs = 100 + jd1 + 7 + offset
  F%center_jitter(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 2>
do jd1 = 1, size(F%emit_jitter,1); lb1 = lbound(F%emit_jitter,1) - 1
  rhs = 100 + jd1 + 8 + offset
  F%emit_jitter(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%sig_z_jitter = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%sig_pz_jitter = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 11 + offset; F%n_particle = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 12 + offset; F%renorm_center = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 13 + offset; F%renorm_sigma = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%random_engine)
  F%random_engine(jd1:jd1) = char(ichar("a") + modulo(100+14+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%random_gauss_converter)
  F%random_gauss_converter(jd1:jd1) = char(ichar("a") + modulo(100+15+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 16 + offset; F%random_sigma_cutoff = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 17 + offset; F%a_norm_emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 18 + offset; F%b_norm_emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 19 + offset; F%a_emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 20 + offset; F%b_emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 21 + offset; F%dPz_dz = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%center,1); lb1 = lbound(F%center,1) - 1
  rhs = 100 + jd1 + 22 + offset
  F%center(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 23 + offset; F%t_offset = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 24 + offset; F%dt_bunch = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 25 + offset; F%sig_z = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 26 + offset; F%sig_pz = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 27 + offset; F%bunch_charge = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 28 + offset; F%n_bunch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 29 + offset; F%ix_turn = rhs
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%species)
  F%species(jd1:jd1) = char(ichar("a") + modulo(100+30+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 31 + offset; F%full_6D_coupling_calc = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 32 + offset; F%use_particle_start = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 33 + offset; F%use_t_coords = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 34 + offset; F%use_z_as_t = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%file_name)
  F%file_name(jd1:jd1) = char(ichar("a") + modulo(100+35+offset+jd1, 26))
enddo

end subroutine set_beam_init_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_lat_param (ok)

implicit none

type(lat_param_struct), target :: f_lat_param, f2_lat_param

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_lat_param (c_lat_param, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_lat_param
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_lat_param_test_pattern (f2_lat_param, 1)

call test_c_lat_param(c_loc(f2_lat_param), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_lat_param_test_pattern (f_lat_param, 4)
if (f_lat_param == f2_lat_param) then
  print *, '[4] lat_param: C side convert C->F: Good'
else
  print *, '[4] lat_param: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call lat_param_struct_to_json(f_lat_param, json_root)
  call json%print(json_root, 'test_f_lat_param_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call lat_param_struct_to_json(f2_lat_param, json_root)
  call json%print(json_root, 'test_f_lat_param_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_lat_param_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_lat_param_test_pattern (f_lat_param, -1)
call set_lat_param_test_pattern (f2_lat_param, -1)

end subroutine test1_f_lat_param

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_lat_param (c_lat_param, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_lat_param
type(lat_param_struct), target :: f_lat_param, f2_lat_param
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call lat_param_to_f (c_lat_param, c_loc(f_lat_param))

call set_lat_param_test_pattern (f2_lat_param, 2)
if (f_lat_param == f2_lat_param) then
  print *, '[2] lat_param: F side convert C->F: Good'
else
  print *, '[2] lat_param: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call lat_param_struct_to_json(f_lat_param, json_root)
  call json%print(json_root, 'test_f_lat_param_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call lat_param_struct_to_json(f2_lat_param, json_root)
  call json%print(json_root, 'test_f_lat_param_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_lat_param_pattern_2_*.json)'

endif

call set_lat_param_test_pattern (f2_lat_param, 3)
call lat_param_to_c (c_loc(f2_lat_param), c_lat_param)

! clean up test pattern data - < 3 deallocates arrays and such
call set_lat_param_test_pattern (f_lat_param, -1)
call set_lat_param_test_pattern (f2_lat_param, -1)

end subroutine test2_f_lat_param

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_lat_param_test_pattern (F, ix_patt)

implicit none

type(lat_param_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%n_part = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%total_length = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%unstable_factor = rhs
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%t1_with_RF,1); lb1 = lbound(F%t1_with_RF,1) - 1
  do jd2 = 1, size(F%t1_with_RF,2); lb2 = lbound(F%t1_with_RF,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 4 + offset
    F%t1_with_RF(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%t1_no_RF,1); lb1 = lbound(F%t1_no_RF,1) - 1
  do jd2 = 1, size(F%t1_no_RF,2); lb2 = lbound(F%t1_no_RF,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 5 + offset
    F%t1_no_RF(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%spin_tune = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%particle = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%default_tracking_species = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%geometry = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 10 + offset; F%ixx = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 11 + offset; F%stable = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 12 + offset; F%live_branch = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_real] Real
rhs = 13 + offset; F%g1_integral = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 14 + offset; F%g2_integral = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 15 + offset; F%g3_integral = rhs
!! f_side.test_pat[0D_NOT_type] CPP_bookkeeping_state
call set_bookkeeping_state_test_pattern (F%bookkeeping_state, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_beam_init
call set_beam_init_test_pattern (F%beam_init, ix_patt)

end subroutine set_lat_param_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_mode_info (ok)

implicit none

type(mode_info_struct), target :: f_mode_info, f2_mode_info

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_mode_info (c_mode_info, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_mode_info
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_mode_info_test_pattern (f2_mode_info, 1)

call test_c_mode_info(c_loc(f2_mode_info), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_mode_info_test_pattern (f_mode_info, 4)
if (f_mode_info == f2_mode_info) then
  print *, '[4] mode_info: C side convert C->F: Good'
else
  print *, '[4] mode_info: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call mode_info_struct_to_json(f_mode_info, json_root)
  call json%print(json_root, 'test_f_mode_info_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call mode_info_struct_to_json(f2_mode_info, json_root)
  call json%print(json_root, 'test_f_mode_info_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_mode_info_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_mode_info_test_pattern (f_mode_info, -1)
call set_mode_info_test_pattern (f2_mode_info, -1)

end subroutine test1_f_mode_info

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_mode_info (c_mode_info, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_mode_info
type(mode_info_struct), target :: f_mode_info, f2_mode_info
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call mode_info_to_f (c_mode_info, c_loc(f_mode_info))

call set_mode_info_test_pattern (f2_mode_info, 2)
if (f_mode_info == f2_mode_info) then
  print *, '[2] mode_info: F side convert C->F: Good'
else
  print *, '[2] mode_info: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call mode_info_struct_to_json(f_mode_info, json_root)
  call json%print(json_root, 'test_f_mode_info_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call mode_info_struct_to_json(f2_mode_info, json_root)
  call json%print(json_root, 'test_f_mode_info_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_mode_info_pattern_2_*.json)'

endif

call set_mode_info_test_pattern (f2_mode_info, 3)
call mode_info_to_c (c_loc(f2_mode_info), c_mode_info)

! clean up test pattern data - < 3 deallocates arrays and such
call set_mode_info_test_pattern (f_mode_info, -1)
call set_mode_info_test_pattern (f2_mode_info, -1)

end subroutine test2_f_mode_info

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_mode_info_test_pattern (F, ix_patt)

implicit none

type(mode_info_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 1 + offset; F%stable = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%tune = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%emit = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%chrom = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%sigma = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%sigmap = rhs

end subroutine set_mode_info_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_pre_tracker (ok)

implicit none

type(pre_tracker_struct), target :: f_pre_tracker, f2_pre_tracker

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_pre_tracker (c_pre_tracker, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_pre_tracker
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_pre_tracker_test_pattern (f2_pre_tracker, 1)

call test_c_pre_tracker(c_loc(f2_pre_tracker), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_pre_tracker_test_pattern (f_pre_tracker, 4)
if (f_pre_tracker == f2_pre_tracker) then
  print *, '[4] pre_tracker: C side convert C->F: Good'
else
  print *, '[4] pre_tracker: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call pre_tracker_struct_to_json(f_pre_tracker, json_root)
  call json%print(json_root, 'test_f_pre_tracker_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call pre_tracker_struct_to_json(f2_pre_tracker, json_root)
  call json%print(json_root, 'test_f_pre_tracker_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_pre_tracker_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_pre_tracker_test_pattern (f_pre_tracker, -1)
call set_pre_tracker_test_pattern (f2_pre_tracker, -1)

end subroutine test1_f_pre_tracker

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_pre_tracker (c_pre_tracker, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_pre_tracker
type(pre_tracker_struct), target :: f_pre_tracker, f2_pre_tracker
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call pre_tracker_to_f (c_pre_tracker, c_loc(f_pre_tracker))

call set_pre_tracker_test_pattern (f2_pre_tracker, 2)
if (f_pre_tracker == f2_pre_tracker) then
  print *, '[2] pre_tracker: F side convert C->F: Good'
else
  print *, '[2] pre_tracker: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call pre_tracker_struct_to_json(f_pre_tracker, json_root)
  call json%print(json_root, 'test_f_pre_tracker_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call pre_tracker_struct_to_json(f2_pre_tracker, json_root)
  call json%print(json_root, 'test_f_pre_tracker_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_pre_tracker_pattern_2_*.json)'

endif

call set_pre_tracker_test_pattern (f2_pre_tracker, 3)
call pre_tracker_to_c (c_loc(f2_pre_tracker), c_pre_tracker)

! clean up test pattern data - < 3 deallocates arrays and such
call set_pre_tracker_test_pattern (f_pre_tracker, -1)
call set_pre_tracker_test_pattern (f2_pre_tracker, -1)

end subroutine test2_f_pre_tracker

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_pre_tracker_test_pattern (F, ix_patt)

implicit none

type(pre_tracker_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%who = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%ix_ele_start = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%ix_ele_end = rhs
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%input_file)
  F%input_file(jd1:jd1) = char(ichar("a") + modulo(100+4+offset+jd1, 26))
enddo

end subroutine set_pre_tracker_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_anormal_mode (ok)

implicit none

type(anormal_mode_struct), target :: f_anormal_mode, f2_anormal_mode

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_anormal_mode (c_anormal_mode, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_anormal_mode
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_anormal_mode_test_pattern (f2_anormal_mode, 1)

call test_c_anormal_mode(c_loc(f2_anormal_mode), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_anormal_mode_test_pattern (f_anormal_mode, 4)
if (f_anormal_mode == f2_anormal_mode) then
  print *, '[4] anormal_mode: C side convert C->F: Good'
else
  print *, '[4] anormal_mode: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call anormal_mode_struct_to_json(f_anormal_mode, json_root)
  call json%print(json_root, 'test_f_anormal_mode_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call anormal_mode_struct_to_json(f2_anormal_mode, json_root)
  call json%print(json_root, 'test_f_anormal_mode_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_anormal_mode_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_anormal_mode_test_pattern (f_anormal_mode, -1)
call set_anormal_mode_test_pattern (f2_anormal_mode, -1)

end subroutine test1_f_anormal_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_anormal_mode (c_anormal_mode, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_anormal_mode
type(anormal_mode_struct), target :: f_anormal_mode, f2_anormal_mode
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call anormal_mode_to_f (c_anormal_mode, c_loc(f_anormal_mode))

call set_anormal_mode_test_pattern (f2_anormal_mode, 2)
if (f_anormal_mode == f2_anormal_mode) then
  print *, '[2] anormal_mode: F side convert C->F: Good'
else
  print *, '[2] anormal_mode: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call anormal_mode_struct_to_json(f_anormal_mode, json_root)
  call json%print(json_root, 'test_f_anormal_mode_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call anormal_mode_struct_to_json(f2_anormal_mode, json_root)
  call json%print(json_root, 'test_f_anormal_mode_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_anormal_mode_pattern_2_*.json)'

endif

call set_anormal_mode_test_pattern (f2_anormal_mode, 3)
call anormal_mode_to_c (c_loc(f2_anormal_mode), c_anormal_mode)

! clean up test pattern data - < 3 deallocates arrays and such
call set_anormal_mode_test_pattern (f_anormal_mode, -1)
call set_anormal_mode_test_pattern (f2_anormal_mode, -1)

end subroutine test2_f_anormal_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_anormal_mode_test_pattern (F, ix_patt)

implicit none

type(anormal_mode_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%emittance = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%emittance_no_vert = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%synch_int,1); lb1 = lbound(F%synch_int,1) - 1
  rhs = 100 + jd1 + 3 + offset
  F%synch_int(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%j_damp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%alpha_damp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%chrom = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%tune = rhs

end subroutine set_anormal_mode_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_linac_normal_mode (ok)

implicit none

type(linac_normal_mode_struct), target :: f_linac_normal_mode, f2_linac_normal_mode

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_linac_normal_mode (c_linac_normal_mode, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_linac_normal_mode
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_linac_normal_mode_test_pattern (f2_linac_normal_mode, 1)

call test_c_linac_normal_mode(c_loc(f2_linac_normal_mode), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_linac_normal_mode_test_pattern (f_linac_normal_mode, 4)
if (f_linac_normal_mode == f2_linac_normal_mode) then
  print *, '[4] linac_normal_mode: C side convert C->F: Good'
else
  print *, '[4] linac_normal_mode: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call linac_normal_mode_struct_to_json(f_linac_normal_mode, json_root)
  call json%print(json_root, 'test_f_linac_normal_mode_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call linac_normal_mode_struct_to_json(f2_linac_normal_mode, json_root)
  call json%print(json_root, 'test_f_linac_normal_mode_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_linac_normal_mode_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_linac_normal_mode_test_pattern (f_linac_normal_mode, -1)
call set_linac_normal_mode_test_pattern (f2_linac_normal_mode, -1)

end subroutine test1_f_linac_normal_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_linac_normal_mode (c_linac_normal_mode, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_linac_normal_mode
type(linac_normal_mode_struct), target :: f_linac_normal_mode, f2_linac_normal_mode
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call linac_normal_mode_to_f (c_linac_normal_mode, c_loc(f_linac_normal_mode))

call set_linac_normal_mode_test_pattern (f2_linac_normal_mode, 2)
if (f_linac_normal_mode == f2_linac_normal_mode) then
  print *, '[2] linac_normal_mode: F side convert C->F: Good'
else
  print *, '[2] linac_normal_mode: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call linac_normal_mode_struct_to_json(f_linac_normal_mode, json_root)
  call json%print(json_root, 'test_f_linac_normal_mode_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call linac_normal_mode_struct_to_json(f2_linac_normal_mode, json_root)
  call json%print(json_root, 'test_f_linac_normal_mode_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_linac_normal_mode_pattern_2_*.json)'

endif

call set_linac_normal_mode_test_pattern (f2_linac_normal_mode, 3)
call linac_normal_mode_to_c (c_loc(f2_linac_normal_mode), c_linac_normal_mode)

! clean up test pattern data - < 3 deallocates arrays and such
call set_linac_normal_mode_test_pattern (f_linac_normal_mode, -1)
call set_linac_normal_mode_test_pattern (f2_linac_normal_mode, -1)

end subroutine test2_f_linac_normal_mode

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_linac_normal_mode_test_pattern (F, ix_patt)

implicit none

type(linac_normal_mode_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%i2_E4 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%i3_E7 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%i5a_E6 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%i5b_E6 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%sig_E1 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%a_emittance_end = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%b_emittance_end = rhs

end subroutine set_linac_normal_mode_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_normal_modes (ok)

implicit none

type(normal_modes_struct), target :: f_normal_modes, f2_normal_modes

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_normal_modes (c_normal_modes, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_normal_modes
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_normal_modes_test_pattern (f2_normal_modes, 1)

call test_c_normal_modes(c_loc(f2_normal_modes), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_normal_modes_test_pattern (f_normal_modes, 4)
if (f_normal_modes == f2_normal_modes) then
  print *, '[4] normal_modes: C side convert C->F: Good'
else
  print *, '[4] normal_modes: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call normal_modes_struct_to_json(f_normal_modes, json_root)
  call json%print(json_root, 'test_f_normal_modes_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call normal_modes_struct_to_json(f2_normal_modes, json_root)
  call json%print(json_root, 'test_f_normal_modes_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_normal_modes_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_normal_modes_test_pattern (f_normal_modes, -1)
call set_normal_modes_test_pattern (f2_normal_modes, -1)

end subroutine test1_f_normal_modes

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_normal_modes (c_normal_modes, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_normal_modes
type(normal_modes_struct), target :: f_normal_modes, f2_normal_modes
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call normal_modes_to_f (c_normal_modes, c_loc(f_normal_modes))

call set_normal_modes_test_pattern (f2_normal_modes, 2)
if (f_normal_modes == f2_normal_modes) then
  print *, '[2] normal_modes: F side convert C->F: Good'
else
  print *, '[2] normal_modes: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call normal_modes_struct_to_json(f_normal_modes, json_root)
  call json%print(json_root, 'test_f_normal_modes_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call normal_modes_struct_to_json(f2_normal_modes, json_root)
  call json%print(json_root, 'test_f_normal_modes_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_normal_modes_pattern_2_*.json)'

endif

call set_normal_modes_test_pattern (f2_normal_modes, 3)
call normal_modes_to_c (c_loc(f2_normal_modes), c_normal_modes)

! clean up test pattern data - < 3 deallocates arrays and such
call set_normal_modes_test_pattern (f_normal_modes, -1)
call set_normal_modes_test_pattern (f2_normal_modes, -1)

end subroutine test2_f_normal_modes

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_normal_modes_test_pattern (F, ix_patt)

implicit none

type(normal_modes_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 4>
do jd1 = 1, size(F%synch_int,1); lb1 = lbound(F%synch_int,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%synch_int(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%sigE_E = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%sig_z = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%e_loss = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%rf_voltage = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%pz_aperture = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%pz_average = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%momentum_compaction = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%dpz_damp = rhs
!! f_side.test_pat[0D_NOT_type] CPP_anormal_mode
call set_anormal_mode_test_pattern (F%a, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_anormal_mode
call set_anormal_mode_test_pattern (F%b, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_anormal_mode
call set_anormal_mode_test_pattern (F%z, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_linac_normal_mode
call set_linac_normal_mode_test_pattern (F%lin, ix_patt)

end subroutine set_normal_modes_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_em_field (ok)

implicit none

type(em_field_struct), target :: f_em_field, f2_em_field

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_em_field (c_em_field, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_em_field
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_em_field_test_pattern (f2_em_field, 1)

call test_c_em_field(c_loc(f2_em_field), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_em_field_test_pattern (f_em_field, 4)
if (f_em_field == f2_em_field) then
  print *, '[4] em_field: C side convert C->F: Good'
else
  print *, '[4] em_field: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call em_field_struct_to_json(f_em_field, json_root)
  call json%print(json_root, 'test_f_em_field_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call em_field_struct_to_json(f2_em_field, json_root)
  call json%print(json_root, 'test_f_em_field_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_em_field_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_em_field_test_pattern (f_em_field, -1)
call set_em_field_test_pattern (f2_em_field, -1)

end subroutine test1_f_em_field

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_em_field (c_em_field, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_em_field
type(em_field_struct), target :: f_em_field, f2_em_field
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call em_field_to_f (c_em_field, c_loc(f_em_field))

call set_em_field_test_pattern (f2_em_field, 2)
if (f_em_field == f2_em_field) then
  print *, '[2] em_field: F side convert C->F: Good'
else
  print *, '[2] em_field: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call em_field_struct_to_json(f_em_field, json_root)
  call json%print(json_root, 'test_f_em_field_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call em_field_struct_to_json(f2_em_field, json_root)
  call json%print(json_root, 'test_f_em_field_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_em_field_pattern_2_*.json)'

endif

call set_em_field_test_pattern (f2_em_field, 3)
call em_field_to_c (c_loc(f2_em_field), c_em_field)

! clean up test pattern data - < 3 deallocates arrays and such
call set_em_field_test_pattern (f_em_field, -1)
call set_em_field_test_pattern (f2_em_field, -1)

end subroutine test2_f_em_field

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_em_field_test_pattern (F, ix_patt)

implicit none

type(em_field_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%E,1); lb1 = lbound(F%E,1) - 1
  rhs = 100 + jd1 + 1 + offset
  F%E(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%B,1); lb1 = lbound(F%B,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%B(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 3, 3>
do jd1 = 1, size(F%dE,1); lb1 = lbound(F%dE,1) - 1
  do jd2 = 1, size(F%dE,2); lb2 = lbound(F%dE,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 3 + offset
    F%dE(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 3, 3>
do jd1 = 1, size(F%dB,1); lb1 = lbound(F%dB,1) - 1
  do jd2 = 1, size(F%dB,2); lb2 = lbound(F%dB,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 4 + offset
    F%dB(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%phi = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%phi_B = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 3>
do jd1 = 1, size(F%A,1); lb1 = lbound(F%A,1) - 1
  rhs = 100 + jd1 + 7 + offset
  F%A(jd1+lb1) = rhs
enddo

end subroutine set_em_field_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_strong_beam (ok)

implicit none

type(strong_beam_struct), target :: f_strong_beam, f2_strong_beam

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_strong_beam (c_strong_beam, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_strong_beam
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_strong_beam_test_pattern (f2_strong_beam, 1)

call test_c_strong_beam(c_loc(f2_strong_beam), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_strong_beam_test_pattern (f_strong_beam, 4)
if (f_strong_beam == f2_strong_beam) then
  print *, '[4] strong_beam: C side convert C->F: Good'
else
  print *, '[4] strong_beam: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call strong_beam_struct_to_json(f_strong_beam, json_root)
  call json%print(json_root, 'test_f_strong_beam_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call strong_beam_struct_to_json(f2_strong_beam, json_root)
  call json%print(json_root, 'test_f_strong_beam_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_strong_beam_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_strong_beam_test_pattern (f_strong_beam, -1)
call set_strong_beam_test_pattern (f2_strong_beam, -1)

end subroutine test1_f_strong_beam

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_strong_beam (c_strong_beam, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_strong_beam
type(strong_beam_struct), target :: f_strong_beam, f2_strong_beam
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call strong_beam_to_f (c_strong_beam, c_loc(f_strong_beam))

call set_strong_beam_test_pattern (f2_strong_beam, 2)
if (f_strong_beam == f2_strong_beam) then
  print *, '[2] strong_beam: F side convert C->F: Good'
else
  print *, '[2] strong_beam: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call strong_beam_struct_to_json(f_strong_beam, json_root)
  call json%print(json_root, 'test_f_strong_beam_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call strong_beam_struct_to_json(f2_strong_beam, json_root)
  call json%print(json_root, 'test_f_strong_beam_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_strong_beam_pattern_2_*.json)'

endif

call set_strong_beam_test_pattern (f2_strong_beam, 3)
call strong_beam_to_c (c_loc(f2_strong_beam), c_strong_beam)

! clean up test pattern data - < 3 deallocates arrays and such
call set_strong_beam_test_pattern (f_strong_beam, -1)
call set_strong_beam_test_pattern (f2_strong_beam, -1)

end subroutine test2_f_strong_beam

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_strong_beam_test_pattern (F, ix_patt)

implicit none

type(strong_beam_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_integer] Int
rhs = 1 + offset; F%ix_slice = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%x_center = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%y_center = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%x_sigma = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%y_sigma = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%dx = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%dy = rhs

end subroutine set_strong_beam_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_track_point (ok)

implicit none

type(track_point_struct), target :: f_track_point, f2_track_point

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_track_point (c_track_point, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_track_point
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_track_point_test_pattern (f2_track_point, 1)

call test_c_track_point(c_loc(f2_track_point), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_track_point_test_pattern (f_track_point, 4)
if (f_track_point == f2_track_point) then
  print *, '[4] track_point: C side convert C->F: Good'
else
  print *, '[4] track_point: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call track_point_struct_to_json(f_track_point, json_root)
  call json%print(json_root, 'test_f_track_point_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call track_point_struct_to_json(f2_track_point, json_root)
  call json%print(json_root, 'test_f_track_point_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_track_point_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_track_point_test_pattern (f_track_point, -1)
call set_track_point_test_pattern (f2_track_point, -1)

end subroutine test1_f_track_point

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_track_point (c_track_point, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_track_point
type(track_point_struct), target :: f_track_point, f2_track_point
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call track_point_to_f (c_track_point, c_loc(f_track_point))

call set_track_point_test_pattern (f2_track_point, 2)
if (f_track_point == f2_track_point) then
  print *, '[2] track_point: F side convert C->F: Good'
else
  print *, '[2] track_point: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call track_point_struct_to_json(f_track_point, json_root)
  call json%print(json_root, 'test_f_track_point_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call track_point_struct_to_json(f2_track_point, json_root)
  call json%print(json_root, 'test_f_track_point_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_track_point_pattern_2_*.json)'

endif

call set_track_point_test_pattern (f2_track_point, 3)
call track_point_to_c (c_loc(f2_track_point), c_track_point)

! clean up test pattern data - < 3 deallocates arrays and such
call set_track_point_test_pattern (f_track_point, -1)
call set_track_point_test_pattern (f2_track_point, -1)

end subroutine test2_f_track_point

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_track_point_test_pattern (F, ix_patt)

implicit none

type(track_point_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%s_lab = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%s_body = rhs
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%orb, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_em_field
call set_em_field_test_pattern (F%field, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_strong_beam
call set_strong_beam_test_pattern (F%strong_beam, ix_patt)
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%vec0,1); lb1 = lbound(F%vec0,1) - 1
  rhs = 100 + jd1 + 6 + offset
  F%vec0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%mat6,1); lb1 = lbound(F%mat6,1) - 1
  do jd2 = 1, size(F%mat6,2); lb2 = lbound(F%mat6,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 7 + offset
    F%mat6(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo

end subroutine set_track_point_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_track (ok)

implicit none

type(track_struct), target :: f_track, f2_track

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_track (c_track, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_track
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_track_test_pattern (f2_track, 1)

call test_c_track(c_loc(f2_track), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_track_test_pattern (f_track, 4)
if (f_track == f2_track) then
  print *, '[4] track: C side convert C->F: Good'
else
  print *, '[4] track: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call track_struct_to_json(f_track, json_root)
  call json%print(json_root, 'test_f_track_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call track_struct_to_json(f2_track, json_root)
  call json%print(json_root, 'test_f_track_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_track_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_track_test_pattern (f_track, -1)
call set_track_test_pattern (f2_track, -1)

end subroutine test1_f_track

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_track (c_track, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_track
type(track_struct), target :: f_track, f2_track
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call track_to_f (c_track, c_loc(f_track))

call set_track_test_pattern (f2_track, 2)
if (f_track == f2_track) then
  print *, '[2] track: F side convert C->F: Good'
else
  print *, '[2] track: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call track_struct_to_json(f_track, json_root)
  call json%print(json_root, 'test_f_track_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call track_struct_to_json(f2_track, json_root)
  call json%print(json_root, 'test_f_track_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_track_pattern_2_*.json)'

endif

call set_track_test_pattern (f2_track, 3)
call track_to_c (c_loc(f2_track), c_track)

! clean up test pattern data - < 3 deallocates arrays and such
call set_track_test_pattern (f_track, -1)
call set_track_test_pattern (f2_track, -1)

end subroutine test2_f_track

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_track_test_pattern (F, ix_patt)

implicit none

type(track_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_track_point>
if (ix_patt < 3) then
  if (allocated(F%pt)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%pt,1), ubound(F%pt,1)
      call set_track_point_test_pattern (F%pt(jd1), -1)
    enddo
    deallocate (F%pt)
  endif
else
  if (.not. allocated(F%pt)) then
    allocate (F%pt(-1:1))
  endif
  do jd1 = 1, size(F%pt,1)
    lb1 = lbound(F%pt,1) - 1
    call set_track_point_test_pattern (F%pt(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%ds_save = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%n_pt = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%n_bad = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 6 + offset; F%n_ok = rhs

end subroutine set_track_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_space_charge_common (ok)

implicit none

type(space_charge_common_struct), target :: f_space_charge_common, f2_space_charge_common

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_space_charge_common (c_space_charge_common, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_space_charge_common
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_space_charge_common_test_pattern (f2_space_charge_common, 1)

call test_c_space_charge_common(c_loc(f2_space_charge_common), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_space_charge_common_test_pattern (f_space_charge_common, 4)
if (f_space_charge_common == f2_space_charge_common) then
  print *, '[4] space_charge_common: C side convert C->F: Good'
else
  print *, '[4] space_charge_common: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call space_charge_common_struct_to_json(f_space_charge_common, json_root)
  call json%print(json_root, 'test_f_space_charge_common_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call space_charge_common_struct_to_json(f2_space_charge_common, json_root)
  call json%print(json_root, 'test_f_space_charge_common_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_space_charge_common_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_space_charge_common_test_pattern (f_space_charge_common, -1)
call set_space_charge_common_test_pattern (f2_space_charge_common, -1)

end subroutine test1_f_space_charge_common

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_space_charge_common (c_space_charge_common, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_space_charge_common
type(space_charge_common_struct), target :: f_space_charge_common, f2_space_charge_common
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call space_charge_common_to_f (c_space_charge_common, c_loc(f_space_charge_common))

call set_space_charge_common_test_pattern (f2_space_charge_common, 2)
if (f_space_charge_common == f2_space_charge_common) then
  print *, '[2] space_charge_common: F side convert C->F: Good'
else
  print *, '[2] space_charge_common: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call space_charge_common_struct_to_json(f_space_charge_common, json_root)
  call json%print(json_root, 'test_f_space_charge_common_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call space_charge_common_struct_to_json(f2_space_charge_common, json_root)
  call json%print(json_root, 'test_f_space_charge_common_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_space_charge_common_pattern_2_*.json)'

endif

call set_space_charge_common_test_pattern (f2_space_charge_common, 3)
call space_charge_common_to_c (c_loc(f2_space_charge_common), c_space_charge_common)

! clean up test pattern data - < 3 deallocates arrays and such
call set_space_charge_common_test_pattern (f_space_charge_common, -1)
call set_space_charge_common_test_pattern (f2_space_charge_common, -1)

end subroutine test2_f_space_charge_common

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_space_charge_common_test_pattern (F, ix_patt)

implicit none

type(space_charge_common_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%ds_track_step = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%dt_track_step = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%cathode_strength_cutoff = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%rel_tol_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%abs_tol_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%beam_chamber_height = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%lsc_sigma_cutoff = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%particle_sigma_cutoff = rhs
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 3>
do jd1 = 1, size(F%space_charge_mesh_size,1); lb1 = lbound(F%space_charge_mesh_size,1) - 1
  rhs = 100 + jd1 + 9 + offset
  F%space_charge_mesh_size(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 3>
do jd1 = 1, size(F%csr3d_mesh_size,1); lb1 = lbound(F%csr3d_mesh_size,1) - 1
  rhs = 100 + jd1 + 10 + offset
  F%csr3d_mesh_size(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 11 + offset; F%n_bin = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 12 + offset; F%particle_bin_span = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 13 + offset; F%n_shield_images = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 14 + offset; F%sc_min_in_bin = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 15 + offset; F%lsc_kick_transverse_dependence = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 16 + offset; F%debug = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%diagnostic_output_file)
  F%diagnostic_output_file(jd1:jd1) = char(ichar("a") + modulo(100+17+offset+jd1, 26))
enddo

end subroutine set_space_charge_common_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_bmad_common (ok)

implicit none

type(bmad_common_struct), target :: f_bmad_common, f2_bmad_common

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_bmad_common (c_bmad_common, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_bmad_common
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_bmad_common_test_pattern (f2_bmad_common, 1)

call test_c_bmad_common(c_loc(f2_bmad_common), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_bmad_common_test_pattern (f_bmad_common, 4)
if (f_bmad_common == f2_bmad_common) then
  print *, '[4] bmad_common: C side convert C->F: Good'
else
  print *, '[4] bmad_common: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call bmad_common_struct_to_json(f_bmad_common, json_root)
  call json%print(json_root, 'test_f_bmad_common_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bmad_common_struct_to_json(f2_bmad_common, json_root)
  call json%print(json_root, 'test_f_bmad_common_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bmad_common_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_bmad_common_test_pattern (f_bmad_common, -1)
call set_bmad_common_test_pattern (f2_bmad_common, -1)

end subroutine test1_f_bmad_common

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_bmad_common (c_bmad_common, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_bmad_common
type(bmad_common_struct), target :: f_bmad_common, f2_bmad_common
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call bmad_common_to_f (c_bmad_common, c_loc(f_bmad_common))

call set_bmad_common_test_pattern (f2_bmad_common, 2)
if (f_bmad_common == f2_bmad_common) then
  print *, '[2] bmad_common: F side convert C->F: Good'
else
  print *, '[2] bmad_common: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call bmad_common_struct_to_json(f_bmad_common, json_root)
  call json%print(json_root, 'test_f_bmad_common_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bmad_common_struct_to_json(f2_bmad_common, json_root)
  call json%print(json_root, 'test_f_bmad_common_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bmad_common_pattern_2_*.json)'

endif

call set_bmad_common_test_pattern (f2_bmad_common, 3)
call bmad_common_to_c (c_loc(f2_bmad_common), c_bmad_common)

! clean up test pattern data - < 3 deallocates arrays and such
call set_bmad_common_test_pattern (f_bmad_common, -1)
call set_bmad_common_test_pattern (f2_bmad_common, -1)

end subroutine test2_f_bmad_common

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_bmad_common_test_pattern (F, ix_patt)

implicit none

type(bmad_common_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%max_aperture_limit = rhs
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%d_orb,1); lb1 = lbound(F%d_orb,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%d_orb(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%default_ds_step = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%significant_length = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%rel_tol_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%abs_tol_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%rel_tol_adaptive_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%abs_tol_adaptive_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%init_ds_adaptive_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%min_ds_adaptive_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%fatal_ds_adaptive_tracking = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 12 + offset; F%autoscale_amp_abs_tol = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 13 + offset; F%autoscale_amp_rel_tol = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 14 + offset; F%autoscale_phase_tol = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 15 + offset; F%electric_dipole_moment = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 16 + offset; F%synch_rad_scale = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 17 + offset; F%sad_eps_scale = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 18 + offset; F%sad_amp_max = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 19 + offset; F%sad_n_div_max = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 20 + offset; F%taylor_order = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 21 + offset; F%runge_kutta_order = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 22 + offset; F%default_integ_order = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 23 + offset; F%max_num_runge_kutta_step = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 24 + offset; F%rf_phase_below_transition_ref = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 25 + offset; F%sr_wakes_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 26 + offset; F%lr_wakes_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 27 + offset; F%auto_bookkeeper = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 28 + offset; F%high_energy_space_charge_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 29 + offset; F%csr_and_space_charge_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 30 + offset; F%spin_tracking_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 31 + offset; F%spin_sokolov_ternov_flipping_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 32 + offset; F%radiation_damping_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 33 + offset; F%radiation_zero_average = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 34 + offset; F%radiation_fluctuations_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 35 + offset; F%conserve_taylor_maps = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 36 + offset; F%absolute_time_tracking = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 37 + offset; F%absolute_time_ref_shift = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 38 + offset; F%convert_to_kinetic_momentum = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 39 + offset; F%normalize_twiss = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 40 + offset; F%aperture_limit_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 41 + offset; F%spin_n0_direction_user_set = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 42 + offset; F%debug = (modulo(rhs, 2) == 0)

end subroutine set_bmad_common_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rad_int1 (ok)

implicit none

type(rad_int1_struct), target :: f_rad_int1, f2_rad_int1

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rad_int1 (c_rad_int1, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rad_int1
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rad_int1_test_pattern (f2_rad_int1, 1)

call test_c_rad_int1(c_loc(f2_rad_int1), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rad_int1_test_pattern (f_rad_int1, 4)
if (f_rad_int1 == f2_rad_int1) then
  print *, '[4] rad_int1: C side convert C->F: Good'
else
  print *, '[4] rad_int1: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rad_int1_struct_to_json(f_rad_int1, json_root)
  call json%print(json_root, 'test_f_rad_int1_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_int1_struct_to_json(f2_rad_int1, json_root)
  call json%print(json_root, 'test_f_rad_int1_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_int1_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_int1_test_pattern (f_rad_int1, -1)
call set_rad_int1_test_pattern (f2_rad_int1, -1)

end subroutine test1_f_rad_int1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rad_int1 (c_rad_int1, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rad_int1
type(rad_int1_struct), target :: f_rad_int1, f2_rad_int1
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rad_int1_to_f (c_rad_int1, c_loc(f_rad_int1))

call set_rad_int1_test_pattern (f2_rad_int1, 2)
if (f_rad_int1 == f2_rad_int1) then
  print *, '[2] rad_int1: F side convert C->F: Good'
else
  print *, '[2] rad_int1: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rad_int1_struct_to_json(f_rad_int1, json_root)
  call json%print(json_root, 'test_f_rad_int1_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_int1_struct_to_json(f2_rad_int1, json_root)
  call json%print(json_root, 'test_f_rad_int1_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_int1_pattern_2_*.json)'

endif

call set_rad_int1_test_pattern (f2_rad_int1, 3)
call rad_int1_to_c (c_loc(f2_rad_int1), c_rad_int1)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_int1_test_pattern (f_rad_int1, -1)
call set_rad_int1_test_pattern (f2_rad_int1, -1)

end subroutine test2_f_rad_int1

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rad_int1_test_pattern (F, ix_patt)

implicit none

type(rad_int1_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%i0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%i1 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%i2 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%i3 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%i4a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%i4b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%i4z = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%i5a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%i5b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 10 + offset; F%i6b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%lin_i2_E4 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 12 + offset; F%lin_i3_E7 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 13 + offset; F%lin_i5a_E6 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 14 + offset; F%lin_i5b_E6 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 15 + offset; F%lin_norm_emit_a = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 16 + offset; F%lin_norm_emit_b = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 17 + offset; F%lin_sig_E = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 18 + offset; F%n_steps = rhs

end subroutine set_rad_int1_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rad_int_branch (ok)

implicit none

type(rad_int_branch_struct), target :: f_rad_int_branch, f2_rad_int_branch

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rad_int_branch (c_rad_int_branch, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rad_int_branch
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rad_int_branch_test_pattern (f2_rad_int_branch, 1)

call test_c_rad_int_branch(c_loc(f2_rad_int_branch), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rad_int_branch_test_pattern (f_rad_int_branch, 4)
if (f_rad_int_branch == f2_rad_int_branch) then
  print *, '[4] rad_int_branch: C side convert C->F: Good'
else
  print *, '[4] rad_int_branch: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rad_int_branch_struct_to_json(f_rad_int_branch, json_root)
  call json%print(json_root, 'test_f_rad_int_branch_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_int_branch_struct_to_json(f2_rad_int_branch, json_root)
  call json%print(json_root, 'test_f_rad_int_branch_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_int_branch_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_int_branch_test_pattern (f_rad_int_branch, -1)
call set_rad_int_branch_test_pattern (f2_rad_int_branch, -1)

end subroutine test1_f_rad_int_branch

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rad_int_branch (c_rad_int_branch, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rad_int_branch
type(rad_int_branch_struct), target :: f_rad_int_branch, f2_rad_int_branch
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rad_int_branch_to_f (c_rad_int_branch, c_loc(f_rad_int_branch))

call set_rad_int_branch_test_pattern (f2_rad_int_branch, 2)
if (f_rad_int_branch == f2_rad_int_branch) then
  print *, '[2] rad_int_branch: F side convert C->F: Good'
else
  print *, '[2] rad_int_branch: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rad_int_branch_struct_to_json(f_rad_int_branch, json_root)
  call json%print(json_root, 'test_f_rad_int_branch_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_int_branch_struct_to_json(f2_rad_int_branch, json_root)
  call json%print(json_root, 'test_f_rad_int_branch_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_int_branch_pattern_2_*.json)'

endif

call set_rad_int_branch_test_pattern (f2_rad_int_branch, 3)
call rad_int_branch_to_c (c_loc(f2_rad_int_branch), c_rad_int_branch)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_int_branch_test_pattern (f_rad_int_branch, -1)
call set_rad_int_branch_test_pattern (f2_rad_int_branch, -1)

end subroutine test2_f_rad_int_branch

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rad_int_branch_test_pattern (F, ix_patt)

implicit none

type(rad_int_branch_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_rad_int1>
if (ix_patt < 3) then
  if (allocated(F%ele)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%ele,1), ubound(F%ele,1)
      call set_rad_int1_test_pattern (F%ele(jd1), -1)
    enddo
    deallocate (F%ele)
  endif
else
  if (.not. allocated(F%ele)) then
    allocate (F%ele(-1:1))
  endif
  do jd1 = 1, size(F%ele,1)
    lb1 = lbound(F%ele,1) - 1
    call set_rad_int1_test_pattern (F%ele(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_rad_int_branch_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rad_int_all_ele (ok)

implicit none

type(rad_int_all_ele_struct), target :: f_rad_int_all_ele, f2_rad_int_all_ele

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rad_int_all_ele (c_rad_int_all_ele, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rad_int_all_ele
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rad_int_all_ele_test_pattern (f2_rad_int_all_ele, 1)

call test_c_rad_int_all_ele(c_loc(f2_rad_int_all_ele), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rad_int_all_ele_test_pattern (f_rad_int_all_ele, 4)
if (f_rad_int_all_ele == f2_rad_int_all_ele) then
  print *, '[4] rad_int_all_ele: C side convert C->F: Good'
else
  print *, '[4] rad_int_all_ele: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rad_int_all_ele_struct_to_json(f_rad_int_all_ele, json_root)
  call json%print(json_root, 'test_f_rad_int_all_ele_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_int_all_ele_struct_to_json(f2_rad_int_all_ele, json_root)
  call json%print(json_root, 'test_f_rad_int_all_ele_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_int_all_ele_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_int_all_ele_test_pattern (f_rad_int_all_ele, -1)
call set_rad_int_all_ele_test_pattern (f2_rad_int_all_ele, -1)

end subroutine test1_f_rad_int_all_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rad_int_all_ele (c_rad_int_all_ele, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rad_int_all_ele
type(rad_int_all_ele_struct), target :: f_rad_int_all_ele, f2_rad_int_all_ele
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rad_int_all_ele_to_f (c_rad_int_all_ele, c_loc(f_rad_int_all_ele))

call set_rad_int_all_ele_test_pattern (f2_rad_int_all_ele, 2)
if (f_rad_int_all_ele == f2_rad_int_all_ele) then
  print *, '[2] rad_int_all_ele: F side convert C->F: Good'
else
  print *, '[2] rad_int_all_ele: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rad_int_all_ele_struct_to_json(f_rad_int_all_ele, json_root)
  call json%print(json_root, 'test_f_rad_int_all_ele_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rad_int_all_ele_struct_to_json(f2_rad_int_all_ele, json_root)
  call json%print(json_root, 'test_f_rad_int_all_ele_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rad_int_all_ele_pattern_2_*.json)'

endif

call set_rad_int_all_ele_test_pattern (f2_rad_int_all_ele, 3)
call rad_int_all_ele_to_c (c_loc(f2_rad_int_all_ele), c_rad_int_all_ele)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rad_int_all_ele_test_pattern (f_rad_int_all_ele, -1)
call set_rad_int_all_ele_test_pattern (f2_rad_int_all_ele, -1)

end subroutine test2_f_rad_int_all_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rad_int_all_ele_test_pattern (F, ix_patt)

implicit none

type(rad_int_all_ele_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_rad_int_branch>
if (ix_patt < 3) then
  if (allocated(F%branch)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%branch,1), ubound(F%branch,1)
      call set_rad_int_branch_test_pattern (F%branch(jd1), -1)
    enddo
    deallocate (F%branch)
  endif
else
  if (.not. allocated(F%branch)) then
    allocate (F%branch(-1:1))
  endif
  do jd1 = 1, size(F%branch,1)
    lb1 = lbound(F%branch,1) - 1
    call set_rad_int_branch_test_pattern (F%branch(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_rad_int_all_ele_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rf_stair_step (ok)

implicit none

type(rf_stair_step_struct), target :: f_rf_stair_step, f2_rf_stair_step

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rf_stair_step (c_rf_stair_step, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rf_stair_step
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rf_stair_step_test_pattern (f2_rf_stair_step, 1)

call test_c_rf_stair_step(c_loc(f2_rf_stair_step), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rf_stair_step_test_pattern (f_rf_stair_step, 4)
if (f_rf_stair_step == f2_rf_stair_step) then
  print *, '[4] rf_stair_step: C side convert C->F: Good'
else
  print *, '[4] rf_stair_step: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rf_stair_step_struct_to_json(f_rf_stair_step, json_root)
  call json%print(json_root, 'test_f_rf_stair_step_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rf_stair_step_struct_to_json(f2_rf_stair_step, json_root)
  call json%print(json_root, 'test_f_rf_stair_step_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rf_stair_step_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rf_stair_step_test_pattern (f_rf_stair_step, -1)
call set_rf_stair_step_test_pattern (f2_rf_stair_step, -1)

end subroutine test1_f_rf_stair_step

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rf_stair_step (c_rf_stair_step, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rf_stair_step
type(rf_stair_step_struct), target :: f_rf_stair_step, f2_rf_stair_step
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rf_stair_step_to_f (c_rf_stair_step, c_loc(f_rf_stair_step))

call set_rf_stair_step_test_pattern (f2_rf_stair_step, 2)
if (f_rf_stair_step == f2_rf_stair_step) then
  print *, '[2] rf_stair_step: F side convert C->F: Good'
else
  print *, '[2] rf_stair_step: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rf_stair_step_struct_to_json(f_rf_stair_step, json_root)
  call json%print(json_root, 'test_f_rf_stair_step_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rf_stair_step_struct_to_json(f2_rf_stair_step, json_root)
  call json%print(json_root, 'test_f_rf_stair_step_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rf_stair_step_pattern_2_*.json)'

endif

call set_rf_stair_step_test_pattern (f2_rf_stair_step, 3)
call rf_stair_step_to_c (c_loc(f2_rf_stair_step), c_rf_stair_step)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rf_stair_step_test_pattern (f_rf_stair_step, -1)
call set_rf_stair_step_test_pattern (f2_rf_stair_step, -1)

end subroutine test2_f_rf_stair_step

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rf_stair_step_test_pattern (F, ix_patt)

implicit none

type(rf_stair_step_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%E_tot0 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%E_tot1 = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%p0c = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%p1c = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%dE_amp = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%scale = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%time = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%s = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 9 + offset; F%ix_step = rhs

end subroutine set_rf_stair_step_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_rf_ele (ok)

implicit none

type(rf_ele_struct), target :: f_rf_ele, f2_rf_ele

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_rf_ele (c_rf_ele, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_rf_ele
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_rf_ele_test_pattern (f2_rf_ele, 1)

call test_c_rf_ele(c_loc(f2_rf_ele), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_rf_ele_test_pattern (f_rf_ele, 4)
if (f_rf_ele == f2_rf_ele) then
  print *, '[4] rf_ele: C side convert C->F: Good'
else
  print *, '[4] rf_ele: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call rf_ele_struct_to_json(f_rf_ele, json_root)
  call json%print(json_root, 'test_f_rf_ele_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rf_ele_struct_to_json(f2_rf_ele, json_root)
  call json%print(json_root, 'test_f_rf_ele_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rf_ele_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_rf_ele_test_pattern (f_rf_ele, -1)
call set_rf_ele_test_pattern (f2_rf_ele, -1)

end subroutine test1_f_rf_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_rf_ele (c_rf_ele, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_rf_ele
type(rf_ele_struct), target :: f_rf_ele, f2_rf_ele
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call rf_ele_to_f (c_rf_ele, c_loc(f_rf_ele))

call set_rf_ele_test_pattern (f2_rf_ele, 2)
if (f_rf_ele == f2_rf_ele) then
  print *, '[2] rf_ele: F side convert C->F: Good'
else
  print *, '[2] rf_ele: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call rf_ele_struct_to_json(f_rf_ele, json_root)
  call json%print(json_root, 'test_f_rf_ele_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call rf_ele_struct_to_json(f2_rf_ele, json_root)
  call json%print(json_root, 'test_f_rf_ele_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_rf_ele_pattern_2_*.json)'

endif

call set_rf_ele_test_pattern (f2_rf_ele, 3)
call rf_ele_to_c (c_loc(f2_rf_ele), c_rf_ele)

! clean up test pattern data - < 3 deallocates arrays and such
call set_rf_ele_test_pattern (f_rf_ele, -1)
call set_rf_ele_test_pattern (f2_rf_ele, -1)

end subroutine test2_f_rf_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_rf_ele_test_pattern (F, ix_patt)

implicit none

type(rf_ele_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_rf_stair_step>
if (ix_patt < 3) then
  if (allocated(F%steps)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%steps,1), ubound(F%steps,1)
      call set_rf_stair_step_test_pattern (F%steps(jd1), -1)
    enddo
    deallocate (F%steps)
  endif
else
  if (.not. allocated(F%steps)) then
    allocate (F%steps(-1:1))
  endif
  do jd1 = 1, size(F%steps,1)
    lb1 = lbound(F%steps,1) - 1
    call set_rf_stair_step_test_pattern (F%steps(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 3 + offset; F%ds_step = rhs

end subroutine set_rf_ele_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_ele (ok)

implicit none

type(ele_struct), target :: f_ele, f2_ele

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_ele (c_ele, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_ele
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_ele_test_pattern (f2_ele, 1)

call test_c_ele(c_loc(f2_ele), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_ele_test_pattern (f_ele, 4)
if (f_ele == f2_ele) then
  print *, '[4] ele: C side convert C->F: Good'
else
  print *, '[4] ele: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call ele_struct_to_json(f_ele, json_root)
  call json%print(json_root, 'test_f_ele_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ele_struct_to_json(f2_ele, json_root)
  call json%print(json_root, 'test_f_ele_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ele_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_ele_test_pattern (f_ele, -1)
call set_ele_test_pattern (f2_ele, -1)

end subroutine test1_f_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_ele (c_ele, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_ele
type(ele_struct), target :: f_ele, f2_ele
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call ele_to_f (c_ele, c_loc(f_ele))

call set_ele_test_pattern (f2_ele, 2)
if (f_ele == f2_ele) then
  print *, '[2] ele: F side convert C->F: Good'
else
  print *, '[2] ele: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call ele_struct_to_json(f_ele, json_root)
  call json%print(json_root, 'test_f_ele_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call ele_struct_to_json(f2_ele, json_root)
  call json%print(json_root, 'test_f_ele_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_ele_pattern_2_*.json)'

endif

call set_ele_test_pattern (f2_ele, 3)
call ele_to_c (c_loc(f2_ele), c_ele)

! clean up test pattern data - < 3 deallocates arrays and such
call set_ele_test_pattern (f_ele, -1)
call set_ele_test_pattern (f2_ele, -1)

end subroutine test2_f_ele

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

recursive subroutine set_ele_test_pattern (F, ix_patt)

implicit none

type(ele_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%type)
  F%type(jd1:jd1) = char(ichar("a") + modulo(100+2+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%alias)
  F%alias(jd1:jd1) = char(ichar("a") + modulo(100+3+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%component_name)
  F%component_name(jd1:jd1) = char(ichar("a") + modulo(100+4+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_PTR_character] std::optional<string>
if (ix_patt < 3) then
  if (associated(F%descrip)) deallocate (F%descrip)
else
    if (.not. associated(F%descrip)) allocate (F%descrip)
    do jd1 = 1, len(F%descrip)
      F%descrip(jd1:jd1) = char(ichar("a") + modulo(100+5+offset+jd1, 26))
    enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%a, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%b, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%z, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_xy_disp
call set_xy_disp_test_pattern (F%x, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_xy_disp
call set_xy_disp_test_pattern (F%y, ix_patt)
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_ac_kicker>
if (ix_patt < 3) then
  if (associated(F%ac_kick)) then
    call set_ac_kicker_test_pattern (F%ac_kick, -1)
    deallocate (F%ac_kick)
  endif
else
  if (.not. associated(F%ac_kick)) allocate (F%ac_kick)
  rhs = 12 + offset
  call set_ac_kicker_test_pattern (F%ac_kick, ix_patt)
endif
!! f_side.test_pat[0D_NOT_type] CPP_bookkeeping_state
call set_bookkeeping_state_test_pattern (F%bookkeeping_state, ix_patt)
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_controller>
if (ix_patt < 3) then
  if (associated(F%control)) then
    call set_controller_test_pattern (F%control, -1)
    deallocate (F%control)
  endif
else
  if (.not. associated(F%control)) allocate (F%control)
  rhs = 15 + offset
  call set_controller_test_pattern (F%control, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_rf_ele>
if (ix_patt < 3) then
  if (associated(F%rf)) then
    call set_rf_ele_test_pattern (F%rf, -1)
    deallocate (F%rf)
  endif
else
  if (.not. associated(F%rf)) allocate (F%rf)
  rhs = 17 + offset
  call set_rf_ele_test_pattern (F%rf, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type]   std::optional<CPP_lat_ele_loc>
if (ix_patt < 3) then
  if (associated(F%lord)) then
    call set_ele_test_pattern (F%lord, -1)
    deallocate (F%lord)
  endif
else
  if (associated(F%lord)) deallocate (F%lord)
  allocate (F%lord)
  rhs = 19 + offset
  F%lord%ix_ele = 0;
  F%lord%ix_branch = 0;
  ! call set_ele_test_pattern (F%lord, 0) ! avoid infinite recursion

endif
!! f_side.test_pat[0D_NOT_type] CPP_floor_position
call set_floor_position_test_pattern (F%floor, ix_patt)
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_high_energy_space_charge>
if (ix_patt < 3) then
  if (associated(F%high_energy_space_charge)) then
    call set_high_energy_space_charge_test_pattern (F%high_energy_space_charge, -1)
    deallocate (F%high_energy_space_charge)
  endif
else
  if (.not. associated(F%high_energy_space_charge)) allocate (F%high_energy_space_charge)
  rhs = 22 + offset
  call set_high_energy_space_charge_test_pattern (F%high_energy_space_charge, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_mode3>
if (ix_patt < 3) then
  if (associated(F%mode3)) then
    call set_mode3_test_pattern (F%mode3, -1)
    deallocate (F%mode3)
  endif
else
  if (.not. associated(F%mode3)) allocate (F%mode3)
  rhs = 24 + offset
  call set_mode3_test_pattern (F%mode3, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_photon_element>
if (ix_patt < 3) then
  if (associated(F%photon)) then
    call set_photon_element_test_pattern (F%photon, -1)
    deallocate (F%photon)
  endif
else
  if (.not. associated(F%photon)) allocate (F%photon)
  rhs = 26 + offset
  call set_photon_element_test_pattern (F%photon, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_rad_map_ele>
if (ix_patt < 3) then
  if (associated(F%rad_map)) then
    call set_rad_map_ele_test_pattern (F%rad_map, -1)
    deallocate (F%rad_map)
  endif
else
  if (.not. associated(F%rad_map)) allocate (F%rad_map)
  rhs = 28 + offset
  call set_rad_map_ele_test_pattern (F%rad_map, ix_patt)
endif
!! f_side.test_pat[1D_NOT_type] FixedArray1D<CPP_taylor, 6>
if (ix_patt < 0) then
  ! pattern < 0 means clean up memory
  do jd1 = lbound(F%taylor,1), ubound(F%taylor,1)
    call set_taylor_test_pattern (F%taylor(jd1), -1)
  enddo
else
  do jd1 = 1, size(F%taylor,1)
    lb1 = lbound(F%taylor,1) - 1
    rhs = 100 + jd1 + 30 + offset
    call set_taylor_test_pattern (F%taylor(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%spin_taylor_ref_orb_in,1); lb1 = lbound(F%spin_taylor_ref_orb_in,1) - 1
  rhs = 100 + jd1 + 31 + offset
  F%spin_taylor_ref_orb_in(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_type] FixedArray1D<CPP_taylor, 4>
if (ix_patt < 0) then
  ! pattern < 0 means clean up memory
  do jd1 = lbound(F%spin_taylor,1), ubound(F%spin_taylor,1)
    call set_taylor_test_pattern (F%spin_taylor(jd1), -1)
  enddo
else
  do jd1 = 1, size(F%spin_taylor,1)
    lb1 = lbound(F%spin_taylor,1) - 1
    rhs = 100 + jd1 + 32 + offset
    call set_taylor_test_pattern (F%spin_taylor(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_wake>
if (ix_patt < 3) then
  if (associated(F%wake)) then
    call set_wake_test_pattern (F%wake, -1)
    deallocate (F%wake)
  endif
else
  if (.not. associated(F%wake)) allocate (F%wake)
  rhs = 33 + offset
  call set_wake_test_pattern (F%wake, ix_patt)
endif
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_wall3d>
if (ix_patt < 3) then
  if (associated(F%wall3d)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%wall3d,1), ubound(F%wall3d,1)
      call set_wall3d_test_pattern (F%wall3d(jd1), -1)
    enddo
    deallocate (F%wall3d)
  endif
else
  if (.not. associated(F%wall3d)) then
    allocate (F%wall3d(-1:1))
  endif
  do jd1 = 1, size(F%wall3d,1)
    lb1 = lbound(F%wall3d,1) - 1
    call set_wall3d_test_pattern (F%wall3d(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_cartesian_map>
if (ix_patt < 3) then
  if (associated(F%cartesian_map)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%cartesian_map,1), ubound(F%cartesian_map,1)
      call set_cartesian_map_test_pattern (F%cartesian_map(jd1), -1)
    enddo
    deallocate (F%cartesian_map)
  endif
else
  if (.not. associated(F%cartesian_map)) then
    allocate (F%cartesian_map(-1:1))
  endif
  do jd1 = 1, size(F%cartesian_map,1)
    lb1 = lbound(F%cartesian_map,1) - 1
    call set_cartesian_map_test_pattern (F%cartesian_map(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_cylindrical_map>
if (ix_patt < 3) then
  if (associated(F%cylindrical_map)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%cylindrical_map,1), ubound(F%cylindrical_map,1)
      call set_cylindrical_map_test_pattern (F%cylindrical_map(jd1), -1)
    enddo
    deallocate (F%cylindrical_map)
  endif
else
  if (.not. associated(F%cylindrical_map)) then
    allocate (F%cylindrical_map(-1:1))
  endif
  do jd1 = 1, size(F%cylindrical_map,1)
    lb1 = lbound(F%cylindrical_map,1) - 1
    call set_cylindrical_map_test_pattern (F%cylindrical_map(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_gen_grad_map>
if (ix_patt < 3) then
  if (associated(F%gen_grad_map)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%gen_grad_map,1), ubound(F%gen_grad_map,1)
      call set_gen_grad_map_test_pattern (F%gen_grad_map(jd1), -1)
    enddo
    deallocate (F%gen_grad_map)
  endif
else
  if (.not. associated(F%gen_grad_map)) then
    allocate (F%gen_grad_map(-1:1))
  endif
  do jd1 = 1, size(F%gen_grad_map,1)
    lb1 = lbound(F%gen_grad_map,1) - 1
    call set_gen_grad_map_test_pattern (F%gen_grad_map(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_grid_field>
if (ix_patt < 3) then
  if (associated(F%grid_field)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%grid_field,1), ubound(F%grid_field,1)
      call set_grid_field_test_pattern (F%grid_field(jd1), -1)
    enddo
    deallocate (F%grid_field)
  endif
else
  if (.not. associated(F%grid_field)) then
    allocate (F%grid_field(-1:1))
  endif
  do jd1 = 1, size(F%grid_field,1)
    lb1 = lbound(F%grid_field,1) - 1
    call set_grid_field_test_pattern (F%grid_field(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%map_ref_orb_in, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%map_ref_orb_out, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%time_ref_orb_in, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%time_ref_orb_out, ix_patt)
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, Bmad::NUM_ELE_ATTRIB+1>
do jd1 = 1, size(F%value,1); lb1 = lbound(F%value,1) - 1
  rhs = 100 + jd1 + 49 + offset
  F%value(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, Bmad::NUM_ELE_ATTRIB+1>
do jd1 = 1, size(F%old_value,1); lb1 = lbound(F%old_value,1) - 1
  rhs = 100 + jd1 + 50 + offset
  F%old_value(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 4, 7>
do jd1 = 1, size(F%spin_q,1); lb1 = lbound(F%spin_q,1) - 1
  do jd2 = 1, size(F%spin_q,2); lb2 = lbound(F%spin_q,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 51 + offset
    F%spin_q(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 6>
do jd1 = 1, size(F%vec0,1); lb1 = lbound(F%vec0,1) - 1
  rhs = 100 + jd1 + 52 + offset
  F%vec0(jd1+lb1) = rhs
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%mat6,1); lb1 = lbound(F%mat6,1) - 1
  do jd2 = 1, size(F%mat6,2); lb2 = lbound(F%mat6,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 53 + offset
    F%mat6(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 2, 2>
do jd1 = 1, size(F%c_mat,1); lb1 = lbound(F%c_mat,1) - 1
  do jd2 = 1, size(F%c_mat,2); lb2 = lbound(F%c_mat,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 54 + offset
    F%c_mat(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 55 + offset; F%gamma_c = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 56 + offset; F%s_start = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 57 + offset; F%s = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 58 + offset; F%ref_time = rhs
!! f_side.test_pat[1D_PTR_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (associated(F%a_pole)) then
     deallocate (F%a_pole)
  endif
else
  if (.not. associated(F%a_pole)) then
    allocate (F%a_pole(-1:1))
  endif
  do jd1 = 1, size(F%a_pole,1)
    lb1 = lbound(F%a_pole,1) - 1
    rhs = 100 + jd1 + 59 + offset
    F%a_pole(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_PTR_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (associated(F%b_pole)) then
     deallocate (F%b_pole)
  endif
else
  if (.not. associated(F%b_pole)) then
    allocate (F%b_pole(-1:1))
  endif
  do jd1 = 1, size(F%b_pole,1)
    lb1 = lbound(F%b_pole,1) - 1
    rhs = 100 + jd1 + 61 + offset
    F%b_pole(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_PTR_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (associated(F%a_pole_elec)) then
     deallocate (F%a_pole_elec)
  endif
else
  if (.not. associated(F%a_pole_elec)) then
    allocate (F%a_pole_elec(-1:1))
  endif
  do jd1 = 1, size(F%a_pole_elec,1)
    lb1 = lbound(F%a_pole_elec,1) - 1
    rhs = 100 + jd1 + 63 + offset
    F%a_pole_elec(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_PTR_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (associated(F%b_pole_elec)) then
     deallocate (F%b_pole_elec)
  endif
else
  if (.not. associated(F%b_pole_elec)) then
    allocate (F%b_pole_elec(-1:1))
  endif
  do jd1 = 1, size(F%b_pole_elec,1)
    lb1 = lbound(F%b_pole_elec,1) - 1
    rhs = 100 + jd1 + 65 + offset
    F%b_pole_elec(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[1D_PTR_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (associated(F%custom)) then
     deallocate (F%custom)
  endif
else
  if (.not. associated(F%custom)) then
    allocate (F%custom(-1:1))
  endif
  do jd1 = 1, size(F%custom,1)
    lb1 = lbound(F%custom,1) - 1
    rhs = 100 + jd1 + 67 + offset
    F%custom(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[3D_PTR_real] VariableArray3D<Real>
if (ix_patt < 3) then
  if (associated(F%r)) deallocate (F%r)
else
  if (.not. associated(F%r)) allocate (F%r(-1:1, 2, 1))
  do jd1 = 1, size(F%r,1); lb1 = lbound(F%r,1) - 1
    do jd2 = 1, size(F%r,2); lb2 = lbound(F%r,2) - 1
      do jd3 = 1, size(F%r,3); lb3 = lbound(F%r,3) - 1
        rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 69 + offset
        F%r(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
      enddo
    enddo
  enddo
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 73 + offset; F%key = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 74 + offset; F%sub_key = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 75 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 76 + offset; F%ix_branch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 77 + offset; F%lord_status = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 78 + offset; F%n_slave = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 79 + offset; F%n_slave_field = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 80 + offset; F%ix1_slave = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 81 + offset; F%slave_status = rhs
!! f_side.test_pat[0D_NOT_integer] Int
if (ix_patt < 3) then
  F%n_lord = 0
else
  F%n_lord = 1
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 83 + offset; F%n_lord_field = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 84 + offset; F%n_lord_ramper = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 85 + offset; F%ic1_lord = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 86 + offset; F%ix_pointer = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 87 + offset; F%ixx = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 88 + offset; F%iyy = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 89 + offset; F%izz = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 90 + offset; F%mat6_calc_method = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 91 + offset; F%tracking_method = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 92 + offset; F%spin_tracking_method = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 93 + offset; F%csr_method = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 94 + offset; F%space_charge_method = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 95 + offset; F%ptc_integration_type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 96 + offset; F%field_calc = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 97 + offset; F%aperture_at = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 98 + offset; F%aperture_type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 99 + offset; F%ref_species = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 100 + offset; F%orientation = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 101 + offset; F%symplectify = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 102 + offset; F%mode_flip = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 103 + offset; F%multipoles_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 104 + offset; F%scale_multipoles = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 105 + offset; F%taylor_map_includes_offsets = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 106 + offset; F%field_master = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 107 + offset; F%is_on = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 108 + offset; F%logic = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 109 + offset; F%bmad_logic = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 110 + offset; F%select = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 111 + offset; F%offset_moves_aperture = (modulo(rhs, 2) == 0)

end subroutine set_ele_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_complex_taylor_term (ok)

implicit none

type(complex_taylor_term_struct), target :: f_complex_taylor_term, f2_complex_taylor_term

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_complex_taylor_term (c_complex_taylor_term, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_complex_taylor_term
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_complex_taylor_term_test_pattern (f2_complex_taylor_term, 1)

call test_c_complex_taylor_term(c_loc(f2_complex_taylor_term), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_complex_taylor_term_test_pattern (f_complex_taylor_term, 4)
if (f_complex_taylor_term == f2_complex_taylor_term) then
  print *, '[4] complex_taylor_term: C side convert C->F: Good'
else
  print *, '[4] complex_taylor_term: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call complex_taylor_term_struct_to_json(f_complex_taylor_term, json_root)
  call json%print(json_root, 'test_f_complex_taylor_term_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call complex_taylor_term_struct_to_json(f2_complex_taylor_term, json_root)
  call json%print(json_root, 'test_f_complex_taylor_term_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_complex_taylor_term_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_complex_taylor_term_test_pattern (f_complex_taylor_term, -1)
call set_complex_taylor_term_test_pattern (f2_complex_taylor_term, -1)

end subroutine test1_f_complex_taylor_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_complex_taylor_term (c_complex_taylor_term, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_complex_taylor_term
type(complex_taylor_term_struct), target :: f_complex_taylor_term, f2_complex_taylor_term
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call complex_taylor_term_to_f (c_complex_taylor_term, c_loc(f_complex_taylor_term))

call set_complex_taylor_term_test_pattern (f2_complex_taylor_term, 2)
if (f_complex_taylor_term == f2_complex_taylor_term) then
  print *, '[2] complex_taylor_term: F side convert C->F: Good'
else
  print *, '[2] complex_taylor_term: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call complex_taylor_term_struct_to_json(f_complex_taylor_term, json_root)
  call json%print(json_root, 'test_f_complex_taylor_term_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call complex_taylor_term_struct_to_json(f2_complex_taylor_term, json_root)
  call json%print(json_root, 'test_f_complex_taylor_term_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_complex_taylor_term_pattern_2_*.json)'

endif

call set_complex_taylor_term_test_pattern (f2_complex_taylor_term, 3)
call complex_taylor_term_to_c (c_loc(f2_complex_taylor_term), c_complex_taylor_term)

! clean up test pattern data - < 3 deallocates arrays and such
call set_complex_taylor_term_test_pattern (f_complex_taylor_term, -1)
call set_complex_taylor_term_test_pattern (f2_complex_taylor_term, -1)

end subroutine test2_f_complex_taylor_term

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_complex_taylor_term_test_pattern (F, ix_patt)

implicit none

type(complex_taylor_term_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 1 + offset; F%coef = cmplx(rhs, 100+rhs)
!! f_side.test_pat[1D_NOT_integer] FixedArray1D<Int, 6>
do jd1 = 1, size(F%expn,1); lb1 = lbound(F%expn,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%expn(jd1+lb1) = rhs
enddo

end subroutine set_complex_taylor_term_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_complex_taylor (ok)

implicit none

type(complex_taylor_struct), target :: f_complex_taylor, f2_complex_taylor

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_complex_taylor (c_complex_taylor, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_complex_taylor
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_complex_taylor_test_pattern (f2_complex_taylor, 1)

call test_c_complex_taylor(c_loc(f2_complex_taylor), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_complex_taylor_test_pattern (f_complex_taylor, 4)
if (f_complex_taylor == f2_complex_taylor) then
  print *, '[4] complex_taylor: C side convert C->F: Good'
else
  print *, '[4] complex_taylor: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call complex_taylor_struct_to_json(f_complex_taylor, json_root)
  call json%print(json_root, 'test_f_complex_taylor_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call complex_taylor_struct_to_json(f2_complex_taylor, json_root)
  call json%print(json_root, 'test_f_complex_taylor_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_complex_taylor_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_complex_taylor_test_pattern (f_complex_taylor, -1)
call set_complex_taylor_test_pattern (f2_complex_taylor, -1)

end subroutine test1_f_complex_taylor

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_complex_taylor (c_complex_taylor, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_complex_taylor
type(complex_taylor_struct), target :: f_complex_taylor, f2_complex_taylor
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call complex_taylor_to_f (c_complex_taylor, c_loc(f_complex_taylor))

call set_complex_taylor_test_pattern (f2_complex_taylor, 2)
if (f_complex_taylor == f2_complex_taylor) then
  print *, '[2] complex_taylor: F side convert C->F: Good'
else
  print *, '[2] complex_taylor: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call complex_taylor_struct_to_json(f_complex_taylor, json_root)
  call json%print(json_root, 'test_f_complex_taylor_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call complex_taylor_struct_to_json(f2_complex_taylor, json_root)
  call json%print(json_root, 'test_f_complex_taylor_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_complex_taylor_pattern_2_*.json)'

endif

call set_complex_taylor_test_pattern (f2_complex_taylor, 3)
call complex_taylor_to_c (c_loc(f2_complex_taylor), c_complex_taylor)

! clean up test pattern data - < 3 deallocates arrays and such
call set_complex_taylor_test_pattern (f_complex_taylor, -1)
call set_complex_taylor_test_pattern (f2_complex_taylor, -1)

end subroutine test2_f_complex_taylor

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_complex_taylor_test_pattern (F, ix_patt)

implicit none

type(complex_taylor_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_complex] Complex
rhs = 1 + offset; F%ref = cmplx(rhs, 100+rhs)
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_complex_taylor_term>
if (ix_patt < 3) then
  if (associated(F%term)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%term,1), ubound(F%term,1)
      call set_complex_taylor_term_test_pattern (F%term(jd1), -1)
    enddo
    deallocate (F%term)
  endif
else
  if (.not. associated(F%term)) then
    allocate (F%term(-1:1))
  endif
  do jd1 = 1, size(F%term,1)
    lb1 = lbound(F%term,1) - 1
    call set_complex_taylor_term_test_pattern (F%term(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_complex_taylor_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_branch (ok)

implicit none

type(branch_struct), target :: f_branch, f2_branch

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_branch (c_branch, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_branch
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_branch_test_pattern (f2_branch, 1)

call test_c_branch(c_loc(f2_branch), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_branch_test_pattern (f_branch, 4)
if (f_branch == f2_branch) then
  print *, '[4] branch: C side convert C->F: Good'
else
  print *, '[4] branch: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call branch_struct_to_json(f_branch, json_root)
  call json%print(json_root, 'test_f_branch_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call branch_struct_to_json(f2_branch, json_root)
  call json%print(json_root, 'test_f_branch_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_branch_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_branch_test_pattern (f_branch, -1)
call set_branch_test_pattern (f2_branch, -1)

end subroutine test1_f_branch

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_branch (c_branch, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_branch
type(branch_struct), target :: f_branch, f2_branch
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call branch_to_f (c_branch, c_loc(f_branch))

call set_branch_test_pattern (f2_branch, 2)
if (f_branch == f2_branch) then
  print *, '[2] branch: F side convert C->F: Good'
else
  print *, '[2] branch: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call branch_struct_to_json(f_branch, json_root)
  call json%print(json_root, 'test_f_branch_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call branch_struct_to_json(f2_branch, json_root)
  call json%print(json_root, 'test_f_branch_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_branch_pattern_2_*.json)'

endif

call set_branch_test_pattern (f2_branch, 3)
call branch_to_c (c_loc(f2_branch), c_branch)

! clean up test pattern data - < 3 deallocates arrays and such
call set_branch_test_pattern (f_branch, -1)
call set_branch_test_pattern (f2_branch, -1)

end subroutine test2_f_branch

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_branch_test_pattern (F, ix_patt)

implicit none

type(branch_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%name)
  F%name(jd1:jd1) = char(ichar("a") + modulo(100+1+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 2 + offset; F%ix_branch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%ix_from_branch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%ix_from_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%ix_to_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 6 + offset; F%ix_fixer = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 7 + offset; F%n_ele_track = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 8 + offset; F%n_ele_max = rhs
!! f_side.test_pat[0D_NOT_type] CPP_mode_info
call set_mode_info_test_pattern (F%a, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_mode_info
call set_mode_info_test_pattern (F%b, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_mode_info
call set_mode_info_test_pattern (F%z, ix_patt)
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_ele>
if (ix_patt < 3) then
  if (associated(F%ele)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%ele,1), ubound(F%ele,1)
      call set_ele_test_pattern (F%ele(jd1), -1)
    enddo
    deallocate (F%ele)
  endif
else
  if (.not. associated(F%ele)) then
    allocate (F%ele(-1:1))
  endif
  do jd1 = 1, size(F%ele,1)
    lb1 = lbound(F%ele,1) - 1
    call set_ele_test_pattern (F%ele(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_lat_param
call set_lat_param_test_pattern (F%param, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%particle_start, ix_patt)
!! f_side.test_pat[1D_PTR_type] VariableArray1D<CPP_wall3d>
if (ix_patt < 3) then
  if (associated(F%wall3d)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%wall3d,1), ubound(F%wall3d,1)
      call set_wall3d_test_pattern (F%wall3d(jd1), -1)
    enddo
    deallocate (F%wall3d)
  endif
else
  if (.not. associated(F%wall3d)) then
    allocate (F%wall3d(-1:1))
  endif
  do jd1 = 1, size(F%wall3d,1)
    lb1 = lbound(F%wall3d,1) - 1
    call set_wall3d_test_pattern (F%wall3d(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_branch_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_lat (ok)

implicit none

type(lat_struct), target :: f_lat, f2_lat

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_lat (c_lat, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_lat
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_lat_test_pattern (f2_lat, 1)

call test_c_lat(c_loc(f2_lat), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_lat_test_pattern (f_lat, 4)
if (f_lat == f2_lat) then
  print *, '[4] lat: C side convert C->F: Good'
else
  print *, '[4] lat: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call lat_struct_to_json(f_lat, json_root)
  call json%print(json_root, 'test_f_lat_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call lat_struct_to_json(f2_lat, json_root)
  call json%print(json_root, 'test_f_lat_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_lat_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_lat_test_pattern (f_lat, -1)
call set_lat_test_pattern (f2_lat, -1)

end subroutine test1_f_lat

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_lat (c_lat, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_lat
type(lat_struct), target :: f_lat, f2_lat
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call lat_to_f (c_lat, c_loc(f_lat))

call set_lat_test_pattern (f2_lat, 2)
if (f_lat == f2_lat) then
  print *, '[2] lat: F side convert C->F: Good'
else
  print *, '[2] lat: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call lat_struct_to_json(f_lat, json_root)
  call json%print(json_root, 'test_f_lat_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call lat_struct_to_json(f2_lat, json_root)
  call json%print(json_root, 'test_f_lat_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_lat_pattern_2_*.json)'

endif

call set_lat_test_pattern (f2_lat, 3)
call lat_to_c (c_loc(f2_lat), c_lat)

! clean up test pattern data - < 3 deallocates arrays and such
call set_lat_test_pattern (f_lat, -1)
call set_lat_test_pattern (f2_lat, -1)

end subroutine test2_f_lat

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_lat_test_pattern (F, ix_patt)

implicit none

type(lat_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_character] string
  ! magic string to opt-out of lattice finalization
  F%use_name = 'TEST-LATTICE-FROM-TEST-SUITE'
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%lattice)
  F%lattice(jd1:jd1) = char(ichar("a") + modulo(100+2+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%machine)
  F%machine(jd1:jd1) = char(ichar("a") + modulo(100+3+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%input_file_name)
  F%input_file_name(jd1:jd1) = char(ichar("a") + modulo(100+4+offset+jd1, 26))
enddo
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%title)
  F%title(jd1:jd1) = char(ichar("a") + modulo(100+5+offset+jd1, 26))
enddo
!! f_side.test_pat[1D_ALLOC_character] VariableArray1D<string>
if (ix_patt < 3) then
  if (allocated(F%print_str)) deallocate (F%print_str)
else
  if (.not. allocated(F%print_str)) allocate (F%print_str(3))
  do jd1 = 1, 3
    do jd = 1, len(F%print_str)
      F%print_str(jd1)(jd:jd) = char(ichar("a") + modulo(100+6+offset+10*jd+jd1, 26))
    enddo
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_expression_atom>
if (ix_patt < 3) then
  if (allocated(F%constant)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%constant,1), ubound(F%constant,1)
      call set_expression_atom_test_pattern (F%constant(jd1), -1)
    enddo
    deallocate (F%constant)
  endif
else
  if (.not. allocated(F%constant)) then
    allocate (F%constant(-1:1))
  endif
  do jd1 = 1, size(F%constant,1)
    lb1 = lbound(F%constant,1) - 1
    call set_expression_atom_test_pattern (F%constant(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_mode_info>
if (ix_patt < 3) then
  if (associated(F%a)) then
    call set_mode_info_test_pattern (F%a, -1)
    deallocate (F%a)
  endif
else
  if (.not. associated(F%a)) allocate (F%a)
  rhs = 10 + offset
  call set_mode_info_test_pattern (F%a, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_mode_info>
if (ix_patt < 3) then
  if (associated(F%b)) then
    call set_mode_info_test_pattern (F%b, -1)
    deallocate (F%b)
  endif
else
  if (.not. associated(F%b)) allocate (F%b)
  rhs = 12 + offset
  call set_mode_info_test_pattern (F%b, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_mode_info>
if (ix_patt < 3) then
  if (associated(F%z)) then
    call set_mode_info_test_pattern (F%z, -1)
    deallocate (F%z)
  endif
else
  if (.not. associated(F%z)) allocate (F%z)
  rhs = 14 + offset
  call set_mode_info_test_pattern (F%z, ix_patt)
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_lat_param>
if (ix_patt < 3) then
  if (associated(F%param)) then
    call set_lat_param_test_pattern (F%param, -1)
    deallocate (F%param)
  endif
else
  if (.not. associated(F%param)) allocate (F%param)
  rhs = 16 + offset
  call set_lat_param_test_pattern (F%param, ix_patt)
endif
!! f_side.test_pat[0D_NOT_type] CPP_bookkeeping_state
call set_bookkeeping_state_test_pattern (F%lord_state, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_ele
call set_ele_test_pattern (F%ele_init, ix_patt)
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_branch>
if (ix_patt < 3) then
  if (allocated(F%branch)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%branch,1), ubound(F%branch,1)
      call set_branch_test_pattern (F%branch(jd1), -1)
    enddo
    deallocate (F%branch)
  endif
else
  if (.not. allocated(F%branch)) then
    allocate (F%branch(-1:1))
  endif
  do jd1 = 1, size(F%branch,1)
    lb1 = lbound(F%branch,1) - 1
    call set_branch_test_pattern (F%branch(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_control>
if (ix_patt < 3) then
  if (allocated(F%control)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%control,1), ubound(F%control,1)
      call set_control_test_pattern (F%control(jd1), -1)
    enddo
    deallocate (F%control)
  endif
else
  if (.not. allocated(F%control)) then
    allocate (F%control(-1:1))
  endif
  do jd1 = 1, size(F%control,1)
    lb1 = lbound(F%control,1) - 1
    call set_control_test_pattern (F%control(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_PTR_type] std::optional<CPP_coord>
if (ix_patt < 3) then
  if (associated(F%particle_start)) then
    call set_coord_test_pattern (F%particle_start, -1)
    deallocate (F%particle_start)
  endif
else
  if (.not. associated(F%particle_start)) allocate (F%particle_start)
  rhs = 24 + offset
  call set_coord_test_pattern (F%particle_start, ix_patt)
endif
!! f_side.test_pat[0D_NOT_type] CPP_beam_init
call set_beam_init_test_pattern (F%beam_init, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_pre_tracker
call set_pre_tracker_test_pattern (F%pre_tracker, ix_patt)
!! f_side.test_pat[1D_ALLOC_real] VariableArray1D<Real>
if (ix_patt < 3) then
  if (allocated(F%custom)) then
     deallocate (F%custom)
  endif
else
  if (.not. allocated(F%custom)) then
    allocate (F%custom(-1:1))
  endif
  do jd1 = 1, size(F%custom,1)
    lb1 = lbound(F%custom,1) - 1
    rhs = 100 + jd1 + 28 + offset
    F%custom(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 30 + offset; F%version = rhs
!! f_side.test_pat[0D_PTR_integer] std::optional<Int>
if (ix_patt < 3) then
  if (associated(F%n_ele_track)) deallocate (F%n_ele_track)
else
  if (.not. associated(F%n_ele_track)) allocate (F%n_ele_track)
  rhs = 31 + offset
  F%n_ele_track = rhs
endif
!! f_side.test_pat[0D_PTR_integer] std::optional<Int>
if (ix_patt < 3) then
  if (associated(F%n_ele_max)) deallocate (F%n_ele_max)
else
  if (.not. associated(F%n_ele_max)) allocate (F%n_ele_max)
  rhs = 33 + offset
  F%n_ele_max = rhs
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 35 + offset; F%n_control_max = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 36 + offset; F%n_ic_max = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 37 + offset; F%input_taylor_order = rhs
!! f_side.test_pat[1D_ALLOC_integer] VariableArray1D<Int>
if (ix_patt < 3) then
  if (allocated(F%ic)) then
     deallocate (F%ic)
  endif
else
  if (.not. allocated(F%ic)) then
    allocate (F%ic(-1:1))
  endif
  do jd1 = 1, size(F%ic,1)
    lb1 = lbound(F%ic,1) - 1
    rhs = 100 + jd1 + 38 + offset
    F%ic(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 40 + offset; F%photon_type = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 41 + offset; F%creation_hash = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 42 + offset; F%ramper_slave_bookkeeping = rhs

end subroutine set_lat_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_bunch (ok)

implicit none

type(bunch_struct), target :: f_bunch, f2_bunch

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_bunch (c_bunch, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_bunch
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_bunch_test_pattern (f2_bunch, 1)

call test_c_bunch(c_loc(f2_bunch), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_bunch_test_pattern (f_bunch, 4)
if (f_bunch == f2_bunch) then
  print *, '[4] bunch: C side convert C->F: Good'
else
  print *, '[4] bunch: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call bunch_struct_to_json(f_bunch, json_root)
  call json%print(json_root, 'test_f_bunch_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bunch_struct_to_json(f2_bunch, json_root)
  call json%print(json_root, 'test_f_bunch_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bunch_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_bunch_test_pattern (f_bunch, -1)
call set_bunch_test_pattern (f2_bunch, -1)

end subroutine test1_f_bunch

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_bunch (c_bunch, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_bunch
type(bunch_struct), target :: f_bunch, f2_bunch
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call bunch_to_f (c_bunch, c_loc(f_bunch))

call set_bunch_test_pattern (f2_bunch, 2)
if (f_bunch == f2_bunch) then
  print *, '[2] bunch: F side convert C->F: Good'
else
  print *, '[2] bunch: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call bunch_struct_to_json(f_bunch, json_root)
  call json%print(json_root, 'test_f_bunch_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bunch_struct_to_json(f2_bunch, json_root)
  call json%print(json_root, 'test_f_bunch_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bunch_pattern_2_*.json)'

endif

call set_bunch_test_pattern (f2_bunch, 3)
call bunch_to_c (c_loc(f2_bunch), c_bunch)

! clean up test pattern data - < 3 deallocates arrays and such
call set_bunch_test_pattern (f_bunch, -1)
call set_bunch_test_pattern (f2_bunch, -1)

end subroutine test2_f_bunch

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_bunch_test_pattern (F, ix_patt)

implicit none

type(bunch_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_coord>
if (ix_patt < 3) then
  if (allocated(F%particle)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%particle,1), ubound(F%particle,1)
      call set_coord_test_pattern (F%particle(jd1), -1)
    enddo
    deallocate (F%particle)
  endif
else
  if (.not. allocated(F%particle)) then
    allocate (F%particle(-1:1))
  endif
  do jd1 = 1, size(F%particle,1)
    lb1 = lbound(F%particle,1) - 1
    call set_coord_test_pattern (F%particle(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[1D_ALLOC_integer] VariableArray1D<Int>
if (ix_patt < 3) then
  if (allocated(F%ix_z)) then
     deallocate (F%ix_z)
  endif
else
  if (.not. allocated(F%ix_z)) then
    allocate (F%ix_z(-1:1))
  endif
  do jd1 = 1, size(F%ix_z,1)
    lb1 = lbound(F%ix_z,1) - 1
    rhs = 100 + jd1 + 3 + offset
    F%ix_z(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%charge_tot = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%charge_live = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%z_center = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%t_center = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 9 + offset; F%t0 = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 10 + offset; F%drift_between_t_and_s = (modulo(rhs, 2) == 0)
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 11 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 12 + offset; F%ix_bunch = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 13 + offset; F%ix_turn = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 14 + offset; F%n_live = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 15 + offset; F%n_good = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 16 + offset; F%n_bad = rhs

end subroutine set_bunch_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_bunch_params (ok)

implicit none

type(bunch_params_struct), target :: f_bunch_params, f2_bunch_params

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_bunch_params (c_bunch_params, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_bunch_params
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_bunch_params_test_pattern (f2_bunch_params, 1)

call test_c_bunch_params(c_loc(f2_bunch_params), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_bunch_params_test_pattern (f_bunch_params, 4)
if (f_bunch_params == f2_bunch_params) then
  print *, '[4] bunch_params: C side convert C->F: Good'
else
  print *, '[4] bunch_params: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call bunch_params_struct_to_json(f_bunch_params, json_root)
  call json%print(json_root, 'test_f_bunch_params_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bunch_params_struct_to_json(f2_bunch_params, json_root)
  call json%print(json_root, 'test_f_bunch_params_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bunch_params_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_bunch_params_test_pattern (f_bunch_params, -1)
call set_bunch_params_test_pattern (f2_bunch_params, -1)

end subroutine test1_f_bunch_params

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_bunch_params (c_bunch_params, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_bunch_params
type(bunch_params_struct), target :: f_bunch_params, f2_bunch_params
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call bunch_params_to_f (c_bunch_params, c_loc(f_bunch_params))

call set_bunch_params_test_pattern (f2_bunch_params, 2)
if (f_bunch_params == f2_bunch_params) then
  print *, '[2] bunch_params: F side convert C->F: Good'
else
  print *, '[2] bunch_params: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call bunch_params_struct_to_json(f_bunch_params, json_root)
  call json%print(json_root, 'test_f_bunch_params_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call bunch_params_struct_to_json(f2_bunch_params, json_root)
  call json%print(json_root, 'test_f_bunch_params_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_bunch_params_pattern_2_*.json)'

endif

call set_bunch_params_test_pattern (f2_bunch_params, 3)
call bunch_params_to_c (c_loc(f2_bunch_params), c_bunch_params)

! clean up test pattern data - < 3 deallocates arrays and such
call set_bunch_params_test_pattern (f_bunch_params, -1)
call set_bunch_params_test_pattern (f2_bunch_params, -1)

end subroutine test2_f_bunch_params

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_bunch_params_test_pattern (F, ix_patt)

implicit none

type(bunch_params_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%centroid, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%x, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%y, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%z, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%a, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%b, ix_patt)
!! f_side.test_pat[0D_NOT_type] CPP_twiss
call set_twiss_test_pattern (F%c, ix_patt)
!! f_side.test_pat[2D_NOT_real] FixedArray2D<Real, 6, 6>
do jd1 = 1, size(F%sigma,1); lb1 = lbound(F%sigma,1) - 1
  do jd2 = 1, size(F%sigma,2); lb2 = lbound(F%sigma,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 8 + offset
    F%sigma(jd1+lb1,jd2+lb2) = rhs
  enddo
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 7>
do jd1 = 1, size(F%rel_max,1); lb1 = lbound(F%rel_max,1) - 1
  rhs = 100 + jd1 + 9 + offset
  F%rel_max(jd1+lb1) = rhs
enddo
!! f_side.test_pat[1D_NOT_real] FixedArray1D<Real, 7>
do jd1 = 1, size(F%rel_min,1); lb1 = lbound(F%rel_min,1) - 1
  rhs = 100 + jd1 + 10 + offset
  F%rel_min(jd1+lb1) = rhs
enddo
!! f_side.test_pat[0D_NOT_real] Real
rhs = 11 + offset; F%s = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 12 + offset; F%t = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 13 + offset; F%sigma_t = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 14 + offset; F%charge_live = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 15 + offset; F%charge_tot = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 16 + offset; F%n_particle_tot = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 17 + offset; F%n_particle_live = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 18 + offset; F%n_particle_lost_in_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 19 + offset; F%n_good_steps = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 20 + offset; F%n_bad_steps = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 21 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 22 + offset; F%location = rhs
!! f_side.test_pat[0D_NOT_logical] Bool
rhs = 23 + offset; F%twiss_valid = (modulo(rhs, 2) == 0)

end subroutine set_bunch_params_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_beam (ok)

implicit none

type(beam_struct), target :: f_beam, f2_beam

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_beam (c_beam, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_beam
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_beam_test_pattern (f2_beam, 1)

call test_c_beam(c_loc(f2_beam), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_beam_test_pattern (f_beam, 4)
if (f_beam == f2_beam) then
  print *, '[4] beam: C side convert C->F: Good'
else
  print *, '[4] beam: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call beam_struct_to_json(f_beam, json_root)
  call json%print(json_root, 'test_f_beam_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call beam_struct_to_json(f2_beam, json_root)
  call json%print(json_root, 'test_f_beam_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_beam_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_beam_test_pattern (f_beam, -1)
call set_beam_test_pattern (f2_beam, -1)

end subroutine test1_f_beam

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_beam (c_beam, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_beam
type(beam_struct), target :: f_beam, f2_beam
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call beam_to_f (c_beam, c_loc(f_beam))

call set_beam_test_pattern (f2_beam, 2)
if (f_beam == f2_beam) then
  print *, '[2] beam: F side convert C->F: Good'
else
  print *, '[2] beam: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call beam_struct_to_json(f_beam, json_root)
  call json%print(json_root, 'test_f_beam_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call beam_struct_to_json(f2_beam, json_root)
  call json%print(json_root, 'test_f_beam_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_beam_pattern_2_*.json)'

endif

call set_beam_test_pattern (f2_beam, 3)
call beam_to_c (c_loc(f2_beam), c_beam)

! clean up test pattern data - < 3 deallocates arrays and such
call set_beam_test_pattern (f_beam, -1)
call set_beam_test_pattern (f2_beam, -1)

end subroutine test2_f_beam

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_beam_test_pattern (F, ix_patt)

implicit none

type(beam_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_bunch>
if (ix_patt < 3) then
  if (allocated(F%bunch)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%bunch,1), ubound(F%bunch,1)
      call set_bunch_test_pattern (F%bunch(jd1), -1)
    enddo
    deallocate (F%bunch)
  endif
else
  if (.not. allocated(F%bunch)) then
    allocate (F%bunch(-1:1))
  endif
  do jd1 = 1, size(F%bunch,1)
    lb1 = lbound(F%bunch,1) - 1
    call set_bunch_test_pattern (F%bunch(jd1+lb1), ix_patt+jd1)
  enddo
endif

end subroutine set_beam_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_aperture_point (ok)

implicit none

type(aperture_point_struct), target :: f_aperture_point, f2_aperture_point

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_aperture_point (c_aperture_point, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_aperture_point
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_aperture_point_test_pattern (f2_aperture_point, 1)

call test_c_aperture_point(c_loc(f2_aperture_point), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_aperture_point_test_pattern (f_aperture_point, 4)
if (f_aperture_point == f2_aperture_point) then
  print *, '[4] aperture_point: C side convert C->F: Good'
else
  print *, '[4] aperture_point: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call aperture_point_struct_to_json(f_aperture_point, json_root)
  call json%print(json_root, 'test_f_aperture_point_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call aperture_point_struct_to_json(f2_aperture_point, json_root)
  call json%print(json_root, 'test_f_aperture_point_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_aperture_point_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_aperture_point_test_pattern (f_aperture_point, -1)
call set_aperture_point_test_pattern (f2_aperture_point, -1)

end subroutine test1_f_aperture_point

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_aperture_point (c_aperture_point, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_aperture_point
type(aperture_point_struct), target :: f_aperture_point, f2_aperture_point
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call aperture_point_to_f (c_aperture_point, c_loc(f_aperture_point))

call set_aperture_point_test_pattern (f2_aperture_point, 2)
if (f_aperture_point == f2_aperture_point) then
  print *, '[2] aperture_point: F side convert C->F: Good'
else
  print *, '[2] aperture_point: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call aperture_point_struct_to_json(f_aperture_point, json_root)
  call json%print(json_root, 'test_f_aperture_point_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call aperture_point_struct_to_json(f2_aperture_point, json_root)
  call json%print(json_root, 'test_f_aperture_point_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_aperture_point_pattern_2_*.json)'

endif

call set_aperture_point_test_pattern (f2_aperture_point, 3)
call aperture_point_to_c (c_loc(f2_aperture_point), c_aperture_point)

! clean up test pattern data - < 3 deallocates arrays and such
call set_aperture_point_test_pattern (f_aperture_point, -1)
call set_aperture_point_test_pattern (f2_aperture_point, -1)

end subroutine test2_f_aperture_point

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_aperture_point_test_pattern (F, ix_patt)

implicit none

type(aperture_point_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%x = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%y = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%plane = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%ix_ele = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 5 + offset; F%i_turn = rhs

end subroutine set_aperture_point_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_aperture_param (ok)

implicit none

type(aperture_param_struct), target :: f_aperture_param, f2_aperture_param

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_aperture_param (c_aperture_param, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_aperture_param
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_aperture_param_test_pattern (f2_aperture_param, 1)

call test_c_aperture_param(c_loc(f2_aperture_param), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_aperture_param_test_pattern (f_aperture_param, 4)
if (f_aperture_param == f2_aperture_param) then
  print *, '[4] aperture_param: C side convert C->F: Good'
else
  print *, '[4] aperture_param: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call aperture_param_struct_to_json(f_aperture_param, json_root)
  call json%print(json_root, 'test_f_aperture_param_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call aperture_param_struct_to_json(f2_aperture_param, json_root)
  call json%print(json_root, 'test_f_aperture_param_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_aperture_param_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_aperture_param_test_pattern (f_aperture_param, -1)
call set_aperture_param_test_pattern (f2_aperture_param, -1)

end subroutine test1_f_aperture_param

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_aperture_param (c_aperture_param, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_aperture_param
type(aperture_param_struct), target :: f_aperture_param, f2_aperture_param
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call aperture_param_to_f (c_aperture_param, c_loc(f_aperture_param))

call set_aperture_param_test_pattern (f2_aperture_param, 2)
if (f_aperture_param == f2_aperture_param) then
  print *, '[2] aperture_param: F side convert C->F: Good'
else
  print *, '[2] aperture_param: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call aperture_param_struct_to_json(f_aperture_param, json_root)
  call json%print(json_root, 'test_f_aperture_param_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call aperture_param_struct_to_json(f2_aperture_param, json_root)
  call json%print(json_root, 'test_f_aperture_param_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_aperture_param_pattern_2_*.json)'

endif

call set_aperture_param_test_pattern (f2_aperture_param, 3)
call aperture_param_to_c (c_loc(f2_aperture_param), c_aperture_param)

! clean up test pattern data - < 3 deallocates arrays and such
call set_aperture_param_test_pattern (f_aperture_param, -1)
call set_aperture_param_test_pattern (f2_aperture_param, -1)

end subroutine test2_f_aperture_param

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_aperture_param_test_pattern (F, ix_patt)

implicit none

type(aperture_param_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[0D_NOT_real] Real
rhs = 1 + offset; F%min_angle = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 2 + offset; F%max_angle = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 3 + offset; F%n_angle = rhs
!! f_side.test_pat[0D_NOT_integer] Int
rhs = 4 + offset; F%n_turn = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 5 + offset; F%x_init = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 6 + offset; F%y_init = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 7 + offset; F%rel_accuracy = rhs
!! f_side.test_pat[0D_NOT_real] Real
rhs = 8 + offset; F%abs_accuracy = rhs
!! f_side.test_pat[0D_NOT_character] string
do jd1 = 1, len(F%start_ele)
  F%start_ele(jd1:jd1) = char(ichar("a") + modulo(100+9+offset+jd1, 26))
enddo

end subroutine set_aperture_param_test_pattern
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_aperture_scan (ok)

implicit none

type(aperture_scan_struct), target :: f_aperture_scan, f2_aperture_scan

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
subroutine test_c_aperture_scan (c_aperture_scan, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_aperture_scan
    logical(c_bool) c_ok
end subroutine
end interface

!

ok = .true.
call set_aperture_scan_test_pattern (f2_aperture_scan, 1)

call test_c_aperture_scan(c_loc(f2_aperture_scan), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_aperture_scan_test_pattern (f_aperture_scan, 4)
if (f_aperture_scan == f2_aperture_scan) then
  print *, '[4] aperture_scan: C side convert C->F: Good'
else
  print *, '[4] aperture_scan: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call aperture_scan_struct_to_json(f_aperture_scan, json_root)
  call json%print(json_root, 'test_f_aperture_scan_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call aperture_scan_struct_to_json(f2_aperture_scan, json_root)
  call json%print(json_root, 'test_f_aperture_scan_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_aperture_scan_pattern_4_*.json)'

endif

! clean up test pattern data - < 3 deallocates arrays and such
call set_aperture_scan_test_pattern (f_aperture_scan, -1)
call set_aperture_scan_test_pattern (f2_aperture_scan, -1)

end subroutine test1_f_aperture_scan

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_aperture_scan (c_aperture_scan, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_aperture_scan
type(aperture_scan_struct), target :: f_aperture_scan, f2_aperture_scan
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call aperture_scan_to_f (c_aperture_scan, c_loc(f_aperture_scan))

call set_aperture_scan_test_pattern (f2_aperture_scan, 2)
if (f_aperture_scan == f2_aperture_scan) then
  print *, '[2] aperture_scan: F side convert C->F: Good'
else
  print *, '[2] aperture_scan: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call aperture_scan_struct_to_json(f_aperture_scan, json_root)
  call json%print(json_root, 'test_f_aperture_scan_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call aperture_scan_struct_to_json(f2_aperture_scan, json_root)
  call json%print(json_root, 'test_f_aperture_scan_pattern_2_expected_f2.json')
  call json%destroy(json_root)
  print *, '    Wrote JSON files for comparison (test_f_aperture_scan_pattern_2_*.json)'

endif

call set_aperture_scan_test_pattern (f2_aperture_scan, 3)
call aperture_scan_to_c (c_loc(f2_aperture_scan), c_aperture_scan)

! clean up test pattern data - < 3 deallocates arrays and such
call set_aperture_scan_test_pattern (f_aperture_scan, -1)
call set_aperture_scan_test_pattern (f2_aperture_scan, -1)

end subroutine test2_f_aperture_scan

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_aperture_scan_test_pattern (F, ix_patt)

implicit none

type(aperture_scan_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[1D_ALLOC_type] VariableArray1D<CPP_aperture_point>
if (ix_patt < 3) then
  if (allocated(F%point)) then
    ! ensure memory is freed for previously-set patterns >= 3
    do jd1 = lbound(F%point,1), ubound(F%point,1)
      call set_aperture_point_test_pattern (F%point(jd1), -1)
    enddo
    deallocate (F%point)
  endif
else
  if (.not. allocated(F%point)) then
    allocate (F%point(-1:1))
  endif
  do jd1 = 1, size(F%point,1)
    lb1 = lbound(F%point,1) - 1
    call set_aperture_point_test_pattern (F%point(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[0D_NOT_type] CPP_coord
call set_coord_test_pattern (F%ref_orb, ix_patt)
!! f_side.test_pat[0D_NOT_real] Real
rhs = 4 + offset; F%pz_start = rhs

end subroutine set_aperture_scan_test_pattern

end module
