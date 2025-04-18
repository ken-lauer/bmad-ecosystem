module sim_utils_json
contains
subroutine complex_to_json (input, json_root, depth)
    use json_module
    use json_kinds, only: CK
    use precision_def, only: rp
    implicit none
    type(json_core) :: json
    type (complex(rp)), intent(in) :: input
    type (json_value), pointer :: json_val
    type (json_value), pointer, intent(inout) :: json_root
    integer, optional, value :: depth
    call json%create_array(json_root, '')
    call json%create_real(json_val, real(input), '')
    call json%add(json_root, json_val)
    call json%create_real(json_val, aimag(input), '')
    call json%add(json_root, json_val)
end subroutine complex_to_json
subroutine object_struct_to_json (input, json_root, depth)
  use object_model_mod, only: object_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (object_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  ! config skip_members: object_struct%child (object_struct, Array of subobjects)
  call json%add(json_root, 'n_child', int(input%n_child))
  call json%add(json_root, 'n_token', int(input%n_token))
  if (allocated(input%name)) then
    call json%add(json_root, 'name', trim(input%name))
  endif
  ! config skip_members: object_struct%parent (object_struct, )
  if (allocated(input%token)) then
    !line=67 definition='type (var_length_string_struct), allocatable :: token(:)' name='token' python_name='token' type='var_length_string_struct' python_type='VarLengthStringStruct' size=None dimension=':' comment='Array of tokens' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'token')
    do i1 = lbound(input%token, 1), ubound(input%token, 1)
      call var_length_string_struct_to_json(input%token(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine object_struct_to_json
subroutine temp_struct_to_json (input, json_root, depth)
  use object_model_mod, only: temp_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (temp_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'str_', trim(input%str))
end subroutine temp_struct_to_json
subroutine geodesic_lm_param_struct_to_json (input, json_root, depth)
  use geodesic_lm, only: geodesic_lm_param_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (geodesic_lm_param_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'cgoal', input%Cgoal)
  call json%add(json_root, 'analytic_avv', input%analytic_avv)
  call json%add(json_root, 'analytic_jac', input%analytic_jac)
  call json%add(json_root, 'artol', input%artol)
  call json%add(json_root, 'avmax', input%avmax)
  call json%add(json_root, 'center_diff', input%center_diff)
  call json%add(json_root, 'factoraccept', input%factoraccept)
  call json%add(json_root, 'factorreject', input%factorreject)
  call json%add(json_root, 'frtol', input%frtol)
  call json%add(json_root, 'ftol', input%ftol)
  call json%add(json_root, 'geo_hit_limit', input%geo_hit_limit)
  call json%add(json_root, 'gtol', input%gtol)
  call json%add(json_root, 'h1', input%h1)
  call json%add(json_root, 'h2', input%h2)
  call json%add(json_root, 'iaccel', int(input%iaccel))
  call json%add(json_root, 'ibold', int(input%ibold))
  call json%add(json_root, 'ibroyden', int(input%ibroyden))
  call json%add(json_root, 'imethod', int(input%imethod))
  call json%add(json_root, 'initialfactor', input%initialfactor)
  call json%add(json_root, 'maxaev', int(input%maxaev))
  call json%add(json_root, 'maxfev', int(input%maxfev))
  call json%add(json_root, 'maxiter', int(input%maxiter))
  call json%add(json_root, 'maxjev', int(input%maxjev))
  call json%add(json_root, 'maxlam', input%maxlam)
  call json%add(json_root, 'minlam', input%minlam)
  call json%add(json_root, 'mode', int(input%mode))
  call json%add(json_root, 'print_level', int(input%print_level))
  call json%add(json_root, 'print_unit', int(input%print_unit))
  call json%add(json_root, 'xrtol', input%xrtol)
  call json%add(json_root, 'xtol', input%xtol)
end subroutine geodesic_lm_param_struct_to_json
subroutine atom_struct_to_json (input, json_root, depth)
  use particle_species_mod, only: atom_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (atom_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'i_offset', int(input%i_offset))
  !line=128 definition='real(rp) :: mass(0:46) = no_iso' name='mass' python_name='mass' type='real' python_type='float' size=None dimension='0:46' comment='isotope masses in units of the unified atomic mass unit.' fortran_default='no_iso' default=0.0 default_factory=''
  call json%create_array(json_list1, 'mass')
  do i1 = lbound(input%mass, 1), ubound(input%mass, 1)
    call json%create_real(json_val, input%mass(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'z', int(input%z))
end subroutine atom_struct_to_json
subroutine global_common_struct_to_json (input, json_root, depth)
  use precision_def, only: global_common_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (global_common_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'debug', int(input%debug))
  call json%add(json_root, 'exit_on_error', input%exit_on_error)
  call json%add(json_root, 'mp_threading_is_safe', input%mp_threading_is_safe)
end subroutine global_common_struct_to_json
subroutine named_number_struct_to_json (input, json_root, depth)
  use precision_def, only: named_number_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (named_number_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'value', input%value)
end subroutine named_number_struct_to_json
subroutine all_pointer_struct_to_json (input, json_root, depth)
  use sim_utils_struct, only: all_pointer_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (all_pointer_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (associated(input%i)) then
    call json%add(json_root, 'i', int(input%i))
  endif
  if (associated(input%i1)) then
    !line=50 definition='integer, pointer :: i1(:) => null()' name='i1' python_name='i1' type='integer' python_type='int' size=None dimension=':' comment='' fortran_default='null()' default=0 default_factory=''
    call json%create_array(json_list1, 'i1')
    do i1 = lbound(input%i1, 1), ubound(input%i1, 1)
      call json%create_integer(json_val, input%i1(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%l)) then
    call json%add(json_root, 'L', input%l)
  endif
  if (associated(input%r)) then
    call json%add(json_root, 'r', input%r)
  endif
  if (associated(input%r1)) then
    !line=49 definition='real(rp), pointer :: r1(:) => null()' name='r1' python_name='r1' type='real' python_type='float' size=None dimension=':' comment='' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list1, 'r1')
    do i1 = lbound(input%r1, 1), ubound(input%r1, 1)
      call json%create_real(json_val, input%r1(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine all_pointer_struct_to_json
subroutine molecular_component_struct_to_json (input, json_root, depth)
  use sim_utils_struct, only: molecular_component_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (molecular_component_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'atom', trim(input%atom))
  call json%add(json_root, 'number', int(input%number))
end subroutine molecular_component_struct_to_json
subroutine nametable_struct_to_json (input, json_root, depth)
  use sim_utils_struct, only: nametable_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (nametable_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%index)) then
    !line=36 definition='integer, allocatable :: index(:)' name='index' python_name='index' type='integer' python_type='int' size=None dimension=':' comment='Sorted index for names(:) array.' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'index')
    do i1 = lbound(input%index, 1), ubound(input%index, 1)
      call json%create_integer(json_val, input%index(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_max', int(input%n_max))
  call json%add(json_root, 'n_min', int(input%n_min))
  if (allocated(input%name)) then
    !line=35 definition='character(40), allocatable :: name(:)' name='name' python_name='name' type='character' python_type='str' size='40' dimension=':' comment='Array of names.' fortran_default=None default='' default_factory='list'
    call json%create_array(json_list1, 'name')
    do i1 = lbound(input%name, 1), ubound(input%name, 1)
      call json%create_string(json_val, trim(input%name(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine nametable_struct_to_json
subroutine str_index_struct_to_json (input, json_root, depth)
  use sim_utils_struct, only: str_index_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (str_index_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%index)) then
    !line=20 definition='integer, allocatable :: index(:)' name='index' python_name='index' type='integer' python_type='int' size=None dimension=':' comment='Sorted index for names(:) array.' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'index')
    do i1 = lbound(input%index, 1), ubound(input%index, 1)
      call json%create_integer(json_val, input%index(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_max', int(input%n_max))
  call json%add(json_root, 'n_min', int(input%n_min))
  if (allocated(input%name)) then
    !line=19 definition='type (var_length_string_struct), allocatable :: name(:)' name='name' python_name='name' type='var_length_string_struct' python_type='VarLengthStringStruct' size=None dimension=':' comment='Array of names.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'name')
    do i1 = lbound(input%name, 1), ubound(input%name, 1)
      call var_length_string_struct_to_json(input%name(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine str_index_struct_to_json
subroutine var_length_string_struct_to_json (input, json_root, depth)
  use sim_utils_struct, only: var_length_string_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (var_length_string_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%str)) then
    call json%add(json_root, 'str_', trim(input%str))
  endif
end subroutine var_length_string_struct_to_json
subroutine out_io_mod_com_struct_to_json (input, json_root, depth)
  use output_mod, only: out_io_mod_com_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (out_io_mod_com_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%buffer)) then
    !line=38 definition='character(300), allocatable :: buffer(:)' name='buffer' python_name='buffer' type='character' python_type='str' size='300' dimension=':' comment='' fortran_default=None default='' default_factory='list'
    call json%create_array(json_list1, 'buffer')
    do i1 = lbound(input%buffer, 1), ubound(input%buffer, 1)
      call json%create_string(json_val, trim(input%buffer(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'capture_lines_null_terminated', input%capture_lines_null_terminated)
  call json%add(json_root, 'capture_state', trim(input%capture_state))
  !line=34 definition='integer :: indent_num(-1:10) = [0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]' name='indent_num' python_name='indent_num' type='integer' python_type='int' size=None dimension='-1:10' comment='' fortran_default='[0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]' default=[0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4] default_factory=''
  call json%create_array(json_list1, 'indent_num')
  do i1 = lbound(input%indent_num, 1), ubound(input%indent_num, 1)
    call json%create_integer(json_val, input%indent_num(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_buffer_lines', int(input%n_buffer_lines))
  call json%add(json_root, 'print_on', input%print_on)
end subroutine out_io_mod_com_struct_to_json
subroutine out_io_output_direct_struct_to_json (input, json_root, depth)
  use output_mod, only: out_io_output_direct_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (out_io_output_direct_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=30 definition='integer :: file_unit(-1:10) = -1' name='file_unit' python_name='file_unit' type='integer' python_type='int' size=None dimension='-1:10' comment='' fortran_default='-1' default=-1 default_factory=''
  call json%create_array(json_list1, 'file_unit')
  do i1 = lbound(input%file_unit, 1), ubound(input%file_unit, 1)
    call json%create_integer(json_val, input%file_unit(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=29 definition='logical :: print_and_capture(-1:10) = .true.' name='print_and_capture' python_name='print_and_capture' type='logical' python_type='bool' size=None dimension='-1:10' comment='' fortran_default='.true.' default=True default_factory=''
  call json%create_array(json_list1, 'print_and_capture')
  do i1 = lbound(input%print_and_capture, 1), ubound(input%print_and_capture, 1)
    call json%create_logical(json_val, input%print_and_capture(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine out_io_output_direct_struct_to_json
subroutine bin_struct_to_json (input, json_root, depth)
  use bin_mod, only: bin_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (bin_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%count)) then
    !line=10 definition='real(rp), allocatable :: count(:)' name='count' python_name='count' type='real' python_type='float' size=None dimension=':' comment='Counts (or weight) in each bin' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'count')
    do i1 = lbound(input%count, 1), ubound(input%count, 1)
      call json%create_real(json_val, input%count(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'delta', input%delta)
  call json%add(json_root, 'max', input%max)
  call json%add(json_root, 'min', input%min)
  call json%add(json_root, 'n', int(input%n))
end subroutine bin_struct_to_json
subroutine general_bin_struct_to_json (input, json_root, depth)
  use bin_mod, only: general_bin_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (general_bin_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%count)) then
    !line=18 definition='real(rp), allocatable :: count(:)' name='count' python_name='count' type='real' python_type='float' size=None dimension=':' comment='Counts (or weight) in each bin' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'count')
    do i1 = lbound(input%count, 1), ubound(input%count, 1)
      call json%create_real(json_val, input%count(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  !line=21 definition='real(rp) :: delta(3)' name='delta' python_name='delta' type='real' python_type='float' size=None dimension='3' comment='Size of a bin' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'delta')
  do i1 = lbound(input%delta, 1), ubound(input%delta, 1)
    call json%create_real(json_val, input%delta(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dim', int(input%dim))
  !line=20 definition='real(rp) :: max(3)' name='max' python_name='max' type='real' python_type='float' size=None dimension='3' comment='' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'max')
  do i1 = lbound(input%max, 1), ubound(input%max, 1)
    call json%create_real(json_val, input%max(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=19 definition='real(rp) :: min(3)' name='min' python_name='min' type='real' python_type='float' size=None dimension='3' comment='Bounds for the bins' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'min')
  do i1 = lbound(input%min, 1), ubound(input%min, 1)
    call json%create_real(json_val, input%min(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=23 definition='integer  :: n(3) = 1' name='n' python_name='n' type='integer' python_type='int' size=None dimension='3' comment='number of bins in each dimension' fortran_default='1' default=1 default_factory=''
  call json%create_array(json_list1, 'n')
  do i1 = lbound(input%n, 1), ubound(input%n, 1)
    call json%create_integer(json_val, input%n(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine general_bin_struct_to_json
subroutine bicubic_cmplx_coef_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: bicubic_cmplx_coef_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (bicubic_cmplx_coef_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=71 definition='complex(rp) :: coef(0:3,0:3) = 0' name='coef' python_name='coef' type='complex' python_type='Complex' size=None dimension='0:3,0:3' comment='Coefs' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%coef, 2), ubound(input%coef, 2)
    call json%create_array(json_list1, 'coef')
    do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
      call complex_to_json(input%coef(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=72 definition='integer :: i_box(2) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='2' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine bicubic_cmplx_coef_struct_to_json
subroutine bicubic_coef_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: bicubic_coef_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (bicubic_coef_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=44 definition='real(rp) :: coef(0:3,0:3) = 0' name='coef' python_name='coef' type='real' python_type='float' size=None dimension='0:3,0:3' comment='Coefs' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%coef, 2), ubound(input%coef, 2)
    call json%create_array(json_list1, 'coef')
    do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
      call json%create_real(json_val, input%coef(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=45 definition='integer :: i_box(2) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='2' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine bicubic_coef_struct_to_json
subroutine cmplx_field1_at_2D_pt_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: cmplx_field1_at_2D_pt_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (cmplx_field1_at_2D_pt_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call complex_to_json(input%d2f_dxdy, json_list1, depth+1)
  call json%rename(json_list1, 'd2f_dxdy')
  call json%add(json_root, json_list1)
  call complex_to_json(input%df_dx, json_list1, depth+1)
  call json%rename(json_list1, 'df_dx')
  call json%add(json_root, json_list1)
  call complex_to_json(input%df_dy, json_list1, depth+1)
  call json%rename(json_list1, 'df_dy')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f, json_list1, depth+1)
  call json%rename(json_list1, 'f')
  call json%add(json_root, json_list1)
end subroutine cmplx_field1_at_2D_pt_struct_to_json
subroutine cmplx_field1_at_3D_pt_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: cmplx_field1_at_3D_pt_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (cmplx_field1_at_3D_pt_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call complex_to_json(input%d2f_dxdy, json_list1, depth+1)
  call json%rename(json_list1, 'd2f_dxdy')
  call json%add(json_root, json_list1)
  call complex_to_json(input%d2f_dxdz, json_list1, depth+1)
  call json%rename(json_list1, 'd2f_dxdz')
  call json%add(json_root, json_list1)
  call complex_to_json(input%d2f_dydz, json_list1, depth+1)
  call json%rename(json_list1, 'd2f_dydz')
  call json%add(json_root, json_list1)
  call complex_to_json(input%d3f_dxdydz, json_list1, depth+1)
  call json%rename(json_list1, 'd3f_dxdydz')
  call json%add(json_root, json_list1)
  call complex_to_json(input%df_dx, json_list1, depth+1)
  call json%rename(json_list1, 'df_dx')
  call json%add(json_root, json_list1)
  call complex_to_json(input%df_dy, json_list1, depth+1)
  call json%rename(json_list1, 'df_dy')
  call json%add(json_root, json_list1)
  call complex_to_json(input%df_dz, json_list1, depth+1)
  call json%rename(json_list1, 'df_dz')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f, json_list1, depth+1)
  call json%rename(json_list1, 'f')
  call json%add(json_root, json_list1)
end subroutine cmplx_field1_at_3D_pt_struct_to_json
subroutine cmplx_field_at_2D_box_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: cmplx_field_at_2D_box_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (cmplx_field_at_2D_box_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=65 definition='integer :: i_box(2) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='2' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=64 definition='type (cmplx_field1_at_2D_pt_struct) pt(0:1, 0:1)' name='pt' python_name='pt' type='cmplx_field1_at_2D_pt_struct' python_type='CmplxField1At2dPtStruct' size=None dimension='0:1, 0:1' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call cmplx_field1_at_2D_pt_struct_to_json(input%pt(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine cmplx_field_at_2D_box_struct_to_json
subroutine cmplx_field_at_3D_box_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: cmplx_field_at_3D_box_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (cmplx_field_at_3D_box_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=121 definition='integer :: i_box(3) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='3' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=120 definition='type (cmplx_field1_at_3D_pt_struct) pt(0:1, 0:1, 0:1)' name='pt' python_name='pt' type='cmplx_field1_at_3D_pt_struct' python_type='CmplxField1At3dPtStruct' size=None dimension='0:1, 0:1, 0:1' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%pt, 3), ubound(input%pt, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call cmplx_field1_at_3D_pt_struct_to_json(input%pt(i1, i2, i3), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
end subroutine cmplx_field_at_3D_box_struct_to_json
subroutine field1_at_2D_pt_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: field1_at_2D_pt_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (field1_at_2D_pt_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'd2f_dxdy', input%d2f_dxdy)
  call json%add(json_root, 'df_dx', input%df_dx)
  call json%add(json_root, 'df_dy', input%df_dy)
  call json%add(json_root, 'f', input%f)
end subroutine field1_at_2D_pt_struct_to_json
subroutine field1_at_3D_pt_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: field1_at_3D_pt_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (field1_at_3D_pt_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'd2f_dxdy', input%d2f_dxdy)
  call json%add(json_root, 'd2f_dxdz', input%d2f_dxdz)
  call json%add(json_root, 'd2f_dydz', input%d2f_dydz)
  call json%add(json_root, 'd3f_dxdydz', input%d3f_dxdydz)
  call json%add(json_root, 'df_dx', input%df_dx)
  call json%add(json_root, 'df_dy', input%df_dy)
  call json%add(json_root, 'df_dz', input%df_dz)
  call json%add(json_root, 'f', input%f)
end subroutine field1_at_3D_pt_struct_to_json
subroutine field_at_2D_box_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: field_at_2D_box_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (field_at_2D_box_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=38 definition='integer :: i_box(2) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='2' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=37 definition='type (field1_at_2D_pt_struct) pt(0:1, 0:1)' name='pt' python_name='pt' type='field1_at_2D_pt_struct' python_type='Field1At2dPtStruct' size=None dimension='0:1, 0:1' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call field1_at_2D_pt_struct_to_json(input%pt(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine field_at_2D_box_struct_to_json
subroutine field_at_3D_box_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: field_at_3D_box_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (field_at_3D_box_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=93 definition='integer :: i_box(3) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='3' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=92 definition='type (field1_at_3D_pt_struct) pt(0:1, 0:1, 0:1)' name='pt' python_name='pt' type='field1_at_3D_pt_struct' python_type='Field1At3dPtStruct' size=None dimension='0:1, 0:1, 0:1' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%pt, 3), ubound(input%pt, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call field1_at_3D_pt_struct_to_json(input%pt(i1, i2, i3), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
end subroutine field_at_3D_box_struct_to_json
subroutine tricubic_cmplx_coef_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: tricubic_cmplx_coef_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (tricubic_cmplx_coef_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=127 definition='complex(rp) :: coef(0:3,0:3,0:3) = 0' name='coef' python_name='coef' type='complex' python_type='Complex' size=None dimension='0:3,0:3,0:3' comment='Coefs' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%coef, 3), ubound(input%coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%coef, 2), ubound(input%coef, 2)
      call json%create_array(json_list1, 'coef')
      do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
        call complex_to_json(input%coef(i1, i2, i3), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !line=128 definition='integer :: i_box(3) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='3' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine tricubic_cmplx_coef_struct_to_json
subroutine tricubic_coef_struct_to_json (input, json_root, depth)
  use cubic_interpolation_mod, only: tricubic_coef_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (tricubic_coef_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=99 definition='real(rp) :: coef(0:3,0:3,0:3) = 0' name='coef' python_name='coef' type='real' python_type='float' size=None dimension='0:3,0:3,0:3' comment='Coefs' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%coef, 3), ubound(input%coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%coef, 2), ubound(input%coef, 2)
      call json%create_array(json_list1, 'coef')
      do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
        call json%create_real(json_val, input%coef(i1, i2, i3), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_list3, json_list2)
    nullify(json_list2)
  enddo
  call json%add(json_root, json_list3)
  nullify(json_list3)
  !line=100 definition='integer :: i_box(3) = int_garbage$' name='i_box' python_name='i_box' type='integer' python_type='int' size=None dimension='3' comment='index at lower box corner.' fortran_default='int_garbage$' default=0 default_factory=''
  call json%create_array(json_list1, 'i_box')
  do i1 = lbound(input%i_box, 1), ubound(input%i_box, 1)
    call json%create_integer(json_val, input%i_box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine tricubic_coef_struct_to_json
subroutine random_state_struct_to_json (input, json_root, depth)
  use random_mod, only: random_state_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (random_state_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'am', input%am)
  call json%add(json_root, 'engine', int(input%engine))
  call json%add(json_root, 'gauss_converter', int(input%gauss_converter))
  call json%add(json_root, 'gauss_sigma_cut', input%gauss_sigma_cut)
  call json%add(json_root, 'h_saved', input%h_saved)
  call json%add(json_root, 'in_sobseq', int(input%in_sobseq))
  call json%add(json_root, 'ix', int(input%ix))
  !line=38 definition='integer(i4_b) :: ix_sobseq(sobseq_maxdim) = 0' name='ix_sobseq' python_name='ix_sobseq' type='integer' python_type='int' size=None dimension='sobseq_maxdim' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'ix_sobseq')
  do i1 = lbound(input%ix_sobseq, 1), ubound(input%ix_sobseq, 1)
    call json%create_integer(json_val, input%ix_sobseq(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'iy', int(input%iy))
  call json%add(json_root, 'number_stored', input%number_stored)
  call json%add(json_root, 'seed', int(input%seed))
  !line=39 definition='real(rp) :: x_sobseq(sobseq_maxdim) = 0' name='x_sobseq' python_name='x_sobseq' type='real' python_type='float' size=None dimension='sobseq_maxdim' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'x_sobseq')
  do i1 = lbound(input%x_sobseq, 1), ubound(input%x_sobseq, 1)
    call json%create_real(json_val, input%x_sobseq(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine random_state_struct_to_json
subroutine spline_struct_to_json (input, json_root, depth)
  use spline_mod, only: spline_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (spline_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  !line=21 definition='real(rp) :: coef(0:3) = 0' name='coef' python_name='coef' type='real' python_type='float' size=None dimension='0:3' comment='coefficients for cubic spline' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'coef')
  do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
    call json%create_real(json_val, input%coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'x1', input%x1)
  call json%add(json_root, 'y0', input%y0)
end subroutine spline_struct_to_json
subroutine super_mrqmin_storage_struct_to_json (input, json_root, depth)
  use super_recipes_mod, only: super_mrqmin_storage_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (super_mrqmin_storage_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  if (allocated(input%alpha)) then
    !line=15 definition='real(rp), allocatable :: alpha(:, :)' name='alpha' python_name='alpha' type='real' python_type='float' size=None dimension=':, :' comment='Curvature matrix. See mrqmin in NR for more details.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%alpha, 2), ubound(input%alpha, 2)
      call json%create_array(json_list1, 'alpha')
      do i1 = lbound(input%alpha, 1), ubound(input%alpha, 1)
        call json%create_real(json_val, input%alpha(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%atry)) then
    !line=16 definition='real(rp), allocatable :: atry(:), beta(:)' name='atry' python_name='atry' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'atry')
    do i1 = lbound(input%atry, 1), ubound(input%atry, 1)
      call json%create_real(json_val, input%atry(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%beta)) then
    !line=16 definition='real(rp), allocatable :: atry(:), beta(:)' name='beta' python_name='beta' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'beta')
    do i1 = lbound(input%beta, 1), ubound(input%beta, 1)
      call json%create_real(json_val, input%beta(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%covar)) then
    !line=14 definition='real(rp), allocatable :: covar(:, :)' name='covar' python_name='covar' type='real' python_type='float' size=None dimension=':, :' comment='Covariance matrix. See mrqmin in NR for more details.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%covar, 2), ubound(input%covar, 2)
      call json%create_array(json_list1, 'covar')
      do i1 = lbound(input%covar, 1), ubound(input%covar, 1)
        call json%create_real(json_val, input%covar(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%da)) then
    !line=17 definition='real(rp), allocatable :: da(:,:)' name='da' python_name='da' type='real' python_type='float' size=None dimension=':,:' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%da, 2), ubound(input%da, 2)
      call json%create_array(json_list1, 'da')
      do i1 = lbound(input%da, 1), ubound(input%da, 1)
        call json%create_real(json_val, input%da(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%dy)) then
    !line=21 definition='real(rp), allocatable :: old_dy(:), dy(:), wt(:), ymod(:)' name='dy' python_name='dy' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'dy')
    do i1 = lbound(input%dy, 1), ubound(input%dy, 1)
      call json%create_real(json_val, input%dy(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%dyda)) then
    !line=20 definition='real(rp), allocatable :: dyda(:, :)' name='dyda' python_name='dyda' type='real' python_type='float' size=None dimension=':, :' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%dyda, 2), ubound(input%dyda, 2)
      call json%create_array(json_list1, 'dyda')
      do i1 = lbound(input%dyda, 1), ubound(input%dyda, 1)
        call json%create_real(json_val, input%dyda(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%mask)) then
    !line=19 definition='logical, allocatable :: mask(:)' name='mask' python_name='mask' type='logical' python_type='bool' size=None dimension=':' comment='' fortran_default=None default=False default_factory=''
    call json%create_array(json_list1, 'mask')
    do i1 = lbound(input%mask, 1), ubound(input%mask, 1)
      call json%create_logical(json_val, input%mask(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ochisq', input%ochisq)
  if (allocated(input%old_dy)) then
    !line=21 definition='real(rp), allocatable :: old_dy(:), dy(:), wt(:), ymod(:)' name='old_dy' python_name='old_dy' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'old_dy')
    do i1 = lbound(input%old_dy, 1), ubound(input%old_dy, 1)
      call json%create_real(json_val, input%old_dy(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%wt)) then
    !line=21 definition='real(rp), allocatable :: old_dy(:), dy(:), wt(:), ymod(:)' name='wt' python_name='wt' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'wt')
    do i1 = lbound(input%wt, 1), ubound(input%wt, 1)
      call json%create_real(json_val, input%wt(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ymod)) then
    !line=21 definition='real(rp), allocatable :: old_dy(:), dy(:), wt(:), ymod(:)' name='ymod' python_name='ymod' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'ymod')
    do i1 = lbound(input%ymod, 1), ubound(input%ymod, 1)
      call json%create_real(json_val, input%ymod(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine super_mrqmin_storage_struct_to_json
subroutine wls_struct_to_json (input, json_root, depth)
  use windowls_mod, only: wls_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (wls_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'n', int(input%N))
  if (allocated(input%Q1)) then
    !line=41 definition='REAL(rp), ALLOCATABLE :: Q1(:,:)' name='Q1' python_name='q1' type='REAL' python_type='float' size=None dimension=':,:' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%Q1, 2), ubound(input%Q1, 2)
      call json%create_array(json_list1, 'q1')
      do i1 = lbound(input%Q1, 1), ubound(input%Q1, 1)
        call json%create_real(json_val, input%Q1(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%R1)) then
    !line=40 definition='REAL(rp), ALLOCATABLE :: R1(:,:)' name='R1' python_name='r1' type='REAL' python_type='float' size=None dimension=':,:' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%R1, 2), ubound(input%R1, 2)
      call json%create_array(json_list1, 'r1')
      do i1 = lbound(input%R1, 1), ubound(input%R1, 1)
        call json%create_real(json_val, input%R1(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'der', int(input%der))
  call json%add(json_root, 'order', int(input%order))
  call json%add(json_root, 'xend', input%xend)
  if (allocated(input%y)) then
    !line=46 definition='REAL(rp), ALLOCATABLE :: y(:)' name='y' python_name='y' type='REAL' python_type='float' size=None dimension=':' comment='holds data' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'y')
    do i1 = lbound(input%y, 1), ubound(input%y, 1)
      call json%create_real(json_val, input%y(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine wls_struct_to_json
subroutine c_dummy_struct_to_json (input, json_root, depth)
  use fortran_cpp_utils, only: c_dummy_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (c_dummy_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'dummy', input%dummy)
end subroutine c_dummy_struct_to_json
subroutine opti_de_param_struct_to_json (input, json_root, depth)
  use opti_de_mod, only: opti_de_param_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (opti_de_param_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'cr', input%CR)
  call json%add(json_root, 'f', input%F)
  call json%add(json_root, 'binomial_cross', input%binomial_cross)
  call json%add(json_root, 'l_best', input%l_best)
  call json%add(json_root, 'minimize_merit', input%minimize_merit)
  call json%add(json_root, 'randomize_f', input%randomize_F)
  call json%add(json_root, 'use_2nd_diff', input%use_2nd_diff)
end subroutine opti_de_param_struct_to_json
subroutine pg_interface_struct_to_json (input, json_root, depth)
  use pgplot_interface, only: pg_interface_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (pg_interface_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'i_chan', int(input%i_chan))
  call json%add(json_root, 'page_scale', input%page_scale)
  call json%add(json_root, 'page_type', trim(input%page_type))
  call json%add(json_root, 'plot_file', trim(input%plot_file))
  call json%add(json_root, 'qp_to_pg_text_height_factor', input%qp_to_pg_text_height_factor)
end subroutine pg_interface_struct_to_json
subroutine qp_arrow_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_arrow_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_arrow_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'head_angle', input%head_angle)
  call json%add(json_root, 'head_barb', input%head_barb)
  call json%add(json_root, 'head_size', input%head_size)
  call json%add(json_root, 'head_type', trim(input%head_type))
end subroutine qp_arrow_struct_to_json
subroutine qp_axis_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_axis_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_axis_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'bounds', trim(input%bounds))
  call json%add(json_root, 'draw_label', input%draw_label)
  call json%add(json_root, 'draw_numbers', input%draw_numbers)
  call json%add(json_root, 'dtick', input%dtick)
  call json%add(json_root, 'eval_max', input%eval_max)
  call json%add(json_root, 'eval_min', input%eval_min)
  call json%add(json_root, 'label', trim(input%label))
  call json%add(json_root, 'label_color', trim(input%label_color))
  call json%add(json_root, 'label_offset', input%label_offset)
  call json%add(json_root, 'major_div', int(input%major_div))
  call json%add(json_root, 'major_div_nominal', int(input%major_div_nominal))
  call json%add(json_root, 'major_tick_len', input%major_tick_len)
  call json%add(json_root, 'max', input%max)
  call json%add(json_root, 'min', input%min)
  call json%add(json_root, 'minor_div', int(input%minor_div))
  call json%add(json_root, 'minor_div_max', int(input%minor_div_max))
  call json%add(json_root, 'minor_tick_len', input%minor_tick_len)
  call json%add(json_root, 'number_offset', input%number_offset)
  call json%add(json_root, 'number_side', int(input%number_side))
  call json%add(json_root, 'places', int(input%places))
  call json%add(json_root, 'tick_max', input%tick_max)
  call json%add(json_root, 'tick_min', input%tick_min)
  call json%add(json_root, 'tick_side', int(input%tick_side))
  call json%add(json_root, 'type', trim(input%type))
end subroutine qp_axis_struct_to_json
subroutine qp_legend_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_legend_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_legend_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'draw_line', input%draw_line)
  call json%add(json_root, 'draw_symbol', input%draw_symbol)
  call json%add(json_root, 'draw_text', input%draw_text)
  call json%add(json_root, 'line_length', input%line_length)
  call json%add(json_root, 'row_spacing', input%row_spacing)
  call json%add(json_root, 'text_offset', input%text_offset)
end subroutine qp_legend_struct_to_json
subroutine qp_line_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_line_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_line_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'pattern', trim(input%pattern))
  call json%add(json_root, 'width', int(input%width))
end subroutine qp_line_struct_to_json
subroutine qp_plot_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_plot_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_plot_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'draw_box', input%draw_box)
  call json%add(json_root, 'draw_grid', input%draw_grid)
  call json%add(json_root, 'draw_title', input%draw_title)
  call json%add(json_root, 'title', trim(input%title))
  call qp_axis_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%x2, json_val, depth + 1)
  call json%rename(json_val, 'x2')
  call json%add(json_root, json_val)
  call json%add(json_root, 'x2_mirrors_x', input%x2_mirrors_x)
  call json%add(json_root, 'x_is_active_axis', input%x_is_active_axis)
  if (associated(input%xx)) then
    call qp_axis_struct_to_json(input%xx, json_val, depth + 1)
    call json%rename(json_val, 'xx')
    call json%add(json_root, json_val)
  endif
  call qp_axis_struct_to_json(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%y2, json_val, depth + 1)
  call json%rename(json_val, 'y2')
  call json%add(json_root, json_val)
  call json%add(json_root, 'y2_mirrors_y', input%y2_mirrors_y)
  call json%add(json_root, 'y_is_active_axis', input%y_is_active_axis)
  if (associated(input%yy)) then
    call qp_axis_struct_to_json(input%yy, json_val, depth + 1)
    call json%rename(json_val, 'yy')
    call json%add(json_root, json_val)
  endif
end subroutine qp_plot_struct_to_json
subroutine qp_point_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_point_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_point_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
end subroutine qp_point_struct_to_json
subroutine qp_rect_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_rect_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_rect_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'x1', input%x1)
  call json%add(json_root, 'x2', input%x2)
  call json%add(json_root, 'y1', input%y1)
  call json%add(json_root, 'y2', input%y2)
end subroutine qp_rect_struct_to_json
subroutine qp_state_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_state_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_state_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call qp_arrow_struct_to_json(input%arrow, json_val, depth + 1)
  call json%rename(json_val, 'arrow')
  call json%add(json_root, json_val)
  call qp_text_struct_to_json(input%axis_label, json_val, depth + 1)
  call json%rename(json_val, 'axis_label')
  call json%add(json_root, json_val)
  call qp_line_struct_to_json(input%axis_line, json_val, depth + 1)
  call json%rename(json_val, 'axis_line')
  call json%add(json_root, json_val)
  call qp_text_struct_to_json(input%axis_number, json_val, depth + 1)
  call json%rename(json_val, 'axis_number')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%border, json_val, depth + 1)
  call json%rename(json_val, 'border')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%box, json_val, depth + 1)
  call json%rename(json_val, 'box')
  call json%add(json_root, json_val)
  call json%add(json_root, 'buffer', input%buffer)
  call json%add(json_root, 'clip', input%clip)
  call json%add(json_root, 'dflt_axis_slop_factor', input%dflt_axis_slop_factor)
  !line=176 definition="character(8) :: dflt_draw_units(3) = ['DATA ', 'GRAPH', 'LB   ' ]" name='dflt_draw_units' python_name='dflt_draw_units' type='character' python_type='str' size='8' dimension='3' comment='' fortran_default="['DATA ', 'GRAPH', 'LB   ' ]" default=['DATA ', 'GRAPH', 'LB   '] default_factory=''
  call json%create_array(json_list1, 'dflt_draw_units')
  do i1 = lbound(input%dflt_draw_units, 1), ubound(input%dflt_draw_units, 1)
    call json%create_string(json_val, trim(input%dflt_draw_units(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=177 definition="character(8) :: dflt_set_units(3)  = ['INCH ', 'PAGE ', 'LB   ' ]" name='dflt_set_units' python_name='dflt_set_units' type='character' python_type='str' size='8' dimension='3' comment='' fortran_default="['INCH ', 'PAGE ', 'LB   ' ]" default=['INCH ', 'PAGE ', 'LB   '] default_factory=''
  call json%create_array(json_list1, 'dflt_set_units')
  do i1 = lbound(input%dflt_set_units, 1), ubound(input%dflt_set_units, 1)
    call json%create_string(json_val, trim(input%dflt_set_units(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dflt_units', int(input%dflt_units))
  call qp_rect_struct_to_json(input%graph, json_val, depth + 1)
  call json%rename(json_val, 'graph')
  call json%add(json_root, json_val)
  call qp_text_struct_to_json(input%graph_title, json_val, depth + 1)
  call json%rename(json_val, 'graph_title')
  call json%add(json_root, json_val)
  call qp_line_struct_to_json(input%grid_line, json_val, depth + 1)
  call json%rename(json_val, 'grid_line')
  call json%add(json_root, json_val)
  call qp_text_struct_to_json(input%legend, json_val, depth + 1)
  call json%rename(json_val, 'legend')
  call json%add(json_root, json_val)
  call qp_line_struct_to_json(input%legend_line, json_val, depth + 1)
  call json%rename(json_val, 'legend_line')
  call json%add(json_root, json_val)
  call qp_text_struct_to_json(input%main_title, json_val, depth + 1)
  call json%rename(json_val, 'main_title')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%margin, json_val, depth + 1)
  call json%rename(json_val, 'margin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'max_axis_zero_digits', int(input%max_axis_zero_digits))
  call json%add(json_root, 'max_digits', int(input%max_digits))
  call qp_rect_struct_to_json(input%page, json_val, depth + 1)
  call json%rename(json_val, 'page')
  call json%add(json_root, json_val)
  call json%add(json_root, 'page_type', trim(input%page_type))
  call qp_plot_struct_to_json(input%plot, json_val, depth + 1)
  call json%rename(json_val, 'plot')
  call json%add(json_root, json_val)
  call json%add(json_root, 'plot_file', trim(input%plot_file))
  call qp_line_struct_to_json(input%plot_line, json_val, depth + 1)
  call json%rename(json_val, 'plot_line')
  call json%add(json_root, json_val)
  call qp_line_struct_to_json(input%std_line, json_val, depth + 1)
  call json%rename(json_val, 'std_line')
  call json%add(json_root, json_val)
  call json%add(json_root, 'subgraph_on', input%subgraph_on)
  call qp_symbol_struct_to_json(input%symbol, json_val, depth + 1)
  call json%rename(json_val, 'symbol')
  call json%add(json_root, json_val)
  call qp_text_struct_to_json(input%text, json_val, depth + 1)
  call json%rename(json_val, 'text')
  call json%add(json_root, json_val)
  call json%add(json_root, 'text_background', trim(input%text_background))
  call json%add(json_root, 'text_scale', input%text_scale)
  call json%add(json_root, 'text_spacing_factor', input%text_spacing_factor)
  call qp_text_struct_to_json(input%this_text, json_val, depth + 1)
  call json%rename(json_val, 'this_text')
  call json%add(json_root, json_val)
  call json%add(json_root, 'uniform_symbol_size', input%uniform_symbol_size)
end subroutine qp_state_struct_to_json
subroutine qp_symbol_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_symbol_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_symbol_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'fill_pattern', trim(input%fill_pattern))
  call json%add(json_root, 'height', input%height)
  call json%add(json_root, 'line_width', int(input%line_width))
  call json%add(json_root, 'type', trim(input%type))
end subroutine qp_symbol_struct_to_json
subroutine qp_text_struct_to_json (input, json_root, depth)
  use quick_plot_struct, only: qp_text_struct
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  implicit none
  type(json_core) :: json
  type (qp_text_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
  call json%create_object(json_root, '')
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'height', input%height)
  call json%add(json_root, 'uniform_spacing', input%uniform_spacing)
end subroutine qp_text_struct_to_json
end module sim_utils_json