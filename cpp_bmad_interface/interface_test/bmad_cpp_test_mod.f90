
module bmad_cpp_test_mod

use json_module, only: json_core, json_value

use bmad_cpp_convert_mod
use equality_mod
use test_struct_defs

contains


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

endif

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

endif



call set_wake_lr_test_pattern (f2_wake_lr, 3)
call wake_lr_to_c (c_loc(f2_wake_lr), c_wake_lr)
end subroutine test2_f_wake_lr

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_lr_test_pattern (F, ix_patt)

implicit none

type(wake_lr_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[integer8, 0, NOT] Int8
rhs = 1 + offset; F%aaa = rhs
!! f_side.test_pat[integer, 0, NOT] Int
rhs = 2 + offset; F%bbb = rhs
!! f_side.test_pat[character, 0, NOT] string
do jd1 = 1, len(F%file)
  F%file(jd1:jd1) = char(ichar("a") + modulo(100+3+offset+jd1, 26))
enddo
!! f_side.test_pat[real, 0, NOT] Real
rhs = 4 + offset; F%t_ref = rhs
!! f_side.test_pat[real, 0, NOT] Real
rhs = 5 + offset; F%freq_spread = rhs

end subroutine set_wake_lr_test_pattern

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

endif

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

endif



call set_wake_test_pattern (f2_wake, 3)
call wake_to_c (c_loc(f2_wake), c_wake)
end subroutine test2_f_wake

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_wake_test_pattern (F, ix_patt)

implicit none

type(wake_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[type, 0, NOT] CPP_wake_lr
call set_wake_lr_test_pattern (F%sr, ix_patt)

end subroutine set_wake_test_pattern

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_all_encompassing (ok)

implicit none

type(all_encompassing_struct), target :: f_all_encompassing, f2_all_encompassing

type(json_core) :: json
type(json_value), pointer :: json_root

logical(c_bool) c_ok
logical ok

interface
  subroutine test_c_all_encompassing (c_all_encompassing, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_all_encompassing
    logical(c_bool) c_ok
  end subroutine
end interface

!

ok = .true.
call set_all_encompassing_test_pattern (f2_all_encompassing, 1)

call test_c_all_encompassing(c_loc(f2_all_encompassing), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_all_encompassing_test_pattern (f_all_encompassing, 4)
if (f_all_encompassing == f2_all_encompassing) then
  print *, '[4] all_encompassing: C side convert C->F: Good'
else
  print *, '[4] all_encompassing: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call all_encompassing_struct_to_json(f_all_encompassing, json_root)
  call json%print(json_root, 'test_f_all_encompassing_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call all_encompassing_struct_to_json(f2_all_encompassing, json_root)
  call json%print(json_root, 'test_f_all_encompassing_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)

endif

end subroutine test1_f_all_encompassing

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_all_encompassing (c_all_encompassing, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_all_encompassing
type(all_encompassing_struct), target :: f_all_encompassing, f2_all_encompassing
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call all_encompassing_to_f (c_all_encompassing, c_loc(f_all_encompassing))

call set_all_encompassing_test_pattern (f2_all_encompassing, 2)
if (f_all_encompassing == f2_all_encompassing) then
  print *, '[2] all_encompassing: F side convert C->F: Good'
else
  print *, '[2] all_encompassing: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call all_encompassing_struct_to_json(f_all_encompassing, json_root)
  call json%print(json_root, 'test_f_all_encompassing_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call all_encompassing_struct_to_json(f2_all_encompassing, json_root)
  call json%print(json_root, 'test_f_all_encompassing_pattern_2_expected_f2.json')
  call json%destroy(json_root)

endif



call set_all_encompassing_test_pattern (f2_all_encompassing, 3)
call all_encompassing_to_c (c_loc(f2_all_encompassing), c_all_encompassing)
end subroutine test2_f_all_encompassing

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_all_encompassing_test_pattern (F, ix_patt)

implicit none

type(all_encompassing_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

!! f_side.test_pat[real, 0, NOT] Real
rhs = 1 + offset; F%real_rp_0d = rhs
!! f_side.test_pat[real, 1, NOT] FixedArray1D<Real, 3>
do jd1 = 1, size(F%real_rp_1d,1); lb1 = lbound(F%real_rp_1d,1) - 1
  rhs = 100 + jd1 + 2 + offset
  F%real_rp_1d(jd1+lb1) = rhs
enddo
!! f_side.test_pat[real, 2, NOT] FixedArray2D<Real, 3, 4>
do jd1 = 1, size(F%real_rp_2d,1); lb1 = lbound(F%real_rp_2d,1) - 1
do jd2 = 1, size(F%real_rp_2d,2); lb2 = lbound(F%real_rp_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 3 + offset
  F%real_rp_2d(jd1+lb1,jd2+lb2) = rhs
enddo; enddo
!! f_side.test_pat[real, 3, NOT] FixedArray3D<Real, 3, 4, 5>
do jd1 = 1, size(F%real_rp_3d,1); lb1 = lbound(F%real_rp_3d,1) - 1
do jd2 = 1, size(F%real_rp_3d,2); lb2 = lbound(F%real_rp_3d,2) - 1
do jd3 = 1, size(F%real_rp_3d,3); lb3 = lbound(F%real_rp_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 4 + offset
  F%real_rp_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
enddo; enddo; enddo
!! f_side.test_pat[real, 0, PTR] shared_ptr<Real>
if (ix_patt < 3) then
  if (associated(F%real_rp_0d_ptr)) deallocate (F%real_rp_0d_ptr)
else
  if (.not. associated(F%real_rp_0d_ptr)) allocate (F%real_rp_0d_ptr)
  rhs = 5 + offset
  F%real_rp_0d_ptr = rhs
endif
!! f_side.test_pat[real, 1, PTR] VariableArray1D<Real>

if (ix_patt < 3) then
  if (associated(F%real_rp_1d_ptr)) deallocate (F%real_rp_1d_ptr)
else
  if (.not. associated(F%real_rp_1d_ptr)) allocate (F%real_rp_1d_ptr(-1:1))
  do jd1 = 1, size(F%real_rp_1d_ptr,1); lb1 = lbound(F%real_rp_1d_ptr,1) - 1
    rhs = 100 + jd1 + 7 + offset
    F%real_rp_1d_ptr(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[real, 2, PTR] VariableArray2D<Real>

if (ix_patt < 3) then
  if (associated(F%real_rp_2d_ptr)) deallocate (F%real_rp_2d_ptr)
else
  if (.not. associated(F%real_rp_2d_ptr)) allocate (F%real_rp_2d_ptr(-1:1, 2))
  do jd1 = 1, size(F%real_rp_2d_ptr,1); lb1 = lbound(F%real_rp_2d_ptr,1) - 1
  do jd2 = 1, size(F%real_rp_2d_ptr,2); lb2 = lbound(F%real_rp_2d_ptr,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 9 + offset
    F%real_rp_2d_ptr(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[real, 3, PTR] VariableArray3D<Real>
if (ix_patt < 3) then
  if (associated(F%real_rp_3d_ptr)) deallocate (F%real_rp_3d_ptr)
else
  if (.not. associated(F%real_rp_3d_ptr)) allocate (F%real_rp_3d_ptr(-1:1, 2, 1))
  do jd1 = 1, size(F%real_rp_3d_ptr,1); lb1 = lbound(F%real_rp_3d_ptr,1) - 1
  do jd2 = 1, size(F%real_rp_3d_ptr,2); lb2 = lbound(F%real_rp_3d_ptr,2) - 1
  do jd3 = 1, size(F%real_rp_3d_ptr,3); lb3 = lbound(F%real_rp_3d_ptr,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 12 + offset
    F%real_rp_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[real, 1, ALLOC] VariableArray1D<Real>

if (ix_patt < 3) then
  if (allocated(F%real_rp_1d_alloc)) deallocate (F%real_rp_1d_alloc)
else
  if (.not. allocated(F%real_rp_1d_alloc)) allocate (F%real_rp_1d_alloc(-1:1))
  do jd1 = 1, size(F%real_rp_1d_alloc,1); lb1 = lbound(F%real_rp_1d_alloc,1) - 1
    rhs = 100 + jd1 + 16 + offset
    F%real_rp_1d_alloc(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[real, 2, ALLOC] VariableArray2D<Real>

if (ix_patt < 3) then
  if (allocated(F%real_rp_2d_alloc)) deallocate (F%real_rp_2d_alloc)
else
  if (.not. allocated(F%real_rp_2d_alloc)) allocate (F%real_rp_2d_alloc(-1:1, 2))
  do jd1 = 1, size(F%real_rp_2d_alloc,1); lb1 = lbound(F%real_rp_2d_alloc,1) - 1
  do jd2 = 1, size(F%real_rp_2d_alloc,2); lb2 = lbound(F%real_rp_2d_alloc,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 18 + offset
    F%real_rp_2d_alloc(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[real, 3, ALLOC] VariableArray3D<Real>
if (ix_patt < 3) then
  if (allocated(F%real_rp_3d_alloc)) deallocate (F%real_rp_3d_alloc)
else
  if (.not. allocated(F%real_rp_3d_alloc)) allocate (F%real_rp_3d_alloc(-1:1, 2, 1))
  do jd1 = 1, size(F%real_rp_3d_alloc,1); lb1 = lbound(F%real_rp_3d_alloc,1) - 1
  do jd2 = 1, size(F%real_rp_3d_alloc,2); lb2 = lbound(F%real_rp_3d_alloc,2) - 1
  do jd3 = 1, size(F%real_rp_3d_alloc,3); lb3 = lbound(F%real_rp_3d_alloc,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 21 + offset
    F%real_rp_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[real, 0, NOT] Real
rhs = 25 + offset; F%real_dp_0d = rhs
!! f_side.test_pat[real, 1, NOT] FixedArray1D<Real, 3>
do jd1 = 1, size(F%real_dp_1d,1); lb1 = lbound(F%real_dp_1d,1) - 1
  rhs = 100 + jd1 + 26 + offset
  F%real_dp_1d(jd1+lb1) = rhs
enddo
!! f_side.test_pat[real, 2, NOT] FixedArray2D<Real, 3, 4>
do jd1 = 1, size(F%real_dp_2d,1); lb1 = lbound(F%real_dp_2d,1) - 1
do jd2 = 1, size(F%real_dp_2d,2); lb2 = lbound(F%real_dp_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 27 + offset
  F%real_dp_2d(jd1+lb1,jd2+lb2) = rhs
enddo; enddo
!! f_side.test_pat[real, 3, NOT] FixedArray3D<Real, 3, 4, 5>
do jd1 = 1, size(F%real_dp_3d,1); lb1 = lbound(F%real_dp_3d,1) - 1
do jd2 = 1, size(F%real_dp_3d,2); lb2 = lbound(F%real_dp_3d,2) - 1
do jd3 = 1, size(F%real_dp_3d,3); lb3 = lbound(F%real_dp_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 28 + offset
  F%real_dp_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
enddo; enddo; enddo
!! f_side.test_pat[real, 0, PTR] shared_ptr<Real>
if (ix_patt < 3) then
  if (associated(F%real_dp_0d_ptr)) deallocate (F%real_dp_0d_ptr)
else
  if (.not. associated(F%real_dp_0d_ptr)) allocate (F%real_dp_0d_ptr)
  rhs = 29 + offset
  F%real_dp_0d_ptr = rhs
endif
!! f_side.test_pat[real, 1, PTR] VariableArray1D<Real>

if (ix_patt < 3) then
  if (associated(F%real_dp_1d_ptr)) deallocate (F%real_dp_1d_ptr)
else
  if (.not. associated(F%real_dp_1d_ptr)) allocate (F%real_dp_1d_ptr(-1:1))
  do jd1 = 1, size(F%real_dp_1d_ptr,1); lb1 = lbound(F%real_dp_1d_ptr,1) - 1
    rhs = 100 + jd1 + 31 + offset
    F%real_dp_1d_ptr(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[real, 2, PTR] VariableArray2D<Real>

if (ix_patt < 3) then
  if (associated(F%real_dp_2d_ptr)) deallocate (F%real_dp_2d_ptr)
else
  if (.not. associated(F%real_dp_2d_ptr)) allocate (F%real_dp_2d_ptr(-1:1, 2))
  do jd1 = 1, size(F%real_dp_2d_ptr,1); lb1 = lbound(F%real_dp_2d_ptr,1) - 1
  do jd2 = 1, size(F%real_dp_2d_ptr,2); lb2 = lbound(F%real_dp_2d_ptr,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 33 + offset
    F%real_dp_2d_ptr(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[real, 3, PTR] VariableArray3D<Real>
if (ix_patt < 3) then
  if (associated(F%real_dp_3d_ptr)) deallocate (F%real_dp_3d_ptr)
else
  if (.not. associated(F%real_dp_3d_ptr)) allocate (F%real_dp_3d_ptr(-1:1, 2, 1))
  do jd1 = 1, size(F%real_dp_3d_ptr,1); lb1 = lbound(F%real_dp_3d_ptr,1) - 1
  do jd2 = 1, size(F%real_dp_3d_ptr,2); lb2 = lbound(F%real_dp_3d_ptr,2) - 1
  do jd3 = 1, size(F%real_dp_3d_ptr,3); lb3 = lbound(F%real_dp_3d_ptr,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 36 + offset
    F%real_dp_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[real, 1, ALLOC] VariableArray1D<Real>

if (ix_patt < 3) then
  if (allocated(F%real_dp_1d_alloc)) deallocate (F%real_dp_1d_alloc)
else
  if (.not. allocated(F%real_dp_1d_alloc)) allocate (F%real_dp_1d_alloc(-1:1))
  do jd1 = 1, size(F%real_dp_1d_alloc,1); lb1 = lbound(F%real_dp_1d_alloc,1) - 1
    rhs = 100 + jd1 + 40 + offset
    F%real_dp_1d_alloc(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[real, 2, ALLOC] VariableArray2D<Real>

if (ix_patt < 3) then
  if (allocated(F%real_dp_2d_alloc)) deallocate (F%real_dp_2d_alloc)
else
  if (.not. allocated(F%real_dp_2d_alloc)) allocate (F%real_dp_2d_alloc(-1:1, 2))
  do jd1 = 1, size(F%real_dp_2d_alloc,1); lb1 = lbound(F%real_dp_2d_alloc,1) - 1
  do jd2 = 1, size(F%real_dp_2d_alloc,2); lb2 = lbound(F%real_dp_2d_alloc,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 42 + offset
    F%real_dp_2d_alloc(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[real, 3, ALLOC] VariableArray3D<Real>
if (ix_patt < 3) then
  if (allocated(F%real_dp_3d_alloc)) deallocate (F%real_dp_3d_alloc)
else
  if (.not. allocated(F%real_dp_3d_alloc)) allocate (F%real_dp_3d_alloc(-1:1, 2, 1))
  do jd1 = 1, size(F%real_dp_3d_alloc,1); lb1 = lbound(F%real_dp_3d_alloc,1) - 1
  do jd2 = 1, size(F%real_dp_3d_alloc,2); lb2 = lbound(F%real_dp_3d_alloc,2) - 1
  do jd3 = 1, size(F%real_dp_3d_alloc,3); lb3 = lbound(F%real_dp_3d_alloc,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 45 + offset
    F%real_dp_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[complex, 0, NOT] Complex
rhs = 49 + offset; F%complex_dp_0d = cmplx(rhs, 100+rhs)
!! f_side.test_pat[complex, 1, NOT] FixedArray1D<Complex, 3>
do jd1 = 1, size(F%complex_dp_1d,1); lb1 = lbound(F%complex_dp_1d,1) - 1
  rhs = 100 + jd1 + 50 + offset
  F%complex_dp_1d(jd1+lb1) = cmplx(rhs, 100+rhs)
enddo
!! f_side.test_pat[complex, 2, NOT] FixedArray2D<Complex, 3, 4>
do jd1 = 1, size(F%complex_dp_2d,1); lb1 = lbound(F%complex_dp_2d,1) - 1
do jd2 = 1, size(F%complex_dp_2d,2); lb2 = lbound(F%complex_dp_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 51 + offset
  F%complex_dp_2d(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)
enddo; enddo
!! f_side.test_pat[complex, 3, NOT] FixedArray3D<Complex, 3, 4, 5>
do jd1 = 1, size(F%complex_dp_3d,1); lb1 = lbound(F%complex_dp_3d,1) - 1
do jd2 = 1, size(F%complex_dp_3d,2); lb2 = lbound(F%complex_dp_3d,2) - 1
do jd3 = 1, size(F%complex_dp_3d,3); lb3 = lbound(F%complex_dp_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 52 + offset
  F%complex_dp_3d(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)
enddo; enddo; enddo
!! f_side.test_pat[complex, 0, PTR] shared_ptr<Complex>
if (ix_patt < 3) then
  if (associated(F%complex_dp_0d_ptr)) deallocate (F%complex_dp_0d_ptr)
else
  if (.not. associated(F%complex_dp_0d_ptr)) allocate (F%complex_dp_0d_ptr)
  rhs = 53 + offset
  F%complex_dp_0d_ptr = cmplx(rhs, 100+rhs)
endif
!! f_side.test_pat[complex, 1, PTR] VariableArray1D<Complex>

if (ix_patt < 3) then
  if (associated(F%complex_dp_1d_ptr)) deallocate (F%complex_dp_1d_ptr)
else
  if (.not. associated(F%complex_dp_1d_ptr)) allocate (F%complex_dp_1d_ptr(-1:1))
  do jd1 = 1, size(F%complex_dp_1d_ptr,1); lb1 = lbound(F%complex_dp_1d_ptr,1) - 1
    rhs = 100 + jd1 + 55 + offset
    F%complex_dp_1d_ptr(jd1+lb1) = cmplx(rhs, 100+rhs)
  enddo
endif
!! f_side.test_pat[complex, 2, PTR] VariableArray2D<Complex>

if (ix_patt < 3) then
  if (associated(F%complex_dp_2d_ptr)) deallocate (F%complex_dp_2d_ptr)
else
  if (.not. associated(F%complex_dp_2d_ptr)) allocate (F%complex_dp_2d_ptr(-1:1, 2))
  do jd1 = 1, size(F%complex_dp_2d_ptr,1); lb1 = lbound(F%complex_dp_2d_ptr,1) - 1
  do jd2 = 1, size(F%complex_dp_2d_ptr,2); lb2 = lbound(F%complex_dp_2d_ptr,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 57 + offset
    F%complex_dp_2d_ptr(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)
  enddo; enddo
endif
!! f_side.test_pat[complex, 3, PTR] VariableArray3D<Complex>
if (ix_patt < 3) then
  if (associated(F%complex_dp_3d_ptr)) deallocate (F%complex_dp_3d_ptr)
else
  if (.not. associated(F%complex_dp_3d_ptr)) allocate (F%complex_dp_3d_ptr(-1:1, 2, 1))
  do jd1 = 1, size(F%complex_dp_3d_ptr,1); lb1 = lbound(F%complex_dp_3d_ptr,1) - 1
  do jd2 = 1, size(F%complex_dp_3d_ptr,2); lb2 = lbound(F%complex_dp_3d_ptr,2) - 1
  do jd3 = 1, size(F%complex_dp_3d_ptr,3); lb3 = lbound(F%complex_dp_3d_ptr,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 60 + offset
    F%complex_dp_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)
  enddo; enddo; enddo
endif
!! f_side.test_pat[complex, 1, ALLOC] VariableArray1D<Complex>

if (ix_patt < 3) then
  if (allocated(F%complex_dp_1d_alloc)) deallocate (F%complex_dp_1d_alloc)
else
  if (.not. allocated(F%complex_dp_1d_alloc)) allocate (F%complex_dp_1d_alloc(-1:1))
  do jd1 = 1, size(F%complex_dp_1d_alloc,1); lb1 = lbound(F%complex_dp_1d_alloc,1) - 1
    rhs = 100 + jd1 + 64 + offset
    F%complex_dp_1d_alloc(jd1+lb1) = cmplx(rhs, 100+rhs)
  enddo
endif
!! f_side.test_pat[complex, 2, ALLOC] VariableArray2D<Complex>

if (ix_patt < 3) then
  if (allocated(F%complex_dp_2d_alloc)) deallocate (F%complex_dp_2d_alloc)
else
  if (.not. allocated(F%complex_dp_2d_alloc)) allocate (F%complex_dp_2d_alloc(-1:1, 2))
  do jd1 = 1, size(F%complex_dp_2d_alloc,1); lb1 = lbound(F%complex_dp_2d_alloc,1) - 1
  do jd2 = 1, size(F%complex_dp_2d_alloc,2); lb2 = lbound(F%complex_dp_2d_alloc,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 66 + offset
    F%complex_dp_2d_alloc(jd1+lb1,jd2+lb2) = cmplx(rhs, 100+rhs)
  enddo; enddo
endif
!! f_side.test_pat[complex, 3, ALLOC] VariableArray3D<Complex>
if (ix_patt < 3) then
  if (allocated(F%complex_dp_3d_alloc)) deallocate (F%complex_dp_3d_alloc)
else
  if (.not. allocated(F%complex_dp_3d_alloc)) allocate (F%complex_dp_3d_alloc(-1:1, 2, 1))
  do jd1 = 1, size(F%complex_dp_3d_alloc,1); lb1 = lbound(F%complex_dp_3d_alloc,1) - 1
  do jd2 = 1, size(F%complex_dp_3d_alloc,2); lb2 = lbound(F%complex_dp_3d_alloc,2) - 1
  do jd3 = 1, size(F%complex_dp_3d_alloc,3); lb3 = lbound(F%complex_dp_3d_alloc,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 69 + offset
    F%complex_dp_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = cmplx(rhs, 100+rhs)
  enddo; enddo; enddo
endif
!! f_side.test_pat[integer, 0, NOT] Int
rhs = 73 + offset; F%int_0d = rhs
!! f_side.test_pat[integer, 1, NOT] FixedArray1D<Int, 3>
do jd1 = 1, size(F%int_1d,1); lb1 = lbound(F%int_1d,1) - 1
  rhs = 100 + jd1 + 74 + offset
  F%int_1d(jd1+lb1) = rhs
enddo
!! f_side.test_pat[integer, 2, NOT] FixedArray2D<Int, 3, 4>
do jd1 = 1, size(F%int_2d,1); lb1 = lbound(F%int_2d,1) - 1
do jd2 = 1, size(F%int_2d,2); lb2 = lbound(F%int_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 75 + offset
  F%int_2d(jd1+lb1,jd2+lb2) = rhs
enddo; enddo
!! f_side.test_pat[integer, 3, NOT] FixedArray3D<Int, 3, 4, 5>
do jd1 = 1, size(F%int_3d,1); lb1 = lbound(F%int_3d,1) - 1
do jd2 = 1, size(F%int_3d,2); lb2 = lbound(F%int_3d,2) - 1
do jd3 = 1, size(F%int_3d,3); lb3 = lbound(F%int_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 76 + offset
  F%int_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
enddo; enddo; enddo
!! f_side.test_pat[integer, 0, PTR] shared_ptr<Int>
if (ix_patt < 3) then
  if (associated(F%int_0d_ptr)) deallocate (F%int_0d_ptr)
else
  if (.not. associated(F%int_0d_ptr)) allocate (F%int_0d_ptr)
  rhs = 77 + offset
  F%int_0d_ptr = rhs
endif
!! f_side.test_pat[integer, 1, PTR] VariableArray1D<Int>

if (ix_patt < 3) then
  if (associated(F%int_1d_ptr)) deallocate (F%int_1d_ptr)
else
  if (.not. associated(F%int_1d_ptr)) allocate (F%int_1d_ptr(-1:1))
  do jd1 = 1, size(F%int_1d_ptr,1); lb1 = lbound(F%int_1d_ptr,1) - 1
    rhs = 100 + jd1 + 79 + offset
    F%int_1d_ptr(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[integer, 2, PTR] VariableArray2D<Int>

if (ix_patt < 3) then
  if (associated(F%int_2d_ptr)) deallocate (F%int_2d_ptr)
else
  if (.not. associated(F%int_2d_ptr)) allocate (F%int_2d_ptr(-1:1, 2))
  do jd1 = 1, size(F%int_2d_ptr,1); lb1 = lbound(F%int_2d_ptr,1) - 1
  do jd2 = 1, size(F%int_2d_ptr,2); lb2 = lbound(F%int_2d_ptr,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 81 + offset
    F%int_2d_ptr(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[integer, 3, PTR] VariableArray3D<Int>
if (ix_patt < 3) then
  if (associated(F%int_3d_ptr)) deallocate (F%int_3d_ptr)
else
  if (.not. associated(F%int_3d_ptr)) allocate (F%int_3d_ptr(-1:1, 2, 1))
  do jd1 = 1, size(F%int_3d_ptr,1); lb1 = lbound(F%int_3d_ptr,1) - 1
  do jd2 = 1, size(F%int_3d_ptr,2); lb2 = lbound(F%int_3d_ptr,2) - 1
  do jd3 = 1, size(F%int_3d_ptr,3); lb3 = lbound(F%int_3d_ptr,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 84 + offset
    F%int_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[integer, 1, ALLOC] VariableArray1D<Int>

if (ix_patt < 3) then
  if (allocated(F%int_1d_alloc)) deallocate (F%int_1d_alloc)
else
  if (.not. allocated(F%int_1d_alloc)) allocate (F%int_1d_alloc(-1:1))
  do jd1 = 1, size(F%int_1d_alloc,1); lb1 = lbound(F%int_1d_alloc,1) - 1
    rhs = 100 + jd1 + 88 + offset
    F%int_1d_alloc(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[integer, 2, ALLOC] VariableArray2D<Int>

if (ix_patt < 3) then
  if (allocated(F%int_2d_alloc)) deallocate (F%int_2d_alloc)
else
  if (.not. allocated(F%int_2d_alloc)) allocate (F%int_2d_alloc(-1:1, 2))
  do jd1 = 1, size(F%int_2d_alloc,1); lb1 = lbound(F%int_2d_alloc,1) - 1
  do jd2 = 1, size(F%int_2d_alloc,2); lb2 = lbound(F%int_2d_alloc,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 90 + offset
    F%int_2d_alloc(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[integer, 3, ALLOC] VariableArray3D<Int>
if (ix_patt < 3) then
  if (allocated(F%int_3d_alloc)) deallocate (F%int_3d_alloc)
else
  if (.not. allocated(F%int_3d_alloc)) allocate (F%int_3d_alloc(-1:1, 2, 1))
  do jd1 = 1, size(F%int_3d_alloc,1); lb1 = lbound(F%int_3d_alloc,1) - 1
  do jd2 = 1, size(F%int_3d_alloc,2); lb2 = lbound(F%int_3d_alloc,2) - 1
  do jd3 = 1, size(F%int_3d_alloc,3); lb3 = lbound(F%int_3d_alloc,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 93 + offset
    F%int_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[integer8, 0, NOT] Int8
rhs = 97 + offset; F%int8_0d = rhs
!! f_side.test_pat[integer8, 1, NOT] FixedArray1D<Int8, 3>
do jd1 = 1, size(F%int8_1d,1); lb1 = lbound(F%int8_1d,1) - 1
  rhs = 100 + jd1 + 98 + offset
  F%int8_1d(jd1+lb1) = rhs
enddo
!! f_side.test_pat[integer8, 2, NOT] FixedArray2D<Int8, 3, 4>
do jd1 = 1, size(F%int8_2d,1); lb1 = lbound(F%int8_2d,1) - 1
do jd2 = 1, size(F%int8_2d,2); lb2 = lbound(F%int8_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 99 + offset
  F%int8_2d(jd1+lb1,jd2+lb2) = rhs
enddo; enddo
!! f_side.test_pat[integer8, 3, NOT] FixedArray3D<Int8, 3, 4, 5>
do jd1 = 1, size(F%int8_3d,1); lb1 = lbound(F%int8_3d,1) - 1
do jd2 = 1, size(F%int8_3d,2); lb2 = lbound(F%int8_3d,2) - 1
do jd3 = 1, size(F%int8_3d,3); lb3 = lbound(F%int8_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 100 + offset
  F%int8_3d(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
enddo; enddo; enddo
!! f_side.test_pat[integer8, 0, PTR] shared_ptr<Int8>
if (ix_patt < 3) then
  if (associated(F%int8_0d_ptr)) deallocate (F%int8_0d_ptr)
else
  if (.not. associated(F%int8_0d_ptr)) allocate (F%int8_0d_ptr)
  rhs = 101 + offset
  F%int8_0d_ptr = rhs
endif
!! f_side.test_pat[integer8, 1, PTR] VariableArray1D<Int8>

if (ix_patt < 3) then
  if (associated(F%int8_1d_ptr)) deallocate (F%int8_1d_ptr)
else
  if (.not. associated(F%int8_1d_ptr)) allocate (F%int8_1d_ptr(-1:1))
  do jd1 = 1, size(F%int8_1d_ptr,1); lb1 = lbound(F%int8_1d_ptr,1) - 1
    rhs = 100 + jd1 + 103 + offset
    F%int8_1d_ptr(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[integer8, 2, PTR] VariableArray2D<Int8>

if (ix_patt < 3) then
  if (associated(F%int8_2d_ptr)) deallocate (F%int8_2d_ptr)
else
  if (.not. associated(F%int8_2d_ptr)) allocate (F%int8_2d_ptr(-1:1, 2))
  do jd1 = 1, size(F%int8_2d_ptr,1); lb1 = lbound(F%int8_2d_ptr,1) - 1
  do jd2 = 1, size(F%int8_2d_ptr,2); lb2 = lbound(F%int8_2d_ptr,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 105 + offset
    F%int8_2d_ptr(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[integer8, 3, PTR] VariableArray3D<Int8>
if (ix_patt < 3) then
  if (associated(F%int8_3d_ptr)) deallocate (F%int8_3d_ptr)
else
  if (.not. associated(F%int8_3d_ptr)) allocate (F%int8_3d_ptr(-1:1, 2, 1))
  do jd1 = 1, size(F%int8_3d_ptr,1); lb1 = lbound(F%int8_3d_ptr,1) - 1
  do jd2 = 1, size(F%int8_3d_ptr,2); lb2 = lbound(F%int8_3d_ptr,2) - 1
  do jd3 = 1, size(F%int8_3d_ptr,3); lb3 = lbound(F%int8_3d_ptr,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 108 + offset
    F%int8_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[integer8, 1, ALLOC] VariableArray1D<Int8>

if (ix_patt < 3) then
  if (allocated(F%int8_1d_alloc)) deallocate (F%int8_1d_alloc)
else
  if (.not. allocated(F%int8_1d_alloc)) allocate (F%int8_1d_alloc(-1:1))
  do jd1 = 1, size(F%int8_1d_alloc,1); lb1 = lbound(F%int8_1d_alloc,1) - 1
    rhs = 100 + jd1 + 112 + offset
    F%int8_1d_alloc(jd1+lb1) = rhs
  enddo
endif
!! f_side.test_pat[integer8, 2, ALLOC] VariableArray2D<Int8>

if (ix_patt < 3) then
  if (allocated(F%int8_2d_alloc)) deallocate (F%int8_2d_alloc)
else
  if (.not. allocated(F%int8_2d_alloc)) allocate (F%int8_2d_alloc(-1:1, 2))
  do jd1 = 1, size(F%int8_2d_alloc,1); lb1 = lbound(F%int8_2d_alloc,1) - 1
  do jd2 = 1, size(F%int8_2d_alloc,2); lb2 = lbound(F%int8_2d_alloc,2) - 1
    rhs = 100 + jd1 + 10*jd2 + 114 + offset
    F%int8_2d_alloc(jd1+lb1,jd2+lb2) = rhs
  enddo; enddo
endif
!! f_side.test_pat[integer8, 3, ALLOC] VariableArray3D<Int8>
if (ix_patt < 3) then
  if (allocated(F%int8_3d_alloc)) deallocate (F%int8_3d_alloc)
else
  if (.not. allocated(F%int8_3d_alloc)) allocate (F%int8_3d_alloc(-1:1, 2, 1))
  do jd1 = 1, size(F%int8_3d_alloc,1); lb1 = lbound(F%int8_3d_alloc,1) - 1
  do jd2 = 1, size(F%int8_3d_alloc,2); lb2 = lbound(F%int8_3d_alloc,2) - 1
  do jd3 = 1, size(F%int8_3d_alloc,3); lb3 = lbound(F%int8_3d_alloc,3) - 1
    rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 117 + offset
    F%int8_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3) = rhs
  enddo; enddo; enddo
endif
!! f_side.test_pat[logical, 0, NOT] Bool
rhs = 121 + offset; F%logical_0d = (modulo(rhs, 2) == 0)
!! f_side.test_pat[logical, 1, NOT] FixedArray1D<Bool, 3>
do jd1 = 1, size(F%logical_1d,1); lb1 = lbound(F%logical_1d,1) - 1
  rhs = 100 + jd1 + 122 + offset
  F%logical_1d(jd1+lb1) = (modulo(rhs, 2) == 0)
enddo
!! f_side.test_pat[logical, 2, NOT] FixedArray2D<Bool, 3, 4>
do jd1 = 1, size(F%logical_2d,1); lb1 = lbound(F%logical_2d,1) - 1
do jd2 = 1, size(F%logical_2d,2); lb2 = lbound(F%logical_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 123 + offset
  F%logical_2d(jd1+lb1,jd2+lb2) = (modulo(rhs, 2) == 0)
enddo; enddo
!! f_side.test_pat[logical, 3, NOT] FixedArray3D<Bool, 3, 4, 5>
do jd1 = 1, size(F%logical_3d,1); lb1 = lbound(F%logical_3d,1) - 1
do jd2 = 1, size(F%logical_3d,2); lb2 = lbound(F%logical_3d,2) - 1
do jd3 = 1, size(F%logical_3d,3); lb3 = lbound(F%logical_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 124 + offset
  F%logical_3d(jd1+lb1,jd2+lb2,jd3+lb3) = (modulo(rhs, 2) == 0)
enddo; enddo; enddo
!! f_side.test_pat[logical, 0, PTR] shared_ptr<Bool>
if (ix_patt < 3) then
  if (associated(F%logical_0d_ptr)) deallocate (F%logical_0d_ptr)
else
  if (.not. associated(F%logical_0d_ptr)) allocate (F%logical_0d_ptr)
  rhs = 125 + offset
  F%logical_0d_ptr = (modulo(rhs, 2) == 0)
endif
!! f_side.test_pat[type, 0, NOT] CPP_wake_lr
call set_wake_lr_test_pattern (F%type_0d, ix_patt)
!! f_side.test_pat[type, 1, NOT] FixedArray1D<CPP_wake_lr, 3>
do jd1 = 1, size(F%type_1d,1); lb1 = lbound(F%type_1d,1) - 1
  rhs = 100 + jd1 + 128 + offset
  call set_wake_lr_test_pattern (F%type_1d(jd1+lb1), ix_patt+jd1)
enddo
!! f_side.test_pat[type, 2, NOT] SharedVector2D<CPP_wake_lr>
do jd1 = 1, size(F%type_2d,1); lb1 = lbound(F%type_2d,1) - 1
do jd2 = 1, size(F%type_2d,2); lb2 = lbound(F%type_2d,2) - 1
  rhs = 100 + jd1 + 10*jd2 + 129 + offset
  call set_wake_lr_test_pattern (F%type_2d(jd1+lb1,jd2+lb2), ix_patt+jd1+10*jd2)
enddo; enddo
!! f_side.test_pat[type, 3, NOT] SharedVector3D<CPP_wake_lr>
do jd1 = 1, size(F%type_3d,1); lb1 = lbound(F%type_3d,1) - 1
do jd2 = 1, size(F%type_3d,2); lb2 = lbound(F%type_3d,2) - 1
do jd3 = 1, size(F%type_3d,3); lb3 = lbound(F%type_3d,3) - 1
  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + 130 + offset
  call set_wake_lr_test_pattern (F%type_3d(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+10*jd2+100*jd3)
enddo; enddo; enddo
!! f_side.test_pat[type, 0, PTR] shared_ptr<CPP_wake_lr>
if (ix_patt < 3) then
  if (associated(F%type_0d_ptr)) deallocate (F%type_0d_ptr)
else
  if (.not. associated(F%type_0d_ptr)) allocate (F%type_0d_ptr)
  rhs = 131 + offset
  call set_wake_lr_test_pattern (F%type_0d_ptr, ix_patt)
endif
!! f_side.test_pat[type, 1, PTR] VariableArray1D<CPP_wake_lr>

if (ix_patt < 3) then
  if (associated(F%type_1d_ptr)) deallocate (F%type_1d_ptr)
else
  if (.not. associated(F%type_1d_ptr)) allocate (F%type_1d_ptr(-1:1))
  do jd1 = 1, size(F%type_1d_ptr,1); lb1 = lbound(F%type_1d_ptr,1) - 1
    call set_wake_lr_test_pattern (F%type_1d_ptr(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[type, 2, PTR] VariableArray2D<CPP_wake_lr>

if (ix_patt < 3) then
  if (associated(F%type_2d_ptr)) deallocate (F%type_2d_ptr)
else
  if (.not. associated(F%type_2d_ptr)) allocate (F%type_2d_ptr(-1:1, 2))
  do jd1 = 1, size(F%type_2d_ptr,1); lb1 = lbound(F%type_2d_ptr,1) - 1
  do jd2 = 1, size(F%type_2d_ptr,2); lb2 = lbound(F%type_2d_ptr,2) - 1
    call set_wake_lr_test_pattern (F%type_2d_ptr(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)
  enddo
  enddo
endif
!! f_side.test_pat[type, 3, PTR] VariableArray3D<CPP_wake_lr>
if (ix_patt < 3) then
  if (associated(F%type_3d_ptr)) deallocate (F%type_3d_ptr)
else
  if (.not. associated(F%type_3d_ptr)) allocate (F%type_3d_ptr(-1:1, 2, 1))
  do jd1 = 1, size(F%type_3d_ptr,1); lb1 = lbound(F%type_3d_ptr,1) - 1
  do jd2 = 1, size(F%type_3d_ptr,2); lb2 = lbound(F%type_3d_ptr,2) - 1
  do jd3 = 1, size(F%type_3d_ptr,3); lb3 = lbound(F%type_3d_ptr,3) - 1
    call set_wake_lr_test_pattern (F%type_3d_ptr(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+2*jd2+3*jd3)
  enddo
  enddo
  enddo
endif
!! f_side.test_pat[type, 1, ALLOC] VariableArray1D<CPP_wake_lr>

if (ix_patt < 3) then
  if (allocated(F%type_1d_alloc)) deallocate (F%type_1d_alloc)
else
  if (.not. allocated(F%type_1d_alloc)) allocate (F%type_1d_alloc(-1:1))
  do jd1 = 1, size(F%type_1d_alloc,1); lb1 = lbound(F%type_1d_alloc,1) - 1
    call set_wake_lr_test_pattern (F%type_1d_alloc(jd1+lb1), ix_patt+jd1)
  enddo
endif
!! f_side.test_pat[type, 2, ALLOC] VariableArray2D<CPP_wake_lr>

if (ix_patt < 3) then
  if (allocated(F%type_2d_alloc)) deallocate (F%type_2d_alloc)
else
  if (.not. allocated(F%type_2d_alloc)) allocate (F%type_2d_alloc(-1:1, 2))
  do jd1 = 1, size(F%type_2d_alloc,1); lb1 = lbound(F%type_2d_alloc,1) - 1
  do jd2 = 1, size(F%type_2d_alloc,2); lb2 = lbound(F%type_2d_alloc,2) - 1
    call set_wake_lr_test_pattern (F%type_2d_alloc(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)
  enddo
  enddo
endif
!! f_side.test_pat[type, 3, ALLOC] VariableArray3D<CPP_wake_lr>
if (ix_patt < 3) then
  if (allocated(F%type_3d_alloc)) deallocate (F%type_3d_alloc)
else
  if (.not. allocated(F%type_3d_alloc)) allocate (F%type_3d_alloc(-1:1, 2, 1))
  do jd1 = 1, size(F%type_3d_alloc,1); lb1 = lbound(F%type_3d_alloc,1) - 1
  do jd2 = 1, size(F%type_3d_alloc,2); lb2 = lbound(F%type_3d_alloc,2) - 1
  do jd3 = 1, size(F%type_3d_alloc,3); lb3 = lbound(F%type_3d_alloc,3) - 1
    call set_wake_lr_test_pattern (F%type_3d_alloc(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+2*jd2+3*jd3)
  enddo
  enddo
  enddo
endif

end subroutine set_all_encompassing_test_pattern

end module
