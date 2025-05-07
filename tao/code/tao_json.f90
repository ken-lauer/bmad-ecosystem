module tao_json
use json_module
use json_string_utilities, only: integer_to_string
use json_kinds, only: CK
contains
subroutine complex_to_json (input, json_root, depth)
  use json_module
  use json_kinds, only: CK
  use precision_def, only: dp
  implicit none
  type(json_core) :: json
  type (complex(dp)), intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  call json%create_array(json_root, '')
  call json%create_real(json_val, real(input), '')
  call json%add(json_root, json_val)
  call json%create_real(json_val, aimag(input), '')
  call json%add(json_root, json_val)
end subroutine complex_to_json
subroutine tao_cmd_history_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_cmd_history_struct
  implicit none
  type(json_core) :: json
  type (tao_cmd_history_struct), pointer, intent(in) :: input
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
  if (allocated(input%cmd)) then
    call json%add(json_root, 'cmd', trim(input%cmd))
  endif
  call json%add(json_root, 'ix', int(input%ix))
end subroutine tao_cmd_history_struct_to_json
subroutine tao_real_pointer_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_real_pointer_struct
  implicit none
  type(json_core) :: json
  type (tao_real_pointer_struct), pointer, intent(in) :: input
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
  if (associated(input%r)) then
    call json%add(json_root, 'r', input%r)
  endif
  if (associated(input%good_value)) then
    call json%add(json_root, 'good_value', input%good_value)
  endif
  if (associated(input%good_user)) then
    call json%add(json_root, 'good_user', input%good_user)
  endif
end subroutine tao_real_pointer_struct_to_json
subroutine tao_logical_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_logical_array_struct
  implicit none
  type(json_core) :: json
  type (tao_logical_array_struct), pointer, intent(in) :: input
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
  if (associated(input%l)) then
    call json%add(json_root, 'l', input%l)
  endif
end subroutine tao_logical_array_struct_to_json
subroutine tao_integer_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_integer_array_struct
  implicit none
  type(json_core) :: json
  type (tao_integer_array_struct), pointer, intent(in) :: input
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
end subroutine tao_integer_array_struct_to_json
subroutine tao_string_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_string_array_struct
  implicit none
  type(json_core) :: json
  type (tao_string_array_struct), pointer, intent(in) :: input
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
  if (associated(input%s)) then
    call json%add(json_root, 's', trim(input%s))
  endif
end subroutine tao_string_array_struct_to_json
subroutine tao_expression_info_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_expression_info_struct
  use bmad_json, only: ele_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_expression_info_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'good', input%good)
  if (associated(input%ele)) then
    call ele_struct_to_json(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 's', input%s)
end subroutine tao_expression_info_struct_to_json
subroutine tao_eval_stack1_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_eval_stack1_struct
  implicit none
  type(json_core) :: json
  type (tao_eval_stack1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'scale', input%scale)
  if (allocated(input%value)) then
    !line=100 definition='real(rp), allocatable :: value(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='value' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'value')
    do i1 = lbound(input%value, 1), ubound(input%value, 1)
      call json%create_real(json_val, input%value(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%info)) then
    !line=101 definition='type (tao_expression_info_struct), allocatable :: info(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_expression_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='info' type='type' size='tao_expression_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'info')
    do i1 = lbound(input%info, 1), ubound(input%info, 1)
      call tao_expression_info_struct_to_json(input%info(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%value_ptr)) then
    !line=102 definition='type (tao_real_pointer_struct), allocatable :: value_ptr(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_real_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='value_ptr' type='type' size='tao_real_pointer_struct' dimension=':' comment='Used to point to data, lattice parameters, etc' default=None
    call json%create_array(json_list1, 'value_ptr')
    do i1 = lbound(input%value_ptr, 1), ubound(input%value_ptr, 1)
      call tao_real_pointer_struct_to_json(input%value_ptr(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_eval_stack1_struct_to_json
subroutine tao_ele_pointer_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_ele_pointer_struct
  use bmad_json, only: ele_pointer_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_ele_pointer_struct), pointer, intent(in) :: input
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
  if (allocated(input%eles)) then
    !line=108 definition='type (ele_pointer_struct), allocatable :: eles(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ele_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='eles' type='type' size='ele_pointer_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'eles')
    do i1 = lbound(input%eles, 1), ubound(input%eles, 1)
      call ele_pointer_struct_to_json(input%eles(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_loc', int(input%n_loc))
end subroutine tao_ele_pointer_struct_to_json
subroutine tao_ele_shape_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_ele_shape_struct
  implicit none
  type(json_core) :: json
  type (tao_ele_shape_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ele_id', trim(input%ele_id))
  call json%add(json_root, 'shape', trim(input%shape))
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'size', input%size)
  call json%add(json_root, 'label', trim(input%label))
  call json%add(json_root, 'draw', input%draw)
  call json%add(json_root, 'multi', input%multi)
  call json%add(json_root, 'line_width', int(input%line_width))
  call json%add(json_root, 'offset', input%offset)
  call json%add(json_root, 'ix_key', int(input%ix_key))
  call json%add(json_root, 'name_ele', trim(input%name_ele))
  if (allocated(input%uni)) then
    !line=125 definition='type (tao_ele_pointer_struct), allocatable :: uni(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_ele_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='uni' type='type' size='tao_ele_pointer_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'uni')
    do i1 = lbound(input%uni, 1), ubound(input%uni, 1)
      call tao_ele_pointer_struct_to_json(input%uni(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_ele_shape_struct_to_json
subroutine tao_drawing_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_drawing_struct
  implicit none
  type(json_core) :: json
  type (tao_drawing_struct), pointer, intent(in) :: input
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
  if (allocated(input%ele_shape)) then
    !line=129 definition='type (tao_ele_shape_struct), allocatable :: ele_shape(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_ele_shape_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele_shape' type='type' size='tao_ele_shape_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'ele_shape')
    do i1 = lbound(input%ele_shape, 1), ubound(input%ele_shape, 1)
      call tao_ele_shape_struct_to_json(input%ele_shape(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_drawing_struct_to_json
subroutine tao_shape_pattern_point_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_shape_pattern_point_struct
  implicit none
  type(json_core) :: json
  type (tao_shape_pattern_point_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'y', input%y)
  call json%add(json_root, 'radius', input%radius)
end subroutine tao_shape_pattern_point_struct_to_json
subroutine tao_shape_pattern_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_shape_pattern_struct
  use sim_utils_json, only: qp_line_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_shape_pattern_struct), pointer, intent(in) :: input
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
  call qp_line_struct_to_json(input%line, json_val, depth + 1)
  call json%rename(json_val, 'line')
  call json%add(json_root, json_val)
  if (allocated(input%pt)) then
    !line=139 definition='type (tao_shape_pattern_point_struct), allocatable :: pt(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_shape_pattern_point_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='tao_shape_pattern_point_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call tao_shape_pattern_point_struct_to_json(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_shape_pattern_struct_to_json
subroutine tao_title_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_title_struct
  implicit none
  type(json_core) :: json
  type (tao_title_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'string', trim(input%string))
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'justify', trim(input%justify))
  call json%add(json_root, 'draw_it', input%draw_it)
end subroutine tao_title_struct_to_json
subroutine tao_data_var_component_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_data_var_component_struct
  implicit none
  type(json_core) :: json
  type (tao_data_var_component_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'sign', input%sign)
end subroutine tao_data_var_component_struct_to_json
subroutine tao_histogram_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_histogram_struct
  implicit none
  type(json_core) :: json
  type (tao_histogram_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'density_normalized', input%density_normalized)
  call json%add(json_root, 'weight_by_charge', input%weight_by_charge)
  call json%add(json_root, 'minimum', input%minimum)
  call json%add(json_root, 'maximum', input%maximum)
  call json%add(json_root, 'width', input%width)
  call json%add(json_root, 'center', input%center)
  call json%add(json_root, 'number', int(input%number))
end subroutine tao_histogram_struct_to_json
subroutine tao_curve_orbit_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_curve_orbit_struct
  implicit none
  type(json_core) :: json
  type (tao_curve_orbit_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  call json%add(json_root, 't', input%t)
end subroutine tao_curve_orbit_struct_to_json
subroutine tao_curve_color_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_curve_color_struct
  implicit none
  type(json_core) :: json
  type (tao_curve_color_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'data_type', trim(input%data_type))
  call json%add(json_root, 'is_on', input%is_on)
  call json%add(json_root, 'min', input%min)
  call json%add(json_root, 'max', input%max)
  call json%add(json_root, 'autoscale', input%autoscale)
end subroutine tao_curve_color_struct_to_json
subroutine tao_curve_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_curve_struct
  use sim_utils_json, only: qp_line_struct_to_json, qp_symbol_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_curve_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'data_source', trim(input%data_source))
  call json%add(json_root, 'data_index', trim(input%data_index))
  call json%add(json_root, 'data_type_x', trim(input%data_type_x))
  if (allocated(input%data_type)) then
    call json%add(json_root, 'data_type', trim(input%data_type))
  endif
  call json%add(json_root, 'ele_ref_name', trim(input%ele_ref_name))
  call json%add(json_root, 'legend_text', trim(input%legend_text))
  call json%add(json_root, 'message_text', trim(input%message_text))
  call json%add(json_root, 'component', trim(input%component))
  call json%add(json_root, 'why_invalid', trim(input%why_invalid))
  ! parent pointer skip: g (type, pointer to parent graph)
  call tao_histogram_struct_to_json(input%hist, json_val, depth + 1)
  call json%rename(json_val, 'hist')
  call json%add(json_root, json_val)
  call tao_curve_color_struct_to_json(input%z_color, json_val, depth + 1)
  call json%rename(json_val, 'z_color')
  call json%add(json_root, json_val)
  if (allocated(input%x_line)) then
    !line=203 definition='real(rp), allocatable :: x_line(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='x_line' type='real' size='rp' dimension=':' comment='Coords for drawing a curve' default=None
    call json%create_array(json_list1, 'x_line')
    do i1 = lbound(input%x_line, 1), ubound(input%x_line, 1)
      call json%create_real(json_val, input%x_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_line)) then
    !line=204 definition='real(rp), allocatable :: y_line(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y_line' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_line')
    do i1 = lbound(input%y_line, 1), ubound(input%y_line, 1)
      call json%create_real(json_val, input%y_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y2_line)) then
    !line=205 definition='real(rp), allocatable :: y2_line(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y2_line' type='real' size='rp' dimension=':' comment='Second array needed for beam chamber curve.' default=None
    call json%create_array(json_list1, 'y2_line')
    do i1 = lbound(input%y2_line, 1), ubound(input%y2_line, 1)
      call json%create_real(json_val, input%y2_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ix_line)) then
    !line=206 definition='integer, allocatable :: ix_line(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ix_line' type='integer' size=None dimension=':' comment='Used by wave and aperture curves.' default=None
    call json%create_array(json_list1, 'ix_line')
    do i1 = lbound(input%ix_line, 1), ubound(input%ix_line, 1)
      call json%create_integer(json_val, input%ix_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%x_symb)) then
    !line=207 definition='real(rp), allocatable :: x_symb(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='x_symb' type='real' size='rp' dimension=':' comment='Coords for drawing the symbols' default=None
    call json%create_array(json_list1, 'x_symb')
    do i1 = lbound(input%x_symb, 1), ubound(input%x_symb, 1)
      call json%create_real(json_val, input%x_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_symb)) then
    !line=208 definition='real(rp), allocatable :: y_symb(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y_symb' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_symb')
    do i1 = lbound(input%y_symb, 1), ubound(input%y_symb, 1)
      call json%create_real(json_val, input%y_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%z_symb)) then
    !line=209 definition='real(rp), allocatable :: z_symb(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='z_symb' type='real' size='rp' dimension=':' comment='Symbol color' default=None
    call json%create_array(json_list1, 'z_symb')
    do i1 = lbound(input%z_symb, 1), ubound(input%z_symb, 1)
      call json%create_real(json_val, input%z_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%err_symb)) then
    !line=210 definition='real(rp), allocatable :: err_symb(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='err_symb' type='real' size='rp' dimension=':' comment='Error bars' default=None
    call json%create_array(json_list1, 'err_symb')
    do i1 = lbound(input%err_symb, 1), ubound(input%err_symb, 1)
      call json%create_real(json_val, input%err_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%symb_size)) then
    !line=211 definition='real(rp), allocatable :: symb_size(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='symb_size' type='real' size='rp' dimension=':' comment='Symbol size. Used with symbol_size_scale.' default=None
    call json%create_array(json_list1, 'symb_size')
    do i1 = lbound(input%symb_size, 1), ubound(input%symb_size, 1)
      call json%create_real(json_val, input%symb_size(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ix_symb)) then
    !line=212 definition='integer, allocatable :: ix_symb(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ix_symb' type='integer' size=None dimension=':' comment='Corresponding index in d1_data%d(:) array.' default=None
    call json%create_array(json_list1, 'ix_symb')
    do i1 = lbound(input%ix_symb, 1), ubound(input%ix_symb, 1)
      call json%create_integer(json_val, input%ix_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'y_axis_scale_factor', input%y_axis_scale_factor)
  call qp_line_struct_to_json(input%line, json_val, depth + 1)
  call json%rename(json_val, 'line')
  call json%add(json_root, json_val)
  call qp_symbol_struct_to_json(input%symbol, json_val, depth + 1)
  call json%rename(json_val, 'symbol')
  call json%add(json_root, json_val)
  call tao_curve_orbit_struct_to_json(input%orbit, json_val, depth + 1)
  call json%rename(json_val, 'orbit')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'symbol_every', int(input%symbol_every))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call json%add(json_root, 'n_turn', int(input%n_turn))
  call json%add(json_root, 'use_y2', input%use_y2)
  call json%add(json_root, 'draw_line', input%draw_line)
  call json%add(json_root, 'draw_symbols', input%draw_symbols)
  call json%add(json_root, 'draw_symbol_index', input%draw_symbol_index)
  call json%add(json_root, 'draw_error_bars', input%draw_error_bars)
  call json%add(json_root, 'smooth_line_calc', input%smooth_line_calc)
  call json%add(json_root, 'valid', input%valid)
end subroutine tao_curve_struct_to_json
subroutine tao_floor_plan_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_floor_plan_struct
  implicit none
  type(json_core) :: json
  type (tao_floor_plan_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'view', trim(input%view))
  call json%add(json_root, 'rotation', input%rotation)
  call json%add(json_root, 'correct_distortion', input%correct_distortion)
  call json%add(json_root, 'flip_label_side', input%flip_label_side)
  call json%add(json_root, 'size_is_absolute', input%size_is_absolute)
  call json%add(json_root, 'draw_only_first_pass', input%draw_only_first_pass)
  call json%add(json_root, 'draw_building_wall', input%draw_building_wall)
  call json%add(json_root, 'orbit_scale', input%orbit_scale)
  call json%add(json_root, 'orbit_color', trim(input%orbit_color))
  call json%add(json_root, 'orbit_pattern', trim(input%orbit_pattern))
  call json%add(json_root, 'orbit_lattice', trim(input%orbit_lattice))
  call json%add(json_root, 'orbit_width', int(input%orbit_width))
end subroutine tao_floor_plan_struct_to_json
subroutine tao_graph_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_graph_struct
  use sim_utils_json, only: qp_axis_struct_to_json, qp_legend_struct_to_json, qp_point_struct_to_json, qp_rect_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_graph_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'type', trim(input%type))
  call json%add(json_root, 'title', trim(input%title))
  call json%add(json_root, 'title_suffix', trim(input%title_suffix))
  !line=258 definition="character(100) :: text_legend(10) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='100', static=False, target=False, value=False, volatile=False, attributes=()) name='text_legend' type='character' size='100' dimension='10' comment='Array for holding descriptive info.' default="''"
  call json%create_array(json_list1, 'text_legend')
  do i1 = lbound(input%text_legend, 1), ubound(input%text_legend, 1)
    call json%create_string(json_val, trim(input%text_legend(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=259 definition="character(100) :: text_legend_out(10) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='100', static=False, target=False, value=False, volatile=False, attributes=()) name='text_legend_out' type='character' size='100' dimension='10' comment='Array for holding descriptive info.' default="''"
  call json%create_array(json_list1, 'text_legend_out')
  do i1 = lbound(input%text_legend_out, 1), ubound(input%text_legend_out, 1)
    call json%create_string(json_val, trim(input%text_legend_out(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'why_invalid', trim(input%why_invalid))
  if (allocated(input%curve)) then
    !line=261 definition='type (tao_curve_struct), allocatable :: curve(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_curve_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='curve' type='type' size='tao_curve_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'curve')
    do i1 = lbound(input%curve, 1), ubound(input%curve, 1)
      call tao_curve_struct_to_json(input%curve(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! parent pointer skip: p (type, pointer to parent plot)
  call tao_floor_plan_struct_to_json(input%floor_plan, json_val, depth + 1)
  call json%rename(json_val, 'floor_plan')
  call json%add(json_root, json_val)
  call qp_point_struct_to_json(input%text_legend_origin, json_val, depth + 1)
  call json%rename(json_val, 'text_legend_origin')
  call json%add(json_root, json_val)
  call qp_point_struct_to_json(input%curve_legend_origin, json_val, depth + 1)
  call json%rename(json_val, 'curve_legend_origin')
  call json%add(json_root, json_val)
  call qp_legend_struct_to_json(input%curve_legend, json_val, depth + 1)
  call json%rename(json_val, 'curve_legend')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%x2, json_val, depth + 1)
  call json%rename(json_val, 'x2')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%y2, json_val, depth + 1)
  call json%rename(json_val, 'y2')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%margin, json_val, depth + 1)
  call json%rename(json_val, 'margin')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%scale_margin, json_val, depth + 1)
  call json%rename(json_val, 'scale_margin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'x_axis_scale_factor', input%x_axis_scale_factor)
  call json%add(json_root, 'symbol_size_scale', input%symbol_size_scale)
  !line=275 definition='integer :: box(4) = 0' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='box' type='integer' size=None dimension='4' comment='Defines which box the plot is put in.' default='0'
  call json%create_array(json_list1, 'box')
  do i1 = lbound(input%box, 1), ubound(input%box, 1)
    call json%create_integer(json_val, input%box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'clip', input%clip)
  call json%add(json_root, 'y2_mirrors_y', input%y2_mirrors_y)
  call json%add(json_root, 'limited', input%limited)
  call json%add(json_root, 'draw_axes', input%draw_axes)
  call json%add(json_root, 'draw_curve_legend', input%draw_curve_legend)
  call json%add(json_root, 'draw_grid', input%draw_grid)
  call json%add(json_root, 'draw_title', input%draw_title)
  call json%add(json_root, 'draw_only_good_user_data_or_vars', input%draw_only_good_user_data_or_vars)
  call json%add(json_root, 'allow_wrap_around', input%allow_wrap_around)
  call json%add(json_root, 'is_valid', input%is_valid)
end subroutine tao_graph_struct_to_json
subroutine tao_plot_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_plot_struct
  implicit none
  type(json_core) :: json
  type (tao_plot_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'description', trim(input%description))
  if (allocated(input%graph)) then
    !line=298 definition='type (tao_graph_struct), allocatable :: graph(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_graph_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='graph' type='type' size='tao_graph_struct' dimension=':' comment='individual graphs of a plot' default=None
    call json%create_array(json_list1, 'graph')
    do i1 = lbound(input%graph, 1), ubound(input%graph, 1)
      call tao_graph_struct_to_json(input%graph(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! parent pointer skip: r (type, pointer to parent.)
  call json%add(json_root, 'ix_plot', int(input%ix_plot))
  call json%add(json_root, 'n_curve_pts', int(input%n_curve_pts))
  call json%add(json_root, 'type', trim(input%type))
  call json%add(json_root, 'x_axis_type', trim(input%x_axis_type))
  call json%add(json_root, 'autoscale_x', input%autoscale_x)
  call json%add(json_root, 'autoscale_y', input%autoscale_y)
  call json%add(json_root, 'autoscale_gang_x', input%autoscale_gang_x)
  call json%add(json_root, 'autoscale_gang_y', input%autoscale_gang_y)
  call json%add(json_root, 'list_with_show_plot_command', input%list_with_show_plot_command)
  call json%add(json_root, 'phantom', input%phantom)
  call json%add(json_root, 'default_plot', input%default_plot)
end subroutine tao_plot_struct_to_json
subroutine tao_plot_region_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_plot_region_struct
  implicit none
  type(json_core) :: json
  type (tao_plot_region_struct), pointer, intent(in) :: input
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
  call tao_plot_struct_to_json(input%plot, json_val, depth + 1)
  call json%rename(json_val, 'plot')
  call json%add(json_root, json_val)
  !line=321 definition='real(rp) :: location(4) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='location' type='real' size='rp' dimension='4' comment='[x1, x2, y1, y2] location on page.' default='0'
  call json%create_array(json_list1, 'location')
  do i1 = lbound(input%location, 1), ubound(input%location, 1)
    call json%create_real(json_val, input%location(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'visible', input%visible)
  call json%add(json_root, 'list_with_show_plot_command', input%list_with_show_plot_command)
  call json%add(json_root, 'setup_done', input%setup_done)
end subroutine tao_plot_region_struct_to_json
subroutine tao_plot_page_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_plot_page_struct
  use sim_utils_json, only: qp_rect_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_plot_page_struct), pointer, intent(in) :: input
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
  call tao_title_struct_to_json(input%title, json_val, depth + 1)
  call json%rename(json_val, 'title')
  call json%add(json_root, json_val)
  call tao_title_struct_to_json(input%subtitle, json_val, depth + 1)
  call json%rename(json_val, 'subtitle')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%border, json_val, depth + 1)
  call json%rename(json_val, 'border')
  call json%add(json_root, json_val)
  call tao_drawing_struct_to_json(input%floor_plan, json_val, depth + 1)
  call json%rename(json_val, 'floor_plan')
  call json%add(json_root, json_val)
  call tao_drawing_struct_to_json(input%lat_layout, json_val, depth + 1)
  call json%rename(json_val, 'lat_layout')
  call json%add(json_root, json_val)
  if (allocated(input%pattern)) then
    !line=339 definition='type (tao_shape_pattern_struct), allocatable :: pattern(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_shape_pattern_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pattern' type='type' size='tao_shape_pattern_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pattern')
    do i1 = lbound(input%pattern, 1), ubound(input%pattern, 1)
      call tao_shape_pattern_struct_to_json(input%pattern(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%template)) then
    !line=340 definition='type (tao_plot_struct), allocatable :: template(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_plot_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='template' type='type' size='tao_plot_struct' dimension=':' comment='Templates for the plots.' default=None
    call json%create_array(json_list1, 'template')
    do i1 = lbound(input%template, 1), ubound(input%template, 1)
      call tao_plot_struct_to_json(input%template(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%region)) then
    !line=341 definition='type (tao_plot_region_struct), allocatable :: region(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_plot_region_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='region' type='type' size='tao_plot_region_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'region')
    do i1 = lbound(input%region, 1), ubound(input%region, 1)
      call tao_plot_region_struct_to_json(input%region(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'plot_display_type', trim(input%plot_display_type))
  !line=343 definition='real(rp) :: size(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='size' type='real' size='rp' dimension='2' comment='width and height of plot window in pixels.' default='0'
  call json%create_array(json_list1, 'size')
  do i1 = lbound(input%size, 1), ubound(input%size, 1)
    call json%create_real(json_val, input%size(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'text_height', input%text_height)
  call json%add(json_root, 'main_title_text_scale', input%main_title_text_scale)
  call json%add(json_root, 'graph_title_text_scale', input%graph_title_text_scale)
  call json%add(json_root, 'axis_number_text_scale', input%axis_number_text_scale)
  call json%add(json_root, 'axis_label_text_scale', input%axis_label_text_scale)
  call json%add(json_root, 'legend_text_scale', input%legend_text_scale)
  call json%add(json_root, 'key_table_text_scale', input%key_table_text_scale)
  call json%add(json_root, 'floor_plan_shape_scale', input%floor_plan_shape_scale)
  call json%add(json_root, 'floor_plan_text_scale', input%floor_plan_text_scale)
  call json%add(json_root, 'lat_layout_shape_scale', input%lat_layout_shape_scale)
  call json%add(json_root, 'lat_layout_text_scale', input%lat_layout_text_scale)
  call json%add(json_root, 'n_curve_pts', int(input%n_curve_pts))
  call json%add(json_root, 'id_window', int(input%id_window))
  call json%add(json_root, 'delete_overlapping_plots', input%delete_overlapping_plots)
  call json%add(json_root, 'draw_graph_title_suffix', input%draw_graph_title_suffix)
end subroutine tao_plot_page_struct_to_json
subroutine tao_region_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_region_array_struct
  implicit none
  type(json_core) :: json
  type (tao_region_array_struct), pointer, intent(in) :: input
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
  if (associated(input%r)) then
    call tao_plot_region_struct_to_json(input%r, json_val, depth + 1)
    call json%rename(json_val, 'r')
    call json%add(json_root, json_val)
  endif
end subroutine tao_region_array_struct_to_json
subroutine tao_plot_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_plot_array_struct
  implicit none
  type(json_core) :: json
  type (tao_plot_array_struct), pointer, intent(in) :: input
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
  ! parent pointer skip: p (type, )
end subroutine tao_plot_array_struct_to_json
subroutine tao_graph_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_graph_array_struct
  implicit none
  type(json_core) :: json
  type (tao_graph_array_struct), pointer, intent(in) :: input
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
  ! parent pointer skip: g (type, )
end subroutine tao_graph_array_struct_to_json
subroutine tao_curve_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_curve_array_struct
  implicit none
  type(json_core) :: json
  type (tao_curve_array_struct), pointer, intent(in) :: input
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
  if (associated(input%c)) then
    call tao_curve_struct_to_json(input%c, json_val, depth + 1)
    call json%rename(json_val, 'c')
    call json%add(json_root, json_val)
  endif
end subroutine tao_curve_array_struct_to_json
subroutine tao_spin_map_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_spin_map_struct
  use bmad_json, only: spin_axis_struct_to_json, spin_orbit_map1_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_spin_map_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'valid', input%valid)
  call spin_orbit_map1_struct_to_json(input%map1, json_val, depth + 1)
  call json%rename(json_val, 'map1')
  call json%add(json_root, json_val)
  call spin_axis_struct_to_json(input%axis_input, json_val, depth + 1)
  call json%rename(json_val, 'axis_input')
  call json%add(json_root, json_val)
  call spin_axis_struct_to_json(input%axis0, json_val, depth + 1)
  call json%rename(json_val, 'axis0')
  call json%add(json_root, json_val)
  call spin_axis_struct_to_json(input%axis1, json_val, depth + 1)
  call json%rename(json_val, 'axis1')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_ref', int(input%ix_ref))
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  !line=389 definition='real(rp) :: mat8(8,8) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='mat8' type='real' size='rp' dimension='8,8' comment='' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mat8, 2), ubound(input%mat8, 2)
    call json%create_array(json_list1, 'mat8')
    do i1 = lbound(input%mat8, 1), ubound(input%mat8, 1)
      call json%create_real(json_val, input%mat8(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine tao_spin_map_struct_to_json
subroutine tao_data_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_data_struct
  implicit none
  type(json_core) :: json
  type (tao_data_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'ele_start_name', trim(input%ele_start_name))
  call json%add(json_root, 'ele_ref_name', trim(input%ele_ref_name))
  if (allocated(input%data_type)) then
    call json%add(json_root, 'data_type', trim(input%data_type))
  endif
  call json%add(json_root, 'merit_type', trim(input%merit_type))
  call json%add(json_root, 'id', trim(input%id))
  call json%add(json_root, 'data_source', trim(input%data_source))
  call json%add(json_root, 'why_invalid', trim(input%why_invalid))
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_ele_start', int(input%ix_ele_start))
  call json%add(json_root, 'ix_ele_ref', int(input%ix_ele_ref))
  call json%add(json_root, 'ix_ele_merit', int(input%ix_ele_merit))
  call json%add(json_root, 'ix_d1', int(input%ix_d1))
  call json%add(json_root, 'ix_data', int(input%ix_data))
  call json%add(json_root, 'ix_dmodel', int(input%ix_dModel))
  call json%add(json_root, 'eval_point', int(input%eval_point))
  call json%add(json_root, 'meas_value', input%meas_value)
  call json%add(json_root, 'ref_value', input%ref_value)
  call json%add(json_root, 'model_value', input%model_value)
  call json%add(json_root, 'design_value', input%design_value)
  call json%add(json_root, 'old_value', input%old_value)
  call json%add(json_root, 'base_value', input%base_value)
  call json%add(json_root, 'error_rms', input%error_rms)
  call json%add(json_root, 'delta_merit', input%delta_merit)
  call json%add(json_root, 'weight', input%weight)
  call json%add(json_root, 'invalid_value', input%invalid_value)
  call json%add(json_root, 'merit', input%merit)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 's_offset', input%s_offset)
  call tao_spin_map_struct_to_json(input%spin_map, json_val, depth + 1)
  call json%rename(json_val, 'spin_map')
  call json%add(json_root, json_val)
  call json%add(json_root, 'err_message_printed', input%err_message_printed)
  call json%add(json_root, 'exists', input%exists)
  call json%add(json_root, 'good_model', input%good_model)
  call json%add(json_root, 'good_base', input%good_base)
  call json%add(json_root, 'good_design', input%good_design)
  call json%add(json_root, 'good_meas', input%good_meas)
  call json%add(json_root, 'good_ref', input%good_ref)
  call json%add(json_root, 'good_user', input%good_user)
  call json%add(json_root, 'good_opt', input%good_opt)
  call json%add(json_root, 'good_plot', input%good_plot)
  call json%add(json_root, 'useit_plot', input%useit_plot)
  call json%add(json_root, 'useit_opt', input%useit_opt)
  ! parent pointer skip: d1 (type, Pointer to the parent d1_data_struct)
  if (allocated(input%stack)) then
    !line=468 definition='type (tao_eval_stack1_struct), allocatable :: stack(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_eval_stack1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='stack' type='type' size='tao_eval_stack1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call tao_eval_stack1_struct_to_json(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_data_struct_to_json
subroutine tao_d1_data_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_d1_data_struct
  implicit none
  type(json_core) :: json
  type (tao_d1_data_struct), pointer, intent(in) :: input
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
  ! parent pointer skip: d2 (type, ptr to parent d2_data)
  if (associated(input%d)) then
    !line=478 definition='type (tao_data_struct), pointer :: d(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='tao_data_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='d' type='type' size='tao_data_struct' dimension=':' comment='' default='null()'
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%d, 1), ubound(input%d, 1)
      call tao_data_struct_to_json(input%d(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_d1_data_struct_to_json
subroutine tao_d2_data_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_d2_data_struct
  implicit none
  type(json_core) :: json
  type (tao_d2_data_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'data_file_name', trim(input%data_file_name))
  call json%add(json_root, 'ref_file_name', trim(input%ref_file_name))
  call json%add(json_root, 'data_date', trim(input%data_date))
  call json%add(json_root, 'ref_date', trim(input%ref_date))
  !line=493 definition="character(80) :: descrip(10) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='80', static=False, target=False, value=False, volatile=False, attributes=()) name='descrip' type='character' size='80' dimension='10' comment='Array for descriptive information.' default="''"
  call json%create_array(json_list1, 'descrip')
  do i1 = lbound(input%descrip, 1), ubound(input%descrip, 1)
    call json%create_string(json_val, trim(input%descrip(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%d1)) then
    !line=494 definition='type (tao_d1_data_struct), allocatable :: d1(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_d1_data_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='d1' type='type' size='tao_d1_data_struct' dimension=':' comment='Points to children' default=None
    call json%create_array(json_list1, 'd1')
    do i1 = lbound(input%d1, 1), ubound(input%d1, 1)
      call tao_d1_data_struct_to_json(input%d1(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'ix_d2_data', int(input%ix_d2_data))
  call json%add(json_root, 'ix_ref', int(input%ix_ref))
  call json%add(json_root, 'data_read_in', input%data_read_in)
  call json%add(json_root, 'ref_read_in', input%ref_read_in)
end subroutine tao_d2_data_struct_to_json
subroutine tao_data_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_data_array_struct
  implicit none
  type(json_core) :: json
  type (tao_data_array_struct), pointer, intent(in) :: input
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
  if (associated(input%d)) then
    call tao_data_struct_to_json(input%d, json_val, depth + 1)
    call json%rename(json_val, 'd')
    call json%add(json_root, json_val)
  endif
end subroutine tao_data_array_struct_to_json
subroutine tao_d1_data_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_d1_data_array_struct
  implicit none
  type(json_core) :: json
  type (tao_d1_data_array_struct), pointer, intent(in) :: input
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
  if (associated(input%d1)) then
    call tao_d1_data_struct_to_json(input%d1, json_val, depth + 1)
    call json%rename(json_val, 'd1')
    call json%add(json_root, json_val)
  endif
end subroutine tao_d1_data_array_struct_to_json
subroutine tao_d2_data_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_d2_data_array_struct
  implicit none
  type(json_core) :: json
  type (tao_d2_data_array_struct), pointer, intent(in) :: input
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
  if (associated(input%d2)) then
    call tao_d2_data_struct_to_json(input%d2, json_val, depth + 1)
    call json%rename(json_val, 'd2')
    call json%add(json_root, json_val)
  endif
end subroutine tao_d2_data_array_struct_to_json
subroutine tao_var_slave_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_var_slave_struct
  implicit none
  type(json_core) :: json
  type (tao_var_slave_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  if (associated(input%model_value)) then
    call json%add(json_root, 'model_value', input%model_value)
  endif
  if (associated(input%base_value)) then
    call json%add(json_root, 'base_value', input%base_value)
  endif
end subroutine tao_var_slave_struct_to_json
subroutine tao_var_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_var_struct
  implicit none
  type(json_core) :: json
  type (tao_var_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'attrib_name', trim(input%attrib_name))
  call json%add(json_root, 'id', trim(input%id))
  if (allocated(input%slave)) then
    !line=549 definition='type (tao_var_slave_struct), allocatable :: slave(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_var_slave_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='slave' type='type' size='tao_var_slave_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'slave')
    do i1 = lbound(input%slave, 1), ubound(input%slave, 1)
      call tao_var_slave_struct_to_json(input%slave(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_v1', int(input%ix_v1))
  call json%add(json_root, 'ix_var', int(input%ix_var))
  call json%add(json_root, 'ix_dvar', int(input%ix_dvar))
  call json%add(json_root, 'ix_attrib', int(input%ix_attrib))
  call json%add(json_root, 'ix_key_table', int(input%ix_key_table))
  if (associated(input%model_value)) then
    call json%add(json_root, 'model_value', input%model_value)
  endif
  if (associated(input%base_value)) then
    call json%add(json_root, 'base_value', input%base_value)
  endif
  call json%add(json_root, 'design_value', input%design_value)
  call json%add(json_root, 'scratch_value', input%scratch_value)
  call json%add(json_root, 'old_value', input%old_value)
  call json%add(json_root, 'meas_value', input%meas_value)
  call json%add(json_root, 'ref_value', input%ref_value)
  call json%add(json_root, 'correction_value', input%correction_value)
  call json%add(json_root, 'high_lim', input%high_lim)
  call json%add(json_root, 'low_lim', input%low_lim)
  call json%add(json_root, 'step', input%step)
  call json%add(json_root, 'weight', input%weight)
  call json%add(json_root, 'delta_merit', input%delta_merit)
  call json%add(json_root, 'merit', input%merit)
  call json%add(json_root, 'dmerit_dvar', input%dMerit_dVar)
  call json%add(json_root, 'key_val0', input%key_val0)
  call json%add(json_root, 'key_delta', input%key_delta)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'extend_val', input%extend_val)
  call json%add(json_root, 'merit_type', trim(input%merit_type))
  call json%add(json_root, 'exists', input%exists)
  call json%add(json_root, 'good_var', input%good_var)
  call json%add(json_root, 'good_user', input%good_user)
  call json%add(json_root, 'good_opt', input%good_opt)
  call json%add(json_root, 'good_plot', input%good_plot)
  call json%add(json_root, 'useit_opt', input%useit_opt)
  call json%add(json_root, 'useit_plot', input%useit_plot)
  call json%add(json_root, 'key_bound', input%key_bound)
  ! parent pointer skip: v1 (type, Pointer to the parent.)
end subroutine tao_var_struct_to_json
subroutine tao_v1_var_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_v1_var_struct
  implicit none
  type(json_core) :: json
  type (tao_v1_var_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_v1_var', int(input%ix_v1_var))
  if (associated(input%v)) then
    !line=592 definition='type (tao_var_struct), pointer :: v(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='tao_var_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='v' type='type' size='tao_var_struct' dimension=':' comment='' default='null()'
    call json%create_array(json_list1, 'v')
    do i1 = lbound(input%v, 1), ubound(input%v, 1)
      call tao_var_struct_to_json(input%v(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_v1_var_struct_to_json
subroutine tao_var_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_var_array_struct
  implicit none
  type(json_core) :: json
  type (tao_var_array_struct), pointer, intent(in) :: input
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
  if (associated(input%v)) then
    call tao_var_struct_to_json(input%v, json_val, depth + 1)
    call json%rename(json_val, 'v')
    call json%add(json_root, json_val)
  endif
end subroutine tao_var_array_struct_to_json
subroutine tao_v1_var_array_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_v1_var_array_struct
  implicit none
  type(json_core) :: json
  type (tao_v1_var_array_struct), pointer, intent(in) :: input
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
  if (associated(input%v1)) then
    call tao_v1_var_struct_to_json(input%v1, json_val, depth + 1)
    call json%rename(json_val, 'v1')
    call json%add(json_root, json_val)
  endif
end subroutine tao_v1_var_array_struct_to_json
subroutine tao_building_wall_orientation_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_building_wall_orientation_struct
  implicit none
  type(json_core) :: json
  type (tao_building_wall_orientation_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'theta', input%theta)
  call json%add(json_root, 'x_offset', input%x_offset)
  call json%add(json_root, 'z_offset', input%z_offset)
end subroutine tao_building_wall_orientation_struct_to_json
subroutine tao_building_wall_point_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_building_wall_point_struct
  implicit none
  type(json_core) :: json
  type (tao_building_wall_point_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'z', input%z)
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'radius', input%radius)
  call json%add(json_root, 'z_center', input%z_center)
  call json%add(json_root, 'x_center', input%x_center)
end subroutine tao_building_wall_point_struct_to_json
subroutine tao_building_wall_section_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_building_wall_section_struct
  implicit none
  type(json_core) :: json
  type (tao_building_wall_section_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'constraint', trim(input%constraint))
  if (allocated(input%point)) then
    !line=626 definition='type (tao_building_wall_point_struct), allocatable :: point(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_building_wall_point_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='point' type='type' size='tao_building_wall_point_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'point')
    do i1 = lbound(input%point, 1), ubound(input%point, 1)
      call tao_building_wall_point_struct_to_json(input%point(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_building_wall_section_struct_to_json
subroutine tao_building_wall_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_building_wall_struct
  implicit none
  type(json_core) :: json
  type (tao_building_wall_struct), pointer, intent(in) :: input
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
  call tao_building_wall_orientation_struct_to_json(input%orientation, json_val, depth + 1)
  call json%rename(json_val, 'orientation')
  call json%add(json_root, json_val)
  if (allocated(input%section)) then
    !line=631 definition='type (tao_building_wall_section_struct), allocatable :: section(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_building_wall_section_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='section' type='type' size='tao_building_wall_section_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'section')
    do i1 = lbound(input%section, 1), ubound(input%section, 1)
      call tao_building_wall_section_struct_to_json(input%section(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_building_wall_struct_to_json
subroutine tao_global_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_global_struct
  implicit none
  type(json_core) :: json
  type (tao_global_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'beam_dead_cutoff', input%beam_dead_cutoff)
  call json%add(json_root, 'lm_opt_deriv_reinit', input%lm_opt_deriv_reinit)
  call json%add(json_root, 'de_lm_step_ratio', input%de_lm_step_ratio)
  call json%add(json_root, 'de_var_to_population_factor', input%de_var_to_population_factor)
  call json%add(json_root, 'lmdif_eps', input%lmdif_eps)
  call json%add(json_root, 'lmdif_negligible_merit', input%lmdif_negligible_merit)
  call json%add(json_root, 'svd_cutoff', input%svd_cutoff)
  call json%add(json_root, 'unstable_penalty', input%unstable_penalty)
  call json%add(json_root, 'merit_stop_value', input%merit_stop_value)
  call json%add(json_root, 'dmerit_stop_value', input%dmerit_stop_value)
  call json%add(json_root, 'random_sigma_cutoff', input%random_sigma_cutoff)
  call json%add(json_root, 'delta_e_chrom', input%delta_e_chrom)
  call json%add(json_root, 'max_plot_time', input%max_plot_time)
  call json%add(json_root, 'default_universe', int(input%default_universe))
  call json%add(json_root, 'default_branch', int(input%default_branch))
  call json%add(json_root, 'n_opti_cycles', int(input%n_opti_cycles))
  call json%add(json_root, 'n_opti_loops', int(input%n_opti_loops))
  call json%add(json_root, 'n_threads', int(input%n_threads))
  call json%add(json_root, 'phase_units', int(input%phase_units))
  call json%add(json_root, 'bunch_to_plot', int(input%bunch_to_plot))
  call json%add(json_root, 'random_seed', int(input%random_seed))
  call json%add(json_root, 'n_top10_merit', int(input%n_top10_merit))
  call json%add(json_root, 'srdt_gen_n_slices', int(input%srdt_gen_n_slices))
  call json%add(json_root, 'datum_err_messages_max', int(input%datum_err_messages_max))
  call json%add(json_root, 'srdt_sxt_n_slices', int(input%srdt_sxt_n_slices))
  call json%add(json_root, 'srdt_use_cache', input%srdt_use_cache)
  call json%add(json_root, 'quiet', trim(input%quiet))
  call json%add(json_root, 'random_engine', trim(input%random_engine))
  call json%add(json_root, 'random_gauss_converter', trim(input%random_gauss_converter))
  call json%add(json_root, 'track_type', trim(input%track_type))
  call json%add(json_root, 'prompt_string', trim(input%prompt_string))
  call json%add(json_root, 'prompt_color', trim(input%prompt_color))
  call json%add(json_root, 'optimizer', trim(input%optimizer))
  call json%add(json_root, 'print_command', trim(input%print_command))
  call json%add(json_root, 'var_out_file', trim(input%var_out_file))
  call json%add(json_root, 'history_file', trim(input%history_file))
  call json%add(json_root, 'beam_timer_on', input%beam_timer_on)
  call json%add(json_root, 'box_plots', input%box_plots)
  call json%add(json_root, 'cmd_file_abort_on_error', input%cmd_file_abort_on_error)
  call json%add(json_root, 'concatenate_maps', input%concatenate_maps)
  call json%add(json_root, 'debug_on', input%debug_on)
  call json%add(json_root, 'derivative_recalc', input%derivative_recalc)
  call json%add(json_root, 'derivative_uses_design', input%derivative_uses_design)
  call json%add(json_root, 'disable_smooth_line_calc', input%disable_smooth_line_calc)
  call json%add(json_root, 'draw_curve_off_scale_warn', input%draw_curve_off_scale_warn)
  call json%add(json_root, 'external_plotting', input%external_plotting)
  call json%add(json_root, 'init_lat_sigma_from_beam', input%init_lat_sigma_from_beam)
  call json%add(json_root, 'label_lattice_elements', input%label_lattice_elements)
  call json%add(json_root, 'label_keys', input%label_keys)
  call json%add(json_root, 'lattice_calc_on', input%lattice_calc_on)
  call json%add(json_root, 'only_limit_opt_vars', input%only_limit_opt_vars)
  call json%add(json_root, 'opt_with_ref', input%opt_with_ref)
  call json%add(json_root, 'opt_with_base', input%opt_with_base)
  call json%add(json_root, 'opt_match_auto_recalc', input%opt_match_auto_recalc)
  call json%add(json_root, 'opti_write_var_file', input%opti_write_var_file)
  call json%add(json_root, 'optimizer_allow_user_abort', input%optimizer_allow_user_abort)
  call json%add(json_root, 'optimizer_var_limit_warn', input%optimizer_var_limit_warn)
  call json%add(json_root, 'plot_on', input%plot_on)
  call json%add(json_root, 'rad_int_user_calc_on', input%rad_int_user_calc_on)
  call json%add(json_root, 'rf_on', input%rf_on)
  call json%add(json_root, 'single_step', input%single_step)
  call json%add(json_root, 'stop_on_error', input%stop_on_error)
  call json%add(json_root, 'svd_retreat_on_merit_increase', input%svd_retreat_on_merit_increase)
  call json%add(json_root, 'var_limits_on', input%var_limits_on)
  call json%add(json_root, 'wait_for_cr_in_single_mode', input%wait_for_CR_in_single_mode)
  call json%add(json_root, 'blank_line_between_commands', input%blank_line_between_commands)
  call json%add(json_root, 'symbol_import', input%symbol_import)
end subroutine tao_global_struct_to_json
subroutine tao_alias_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_alias_struct
  implicit none
  type(json_core) :: json
  type (tao_alias_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'expanded_str', trim(input%expanded_str))
end subroutine tao_alias_struct_to_json
subroutine tao_command_file_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_command_file_struct
  implicit none
  type(json_core) :: json
  type (tao_command_file_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'full_name', trim(input%full_name))
  call json%add(json_root, 'dir', trim(input%dir))
  call json%add(json_root, 'ix_unit', int(input%ix_unit))
  !line=719 definition="character(40) :: cmd_arg(9) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='cmd_arg' type='character' size='40' dimension='9' comment='Command file arguments.' default="''"
  call json%create_array(json_list1, 'cmd_arg')
  do i1 = lbound(input%cmd_arg, 1), ubound(input%cmd_arg, 1)
    call json%create_string(json_val, trim(input%cmd_arg(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'quiet', trim(input%quiet))
  call json%add(json_root, 'paused', input%paused)
  call json%add(json_root, 'n_line', int(input%n_line))
  call json%add(json_root, 'reset_at_end', input%reset_at_end)
  call json%add(json_root, 'lattice_calc_save', input%lattice_calc_save)
  call json%add(json_root, 'plot_save', input%plot_save)
end subroutine tao_command_file_struct_to_json
subroutine do_loop_struct_to_json (input, json_root, depth)
  use tao_struct, only: do_loop_struct
  implicit none
  type(json_core) :: json
  type (do_loop_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'index', int(input%index))
  call json%add(json_root, 'start', int(input%start))
  call json%add(json_root, 'end', int(input%end))
  call json%add(json_root, 'step', int(input%step))
  call json%add(json_root, 'n_line_start', int(input%n_line_start))
  call json%add(json_root, 'n_line_end', int(input%n_line_end))
  call json%add(json_root, 'value', int(input%value))
end subroutine do_loop_struct_to_json
subroutine tao_common_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_common_struct
  use sim_utils_json, only: named_number_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_common_struct), pointer, intent(in) :: input
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
  !line=741 definition='type (tao_alias_struct) :: alias(200) = tao_alias_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_alias_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='alias' type='type' size='tao_alias_struct' dimension='200' comment='' default='tao_alias_struct()'
  call json%create_array(json_list1, 'alias')
  do i1 = lbound(input%alias, 1), ubound(input%alias, 1)
    call tao_alias_struct_to_json(input%alias(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=742 definition='type (tao_alias_struct) :: key(100) = tao_alias_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_alias_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='key' type='type' size='tao_alias_struct' dimension='100' comment='' default='tao_alias_struct()'
  call json%create_array(json_list1, 'key')
  do i1 = lbound(input%key, 1), ubound(input%key, 1)
    call tao_alias_struct_to_json(input%key(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%cmd_file)) then
    !line=743 definition='type (tao_command_file_struct), allocatable :: cmd_file(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_command_file_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='cmd_file' type='type' size='tao_command_file_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'cmd_file')
    do i1 = lbound(input%cmd_file, 1), ubound(input%cmd_file, 1)
      call tao_command_file_struct_to_json(input%cmd_file(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%symbolic_num)) then
    !line=744 definition='type (named_number_struct), allocatable :: symbolic_num(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='named_number_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='symbolic_num' type='type' size='named_number_struct' dimension=':' comment='Named numbers' default=None
    call json%create_array(json_list1, 'symbolic_num')
    do i1 = lbound(input%symbolic_num, 1), ubound(input%symbolic_num, 1)
      call named_number_struct_to_json(input%symbolic_num(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%plot_place_buffer)) then
    !line=745 definition='type (tao_plot_region_struct), allocatable :: plot_place_buffer(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_plot_region_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='plot_place_buffer' type='type' size='tao_plot_region_struct' dimension=':' comment='Used when %external_plotting is on.' default=None
    call json%create_array(json_list1, 'plot_place_buffer')
    do i1 = lbound(input%plot_place_buffer, 1), ubound(input%plot_place_buffer, 1)
      call tao_plot_region_struct_to_json(input%plot_place_buffer(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%do_loop)) then
    !line=746 definition='type (do_loop_struct), allocatable :: do_loop(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='do_loop_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='do_loop' type='type' size='do_loop_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'do_loop')
    do i1 = lbound(input%do_loop, 1), ubound(input%do_loop, 1)
      call do_loop_struct_to_json(input%do_loop(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%covar)) then
    !line=747 definition='real(rp), allocatable :: covar(:,:), alpha(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='covar' type='real' size='rp' dimension=':,:' comment='' default=None
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
  if (allocated(input%alpha)) then
    !line=747 definition='real(rp), allocatable :: covar(:,:), alpha(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='alpha' type='real' size='rp' dimension=':,:' comment='' default=None
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
  call json%add(json_root, 'dummy_target', input%dummy_target)
  call json%add(json_root, 'ix_ref_taylor', int(input%ix_ref_taylor))
  call json%add(json_root, 'ix_ele_taylor', int(input%ix_ele_taylor))
  call json%add(json_root, 'n_alias', int(input%n_alias))
  call json%add(json_root, 'cmd_file_level', int(input%cmd_file_level))
  call json%add(json_root, 'ix_key_bank', int(input%ix_key_bank))
  call json%add(json_root, 'ix_history', int(input%ix_history))
  call json%add(json_root, 'n_history', int(input%n_history))
  call json%add(json_root, 'lev_loop', int(input%lev_loop))
  call json%add(json_root, 'n_err_messages_printed', int(input%n_err_messages_printed))
  call json%add(json_root, 'n_universes', int(input%n_universes))
  call json%add(json_root, 'ix_beam_track_active_element', int(input%ix_beam_track_active_element))
  call json%add(json_root, 'cmd_file_paused', input%cmd_file_paused)
  call json%add(json_root, 'use_cmd_here', input%use_cmd_here)
  call json%add(json_root, 'cmd_from_cmd_file', input%cmd_from_cmd_file)
  call json%add(json_root, 'use_saved_beam_in_tracking', input%use_saved_beam_in_tracking)
  call json%add(json_root, 'single_mode', input%single_mode)
  call json%add(json_root, 'combine_consecutive_elements_of_like_name', input%combine_consecutive_elements_of_like_name)
  call json%add(json_root, 'have_tracked_beam', input%have_tracked_beam)
  call json%add(json_root, 'init_plot_needed', input%init_plot_needed)
  call json%add(json_root, 'init_beam', input%init_beam)
  call json%add(json_root, 'init_var', input%init_var)
  call json%add(json_root, 'init_read_lat_info', input%init_read_lat_info)
  call json%add(json_root, 'optimizer_running', input%optimizer_running)
  call json%add(json_root, 'have_datums_using_expressions', input%have_datums_using_expressions)
  call json%add(json_root, 'print_to_terminal', input%print_to_terminal)
  call json%add(json_root, 'lattice_calc_done', input%lattice_calc_done)
  call json%add(json_root, 'add_measurement_noise', input%add_measurement_noise)
  !line=775 definition='logical :: is_err_message_printed(2) = .false.' type_info=TypeInformation(type='logical', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='is_err_message_printed' type='logical' size=None dimension='2' comment='Used by tao_set_invalid' default='.false.'
  call json%create_array(json_list1, 'is_err_message_printed')
  do i1 = lbound(input%is_err_message_printed, 1), ubound(input%is_err_message_printed, 1)
    call json%create_logical(json_val, input%is_err_message_printed(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'command_arg_has_been_executed', input%command_arg_has_been_executed)
  call json%add(json_root, 'all_merit_weights_positive', input%all_merit_weights_positive)
  call json%add(json_root, 'multi_turn_orbit_is_plotted', input%multi_turn_orbit_is_plotted)
  call json%add(json_root, 'force_chrom_calc', input%force_chrom_calc)
  call json%add(json_root, 'force_rad_int_calc', input%force_rad_int_calc)
  call json%add(json_root, 'rad_int_ri_calc_on', input%rad_int_ri_calc_on)
  call json%add(json_root, 'rad_int_6d_calc_on', input%rad_int_6d_calc_on)
  !line=783 definition="character(16) :: valid_plot_who(10) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='16', static=False, target=False, value=False, volatile=False, attributes=()) name='valid_plot_who' type='character' size='16' dimension='10' comment='model, base, ref etc...' default="''"
  call json%create_array(json_list1, 'valid_plot_who')
  do i1 = lbound(input%valid_plot_who, 1), ubound(input%valid_plot_who, 1)
    call json%create_string(json_val, trim(input%valid_plot_who(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'single_mode_buffer', trim(input%single_mode_buffer))
  call json%add(json_root, 'cmd', trim(input%cmd))
  call json%add(json_root, 'saved_cmd_line', trim(input%saved_cmd_line))
end subroutine tao_common_struct_to_json
subroutine tao_init_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_init_struct
  implicit none
  type(json_core) :: json
  type (tao_init_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'parse_cmd_args', input%parse_cmd_args)
  call json%add(json_root, 'debug_switch', input%debug_switch)
  call json%add(json_root, 'external_plotting_switch', input%external_plotting_switch)
  call json%add(json_root, 'init_name', trim(input%init_name))
  call json%add(json_root, 'hook_init_file', trim(input%hook_init_file))
  call json%add(json_root, 'hook_lat_file', trim(input%hook_lat_file))
  call json%add(json_root, 'hook_beam_file', trim(input%hook_beam_file))
  call json%add(json_root, 'hook_data_file', trim(input%hook_data_file))
  call json%add(json_root, 'hook_plot_file', trim(input%hook_plot_file))
  call json%add(json_root, 'hook_startup_file', trim(input%hook_startup_file))
  call json%add(json_root, 'hook_var_file', trim(input%hook_var_file))
  call json%add(json_root, 'hook_building_wall_file', trim(input%hook_building_wall_file))
  call json%add(json_root, 'init_file_arg_path', trim(input%init_file_arg_path))
  call json%add(json_root, 'lattice_file_arg', trim(input%lattice_file_arg))
  call json%add(json_root, 'hook_init_file_arg', trim(input%hook_init_file_arg))
  call json%add(json_root, 'init_file_arg', trim(input%init_file_arg))
  call json%add(json_root, 'beam_file_arg', trim(input%beam_file_arg))
  call json%add(json_root, 'beam_init_position_file_arg', trim(input%beam_init_position_file_arg))
  call json%add(json_root, 'command_arg', trim(input%command_arg))
  call json%add(json_root, 'data_file_arg', trim(input%data_file_arg))
  call json%add(json_root, 'plot_file_arg', trim(input%plot_file_arg))
  call json%add(json_root, 'startup_file_arg', trim(input%startup_file_arg))
  call json%add(json_root, 'var_file_arg', trim(input%var_file_arg))
  call json%add(json_root, 'building_wall_file_arg', trim(input%building_wall_file_arg))
  call json%add(json_root, 'geometry_arg', trim(input%geometry_arg))
  call json%add(json_root, 'slice_lattice_arg', trim(input%slice_lattice_arg))
  call json%add(json_root, 'start_branch_at_arg', trim(input%start_branch_at_arg))
  call json%add(json_root, 'log_startup_arg', trim(input%log_startup_arg))
  call json%add(json_root, 'no_stopping_arg', trim(input%no_stopping_arg))
  call json%add(json_root, 'noplot_arg', trim(input%noplot_arg))
  call json%add(json_root, 'no_rad_int_arg', trim(input%no_rad_int_arg))
  call json%add(json_root, 'reverse_arg', trim(input%reverse_arg))
  call json%add(json_root, 'debug_arg', trim(input%debug_arg))
  call json%add(json_root, 'disable_smooth_line_calc_arg', trim(input%disable_smooth_line_calc_arg))
  call json%add(json_root, 'rf_on_arg', trim(input%rf_on_arg))
  call json%add(json_root, 'prompt_color_arg', trim(input%prompt_color_arg))
  call json%add(json_root, 'quiet_arg', trim(input%quiet_arg))
  call json%add(json_root, 'noinit_arg', trim(input%noinit_arg))
  call json%add(json_root, 'nostartup_arg', trim(input%nostartup_arg))
  call json%add(json_root, 'symbol_import_arg', trim(input%symbol_import_arg))
  call json%add(json_root, 'unique_name_suffix', trim(input%unique_name_suffix))
end subroutine tao_init_struct_to_json
subroutine tao_beam_shake_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_beam_shake_struct
  implicit none
  type(json_core) :: json
  type (tao_beam_shake_struct), pointer, intent(in) :: input
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
  !line=839 definition='real(rp) cbar(2,2)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='cbar' type='real' size='rp' dimension='2,2' comment='' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%cbar, 2), ubound(input%cbar, 2)
    call json%create_array(json_list1, 'cbar')
    do i1 = lbound(input%cbar, 1), ubound(input%cbar, 1)
      call json%create_real(json_val, input%cbar(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'k_11a', input%k_11a)
  call json%add(json_root, 'k_12a', input%k_12a)
  call json%add(json_root, 'k_12b', input%k_12b)
  call json%add(json_root, 'k_22b', input%k_22b)
  call json%add(json_root, 'amp_a', input%amp_a)
  call json%add(json_root, 'amp_b', input%amp_b)
  call json%add(json_root, 'amp_na', input%amp_na)
  call json%add(json_root, 'amp_nb', input%amp_nb)
  call json%add(json_root, 'one', input%one)
  call json%add(json_root, 'coupling_calc_done', input%coupling_calc_done)
  call json%add(json_root, 'amp_calc_done', input%amp_calc_done)
end subroutine tao_beam_shake_struct_to_json
subroutine tao_scratch_space_struct_to_json (input, json_root, depth)
              use tao_struct, only: tao_scratch_space_struct
              use bmad_json, only: ele_pointer_struct_to_json
  use sim_utils_json, only: all_pointer_struct_to_json
              implicit none
              type(json_core) :: json
              type (tao_scratch_space_struct), pointer, intent(in) :: input
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
  if (allocated(input%cc)) then
    !line=848 definition='type (tao_beam_shake_struct), allocatable :: cc(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_beam_shake_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='cc' type='type' size='tao_beam_shake_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'cc')
    do i1 = lbound(input%cc, 1), ubound(input%cc, 1)
      call tao_beam_shake_struct_to_json(input%cc(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%eles)) then
    !line=849 definition='type (ele_pointer_struct), allocatable :: eles(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ele_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='eles' type='type' size='ele_pointer_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'eles')
    do i1 = lbound(input%eles, 1), ubound(input%eles, 1)
      call ele_pointer_struct_to_json(input%eles(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%d1_array)) then
    !line=850 definition='type (tao_d1_data_array_struct), allocatable :: d1_array(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_d1_data_array_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='d1_array' type='type' size='tao_d1_data_array_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'd1_array')
    do i1 = lbound(input%d1_array, 1), ubound(input%d1_array, 1)
      call tao_d1_data_array_struct_to_json(input%d1_array(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%v1_array)) then
    !line=851 definition='type (tao_v1_var_array_struct), allocatable :: v1_array(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_v1_var_array_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='v1_array' type='type' size='tao_v1_var_array_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'v1_array')
    do i1 = lbound(input%v1_array, 1), ubound(input%v1_array, 1)
      call tao_v1_var_array_struct_to_json(input%v1_array(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%stack)) then
    !line=852 definition='type (tao_eval_stack1_struct), allocatable :: stack(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_eval_stack1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='stack' type='type' size='tao_eval_stack1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call tao_eval_stack1_struct_to_json(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%var_array)) then
    !line=853 definition='type (tao_var_array_struct), allocatable :: var_array(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_var_array_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='var_array' type='type' size='tao_var_array_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'var_array')
    do i1 = lbound(input%var_array, 1), ubound(input%var_array, 1)
      call tao_var_array_struct_to_json(input%var_array(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%attribs)) then
    !line=854 definition='type (all_pointer_struct), allocatable :: attribs(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='all_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='attribs' type='type' size='all_pointer_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'attribs')
    do i1 = lbound(input%attribs, 1), ubound(input%attribs, 1)
      call all_pointer_struct_to_json(input%attribs(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%comp)) then
    !line=855 definition='type (tao_data_var_component_struct), allocatable :: comp(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_data_var_component_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='comp' type='type' size='tao_data_var_component_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'comp')
    do i1 = lbound(input%comp, 1), ubound(input%comp, 1)
      call tao_data_var_component_struct_to_json(input%comp(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%info)) then
    !line=856 definition='type (tao_expression_info_struct), allocatable :: info(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_expression_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='info' type='type' size='tao_expression_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'info')
    do i1 = lbound(input%info, 1), ubound(input%info, 1)
      call tao_expression_info_struct_to_json(input%info(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%info_x)) then
    !line=857 definition='type (tao_expression_info_struct), allocatable :: info_x(:), info_y(:), info_ix(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_expression_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='info_x' type='type' size='tao_expression_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'info_x')
    do i1 = lbound(input%info_x, 1), ubound(input%info_x, 1)
      call tao_expression_info_struct_to_json(input%info_x(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%info_y)) then
    !line=857 definition='type (tao_expression_info_struct), allocatable :: info_x(:), info_y(:), info_ix(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_expression_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='info_y' type='type' size='tao_expression_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'info_y')
    do i1 = lbound(input%info_y, 1), ubound(input%info_y, 1)
      call tao_expression_info_struct_to_json(input%info_y(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%info_ix)) then
    !line=857 definition='type (tao_expression_info_struct), allocatable :: info_x(:), info_y(:), info_ix(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_expression_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='info_ix' type='type' size='tao_expression_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'info_ix')
    do i1 = lbound(input%info_ix, 1), ubound(input%info_ix, 1)
      call tao_expression_info_struct_to_json(input%info_ix(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%picked)) then
    !line=858 definition='logical, allocatable :: picked(:)' type_info=TypeInformation(type='logical', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='picked' type='logical' size=None dimension=':' comment='' default=None
    call json%create_array(json_list1, 'picked')
    do i1 = lbound(input%picked, 1), ubound(input%picked, 1)
      call json%create_logical(json_val, input%picked(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%axis1)) then
    !line=859 definition='real(rp), allocatable :: axis1(:), axis2(:), axis3(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='axis1' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'axis1')
    do i1 = lbound(input%axis1, 1), ubound(input%axis1, 1)
      call json%create_real(json_val, input%axis1(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%axis2)) then
    !line=859 definition='real(rp), allocatable :: axis1(:), axis2(:), axis3(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='axis2' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'axis2')
    do i1 = lbound(input%axis2, 1), ubound(input%axis2, 1)
      call json%create_real(json_val, input%axis2(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%axis3)) then
    !line=859 definition='real(rp), allocatable :: axis1(:), axis2(:), axis3(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='axis3' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'axis3')
    do i1 = lbound(input%axis3, 1), ubound(input%axis3, 1)
      call json%create_real(json_val, input%axis3(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%x)) then
    !line=860 definition='real(rp), allocatable :: x(:), y(:), err(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='x' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'x')
    do i1 = lbound(input%x, 1), ubound(input%x, 1)
      call json%create_real(json_val, input%x(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y)) then
    !line=860 definition='real(rp), allocatable :: x(:), y(:), err(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y')
    do i1 = lbound(input%y, 1), ubound(input%y, 1)
      call json%create_real(json_val, input%y(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%err)) then
    !line=860 definition='real(rp), allocatable :: x(:), y(:), err(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='err' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'err')
    do i1 = lbound(input%err, 1), ubound(input%err, 1)
      call json%create_real(json_val, input%err(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_value)) then
    !line=861 definition='real(rp), allocatable :: y_value(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y_value' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_value')
    do i1 = lbound(input%y_value, 1), ubound(input%y_value, 1)
      call json%create_real(json_val, input%y_value(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%srdt_cache)) then
    !line=862 definition='complex(rp), allocatable :: srdt_cache(:,:,:)' type_info=TypeInformation(type='complex', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='srdt_cache' type='complex' size='rp' dimension=':,:,:' comment='' default=None
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%srdt_cache, 3), ubound(input%srdt_cache, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%srdt_cache, 2), ubound(input%srdt_cache, 2)
        call json%create_array(json_list1, 'srdt_cache')
        do i1 = lbound(input%srdt_cache, 1), ubound(input%srdt_cache, 1)
          call complex_to_json(input%srdt_cache(i1, i2, i3), json_val, depth + 1)
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
  endif
end subroutine tao_scratch_space_struct_to_json
subroutine tao_lat_mode_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_lat_mode_struct
  implicit none
  type(json_core) :: json
  type (tao_lat_mode_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'chrom', input%chrom)
  call json%add(json_root, 'growth_rate', input%growth_rate)
end subroutine tao_lat_mode_struct_to_json
subroutine tao_lat_sigma_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_lat_sigma_struct
  implicit none
  type(json_core) :: json
  type (tao_lat_sigma_struct), pointer, intent(in) :: input
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
  !line=875 definition='real(rp) :: mat(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='mat' type='real' size='rp' dimension='6,6' comment='' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mat, 2), ubound(input%mat, 2)
    call json%create_array(json_list1, 'mat')
    do i1 = lbound(input%mat, 1), ubound(input%mat, 1)
      call json%create_real(json_val, input%mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine tao_lat_sigma_struct_to_json
subroutine tao_spin_dn_dpz_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_spin_dn_dpz_struct
  implicit none
  type(json_core) :: json
  type (tao_spin_dn_dpz_struct), pointer, intent(in) :: input
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
  !line=879 definition='real(rp) vec(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec' type='real' size='rp' dimension='3' comment='n0 derivative wrt pz.' default=None
  call json%create_array(json_list1, 'vec')
  do i1 = lbound(input%vec, 1), ubound(input%vec, 1)
    call json%create_real(json_val, input%vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=880 definition='real(rp) partial(3,3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='partial' type='real' size='rp' dimension='3,3' comment='partial(i:) is spin n0 derivative wrt pz for i^th oscillation mode (1 => a-mode, etc.)' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%partial, 2), ubound(input%partial, 2)
    call json%create_array(json_list1, 'partial')
    do i1 = lbound(input%partial, 1), ubound(input%partial, 1)
      call json%create_real(json_val, input%partial(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=881 definition='real(rp) partial2(3,3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='partial2' type='real' size='rp' dimension='3,3' comment='partial(i:) is spin n0 derivative wrt pz with i^th oscillation mode missing (1 => a-mode, etc.)' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%partial2, 2), ubound(input%partial2, 2)
    call json%create_array(json_list1, 'partial2')
    do i1 = lbound(input%partial2, 1), ubound(input%partial2, 1)
      call json%create_real(json_val, input%partial2(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine tao_spin_dn_dpz_struct_to_json
subroutine tao_spin_ele_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_spin_ele_struct
  implicit none
  type(json_core) :: json
  type (tao_spin_ele_struct), pointer, intent(in) :: input
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
  call tao_spin_dn_dpz_struct_to_json(input%dn_dpz, json_val, depth + 1)
  call json%rename(json_val, 'dn_dpz')
  call json%add(json_root, json_val)
  !line=886 definition='real(rp) :: orb_eigen_val(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orb_eigen_val' type='real' size='rp' dimension='6' comment='' default='0'
  call json%create_array(json_list1, 'orb_eigen_val')
  do i1 = lbound(input%orb_eigen_val, 1), ubound(input%orb_eigen_val, 1)
    call json%create_real(json_val, input%orb_eigen_val(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=887 definition='real(rp) :: orb_eigen_vec(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orb_eigen_vec' type='real' size='rp' dimension='6,6' comment='(j,:) is j^th vector' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%orb_eigen_vec, 2), ubound(input%orb_eigen_vec, 2)
    call json%create_array(json_list1, 'orb_eigen_vec')
    do i1 = lbound(input%orb_eigen_vec, 1), ubound(input%orb_eigen_vec, 1)
      call json%create_real(json_val, input%orb_eigen_vec(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=888 definition='real(rp) :: spin_eigen_vec(6,3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_eigen_vec' type='real' size='rp' dimension='6,3' comment='(j,:) is j^th vector' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%spin_eigen_vec, 2), ubound(input%spin_eigen_vec, 2)
    call json%create_array(json_list1, 'spin_eigen_vec')
    do i1 = lbound(input%spin_eigen_vec, 1), ubound(input%spin_eigen_vec, 1)
      call json%create_real(json_val, input%spin_eigen_vec(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'valid', input%valid)
end subroutine tao_spin_ele_struct_to_json
subroutine tao_spin_polarization_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_spin_polarization_struct
  use bmad_json, only: spin_orbit_map1_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_spin_polarization_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'tune', input%tune)
  call json%add(json_root, 'pol_limit_st', input%pol_limit_st)
  call json%add(json_root, 'pol_limit_dk', input%pol_limit_dk)
  !line=896 definition='real(rp) :: pol_limit_dk_partial(3) = real_garbage$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='pol_limit_dk_partial' type='real' size='rp' dimension='3' comment='Limit using only single mode to calc dn_dpz' default='real_garbage$'
  call json%create_array(json_list1, 'pol_limit_dk_partial')
  do i1 = lbound(input%pol_limit_dk_partial, 1), ubound(input%pol_limit_dk_partial, 1)
    call json%create_real(json_val, input%pol_limit_dk_partial(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=897 definition='real(rp) :: pol_limit_dk_partial2(3) = real_garbage$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='pol_limit_dk_partial2' type='real' size='rp' dimension='3' comment='Limit using only single mode to calc dn_dpz' default='real_garbage$'
  call json%create_array(json_list1, 'pol_limit_dk_partial2')
  do i1 = lbound(input%pol_limit_dk_partial2, 1), ubound(input%pol_limit_dk_partial2, 1)
    call json%create_real(json_val, input%pol_limit_dk_partial2(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'pol_rate_bks', input%pol_rate_bks)
  call json%add(json_root, 'depol_rate', input%depol_rate)
  !line=900 definition='real(rp) :: depol_rate_partial(3) = real_garbage$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='depol_rate_partial' type='real' size='rp' dimension='3' comment='Depolarization rate (1/sec) using only single mode to calc dn_dpz.' default='real_garbage$'
  call json%create_array(json_list1, 'depol_rate_partial')
  do i1 = lbound(input%depol_rate_partial, 1), ubound(input%depol_rate_partial, 1)
    call json%create_real(json_val, input%depol_rate_partial(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=901 definition='real(rp) :: depol_rate_partial2(3) = real_garbage$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='depol_rate_partial2' type='real' size='rp' dimension='3' comment='Depolarization rate (1/sec) using only two modes to calc dn_dpz.' default='real_garbage$'
  call json%create_array(json_list1, 'depol_rate_partial2')
  do i1 = lbound(input%depol_rate_partial2, 1), ubound(input%depol_rate_partial2, 1)
    call json%create_real(json_val, input%depol_rate_partial2(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'integral_bn', input%integral_bn)
  call json%add(json_root, 'integral_bdn', input%integral_bdn)
  call json%add(json_root, 'integral_1ns', input%integral_1ns)
  call json%add(json_root, 'integral_dn2', input%integral_dn2)
  call json%add(json_root, 'valid', input%valid)
  call spin_orbit_map1_struct_to_json(input%q_1turn, json_val, depth + 1)
  call json%rename(json_val, 'q_1turn')
  call json%add(json_root, json_val)
  if (allocated(input%q_ele)) then
    !line=908 definition='type (spin_orbit_map1_struct), allocatable :: q_ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spin_orbit_map1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='q_ele' type='type' size='spin_orbit_map1_struct' dimension=':' comment='Save results from spin_concat_linear_maps in tao_spin_polarization.' default=None
    call json%create_array(json_list1, 'q_ele')
    do i1 = lbound(input%q_ele, 1), ubound(input%q_ele, 1)
      call spin_orbit_map1_struct_to_json(input%q_ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_spin_polarization_struct_to_json
subroutine tao_plot_cache_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_plot_cache_struct
  use bmad_json, only: coord_struct_to_json, ele_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_plot_cache_struct), pointer, intent(in) :: input
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
  call ele_struct_to_json(input%ele, json_val, depth + 1)
  call json%rename(json_val, 'ele')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%orbit, json_val, depth + 1)
  call json%rename(json_val, 'orbit')
  call json%add(json_root, json_val)
  call json%add(json_root, 'err', input%err)
end subroutine tao_plot_cache_struct_to_json
subroutine tao_lattice_branch_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_lattice_branch_struct
  use bmad_json, only: bmad_normal_form_struct_to_json, bunch_params_struct_to_json, bunch_track_struct_to_json, coord_struct_to_json, normal_modes_struct_to_json, ptc_normal_form_struct_to_json, summation_rdt_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_lattice_branch_struct), pointer, intent(in) :: input
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
  ! parent pointer skip: tao_lat (type, Parent tao_lat)
  if (allocated(input%lat_sigma)) then
    !line=925 definition='type (tao_lat_sigma_struct), allocatable :: lat_sigma(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_lat_sigma_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='lat_sigma' type='type' size='tao_lat_sigma_struct' dimension=':' comment='Sigma matrix derived from lattice (not beam).' default=None
    call json%create_array(json_list1, 'lat_sigma')
    do i1 = lbound(input%lat_sigma, 1), ubound(input%lat_sigma, 1)
      call tao_lat_sigma_struct_to_json(input%lat_sigma(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%spin_ele)) then
    !line=926 definition='type (tao_spin_ele_struct), allocatable :: spin_ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_spin_ele_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_ele' type='type' size='tao_spin_ele_struct' dimension=':' comment='Spin stuff' default=None
    call json%create_array(json_list1, 'spin_ele')
    do i1 = lbound(input%spin_ele, 1), ubound(input%spin_ele, 1)
      call tao_spin_ele_struct_to_json(input%spin_ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%bunch_params)) then
    !line=927 definition='type (bunch_params_struct), allocatable :: bunch_params(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='bunch_params_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='bunch_params' type='type' size='bunch_params_struct' dimension=':' comment='Per element' default=None
    call json%create_array(json_list1, 'bunch_params')
    do i1 = lbound(input%bunch_params, 1), ubound(input%bunch_params, 1)
      call bunch_params_struct_to_json(input%bunch_params(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%bunch_params_comb)) then
    !line=928 definition='type (bunch_track_struct), allocatable :: bunch_params_comb(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='bunch_track_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='bunch_params_comb' type='type' size='bunch_track_struct' dimension=':' comment='A comb for each bunch in beam.' default=None
    call json%create_array(json_list1, 'bunch_params_comb')
    do i1 = lbound(input%bunch_params_comb, 1), ubound(input%bunch_params_comb, 1)
      call bunch_track_struct_to_json(input%bunch_params_comb(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%orbit)) then
    !line=929 definition='type (coord_struct), allocatable :: orbit(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='coord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='orbit' type='type' size='coord_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'orbit')
    do i1 = lbound(input%orbit, 1), ubound(input%orbit, 1)
      call coord_struct_to_json(input%orbit(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%plot_cache)) then
    !line=930 definition='type (tao_plot_cache_struct), allocatable :: plot_cache(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_plot_cache_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='plot_cache' type='type' size='tao_plot_cache_struct' dimension=':' comment='Plotting data cache' default=None
    call json%create_array(json_list1, 'plot_cache')
    do i1 = lbound(input%plot_cache, 1), ubound(input%plot_cache, 1)
      call tao_plot_cache_struct_to_json(input%plot_cache(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_lat_mode_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call tao_lat_mode_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call tao_spin_polarization_struct_to_json(input%spin, json_val, depth + 1)
  call json%rename(json_val, 'spin')
  call json%add(json_root, json_val)
  call summation_rdt_struct_to_json(input%srdt, json_val, depth + 1)
  call json%rename(json_val, 'srdt')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%orb0, json_val, depth + 1)
  call json%rename(json_val, 'orb0')
  call json%add(json_root, json_val)
  call normal_modes_struct_to_json(input%modes_ri, json_val, depth + 1)
  call json%rename(json_val, 'modes_ri')
  call json%add(json_root, json_val)
  call normal_modes_struct_to_json(input%modes_6d, json_val, depth + 1)
  call json%rename(json_val, 'modes_6d')
  call json%add(json_root, json_val)
  call ptc_normal_form_struct_to_json(input%ptc_normal_form, json_val, depth + 1)
  call json%rename(json_val, 'ptc_normal_form')
  call json%add(json_root, json_val)
  call bmad_normal_form_struct_to_json(input%bmad_normal_form, json_val, depth + 1)
  call json%rename(json_val, 'bmad_normal_form')
  call json%add(json_root, json_val)
  if (allocated(input%high_E_orb)) then
    !line=939 definition='type (coord_struct), allocatable :: high_E_orb(:), low_E_orb(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='coord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='high_E_orb' type='type' size='coord_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'high_e_orb')
    do i1 = lbound(input%high_E_orb, 1), ubound(input%high_E_orb, 1)
      call coord_struct_to_json(input%high_E_orb(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%low_E_orb)) then
    !line=939 definition='type (coord_struct), allocatable :: high_E_orb(:), low_E_orb(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='coord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='low_E_orb' type='type' size='coord_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'low_e_orb')
    do i1 = lbound(input%low_E_orb, 1), ubound(input%low_E_orb, 1)
      call coord_struct_to_json(input%low_E_orb(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'cache_x_min', input%cache_x_min)
  call json%add(json_root, 'cache_x_max', input%cache_x_max)
  call json%add(json_root, 'comb_ds_save', input%comb_ds_save)
  call json%add(json_root, 'track_state', int(input%track_state))
  call json%add(json_root, 'cache_n_pts', int(input%cache_n_pts))
  call json%add(json_root, 'ix_rad_int_cache', int(input%ix_rad_int_cache))
  call json%add(json_root, 'n_hterms', int(input%n_hterms))
  call json%add(json_root, 'has_open_match_element', input%has_open_match_element)
  call json%add(json_root, 'plot_cache_valid', input%plot_cache_valid)
  call json%add(json_root, 'spin_map_valid', input%spin_map_valid)
  call json%add(json_root, 'twiss_valid', input%twiss_valid)
  call json%add(json_root, 'mode_flip_here', input%mode_flip_here)
end subroutine tao_lattice_branch_struct_to_json
subroutine tao_lattice_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_lattice_struct
  use bmad_json, only: lat_struct_to_json, rad_int_all_ele_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_lattice_struct), pointer, intent(in) :: input
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
  call lat_struct_to_json(input%lat, json_val, depth + 1)
  call json%rename(json_val, 'lat')
  call json%add(json_root, json_val)
  call lat_struct_to_json(input%high_E_lat, json_val, depth + 1)
  call json%rename(json_val, 'high_E_lat')
  call json%add(json_root, json_val)
  call lat_struct_to_json(input%low_E_lat, json_val, depth + 1)
  call json%rename(json_val, 'low_E_lat')
  call json%add(json_root, json_val)
  call json%add(json_root, 'chrom_calc_ok', input%chrom_calc_ok)
  ! parent pointer skip: u (type, Parent universe)
  call rad_int_all_ele_struct_to_json(input%rad_int_by_ele_ri, json_val, depth + 1)
  call json%rename(json_val, 'rad_int_by_ele_ri')
  call json%add(json_root, json_val)
  call rad_int_all_ele_struct_to_json(input%rad_int_by_ele_6d, json_val, depth + 1)
  call json%rename(json_val, 'rad_int_by_ele_6d')
  call json%add(json_root, json_val)
  if (allocated(input%tao_branch)) then
    !line=965 definition='type (tao_lattice_branch_struct), allocatable :: tao_branch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_lattice_branch_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='tao_branch' type='type' size='tao_lattice_branch_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'tao_branch')
    do i1 = lbound(input%tao_branch, 1), ubound(input%tao_branch, 1)
      call tao_lattice_branch_struct_to_json(input%tao_branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine tao_lattice_struct_to_json
subroutine tao_model_element_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_model_element_struct
  use bmad_json, only: beam_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_model_element_struct), pointer, intent(in) :: input
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
  call beam_struct_to_json(input%beam, json_val, depth + 1)
  call json%rename(json_val, 'beam')
  call json%add(json_root, json_val)
  call json%add(json_root, 'save_beam_internally', input%save_beam_internally)
  call json%add(json_root, 'save_beam_to_file', input%save_beam_to_file)
end subroutine tao_model_element_struct_to_json
subroutine tao_beam_branch_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_beam_branch_struct
  use bmad_json, only: beam_init_struct_to_json, beam_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_beam_branch_struct), pointer, intent(in) :: input
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
  call beam_struct_to_json(input%beam_at_start, json_val, depth + 1)
  call json%rename(json_val, 'beam_at_start')
  call json%add(json_root, json_val)
  call beam_init_struct_to_json(input%beam_init, json_val, depth + 1)
  call json%rename(json_val, 'beam_init')
  call json%add(json_root, json_val)
  call beam_init_struct_to_json(input%beam_init_used, json_val, depth + 1)
  call json%rename(json_val, 'beam_init_used')
  call json%add(json_root, json_val)
  call json%add(json_root, 'init_starting_distribution', input%init_starting_distribution)
  call json%add(json_root, 'track_start', trim(input%track_start))
  call json%add(json_root, 'track_end', trim(input%track_end))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_track_start', int(input%ix_track_start))
  call json%add(json_root, 'ix_track_end', int(input%ix_track_end))
end subroutine tao_beam_branch_struct_to_json
subroutine tao_model_branch_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_model_branch_struct
  implicit none
  type(json_core) :: json
  type (tao_model_branch_struct), pointer, intent(in) :: input
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
  if (allocated(input%ele)) then
    !line=1001 definition='type (tao_model_element_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_model_element_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='tao_model_element_struct' dimension=':' comment='Per element information' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call tao_model_element_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_beam_branch_struct_to_json(input%beam, json_val, depth + 1)
  call json%rename(json_val, 'beam')
  call json%add(json_root, json_val)
end subroutine tao_model_branch_struct_to_json
subroutine tao_beam_uni_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_beam_uni_struct
  implicit none
  type(json_core) :: json
  type (tao_beam_uni_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'saved_at', trim(input%saved_at))
  call json%add(json_root, 'dump_file', trim(input%dump_file))
  call json%add(json_root, 'dump_at', trim(input%dump_at))
  call json%add(json_root, 'track_beam_in_universe', input%track_beam_in_universe)
  call json%add(json_root, 'always_reinit', input%always_reinit)
end subroutine tao_beam_uni_struct_to_json
subroutine tao_universe_calc_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_universe_calc_struct
  implicit none
  type(json_core) :: json
  type (tao_universe_calc_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'srdt_for_data', int(input%srdt_for_data))
  call json%add(json_root, 'rad_int_for_data', input%rad_int_for_data)
  call json%add(json_root, 'rad_int_for_plotting', input%rad_int_for_plotting)
  call json%add(json_root, 'chrom_for_data', input%chrom_for_data)
  call json%add(json_root, 'chrom_for_plotting', input%chrom_for_plotting)
  call json%add(json_root, 'lat_sigma_for_data', input%lat_sigma_for_data)
  call json%add(json_root, 'lat_sigma_for_plotting', input%lat_sigma_for_plotting)
  call json%add(json_root, 'dynamic_aperture', input%dynamic_aperture)
  call json%add(json_root, 'one_turn_map', input%one_turn_map)
  call json%add(json_root, 'lattice', input%lattice)
  call json%add(json_root, 'twiss', input%twiss)
  call json%add(json_root, 'track', input%track)
  call json%add(json_root, 'spin_matrices', input%spin_matrices)
end subroutine tao_universe_calc_struct_to_json
subroutine tao_mpi_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_mpi_struct
  implicit none
  type(json_core) :: json
  type (tao_mpi_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'on', input%on)
  call json%add(json_root, 'master', input%master)
  call json%add(json_root, 'rank', int(input%rank))
  call json%add(json_root, 'max_rank', int(input%max_rank))
  call json%add(json_root, 'host_name', trim(input%host_name))
end subroutine tao_mpi_struct_to_json
subroutine tao_dynamic_aperture_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_dynamic_aperture_struct
  use bmad_json, only: aperture_param_struct_to_json, aperture_scan_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_dynamic_aperture_struct), pointer, intent(in) :: input
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
  call aperture_param_struct_to_json(input%param, json_val, depth + 1)
  call json%rename(json_val, 'param')
  call json%add(json_root, json_val)
  if (allocated(input%scan)) then
    !line=1050 definition='type (aperture_scan_struct), allocatable :: scan(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='aperture_scan_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='scan' type='type' size='aperture_scan_struct' dimension=':' comment='One scan for each pz.' default=None
    call json%create_array(json_list1, 'scan')
    do i1 = lbound(input%scan, 1), ubound(input%scan, 1)
      call aperture_scan_struct_to_json(input%scan(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pz)) then
    !line=1051 definition='real(rp), allocatable :: pz(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='pz' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pz')
    do i1 = lbound(input%pz, 1), ubound(input%pz, 1)
      call json%create_real(json_val, input%pz(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ellipse_scale', input%ellipse_scale)
  call json%add(json_root, 'a_emit', input%a_emit)
  call json%add(json_root, 'b_emit', input%b_emit)
end subroutine tao_dynamic_aperture_struct_to_json
subroutine tao_wave_kick_pt_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_wave_kick_pt_struct
  use bmad_json, only: ele_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_wave_kick_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'phi_s', input%phi_s)
  call json%add(json_root, 'phi_r', input%phi_r)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'amp', input%amp)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'ix_dat_before_kick', int(input%ix_dat_before_kick))
  if (associated(input%ele)) then
    call ele_struct_to_json(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
end subroutine tao_wave_kick_pt_struct_to_json
subroutine tao_wave_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_wave_struct
  implicit none
  type(json_core) :: json
  type (tao_wave_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'data_type', trim(input%data_type))
  call json%add(json_root, 'rms_rel_a', input%rms_rel_a)
  call json%add(json_root, 'rms_rel_b', input%rms_rel_b)
  call json%add(json_root, 'rms_rel_as', input%rms_rel_as)
  call json%add(json_root, 'rms_rel_bs', input%rms_rel_bs)
  call json%add(json_root, 'rms_rel_ar', input%rms_rel_ar)
  call json%add(json_root, 'rms_rel_br', input%rms_rel_br)
  call json%add(json_root, 'rms_rel_k', input%rms_rel_k)
  call json%add(json_root, 'rms_rel_ks', input%rms_rel_ks)
  call json%add(json_root, 'rms_rel_kr', input%rms_rel_kr)
  call json%add(json_root, 'rms_phi', input%rms_phi)
  call json%add(json_root, 'rms_phi_s', input%rms_phi_s)
  call json%add(json_root, 'rms_phi_r', input%rms_phi_r)
  call json%add(json_root, 'amp_ba_s', input%amp_ba_s)
  call json%add(json_root, 'amp_ba_r', input%amp_ba_r)
  call json%add(json_root, 'chi_a', input%chi_a)
  call json%add(json_root, 'chi_c', input%chi_c)
  call json%add(json_root, 'chi_ba', input%chi_ba)
  !line=1073 definition='real(rp) :: amp_a(2) = 0, amp_b(2) = 0, amp_ba(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='amp_a' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'amp_a')
  do i1 = lbound(input%amp_a, 1), ubound(input%amp_a, 1)
    call json%create_real(json_val, input%amp_a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1073 definition='real(rp) :: amp_a(2) = 0, amp_b(2) = 0, amp_ba(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='amp_b' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'amp_b')
  do i1 = lbound(input%amp_b, 1), ubound(input%amp_b, 1)
    call json%create_real(json_val, input%amp_b(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1073 definition='real(rp) :: amp_a(2) = 0, amp_b(2) = 0, amp_ba(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='amp_ba' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'amp_ba')
  do i1 = lbound(input%amp_ba, 1), ubound(input%amp_ba, 1)
    call json%create_real(json_val, input%amp_ba(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1074 definition='real(rp) :: coef_a(4) = 0, coef_b(4) = 0, coef_ba(4) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='coef_a' type='real' size='rp' dimension='4' comment='' default='0'
  call json%create_array(json_list1, 'coef_a')
  do i1 = lbound(input%coef_a, 1), ubound(input%coef_a, 1)
    call json%create_real(json_val, input%coef_a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1074 definition='real(rp) :: coef_a(4) = 0, coef_b(4) = 0, coef_ba(4) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='coef_b' type='real' size='rp' dimension='4' comment='' default='0'
  call json%create_array(json_list1, 'coef_b')
  do i1 = lbound(input%coef_b, 1), ubound(input%coef_b, 1)
    call json%create_real(json_val, input%coef_b(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1074 definition='real(rp) :: coef_a(4) = 0, coef_b(4) = 0, coef_ba(4) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='coef_ba' type='real' size='rp' dimension='4' comment='' default='0'
  call json%create_array(json_list1, 'coef_ba')
  do i1 = lbound(input%coef_ba, 1), ubound(input%coef_ba, 1)
    call json%create_real(json_val, input%coef_ba(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_func', int(input%n_func))
  call json%add(json_root, 'ix_a1', int(input%ix_a1))
  call json%add(json_root, 'ix_a2', int(input%ix_a2))
  call json%add(json_root, 'ix_b1', int(input%ix_b1))
  call json%add(json_root, 'ix_b2', int(input%ix_b2))
  call json%add(json_root, 'i_a1', int(input%i_a1))
  call json%add(json_root, 'i_a2', int(input%i_a2))
  call json%add(json_root, 'i_b1', int(input%i_b1))
  call json%add(json_root, 'i_b2', int(input%i_b2))
  call json%add(json_root, 'n_a', int(input%n_a))
  call json%add(json_root, 'n_b', int(input%n_b))
  call json%add(json_root, 'i_curve_wrap_pt', int(input%i_curve_wrap_pt))
  if (allocated(input%ix_data)) then
    !line=1079 definition='integer, allocatable :: ix_data(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ix_data' type='integer' size=None dimension=':' comment='Translates from plot point to datum index' default=None
    call json%create_array(json_list1, 'ix_data')
    do i1 = lbound(input%ix_data, 1), ubound(input%ix_data, 1)
      call json%create_integer(json_val, input%ix_data(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_kick', int(input%n_kick))
  if (allocated(input%kick)) then
    !line=1081 definition='type (tao_wave_kick_pt_struct), allocatable :: kick(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_wave_kick_pt_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='kick' type='type' size='tao_wave_kick_pt_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'kick')
    do i1 = lbound(input%kick, 1), ubound(input%kick, 1)
      call tao_wave_kick_pt_struct_to_json(input%kick(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_graph_struct_to_json(input%base_graph, json_val, depth + 1)
  call json%rename(json_val, 'base_graph')
  call json%add(json_root, json_val)
  if (associated(input%region)) then
    call tao_plot_region_struct_to_json(input%region, json_val, depth + 1)
    call json%rename(json_val, 'region')
    call json%add(json_root, json_val)
  endif
  if (associated(input%d1_dat)) then
    call tao_d1_data_struct_to_json(input%d1_dat, json_val, depth + 1)
    call json%rename(json_val, 'd1_dat')
    call json%add(json_root, json_val)
  endif
end subroutine tao_wave_struct_to_json
subroutine tao_ping_scale_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_ping_scale_struct
  implicit none
  type(json_core) :: json
  type (tao_ping_scale_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'a_mode_meas', input%a_mode_meas)
  call json%add(json_root, 'a_mode_ref', input%a_mode_ref)
  call json%add(json_root, 'b_mode_meas', input%b_mode_meas)
  call json%add(json_root, 'b_mode_ref', input%b_mode_ref)
end subroutine tao_ping_scale_struct_to_json
subroutine tao_universe_pointer_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_universe_pointer_struct
  implicit none
  type(json_core) :: json
  type (tao_universe_pointer_struct), pointer, intent(in) :: input
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
  ! parent pointer skip: u (type, )
end subroutine tao_universe_pointer_struct_to_json
subroutine tao_universe_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_universe_struct
  use bmad_json, only: lat_ele_order_struct_to_json, lat_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_universe_struct), pointer, intent(in) :: input
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
  if (associated(input%model)) then
    call tao_lattice_struct_to_json(input%model, json_val, depth + 1)
    call json%rename(json_val, 'model')
    call json%add(json_root, json_val)
  endif
  if (associated(input%design)) then
    call tao_lattice_struct_to_json(input%design, json_val, depth + 1)
    call json%rename(json_val, 'design')
    call json%add(json_root, json_val)
  endif
  if (associated(input%base)) then
    call tao_lattice_struct_to_json(input%base, json_val, depth + 1)
    call json%rename(json_val, 'base')
    call json%add(json_root, json_val)
  endif
  call tao_beam_uni_struct_to_json(input%beam, json_val, depth + 1)
  call json%rename(json_val, 'beam')
  call json%add(json_root, json_val)
  call tao_dynamic_aperture_struct_to_json(input%dynamic_aperture, json_val, depth + 1)
  call json%rename(json_val, 'dynamic_aperture')
  call json%add(json_root, json_val)
  if (associated(input%model_branch)) then
    !line=1110 definition='type (tao_model_branch_struct), pointer :: model_branch(:)' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='tao_model_branch_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='model_branch' type='type' size='tao_model_branch_struct' dimension=':' comment='model specific information' default=None
    call json%create_array(json_list1, 'model_branch')
    do i1 = lbound(input%model_branch, 1), ubound(input%model_branch, 1)
      call tao_model_branch_struct_to_json(input%model_branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%d2_data)) then
    !line=1111 definition='type (tao_d2_data_struct), allocatable :: d2_data(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_d2_data_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='d2_data' type='type' size='tao_d2_data_struct' dimension=':' comment='The data types' default=None
    call json%create_array(json_list1, 'd2_data')
    do i1 = lbound(input%d2_data, 1), ubound(input%d2_data, 1)
      call tao_d2_data_struct_to_json(input%d2_data(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%data)) then
    !line=1112 definition='type (tao_data_struct), allocatable :: data(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_data_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='data' type='type' size='tao_data_struct' dimension=':' comment='Array of all data.' default=None
    call json%create_array(json_list1, 'data')
    do i1 = lbound(input%data, 1), ubound(input%data, 1)
      call tao_data_struct_to_json(input%data(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_ping_scale_struct_to_json(input%ping_scale, json_val, depth + 1)
  call json%rename(json_val, 'ping_scale')
  call json%add(json_root, json_val)
  call lat_struct_to_json(input%scratch_lat, json_val, depth + 1)
  call json%rename(json_val, 'scratch_lat')
  call json%add(json_root, json_val)
  call tao_universe_calc_struct_to_json(input%calc, json_val, depth + 1)
  call json%rename(json_val, 'calc')
  call json%add(json_root, json_val)
  call lat_ele_order_struct_to_json(input%ele_order, json_val, depth + 1)
  call json%rename(json_val, 'ele_order')
  call json%add(json_root, json_val)
  call tao_spin_map_struct_to_json(input%spin_map, json_val, depth + 1)
  call json%rename(json_val, 'spin_map')
  call json%add(json_root, json_val)
  if (allocated(input%dModel_dVar)) then
    !line=1118 definition='real(rp), allocatable :: dModel_dVar(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dModel_dVar' type='real' size='rp' dimension=':,:' comment='Derivative matrix.' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%dModel_dVar, 2), ubound(input%dModel_dVar, 2)
      call json%create_array(json_list1, 'dmodel_dvar')
      do i1 = lbound(input%dModel_dVar, 1), ubound(input%dModel_dVar, 1)
        call json%create_real(json_val, input%dModel_dVar(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  call json%add(json_root, 'n_d2_data_used', int(input%n_d2_data_used))
  call json%add(json_root, 'n_data_used', int(input%n_data_used))
  call json%add(json_root, 'is_on', input%is_on)
  call json%add(json_root, 'design_same_as_previous', input%design_same_as_previous)
  call json%add(json_root, 'picked_uni', input%picked_uni)
end subroutine tao_universe_struct_to_json
subroutine tao_super_universe_struct_to_json (input, json_root, depth)
  use tao_struct, only: tao_super_universe_struct
  implicit none
  type(json_core) :: json
  type (tao_super_universe_struct), pointer, intent(in) :: input
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
  call tao_global_struct_to_json(input%global, json_val, depth + 1)
  call json%rename(json_val, 'global')
  call json%add(json_root, json_val)
  call tao_init_struct_to_json(input%init, json_val, depth + 1)
  call json%rename(json_val, 'init')
  call json%add(json_root, json_val)
  call tao_common_struct_to_json(input%com, json_val, depth + 1)
  call json%rename(json_val, 'com')
  call json%add(json_root, json_val)
  call tao_plot_page_struct_to_json(input%plot_page, json_val, depth + 1)
  call json%rename(json_val, 'plot_page')
  call json%add(json_root, json_val)
  if (allocated(input%v1_var)) then
    !line=1136 definition='type (tao_v1_var_struct), allocatable :: v1_var(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_v1_var_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='v1_var' type='type' size='tao_v1_var_struct' dimension=':' comment='The variable types' default=None
    call json%create_array(json_list1, 'v1_var')
    do i1 = lbound(input%v1_var, 1), ubound(input%v1_var, 1)
      call tao_v1_var_struct_to_json(input%v1_var(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%var)) then
    !line=1137 definition='type (tao_var_struct), allocatable :: var(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_var_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='var' type='type' size='tao_var_struct' dimension=':' comment='array of all variables.' default=None
    call json%create_array(json_list1, 'var')
    do i1 = lbound(input%var, 1), ubound(input%var, 1)
      call tao_var_struct_to_json(input%var(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%u)) then
    !line=1138 definition='type (tao_universe_struct), allocatable :: u(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_universe_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='u' type='type' size='tao_universe_struct' dimension=':' comment='array of universes.' default=None
    call json%create_array(json_list1, 'u')
    do i1 = lbound(input%u, 1), ubound(input%u, 1)
      call tao_universe_struct_to_json(input%u(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_mpi_struct_to_json(input%mpi, json_val, depth + 1)
  call json%rename(json_val, 'mpi')
  call json%add(json_root, json_val)
  if (allocated(input%key)) then
    !line=1140 definition='integer, allocatable :: key(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='key' type='integer' size=None dimension=':' comment='' default=None
    call json%create_array(json_list1, 'key')
    do i1 = lbound(input%key, 1), ubound(input%key, 1)
      call json%create_integer(json_val, input%key(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_building_wall_struct_to_json(input%building_wall, json_val, depth + 1)
  call json%rename(json_val, 'building_wall')
  call json%add(json_root, json_val)
  call tao_wave_struct_to_json(input%wave, json_val, depth + 1)
  call json%rename(json_val, 'wave')
  call json%add(json_root, json_val)
  call json%add(json_root, 'n_var_used', int(input%n_var_used))
  call json%add(json_root, 'n_v1_var_used', int(input%n_v1_var_used))
  !line=1145 definition='type (tao_cmd_history_struct) :: history(1000) = tao_cmd_history_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tao_cmd_history_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='history' type='type' size='tao_cmd_history_struct' dimension='1000' comment='command history' default='tao_cmd_history_struct()'
  call json%create_array(json_list1, 'history')
  do i1 = lbound(input%history, 1), ubound(input%history, 1)
    call tao_cmd_history_struct_to_json(input%history(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'initialized', input%initialized)
end subroutine tao_super_universe_struct_to_json
subroutine tao_c_interface_common_struct_to_json (input, json_root, depth)
  use tao_c_interface_mod, only: tao_c_interface_common_struct
  implicit none
  type(json_core) :: json
  type (tao_c_interface_common_struct), pointer, intent(in) :: input
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
  if (allocated(input%c_real)) then
    !line=17 definition='real(c_double), allocatable :: c_real(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='c_double', static=False, target=False, value=False, volatile=False, attributes=()) name='c_real' type='real' size='c_double' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'c_real')
    do i1 = lbound(input%c_real, 1), ubound(input%c_real, 1)
      call json%create_real(json_val, input%c_real(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%c_integer)) then
    !line=18 definition='integer(c_int), allocatable :: c_integer(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='c_int', static=False, target=False, value=False, volatile=False, attributes=()) name='c_integer' type='integer' size='c_int' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'c_integer')
    do i1 = lbound(input%c_integer, 1), ubound(input%c_integer, 1)
      call json%create_integer(json_val, input%c_integer(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  !line=19 definition='character(c_char) :: c_line(n_char_show+1)' type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='c_char', static=False, target=False, value=False, volatile=False, attributes=()) name='c_line' type='character' size='c_char' dimension='n_char_show+1' comment='' default=None
  call json%create_array(json_list1, 'c_line')
  do i1 = lbound(input%c_line, 1), ubound(input%c_line, 1)
    call json%create_string(json_val, trim(input%c_line(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_real', int(input%n_real))
  call json%add(json_root, 'n_int', int(input%n_int))
end subroutine tao_c_interface_common_struct_to_json
subroutine tao_top10_struct_to_json (input, json_root, depth)
  use tao_top10_mod, only: tao_top10_struct
  implicit none
  type(json_core) :: json
  type (tao_top10_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'index', int(input%index))
  call json%add(json_root, 'valid', input%valid)
end subroutine tao_top10_struct_to_json
subroutine tao_d2_data_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_d2_data_input
  implicit none
  type(json_core) :: json
  type (tao_d2_data_input), pointer, intent(in) :: input
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
end subroutine tao_d2_data_input_to_json
subroutine tao_d1_data_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_d1_data_input
  implicit none
  type(json_core) :: json
  type (tao_d1_data_input), pointer, intent(in) :: input
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
end subroutine tao_d1_data_input_to_json
subroutine tao_datum_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_datum_input
  use bmad_json, only: spin_axis_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_datum_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'data_type', trim(input%data_type))
  call json%add(json_root, 'ele_ref_name', trim(input%ele_ref_name))
  call json%add(json_root, 'ele_start_name', trim(input%ele_start_name))
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'merit_type', trim(input%merit_type))
  call json%add(json_root, 'meas', input%meas)
  call json%add(json_root, 'weight', input%weight)
  call json%add(json_root, 'good_user', input%good_user)
  call json%add(json_root, 'good_opt', input%good_opt)
  call json%add(json_root, 'data_source', trim(input%data_source))
  call json%add(json_root, 'eval_point', trim(input%eval_point))
  call json%add(json_root, 's_offset', input%s_offset)
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call spin_axis_struct_to_json(input%spin_axis, json_val, depth + 1)
  call json%rename(json_val, 'spin_axis')
  call json%add(json_root, json_val)
  call json%add(json_root, 'invalid_value', input%invalid_value)
  call json%add(json_root, 'error_rms', input%error_rms)
end subroutine tao_datum_input_to_json
subroutine tao_v1_var_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_v1_var_input
  implicit none
  type(json_core) :: json
  type (tao_v1_var_input), pointer, intent(in) :: input
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
end subroutine tao_v1_var_input_to_json
subroutine tao_var_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_var_input
  implicit none
  type(json_core) :: json
  type (tao_var_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'attribute', trim(input%attribute))
  call json%add(json_root, 'universe', trim(input%universe))
  call json%add(json_root, 'weight', input%weight)
  call json%add(json_root, 'step', input%step)
  call json%add(json_root, 'low_lim', input%low_lim)
  call json%add(json_root, 'high_lim', input%high_lim)
  call json%add(json_root, 'merit_type', trim(input%merit_type))
  call json%add(json_root, 'good_user', input%good_user)
  call json%add(json_root, 'key_bound', input%key_bound)
  call json%add(json_root, 'key_delta', input%key_delta)
  call json%add(json_root, 'meas', input%meas)
end subroutine tao_var_input_to_json
subroutine tao_region_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_region_input
  implicit none
  type(json_core) :: json
  type (tao_region_input), pointer, intent(in) :: input
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
  !line=71 definition='real(rp) :: location(4) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='location' type='real' size='rp' dimension='4' comment='location on page.' default='0'
  call json%create_array(json_list1, 'location')
  do i1 = lbound(input%location, 1), ubound(input%location, 1)
    call json%create_real(json_val, input%location(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine tao_region_input_to_json
subroutine tao_place_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_place_input
  implicit none
  type(json_core) :: json
  type (tao_place_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'region', trim(input%region))
  call json%add(json_root, 'plot', trim(input%plot))
end subroutine tao_place_input_to_json
subroutine tao_curve_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_curve_input
  use sim_utils_json, only: qp_line_struct_to_json, qp_symbol_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_curve_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'data_source', trim(input%data_source))
  call json%add(json_root, 'data_type_x', trim(input%data_type_x))
  call json%add(json_root, 'data_type_z', trim(input%data_type_z))
  call json%add(json_root, 'data_type', trim(input%data_type))
  call json%add(json_root, 'data_index', trim(input%data_index))
  call json%add(json_root, 'legend_text', trim(input%legend_text))
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'component', trim(input%component))
  call json%add(json_root, 'y_axis_scale_factor', input%y_axis_scale_factor)
  call json%add(json_root, 'z_color0', input%z_color0)
  call json%add(json_root, 'z_color1', input%z_color1)
  call json%add(json_root, 'symbol_every', int(input%symbol_every))
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'n_turn', int(input%n_turn))
  call json%add(json_root, 'draw_line', input%draw_line)
  call json%add(json_root, 'draw_symbols', input%draw_symbols)
  call json%add(json_root, 'draw_symbol_index', input%draw_symbol_index)
  call json%add(json_root, 'draw_error_bars', input%draw_error_bars)
  call json%add(json_root, 'use_y2', input%use_y2)
  call json%add(json_root, 'use_z_color', input%use_z_color)
  call json%add(json_root, 'autoscale_z_color', input%autoscale_z_color)
  call json%add(json_root, 'smooth_line_calc', input%smooth_line_calc)
  call json%add(json_root, 'ele_ref_name', trim(input%ele_ref_name))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call qp_line_struct_to_json(input%line, json_val, depth + 1)
  call json%rename(json_val, 'line')
  call json%add(json_root, json_val)
  call qp_symbol_struct_to_json(input%symbol, json_val, depth + 1)
  call json%rename(json_val, 'symbol')
  call json%add(json_root, json_val)
  call tao_histogram_struct_to_json(input%hist, json_val, depth + 1)
  call json%rename(json_val, 'hist')
  call json%add(json_root, json_val)
  call tao_curve_orbit_struct_to_json(input%orbit, json_val, depth + 1)
  call json%rename(json_val, 'orbit')
  call json%add(json_root, json_val)
  call tao_curve_color_struct_to_json(input%z_color, json_val, depth + 1)
  call json%rename(json_val, 'z_color')
  call json%add(json_root, json_val)
end subroutine tao_curve_input_to_json
subroutine tao_graph_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_graph_input
  use sim_utils_json, only: qp_axis_struct_to_json, qp_legend_struct_to_json, qp_point_struct_to_json, qp_rect_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_graph_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'type', trim(input%type))
  call json%add(json_root, 'title', trim(input%title))
  call json%add(json_root, 'component', trim(input%component))
  !line=117 definition="character(100) :: text_legend(10) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='100', static=False, target=False, value=False, volatile=False, attributes=()) name='text_legend' type='character' size='100' dimension='10' comment='' default="''"
  call json%create_array(json_list1, 'text_legend')
  do i1 = lbound(input%text_legend, 1), ubound(input%text_legend, 1)
    call json%create_string(json_val, trim(input%text_legend(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'floor_plan_view', trim(input%floor_plan_view))
  call json%add(json_root, 'floor_plan_orbit_color', trim(input%floor_plan_orbit_color))
  !line=120 definition='integer :: box(4) = [1, 1, 1, 1]' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='box' type='integer' size=None dimension='4' comment='' default='[1, 1, 1, 1]'
  call json%create_array(json_list1, 'box')
  do i1 = lbound(input%box, 1), ubound(input%box, 1)
    call json%create_integer(json_val, input%box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'n_curve', int(input%n_curve))
  call json%add(json_root, 'x_axis_scale_factor', input%x_axis_scale_factor)
  call json%add(json_root, 'symbol_size_scale', input%symbol_size_scale)
  call json%add(json_root, 'floor_plan_rotation', input%floor_plan_rotation)
  call json%add(json_root, 'floor_plan_orbit_scale', input%floor_plan_orbit_scale)
  call json%add(json_root, 'floor_plan_flip_label_side', input%floor_plan_flip_label_side)
  call json%add(json_root, 'floor_plan_size_is_absolute', input%floor_plan_size_is_absolute)
  call json%add(json_root, 'floor_plan_draw_only_first_pass', input%floor_plan_draw_only_first_pass)
  call json%add(json_root, 'correct_xy_distortion', input%correct_xy_distortion)
  call json%add(json_root, 'clip', input%clip)
  call json%add(json_root, 'draw_title', input%draw_title)
  call json%add(json_root, 'draw_axes', input%draw_axes)
  call json%add(json_root, 'draw_grid', input%draw_grid)
  call json%add(json_root, 'draw_curve_legend', input%draw_curve_legend)
  call json%add(json_root, 'draw_only_good_user_data_or_vars', input%draw_only_good_user_data_or_vars)
  call json%add(json_root, 'allow_wrap_around', input%allow_wrap_around)
  call tao_floor_plan_struct_to_json(input%floor_plan, json_val, depth + 1)
  call json%rename(json_val, 'floor_plan')
  call json%add(json_root, json_val)
  call qp_point_struct_to_json(input%text_legend_origin, json_val, depth + 1)
  call json%rename(json_val, 'text_legend_origin')
  call json%add(json_root, json_val)
  call qp_point_struct_to_json(input%curve_legend_origin, json_val, depth + 1)
  call json%rename(json_val, 'curve_legend_origin')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%margin, json_val, depth + 1)
  call json%rename(json_val, 'margin')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%scale_margin, json_val, depth + 1)
  call json%rename(json_val, 'scale_margin')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%x2, json_val, depth + 1)
  call json%rename(json_val, 'x2')
  call json%add(json_root, json_val)
  call qp_axis_struct_to_json(input%y2, json_val, depth + 1)
  call json%rename(json_val, 'y2')
  call json%add(json_root, json_val)
  call qp_legend_struct_to_json(input%curve_legend, json_val, depth + 1)
  call json%rename(json_val, 'curve_legend')
  call json%add(json_root, json_val)
end subroutine tao_graph_input_to_json
subroutine tao_plot_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_plot_input
  use sim_utils_json, only: qp_axis_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_plot_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'description', trim(input%description))
  call json%add(json_root, 'x_axis_type', trim(input%x_axis_type))
  call json%add(json_root, 'n_graph', int(input%n_graph))
  call json%add(json_root, 'autoscale_gang_x', input%autoscale_gang_x)
  call json%add(json_root, 'autoscale_gang_y', input%autoscale_gang_y)
  call json%add(json_root, 'autoscale_x', input%autoscale_x)
  call json%add(json_root, 'autoscale_y', input%autoscale_y)
  call json%add(json_root, 'n_curve_pts', int(input%n_curve_pts))
  call qp_axis_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
end subroutine tao_plot_input_to_json
subroutine tao_design_lat_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_design_lat_input
  implicit none
  type(json_core) :: json
  type (tao_design_lat_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'file', trim(input%file))
  call json%add(json_root, 'file2', trim(input%file2))
  call json%add(json_root, 'language', trim(input%language))
  call json%add(json_root, 'use_line', trim(input%use_line))
  call json%add(json_root, 'one_turn_map_calc', input%one_turn_map_calc)
  call json%add(json_root, 'dynamic_aperture_calc', input%dynamic_aperture_calc)
  call json%add(json_root, 'reverse_lattice', input%reverse_lattice)
  call json%add(json_root, 'start_branch_at', trim(input%start_branch_at))
  call json%add(json_root, 'slice_lattice', trim(input%slice_lattice))
  !line=177 definition="character(40) :: use_element_range(2) = ''" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='use_element_range' type='character' size='40' dimension='2' comment='' default="''"
  call json%create_array(json_list1, 'use_element_range')
  do i1 = lbound(input%use_element_range, 1), ubound(input%use_element_range, 1)
    call json%create_string(json_val, trim(input%use_element_range(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine tao_design_lat_input_to_json
subroutine tao_key_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_key_input
  implicit none
  type(json_core) :: json
  type (tao_key_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'attrib_name', trim(input%attrib_name))
  call json%add(json_root, 'delta', input%delta)
  call json%add(json_root, 'universe', trim(input%universe))
  call json%add(json_root, 'small_step', input%small_step)
  call json%add(json_root, 'low_lim', input%low_lim)
  call json%add(json_root, 'high_lim', input%high_lim)
  call json%add(json_root, 'weight', input%weight)
  call json%add(json_root, 'good_opt', input%good_opt)
  call json%add(json_root, 'merit_type', trim(input%merit_type))
end subroutine tao_key_input_to_json
subroutine tao_plot_page_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_plot_page_input
  use sim_utils_json, only: qp_rect_struct_to_json
  implicit none
  type(json_core) :: json
  type (tao_plot_page_input), pointer, intent(in) :: input
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
  call tao_title_struct_to_json(input%title, json_val, depth + 1)
  call json%rename(json_val, 'title')
  call json%add(json_root, json_val)
  call tao_title_struct_to_json(input%subtitle, json_val, depth + 1)
  call json%rename(json_val, 'subtitle')
  call json%add(json_root, json_val)
  call qp_rect_struct_to_json(input%border, json_val, depth + 1)
  call json%rename(json_val, 'border')
  call json%add(json_root, json_val)
  call json%add(json_root, 'plot_display_type', trim(input%plot_display_type))
  !line=198 definition='real(rp) :: size(2) = 0.0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='size' type='real' size='rp' dimension='2' comment='width and height of window in pixels.' default='0.0'
  call json%create_array(json_list1, 'size')
  do i1 = lbound(input%size, 1), ubound(input%size, 1)
    call json%create_real(json_val, input%size(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'text_height', input%text_height)
  call json%add(json_root, 'main_title_text_scale', input%main_title_text_scale)
  call json%add(json_root, 'graph_title_text_scale', input%graph_title_text_scale)
  call json%add(json_root, 'axis_number_text_scale', input%axis_number_text_scale)
  call json%add(json_root, 'axis_label_text_scale', input%axis_label_text_scale)
  call json%add(json_root, 'legend_text_scale', input%legend_text_scale)
  call json%add(json_root, 'key_table_text_scale', input%key_table_text_scale)
  call json%add(json_root, 'floor_plan_shape_scale', input%floor_plan_shape_scale)
  call json%add(json_root, 'floor_plan_text_scale', input%floor_plan_text_scale)
  call json%add(json_root, 'lat_layout_shape_scale', input%lat_layout_shape_scale)
  call json%add(json_root, 'lat_layout_text_scale', input%lat_layout_text_scale)
  call json%add(json_root, 'curve_legend_line_len', input%curve_legend_line_len)
  call json%add(json_root, 'curve_legend_text_offset', input%curve_legend_text_offset)
  call json%add(json_root, 'n_curve_pts', int(input%n_curve_pts))
  call json%add(json_root, 'delete_overlapping_plots', input%delete_overlapping_plots)
  call json%add(json_root, 'draw_graph_title_suffix', input%draw_graph_title_suffix)
end subroutine tao_plot_page_input_to_json
subroutine tao_ele_shape_input_to_json (input, json_root, depth)
  use tao_input_struct, only: tao_ele_shape_input
  implicit none
  type(json_core) :: json
  type (tao_ele_shape_input), pointer, intent(in) :: input
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
  call json%add(json_root, 'ele_id', trim(input%ele_id))
  call json%add(json_root, 'shape', trim(input%shape))
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'size', input%size)
  call json%add(json_root, 'label', trim(input%label))
  call json%add(json_root, 'draw', input%draw)
  call json%add(json_root, 'multi', input%multi)
  call json%add(json_root, 'line_width', int(input%line_width))
  call json%add(json_root, 'offset', input%offset)
end subroutine tao_ele_shape_input_to_json
end module tao_json