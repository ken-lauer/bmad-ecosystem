module helper_struct_json
use json_module
use json_string_utilities, only: integer_to_string
use json_kinds, only: CK
contains
subroutine complex_to_json (input, json_root, depth, max_depth)
  use precision_def, only: dp
  implicit none
  type(json_core) :: json
  type (complex(dp)), intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  call json%create_array(json_root, '')
  call json%create_real(json_val, real(input), '')
  call json%add(json_root, json_val)
  call json%create_real(json_val, aimag(input), '')
  call json%add(json_root, json_val)
end subroutine complex_to_json
subroutine branch_reference_struct_to_json (input, json_root, depth, max_depth)
  use cpp_bmad_interface_helper_structs, only: branch_reference_struct
  implicit none
  type(json_core) :: json
  type (branch_reference_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
end subroutine branch_reference_struct_to_json
subroutine ele_reference_struct_to_json (input, json_root, depth, max_depth)
  use cpp_bmad_interface_helper_structs, only: ele_reference_struct
  implicit none
  type(json_core) :: json
  type (ele_reference_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
end subroutine ele_reference_struct_to_json
end module helper_struct_json