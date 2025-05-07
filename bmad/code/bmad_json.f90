module bmad_json
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
subroutine ibs_struct_to_json (input, json_root, depth)
  use ibs_rates_mod, only: ibs_struct
  implicit none
  type(json_core) :: json
  type (ibs_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'inv_ta', input%inv_Ta)
  call json%add(json_root, 'inv_tb', input%inv_Tb)
  call json%add(json_root, 'inv_tz', input%inv_Tz)
end subroutine ibs_struct_to_json
subroutine momentum_aperture_struct_to_json (input, json_root, depth)
  use touschek_mod, only: momentum_aperture_struct
  implicit none
  type(json_core) :: json
  type (momentum_aperture_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'pos', input%pos)
  call json%add(json_root, 'neg', input%neg)
end subroutine momentum_aperture_struct_to_json
subroutine ibs_sim_param_struct_to_json (input, json_root, depth)
  use ibs_mod, only: ibs_sim_param_struct
  implicit none
  type(json_core) :: json
  type (ibs_sim_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'tau_a', input%tau_a)
  call json%add(json_root, 'clog_to_use', int(input%clog_to_use))
  call json%add(json_root, 'set_dispersion', input%set_dispersion)
  call json%add(json_root, 'eta_set', input%eta_set)
  call json%add(json_root, 'etap_set', input%etap_set)
  call json%add(json_root, 'do_pwd', input%do_pwd)
  call json%add(json_root, 'inductance', input%inductance)
  call json%add(json_root, 'formula', trim(input%formula))
end subroutine ibs_sim_param_struct_to_json
subroutine ibs_lifetime_struct_to_json (input, json_root, depth)
  use ibs_mod, only: ibs_lifetime_struct
  implicit none
  type(json_core) :: json
  type (ibs_lifetime_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'tlx', input%Tlx)
  call json%add(json_root, 'tly', input%Tly)
  call json%add(json_root, 'tlp', input%Tlp)
end subroutine ibs_lifetime_struct_to_json
subroutine ibs_maxratio_struct_to_json (input, json_root, depth)
  use ibs_mod, only: ibs_maxratio_struct
  implicit none
  type(json_core) :: json
  type (ibs_maxratio_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'rx', input%rx)
  call json%add(json_root, 'ry', input%ry)
  call json%add(json_root, 'r_p', input%r_p)
end subroutine ibs_maxratio_struct_to_json
subroutine astra_lattice_param_struct_to_json (input, json_root, depth)
  use astra_interface_mod, only: astra_lattice_param_struct
  implicit none
  type(json_core) :: json
  type (astra_lattice_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'fieldmap_dimension', int(input%fieldmap_dimension))
end subroutine astra_lattice_param_struct_to_json
subroutine gpt_lat_param_struct_to_json (input, json_root, depth)
  use gpt_interface_mod, only: gpt_lat_param_struct
  implicit none
  type(json_core) :: json
  type (gpt_lat_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'fieldmap_dimension', int(input%fieldmap_dimension))
  call json%add(json_root, 'only_write_autophase_parameters', input%only_write_autophase_parameters)
  call json%add(json_root, 'gpt_filename', trim(input%gpt_filename))
  call json%add(json_root, 'header_file_name', trim(input%header_file_name))
  call json%add(json_root, 'tracking_end_element', trim(input%tracking_end_element))
end subroutine gpt_lat_param_struct_to_json
subroutine ptc_rad_map_struct_to_json (input, json_root, depth)
  use ptc_map_with_radiation_mod, only: ptc_rad_map_struct
  implicit none
  type(json_core) :: json
  type (ptc_rad_map_struct), pointer, intent(in) :: input
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
  ! config skip_members: ptc_rad_map_struct%sub_map (type, Type tree_element in PTC)
  call json%add(json_root, 'lattice_file', trim(input%lattice_file))
  call json%add(json_root, 'dref_time', input%dref_time)
  call json%add(json_root, 'p0c_start', input%p0c_start)
  call json%add(json_root, 'p0c_end', input%p0c_end)
  call json%add(json_root, 's_end', input%s_end)
  call json%add(json_root, 'map_order', int(input%map_order))
  call json%add(json_root, 'radiation_damping_on', input%radiation_damping_on)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele_start', int(input%ix_ele_start))
  call json%add(json_root, 'ix_ele_end', int(input%ix_ele_end))
  !line=21 definition='real(rp) nodamp_mat(6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='nodamp_mat' type='real' size='rp' dimension='6,6' comment='Nondamped orbital matrix. M_orbit = M_damp * M_nodamp' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%nodamp_mat, 2), ubound(input%nodamp_mat, 2)
    call json%create_array(json_list1, 'nodamp_mat')
    do i1 = lbound(input%nodamp_mat, 1), ubound(input%nodamp_mat, 1)
      call json%create_real(json_val, input%nodamp_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=22 definition='real(rp) damp_mat(6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='damp_mat' type='real' size='rp' dimension='6,6' comment='Damping "correction" to orbital matrix.' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%damp_mat, 2), ubound(input%damp_mat, 2)
    call json%create_array(json_list1, 'damp_mat')
    do i1 = lbound(input%damp_mat, 1), ubound(input%damp_mat, 1)
      call json%create_real(json_val, input%damp_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=23 definition='real(rp) stoc_mat(6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='stoc_mat' type='real' size='rp' dimension='6,6' comment='Stochatic matrix for the orbit.' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%stoc_mat, 2), ubound(input%stoc_mat, 2)
    call json%create_array(json_list1, 'stoc_mat')
    do i1 = lbound(input%stoc_mat, 1), ubound(input%stoc_mat, 1)
      call json%create_real(json_val, input%stoc_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=24 definition='real(rp) ref0(6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='ref0' type='real' size='rp' dimension='6' comment='Reference orbit at start.' default=None
  call json%create_array(json_list1, 'ref0')
  do i1 = lbound(input%ref0, 1), ubound(input%ref0, 1)
    call json%create_real(json_val, input%ref0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=25 definition='real(rp) ref1(6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='ref1' type='real' size='rp' dimension='6' comment='Reference orbit at end.' default=None
  call json%create_array(json_list1, 'ref1')
  do i1 = lbound(input%ref1, 1), ubound(input%ref1, 1)
    call json%create_real(json_val, input%ref1(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine ptc_rad_map_struct_to_json
subroutine pmd_unit_struct_to_json (input, json_root, depth)
  use hdf5_openpmd_mod, only: pmd_unit_struct
  implicit none
  type(json_core) :: json
  type (pmd_unit_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'unitsymbol', trim(input%unitSymbol))
  call json%add(json_root, 'unitsi', input%unitSI)
  !line=12 definition='real(rp) :: unitDimension(7) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='unitDimension' type='real' size='rp' dimension='7' comment='SI Base Exponents' default='0'
  call json%create_array(json_list1, 'unitdimension')
  do i1 = lbound(input%unitDimension, 1), ubound(input%unitDimension, 1)
    call json%create_real(json_val, input%unitDimension(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine pmd_unit_struct_to_json
subroutine hdf5_info_struct_to_json (input, json_root, depth)
  use hdf5_interface, only: hdf5_info_struct
  implicit none
  type(json_core) :: json
  type (hdf5_info_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'element_type', int(input%element_type))
  call json%add(json_root, 'data_class_type', int(input%data_class_type))
  ! config skip_members: hdf5_info_struct%data_dim (integer, Dimensions. Not used for groups. EG: Scaler data has [1, 0, 0].)
  call json%add(json_root, 'data_size', int(input%data_size))
  call json%add(json_root, 'num_attributes', int(input%num_attributes))
end subroutine hdf5_info_struct_to_json
subroutine multipass_region_ele_struct_to_json (input, json_root, depth)
  use write_lattice_file_mod, only: multipass_region_ele_struct
  implicit none
  type(json_core) :: json
  type (multipass_region_ele_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_region', int(input%ix_region))
  call json%add(json_root, 'region_start_pt', input%region_start_pt)
  call json%add(json_root, 'region_stop_pt', input%region_stop_pt)
end subroutine multipass_region_ele_struct_to_json
subroutine multipass_region_branch_struct_to_json (input, json_root, depth)
  use write_lattice_file_mod, only: multipass_region_branch_struct
  implicit none
  type(json_core) :: json
  type (multipass_region_branch_struct), pointer, intent(in) :: input
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
    !line=13 definition='type (multipass_region_ele_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='multipass_region_ele_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='multipass_region_ele_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call multipass_region_ele_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine multipass_region_branch_struct_to_json
subroutine multipass_region_lat_struct_to_json (input, json_root, depth)
  use write_lattice_file_mod, only: multipass_region_lat_struct
  implicit none
  type(json_core) :: json
  type (multipass_region_lat_struct), pointer, intent(in) :: input
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
  if (allocated(input%branch)) then
    !line=17 definition='type (multipass_region_branch_struct), allocatable :: branch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='multipass_region_branch_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='branch' type='type' size='multipass_region_branch_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call multipass_region_branch_struct_to_json(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine multipass_region_lat_struct_to_json
subroutine diffuse_param_struct_to_json (input, json_root, depth)
  use photon_reflection_mod, only: diffuse_param_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (diffuse_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'lambda', input%lambda)
  call json%add(json_root, 'c_norm', input%c_norm)
  call json%add(json_root, 'chx_norm', input%chx_norm)
  !line=16 definition='type (spline_struct) prob_spline(0:50)' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='prob_spline' type='type' size='spline_struct' dimension='0:50' comment='' default=None
  call json%create_array(json_list1, 'prob_spline')
  do i1 = lbound(input%prob_spline, 1), ubound(input%prob_spline, 1)
    call spline_struct_to_json(input%prob_spline(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_pt_spline', int(input%n_pt_spline))
end subroutine diffuse_param_struct_to_json
subroutine cheb_diffuse_struct_to_json (input, json_root, depth)
  use photon_reflection_mod, only: cheb_diffuse_struct
  implicit none
  type(json_core) :: json
  type (cheb_diffuse_struct), pointer, intent(in) :: input
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
  !line=21 definition='real(rp) cch_int(n_cheb_term$), cch(n_cheb_term$)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='cch_int' type='real' size='rp' dimension='n_cheb_term$' comment='' default=None
  call json%create_array(json_list1, 'cch_int')
  do i1 = lbound(input%cch_int, 1), ubound(input%cch_int, 1)
    call json%create_real(json_val, input%cch_int(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=21 definition='real(rp) cch_int(n_cheb_term$), cch(n_cheb_term$)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='cch' type='real' size='rp' dimension='n_cheb_term$' comment='' default=None
  call json%create_array(json_list1, 'cch')
  do i1 = lbound(input%cch, 1), ubound(input%cch, 1)
    call json%create_real(json_val, input%cch(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine cheb_diffuse_struct_to_json
subroutine diffuse_common_struct_to_json (input, json_root, depth)
  use photon_reflection_mod, only: diffuse_common_struct
  implicit none
  type(json_core) :: json
  type (diffuse_common_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'use_spline_fit', input%use_spline_fit)
  call json%add(json_root, 'area_err_tol', input%area_err_tol)
end subroutine diffuse_common_struct_to_json
subroutine photon_init_x_angle_spline_struct_to_json (input, json_root, depth)
  use photon_init_spline_mod, only: photon_init_x_angle_spline_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (photon_init_x_angle_spline_struct), pointer, intent(in) :: input
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
  if (allocated(input%prob)) then
    !line=16 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='prob' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'prob')
    do i1 = lbound(input%prob, 1), ubound(input%prob, 1)
      call spline_struct_to_json(input%prob(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pl)) then
    !line=16 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pl' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pl')
    do i1 = lbound(input%pl, 1), ubound(input%pl, 1)
      call spline_struct_to_json(input%pl(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pc)) then
    !line=16 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pc' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pc')
    do i1 = lbound(input%pc, 1), ubound(input%pc, 1)
      call spline_struct_to_json(input%pc(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pl45)) then
    !line=16 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pl45' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pl45')
    do i1 = lbound(input%pl45, 1), ubound(input%pl45, 1)
      call spline_struct_to_json(input%pl45(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine photon_init_x_angle_spline_struct_to_json
subroutine photon_init_y_angle_spline_struct_to_json (input, json_root, depth)
  use photon_init_spline_mod, only: photon_init_y_angle_spline_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (photon_init_y_angle_spline_struct), pointer, intent(in) :: input
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
  if (allocated(input%prob)) then
    !line=20 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='prob' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'prob')
    do i1 = lbound(input%prob, 1), ubound(input%prob, 1)
      call spline_struct_to_json(input%prob(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pl)) then
    !line=20 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pl' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pl')
    do i1 = lbound(input%pl, 1), ubound(input%pl, 1)
      call spline_struct_to_json(input%pl(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pc)) then
    !line=20 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pc' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pc')
    do i1 = lbound(input%pc, 1), ubound(input%pc, 1)
      call spline_struct_to_json(input%pc(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%pl45)) then
    !line=20 definition='type (spline_struct), allocatable :: prob(:), pl(:), pc(:), pl45(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pl45' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pl45')
    do i1 = lbound(input%pl45, 1), ubound(input%pl45, 1)
      call spline_struct_to_json(input%pl45(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%x_angle)) then
    !line=21 definition='type (photon_init_x_angle_spline_struct), allocatable :: x_angle(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='photon_init_x_angle_spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='x_angle' type='type' size='photon_init_x_angle_spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'x_angle')
    do i1 = lbound(input%x_angle, 1), ubound(input%x_angle, 1)
      call photon_init_x_angle_spline_struct_to_json(input%x_angle(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine photon_init_y_angle_spline_struct_to_json
subroutine photon_init_splines_struct_to_json (input, json_root, depth)
  use photon_init_spline_mod, only: photon_init_splines_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (photon_init_splines_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'source_type', trim(input%source_type))
  call json%add(json_root, 'spline_space_dimensions', int(input%spline_space_dimensions))
  if (allocated(input%energy_prob)) then
    !line=27 definition='type (spline_struct), allocatable :: energy_prob(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='energy_prob' type='type' size='spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'energy_prob')
    do i1 = lbound(input%energy_prob, 1), ubound(input%energy_prob, 1)
      call spline_struct_to_json(input%energy_prob(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_angle)) then
    !line=28 definition='type (photon_init_y_angle_spline_struct), allocatable :: y_angle(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='photon_init_y_angle_spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='y_angle' type='type' size='photon_init_y_angle_spline_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_angle')
    do i1 = lbound(input%y_angle, 1), ubound(input%y_angle, 1)
      call photon_init_y_angle_spline_struct_to_json(input%y_angle(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine photon_init_splines_struct_to_json
subroutine crystal_param_struct_to_json (input, json_root, depth)
  use photon_utils_mod, only: crystal_param_struct
  implicit none
  type(json_core) :: json
  type (crystal_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'cap_gamma', input%cap_gamma)
  call json%add(json_root, 'dtheta_sin_2theta', input%dtheta_sin_2theta)
  call json%add(json_root, 'b_eff', input%b_eff)
  call json%add(json_root, 'wavelength', input%wavelength)
  !line=11 definition='real(rp) old_vvec(3), new_vvec(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='old_vvec' type='real' size='rp' dimension='3' comment='' default=None
  call json%create_array(json_list1, 'old_vvec')
  do i1 = lbound(input%old_vvec, 1), ubound(input%old_vvec, 1)
    call json%create_real(json_val, input%old_vvec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=11 definition='real(rp) old_vvec(3), new_vvec(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='new_vvec' type='real' size='rp' dimension='3' comment='' default=None
  call json%create_array(json_list1, 'new_vvec')
  do i1 = lbound(input%new_vvec, 1), ubound(input%new_vvec, 1)
    call json%create_real(json_val, input%new_vvec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine crystal_param_struct_to_json
subroutine photon_init_spline_pt_struct_to_json (input, json_root, depth)
  use photon_init_mod, only: photon_init_spline_pt_struct
  implicit none
  type(json_core) :: json
  type (photon_init_spline_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'c0', input%c0)
  call json%add(json_root, 'c1', input%c1)
  call json%add(json_root, 'c2', input%c2)
  call json%add(json_root, 'c3', input%c3)
end subroutine photon_init_spline_pt_struct_to_json
subroutine photon_init_spline_struct_to_json (input, json_root, depth)
  use photon_init_mod, only: photon_init_spline_struct
  implicit none
  type(json_core) :: json
  type (photon_init_spline_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'x_min', input%x_min)
  call json%add(json_root, 'x_max', input%x_max)
  call json%add(json_root, 'del_x', input%del_x)
  if (allocated(input%pt)) then
    !line=30 definition='type (photon_init_spline_pt_struct), allocatable :: pt(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='photon_init_spline_pt_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='photon_init_spline_pt_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call photon_init_spline_pt_struct_to_json(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'spline_type', int(input%spline_type))
end subroutine photon_init_spline_struct_to_json
subroutine photon_coord_struct_to_json (input, json_root, depth)
  use capillary_mod, only: photon_coord_struct
  implicit none
  type(json_core) :: json
  type (photon_coord_struct), pointer, intent(in) :: input
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
  call coord_struct_to_json(input%orb, json_val, depth + 1)
  call json%rename(json_val, 'orb')
  call json%add(json_root, json_val)
  call json%add(json_root, 'track_len', input%track_len)
  call json%add(json_root, 'ix_section', int(input%ix_section))
end subroutine photon_coord_struct_to_json
subroutine photon_track_struct_to_json (input, json_root, depth)
  use capillary_mod, only: photon_track_struct
  implicit none
  type(json_core) :: json
  type (photon_track_struct), pointer, intent(in) :: input
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
  call photon_coord_struct_to_json(input%old, json_val, depth + 1)
  call json%rename(json_val, 'old')
  call json%add(json_root, json_val)
  call photon_coord_struct_to_json(input%now, json_val, depth + 1)
  call json%rename(json_val, 'now')
  call json%add(json_root, json_val)
end subroutine photon_track_struct_to_json
subroutine csr_ele_info_struct_to_json (input, json_root, depth)
  use csr_and_space_charge_mod, only: csr_ele_info_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (csr_ele_info_struct), pointer, intent(in) :: input
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
  if (associated(input%ele)) then
    call ele_struct_to_json(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  call coord_struct_to_json(input%orbit0, json_val, depth + 1)
  call json%rename(json_val, 'orbit0')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%orbit1, json_val, depth + 1)
  call json%rename(json_val, 'orbit1')
  call json%add(json_root, json_val)
  call floor_position_struct_to_json(input%floor0, json_val, depth + 1)
  call json%rename(json_val, 'floor0')
  call json%add(json_root, json_val)
  call floor_position_struct_to_json(input%floor1, json_val, depth + 1)
  call json%rename(json_val, 'floor1')
  call json%add(json_root, json_val)
  call floor_position_struct_to_json(input%ref_floor0, json_val, depth + 1)
  call json%rename(json_val, 'ref_floor0')
  call json%add(json_root, json_val)
  call floor_position_struct_to_json(input%ref_floor1, json_val, depth + 1)
  call json%rename(json_val, 'ref_floor1')
  call json%add(json_root, json_val)
  call spline_struct_to_json(input%spline, json_val, depth + 1)
  call json%rename(json_val, 'spline')
  call json%add(json_root, json_val)
  call json%add(json_root, 'theta_chord', input%theta_chord)
  call json%add(json_root, 'l_chord', input%L_chord)
  call json%add(json_root, 'dl_s', input%dL_s)
end subroutine csr_ele_info_struct_to_json
subroutine csr_bunch_slice_struct_to_json (input, json_root, depth)
  use csr_and_space_charge_mod, only: csr_bunch_slice_struct
  implicit none
  type(json_core) :: json
  type (csr_bunch_slice_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'z0_edge', input%z0_edge)
  call json%add(json_root, 'z1_edge', input%z1_edge)
  call json%add(json_root, 'z_center', input%z_center)
  call json%add(json_root, 'sig_x', input%sig_x)
  call json%add(json_root, 'sig_y', input%sig_y)
  call json%add(json_root, 'charge', input%charge)
  call json%add(json_root, 'dcharge_density_dz', input%dcharge_density_dz)
  call json%add(json_root, 'edge_dcharge_density_dz', input%edge_dcharge_density_dz)
  call json%add(json_root, 'kick_csr', input%kick_csr)
  !line=45 definition='real(rp) :: coef_lsc_plus(0:2,0:2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='coef_lsc_plus' type='real' size='rp' dimension='0:2,0:2' comment='LSC Kick coefs.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%coef_lsc_plus, 2), ubound(input%coef_lsc_plus, 2)
    call json%create_array(json_list1, 'coef_lsc_plus')
    do i1 = lbound(input%coef_lsc_plus, 1), ubound(input%coef_lsc_plus, 1)
      call json%create_real(json_val, input%coef_lsc_plus(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=46 definition='real(rp) :: coef_lsc_minus(0:2,0:2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='coef_lsc_minus' type='real' size='rp' dimension='0:2,0:2' comment='LSC Kick coefs.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%coef_lsc_minus, 2), ubound(input%coef_lsc_minus, 2)
    call json%create_array(json_list1, 'coef_lsc_minus')
    do i1 = lbound(input%coef_lsc_minus, 1), ubound(input%coef_lsc_minus, 1)
      call json%create_real(json_val, input%coef_lsc_minus(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'kick_lsc', input%kick_lsc)
  call json%add(json_root, 'n_particle', input%n_particle)
end subroutine csr_bunch_slice_struct_to_json
subroutine csr_kick1_struct_to_json (input, json_root, depth)
  use csr_and_space_charge_mod, only: csr_kick1_struct
  implicit none
  type(json_core) :: json
  type (csr_kick1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'i_csr', input%I_csr)
  call json%add(json_root, 'i_int_csr', input%I_int_csr)
  call json%add(json_root, 'image_kick_csr', input%image_kick_csr)
  !line=61 definition='real(rp) L_vec(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='L_vec' type='real' size='rp' dimension='3' comment='L vector in global coordinates.' default=None
  call json%create_array(json_list1, 'l_vec')
  do i1 = lbound(input%L_vec, 1), ubound(input%L_vec, 1)
    call json%create_real(json_val, input%L_vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'l', input%L)
  call json%add(json_root, 'dl', input%dL)
  call json%add(json_root, 'dz_particles', input%dz_particles)
  call json%add(json_root, 's_chord_source', input%s_chord_source)
  call json%add(json_root, 'theta_l', input%theta_L)
  call json%add(json_root, 'theta_sl', input%theta_sl)
  call json%add(json_root, 'theta_lk', input%theta_lk)
  call json%add(json_root, 'ix_ele_source', int(input%ix_ele_source))
  call floor_position_struct_to_json(input%floor_s, json_val, depth + 1)
  call json%rename(json_val, 'floor_s')
  call json%add(json_root, json_val)
end subroutine csr_kick1_struct_to_json
subroutine csr_particle_position_struct_to_json (input, json_root, depth)
  use csr_and_space_charge_mod, only: csr_particle_position_struct
  implicit none
  type(json_core) :: json
  type (csr_particle_position_struct), pointer, intent(in) :: input
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
  !line=74 definition='real(rp) :: r(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r' type='real' size='rp' dimension='3' comment='particle position' default=None
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'charge', input%charge)
end subroutine csr_particle_position_struct_to_json
subroutine csr_struct_to_json (input, json_root, depth)
  use csr_and_space_charge_mod, only: csr_struct
  implicit none
  type(json_core) :: json
  type (csr_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'gamma', input%gamma)
  call json%add(json_root, 'gamma2', input%gamma2)
  call json%add(json_root, 'rel_mass', input%rel_mass)
  call json%add(json_root, 'beta', input%beta)
  call json%add(json_root, 'dz_slice', input%dz_slice)
  call json%add(json_root, 'ds_track_step', input%ds_track_step)
  call json%add(json_root, 's_kick', input%s_kick)
  call json%add(json_root, 's_chord_kick', input%s_chord_kick)
  call json%add(json_root, 'y_source', input%y_source)
  call json%add(json_root, 'kick_factor', input%kick_factor)
  call json%add(json_root, 'actual_track_step', input%actual_track_step)
  call json%add(json_root, 'x0_bunch', input%x0_bunch)
  call json%add(json_root, 'y0_bunch', input%y0_bunch)
  call floor_position_struct_to_json(input%floor_k, json_val, depth + 1)
  call json%rename(json_val, 'floor_k')
  call json%add(json_root, json_val)
  call json%add(json_root, 'species', int(input%species))
  call json%add(json_root, 'ix_ele_kick', int(input%ix_ele_kick))
  if (allocated(input%slice)) then
    !line=93 definition='type (csr_bunch_slice_struct), allocatable :: slice(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='csr_bunch_slice_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='slice' type='type' size='csr_bunch_slice_struct' dimension=':' comment='slice(i) refers to the i^th bunch slice.' default=None
    call json%create_array(json_list1, 'slice')
    do i1 = lbound(input%slice, 1), ubound(input%slice, 1)
      call csr_bunch_slice_struct_to_json(input%slice(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%kick1)) then
    !line=94 definition='type (csr_kick1_struct), allocatable :: kick1(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='csr_kick1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='kick1' type='type' size='csr_kick1_struct' dimension=':' comment='kick1(i) referes to the kick between two slices i bins apart.' default=None
    call json%create_array(json_list1, 'kick1')
    do i1 = lbound(input%kick1, 1), ubound(input%kick1, 1)
      call csr_kick1_struct_to_json(input%kick1(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%eleinfo)) then
    !line=95 definition='type (csr_ele_info_struct), allocatable :: eleinfo(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='csr_ele_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='eleinfo' type='type' size='csr_ele_info_struct' dimension=':' comment='Element-by-element information.' default=None
    call json%create_array(json_list1, 'eleinfo')
    do i1 = lbound(input%eleinfo, 1), ubound(input%eleinfo, 1)
      call csr_ele_info_struct_to_json(input%eleinfo(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%kick_ele)) then
    call ele_struct_to_json(input%kick_ele, json_val, depth + 1)
    call json%rename(json_val, 'kick_ele')
    call json%add(json_root, json_val)
  endif
  call mesh3d_struct_to_json(input%mesh3d, json_val, depth + 1)
  call json%rename(json_val, 'mesh3d')
  call json%add(json_root, json_val)
  if (allocated(input%position)) then
    !line=98 definition='type (csr_particle_position_struct), allocatable :: position(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='csr_particle_position_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='position' type='type' size='csr_particle_position_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'position')
    do i1 = lbound(input%position, 1), ubound(input%position, 1)
      call csr_particle_position_struct_to_json(input%position(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine csr_struct_to_json
subroutine mesh3d_struct_to_json (input, json_root, depth)
  use open_spacecharge_mod, only: mesh3d_struct
  implicit none
  type(json_core) :: json
  type (mesh3d_struct), pointer, intent(in) :: input
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
  !line=15 definition='integer :: nlo(3) = [ 1,  1,  1]' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='nlo' type='integer' size=None dimension='3' comment='Lowest  grid index in x, y, z (m) of rho and the quantity being computed (phi or E)' default='[ 1,  1,  1]'
  call json%create_array(json_list1, 'nlo')
  do i1 = lbound(input%nlo, 1), ubound(input%nlo, 1)
    call json%create_integer(json_val, input%nlo(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=16 definition='integer :: nhi(3) = [64, 64, 64]' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='nhi' type='integer' size=None dimension='3' comment='Highest grid index in x, y, z (m) of rho and the quantity being computed (phi or E)' default='[64, 64, 64]'
  call json%create_array(json_list1, 'nhi')
  do i1 = lbound(input%nhi, 1), ubound(input%nhi, 1)
    call json%create_integer(json_val, input%nhi(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=17 definition='integer :: npad(3) = [ 1,  1,  1]' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='npad' type='integer' size=None dimension='3' comment='Array padding for cyclic convolution' default='[ 1,  1,  1]'
  call json%create_array(json_list1, 'npad')
  do i1 = lbound(input%npad, 1), ubound(input%npad, 1)
    call json%create_integer(json_val, input%npad(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=18 definition='real(dp) :: min(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='min' type='real' size='dp' dimension='3' comment='Minimim in each dimension' default=None
  call json%create_array(json_list1, 'min')
  do i1 = lbound(input%min, 1), ubound(input%min, 1)
    call json%create_real(json_val, input%min(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=19 definition='real(dp) :: max(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='max' type='real' size='dp' dimension='3' comment='Maximum in each dimension' default=None
  call json%create_array(json_list1, 'max')
  do i1 = lbound(input%max, 1), ubound(input%max, 1)
    call json%create_real(json_val, input%max(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=20 definition='real(dp) :: delta(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='delta' type='real' size='dp' dimension='3' comment='Grid spacing' default=None
  call json%create_array(json_list1, 'delta')
  do i1 = lbound(input%delta, 1), ubound(input%delta, 1)
    call json%create_real(json_val, input%delta(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'gamma', input%gamma)
  call json%add(json_root, 'charge', input%charge)
  if (allocated(input%rho)) then
    !line=23 definition='real(dp), allocatable, dimension(:,:,:) :: rho' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=':,:,:', external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='rho' type='real' size='dp' dimension=':,:,:' comment='Charge density grid' default=None
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%rho, 3), ubound(input%rho, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%rho, 2), ubound(input%rho, 2)
        call json%create_array(json_list1, 'rho')
        do i1 = lbound(input%rho, 1), ubound(input%rho, 1)
          call json%create_real(json_val, input%rho(i1, i2, i3), '')
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
  if (allocated(input%phi)) then
    !line=24 definition='real(dp), allocatable, dimension(:,:,:) :: phi' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=':,:,:', external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='phi' type='real' size='dp' dimension=':,:,:' comment='electric potential grid' default=None
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%phi, 3), ubound(input%phi, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%phi, 2), ubound(input%phi, 2)
        call json%create_array(json_list1, 'phi')
        do i1 = lbound(input%phi, 1), ubound(input%phi, 1)
          call json%create_real(json_val, input%phi(i1, i2, i3), '')
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
  if (allocated(input%efield)) then
    !line=25 definition='real(dp), allocatable, dimension(:,:,:,:) :: efield' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=':,:,:,:', external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='efield' type='real' size='dp' dimension=':,:,:,:' comment='electric field grid' default=None
    call json%create_array(json_list4, 'dim-4')
    do i4 = lbound(input%efield, 4), ubound(input%efield, 4)
      call json%create_array(json_list3, 'dim-3')
      do i3 = lbound(input%efield, 3), ubound(input%efield, 3)
        call json%create_array(json_list2, 'dim-2')
        do i2 = lbound(input%efield, 2), ubound(input%efield, 2)
          call json%create_array(json_list1, 'efield')
          do i1 = lbound(input%efield, 1), ubound(input%efield, 1)
            call json%create_real(json_val, input%efield(i1, i2, i3, i4), '')
            call json%add(json_list1, json_val)
          enddo
          call json%add(json_list2, json_list1)
          nullify(json_list1)
        enddo
        call json%add(json_list3, json_list2)
        nullify(json_list2)
      enddo
      call json%add(json_list4, json_list3)
      nullify(json_list3)
    enddo
    call json%add(json_root, json_list4)
    nullify(json_list4)
  endif
  if (allocated(input%bfield)) then
    !line=26 definition='real(dp), allocatable, dimension(:,:,:,:) :: bfield' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=':,:,:,:', external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='dp', static=False, target=False, value=False, volatile=False, attributes=()) name='bfield' type='real' size='dp' dimension=':,:,:,:' comment='magnetic field grid' default=None
    call json%create_array(json_list4, 'dim-4')
    do i4 = lbound(input%bfield, 4), ubound(input%bfield, 4)
      call json%create_array(json_list3, 'dim-3')
      do i3 = lbound(input%bfield, 3), ubound(input%bfield, 3)
        call json%create_array(json_list2, 'dim-2')
        do i2 = lbound(input%bfield, 2), ubound(input%bfield, 2)
          call json%create_array(json_list1, 'bfield')
          do i1 = lbound(input%bfield, 1), ubound(input%bfield, 1)
            call json%create_real(json_val, input%bfield(i1, i2, i3, i4), '')
            call json%add(json_list1, json_val)
          enddo
          call json%add(json_list2, json_list1)
          nullify(json_list1)
        enddo
        call json%add(json_list3, json_list2)
        nullify(json_list2)
      enddo
      call json%add(json_list4, json_list3)
      nullify(json_list3)
    enddo
    call json%add(json_root, json_list4)
    nullify(json_list4)
  endif
end subroutine mesh3d_struct_to_json
subroutine seq_ele_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: seq_ele_struct
  implicit none
  type(json_core) :: json
  type (seq_ele_struct), pointer, intent(in) :: input
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
  if (allocated(input%actual_arg)) then
    !line=16 definition='character(40), allocatable :: actual_arg(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='actual_arg' type='character' size='40' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'actual_arg')
    do i1 = lbound(input%actual_arg, 1), ubound(input%actual_arg, 1)
      call json%create_string(json_val, trim(input%actual_arg(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'tag', trim(input%tag))
  call json%add(json_root, 'slice_start', trim(input%slice_start))
  call json%add(json_root, 'slice_end', trim(input%slice_end))
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_arg', int(input%ix_arg))
  call json%add(json_root, 'rep_count', int(input%rep_count))
  call json%add(json_root, 'ele_order_reflect', input%ele_order_reflect)
  call json%add(json_root, 'ele_orientation', int(input%ele_orientation))
end subroutine seq_ele_struct_to_json
subroutine base_line_ele_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: base_line_ele_struct
  implicit none
  type(json_core) :: json
  type (base_line_ele_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'tag', trim(input%tag))
  call json%add(json_root, 'ix_multi', int(input%ix_multi))
  call json%add(json_root, 'orientation', int(input%orientation))
  call json%add(json_root, 'ix_ele_in_in_lat', int(input%ix_ele_in_in_lat))
  call json%add(json_root, 'ele_order_reflect', input%ele_order_reflect)
end subroutine base_line_ele_struct_to_json
subroutine seq_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: seq_struct
  implicit none
  type(json_core) :: json
  type (seq_struct), pointer, intent(in) :: input
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
  if (allocated(input%ele)) then
    !line=40 definition='type (seq_ele_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='seq_ele_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='seq_ele_struct' dimension=':' comment='Elements in the sequence' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call seq_ele_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%dummy_arg)) then
    !line=41 definition='character(40), allocatable :: dummy_arg(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='dummy_arg' type='character' size='40' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'dummy_arg')
    do i1 = lbound(input%dummy_arg, 1), ubound(input%dummy_arg, 1)
      call json%create_string(json_val, trim(input%dummy_arg(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%corresponding_actual_arg)) then
    !line=42 definition='character(40), allocatable :: corresponding_actual_arg(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='corresponding_actual_arg' type='character' size='40' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'corresponding_actual_arg')
    do i1 = lbound(input%corresponding_actual_arg, 1), ubound(input%corresponding_actual_arg, 1)
      call json%create_string(json_val, trim(input%corresponding_actual_arg(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'ix_list', int(input%ix_list))
  call json%add(json_root, 'list_upcount', int(input%list_upcount))
  call json%add(json_root, 'index', int(input%index))
  call json%add(json_root, 'file_name', trim(input%file_name))
  call json%add(json_root, 'ix_file_line', int(input%ix_file_line))
  call json%add(json_root, 'multipass', input%multipass)
  call json%add(json_root, 'ptc_layout', input%ptc_layout)
  call json%add(json_root, 'active', input%active)
end subroutine seq_struct_to_json
subroutine stack_file_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: stack_file_struct
  implicit none
  type(json_core) :: json
  type (stack_file_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'input_line1_saved', trim(input%input_line1_saved))
  call json%add(json_root, 'input_line2_saved', trim(input%input_line2_saved))
  call json%add(json_root, 'rest_of_line_saved', trim(input%rest_of_line_saved))
  call json%add(json_root, 'parse_line_saved', trim(input%parse_line_saved))
  call json%add(json_root, 'next_chunk_saved', trim(input%next_chunk_saved))
  call json%add(json_root, 'last_char_in_parse_line_saved', trim(input%last_char_in_parse_line_saved))
  call json%add(json_root, 'ios_next_chunk_saved', int(input%ios_next_chunk_saved))
  call json%add(json_root, 'ios_this_chunk_saved', int(input%ios_this_chunk_saved))
  call json%add(json_root, 'i_line', int(input%i_line))
  call json%add(json_root, 'f_unit', int(input%f_unit))
  call json%add(json_root, 'inline_call_active', input%inline_call_active)
end subroutine stack_file_struct_to_json
subroutine parser_controller_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: parser_controller_struct
  implicit none
  type(json_core) :: json
  type (parser_controller_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'attrib_name', trim(input%attrib_name))
  if (allocated(input%stack)) then
    !line=81 definition='type (expression_atom_struct), allocatable :: stack(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='expression_atom_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='stack' type='type' size='expression_atom_struct' dimension=':' comment='Arithmetic expression stack' default=None
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call expression_atom_struct_to_json(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_knot)) then
    !line=82 definition='real(rp), allocatable :: y_knot(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y_knot' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_knot')
    do i1 = lbound(input%y_knot, 1), ubound(input%y_knot, 1)
      call json%create_real(json_val, input%y_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_stk', int(input%n_stk))
end subroutine parser_controller_struct_to_json
subroutine parser_ele_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: parser_ele_struct
  implicit none
  type(json_core) :: json
  type (parser_ele_struct), pointer, intent(in) :: input
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
  if (allocated(input%control)) then
    !line=87 definition='type (parser_controller_struct), allocatable :: control(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='parser_controller_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='control' type='type' size='parser_controller_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'control')
    do i1 = lbound(input%control, 1), ubound(input%control, 1)
      call parser_controller_struct_to_json(input%control(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%field_overlaps)) then
    !line=88 definition='character(40), allocatable :: field_overlaps(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='field_overlaps' type='character' size='40' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'field_overlaps')
    do i1 = lbound(input%field_overlaps, 1), ubound(input%field_overlaps, 1)
      call json%create_string(json_val, trim(input%field_overlaps(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ref_name', trim(input%ref_name))
  call json%add(json_root, 'ix_super_ref_multipass', int(input%ix_super_ref_multipass))
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  if (allocated(input%names1)) then
    !line=92 definition='character(40), allocatable :: names1(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='names1' type='character' size='40' dimension=':' comment='Currently just used by feedback element.' default=None
    call json%create_array(json_list1, 'names1')
    do i1 = lbound(input%names1, 1), ubound(input%names1, 1)
      call json%create_string(json_val, trim(input%names1(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%names2)) then
    !line=93 definition='character(40), allocatable :: names2(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='40', static=False, target=False, value=False, volatile=False, attributes=()) name='names2' type='character' size='40' dimension=':' comment='Currently just used by feedback element.' default=None
    call json%create_array(json_list1, 'names2')
    do i1 = lbound(input%names2, 1), ubound(input%names2, 1)
      call json%create_string(json_val, trim(input%names2(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'lat_file', trim(input%lat_file))
  call json%add(json_root, 'offset', input%offset)
  call json%add(json_root, 'ix_line_in_file', int(input%ix_line_in_file))
  call json%add(json_root, 'ix_count', int(input%ix_count))
  call json%add(json_root, 'ele_pt', int(input%ele_pt))
  call json%add(json_root, 'ref_pt', int(input%ref_pt))
  call json%add(json_root, 'index', int(input%index))
  call json%add(json_root, 'superposition_command_here', input%superposition_command_here)
  call json%add(json_root, 'superposition_has_been_set', input%superposition_has_been_set)
  call json%add(json_root, 'wrap_superimpose', input%wrap_superimpose)
  call json%add(json_root, 'create_jumbo_slave', input%create_jumbo_slave)
  call json%add(json_root, 'is_range', input%is_range)
  call json%add(json_root, 'default_attrib', trim(input%default_attrib))
end subroutine parser_ele_struct_to_json
subroutine parser_lat_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: parser_lat_struct
  implicit none
  type(json_core) :: json
  type (parser_lat_struct), pointer, intent(in) :: input
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
    !line=109 definition='type (parser_ele_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='parser_ele_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='parser_ele_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call parser_ele_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine parser_lat_struct_to_json
subroutine bp_const_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: bp_const_struct
  implicit none
  type(json_core) :: json
  type (bp_const_struct), pointer, intent(in) :: input
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
end subroutine bp_const_struct_to_json
subroutine bp_common_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: bp_common_struct
  implicit none
  type(json_core) :: json
  type (bp_common_struct), pointer, intent(in) :: input
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
  !line=128 definition='type (stack_file_struct) :: file(0:f_maxx) = stack_file_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='stack_file_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='file' type='type' size='stack_file_struct' dimension='0:f_maxx' comment='' default='stack_file_struct()'
  call json%create_array(json_list1, 'file')
  do i1 = lbound(input%file, 1), ubound(input%file, 1)
    call stack_file_struct_to_json(input%file(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%current_file)) then
    call stack_file_struct_to_json(input%current_file, json_val, depth + 1)
    call json%rename(json_val, 'current_file')
    call json%add(json_root, json_val)
  endif
  if (associated(input%old_lat)) then
    call lat_struct_to_json(input%old_lat, json_val, depth + 1)
    call json%rename(json_val, 'old_lat')
    call json%add(json_root, json_val)
  endif
  call extra_parsing_info_struct_to_json(input%extra, json_val, depth + 1)
  call json%rename(json_val, 'extra')
  call json%add(json_root, json_val)
  call json%add(json_root, 'i_file_level', int(input%i_file_level))
  call json%add(json_root, 'num_lat_files', int(input%num_lat_files))
  call json%add(json_root, 'i_const_tot', int(input%i_const_tot))
  call json%add(json_root, 'i_const_init', int(input%i_const_init))
  call json%add(json_root, 'ios_next_chunk', int(input%ios_next_chunk))
  call json%add(json_root, 'ios_this_chunk', int(input%ios_this_chunk))
  if (allocated(input%lat_file_names)) then
    !line=137 definition='character(400), allocatable :: lat_file_names(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='400', static=False, target=False, value=False, volatile=False, attributes=()) name='lat_file_names' type='character' size='400' dimension=':' comment='List of all files used to create lat' default=None
    call json%create_array(json_list1, 'lat_file_names')
    do i1 = lbound(input%lat_file_names, 1), ubound(input%lat_file_names, 1)
      call json%create_string(json_val, trim(input%lat_file_names(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'line1_file_name', trim(input%line1_file_name))
  call json%add(json_root, 'line2_file_name', trim(input%line2_file_name))
  call json%add(json_root, 'parse_line', trim(input%parse_line))
  call json%add(json_root, 'input_line1', trim(input%input_line1))
  call json%add(json_root, 'input_line2', trim(input%input_line2))
  call json%add(json_root, 'rest_of_line', trim(input%rest_of_line))
  call json%add(json_root, 'next_chunk', trim(input%next_chunk))
  call json%add(json_root, 'last_char_in_parse_line', trim(input%last_char_in_parse_line))
  call json%add(json_root, 'parser_name', trim(input%parser_name))
  call json%add(json_root, 'last_word', trim(input%last_word))
  call json%add(json_root, 'bmad_parser_calling', input%bmad_parser_calling)
  call json%add(json_root, 'fatal_error_flag', input%fatal_error_flag)
  call json%add(json_root, 'error_flag', input%error_flag)
  call json%add(json_root, 'input_line_meaningful', input%input_line_meaningful)
  call json%add(json_root, 'do_superimpose', input%do_superimpose)
  call json%add(json_root, 'write_digested', input%write_digested)
  call json%add(json_root, 'write_digested2', input%write_digested2)
  call json%add(json_root, 'always_parse', input%always_parse)
  call json%add(json_root, 'input_from_file', input%input_from_file)
  call json%add(json_root, 'inline_call_active', input%inline_call_active)
  call json%add(json_root, 'print_err', input%print_err)
  call json%add(json_root, 'undefined_vars_evaluate_to_zero', input%undefined_vars_evaluate_to_zero)
  call json%add(json_root, 'use_local_lat_file', input%use_local_lat_file)
  call json%add(json_root, 'used_line_set_by_calling_routine', input%used_line_set_by_calling_routine)
  call json%add(json_root, 'calc_reference_orbit', input%calc_reference_orbit)
  call json%add(json_root, 'detected_expand_lattice_cmd', input%detected_expand_lattice_cmd)
  call json%add(json_root, 'time0', input%time0)
  call json%add(json_root, 'time1', input%time1)
  call json%add(json_root, 'time2', input%time2)
  call json%add(json_root, 'time3', input%time3)
end subroutine bp_common_struct_to_json
subroutine bp_common2_struct_to_json (input, json_root, depth)
  use bmad_parser_struct, only: bp_common2_struct
  implicit none
  type(json_core) :: json
  type (bp_common2_struct), pointer, intent(in) :: input
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
  if (allocated(input%const)) then
    !line=177 definition='type (bp_const_struct), allocatable :: const(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='bp_const_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='const' type='type' size='bp_const_struct' dimension=':' comment='Constant name' default=None
    call json%create_array(json_list1, 'const')
    do i1 = lbound(input%const, 1), ubound(input%const, 1)
      call bp_const_struct_to_json(input%const(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine bp_common2_struct_to_json
subroutine summation_rdt_struct_to_json (input, json_root, depth)
  use srdt_mod, only: summation_rdt_struct
  implicit none
  type(json_core) :: json
  type (summation_rdt_struct), pointer, intent(in) :: input
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
  call complex_to_json(input%h11001, json_list1, depth+1)
  call json%rename(json_list1, 'h11001')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h00111, json_list1, depth+1)
  call json%rename(json_list1, 'h00111')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h20001, json_list1, depth+1)
  call json%rename(json_list1, 'h20001')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h00201, json_list1, depth+1)
  call json%rename(json_list1, 'h00201')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h10002, json_list1, depth+1)
  call json%rename(json_list1, 'h10002')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h21000, json_list1, depth+1)
  call json%rename(json_list1, 'h21000')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h30000, json_list1, depth+1)
  call json%rename(json_list1, 'h30000')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h10110, json_list1, depth+1)
  call json%rename(json_list1, 'h10110')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h10020, json_list1, depth+1)
  call json%rename(json_list1, 'h10020')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h10200, json_list1, depth+1)
  call json%rename(json_list1, 'h10200')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h31000, json_list1, depth+1)
  call json%rename(json_list1, 'h31000')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h40000, json_list1, depth+1)
  call json%rename(json_list1, 'h40000')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h20110, json_list1, depth+1)
  call json%rename(json_list1, 'h20110')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h11200, json_list1, depth+1)
  call json%rename(json_list1, 'h11200')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h20020, json_list1, depth+1)
  call json%rename(json_list1, 'h20020')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h20200, json_list1, depth+1)
  call json%rename(json_list1, 'h20200')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h00310, json_list1, depth+1)
  call json%rename(json_list1, 'h00310')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h00400, json_list1, depth+1)
  call json%rename(json_list1, 'h00400')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h22000, json_list1, depth+1)
  call json%rename(json_list1, 'h22000')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h00220, json_list1, depth+1)
  call json%rename(json_list1, 'h00220')
  call json%add(json_root, json_list1)
  call complex_to_json(input%h11110, json_list1, depth+1)
  call json%rename(json_list1, 'h11110')
  call json%add(json_root, json_list1)
end subroutine summation_rdt_struct_to_json
subroutine sliced_eles_struct_to_json (input, json_root, depth)
  use srdt_mod, only: sliced_eles_struct
  implicit none
  type(json_core) :: json
  type (sliced_eles_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix', int(input%ix))
  call json%add(json_root, 'k1l', input%k1l)
  call json%add(json_root, 'k2l', input%k2l)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'l', input%l)
  call json%add(json_root, 'eta_a', input%eta_a)
  call json%add(json_root, 'beta_a', input%beta_a)
  call json%add(json_root, 'beta_b', input%beta_b)
  call json%add(json_root, 'phi_a', input%phi_a)
  call json%add(json_root, 'phi_b', input%phi_b)
  call json%add(json_root, 'good_k2', input%good_k2)
  call summation_rdt_struct_to_json(input%srdt, json_val, depth + 1)
  call json%rename(json_val, 'srdt')
  call json%add(json_root, json_val)
  call complex_to_json(input%ea, json_list1, depth+1)
  call json%rename(json_list1, 'ea')
  call json%add(json_root, json_list1)
  call complex_to_json(input%eb, json_list1, depth+1)
  call json%rename(json_list1, 'eb')
  call json%add(json_root, json_list1)
  call complex_to_json(input%e2a, json_list1, depth+1)
  call json%rename(json_list1, 'e2a')
  call json%add(json_root, json_list1)
  call complex_to_json(input%e2b, json_list1, depth+1)
  call json%rename(json_list1, 'e2b')
  call json%add(json_root, json_list1)
  call complex_to_json(input%e3a, json_list1, depth+1)
  call json%rename(json_list1, 'e3a')
  call json%add(json_root, json_list1)
end subroutine sliced_eles_struct_to_json
subroutine fringe_field_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: fringe_field_info_struct
  implicit none
  type(json_core) :: json
  type (fringe_field_info_struct), pointer, intent(in) :: input
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
  if (associated(input%hard_ele)) then
    call ele_struct_to_json(input%hard_ele, json_val, depth + 1)
    call json%rename(json_val, 'hard_ele')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 's_edge_hard', input%s_edge_hard)
  call json%add(json_root, 'ds_edge', input%ds_edge)
  call json%add(json_root, 'particle_at', int(input%particle_at))
  if (associated(input%hard_location)) then
    call json%add(json_root, 'hard_location', int(input%hard_location))
  endif
  if (allocated(input%location)) then
    !line=41 definition='integer, allocatable :: location(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='location' type='integer' size=None dimension=':' comment='Particle location in an element. entrance_end$, inside$, or exit_end$' default=None
    call json%create_array(json_list1, 'location')
    do i1 = lbound(input%location, 1), ubound(input%location, 1)
      call json%create_integer(json_val, input%location(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'has_fringe', input%has_fringe)
end subroutine fringe_field_info_struct_to_json
subroutine expression_atom_struct_to_json (input, json_root, depth)
  use bmad_struct, only: expression_atom_struct
  implicit none
  type(json_core) :: json
  type (expression_atom_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'value', input%value)
end subroutine expression_atom_struct_to_json
subroutine twiss_struct_to_json (input, json_root, depth)
  use bmad_struct, only: twiss_struct
  implicit none
  type(json_core) :: json
  type (twiss_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'beta', input%beta)
  call json%add(json_root, 'alpha', input%alpha)
  call json%add(json_root, 'gamma', input%gamma)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'eta', input%eta)
  call json%add(json_root, 'etap', input%etap)
  call json%add(json_root, 'deta_ds', input%deta_ds)
  call json%add(json_root, 'sigma', input%sigma)
  call json%add(json_root, 'sigma_p', input%sigma_p)
  call json%add(json_root, 'emit', input%emit)
  call json%add(json_root, 'norm_emit', input%norm_emit)
end subroutine twiss_struct_to_json
subroutine interval1_coef_struct_to_json (input, json_root, depth)
  use bmad_struct, only: interval1_coef_struct
  implicit none
  type(json_core) :: json
  type (interval1_coef_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'c0', input%c0)
  call json%add(json_root, 'c1', input%c1)
  call json%add(json_root, 'n_exp', input%n_exp)
end subroutine interval1_coef_struct_to_json
subroutine photon_reflect_table_struct_to_json (input, json_root, depth)
  use bmad_struct, only: photon_reflect_table_struct
  implicit none
  type(json_core) :: json
  type (photon_reflect_table_struct), pointer, intent(in) :: input
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
  if (allocated(input%angle)) then
    !line=205 definition='real(rp), allocatable :: angle(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='angle' type='real' size='rp' dimension=':' comment='Vector of angle values for %p_reflect' default=None
    call json%create_array(json_list1, 'angle')
    do i1 = lbound(input%angle, 1), ubound(input%angle, 1)
      call json%create_real(json_val, input%angle(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%energy)) then
    !line=206 definition='real(rp), allocatable :: energy(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='energy' type='real' size='rp' dimension=':' comment='Vector of energy values for %p_reflect' default=None
    call json%create_array(json_list1, 'energy')
    do i1 = lbound(input%energy, 1), ubound(input%energy, 1)
      call json%create_real(json_val, input%energy(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%int1)) then
    !line=207 definition='type (interval1_coef_struct), allocatable :: int1(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='interval1_coef_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='int1' type='type' size='interval1_coef_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'int1')
    do i1 = lbound(input%int1, 1), ubound(input%int1, 1)
      call interval1_coef_struct_to_json(input%int1(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%p_reflect)) then
    !line=208 definition='real(rp), allocatable :: p_reflect(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='p_reflect' type='real' size='rp' dimension=':,:' comment='(angle, ev) probability. Log used for smooth surface reflection' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%p_reflect, 2), ubound(input%p_reflect, 2)
      call json%create_array(json_list1, 'p_reflect')
      do i1 = lbound(input%p_reflect, 1), ubound(input%p_reflect, 1)
        call json%create_real(json_val, input%p_reflect(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'max_energy', input%max_energy)
  if (allocated(input%p_reflect_scratch)) then
    !line=210 definition='real(rp), allocatable :: p_reflect_scratch(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='p_reflect_scratch' type='real' size='rp' dimension=':' comment='Scratch space' default=None
    call json%create_array(json_list1, 'p_reflect_scratch')
    do i1 = lbound(input%p_reflect_scratch, 1), ubound(input%p_reflect_scratch, 1)
      call json%create_real(json_val, input%p_reflect_scratch(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%bragg_angle)) then
    !line=211 definition='real(rp), allocatable :: bragg_angle(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='bragg_angle' type='real' size='rp' dimension=':' comment='Bragg angle at energy values.' default=None
    call json%create_array(json_list1, 'bragg_angle')
    do i1 = lbound(input%bragg_angle, 1), ubound(input%bragg_angle, 1)
      call json%create_real(json_val, input%bragg_angle(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine photon_reflect_table_struct_to_json
subroutine photon_reflect_surface_struct_to_json (input, json_root, depth)
  use bmad_struct, only: photon_reflect_surface_struct
  implicit none
  type(json_core) :: json
  type (photon_reflect_surface_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'reflectivity_file', trim(input%reflectivity_file))
  if (allocated(input%table)) then
    !line=222 definition='type (photon_reflect_table_struct), allocatable :: table(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='photon_reflect_table_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='table' type='type' size='photon_reflect_table_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'table')
    do i1 = lbound(input%table, 1), ubound(input%table, 1)
      call photon_reflect_table_struct_to_json(input%table(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'surface_roughness_rms', input%surface_roughness_rms)
  call json%add(json_root, 'roughness_correlation_len', input%roughness_correlation_len)
  call json%add(json_root, 'ix_surface', int(input%ix_surface))
end subroutine photon_reflect_surface_struct_to_json
subroutine pauli_struct_to_json (input, json_root, depth)
  use bmad_struct, only: pauli_struct
  implicit none
  type(json_core) :: json
  type (pauli_struct), pointer, intent(in) :: input
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
  !line=260 definition='complex(rp) sigma(2,2)' type_info=TypeInformation(type='complex', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='sigma' type='complex' size='rp' dimension='2,2' comment='' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%sigma, 2), ubound(input%sigma, 2)
    call json%create_array(json_list1, 'sigma')
    do i1 = lbound(input%sigma, 1), ubound(input%sigma, 1)
      call complex_to_json(input%sigma(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine pauli_struct_to_json
subroutine spin_eigen_struct_to_json (input, json_root, depth)
  use bmad_struct, only: spin_eigen_struct
  implicit none
  type(json_core) :: json
  type (spin_eigen_struct), pointer, intent(in) :: input
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
  !line=270 definition='complex(rp) :: vec(8) = 0' type_info=TypeInformation(type='complex', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec' type='complex' size='rp' dimension='8' comment='' default='0'
  call json%create_array(json_list1, 'vec')
  do i1 = lbound(input%vec, 1), ubound(input%vec, 1)
    call complex_to_json(input%vec(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call complex_to_json(input%val, json_list1, depth+1)
  call json%rename(json_list1, 'val')
  call json%add(json_root, json_list1)
end subroutine spin_eigen_struct_to_json
subroutine spin_axis_struct_to_json (input, json_root, depth)
  use bmad_struct, only: spin_axis_struct
  implicit none
  type(json_core) :: json
  type (spin_axis_struct), pointer, intent(in) :: input
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
  !line=275 definition='real(rp) :: l(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='l' type='real' size='rp' dimension='3' comment='Transverse axis.' default='0'
  call json%create_array(json_list1, 'l')
  do i1 = lbound(input%l, 1), ubound(input%l, 1)
    call json%create_real(json_val, input%l(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=276 definition='real(rp) :: n0(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='n0' type='real' size='rp' dimension='3' comment='Invariant spin axis on closed orbit.' default='0'
  call json%create_array(json_list1, 'n0')
  do i1 = lbound(input%n0, 1), ubound(input%n0, 1)
    call json%create_real(json_val, input%n0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=277 definition='real(rp) :: m(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='m' type='real' size='rp' dimension='3' comment='Transverse axis.' default='0'
  call json%create_array(json_list1, 'm')
  do i1 = lbound(input%m, 1), ubound(input%m, 1)
    call json%create_real(json_val, input%m(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine spin_axis_struct_to_json
subroutine spin_matching_struct_to_json (input, json_root, depth)
  use bmad_struct, only: spin_matching_struct
  implicit none
  type(json_core) :: json
  type (spin_matching_struct), pointer, intent(in) :: input
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
  call spin_axis_struct_to_json(input%axis, json_val, depth + 1)
  call json%rename(json_val, 'axis')
  call json%add(json_root, json_val)
  !line=282 definition='type (spin_eigen_struct) :: eigen(8) = spin_eigen_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spin_eigen_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='eigen' type='type' size='spin_eigen_struct' dimension='8' comment='' default='spin_eigen_struct()'
  call json%create_array(json_list1, 'eigen')
  do i1 = lbound(input%eigen, 1), ubound(input%eigen, 1)
    call spin_eigen_struct_to_json(input%eigen(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=283 definition='real(rp) :: dn_dpz(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dn_dpz' type='real' size='rp' dimension='3' comment='Invariant spin derivative' default='0'
  call json%create_array(json_list1, 'dn_dpz')
  do i1 = lbound(input%dn_dpz, 1), ubound(input%dn_dpz, 1)
    call json%create_real(json_val, input%dn_dpz(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=284 definition='real(rp) :: alpha(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='alpha' type='real' size='rp' dimension='6' comment='Alpha vector' default='0'
  call json%create_array(json_list1, 'alpha')
  do i1 = lbound(input%alpha, 1), ubound(input%alpha, 1)
    call json%create_real(json_val, input%alpha(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=285 definition='real(rp) :: beta(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='beta' type='real' size='rp' dimension='6' comment='Beta vector' default='0'
  call json%create_array(json_list1, 'beta')
  do i1 = lbound(input%beta, 1), ubound(input%beta, 1)
    call json%create_real(json_val, input%beta(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=286 definition='real(rp) :: orb0(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orb0' type='real' size='rp' dimension='6' comment='Closed orbit' default='0'
  call json%create_array(json_list1, 'orb0')
  do i1 = lbound(input%orb0, 1), ubound(input%orb0, 1)
    call json%create_real(json_val, input%orb0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=287 definition='real(rp) :: M_1turn(8,8) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='M_1turn' type='real' size='rp' dimension='8,8' comment='1-turn matrix' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%M_1turn, 2), ubound(input%M_1turn, 2)
    call json%create_array(json_list1, 'm_1turn')
    do i1 = lbound(input%M_1turn, 1), ubound(input%M_1turn, 1)
      call json%create_real(json_val, input%M_1turn(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=288 definition='real(rp) :: M_ele(8,8) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='M_ele' type='real' size='rp' dimension='8,8' comment='Transfer matrix through element.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%M_ele, 2), ubound(input%M_ele, 2)
    call json%create_array(json_list1, 'm_ele')
    do i1 = lbound(input%M_ele, 1), ubound(input%M_ele, 1)
      call json%create_real(json_val, input%M_ele(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=289 definition='real(rp) :: sq_ele(0:3) = 0, sq_1turn(0:3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='sq_ele' type='real' size='rp' dimension='0:3' comment='' default='0'
  call json%create_array(json_list1, 'sq_ele')
  do i1 = lbound(input%sq_ele, 1), ubound(input%sq_ele, 1)
    call json%create_real(json_val, input%sq_ele(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=289 definition='real(rp) :: sq_ele(0:3) = 0, sq_1turn(0:3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='sq_1turn' type='real' size='rp' dimension='0:3' comment='' default='0'
  call json%create_array(json_list1, 'sq_1turn')
  do i1 = lbound(input%sq_1turn, 1), ubound(input%sq_1turn, 1)
    call json%create_real(json_val, input%sq_1turn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'valid', input%valid)
end subroutine spin_matching_struct_to_json
subroutine spin_polar_struct_to_json (input, json_root, depth)
  use bmad_struct, only: spin_polar_struct
  implicit none
  type(json_core) :: json
  type (spin_polar_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'polarization', input%polarization)
  call json%add(json_root, 'theta', input%theta)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'xi', input%xi)
end subroutine spin_polar_struct_to_json
subroutine spin_orbit_map1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: spin_orbit_map1_struct
  implicit none
  type(json_core) :: json
  type (spin_orbit_map1_struct), pointer, intent(in) :: input
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
  !line=306 definition='real(rp) :: orb_mat(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orb_mat' type='real' size='rp' dimension='6,6' comment='Orbital matrix' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%orb_mat, 2), ubound(input%orb_mat, 2)
    call json%create_array(json_list1, 'orb_mat')
    do i1 = lbound(input%orb_mat, 1), ubound(input%orb_mat, 1)
      call json%create_real(json_val, input%orb_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=307 definition='real(rp) :: vec0(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec0' type='real' size='rp' dimension='6' comment='Orbital 0th order map: r_out = mat6 * r_in + vec0' default='0'
  call json%create_array(json_list1, 'vec0')
  do i1 = lbound(input%vec0, 1), ubound(input%vec0, 1)
    call json%create_real(json_val, input%vec0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=308 definition='real(rp) :: spin_q(0:3,0:6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_q' type='real' size='rp' dimension='0:3,0:6' comment='0th and 1st order quaternion spin map' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%spin_q, 2), ubound(input%spin_q, 2)
    call json%create_array(json_list1, 'spin_q')
    do i1 = lbound(input%spin_q, 1), ubound(input%spin_q, 1)
      call json%create_real(json_val, input%spin_q(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine spin_orbit_map1_struct_to_json
subroutine linear_isf1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: linear_isf1_struct
  implicit none
  type(json_core) :: json
  type (linear_isf1_struct), pointer, intent(in) :: input
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
  !line=314 definition='real(rp) :: orb0(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orb0' type='real' size='rp' dimension='6' comment='Closed orbit.' default='0'
  call json%create_array(json_list1, 'orb0')
  do i1 = lbound(input%orb0, 1), ubound(input%orb0, 1)
    call json%create_real(json_val, input%orb0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=315 definition='real(rp) :: isf(0:3, 0:6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='isf' type='real' size='rp' dimension='0:3, 0:6' comment='Linear ISF map at a given point.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%isf, 2), ubound(input%isf, 2)
    call json%create_array(json_list1, 'isf')
    do i1 = lbound(input%isf, 1), ubound(input%isf, 1)
      call json%create_real(json_val, input%isf(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 's', input%s)
end subroutine linear_isf1_struct_to_json
subroutine linear_ele_isf_struct_to_json (input, json_root, depth)
  use bmad_struct, only: linear_ele_isf_struct
  implicit none
  type(json_core) :: json
  type (linear_ele_isf_struct), pointer, intent(in) :: input
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
  if (allocated(input%node)) then
    !line=323 definition='type (linear_isf1_struct), allocatable :: node(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='linear_isf1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='node' type='type' size='linear_isf1_struct' dimension=':' comment='Array per PTC integration node.' default=None
    call json%create_array(json_list1, 'node')
    do i1 = lbound(input%node, 1), ubound(input%node, 1)
      call linear_isf1_struct_to_json(input%node(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine linear_ele_isf_struct_to_json
subroutine wall3d_vertex_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wall3d_vertex_struct
  implicit none
  type(json_core) :: json
  type (wall3d_vertex_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'radius_x', input%radius_x)
  call json%add(json_root, 'radius_y', input%radius_y)
  call json%add(json_root, 'tilt', input%tilt)
  call json%add(json_root, 'angle', input%angle)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'type', int(input%type))
end subroutine wall3d_vertex_struct_to_json
subroutine wall3d_section_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wall3d_section_struct
  implicit none
  type(json_core) :: json
  type (wall3d_section_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'material', trim(input%material))
  if (allocated(input%v)) then
    !line=420 definition='type (wall3d_vertex_struct), allocatable :: v(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='wall3d_vertex_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='v' type='type' size='wall3d_vertex_struct' dimension=':' comment='Array of vertices. Always stored relative.' default=None
    call json%create_array(json_list1, 'v')
    do i1 = lbound(input%v, 1), ubound(input%v, 1)
      call wall3d_vertex_struct_to_json(input%v(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%surface)) then
    call photon_reflect_surface_struct_to_json(input%surface, json_val, depth + 1)
    call json%rename(json_val, 'surface')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'n_vertex_input', int(input%n_vertex_input))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'vertices_state', int(input%vertices_state))
  call json%add(json_root, 'patch_in_region', input%patch_in_region)
  call json%add(json_root, 'thickness', input%thickness)
  call json%add(json_root, 's', input%s)
  !line=430 definition='real(rp) :: r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='2' comment='Center of section' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dx0_ds', input%dx0_ds)
  call json%add(json_root, 'dy0_ds', input%dy0_ds)
  !line=433 definition='real(rp) :: x0_coef(0:3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='x0_coef' type='real' size='rp' dimension='0:3' comment='Spline coefs for x-center' default='0'
  call json%create_array(json_list1, 'x0_coef')
  do i1 = lbound(input%x0_coef, 1), ubound(input%x0_coef, 1)
    call json%create_real(json_val, input%x0_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=434 definition='real(rp) :: y0_coef(0:3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y0_coef' type='real' size='rp' dimension='0:3' comment='Spline coefs for y-center' default='0'
  call json%create_array(json_list1, 'y0_coef')
  do i1 = lbound(input%y0_coef, 1), ubound(input%y0_coef, 1)
    call json%create_real(json_val, input%y0_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dr_ds', input%dr_ds)
  !line=436 definition='real(rp) :: p1_coef(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='p1_coef' type='real' size='rp' dimension='3' comment='Spline coefs for p0 function' default='0'
  call json%create_array(json_list1, 'p1_coef')
  do i1 = lbound(input%p1_coef, 1), ubound(input%p1_coef, 1)
    call json%create_real(json_val, input%p1_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=437 definition='real(rp) :: p2_coef(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='p2_coef' type='real' size='rp' dimension='3' comment='Spline coefs for p1 function' default='0'
  call json%create_array(json_list1, 'p2_coef')
  do i1 = lbound(input%p2_coef, 1), ubound(input%p2_coef, 1)
    call json%create_real(json_val, input%p2_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine wall3d_section_struct_to_json
subroutine wall3d_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wall3d_struct
  implicit none
  type(json_core) :: json
  type (wall3d_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'ix_wall3d', int(input%ix_wall3d))
  call json%add(json_root, 'n_link', int(input%n_link))
  call json%add(json_root, 'thickness', input%thickness)
  call json%add(json_root, 'clear_material', trim(input%clear_material))
  call json%add(json_root, 'opaque_material', trim(input%opaque_material))
  call json%add(json_root, 'superimpose', input%superimpose)
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  if (allocated(input%section)) then
    !line=459 definition='type (wall3d_section_struct), allocatable :: section(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='wall3d_section_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='section' type='type' size='wall3d_section_struct' dimension=':' comment='Indexed from 1.' default=None
    call json%create_array(json_list1, 'section')
    do i1 = lbound(input%section, 1), ubound(input%section, 1)
      call wall3d_section_struct_to_json(input%section(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine wall3d_struct_to_json
subroutine taylor_term_struct_to_json (input, json_root, depth)
  use bmad_struct, only: taylor_term_struct
  implicit none
  type(json_core) :: json
  type (taylor_term_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'coef', input%coef)
  !line=466 definition='integer :: expn(6) = 0' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='expn' type='integer' size=None dimension='6' comment='' default='0'
  call json%create_array(json_list1, 'expn')
  do i1 = lbound(input%expn, 1), ubound(input%expn, 1)
    call json%create_integer(json_val, input%expn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine taylor_term_struct_to_json
subroutine complex_taylor_term_struct_to_json (input, json_root, depth)
  use bmad_struct, only: complex_taylor_term_struct
  implicit none
  type(json_core) :: json
  type (complex_taylor_term_struct), pointer, intent(in) :: input
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
  call complex_to_json(input%coef, json_list1, depth+1)
  call json%rename(json_list1, 'coef')
  call json%add(json_root, json_list1)
  !line=471 definition='integer :: expn(6)' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='expn' type='integer' size=None dimension='6' comment='' default=None
  call json%create_array(json_list1, 'expn')
  do i1 = lbound(input%expn, 1), ubound(input%expn, 1)
    call json%create_integer(json_val, input%expn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine complex_taylor_term_struct_to_json
subroutine taylor_struct_to_json (input, json_root, depth)
  use bmad_struct, only: taylor_struct
  implicit none
  type(json_core) :: json
  type (taylor_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ref', input%ref)
  if (associated(input%term)) then
    !line=480 definition='type (taylor_term_struct), pointer :: term(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='taylor_term_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='term' type='type' size='taylor_term_struct' dimension=':' comment='' default='null()'
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call taylor_term_struct_to_json(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine taylor_struct_to_json
subroutine complex_taylor_struct_to_json (input, json_root, depth)
  use bmad_struct, only: complex_taylor_struct
  implicit none
  type(json_core) :: json
  type (complex_taylor_struct), pointer, intent(in) :: input
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
  call complex_to_json(input%ref, json_list1, depth+1)
  call json%rename(json_list1, 'ref')
  call json%add(json_root, json_list1)
  if (associated(input%term)) then
    !line=489 definition='type (complex_taylor_term_struct), pointer :: term(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='complex_taylor_term_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='term' type='type' size='complex_taylor_term_struct' dimension=':' comment='' default='null()'
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call complex_taylor_term_struct_to_json(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine complex_taylor_struct_to_json
subroutine coord_struct_to_json (input, json_root, depth)
  use bmad_struct, only: coord_struct
  implicit none
  type(json_core) :: json
  type (coord_struct), pointer, intent(in) :: input
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
  !line=530 definition='real(rp) :: vec(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec' type='real' size='rp' dimension='6' comment='(x, px, y, py, z, pz). Generally phase space for charged particles. See Bmad manual.' default='0'
  call json%create_array(json_list1, 'vec')
  do i1 = lbound(input%vec, 1), ubound(input%vec, 1)
    call json%create_real(json_val, input%vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 't', input%t)
  !line=533 definition='real(rp) :: spin(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin' type='real' size='rp' dimension='3' comment='Spin.' default='0'
  call json%create_array(json_list1, 'spin')
  do i1 = lbound(input%spin, 1), ubound(input%spin, 1)
    call json%create_real(json_val, input%spin(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=534 definition='real(rp) :: field(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='field' type='real' size='rp' dimension='2' comment='Photon E-field intensity (x,y).' default='0'
  call json%create_array(json_list1, 'field')
  do i1 = lbound(input%field, 1), ubound(input%field, 1)
    call json%create_real(json_val, input%field(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=535 definition='real(rp) :: phase(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='phase' type='real' size='rp' dimension='2' comment='Photon E-field phase (x,y). phase(1) is also used with' default='0'
  call json%create_array(json_list1, 'phase')
  do i1 = lbound(input%phase, 1), ubound(input%phase, 1)
    call json%create_real(json_val, input%phase(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'charge', input%charge)
  call json%add(json_root, 'dt_ref', input%dt_ref)
  call json%add(json_root, 'r', input%r)
  call json%add(json_root, 'p0c', input%p0c)
  call json%add(json_root, 'e_potential', input%E_potential)
  call json%add(json_root, 'beta', input%beta)
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_turn', int(input%ix_turn))
  call json%add(json_root, 'ix_user', int(input%ix_user))
  call json%add(json_root, 'state', int(input%state))
  call json%add(json_root, 'direction', int(input%direction))
  call json%add(json_root, 'time_dir', int(input%time_dir))
  call json%add(json_root, 'species', int(input%species))
  call json%add(json_root, 'location', int(input%location))
end subroutine coord_struct_to_json
subroutine coord_array_struct_to_json (input, json_root, depth)
  use bmad_struct, only: coord_array_struct
  implicit none
  type(json_core) :: json
  type (coord_array_struct), pointer, intent(in) :: input
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
  if (allocated(input%orbit)) then
    !line=562 definition='type (coord_struct), allocatable :: orbit(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='coord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='orbit' type='type' size='coord_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'orbit')
    do i1 = lbound(input%orbit, 1), ubound(input%orbit, 1)
      call coord_struct_to_json(input%orbit(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine coord_array_struct_to_json
subroutine bpm_phase_coupling_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bpm_phase_coupling_struct
  implicit none
  type(json_core) :: json
  type (bpm_phase_coupling_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'k_22a', input%K_22a)
  call json%add(json_root, 'k_12a', input%K_12a)
  call json%add(json_root, 'k_11b', input%K_11b)
  call json%add(json_root, 'k_12b', input%K_12b)
  call json%add(json_root, 'cbar22_a', input%Cbar22_a)
  call json%add(json_root, 'cbar12_a', input%Cbar12_a)
  call json%add(json_root, 'cbar11_b', input%Cbar11_b)
  call json%add(json_root, 'cbar12_b', input%Cbar12_b)
  call json%add(json_root, 'phi_a', input%phi_a)
  call json%add(json_root, 'phi_b', input%phi_b)
end subroutine bpm_phase_coupling_struct_to_json
subroutine wake_sr_z_long_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wake_sr_z_long_struct
  implicit none
  type(json_core) :: json
  type (wake_sr_z_long_struct), pointer, intent(in) :: input
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
  if (allocated(input%w)) then
    !line=595 definition='real(rp), allocatable :: w(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='w' type='real' size='rp' dimension=':' comment='Input single particle Wake. Indexed from 1.' default=None
    call json%create_array(json_list1, 'w')
    do i1 = lbound(input%w, 1), ubound(input%w, 1)
      call json%create_real(json_val, input%w(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%fw)) then
    !line=596 definition='complex(rp), allocatable :: fw(:)' type_info=TypeInformation(type='complex', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='fw' type='complex' size='rp' dimension=':' comment='Fourier transform of w.' default=None
    call json%create_array(json_list1, 'fw')
    do i1 = lbound(input%fw, 1), ubound(input%fw, 1)
      call complex_to_json(input%fw(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%fbunch)) then
    !line=597 definition='complex(rp), allocatable :: fbunch(:), w_out(:)' type_info=TypeInformation(type='complex', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='fbunch' type='complex' size='rp' dimension=':' comment='Scratch space.' default=None
    call json%create_array(json_list1, 'fbunch')
    do i1 = lbound(input%fbunch, 1), ubound(input%fbunch, 1)
      call complex_to_json(input%fbunch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%w_out)) then
    !line=597 definition='complex(rp), allocatable :: fbunch(:), w_out(:)' type_info=TypeInformation(type='complex', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='w_out' type='complex' size='rp' dimension=':' comment='Scratch space.' default=None
    call json%create_array(json_list1, 'w_out')
    do i1 = lbound(input%w_out, 1), ubound(input%w_out, 1)
      call complex_to_json(input%w_out(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'dz', input%dz)
  call json%add(json_root, 'z0', input%z0)
  call json%add(json_root, 'smoothing_sigma', input%smoothing_sigma)
  call json%add(json_root, 'position_dependence', int(input%position_dependence))
  call json%add(json_root, 'time_based', input%time_based)
end subroutine wake_sr_z_long_struct_to_json
subroutine wake_sr_mode_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wake_sr_mode_struct
  implicit none
  type(json_core) :: json
  type (wake_sr_mode_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'amp', input%amp)
  call json%add(json_root, 'damp', input%damp)
  call json%add(json_root, 'k', input%k)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'b_sin', input%b_sin)
  call json%add(json_root, 'b_cos', input%b_cos)
  call json%add(json_root, 'a_sin', input%a_sin)
  call json%add(json_root, 'a_cos', input%a_cos)
  call json%add(json_root, 'polarization', int(input%polarization))
  call json%add(json_root, 'position_dependence', int(input%position_dependence))
end subroutine wake_sr_mode_struct_to_json
subroutine wake_sr_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wake_sr_struct
  implicit none
  type(json_core) :: json
  type (wake_sr_struct), pointer, intent(in) :: input
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
  call wake_sr_z_long_struct_to_json(input%z_long, json_val, depth + 1)
  call json%rename(json_val, 'z_long')
  call json%add(json_root, json_val)
  if (allocated(input%long)) then
    !line=623 definition='type (wake_sr_mode_struct), allocatable :: long(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='wake_sr_mode_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='long' type='type' size='wake_sr_mode_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'long')
    do i1 = lbound(input%long, 1), ubound(input%long, 1)
      call wake_sr_mode_struct_to_json(input%long(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%trans)) then
    !line=624 definition='type (wake_sr_mode_struct), allocatable :: trans(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='wake_sr_mode_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='trans' type='type' size='wake_sr_mode_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'trans')
    do i1 = lbound(input%trans, 1), ubound(input%trans, 1)
      call wake_sr_mode_struct_to_json(input%trans(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'z_ref_long', input%z_ref_long)
  call json%add(json_root, 'z_ref_trans', input%z_ref_trans)
  call json%add(json_root, 'z_max', input%z_max)
  call json%add(json_root, 'amp_scale', input%amp_scale)
  call json%add(json_root, 'z_scale', input%z_scale)
  call json%add(json_root, 'scale_with_length', input%scale_with_length)
end subroutine wake_sr_struct_to_json
subroutine wake_lr_mode_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wake_lr_mode_struct
  implicit none
  type(json_core) :: json
  type (wake_lr_mode_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'freq', input%freq)
  call json%add(json_root, 'freq_in', input%freq_in)
  call json%add(json_root, 'r_over_q', input%R_over_Q)
  call json%add(json_root, 'q', input%Q)
  call json%add(json_root, 'damp', input%damp)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'angle', input%angle)
  call json%add(json_root, 'b_sin', input%b_sin)
  call json%add(json_root, 'b_cos', input%b_cos)
  call json%add(json_root, 'a_sin', input%a_sin)
  call json%add(json_root, 'a_cos', input%a_cos)
  call json%add(json_root, 'm', int(input%m))
  call json%add(json_root, 'polarized', input%polarized)
end subroutine wake_lr_mode_struct_to_json
subroutine wake_lr_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wake_lr_struct
  implicit none
  type(json_core) :: json
  type (wake_lr_struct), pointer, intent(in) :: input
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
  if (allocated(input%mode)) then
    !line=654 definition='type (wake_lr_mode_struct), allocatable :: mode(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='wake_lr_mode_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='mode' type='type' size='wake_lr_mode_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'mode')
    do i1 = lbound(input%mode, 1), ubound(input%mode, 1)
      call wake_lr_mode_struct_to_json(input%mode(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 't_ref', input%t_ref)
  call json%add(json_root, 'freq_spread', input%freq_spread)
  call json%add(json_root, 'amp_scale', input%amp_scale)
  call json%add(json_root, 'time_scale', input%time_scale)
  call json%add(json_root, 'self_wake_on', input%self_wake_on)
end subroutine wake_lr_struct_to_json
subroutine wake_struct_to_json (input, json_root, depth)
  use bmad_struct, only: wake_struct
  implicit none
  type(json_core) :: json
  type (wake_struct), pointer, intent(in) :: input
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
  call wake_sr_struct_to_json(input%sr, json_val, depth + 1)
  call json%rename(json_val, 'sr')
  call json%add(json_root, json_val)
  call wake_lr_struct_to_json(input%lr, json_val, depth + 1)
  call json%rename(json_val, 'lr')
  call json%add(json_root, json_val)
end subroutine wake_struct_to_json
subroutine ac_kicker_time_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ac_kicker_time_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (ac_kicker_time_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'amp', input%amp)
  call json%add(json_root, 'time', input%time)
  call spline_struct_to_json(input%spline, json_val, depth + 1)
  call json%rename(json_val, 'spline')
  call json%add(json_root, json_val)
end subroutine ac_kicker_time_struct_to_json
subroutine ac_kicker_freq_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ac_kicker_freq_struct
  implicit none
  type(json_core) :: json
  type (ac_kicker_freq_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'f', input%f)
  call json%add(json_root, 'amp', input%amp)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'rf_clock_harmonic', int(input%rf_clock_harmonic))
end subroutine ac_kicker_freq_struct_to_json
subroutine ac_kicker_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ac_kicker_struct
  implicit none
  type(json_core) :: json
  type (ac_kicker_struct), pointer, intent(in) :: input
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
  if (allocated(input%amp_vs_time)) then
    !line=686 definition='type (ac_kicker_time_struct), allocatable :: amp_vs_time(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ac_kicker_time_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='amp_vs_time' type='type' size='ac_kicker_time_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'amp_vs_time')
    do i1 = lbound(input%amp_vs_time, 1), ubound(input%amp_vs_time, 1)
      call ac_kicker_time_struct_to_json(input%amp_vs_time(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%frequency)) then
    !line=687 definition='type (ac_kicker_freq_struct), allocatable :: frequency(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ac_kicker_freq_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='frequency' type='type' size='ac_kicker_freq_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'frequency')
    do i1 = lbound(input%frequency, 1), ubound(input%frequency, 1)
      call ac_kicker_freq_struct_to_json(input%frequency(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine ac_kicker_struct_to_json
subroutine cartesian_map_term1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: cartesian_map_term1_struct
  implicit none
  type(json_core) :: json
  type (cartesian_map_term1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'coef', input%coef)
  call json%add(json_root, 'kx', input%kx)
  call json%add(json_root, 'ky', input%ky)
  call json%add(json_root, 'kz', input%kz)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'phi_z', input%phi_z)
  call json%add(json_root, 'family', int(input%family))
  call json%add(json_root, 'form', int(input%form))
end subroutine cartesian_map_term1_struct_to_json
subroutine cartesian_map_term_struct_to_json (input, json_root, depth)
  use bmad_struct, only: cartesian_map_term_struct
  implicit none
  type(json_core) :: json
  type (cartesian_map_term_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_link', int(input%n_link))
  if (allocated(input%term)) then
    !line=710 definition='type (cartesian_map_term1_struct), allocatable :: term(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='cartesian_map_term1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='term' type='type' size='cartesian_map_term1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call cartesian_map_term1_struct_to_json(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine cartesian_map_term_struct_to_json
subroutine cartesian_map_struct_to_json (input, json_root, depth)
  use bmad_struct, only: cartesian_map_struct
  implicit none
  type(json_core) :: json
  type (cartesian_map_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'field_scale', input%field_scale)
  !line=715 definition='real(rp) :: r0(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='3' comment='Field origin offset.' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'field_type', int(input%field_type))
  if (associated(input%ptr)) then
    call cartesian_map_term_struct_to_json(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
end subroutine cartesian_map_struct_to_json
subroutine cylindrical_map_term1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: cylindrical_map_term1_struct
  implicit none
  type(json_core) :: json
  type (cylindrical_map_term1_struct), pointer, intent(in) :: input
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
  call complex_to_json(input%e_coef, json_list1, depth+1)
  call json%rename(json_list1, 'e_coef')
  call json%add(json_root, json_list1)
  call complex_to_json(input%b_coef, json_list1, depth+1)
  call json%rename(json_list1, 'b_coef')
  call json%add(json_root, json_list1)
end subroutine cylindrical_map_term1_struct_to_json
subroutine cylindrical_map_term_struct_to_json (input, json_root, depth)
  use bmad_struct, only: cylindrical_map_term_struct
  implicit none
  type(json_core) :: json
  type (cylindrical_map_term_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_link', int(input%n_link))
  if (allocated(input%term)) then
    !line=732 definition='type (cylindrical_map_term1_struct), allocatable :: term(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='cylindrical_map_term1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='term' type='type' size='cylindrical_map_term1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call cylindrical_map_term1_struct_to_json(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine cylindrical_map_term_struct_to_json
subroutine cylindrical_map_struct_to_json (input, json_root, depth)
  use bmad_struct, only: cylindrical_map_struct
  implicit none
  type(json_core) :: json
  type (cylindrical_map_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'm', int(input%m))
  call json%add(json_root, 'harmonic', int(input%harmonic))
  call json%add(json_root, 'phi0_fieldmap', input%phi0_fieldmap)
  call json%add(json_root, 'theta0_azimuth', input%theta0_azimuth)
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'dz', input%dz)
  !line=744 definition='real(rp) :: r0(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='3' comment='Field origin offset.' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%ptr)) then
    call cylindrical_map_term_struct_to_json(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
end subroutine cylindrical_map_struct_to_json
subroutine gen_grad1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: gen_grad1_struct
  implicit none
  type(json_core) :: json
  type (gen_grad1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'm', int(input%m))
  call json%add(json_root, 'sincos', int(input%sincos))
  call json%add(json_root, 'n_deriv_max', int(input%n_deriv_max))
  if (allocated(input%deriv)) then
    !line=754 definition='real(rp), allocatable :: deriv(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='deriv' type='real' size='rp' dimension=':,:' comment='Range: (iz0:iz1, 0:2*n_deriv_max+1)' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%deriv, 2), ubound(input%deriv, 2)
      call json%create_array(json_list1, 'deriv')
      do i1 = lbound(input%deriv, 1), ubound(input%deriv, 1)
        call json%create_real(json_val, input%deriv(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine gen_grad1_struct_to_json
subroutine gen_grad_map_struct_to_json (input, json_root, depth)
  use bmad_struct, only: gen_grad_map_struct
  implicit none
  type(json_core) :: json
  type (gen_grad_map_struct), pointer, intent(in) :: input
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
  if (allocated(input%gg)) then
    !line=760 definition='type (gen_grad1_struct), allocatable :: gg(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='gen_grad1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='gg' type='type' size='gen_grad1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'gg')
    do i1 = lbound(input%gg, 1), ubound(input%gg, 1)
      call gen_grad1_struct_to_json(input%gg(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'field_type', int(input%field_type))
  call json%add(json_root, 'iz0', int(input%iz0))
  call json%add(json_root, 'iz1', int(input%iz1))
  call json%add(json_root, 'dz', input%dz)
  !line=766 definition='real(rp) :: r0(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='3' comment='field origin relative to ele_anchor_pt.' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  call json%add(json_root, 'curved_ref_frame', input%curved_ref_frame)
end subroutine gen_grad_map_struct_to_json
subroutine grid_field_pt1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: grid_field_pt1_struct
  implicit none
  type(json_core) :: json
  type (grid_field_pt1_struct), pointer, intent(in) :: input
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
  !line=775 definition='complex(rp) :: E(3) = 0' type_info=TypeInformation(type='complex', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='E' type='complex' size='rp' dimension='3' comment='' default='0'
  call json%create_array(json_list1, 'e')
  do i1 = lbound(input%E, 1), ubound(input%E, 1)
    call complex_to_json(input%E(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=776 definition='complex(rp) :: B(3) = 0' type_info=TypeInformation(type='complex', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='B' type='complex' size='rp' dimension='3' comment='' default='0'
  call json%create_array(json_list1, 'b')
  do i1 = lbound(input%B, 1), ubound(input%B, 1)
    call complex_to_json(input%B(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine grid_field_pt1_struct_to_json
subroutine grid_field_pt_struct_to_json (input, json_root, depth)
  use bmad_struct, only: grid_field_pt_struct
  implicit none
  type(json_core) :: json
  type (grid_field_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_link', int(input%n_link))
  if (allocated(input%pt)) then
    !line=782 definition='type (grid_field_pt1_struct), allocatable :: pt(:,:,:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='grid_field_pt1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='grid_field_pt1_struct' dimension=':,:,:' comment='' default=None
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%pt, 3), ubound(input%pt, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
        call json%create_array(json_list1, 'pt')
        do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
          call grid_field_pt1_struct_to_json(input%pt(i1, i2, i3), json_val, depth + 1)
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
end subroutine grid_field_pt_struct_to_json
subroutine grid_field_struct_to_json (input, json_root, depth)
  use bmad_struct, only: grid_field_struct
  use sim_utils_json, only: bicubic_cmplx_coef_struct_to_json, tricubic_cmplx_coef_struct_to_json
  implicit none
  type(json_core) :: json
  type (grid_field_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'geometry', int(input%geometry))
  call json%add(json_root, 'harmonic', int(input%harmonic))
  call json%add(json_root, 'phi0_fieldmap', input%phi0_fieldmap)
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'field_type', int(input%field_type))
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'interpolation_order', int(input%interpolation_order))
  !line=794 definition='real(rp) :: dr(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dr' type='real' size='rp' dimension='3' comment='Grid spacing.' default='0'
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=795 definition='real(rp) :: r0(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='3' comment='Field origin relative to ele_anchor_pt.' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'curved_ref_frame', input%curved_ref_frame)
  if (associated(input%ptr)) then
    call grid_field_pt_struct_to_json(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
  !line=798 definition='type (bicubic_cmplx_coef_struct) bi_coef(4, 2, 3)' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='bicubic_cmplx_coef_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='bi_coef' type='type' size='bicubic_cmplx_coef_struct' dimension='4, 2, 3' comment='Save computed coefs for faster tracking' default=None
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%bi_coef, 3), ubound(input%bi_coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%bi_coef, 2), ubound(input%bi_coef, 2)
      call json%create_array(json_list1, 'bi_coef')
      do i1 = lbound(input%bi_coef, 1), ubound(input%bi_coef, 1)
        call bicubic_cmplx_coef_struct_to_json(input%bi_coef(i1, i2, i3), json_val, depth + 1)
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
  !line=799 definition='type (tricubic_cmplx_coef_struct) tri_coef(4, 2, 3)' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='tricubic_cmplx_coef_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='tri_coef' type='type' size='tricubic_cmplx_coef_struct' dimension='4, 2, 3' comment='Save computed coefs for faster tracking' default=None
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%tri_coef, 3), ubound(input%tri_coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%tri_coef, 2), ubound(input%tri_coef, 2)
      call json%create_array(json_list1, 'tri_coef')
      do i1 = lbound(input%tri_coef, 1), ubound(input%tri_coef, 1)
        call tricubic_cmplx_coef_struct_to_json(input%tri_coef(i1, i2, i3), json_val, depth + 1)
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
end subroutine grid_field_struct_to_json
subroutine em_taylor_term_struct_to_json (input, json_root, depth)
  use bmad_struct, only: em_taylor_term_struct
  implicit none
  type(json_core) :: json
  type (em_taylor_term_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'coef', input%coef)
  !line=808 definition='integer :: expn(2) = 0' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='expn' type='integer' size=None dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'expn')
  do i1 = lbound(input%expn, 1), ubound(input%expn, 1)
    call json%create_integer(json_val, input%expn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine em_taylor_term_struct_to_json
subroutine em_taylor_struct_to_json (input, json_root, depth)
  use bmad_struct, only: em_taylor_struct
  implicit none
  type(json_core) :: json
  type (em_taylor_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ref', input%ref)
  if (allocated(input%term)) then
    !line=813 definition='type (em_taylor_term_struct), allocatable :: term(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='em_taylor_term_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='term' type='type' size='em_taylor_term_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call em_taylor_term_struct_to_json(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine em_taylor_struct_to_json
subroutine floor_position_struct_to_json (input, json_root, depth)
  use bmad_struct, only: floor_position_struct
  implicit none
  type(json_core) :: json
  type (floor_position_struct), pointer, intent(in) :: input
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
  !line=828 definition='real(rp) :: r(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r' type='real' size='rp' dimension='3' comment='(x, y, z) offset from origin' default='0'
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=829 definition='real(rp) :: w(3,3) =  mat3_unit$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='w' type='real' size='rp' dimension='3,3' comment='W matrix. Columns are unit vectors of the frame axes.' default='mat3_unit$'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%w, 2), ubound(input%w, 2)
    call json%create_array(json_list1, 'w')
    do i1 = lbound(input%w, 1), ubound(input%w, 1)
      call json%create_real(json_val, input%w(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'theta', input%theta)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'psi', input%psi)
end subroutine floor_position_struct_to_json
subroutine high_energy_space_charge_struct_to_json (input, json_root, depth)
  use bmad_struct, only: high_energy_space_charge_struct
  implicit none
  type(json_core) :: json
  type (high_energy_space_charge_struct), pointer, intent(in) :: input
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
  call coord_struct_to_json(input%closed_orb, json_val, depth + 1)
  call json%rename(json_val, 'closed_orb')
  call json%add(json_root, json_val)
  call json%add(json_root, 'kick_const', input%kick_const)
  call json%add(json_root, 'sig_x', input%sig_x)
  call json%add(json_root, 'sig_y', input%sig_y)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'sin_phi', input%sin_phi)
  call json%add(json_root, 'cos_phi', input%cos_phi)
  call json%add(json_root, 'sig_z', input%sig_z)
end subroutine high_energy_space_charge_struct_to_json
subroutine xy_disp_struct_to_json (input, json_root, depth)
  use bmad_struct, only: xy_disp_struct
  implicit none
  type(json_core) :: json
  type (xy_disp_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'eta', input%eta)
  call json%add(json_root, 'etap', input%etap)
  call json%add(json_root, 'deta_ds', input%deta_ds)
  call json%add(json_root, 'sigma', input%sigma)
end subroutine xy_disp_struct_to_json
subroutine lat_ele_loc_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_ele_loc_struct
  implicit none
  type(json_core) :: json
  type (lat_ele_loc_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
end subroutine lat_ele_loc_struct_to_json
subroutine lat_ele_order1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_ele_order1_struct
  implicit none
  type(json_core) :: json
  type (lat_ele_order1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_order', int(input%ix_order))
end subroutine lat_ele_order1_struct_to_json
subroutine lat_ele_order_array_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_ele_order_array_struct
  implicit none
  type(json_core) :: json
  type (lat_ele_order_array_struct), pointer, intent(in) :: input
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
    !line=866 definition='type (lat_ele_order1_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='lat_ele_order1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='lat_ele_order1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call lat_ele_order1_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine lat_ele_order_array_struct_to_json
subroutine lat_ele_order_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_ele_order_struct
  implicit none
  type(json_core) :: json
  type (lat_ele_order_struct), pointer, intent(in) :: input
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
  if (allocated(input%branch)) then
    !line=885 definition='type (lat_ele_order_array_struct), allocatable :: branch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='lat_ele_order_array_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='branch' type='type' size='lat_ele_order_array_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call lat_ele_order_array_struct_to_json(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine lat_ele_order_struct_to_json
subroutine ele_pointer_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ele_pointer_struct
  implicit none
  type(json_core) :: json
  type (ele_pointer_struct), pointer, intent(in) :: input
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
  if (associated(input%ele)) then
    call ele_struct_to_json(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  call lat_ele_loc_struct_to_json(input%loc, json_val, depth + 1)
  call json%rename(json_val, 'loc')
  call json%add(json_root, json_val)
  call json%add(json_root, 'id', int(input%id))
end subroutine ele_pointer_struct_to_json
subroutine branch_pointer_struct_to_json (input, json_root, depth)
  use bmad_struct, only: branch_pointer_struct
  implicit none
  type(json_core) :: json
  type (branch_pointer_struct), pointer, intent(in) :: input
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
  if (associated(input%branch)) then
    call branch_struct_to_json(input%branch, json_val, depth + 1)
    call json%rename(json_val, 'branch')
    call json%add(json_root, json_val)
  endif
end subroutine branch_pointer_struct_to_json
subroutine lat_pointer_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_pointer_struct
  implicit none
  type(json_core) :: json
  type (lat_pointer_struct), pointer, intent(in) :: input
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
  if (associated(input%lat)) then
    call lat_struct_to_json(input%lat, json_val, depth + 1)
    call json%rename(json_val, 'lat')
    call json%add(json_root, json_val)
  endif
end subroutine lat_pointer_struct_to_json
subroutine mode3_struct_to_json (input, json_root, depth)
  use bmad_struct, only: mode3_struct
  implicit none
  type(json_core) :: json
  type (mode3_struct), pointer, intent(in) :: input
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
  !line=916 definition='real(rp) v(6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='v' type='real' size='rp' dimension='6,6' comment='' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%v, 2), ubound(input%v, 2)
    call json%create_array(json_list1, 'v')
    do i1 = lbound(input%v, 1), ubound(input%v, 1)
      call json%create_real(json_val, input%v(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call twiss_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%c, json_val, depth + 1)
  call json%rename(json_val, 'c')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
end subroutine mode3_struct_to_json
subroutine bookkeeping_state_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bookkeeping_state_struct
  implicit none
  type(json_core) :: json
  type (bookkeeping_state_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'attributes', int(input%attributes))
  call json%add(json_root, 'control', int(input%control))
  call json%add(json_root, 'floor_position', int(input%floor_position))
  call json%add(json_root, 's_position', int(input%s_position))
  call json%add(json_root, 'ref_energy', int(input%ref_energy))
  call json%add(json_root, 'mat6', int(input%mat6))
  call json%add(json_root, 'rad_int', int(input%rad_int))
  call json%add(json_root, 'ptc', int(input%ptc))
  call json%add(json_root, 'has_misalign', input%has_misalign)
end subroutine bookkeeping_state_struct_to_json
subroutine multipole_cache_struct_to_json (input, json_root, depth)
  use bmad_struct, only: multipole_cache_struct
  implicit none
  type(json_core) :: json
  type (multipole_cache_struct), pointer, intent(in) :: input
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
  if (allocated(input%a_pole_mag)) then
    !line=947 definition='real(rp), allocatable :: a_pole_mag(:), b_pole_mag(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='a_pole_mag' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'a_pole_mag')
    do i1 = lbound(input%a_pole_mag, 1), ubound(input%a_pole_mag, 1)
      call json%create_real(json_val, input%a_pole_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_pole_mag)) then
    !line=947 definition='real(rp), allocatable :: a_pole_mag(:), b_pole_mag(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='b_pole_mag' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'b_pole_mag')
    do i1 = lbound(input%b_pole_mag, 1), ubound(input%b_pole_mag, 1)
      call json%create_real(json_val, input%b_pole_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%a_kick_mag)) then
    !line=948 definition='real(rp), allocatable :: a_kick_mag(:), b_kick_mag(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='a_kick_mag' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'a_kick_mag')
    do i1 = lbound(input%a_kick_mag, 1), ubound(input%a_kick_mag, 1)
      call json%create_real(json_val, input%a_kick_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_kick_mag)) then
    !line=948 definition='real(rp), allocatable :: a_kick_mag(:), b_kick_mag(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='b_kick_mag' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'b_kick_mag')
    do i1 = lbound(input%b_kick_mag, 1), ubound(input%b_kick_mag, 1)
      call json%create_real(json_val, input%b_kick_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_pole_mag_max', int(input%ix_pole_mag_max))
  call json%add(json_root, 'ix_kick_mag_max', int(input%ix_kick_mag_max))
  call json%add(json_root, 'mag_valid', input%mag_valid)
  if (allocated(input%a_pole_elec)) then
    !line=951 definition='real(rp), allocatable :: a_pole_elec(:), b_pole_elec(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='a_pole_elec' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'a_pole_elec')
    do i1 = lbound(input%a_pole_elec, 1), ubound(input%a_pole_elec, 1)
      call json%create_real(json_val, input%a_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_pole_elec)) then
    !line=951 definition='real(rp), allocatable :: a_pole_elec(:), b_pole_elec(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='b_pole_elec' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'b_pole_elec')
    do i1 = lbound(input%b_pole_elec, 1), ubound(input%b_pole_elec, 1)
      call json%create_real(json_val, input%b_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%a_kick_elec)) then
    !line=952 definition='real(rp), allocatable :: a_kick_elec(:), b_kick_elec(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='a_kick_elec' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'a_kick_elec')
    do i1 = lbound(input%a_kick_elec, 1), ubound(input%a_kick_elec, 1)
      call json%create_real(json_val, input%a_kick_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_kick_elec)) then
    !line=952 definition='real(rp), allocatable :: a_kick_elec(:), b_kick_elec(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='b_kick_elec' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'b_kick_elec')
    do i1 = lbound(input%b_kick_elec, 1), ubound(input%b_kick_elec, 1)
      call json%create_real(json_val, input%b_kick_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_pole_elec_max', int(input%ix_pole_elec_max))
  call json%add(json_root, 'ix_kick_elec_max', int(input%ix_kick_elec_max))
  call json%add(json_root, 'elec_valid', input%elec_valid)
end subroutine multipole_cache_struct_to_json
subroutine rad_map_struct_to_json (input, json_root, depth)
  use bmad_struct, only: rad_map_struct
  implicit none
  type(json_core) :: json
  type (rad_map_struct), pointer, intent(in) :: input
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
  !line=962 definition='real(rp) :: ref_orb(6) = -1' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='ref_orb' type='real' size='rp' dimension='6' comment='Reference point around which damp_mat is calculated.' default='-1'
  call json%create_array(json_list1, 'ref_orb')
  do i1 = lbound(input%ref_orb, 1), ubound(input%ref_orb, 1)
    call json%create_real(json_val, input%ref_orb(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=963 definition='real(rp) :: damp_dmat(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='damp_dmat' type='real' size='rp' dimension='6,6' comment='damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%damp_dmat, 2), ubound(input%damp_dmat, 2)
    call json%create_array(json_list1, 'damp_dmat')
    do i1 = lbound(input%damp_dmat, 1), ubound(input%damp_dmat, 1)
      call json%create_real(json_val, input%damp_dmat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=964 definition='real(rp) :: xfer_damp_vec(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='xfer_damp_vec' type='real' size='rp' dimension='6' comment='Transfer map with damping 0th order vector.' default='0'
  call json%create_array(json_list1, 'xfer_damp_vec')
  do i1 = lbound(input%xfer_damp_vec, 1), ubound(input%xfer_damp_vec, 1)
    call json%create_real(json_val, input%xfer_damp_vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=965 definition='real(rp) :: xfer_damp_mat(6,6) = mat6_unit$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='xfer_damp_mat' type='real' size='rp' dimension='6,6' comment='1st order matrix: xfer_no_damp_mat + xfer_damp_correction.' default='mat6_unit$'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%xfer_damp_mat, 2), ubound(input%xfer_damp_mat, 2)
    call json%create_array(json_list1, 'xfer_damp_mat')
    do i1 = lbound(input%xfer_damp_mat, 1), ubound(input%xfer_damp_mat, 1)
      call json%create_real(json_val, input%xfer_damp_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=966 definition='real(rp) :: stoc_mat(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='stoc_mat' type='real' size='rp' dimension='6,6' comment='Stochastic variance or "kick" (Cholesky decomposed) matrix.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%stoc_mat, 2), ubound(input%stoc_mat, 2)
    call json%create_array(json_list1, 'stoc_mat')
    do i1 = lbound(input%stoc_mat, 1), ubound(input%stoc_mat, 1)
      call json%create_real(json_val, input%stoc_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine rad_map_struct_to_json
subroutine rad_map_ele_struct_to_json (input, json_root, depth)
  use bmad_struct, only: rad_map_ele_struct
  implicit none
  type(json_core) :: json
  type (rad_map_ele_struct), pointer, intent(in) :: input
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
  call rad_map_struct_to_json(input%rm0, json_val, depth + 1)
  call json%rename(json_val, 'rm0')
  call json%add(json_root, json_val)
  call rad_map_struct_to_json(input%rm1, json_val, depth + 1)
  call json%rename(json_val, 'rm1')
  call json%add(json_root, json_val)
  call json%add(json_root, 'stale', input%stale)
end subroutine rad_map_ele_struct_to_json
subroutine surface_segmented_pt_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_segmented_pt_struct
  implicit none
  type(json_core) :: json
  type (surface_segmented_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'z0', input%z0)
  call json%add(json_root, 'dz_dx', input%dz_dx)
  call json%add(json_root, 'dz_dy', input%dz_dy)
end subroutine surface_segmented_pt_struct_to_json
subroutine surface_segmented_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_segmented_struct
  implicit none
  type(json_core) :: json
  type (surface_segmented_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'active', input%active)
  !line=984 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dr' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=984 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%pt)) then
    !line=985 definition='type (surface_segmented_pt_struct), allocatable :: pt(:,:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='surface_segmented_pt_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='surface_segmented_pt_struct' dimension=':,:' comment='' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call surface_segmented_pt_struct_to_json(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine surface_segmented_struct_to_json
subroutine surface_h_misalign_pt_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_h_misalign_pt_struct
  implicit none
  type(json_core) :: json
  type (surface_h_misalign_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'rot_y', input%rot_y)
  call json%add(json_root, 'rot_t', input%rot_t)
  call json%add(json_root, 'rot_y_rms', input%rot_y_rms)
  call json%add(json_root, 'rot_t_rms', input%rot_t_rms)
end subroutine surface_h_misalign_pt_struct_to_json
subroutine surface_h_misalign_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_h_misalign_struct
  implicit none
  type(json_core) :: json
  type (surface_h_misalign_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'active', input%active)
  !line=997 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dr' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=997 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%pt)) then
    !line=998 definition='type (surface_h_misalign_pt_struct), allocatable :: pt(:,:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='surface_h_misalign_pt_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='surface_h_misalign_pt_struct' dimension=':,:' comment='' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call surface_h_misalign_pt_struct_to_json(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine surface_h_misalign_struct_to_json
subroutine surface_displacement_pt_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_displacement_pt_struct
  implicit none
  type(json_core) :: json
  type (surface_displacement_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'z0', input%z0)
  call json%add(json_root, 'dz_dx', input%dz_dx)
  call json%add(json_root, 'dz_dy', input%dz_dy)
  call json%add(json_root, 'd2z_dxdy', input%d2z_dxdy)
end subroutine surface_displacement_pt_struct_to_json
subroutine surface_displacement_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_displacement_struct
  implicit none
  type(json_core) :: json
  type (surface_displacement_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'active', input%active)
  !line=1010 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dr' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1010 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%pt)) then
    !line=1011 definition='type (surface_displacement_pt_struct), allocatable :: pt(:,:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='surface_displacement_pt_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='surface_displacement_pt_struct' dimension=':,:' comment='' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call surface_displacement_pt_struct_to_json(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine surface_displacement_struct_to_json
subroutine pixel_pt_struct_to_json (input, json_root, depth)
  use bmad_struct, only: pixel_pt_struct
  implicit none
  type(json_core) :: json
  type (pixel_pt_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_photon', int(input%n_photon))
  call complex_to_json(input%E_x, json_list1, depth+1)
  call json%rename(json_list1, 'e_x')
  call json%add(json_root, json_list1)
  call complex_to_json(input%E_y, json_list1, depth+1)
  call json%rename(json_list1, 'e_y')
  call json%add(json_root, json_list1)
  call json%add(json_root, 'intensity_x', input%intensity_x)
  call json%add(json_root, 'intensity_y', input%intensity_y)
  call json%add(json_root, 'intensity', input%intensity)
  !line=1020 definition='real(rp) :: orbit(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orbit' type='real' size='rp' dimension='6' comment='x, Vx/c, y, Vy/c, dummy, E - E_ref.' default='0'
  call json%create_array(json_list1, 'orbit')
  do i1 = lbound(input%orbit, 1), ubound(input%orbit, 1)
    call json%create_real(json_val, input%orbit(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1021 definition='real(rp) :: orbit_rms(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orbit_rms' type='real' size='rp' dimension='6' comment='RMS statistics.' default='0'
  call json%create_array(json_list1, 'orbit_rms')
  do i1 = lbound(input%orbit_rms, 1), ubound(input%orbit_rms, 1)
    call json%create_real(json_val, input%orbit_rms(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1022 definition='real(rp) :: init_orbit(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='init_orbit' type='real' size='rp' dimension='6' comment='Initial orbit at start of lattice statistics.' default='0'
  call json%create_array(json_list1, 'init_orbit')
  do i1 = lbound(input%init_orbit, 1), ubound(input%init_orbit, 1)
    call json%create_real(json_val, input%init_orbit(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1023 definition='real(rp) :: init_orbit_rms(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='init_orbit_rms' type='real' size='rp' dimension='6' comment='Initial orbit at start of lattice RMS statistics.' default='0'
  call json%create_array(json_list1, 'init_orbit_rms')
  do i1 = lbound(input%init_orbit_rms, 1), ubound(input%init_orbit_rms, 1)
    call json%create_real(json_val, input%init_orbit_rms(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine pixel_pt_struct_to_json
subroutine pixel_detec_struct_to_json (input, json_root, depth)
  use bmad_struct, only: pixel_detec_struct
  implicit none
  type(json_core) :: json
  type (pixel_detec_struct), pointer, intent(in) :: input
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
  !line=1027 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dr' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1027 definition='real(rp) :: dr(2) = 0, r0(2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r0' type='real' size='rp' dimension='2' comment='' default='0'
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_track_tot', int(input%n_track_tot))
  call json%add(json_root, 'n_hit_detec', int(input%n_hit_detec))
  call json%add(json_root, 'n_hit_pixel', int(input%n_hit_pixel))
  if (allocated(input%pt)) then
    !line=1031 definition='type (pixel_pt_struct), allocatable :: pt(:,:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='pixel_pt_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='pixel_pt_struct' dimension=':,:' comment='Grid of pixels' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call pixel_pt_struct_to_json(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine pixel_detec_struct_to_json
subroutine surface_curvature_struct_to_json (input, json_root, depth)
  use bmad_struct, only: surface_curvature_struct
  implicit none
  type(json_core) :: json
  type (surface_curvature_struct), pointer, intent(in) :: input
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
  !line=1037 definition='real(rp) :: xy(0:6,0:6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='xy' type='real' size='rp' dimension='0:6,0:6' comment='' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%xy, 2), ubound(input%xy, 2)
    call json%create_array(json_list1, 'xy')
    do i1 = lbound(input%xy, 1), ubound(input%xy, 1)
      call json%create_real(json_val, input%xy(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'spherical', input%spherical)
  !line=1039 definition='real(rp) :: elliptical(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='elliptical' type='real' size='rp' dimension='3' comment='Total curvature = elliptical + spherical' default='0'
  call json%create_array(json_list1, 'elliptical')
  do i1 = lbound(input%elliptical, 1), ubound(input%elliptical, 1)
    call json%create_real(json_val, input%elliptical(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'has_curvature', input%has_curvature)
end subroutine surface_curvature_struct_to_json
subroutine target_point_struct_to_json (input, json_root, depth)
  use bmad_struct, only: target_point_struct
  implicit none
  type(json_core) :: json
  type (target_point_struct), pointer, intent(in) :: input
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
  !line=1046 definition='real(rp) :: r(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r' type='real' size='rp' dimension='3' comment='(x, y, z)' default='0'
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine target_point_struct_to_json
subroutine photon_target_struct_to_json (input, json_root, depth)
  use bmad_struct, only: photon_target_struct
  implicit none
  type(json_core) :: json
  type (photon_target_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_corner', int(input%n_corner))
  call lat_ele_loc_struct_to_json(input%ele_loc, json_val, depth + 1)
  call json%rename(json_val, 'ele_loc')
  call json%add(json_root, json_val)
  !line=1053 definition='type (target_point_struct) :: corner(8) = target_point_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='target_point_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='corner' type='type' size='target_point_struct' dimension='8' comment='' default='target_point_struct()'
  call json%create_array(json_list1, 'corner')
  do i1 = lbound(input%corner, 1), ubound(input%corner, 1)
    call target_point_struct_to_json(input%corner(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call target_point_struct_to_json(input%center, json_val, depth + 1)
  call json%rename(json_val, 'center')
  call json%add(json_root, json_val)
end subroutine photon_target_struct_to_json
subroutine photon_material_struct_to_json (input, json_root, depth)
  use bmad_struct, only: photon_material_struct
  implicit none
  type(json_core) :: json
  type (photon_material_struct), pointer, intent(in) :: input
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
  call complex_to_json(input%f0_m1, json_list1, depth+1)
  call json%rename(json_list1, 'f0_m1')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f0_m2, json_list1, depth+1)
  call json%rename(json_list1, 'f0_m2')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f_0, json_list1, depth+1)
  call json%rename(json_list1, 'f_0')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f_h, json_list1, depth+1)
  call json%rename(json_list1, 'f_h')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f_hbar, json_list1, depth+1)
  call json%rename(json_list1, 'f_hbar')
  call json%add(json_root, json_list1)
  call complex_to_json(input%f_hkl, json_list1, depth+1)
  call json%rename(json_list1, 'f_hkl')
  call json%add(json_root, json_list1)
  !line=1063 definition='real(rp) :: h_norm(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='h_norm' type='real' size='rp' dimension='3' comment='Normalized H vector for crystals.' default='0'
  call json%create_array(json_list1, 'h_norm')
  do i1 = lbound(input%h_norm, 1), ubound(input%h_norm, 1)
    call json%create_real(json_val, input%h_norm(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1064 definition='real(rp) :: l_ref(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='l_ref' type='real' size='rp' dimension='3' comment='Crystal reference orbit displacement vector in element coords.' default='0'
  call json%create_array(json_list1, 'l_ref')
  do i1 = lbound(input%l_ref, 1), ubound(input%l_ref, 1)
    call json%create_real(json_val, input%l_ref(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine photon_material_struct_to_json
subroutine photon_element_struct_to_json (input, json_root, depth)
  use bmad_struct, only: photon_element_struct
  use sim_utils_json, only: spline_struct_to_json
  implicit none
  type(json_core) :: json
  type (photon_element_struct), pointer, intent(in) :: input
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
  call surface_curvature_struct_to_json(input%curvature, json_val, depth + 1)
  call json%rename(json_val, 'curvature')
  call json%add(json_root, json_val)
  call photon_target_struct_to_json(input%target, json_val, depth + 1)
  call json%rename(json_val, 'target')
  call json%add(json_root, json_val)
  call photon_material_struct_to_json(input%material, json_val, depth + 1)
  call json%rename(json_val, 'material')
  call json%add(json_root, json_val)
  call surface_segmented_struct_to_json(input%segmented, json_val, depth + 1)
  call json%rename(json_val, 'segmented')
  call json%add(json_root, json_val)
  call surface_h_misalign_struct_to_json(input%h_misalign, json_val, depth + 1)
  call json%rename(json_val, 'h_misalign')
  call json%add(json_root, json_val)
  call surface_displacement_struct_to_json(input%displacement, json_val, depth + 1)
  call json%rename(json_val, 'displacement')
  call json%add(json_root, json_val)
  call pixel_detec_struct_to_json(input%pixel, json_val, depth + 1)
  call json%rename(json_val, 'pixel')
  call json%add(json_root, json_val)
  call json%add(json_root, 'reflectivity_table_type', int(input%reflectivity_table_type))
  call photon_reflect_table_struct_to_json(input%reflectivity_table_sigma, json_val, depth + 1)
  call json%rename(json_val, 'reflectivity_table_sigma')
  call json%add(json_root, json_val)
  call photon_reflect_table_struct_to_json(input%reflectivity_table_pi, json_val, depth + 1)
  call json%rename(json_val, 'reflectivity_table_pi')
  call json%add(json_root, json_val)
  if (allocated(input%init_energy_prob)) then
    !line=1083 definition='type (spline_struct), allocatable :: init_energy_prob(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='spline_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='init_energy_prob' type='type' size='spline_struct' dimension=':' comment='Initial energy probability density' default=None
    call json%create_array(json_list1, 'init_energy_prob')
    do i1 = lbound(input%init_energy_prob, 1), ubound(input%init_energy_prob, 1)
      call spline_struct_to_json(input%init_energy_prob(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%integrated_init_energy_prob)) then
    !line=1084 definition='real(rp), allocatable :: integrated_init_energy_prob(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='integrated_init_energy_prob' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'integrated_init_energy_prob')
    do i1 = lbound(input%integrated_init_energy_prob, 1), ubound(input%integrated_init_energy_prob, 1)
      call json%create_real(json_val, input%integrated_init_energy_prob(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine photon_element_struct_to_json
subroutine bunch_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bunch_struct
  implicit none
  type(json_core) :: json
  type (bunch_struct), pointer, intent(in) :: input
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
  if (allocated(input%particle)) then
    !line=1091 definition='type (coord_struct), allocatable :: particle(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='coord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='particle' type='type' size='coord_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'particle')
    do i1 = lbound(input%particle, 1), ubound(input%particle, 1)
      call coord_struct_to_json(input%particle(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ix_z)) then
    !line=1092 definition='integer, allocatable :: ix_z(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ix_z' type='integer' size=None dimension=':' comment='bunch%ix_z(1) is index of head particle, etc.' default=None
    call json%create_array(json_list1, 'ix_z')
    do i1 = lbound(input%ix_z, 1), ubound(input%ix_z, 1)
      call json%create_integer(json_val, input%ix_z(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'charge_tot', input%charge_tot)
  call json%add(json_root, 'charge_live', input%charge_live)
  call json%add(json_root, 'z_center', input%z_center)
  call json%add(json_root, 't_center', input%t_center)
  call json%add(json_root, 't0', input%t0)
  call json%add(json_root, 'drift_between_t_and_s', input%drift_between_t_and_s)
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call json%add(json_root, 'ix_turn', int(input%ix_turn))
  call json%add(json_root, 'n_live', int(input%n_live))
  call json%add(json_root, 'n_good', int(input%n_good))
  call json%add(json_root, 'n_bad', int(input%n_bad))
end subroutine bunch_struct_to_json
subroutine beam_struct_to_json (input, json_root, depth)
  use bmad_struct, only: beam_struct
  implicit none
  type(json_core) :: json
  type (beam_struct), pointer, intent(in) :: input
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
  if (allocated(input%bunch)) then
    !line=1111 definition='type (bunch_struct), allocatable :: bunch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='bunch_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='bunch' type='type' size='bunch_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'bunch')
    do i1 = lbound(input%bunch, 1), ubound(input%bunch, 1)
      call bunch_struct_to_json(input%bunch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine beam_struct_to_json
subroutine ellipse_beam_init_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ellipse_beam_init_struct
  implicit none
  type(json_core) :: json
  type (ellipse_beam_init_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'part_per_ellipse', int(input%part_per_ellipse))
  call json%add(json_root, 'n_ellipse', int(input%n_ellipse))
  call json%add(json_root, 'sigma_cutoff', input%sigma_cutoff)
end subroutine ellipse_beam_init_struct_to_json
subroutine kv_beam_init_struct_to_json (input, json_root, depth)
  use bmad_struct, only: kv_beam_init_struct
  implicit none
  type(json_core) :: json
  type (kv_beam_init_struct), pointer, intent(in) :: input
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
  !line=1121 definition='integer :: part_per_phi(2) = 0' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='part_per_phi' type='integer' size=None dimension='2' comment='number of particles per angle variable.' default='0'
  call json%create_array(json_list1, 'part_per_phi')
  do i1 = lbound(input%part_per_phi, 1), ubound(input%part_per_phi, 1)
    call json%create_integer(json_val, input%part_per_phi(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_i2', int(input%n_I2))
  call json%add(json_root, 'a', input%A)
end subroutine kv_beam_init_struct_to_json
subroutine grid_beam_init_struct_to_json (input, json_root, depth)
  use bmad_struct, only: grid_beam_init_struct
  implicit none
  type(json_core) :: json
  type (grid_beam_init_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_x', int(input%n_x))
  call json%add(json_root, 'n_px', int(input%n_px))
  call json%add(json_root, 'x_min', input%x_min)
  call json%add(json_root, 'x_max', input%x_max)
  call json%add(json_root, 'px_min', input%px_min)
  call json%add(json_root, 'px_max', input%px_max)
end subroutine grid_beam_init_struct_to_json
subroutine beam_init_struct_to_json (input, json_root, depth)
  use bmad_struct, only: beam_init_struct
  implicit none
  type(json_core) :: json
  type (beam_init_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'position_file', trim(input%position_file))
  !line=1137 definition="character(16) :: distribution_type(3) = 'RAN_GAUSS'" type_info=TypeInformation(type='character', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='16', static=False, target=False, value=False, volatile=False, attributes=()) name='distribution_type' type='character' size='16' dimension='3' comment='distribution type (in x-px, y-py, and z-pz planes)' default="'RAN_GAUSS'"
  call json%create_array(json_list1, 'distribution_type')
  do i1 = lbound(input%distribution_type, 1), ubound(input%distribution_type, 1)
    call json%create_string(json_val, trim(input%distribution_type(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1138 definition='real(rp) :: spin(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin' type='real' size='rp' dimension='3' comment='Spin (x, y, z)' default='0'
  call json%create_array(json_list1, 'spin')
  do i1 = lbound(input%spin, 1), ubound(input%spin, 1)
    call json%create_real(json_val, input%spin(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1139 definition='type (ellipse_beam_init_struct) :: ellipse(3) = ellipse_beam_init_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ellipse_beam_init_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ellipse' type='type' size='ellipse_beam_init_struct' dimension='3' comment='Ellipse beam distribution' default='ellipse_beam_init_struct()'
  call json%create_array(json_list1, 'ellipse')
  do i1 = lbound(input%ellipse, 1), ubound(input%ellipse, 1)
    call ellipse_beam_init_struct_to_json(input%ellipse(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call kv_beam_init_struct_to_json(input%KV, json_val, depth + 1)
  call json%rename(json_val, 'KV')
  call json%add(json_root, json_val)
  !line=1141 definition='type (grid_beam_init_struct) :: grid(3) = grid_beam_init_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='grid_beam_init_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='grid' type='type' size='grid_beam_init_struct' dimension='3' comment='Grid beam distribution' default='grid_beam_init_struct()'
  call json%create_array(json_list1, 'grid')
  do i1 = lbound(input%grid, 1), ubound(input%grid, 1)
    call grid_beam_init_struct_to_json(input%grid(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1142 definition='real(rp) :: center_jitter(6) = 0.0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='center_jitter' type='real' size='rp' dimension='6' comment='Bunch center rms jitter' default='0.0'
  call json%create_array(json_list1, 'center_jitter')
  do i1 = lbound(input%center_jitter, 1), ubound(input%center_jitter, 1)
    call json%create_real(json_val, input%center_jitter(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1143 definition='real(rp) :: emit_jitter(2)   = 0.0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='emit_jitter' type='real' size='rp' dimension='2' comment='a and b bunch emittance rms jitter normalized to emittance' default='0.0'
  call json%create_array(json_list1, 'emit_jitter')
  do i1 = lbound(input%emit_jitter, 1), ubound(input%emit_jitter, 1)
    call json%create_real(json_val, input%emit_jitter(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'sig_z_jitter', input%sig_z_jitter)
  call json%add(json_root, 'sig_pz_jitter', input%sig_pz_jitter)
  call json%add(json_root, 'n_particle', int(input%n_particle))
  call json%add(json_root, 'renorm_center', input%renorm_center)
  call json%add(json_root, 'renorm_sigma', input%renorm_sigma)
  call json%add(json_root, 'random_engine', trim(input%random_engine))
  call json%add(json_root, 'random_gauss_converter', trim(input%random_gauss_converter))
  call json%add(json_root, 'random_sigma_cutoff', input%random_sigma_cutoff)
  call json%add(json_root, 'a_norm_emit', input%a_norm_emit)
  call json%add(json_root, 'b_norm_emit', input%b_norm_emit)
  call json%add(json_root, 'a_emit', input%a_emit)
  call json%add(json_root, 'b_emit', input%b_emit)
  call json%add(json_root, 'dpz_dz', input%dPz_dz)
  !line=1157 definition='real(rp) :: center(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='center' type='real' size='rp' dimension='6' comment='Bench phase space center offset relative to reference.' default='0'
  call json%create_array(json_list1, 'center')
  do i1 = lbound(input%center, 1), ubound(input%center, 1)
    call json%create_real(json_val, input%center(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 't_offset', input%t_offset)
  call json%add(json_root, 'dt_bunch', input%dt_bunch)
  call json%add(json_root, 'sig_z', input%sig_z)
  call json%add(json_root, 'sig_pz', input%sig_pz)
  call json%add(json_root, 'bunch_charge', input%bunch_charge)
  call json%add(json_root, 'n_bunch', int(input%n_bunch))
  call json%add(json_root, 'ix_turn', int(input%ix_turn))
  call json%add(json_root, 'species', trim(input%species))
  call json%add(json_root, 'full_6d_coupling_calc', input%full_6D_coupling_calc)
  call json%add(json_root, 'use_particle_start', input%use_particle_start)
  call json%add(json_root, 'use_t_coords', input%use_t_coords)
  call json%add(json_root, 'use_z_as_t', input%use_z_as_t)
  call json%add(json_root, 'file_name', trim(input%file_name))
end subroutine beam_init_struct_to_json
subroutine bunch_params_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bunch_params_struct
  implicit none
  type(json_core) :: json
  type (bunch_params_struct), pointer, intent(in) :: input
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
  call coord_struct_to_json(input%centroid, json_val, depth + 1)
  call json%rename(json_val, 'centroid')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%c, json_val, depth + 1)
  call json%rename(json_val, 'c')
  call json%add(json_root, json_val)
  !line=1191 definition='real(rp) :: sigma(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='sigma' type='real' size='rp' dimension='6,6' comment='beam size matrix' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%sigma, 2), ubound(input%sigma, 2)
    call json%create_array(json_list1, 'sigma')
    do i1 = lbound(input%sigma, 1), ubound(input%sigma, 1)
      call json%create_real(json_val, input%sigma(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=1192 definition='real(rp) :: rel_max(7) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='rel_max' type='real' size='rp' dimension='7' comment='Max orbit relative to centroid. 7 -> time.' default='0'
  call json%create_array(json_list1, 'rel_max')
  do i1 = lbound(input%rel_max, 1), ubound(input%rel_max, 1)
    call json%create_real(json_val, input%rel_max(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1193 definition='real(rp) :: rel_min(7) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='rel_min' type='real' size='rp' dimension='7' comment='Min orbit relative to_centroid. 7 -> time.' default='0'
  call json%create_array(json_list1, 'rel_min')
  do i1 = lbound(input%rel_min, 1), ubound(input%rel_min, 1)
    call json%create_real(json_val, input%rel_min(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 't', input%t)
  call json%add(json_root, 'sigma_t', input%sigma_t)
  call json%add(json_root, 'charge_live', input%charge_live)
  call json%add(json_root, 'charge_tot', input%charge_tot)
  call json%add(json_root, 'n_particle_tot', int(input%n_particle_tot))
  call json%add(json_root, 'n_particle_live', int(input%n_particle_live))
  call json%add(json_root, 'n_particle_lost_in_ele', int(input%n_particle_lost_in_ele))
  call json%add(json_root, 'n_good_steps', int(input%n_good_steps))
  call json%add(json_root, 'n_bad_steps', int(input%n_bad_steps))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'location', int(input%location))
  call json%add(json_root, 'twiss_valid', input%twiss_valid)
end subroutine bunch_params_struct_to_json
subroutine bunch_track_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bunch_track_struct
  implicit none
  type(json_core) :: json
  type (bunch_track_struct), pointer, intent(in) :: input
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
  if (allocated(input%pt)) then
    !line=1214 definition='type (bunch_params_struct), allocatable :: pt(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='bunch_params_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='bunch_params_struct' dimension=':' comment='Array indexed from 0' default=None
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call bunch_params_struct_to_json(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ds_save', input%ds_save)
  call json%add(json_root, 'n_pt', int(input%n_pt))
end subroutine bunch_track_struct_to_json
subroutine converter_prob_pc_r_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_prob_pc_r_struct
  implicit none
  type(json_core) :: json
  type (converter_prob_pc_r_struct), pointer, intent(in) :: input
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
  if (allocated(input%pc_out)) then
    !line=1225 definition='real(rp), allocatable :: pc_out(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='pc_out' type='real' size='rp' dimension=':' comment='Grid pc_out values.' default=None
    call json%create_array(json_list1, 'pc_out')
    do i1 = lbound(input%pc_out, 1), ubound(input%pc_out, 1)
      call json%create_real(json_val, input%pc_out(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%r)) then
    !line=1226 definition='real(rp), allocatable :: r(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r' type='real' size='rp' dimension=':' comment='Grid r_out values.' default=None
    call json%create_array(json_list1, 'r')
    do i1 = lbound(input%r, 1), ubound(input%r, 1)
      call json%create_real(json_val, input%r(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%prob)) then
    !line=1227 definition='real(rp), allocatable :: prob(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='prob' type='real' size='rp' dimension=':,:' comment='Probability grid.' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%prob, 2), ubound(input%prob, 2)
      call json%create_array(json_list1, 'prob')
      do i1 = lbound(input%prob, 1), ubound(input%prob, 1)
        call json%create_real(json_val, input%prob(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%spin_z)) then
    !line=1228 definition='real(rp), allocatable :: spin_z(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_z' type='real' size='rp' dimension=':,:' comment='Z polarization grid.' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%spin_z, 2), ubound(input%spin_z, 2)
      call json%create_array(json_list1, 'spin_z')
      do i1 = lbound(input%spin_z, 1), ubound(input%spin_z, 1)
        call json%create_real(json_val, input%spin_z(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'pc_out_min', input%pc_out_min)
  call json%add(json_root, 'pc_out_max', input%pc_out_max)
  call json%add(json_root, 'integrated_prob', input%integrated_prob)
  if (allocated(input%p_norm)) then
    !line=1231 definition='real(rp), allocatable :: p_norm(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='p_norm' type='real' size='rp' dimension=':,:' comment='Normalized probability taking into account.' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%p_norm, 2), ubound(input%p_norm, 2)
      call json%create_array(json_list1, 'p_norm')
      do i1 = lbound(input%p_norm, 1), ubound(input%p_norm, 1)
        call json%create_real(json_val, input%p_norm(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%integ_pc_out)) then
    !line=1232 definition='real(rp), allocatable :: integ_pc_out(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='integ_pc_out' type='real' size='rp' dimension=':' comment='Normalized probability integrated from min pc_out up.' default=None
    call json%create_array(json_list1, 'integ_pc_out')
    do i1 = lbound(input%integ_pc_out, 1), ubound(input%integ_pc_out, 1)
      call json%create_real(json_val, input%integ_pc_out(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%integ_r)) then
    !line=1233 definition='real(rp), allocatable :: integ_r(:,:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='integ_r' type='real' size='rp' dimension=':,:' comment='' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%integ_r, 2), ubound(input%integ_r, 2)
      call json%create_array(json_list1, 'integ_r')
      do i1 = lbound(input%integ_r, 1), ubound(input%integ_r, 1)
        call json%create_real(json_val, input%integ_r(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  if (allocated(input%integ_r_ave)) then
    !line=1234 definition='real(rp), allocatable :: integ_r_ave(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='integ_r_ave' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'integ_r_ave')
    do i1 = lbound(input%integ_r_ave, 1), ubound(input%integ_r_ave, 1)
      call json%create_real(json_val, input%integ_r_ave(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine converter_prob_pc_r_struct_to_json
subroutine converter_dir_1D_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_dir_1D_struct
  implicit none
  type(json_core) :: json
  type (converter_dir_1D_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'pc_out', input%pc_out)
  !line=1243 definition='real(rp) :: poly(0:4) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='poly' type='real' size='rp' dimension='0:4' comment='param(r) = Sum: poly(i) * r^i' default='0'
  call json%create_array(json_list1, 'poly')
  do i1 = lbound(input%poly, 1), ubound(input%poly, 1)
    call json%create_real(json_val, input%poly(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine converter_dir_1D_struct_to_json
subroutine converter_dir_2D_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_dir_2D_struct
  implicit none
  type(json_core) :: json
  type (converter_dir_2D_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'k', input%k)
  !line=1248 definition='real(rp) :: poly(0:3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='poly' type='real' size='rp' dimension='0:3' comment='' default='0'
  call json%create_array(json_list1, 'poly')
  do i1 = lbound(input%poly, 1), ubound(input%poly, 1)
    call json%create_real(json_val, input%poly(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine converter_dir_2D_struct_to_json
subroutine converter_dir_coef_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_dir_coef_struct
  implicit none
  type(json_core) :: json
  type (converter_dir_coef_struct), pointer, intent(in) :: input
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
  if (allocated(input%fit_1d_r)) then
    !line=1252 definition='type (converter_dir_1D_struct), allocatable :: fit_1d_r(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='converter_dir_1D_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='fit_1d_r' type='type' size='converter_dir_1D_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'fit_1d_r')
    do i1 = lbound(input%fit_1d_r, 1), ubound(input%fit_1d_r, 1)
      call converter_dir_1D_struct_to_json(input%fit_1d_r(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call converter_dir_2D_struct_to_json(input%fit_2d_r, json_val, depth + 1)
  call json%rename(json_val, 'fit_2d_r')
  call json%add(json_root, json_val)
  call converter_dir_2D_struct_to_json(input%fit_2d_pc, json_val, depth + 1)
  call json%rename(json_val, 'fit_2d_pc')
  call json%add(json_root, json_val)
  call json%add(json_root, 'c0', input%c0)
end subroutine converter_dir_coef_struct_to_json
subroutine converter_direction_out_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_direction_out_struct
  implicit none
  type(json_core) :: json
  type (converter_direction_out_struct), pointer, intent(in) :: input
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
  call converter_dir_coef_struct_to_json(input%beta, json_val, depth + 1)
  call json%rename(json_val, 'beta')
  call json%add(json_root, json_val)
  call converter_dir_coef_struct_to_json(input%alpha_x, json_val, depth + 1)
  call json%rename(json_val, 'alpha_x')
  call json%add(json_root, json_val)
  call converter_dir_coef_struct_to_json(input%alpha_y, json_val, depth + 1)
  call json%rename(json_val, 'alpha_y')
  call json%add(json_root, json_val)
  call converter_dir_coef_struct_to_json(input%dxds_min, json_val, depth + 1)
  call json%rename(json_val, 'dxds_min')
  call json%add(json_root, json_val)
  call converter_dir_coef_struct_to_json(input%dxds_max, json_val, depth + 1)
  call json%rename(json_val, 'dxds_max')
  call json%add(json_root, json_val)
  call converter_dir_coef_struct_to_json(input%dyds_max, json_val, depth + 1)
  call json%rename(json_val, 'dyds_max')
  call json%add(json_root, json_val)
  call converter_dir_coef_struct_to_json(input%c_x, json_val, depth + 1)
  call json%rename(json_val, 'c_x')
  call json%add(json_root, json_val)
end subroutine converter_direction_out_struct_to_json
subroutine converter_sub_distribution_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_sub_distribution_struct
  implicit none
  type(json_core) :: json
  type (converter_sub_distribution_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'pc_in', input%pc_in)
  !line=1269 definition='real(rp) :: spin_in(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_in' type='real' size='rp' dimension='3' comment='' default=None
  call json%create_array(json_list1, 'spin_in')
  do i1 = lbound(input%spin_in, 1), ubound(input%spin_in, 1)
    call json%create_real(json_val, input%spin_in(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call converter_prob_pc_r_struct_to_json(input%prob_pc_r, json_val, depth + 1)
  call json%rename(json_val, 'prob_pc_r')
  call json%add(json_root, json_val)
  call converter_direction_out_struct_to_json(input%dir_out, json_val, depth + 1)
  call json%rename(json_val, 'dir_out')
  call json%add(json_root, json_val)
end subroutine converter_sub_distribution_struct_to_json
subroutine material_struct_to_json (input, json_root, depth)
  use bmad_struct, only: material_struct
  implicit none
  type(json_core) :: json
  type (material_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'species', int(input%species))
  call json%add(json_root, 'number', int(input%number))
  call json%add(json_root, 'density', input%density)
  call json%add(json_root, 'density_used', input%density_used)
  call json%add(json_root, 'area_density', input%area_density)
  call json%add(json_root, 'area_density_used', input%area_density_used)
  call json%add(json_root, 'radiation_length', input%radiation_length)
  call json%add(json_root, 'radiation_length_used', input%radiation_length_used)
end subroutine material_struct_to_json
subroutine foil_struct_to_json (input, json_root, depth)
  use bmad_struct, only: foil_struct
  implicit none
  type(json_core) :: json
  type (foil_struct), pointer, intent(in) :: input
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
  if (allocated(input%material)) then
    !line=1285 definition='type (material_struct), allocatable :: material(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='material_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='material' type='type' size='material_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'material')
    do i1 = lbound(input%material, 1), ubound(input%material, 1)
      call material_struct_to_json(input%material(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine foil_struct_to_json
subroutine converter_distribution_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_distribution_struct
  implicit none
  type(json_core) :: json
  type (converter_distribution_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'thickness', input%thickness)
  if (allocated(input%sub_dist)) then
    !line=1292 definition='type (converter_sub_distribution_struct), allocatable :: sub_dist(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='converter_sub_distribution_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='sub_dist' type='type' size='converter_sub_distribution_struct' dimension=':' comment='Distribution at various pc_in values.' default=None
    call json%create_array(json_list1, 'sub_dist')
    do i1 = lbound(input%sub_dist, 1), ubound(input%sub_dist, 1)
      call converter_sub_distribution_struct_to_json(input%sub_dist(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine converter_distribution_struct_to_json
subroutine converter_struct_to_json (input, json_root, depth)
  use bmad_struct, only: converter_struct
  implicit none
  type(json_core) :: json
  type (converter_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'species_out', int(input%species_out))
  call json%add(json_root, 'material_type', trim(input%material_type))
  if (allocated(input%dist)) then
    !line=1301 definition='type (converter_distribution_struct), allocatable :: dist(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='converter_distribution_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='dist' type='type' size='converter_distribution_struct' dimension=':' comment='Distribution at various thicknesses' default=None
    call json%create_array(json_list1, 'dist')
    do i1 = lbound(input%dist, 1), ubound(input%dist, 1)
      call converter_distribution_struct_to_json(input%dist(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine converter_struct_to_json
subroutine control_struct_to_json (input, json_root, depth)
  use bmad_struct, only: control_struct
  implicit none
  type(json_core) :: json
  type (control_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'value', input%value)
  if (allocated(input%y_knot)) then
    !line=1310 definition='real(rp), allocatable :: y_knot(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y_knot' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_knot')
    do i1 = lbound(input%y_knot, 1), ubound(input%y_knot, 1)
      call json%create_real(json_val, input%y_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%stack)) then
    !line=1311 definition='type (expression_atom_struct), allocatable :: stack(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='expression_atom_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='stack' type='type' size='expression_atom_struct' dimension=':' comment='Evaluation stack' default=None
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call expression_atom_struct_to_json(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call lat_ele_loc_struct_to_json(input%slave, json_val, depth + 1)
  call json%rename(json_val, 'slave')
  call json%add(json_root, json_val)
  call lat_ele_loc_struct_to_json(input%lord, json_val, depth + 1)
  call json%rename(json_val, 'lord')
  call json%add(json_root, json_val)
  call json%add(json_root, 'slave_name', trim(input%slave_name))
  call json%add(json_root, 'attribute', trim(input%attribute))
  call json%add(json_root, 'ix_attrib', int(input%ix_attrib))
end subroutine control_struct_to_json
subroutine control_var1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: control_var1_struct
  implicit none
  type(json_core) :: json
  type (control_var1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'old_value', input%old_value)
end subroutine control_var1_struct_to_json
subroutine control_ramp1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: control_ramp1_struct
  implicit none
  type(json_core) :: json
  type (control_ramp1_struct), pointer, intent(in) :: input
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
  if (allocated(input%y_knot)) then
    !line=1327 definition='real(rp), allocatable :: y_knot(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='y_knot' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'y_knot')
    do i1 = lbound(input%y_knot, 1), ubound(input%y_knot, 1)
      call json%create_real(json_val, input%y_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%stack)) then
    !line=1328 definition='type (expression_atom_struct), allocatable :: stack(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='expression_atom_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='stack' type='type' size='expression_atom_struct' dimension=':' comment='Evaluation stack' default=None
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call expression_atom_struct_to_json(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'attribute', trim(input%attribute))
  call json%add(json_root, 'slave_name', trim(input%slave_name))
  call json%add(json_root, 'is_controller', input%is_controller)
end subroutine control_ramp1_struct_to_json
subroutine ramper_lord_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ramper_lord_struct
  implicit none
  type(json_core) :: json
  type (ramper_lord_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_con', int(input%ix_con))
  if (associated(input%attrib_ptr)) then
    call json%add(json_root, 'attrib_ptr', input%attrib_ptr)
  endif
end subroutine ramper_lord_struct_to_json
subroutine controller_struct_to_json (input, json_root, depth)
  use bmad_struct, only: controller_struct
  implicit none
  type(json_core) :: json
  type (controller_struct), pointer, intent(in) :: input
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
  if (allocated(input%var)) then
    !line=1344 definition='type (control_var1_struct), allocatable :: var(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='control_var1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='var' type='type' size='control_var1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'var')
    do i1 = lbound(input%var, 1), ubound(input%var, 1)
      call control_var1_struct_to_json(input%var(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ramp)) then
    !line=1345 definition='type (control_ramp1_struct), allocatable :: ramp(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='control_ramp1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ramp' type='type' size='control_ramp1_struct' dimension=':' comment='For ramper lord elements' default=None
    call json%create_array(json_list1, 'ramp')
    do i1 = lbound(input%ramp, 1), ubound(input%ramp, 1)
      call control_ramp1_struct_to_json(input%ramp(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ramper_lord)) then
    !line=1346 definition='type (ramper_lord_struct), allocatable :: ramper_lord(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ramper_lord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ramper_lord' type='type' size='ramper_lord_struct' dimension=':' comment='Ramper lord info for this slave' default=None
    call json%create_array(json_list1, 'ramper_lord')
    do i1 = lbound(input%ramper_lord, 1), ubound(input%ramper_lord, 1)
      call ramper_lord_struct_to_json(input%ramper_lord(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%x_knot)) then
    !line=1347 definition='real(rp), allocatable :: x_knot(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='x_knot' type='real' size='rp' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'x_knot')
    do i1 = lbound(input%x_knot, 1), ubound(input%x_knot, 1)
      call json%create_real(json_val, input%x_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine controller_struct_to_json
subroutine ele_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ele_struct
  use forest_json, only: fibre_to_json
  implicit none
  type(json_core) :: json
  type (ele_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'alias', trim(input%alias))
  call json%add(json_root, 'component_name', trim(input%component_name))
  if (associated(input%descrip)) then
    call json%add(json_root, 'descrip', trim(input%descrip))
  endif
  call twiss_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  call xy_disp_struct_to_json(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call xy_disp_struct_to_json(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  if (associated(input%ac_kick)) then
    call ac_kicker_struct_to_json(input%ac_kick, json_val, depth + 1)
    call json%rename(json_val, 'ac_kick')
    call json%add(json_root, json_val)
  endif
  call bookkeeping_state_struct_to_json(input%bookkeeping_state, json_val, depth + 1)
  call json%rename(json_val, 'bookkeeping_state')
  call json%add(json_root, json_val)
  ! config skip_members: ele_struct%branch (type, Pointer to branch containing element.)
  if (associated(input%control)) then
    call controller_struct_to_json(input%control, json_val, depth + 1)
    call json%rename(json_val, 'control')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: ele_struct%converter (type, EG: Positron converter in linac.)
  ! config skip_members: ele_struct%foil (type, )
  ! config skip_members: ele_struct%lord (type, Pointer to a slice lord.)
  if (associated(input%ptc_fibre)) then
    call fibre_to_json(input%ptc_fibre, json_val, depth + 1)
    call json%rename(json_val, 'ptc_fibre')
    call json%add(json_root, json_val)
  endif
  call floor_position_struct_to_json(input%floor, json_val, depth + 1)
  call json%rename(json_val, 'floor')
  call json%add(json_root, json_val)
  if (associated(input%high_energy_space_charge)) then
    call high_energy_space_charge_struct_to_json(input%high_energy_space_charge, json_val, depth + 1)
    call json%rename(json_val, 'high_energy_space_charge')
    call json%add(json_root, json_val)
  endif
  if (associated(input%mode3)) then
    call mode3_struct_to_json(input%mode3, json_val, depth + 1)
    call json%rename(json_val, 'mode3')
    call json%add(json_root, json_val)
  endif
  if (associated(input%photon)) then
    call photon_element_struct_to_json(input%photon, json_val, depth + 1)
    call json%rename(json_val, 'photon')
    call json%add(json_root, json_val)
  endif
  ! config skip_members: ele_struct%multipole_cache (type, )
  if (associated(input%rad_map)) then
    call rad_map_ele_struct_to_json(input%rad_map, json_val, depth + 1)
    call json%rename(json_val, 'rad_map')
    call json%add(json_root, json_val)
  endif
  !line=1393 definition='type (taylor_struct) :: taylor(6) = taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='taylor' type='type' size='taylor_struct' dimension='6' comment='Phase space Taylor map.' default='taylor_struct()'
  call json%create_array(json_list1, 'taylor')
  do i1 = lbound(input%taylor, 1), ubound(input%taylor, 1)
    call taylor_struct_to_json(input%taylor(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1394 definition='real(rp) :: spin_taylor_ref_orb_in(6) = real_garbage$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_taylor_ref_orb_in' type='real' size='rp' dimension='6' comment='' default='real_garbage$'
  call json%create_array(json_list1, 'spin_taylor_ref_orb_in')
  do i1 = lbound(input%spin_taylor_ref_orb_in, 1), ubound(input%spin_taylor_ref_orb_in, 1)
    call json%create_real(json_val, input%spin_taylor_ref_orb_in(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1395 definition='type (taylor_struct) :: spin_taylor(0:3) = taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_taylor' type='type' size='taylor_struct' dimension='0:3' comment='Quaternion Spin Taylor map.' default='taylor_struct()'
  call json%create_array(json_list1, 'spin_taylor')
  do i1 = lbound(input%spin_taylor, 1), ubound(input%spin_taylor, 1)
    call taylor_struct_to_json(input%spin_taylor(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%wake)) then
    call wake_struct_to_json(input%wake, json_val, depth + 1)
    call json%rename(json_val, 'wake')
    call json%add(json_root, json_val)
  endif
  if (associated(input%wall3d)) then
    !line=1397 definition='type (wall3d_struct), pointer :: wall3d(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='wall3d_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='wall3d' type='type' size='wall3d_struct' dimension=':' comment='Chamber or capillary wall' default='null()'
    call json%create_array(json_list1, 'wall3d')
    do i1 = lbound(input%wall3d, 1), ubound(input%wall3d, 1)
      call wall3d_struct_to_json(input%wall3d(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%cartesian_map)) then
    !line=1398 definition='type (cartesian_map_struct), pointer :: cartesian_map(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='cartesian_map_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='cartesian_map' type='type' size='cartesian_map_struct' dimension=':' comment='Used to define E/M fields' default='null()'
    call json%create_array(json_list1, 'cartesian_map')
    do i1 = lbound(input%cartesian_map, 1), ubound(input%cartesian_map, 1)
      call cartesian_map_struct_to_json(input%cartesian_map(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%cylindrical_map)) then
    !line=1399 definition='type (cylindrical_map_struct), pointer :: cylindrical_map(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='cylindrical_map_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='cylindrical_map' type='type' size='cylindrical_map_struct' dimension=':' comment='Used to define E/M fields' default='null()'
    call json%create_array(json_list1, 'cylindrical_map')
    do i1 = lbound(input%cylindrical_map, 1), ubound(input%cylindrical_map, 1)
      call cylindrical_map_struct_to_json(input%cylindrical_map(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%gen_grad_map)) then
    !line=1400 definition='type (gen_grad_map_struct), pointer :: gen_grad_map(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='gen_grad_map_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='gen_grad_map' type='type' size='gen_grad_map_struct' dimension=':' comment='Used to define E/M fields.' default='null()'
    call json%create_array(json_list1, 'gen_grad_map')
    do i1 = lbound(input%gen_grad_map, 1), ubound(input%gen_grad_map, 1)
      call gen_grad_map_struct_to_json(input%gen_grad_map(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%grid_field)) then
    !line=1401 definition='type (grid_field_struct), pointer :: grid_field(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='grid_field_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='grid_field' type='type' size='grid_field_struct' dimension=':' comment='Used to define E/M fields.' default='null()'
    call json%create_array(json_list1, 'grid_field')
    do i1 = lbound(input%grid_field, 1), ubound(input%grid_field, 1)
      call grid_field_struct_to_json(input%grid_field(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call coord_struct_to_json(input%map_ref_orb_in, json_val, depth + 1)
  call json%rename(json_val, 'map_ref_orb_in')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%map_ref_orb_out, json_val, depth + 1)
  call json%rename(json_val, 'map_ref_orb_out')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%time_ref_orb_in, json_val, depth + 1)
  call json%rename(json_val, 'time_ref_orb_in')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%time_ref_orb_out, json_val, depth + 1)
  call json%rename(json_val, 'time_ref_orb_out')
  call json%add(json_root, json_val)
  !line=1406 definition='real(rp) :: value(num_ele_attrib$) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='value' type='real' size='rp' dimension='num_ele_attrib$' comment='attribute values.' default='0'
  call json%create_array(json_list1, 'value')
  do i1 = lbound(input%value, 1), ubound(input%value, 1)
    call json%create_real(json_val, input%value(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1407 definition='real(rp) :: old_value(num_ele_attrib$) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='old_value' type='real' size='rp' dimension='num_ele_attrib$' comment='Used to see if %value(:) array has changed.' default='0'
  call json%create_array(json_list1, 'old_value')
  do i1 = lbound(input%old_value, 1), ubound(input%old_value, 1)
    call json%create_real(json_val, input%old_value(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1408 definition='real(rp) :: spin_q(0:3,0:6) = real_garbage$' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='spin_q' type='real' size='rp' dimension='0:3,0:6' comment='0th and 1st order Spin transport quaternion.' default='real_garbage$'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%spin_q, 2), ubound(input%spin_q, 2)
    call json%create_array(json_list1, 'spin_q')
    do i1 = lbound(input%spin_q, 1), ubound(input%spin_q, 1)
      call json%create_real(json_val, input%spin_q(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=1409 definition='real(rp) :: vec0(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec0' type='real' size='rp' dimension='6' comment='0th order transport vector.' default='0'
  call json%create_array(json_list1, 'vec0')
  do i1 = lbound(input%vec0, 1), ubound(input%vec0, 1)
    call json%create_real(json_val, input%vec0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1410 definition='real(rp) :: mat6(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='mat6' type='real' size='rp' dimension='6,6' comment='1st order transport matrix.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mat6, 2), ubound(input%mat6, 2)
    call json%create_array(json_list1, 'mat6')
    do i1 = lbound(input%mat6, 1), ubound(input%mat6, 1)
      call json%create_real(json_val, input%mat6(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=1411 definition='real(rp) :: c_mat(2,2) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='c_mat' type='real' size='rp' dimension='2,2' comment='2x2 C coupling matrix' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%c_mat, 2), ubound(input%c_mat, 2)
    call json%create_array(json_list1, 'c_mat')
    do i1 = lbound(input%c_mat, 1), ubound(input%c_mat, 1)
      call json%create_real(json_val, input%c_mat(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'gamma_c', input%gamma_c)
  call json%add(json_root, 's_start', input%s_start)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'ref_time', input%ref_time)
  if (associated(input%a_pole)) then
    !line=1416 definition='real(rp), pointer :: a_pole(:) => null()' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='a_pole' type='real' size='rp' dimension=':' comment='knl for multipole elements.' default='null()'
    call json%create_array(json_list1, 'a_pole')
    do i1 = lbound(input%a_pole, 1), ubound(input%a_pole, 1)
      call json%create_real(json_val, input%a_pole(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%b_pole)) then
    !line=1417 definition='real(rp), pointer :: b_pole(:) => null()' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='b_pole' type='real' size='rp' dimension=':' comment='tilt for multipole elements.' default='null()'
    call json%create_array(json_list1, 'b_pole')
    do i1 = lbound(input%b_pole, 1), ubound(input%b_pole, 1)
      call json%create_real(json_val, input%b_pole(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%a_pole_elec)) then
    !line=1418 definition='real(rp), pointer :: a_pole_elec(:) => null()' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='a_pole_elec' type='real' size='rp' dimension=':' comment='Electrostatic multipoles. ksnl for multipole elements.' default='null()'
    call json%create_array(json_list1, 'a_pole_elec')
    do i1 = lbound(input%a_pole_elec, 1), ubound(input%a_pole_elec, 1)
      call json%create_real(json_val, input%a_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%b_pole_elec)) then
    !line=1419 definition='real(rp), pointer :: b_pole_elec(:) => null()' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='b_pole_elec' type='real' size='rp' dimension=':' comment='Electrostatic multipoles.' default='null()'
    call json%create_array(json_list1, 'b_pole_elec')
    do i1 = lbound(input%b_pole_elec, 1), ubound(input%b_pole_elec, 1)
      call json%create_real(json_val, input%b_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%custom)) then
    !line=1420 definition='real(rp), pointer :: custom(:) => null()' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='custom' type='real' size='rp' dimension=':' comment='Custom attributes.' default='null()'
    call json%create_array(json_list1, 'custom')
    do i1 = lbound(input%custom, 1), ubound(input%custom, 1)
      call json%create_real(json_val, input%custom(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%r)) then
    !line=1421 definition='real(rp), pointer :: r(:,:,:) => null()' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r' type='real' size='rp' dimension=':,:,:' comment='For general use. Not used by Bmad.' default='null()'
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%r, 3), ubound(input%r, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%r, 2), ubound(input%r, 2)
        call json%create_array(json_list1, 'r')
        do i1 = lbound(input%r, 1), ubound(input%r, 1)
          call json%create_real(json_val, input%r(i1, i2, i3), '')
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
  call json%add(json_root, 'key', int(input%key))
  call json%add(json_root, 'sub_key', int(input%sub_key))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'lord_status', int(input%lord_status))
  call json%add(json_root, 'n_slave', int(input%n_slave))
  call json%add(json_root, 'n_slave_field', int(input%n_slave_field))
  call json%add(json_root, 'ix1_slave', int(input%ix1_slave))
  call json%add(json_root, 'slave_status', int(input%slave_status))
  call json%add(json_root, 'n_lord', int(input%n_lord))
  call json%add(json_root, 'n_lord_field', int(input%n_lord_field))
  call json%add(json_root, 'n_lord_ramper', int(input%n_lord_ramper))
  call json%add(json_root, 'ic1_lord', int(input%ic1_lord))
  call json%add(json_root, 'ix_pointer', int(input%ix_pointer))
  call json%add(json_root, 'ixx', int(input%ixx))
  call json%add(json_root, 'iyy', int(input%iyy))
  call json%add(json_root, 'izz', int(input%izz))
  call json%add(json_root, 'mat6_calc_method', int(input%mat6_calc_method))
  call json%add(json_root, 'tracking_method', int(input%tracking_method))
  call json%add(json_root, 'spin_tracking_method', int(input%spin_tracking_method))
  call json%add(json_root, 'csr_method', int(input%csr_method))
  call json%add(json_root, 'space_charge_method', int(input%space_charge_method))
  call json%add(json_root, 'ptc_integration_type', int(input%ptc_integration_type))
  call json%add(json_root, 'field_calc', int(input%field_calc))
  call json%add(json_root, 'aperture_at', int(input%aperture_at))
  call json%add(json_root, 'aperture_type', int(input%aperture_type))
  call json%add(json_root, 'ref_species', int(input%ref_species))
  call json%add(json_root, 'orientation', int(input%orientation))
  call json%add(json_root, 'symplectify', input%symplectify)
  call json%add(json_root, 'mode_flip', input%mode_flip)
  call json%add(json_root, 'multipoles_on', input%multipoles_on)
  call json%add(json_root, 'scale_multipoles', input%scale_multipoles)
  call json%add(json_root, 'taylor_map_includes_offsets', input%taylor_map_includes_offsets)
  call json%add(json_root, 'field_master', input%field_master)
  call json%add(json_root, 'is_on', input%is_on)
  call json%add(json_root, 'logic', input%logic)
  call json%add(json_root, 'bmad_logic', input%bmad_logic)
  call json%add(json_root, 'select', input%select)
  call json%add(json_root, 'offset_moves_aperture', input%offset_moves_aperture)
end subroutine ele_struct_to_json
subroutine lat_param_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_param_struct
  implicit none
  type(json_core) :: json
  type (lat_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'n_part', input%n_part)
  call json%add(json_root, 'total_length', input%total_length)
  call json%add(json_root, 'unstable_factor', input%unstable_factor)
  !line=1478 definition='real(rp) :: t1_with_RF(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='t1_with_RF' type='real' size='rp' dimension='6,6' comment='Full 1-turn matrix with RF on.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%t1_with_RF, 2), ubound(input%t1_with_RF, 2)
    call json%create_array(json_list1, 't1_with_rf')
    do i1 = lbound(input%t1_with_RF, 1), ubound(input%t1_with_RF, 1)
      call json%create_real(json_val, input%t1_with_RF(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=1479 definition='real(rp) :: t1_no_RF(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='t1_no_RF' type='real' size='rp' dimension='6,6' comment='Full 1-turn matrix with RF off.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%t1_no_RF, 2), ubound(input%t1_no_RF, 2)
    call json%create_array(json_list1, 't1_no_rf')
    do i1 = lbound(input%t1_no_RF, 1), ubound(input%t1_no_RF, 1)
      call json%create_real(json_val, input%t1_no_RF(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'spin_tune', input%spin_tune)
  call json%add(json_root, 'particle', int(input%particle))
  call json%add(json_root, 'default_tracking_species', int(input%default_tracking_species))
  call json%add(json_root, 'geometry', int(input%geometry))
  call json%add(json_root, 'ixx', int(input%ixx))
  call json%add(json_root, 'stable', input%stable)
  call json%add(json_root, 'live_branch', input%live_branch)
  call json%add(json_root, 'g1_integral', input%g1_integral)
  call json%add(json_root, 'g2_integral', input%g2_integral)
  call json%add(json_root, 'g3_integral', input%g3_integral)
  call bookkeeping_state_struct_to_json(input%bookkeeping_state, json_val, depth + 1)
  call json%rename(json_val, 'bookkeeping_state')
  call json%add(json_root, json_val)
  call beam_init_struct_to_json(input%beam_init, json_val, depth + 1)
  call json%rename(json_val, 'beam_init')
  call json%add(json_root, json_val)
end subroutine lat_param_struct_to_json
subroutine ptc_layout_pointer_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ptc_layout_pointer_struct
  use forest_json, only: layout_to_json
  implicit none
  type(json_core) :: json
  type (ptc_layout_pointer_struct), pointer, intent(in) :: input
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
  if (associated(input%ptr)) then
    call layout_to_json(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
end subroutine ptc_layout_pointer_struct_to_json
subroutine ptc_branch1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ptc_branch1_struct
  use forest_json, only: layout_to_json
  implicit none
  type(json_core) :: json
  type (ptc_branch1_struct), pointer, intent(in) :: input
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
  if (allocated(input%m_u_layout)) then
    !line=1504 definition='type (ptc_layout_pointer_struct), allocatable :: m_u_layout(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ptc_layout_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='m_u_layout' type='type' size='ptc_layout_pointer_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'm_u_layout')
    do i1 = lbound(input%m_u_layout, 1), ubound(input%m_u_layout, 1)
      call ptc_layout_pointer_struct_to_json(input%m_u_layout(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%m_t_layout)) then
    call layout_to_json(input%m_t_layout, json_val, depth + 1)
    call json%rename(json_val, 'm_t_layout')
    call json%add(json_root, json_val)
  endif
end subroutine ptc_branch1_struct_to_json
subroutine mode_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: mode_info_struct
  implicit none
  type(json_core) :: json
  type (mode_info_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'stable', input%stable)
  call json%add(json_root, 'tune', input%tune)
  call json%add(json_root, 'emit', input%emit)
  call json%add(json_root, 'chrom', input%chrom)
  call json%add(json_root, 'sigma', input%sigma)
  call json%add(json_root, 'sigmap', input%sigmap)
end subroutine mode_info_struct_to_json
subroutine resonance_h_struct_to_json (input, json_root, depth)
  use bmad_struct, only: resonance_h_struct
  implicit none
  type(json_core) :: json
  type (resonance_h_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'id', trim(input%id))
  call complex_to_json(input%c_val, json_list1, depth+1)
  call json%rename(json_list1, 'c_val')
  call json%add(json_root, json_list1)
end subroutine resonance_h_struct_to_json
subroutine bmad_normal_form_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bmad_normal_form_struct
  implicit none
  type(json_core) :: json
  type (bmad_normal_form_struct), pointer, intent(in) :: input
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
  if (associated(input%ele_origin)) then
    call ele_struct_to_json(input%ele_origin, json_val, depth + 1)
    call json%rename(json_val, 'ele_origin')
    call json%add(json_root, json_val)
  endif
  !line=1533 definition='type (taylor_struct) :: M(6) = taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='M' type='type' size='taylor_struct' dimension='6' comment='One-turn taylor map: M = A o N o A_inv, N = exp(:h:)' default='taylor_struct()'
  call json%create_array(json_list1, 'm')
  do i1 = lbound(input%M, 1), ubound(input%M, 1)
    call taylor_struct_to_json(input%M(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1534 definition='type (taylor_struct) :: A(6) = taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='A' type='type' size='taylor_struct' dimension='6' comment='Map from Floquet -> Lab coordinates' default='taylor_struct()'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%A, 1), ubound(input%A, 1)
    call taylor_struct_to_json(input%A(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1535 definition='type (taylor_struct) :: A_inv(6) = taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='A_inv' type='type' size='taylor_struct' dimension='6' comment='Map from Lab -> Floquet coordinates' default='taylor_struct()'
  call json%create_array(json_list1, 'a_inv')
  do i1 = lbound(input%A_inv, 1), ubound(input%A_inv, 1)
    call taylor_struct_to_json(input%A_inv(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1536 definition='type (taylor_struct) :: dhdj(6) = taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='dhdj' type='type' size='taylor_struct' dimension='6' comment='Nonlinear tune function operating on Floquet coordinates' default='taylor_struct()'
  call json%create_array(json_list1, 'dhdj')
  do i1 = lbound(input%dhdj, 1), ubound(input%dhdj, 1)
    call taylor_struct_to_json(input%dhdj(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1537 definition='type (complex_taylor_struct) :: F(6) = complex_taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='complex_taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='F' type='type' size='complex_taylor_struct' dimension='6' comment='Vector field factorization in phasor basis:' default='complex_taylor_struct()'
  call json%create_array(json_list1, 'f')
  do i1 = lbound(input%F, 1), ubound(input%F, 1)
    call complex_taylor_struct_to_json(input%F(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1538 definition='type (complex_taylor_struct) :: L(6) = complex_taylor_struct()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='complex_taylor_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='L' type='type' size='complex_taylor_struct' dimension='6' comment='L component' default='complex_taylor_struct()'
  call json%create_array(json_list1, 'l')
  do i1 = lbound(input%L, 1), ubound(input%L, 1)
    call complex_taylor_struct_to_json(input%L(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%h)) then
    !line=1539 definition='type (resonance_h_struct), allocatable :: h(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='resonance_h_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='h' type='type' size='resonance_h_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'h')
    do i1 = lbound(input%h, 1), ubound(input%h, 1)
      call resonance_h_struct_to_json(input%h(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine bmad_normal_form_struct_to_json
subroutine ptc_normal_form_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ptc_normal_form_struct
  use forest_json, only: c_normal_form_to_json, c_quaternion_to_json, c_taylor_to_json, internal_state_to_json, probe_8_to_json
  implicit none
  type(json_core) :: json
  type (ptc_normal_form_struct), pointer, intent(in) :: input
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
  if (associated(input%ele_origin)) then
    call ele_struct_to_json(input%ele_origin, json_val, depth + 1)
    call json%rename(json_val, 'ele_origin')
    call json%add(json_root, json_val)
  endif
  call probe_8_to_json(input%one_turn_map, json_val, depth + 1)
  call json%rename(json_val, 'one_turn_map')
  call json%add(json_root, json_val)
  !line=1545 definition='real(rp) orb0(6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='orb0' type='real' size='rp' dimension='6' comment='Closed orbit at element.' default=None
  call json%create_array(json_list1, 'orb0')
  do i1 = lbound(input%orb0, 1), ubound(input%orb0, 1)
    call json%create_real(json_val, input%orb0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call c_normal_form_to_json(input%normal_form, json_val, depth + 1)
  call json%rename(json_val, 'normal_form')
  call json%add(json_root, json_val)
  !line=1547 definition='type (c_taylor) phase(3)' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='c_taylor', static=False, target=False, value=False, volatile=False, attributes=()) name='phase' type='type' size='c_taylor' dimension='3' comment='Phase/chromaticity maps' default=None
  call json%create_array(json_list1, 'phase')
  do i1 = lbound(input%phase, 1), ubound(input%phase, 1)
    call c_taylor_to_json(input%phase(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call c_taylor_to_json(input%path_length, json_val, depth + 1)
  call json%rename(json_val, 'path_length')
  call json%add(json_root, json_val)
  call c_taylor_to_json(input%spin_tune, json_val, depth + 1)
  call json%rename(json_val, 'spin_tune')
  call json%add(json_root, json_val)
  call c_quaternion_to_json(input%isf, json_val, depth + 1)
  call json%rename(json_val, 'isf')
  call json%add(json_root, json_val)
  call internal_state_to_json(input%state, json_val, depth + 1)
  call json%rename(json_val, 'state')
  call json%add(json_root, json_val)
  call json%add(json_root, 'valid_map', input%valid_map)
end subroutine ptc_normal_form_struct_to_json
subroutine branch_struct_to_json (input, json_root, depth)
  use bmad_struct, only: branch_struct
  implicit none
  type(json_core) :: json
  type (branch_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_from_branch', int(input%ix_from_branch))
  call json%add(json_root, 'ix_from_ele', int(input%ix_from_ele))
  call json%add(json_root, 'ix_to_ele', int(input%ix_to_ele))
  call json%add(json_root, 'n_ele_track', int(input%n_ele_track))
  call json%add(json_root, 'n_ele_max', int(input%n_ele_max))
  ! config skip_members: branch_struct%lat (type, )
  call mode_info_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call mode_info_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call mode_info_struct_to_json(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  if (associated(input%ele)) then
    !line=1567 definition='type (ele_struct), pointer :: ele(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='ele_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='ele_struct' dimension=':' comment='' default='null()'
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call ele_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call lat_param_struct_to_json(input%param, json_val, depth + 1)
  call json%rename(json_val, 'param')
  call json%add(json_root, json_val)
  if (associated(input%wall3d)) then
    !line=1569 definition='type (wall3d_struct), pointer :: wall3d(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='wall3d_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='wall3d' type='type' size='wall3d_struct' dimension=':' comment='' default='null()'
    call json%create_array(json_list1, 'wall3d')
    do i1 = lbound(input%wall3d, 1), ubound(input%wall3d, 1)
      call wall3d_struct_to_json(input%wall3d(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! config skip_members: branch_struct%ptc (type, Pointer to layout. Note: ptc info not transferred with "branch1 = branch2" set.)
end subroutine branch_struct_to_json
subroutine pre_tracker_struct_to_json (input, json_root, depth)
  use bmad_struct, only: pre_tracker_struct
  implicit none
  type(json_core) :: json
  type (pre_tracker_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'who', int(input%who))
  call json%add(json_root, 'ix_ele_start', int(input%ix_ele_start))
  call json%add(json_root, 'ix_ele_end', int(input%ix_ele_end))
  call json%add(json_root, 'input_file', trim(input%input_file))
end subroutine pre_tracker_struct_to_json
subroutine lat_struct_to_json (input, json_root, depth)
  use bmad_struct, only: lat_struct
  implicit none
  type(json_core) :: json
  type (lat_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'use_name', trim(input%use_name))
  call json%add(json_root, 'lattice', trim(input%lattice))
  call json%add(json_root, 'machine', trim(input%machine))
  call json%add(json_root, 'input_file_name', trim(input%input_file_name))
  call json%add(json_root, 'title', trim(input%title))
  if (allocated(input%print_str)) then
    !line=1598 definition='character(100), allocatable :: print_str(:)' type_info=TypeInformation(type='character', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='100', static=False, target=False, value=False, volatile=False, attributes=()) name='print_str' type='character' size='100' dimension=':' comment='Saved print statements.' default=None
    call json%create_array(json_list1, 'print_str')
    do i1 = lbound(input%print_str, 1), ubound(input%print_str, 1)
      call json%create_string(json_val, trim(input%print_str(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%constant)) then
    !line=1599 definition='type (expression_atom_struct), allocatable :: constant(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='expression_atom_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='constant' type='type' size='expression_atom_struct' dimension=':' comment='Constants defined in the lattice' default=None
    call json%create_array(json_list1, 'constant')
    do i1 = lbound(input%constant, 1), ubound(input%constant, 1)
      call expression_atom_struct_to_json(input%constant(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%a)) then
    call mode_info_struct_to_json(input%a, json_val, depth + 1)
    call json%rename(json_val, 'a')
    call json%add(json_root, json_val)
  endif
  if (associated(input%b)) then
    call mode_info_struct_to_json(input%b, json_val, depth + 1)
    call json%rename(json_val, 'b')
    call json%add(json_root, json_val)
  endif
  if (associated(input%z)) then
    call mode_info_struct_to_json(input%z, json_val, depth + 1)
    call json%rename(json_val, 'z')
    call json%add(json_root, json_val)
  endif
  if (associated(input%param)) then
    call lat_param_struct_to_json(input%param, json_val, depth + 1)
    call json%rename(json_val, 'param')
    call json%add(json_root, json_val)
  endif
  call bookkeeping_state_struct_to_json(input%lord_state, json_val, depth + 1)
  call json%rename(json_val, 'lord_state')
  call json%add(json_root, json_val)
  call ele_struct_to_json(input%ele_init, json_val, depth + 1)
  call json%rename(json_val, 'ele_init')
  call json%add(json_root, json_val)
  if (associated(input%ele)) then
    !line=1604 definition='type (ele_struct), pointer ::  ele(:) => null()' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='ele_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='ele_struct' dimension=':' comment='Array of elements [=> branch(0)].' default='null()'
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call ele_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%branch)) then
    !line=1605 definition='type (branch_struct), allocatable :: branch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='branch_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='branch' type='type' size='branch_struct' dimension=':' comment='Branch(0:) array' default=None
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call branch_struct_to_json(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%control)) then
    !line=1606 definition='type (control_struct), allocatable :: control(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='control_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='control' type='type' size='control_struct' dimension=':' comment='Control list' default=None
    call json%create_array(json_list1, 'control')
    do i1 = lbound(input%control, 1), ubound(input%control, 1)
      call control_struct_to_json(input%control(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call coord_struct_to_json(input%particle_start, json_val, depth + 1)
  call json%rename(json_val, 'particle_start')
  call json%add(json_root, json_val)
  call beam_init_struct_to_json(input%beam_init, json_val, depth + 1)
  call json%rename(json_val, 'beam_init')
  call json%add(json_root, json_val)
  call pre_tracker_struct_to_json(input%pre_tracker, json_val, depth + 1)
  call json%rename(json_val, 'pre_tracker')
  call json%add(json_root, json_val)
  ! config skip_members: lat_struct%nametable (type, For quick searching by element name.)
  if (allocated(input%custom)) then
    !line=1611 definition='real(rp), allocatable :: custom(:)' type_info=TypeInformation(type='real', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='custom' type='real' size='rp' dimension=':' comment='Custom attributes.' default=None
    call json%create_array(json_list1, 'custom')
    do i1 = lbound(input%custom, 1), ubound(input%custom, 1)
      call json%create_real(json_val, input%custom(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'version', int(input%version))
  if (associated(input%n_ele_track)) then
    call json%add(json_root, 'n_ele_track', int(input%n_ele_track))
  endif
  if (associated(input%n_ele_max)) then
    call json%add(json_root, 'n_ele_max', int(input%n_ele_max))
  endif
  call json%add(json_root, 'n_control_max', int(input%n_control_max))
  call json%add(json_root, 'n_ic_max', int(input%n_ic_max))
  call json%add(json_root, 'input_taylor_order', int(input%input_taylor_order))
  if (allocated(input%ic)) then
    !line=1618 definition='integer, allocatable :: ic(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ic' type='integer' size=None dimension=':' comment='Index to %control(:) from slaves.' default=None
    call json%create_array(json_list1, 'ic')
    do i1 = lbound(input%ic, 1), ubound(input%ic, 1)
      call json%create_integer(json_val, input%ic(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'photon_type', int(input%photon_type))
  call json%add(json_root, 'creation_hash', int(input%creation_hash))
  call json%add(json_root, 'ramper_slave_bookkeeping', int(input%ramper_slave_bookkeeping))
end subroutine lat_struct_to_json
subroutine anormal_mode_struct_to_json (input, json_root, depth)
  use bmad_struct, only: anormal_mode_struct
  implicit none
  type(json_core) :: json
  type (anormal_mode_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'emittance', input%emittance)
  call json%add(json_root, 'emittance_no_vert', input%emittance_no_vert)
  !line=1924 definition='real(rp) :: synch_int(4:6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='synch_int' type='real' size='rp' dimension='4:6' comment='Synchrotron integrals' default='0'
  call json%create_array(json_list1, 'synch_int')
  do i1 = lbound(input%synch_int, 1), ubound(input%synch_int, 1)
    call json%create_real(json_val, input%synch_int(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'j_damp', input%j_damp)
  call json%add(json_root, 'alpha_damp', input%alpha_damp)
  call json%add(json_root, 'chrom', input%chrom)
  call json%add(json_root, 'tune', input%tune)
end subroutine anormal_mode_struct_to_json
subroutine linac_normal_mode_struct_to_json (input, json_root, depth)
  use bmad_struct, only: linac_normal_mode_struct
  implicit none
  type(json_core) :: json
  type (linac_normal_mode_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'i2_e4', input%i2_E4)
  call json%add(json_root, 'i3_e7', input%i3_E7)
  call json%add(json_root, 'i5a_e6', input%i5a_E6)
  call json%add(json_root, 'i5b_e6', input%i5b_E6)
  call json%add(json_root, 'sig_e1', input%sig_E1)
  call json%add(json_root, 'a_emittance_end', input%a_emittance_end)
  call json%add(json_root, 'b_emittance_end', input%b_emittance_end)
end subroutine linac_normal_mode_struct_to_json
subroutine normal_modes_struct_to_json (input, json_root, depth)
  use bmad_struct, only: normal_modes_struct
  implicit none
  type(json_core) :: json
  type (normal_modes_struct), pointer, intent(in) :: input
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
  !line=1942 definition='real(rp) :: synch_int(0:3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='synch_int' type='real' size='rp' dimension='0:3' comment='Synchrotron integrals I0, I1, I2, and I3' default='0'
  call json%create_array(json_list1, 'synch_int')
  do i1 = lbound(input%synch_int, 1), ubound(input%synch_int, 1)
    call json%create_real(json_val, input%synch_int(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'sige_e', input%sigE_E)
  call json%add(json_root, 'sig_z', input%sig_z)
  call json%add(json_root, 'e_loss', input%e_loss)
  call json%add(json_root, 'rf_voltage', input%rf_voltage)
  call json%add(json_root, 'pz_aperture', input%pz_aperture)
  call json%add(json_root, 'pz_average', input%pz_average)
  call json%add(json_root, 'momentum_compaction', input%momentum_compaction)
  call json%add(json_root, 'dpz_damp', input%dpz_damp)
  call anormal_mode_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call anormal_mode_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call anormal_mode_struct_to_json(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  call linac_normal_mode_struct_to_json(input%lin, json_val, depth + 1)
  call json%rename(json_val, 'lin')
  call json%add(json_root, json_val)
end subroutine normal_modes_struct_to_json
subroutine em_field_struct_to_json (input, json_root, depth)
  use bmad_struct, only: em_field_struct
  implicit none
  type(json_core) :: json
  type (em_field_struct), pointer, intent(in) :: input
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
  !line=1973 definition='real(rp) :: E(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='E' type='real' size='rp' dimension='3' comment='electric field.' default='0'
  call json%create_array(json_list1, 'e')
  do i1 = lbound(input%E, 1), ubound(input%E, 1)
    call json%create_real(json_val, input%E(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1974 definition='real(rp) :: B(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='B' type='real' size='rp' dimension='3' comment='magnetic field.' default='0'
  call json%create_array(json_list1, 'b')
  do i1 = lbound(input%B, 1), ubound(input%B, 1)
    call json%create_real(json_val, input%B(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1975 definition='real(rp) :: dE(3,3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dE' type='real' size='rp' dimension='3,3' comment='electric field gradient.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%dE, 2), ubound(input%dE, 2)
    call json%create_array(json_list1, 'de')
    do i1 = lbound(input%dE, 1), ubound(input%dE, 1)
      call json%create_real(json_val, input%dE(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=1976 definition='real(rp) :: dB(3,3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='dB' type='real' size='rp' dimension='3,3' comment='magnetic field gradient.' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%dB, 2), ubound(input%dB, 2)
    call json%create_array(json_list1, 'db')
    do i1 = lbound(input%dB, 1), ubound(input%dB, 1)
      call json%create_real(json_val, input%dB(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'phi_b', input%phi_B)
  !line=1979 definition='real(rp) :: A(3) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='A' type='real' size='rp' dimension='3' comment='Magnetic vector potential.' default='0'
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%A, 1), ubound(input%A, 1)
    call json%create_real(json_val, input%A(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
end subroutine em_field_struct_to_json
subroutine strong_beam_struct_to_json (input, json_root, depth)
  use bmad_struct, only: strong_beam_struct
  implicit none
  type(json_core) :: json
  type (strong_beam_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ix_slice', int(input%ix_slice))
  call json%add(json_root, 'x_center', input%x_center)
  call json%add(json_root, 'y_center', input%y_center)
  call json%add(json_root, 'x_sigma', input%x_sigma)
  call json%add(json_root, 'y_sigma', input%y_sigma)
  call json%add(json_root, 'dx', input%dx)
  call json%add(json_root, 'dy', input%dy)
end subroutine strong_beam_struct_to_json
subroutine track_point_struct_to_json (input, json_root, depth)
  use bmad_struct, only: track_point_struct
  implicit none
  type(json_core) :: json
  type (track_point_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 's_body', input%s_body)
  call coord_struct_to_json(input%orb, json_val, depth + 1)
  call json%rename(json_val, 'orb')
  call json%add(json_root, json_val)
  call em_field_struct_to_json(input%field, json_val, depth + 1)
  call json%rename(json_val, 'field')
  call json%add(json_root, json_val)
  call strong_beam_struct_to_json(input%strong_beam, json_val, depth + 1)
  call json%rename(json_val, 'strong_beam')
  call json%add(json_root, json_val)
  !line=2002 definition='real(rp) vec0(6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec0' type='real' size='rp' dimension='6' comment='0th order part of xfer map from the beginning.' default=None
  call json%create_array(json_list1, 'vec0')
  do i1 = lbound(input%vec0, 1), ubound(input%vec0, 1)
    call json%create_real(json_val, input%vec0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=2003 definition='real(rp) mat6(6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='mat6' type='real' size='rp' dimension='6,6' comment='1st order part of xfer map (transfer matrix).' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mat6, 2), ubound(input%mat6, 2)
    call json%create_array(json_list1, 'mat6')
    do i1 = lbound(input%mat6, 1), ubound(input%mat6, 1)
      call json%create_real(json_val, input%mat6(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
end subroutine track_point_struct_to_json
subroutine track_struct_to_json (input, json_root, depth)
  use bmad_struct, only: track_struct
  implicit none
  type(json_core) :: json
  type (track_struct), pointer, intent(in) :: input
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
  if (allocated(input%pt)) then
    !line=2009 definition='type (track_point_struct), allocatable :: pt(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='track_point_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='track_point_struct' dimension=':' comment='Array of track points indexed from 0.' default=None
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call track_point_struct_to_json(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ds_save', input%ds_save)
  call json%add(json_root, 'n_pt', int(input%n_pt))
  call json%add(json_root, 'n_bad', int(input%n_bad))
  call json%add(json_root, 'n_ok', int(input%n_ok))
end subroutine track_struct_to_json
subroutine multipass_lord_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: multipass_lord_info_struct
  implicit none
  type(json_core) :: json
  type (multipass_lord_info_struct), pointer, intent(in) :: input
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
  if (associated(input%lord)) then
    call ele_struct_to_json(input%lord, json_val, depth + 1)
    call json%rename(json_val, 'lord')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'n_pass', int(input%n_pass))
  call json%add(json_root, 'n_super_slave', int(input%n_super_slave))
  if (allocated(input%super_lord)) then
    !line=2031 definition='type (ele_pointer_struct), allocatable :: super_lord(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ele_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='super_lord' type='type' size='ele_pointer_struct' dimension=':' comment='Super_lord list if they exist.' default=None
    call json%create_array(json_list1, 'super_lord')
    do i1 = lbound(input%super_lord, 1), ubound(input%super_lord, 1)
      call ele_pointer_struct_to_json(input%super_lord(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%slave)) then
    !line=2032 definition='type (ele_pointer_struct), allocatable :: slave(:,:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='ele_pointer_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='slave' type='type' size='ele_pointer_struct' dimension=':,:' comment='Slaves list in tracking part.' default=None
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%slave, 2), ubound(input%slave, 2)
      call json%create_array(json_list1, 'slave')
      do i1 = lbound(input%slave, 1), ubound(input%slave, 1)
        call ele_pointer_struct_to_json(input%slave(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
end subroutine multipass_lord_info_struct_to_json
subroutine multipass_ele_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: multipass_ele_info_struct
  implicit none
  type(json_core) :: json
  type (multipass_ele_info_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'multipass', input%multipass)
  call json%add(json_root, 'ix_pass', int(input%ix_pass))
  if (allocated(input%ix_lord)) then
    !line=2041 definition='integer, allocatable :: ix_lord(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ix_lord' type='integer' size=None dimension=':' comment='Pointers to lord(:) array' default=None
    call json%create_array(json_list1, 'ix_lord')
    do i1 = lbound(input%ix_lord, 1), ubound(input%ix_lord, 1)
      call json%create_integer(json_val, input%ix_lord(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ix_super)) then
    !line=2042 definition='integer, allocatable :: ix_super(:)' type_info=TypeInformation(type='integer', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='ix_super' type='integer' size=None dimension=':' comment='Indexes to slave(ix_pass, super_slave%ix_ele) matrix' default=None
    call json%create_array(json_list1, 'ix_super')
    do i1 = lbound(input%ix_super, 1), ubound(input%ix_super, 1)
      call json%create_integer(json_val, input%ix_super(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine multipass_ele_info_struct_to_json
subroutine multipass_branch_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: multipass_branch_info_struct
  implicit none
  type(json_core) :: json
  type (multipass_branch_info_struct), pointer, intent(in) :: input
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
    !line=2046 definition='type (multipass_ele_info_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='multipass_ele_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='multipass_ele_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call multipass_ele_info_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine multipass_branch_info_struct_to_json
subroutine multipass_all_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: multipass_all_info_struct
  implicit none
  type(json_core) :: json
  type (multipass_all_info_struct), pointer, intent(in) :: input
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
  if (allocated(input%lord)) then
    !line=2053 definition='type (multipass_lord_info_struct), allocatable :: lord(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='multipass_lord_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='lord' type='type' size='multipass_lord_info_struct' dimension=':' comment='Array of lords' default=None
    call json%create_array(json_list1, 'lord')
    do i1 = lbound(input%lord, 1), ubound(input%lord, 1)
      call multipass_lord_info_struct_to_json(input%lord(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%branch)) then
    !line=2054 definition='type (multipass_branch_info_struct), allocatable :: branch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='multipass_branch_info_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='branch' type='type' size='multipass_branch_info_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call multipass_branch_info_struct_to_json(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine multipass_all_info_struct_to_json
subroutine aperture_point_struct_to_json (input, json_root, depth)
  use bmad_struct, only: aperture_point_struct
  implicit none
  type(json_core) :: json
  type (aperture_point_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'plane', int(input%plane))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'i_turn', int(input%i_turn))
end subroutine aperture_point_struct_to_json
subroutine aperture_param_struct_to_json (input, json_root, depth)
  use bmad_struct, only: aperture_param_struct
  implicit none
  type(json_core) :: json
  type (aperture_param_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'min_angle', input%min_angle)
  call json%add(json_root, 'max_angle', input%max_angle)
  call json%add(json_root, 'n_angle', int(input%n_angle))
  call json%add(json_root, 'n_turn', int(input%n_turn))
  call json%add(json_root, 'x_init', input%x_init)
  call json%add(json_root, 'y_init', input%y_init)
  call json%add(json_root, 'rel_accuracy', input%rel_accuracy)
  call json%add(json_root, 'abs_accuracy', input%abs_accuracy)
  call json%add(json_root, 'start_ele', trim(input%start_ele))
end subroutine aperture_param_struct_to_json
subroutine aperture_scan_struct_to_json (input, json_root, depth)
  use bmad_struct, only: aperture_scan_struct
  implicit none
  type(json_core) :: json
  type (aperture_scan_struct), pointer, intent(in) :: input
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
  if (allocated(input%point)) then
    !line=2085 definition='type (aperture_point_struct), allocatable :: point(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='aperture_point_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='point' type='type' size='aperture_point_struct' dimension=':' comment='Set of aperture points at different angles.' default=None
    call json%create_array(json_list1, 'point')
    do i1 = lbound(input%point, 1), ubound(input%point, 1)
      call aperture_point_struct_to_json(input%point(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call coord_struct_to_json(input%ref_orb, json_val, depth + 1)
  call json%rename(json_val, 'ref_orb')
  call json%add(json_root, json_val)
  call json%add(json_root, 'pz_start', input%pz_start)
end subroutine aperture_scan_struct_to_json
subroutine space_charge_common_struct_to_json (input, json_root, depth)
  use bmad_struct, only: space_charge_common_struct
  implicit none
  type(json_core) :: json
  type (space_charge_common_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'ds_track_step', input%ds_track_step)
  call json%add(json_root, 'dt_track_step', input%dt_track_step)
  call json%add(json_root, 'cathode_strength_cutoff', input%cathode_strength_cutoff)
  call json%add(json_root, 'rel_tol_tracking', input%rel_tol_tracking)
  call json%add(json_root, 'abs_tol_tracking', input%abs_tol_tracking)
  call json%add(json_root, 'beam_chamber_height', input%beam_chamber_height)
  call json%add(json_root, 'lsc_sigma_cutoff', input%lsc_sigma_cutoff)
  call json%add(json_root, 'particle_sigma_cutoff', input%particle_sigma_cutoff)
  !line=2102 definition='integer :: space_charge_mesh_size(3) = [32, 32, 64]' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='space_charge_mesh_size' type='integer' size=None dimension='3' comment='Gird size for fft_3d space charge calc.' default='[32, 32, 64]'
  call json%create_array(json_list1, 'space_charge_mesh_size')
  do i1 = lbound(input%space_charge_mesh_size, 1), ubound(input%space_charge_mesh_size, 1)
    call json%create_integer(json_val, input%space_charge_mesh_size(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=2103 definition='integer :: csr3d_mesh_size(3) = [32, 32, 64]' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='csr3d_mesh_size' type='integer' size=None dimension='3' comment='Gird size for CSR.' default='[32, 32, 64]'
  call json%create_array(json_list1, 'csr3d_mesh_size')
  do i1 = lbound(input%csr3d_mesh_size, 1), ubound(input%csr3d_mesh_size, 1)
    call json%create_integer(json_val, input%csr3d_mesh_size(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_bin', int(input%n_bin))
  call json%add(json_root, 'particle_bin_span', int(input%particle_bin_span))
  call json%add(json_root, 'n_shield_images', int(input%n_shield_images))
  call json%add(json_root, 'sc_min_in_bin', int(input%sc_min_in_bin))
  call json%add(json_root, 'lsc_kick_transverse_dependence', input%lsc_kick_transverse_dependence)
  call json%add(json_root, 'debug', input%debug)
  call json%add(json_root, 'diagnostic_output_file', trim(input%diagnostic_output_file))
end subroutine space_charge_common_struct_to_json
subroutine time_runge_kutta_common_struct_to_json (input, json_root, depth)
  use bmad_struct, only: time_runge_kutta_common_struct
  implicit none
  type(json_core) :: json
  type (time_runge_kutta_common_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'num_steps_done', int(input%num_steps_done))
  call json%add(json_root, 'print_too_many_step_err', input%print_too_many_step_err)
end subroutine time_runge_kutta_common_struct_to_json
subroutine extra_parsing_info_struct_to_json (input, json_root, depth)
  use bmad_struct, only: extra_parsing_info_struct
  use sim_utils_json, only: random_state_struct_to_json
  implicit none
  type(json_core) :: json
  type (extra_parsing_info_struct), pointer, intent(in) :: input
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
  call random_state_struct_to_json(input%ran_state, json_val, depth + 1)
  call json%rename(json_val, 'ran_state')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ran_seed', int(input%ran_seed))
  call json%add(json_root, 'undeterministic_ran_function_called', input%undeterministic_ran_function_called)
  call json%add(json_root, 'd_orb_set', input%d_orb_set)
  call json%add(json_root, 'max_aperture_limit_set', input%max_aperture_limit_set)
  call json%add(json_root, 'default_ds_step_set', input%default_ds_step_set)
  call json%add(json_root, 'significant_length_set', input%significant_length_set)
  call json%add(json_root, 'rel_tol_tracking_set', input%rel_tol_tracking_set)
  call json%add(json_root, 'abs_tol_tracking_set', input%abs_tol_tracking_set)
  call json%add(json_root, 'rel_tol_adaptive_tracking_set', input%rel_tol_adaptive_tracking_set)
  call json%add(json_root, 'abs_tol_adaptive_tracking_set', input%abs_tol_adaptive_tracking_set)
  call json%add(json_root, 'init_ds_adaptive_tracking_set', input%init_ds_adaptive_tracking_set)
  call json%add(json_root, 'min_ds_adaptive_tracking_set', input%min_ds_adaptive_tracking_set)
  call json%add(json_root, 'fatal_ds_adaptive_tracking_set', input%fatal_ds_adaptive_tracking_set)
  call json%add(json_root, 'synch_rad_scale_set', input%synch_rad_scale_set)
  call json%add(json_root, 'autoscale_amp_abs_tol_set', input%autoscale_amp_abs_tol_set)
  call json%add(json_root, 'autoscale_amp_rel_tol_set', input%autoscale_amp_rel_tol_set)
  call json%add(json_root, 'autoscale_phase_tol_set', input%autoscale_phase_tol_set)
  call json%add(json_root, 'rf_phase_below_transition_ref_set', input%rf_phase_below_transition_ref_set)
  call json%add(json_root, 'electric_dipole_moment_set', input%electric_dipole_moment_set)
  call json%add(json_root, 'taylor_order_set', input%taylor_order_set)
  call json%add(json_root, 'runge_kutta_order_set', input%runge_kutta_order_set)
  call json%add(json_root, 'default_integ_order_set', input%default_integ_order_set)
  call json%add(json_root, 'sr_wakes_on_set', input%sr_wakes_on_set)
  call json%add(json_root, 'lr_wakes_on_set', input%lr_wakes_on_set)
  call json%add(json_root, 'high_energy_space_charge_on_set', input%high_energy_space_charge_on_set)
  call json%add(json_root, 'csr_and_space_charge_on_set', input%csr_and_space_charge_on_set)
  call json%add(json_root, 'spin_tracking_on_set', input%spin_tracking_on_set)
  call json%add(json_root, 'spin_sokolov_ternov_flipping_on_set', input%spin_sokolov_ternov_flipping_on_set)
  call json%add(json_root, 'radiation_damping_on_set', input%radiation_damping_on_set)
  call json%add(json_root, 'radiation_zero_average_set', input%radiation_zero_average_set)
  call json%add(json_root, 'radiation_fluctuations_on_set', input%radiation_fluctuations_on_set)
  call json%add(json_root, 'conserve_taylor_maps_set', input%conserve_taylor_maps_set)
  call json%add(json_root, 'absolute_time_tracking_set', input%absolute_time_tracking_set)
  call json%add(json_root, 'absolute_time_ref_shift_set', input%absolute_time_ref_shift_set)
  call json%add(json_root, 'convert_to_kinetic_momentum_set', input%convert_to_kinetic_momentum_set)
  call json%add(json_root, 'aperture_limit_on_set', input%aperture_limit_on_set)
  call json%add(json_root, 'sad_eps_scale_set', input%sad_eps_scale_set)
  call json%add(json_root, 'sad_amp_max_set', input%sad_amp_max_set)
  call json%add(json_root, 'sad_n_div_max_set', input%sad_n_div_max_set)
  call json%add(json_root, 'max_num_runge_kutta_step_set', input%max_num_runge_kutta_step_set)
  call json%add(json_root, 'debug_set', input%debug_set)
  call json%add(json_root, 'ds_track_step_set', input%ds_track_step_set)
  call json%add(json_root, 'dt_track_step_set', input%dt_track_step_set)
  call json%add(json_root, 'cathode_strength_cutoff_set', input%cathode_strength_cutoff_set)
  call json%add(json_root, 'sc_rel_tol_tracking_set', input%sc_rel_tol_tracking_set)
  call json%add(json_root, 'sc_abs_tol_tracking_set', input%sc_abs_tol_tracking_set)
  call json%add(json_root, 'beam_chamber_height_set', input%beam_chamber_height_set)
  call json%add(json_root, 'lsc_sigma_cutoff_set', input%lsc_sigma_cutoff_set)
  call json%add(json_root, 'particle_sigma_cutoff_set', input%particle_sigma_cutoff_set)
  call json%add(json_root, 'space_charge_mesh_size_set', input%space_charge_mesh_size_set)
  call json%add(json_root, 'csr3d_mesh_size_set', input%csr3d_mesh_size_set)
  call json%add(json_root, 'n_bin_set', input%n_bin_set)
  call json%add(json_root, 'particle_bin_span_set', input%particle_bin_span_set)
  call json%add(json_root, 'n_shield_images_set', input%n_shield_images_set)
  call json%add(json_root, 'sc_min_in_bin_set', input%sc_min_in_bin_set)
  call json%add(json_root, 'lsc_kick_transverse_dependence_set', input%lsc_kick_transverse_dependence_set)
  call json%add(json_root, 'sc_debug_set', input%sc_debug_set)
  call json%add(json_root, 'diagnostic_output_file_set', input%diagnostic_output_file_set)
  call json%add(json_root, 'old_integrator_set', input%old_integrator_set)
  call json%add(json_root, 'use_orientation_patches_set', input%use_orientation_patches_set)
  call json%add(json_root, 'print_info_messages_set', input%print_info_messages_set)
  call json%add(json_root, 'max_fringe_order_set', input%max_fringe_order_set)
  call json%add(json_root, 'exact_model_set', input%exact_model_set)
  call json%add(json_root, 'exact_misalign_set', input%exact_misalign_set)
  call json%add(json_root, 'vertical_kick_set', input%vertical_kick_set)
  call json%add(json_root, 'cut_factor_set', input%cut_factor_set)
  call json%add(json_root, 'translate_patch_drift_time_set', input%translate_patch_drift_time_set)
end subroutine extra_parsing_info_struct_to_json
subroutine bmad_common_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bmad_common_struct
  implicit none
  type(json_core) :: json
  type (bmad_common_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'max_aperture_limit', input%max_aperture_limit)
  !line=2223 definition='real(rp) :: d_orb(6)           = 1d-5' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='d_orb' type='real' size='rp' dimension='6' comment='Orbit deltas for the mat6 via tracking calc.' default='1d-5'
  call json%create_array(json_list1, 'd_orb')
  do i1 = lbound(input%d_orb, 1), ubound(input%d_orb, 1)
    call json%create_real(json_val, input%d_orb(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'default_ds_step', input%default_ds_step)
  call json%add(json_root, 'significant_length', input%significant_length)
  call json%add(json_root, 'rel_tol_tracking', input%rel_tol_tracking)
  call json%add(json_root, 'abs_tol_tracking', input%abs_tol_tracking)
  call json%add(json_root, 'rel_tol_adaptive_tracking', input%rel_tol_adaptive_tracking)
  call json%add(json_root, 'abs_tol_adaptive_tracking', input%abs_tol_adaptive_tracking)
  call json%add(json_root, 'init_ds_adaptive_tracking', input%init_ds_adaptive_tracking)
  call json%add(json_root, 'min_ds_adaptive_tracking', input%min_ds_adaptive_tracking)
  call json%add(json_root, 'fatal_ds_adaptive_tracking', input%fatal_ds_adaptive_tracking)
  call json%add(json_root, 'autoscale_amp_abs_tol', input%autoscale_amp_abs_tol)
  call json%add(json_root, 'autoscale_amp_rel_tol', input%autoscale_amp_rel_tol)
  call json%add(json_root, 'autoscale_phase_tol', input%autoscale_phase_tol)
  call json%add(json_root, 'electric_dipole_moment', input%electric_dipole_moment)
  call json%add(json_root, 'synch_rad_scale', input%synch_rad_scale)
  call json%add(json_root, 'sad_eps_scale', input%sad_eps_scale)
  call json%add(json_root, 'sad_amp_max', input%sad_amp_max)
  call json%add(json_root, 'sad_n_div_max', int(input%sad_n_div_max))
  call json%add(json_root, 'taylor_order', int(input%taylor_order))
  call json%add(json_root, 'runge_kutta_order', int(input%runge_kutta_order))
  call json%add(json_root, 'default_integ_order', int(input%default_integ_order))
  call json%add(json_root, 'max_num_runge_kutta_step', int(input%max_num_runge_kutta_step))
  call json%add(json_root, 'rf_phase_below_transition_ref', input%rf_phase_below_transition_ref)
  call json%add(json_root, 'sr_wakes_on', input%sr_wakes_on)
  call json%add(json_root, 'lr_wakes_on', input%lr_wakes_on)
  call json%add(json_root, 'auto_bookkeeper', input%auto_bookkeeper)
  call json%add(json_root, 'high_energy_space_charge_on', input%high_energy_space_charge_on)
  call json%add(json_root, 'csr_and_space_charge_on', input%csr_and_space_charge_on)
  call json%add(json_root, 'spin_tracking_on', input%spin_tracking_on)
  call json%add(json_root, 'spin_sokolov_ternov_flipping_on', input%spin_sokolov_ternov_flipping_on)
  call json%add(json_root, 'radiation_damping_on', input%radiation_damping_on)
  call json%add(json_root, 'radiation_zero_average', input%radiation_zero_average)
  call json%add(json_root, 'radiation_fluctuations_on', input%radiation_fluctuations_on)
  call json%add(json_root, 'conserve_taylor_maps', input%conserve_taylor_maps)
  call json%add(json_root, 'absolute_time_tracking', input%absolute_time_tracking)
  call json%add(json_root, 'absolute_time_ref_shift', input%absolute_time_ref_shift)
  call json%add(json_root, 'convert_to_kinetic_momentum', input%convert_to_kinetic_momentum)
  call json%add(json_root, 'aperture_limit_on', input%aperture_limit_on)
  call json%add(json_root, 'debug', input%debug)
end subroutine bmad_common_struct_to_json
subroutine bmad_private_struct_to_json (input, json_root, depth)
  use bmad_struct, only: bmad_private_struct
  implicit none
  type(json_core) :: json
  type (bmad_private_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'rf_clock_period', input%rf_clock_period)
  call json%add(json_root, 'random_on', input%random_on)
end subroutine bmad_private_struct_to_json
subroutine ptc_common_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ptc_common_struct
  implicit none
  type(json_core) :: json
  type (ptc_common_struct), pointer, intent(in) :: input
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
  if (associated(input%max_fringe_order)) then
    call json%add(json_root, 'max_fringe_order', int(input%max_fringe_order))
  endif
  if (associated(input%old_integrator)) then
    call json%add(json_root, 'old_integrator', int(input%old_integrator))
  endif
  if (associated(input%exact_model)) then
    call json%add(json_root, 'exact_model', input%exact_model)
  endif
  if (associated(input%exact_misalign)) then
    call json%add(json_root, 'exact_misalign', input%exact_misalign)
  endif
  if (associated(input%vertical_kick)) then
    call json%add(json_root, 'vertical_kick', input%vertical_kick)
  endif
  call json%add(json_root, 'cut_factor', input%cut_factor)
  call json%add(json_root, 'print_step_warning', input%print_step_warning)
  call json%add(json_root, 'use_orientation_patches', input%use_orientation_patches)
  call json%add(json_root, 'print_info_messages', input%print_info_messages)
  call json%add(json_root, 'translate_patch_drift_time', input%translate_patch_drift_time)
end subroutine ptc_common_struct_to_json
subroutine ptc_private_struct_to_json (input, json_root, depth)
  use bmad_struct, only: ptc_private_struct
  use forest_json, only: internal_state_to_json
  implicit none
  type(json_core) :: json
  type (ptc_private_struct), pointer, intent(in) :: input
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
  call internal_state_to_json(input%base_state, json_val, depth + 1)
  call json%rename(json_val, 'base_state')
  call json%add(json_root, json_val)
  call json%add(json_root, 'e_tot_set', input%e_tot_set)
  call json%add(json_root, 'taylor_order_ptc', int(input%taylor_order_ptc))
  call json%add(json_root, 'taylor_order_saved', int(input%taylor_order_saved))
  call json%add(json_root, 'init_ptc_needed', input%init_ptc_needed)
  call json%add(json_root, 'init_spin_needed', input%init_spin_needed)
end subroutine ptc_private_struct_to_json
subroutine rad_int1_struct_to_json (input, json_root, depth)
  use bmad_struct, only: rad_int1_struct
  implicit none
  type(json_core) :: json
  type (rad_int1_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'i0', input%i0)
  call json%add(json_root, 'i1', input%i1)
  call json%add(json_root, 'i2', input%i2)
  call json%add(json_root, 'i3', input%i3)
  call json%add(json_root, 'i4a', input%i4a)
  call json%add(json_root, 'i4b', input%i4b)
  call json%add(json_root, 'i4z', input%i4z)
  call json%add(json_root, 'i5a', input%i5a)
  call json%add(json_root, 'i5b', input%i5b)
  call json%add(json_root, 'i6b', input%i6b)
  call json%add(json_root, 'lin_i2_e4', input%lin_i2_E4)
  call json%add(json_root, 'lin_i3_e7', input%lin_i3_E7)
  call json%add(json_root, 'lin_i5a_e6', input%lin_i5a_E6)
  call json%add(json_root, 'lin_i5b_e6', input%lin_i5b_E6)
  call json%add(json_root, 'lin_norm_emit_a', input%lin_norm_emit_a)
  call json%add(json_root, 'lin_norm_emit_b', input%lin_norm_emit_b)
  call json%add(json_root, 'lin_sig_e', input%lin_sig_E)
  call json%add(json_root, 'n_steps', input%n_steps)
end subroutine rad_int1_struct_to_json
subroutine rad_int_branch_struct_to_json (input, json_root, depth)
  use bmad_struct, only: rad_int_branch_struct
  implicit none
  type(json_core) :: json
  type (rad_int_branch_struct), pointer, intent(in) :: input
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
    !line=2348 definition='type (rad_int1_struct), allocatable :: ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rad_int1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='ele' type='type' size='rad_int1_struct' dimension=':' comment='Array is indexed from 0' default=None
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call rad_int1_struct_to_json(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine rad_int_branch_struct_to_json
subroutine rad_int_all_ele_struct_to_json (input, json_root, depth)
  use bmad_struct, only: rad_int_all_ele_struct
  implicit none
  type(json_core) :: json
  type (rad_int_all_ele_struct), pointer, intent(in) :: input
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
  if (allocated(input%branch)) then
    !line=2352 definition='type (rad_int_branch_struct), allocatable :: branch(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rad_int_branch_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='branch' type='type' size='rad_int_branch_struct' dimension=':' comment='Array is indexed from 0' default=None
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call rad_int_branch_struct_to_json(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
end subroutine rad_int_all_ele_struct_to_json
subroutine pmd_header_struct_to_json (input, json_root, depth)
  use bmad_struct, only: pmd_header_struct
  implicit none
  type(json_core) :: json
  type (pmd_header_struct), pointer, intent(in) :: input
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
  if (allocated(input%openPMD)) then
    call json%add(json_root, 'openpmd', trim(input%openPMD))
  endif
  if (allocated(input%openPMDextension)) then
    call json%add(json_root, 'openpmdextension', trim(input%openPMDextension))
  endif
  if (allocated(input%basePath)) then
    call json%add(json_root, 'basepath', trim(input%basePath))
  endif
  if (allocated(input%particlesPath)) then
    call json%add(json_root, 'particlespath', trim(input%particlesPath))
  endif
  if (allocated(input%meshesPath)) then
    call json%add(json_root, 'meshespath', trim(input%meshesPath))
  endif
  if (allocated(input%author)) then
    call json%add(json_root, 'author', trim(input%author))
  endif
  if (allocated(input%software)) then
    call json%add(json_root, 'software', trim(input%software))
  endif
  if (allocated(input%softwareVersion)) then
    call json%add(json_root, 'softwareversion', trim(input%softwareVersion))
  endif
  if (allocated(input%date)) then
    call json%add(json_root, 'date', trim(input%date))
  endif
  if (allocated(input%latticeFile)) then
    call json%add(json_root, 'latticefile', trim(input%latticeFile))
  endif
  if (allocated(input%latticeName)) then
    call json%add(json_root, 'latticename', trim(input%latticeName))
  endif
end subroutine pmd_header_struct_to_json
subroutine runge_kutta_common_struct_to_json (input, json_root, depth)
  use runge_kutta_mod, only: runge_kutta_common_struct
  implicit none
  type(json_core) :: json
  type (runge_kutta_common_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'num_steps_done', int(input%num_steps_done))
  call json%add(json_root, 'calc_field_derivatives', input%calc_field_derivatives)
end subroutine runge_kutta_common_struct_to_json
subroutine rad_int_track_point_struct_to_json (input, json_root, depth)
  use rad_int_common, only: rad_int_track_point_struct
  implicit none
  type(json_core) :: json
  type (rad_int_track_point_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 's_body', input%s_body)
  !line=17 definition='real(rp) :: mat6(6,6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='mat6' type='real' size='rp' dimension='6,6' comment='' default='0'
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%mat6, 2), ubound(input%mat6, 2)
    call json%create_array(json_list1, 'mat6')
    do i1 = lbound(input%mat6, 1), ubound(input%mat6, 1)
      call json%create_real(json_val, input%mat6(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=18 definition='real(rp) :: vec0(6) = 0' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='vec0' type='real' size='rp' dimension='6' comment='' default='0'
  call json%create_array(json_list1, 'vec0')
  do i1 = lbound(input%vec0, 1), ubound(input%vec0, 1)
    call json%create_real(json_val, input%vec0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call coord_struct_to_json(input%ref_orb_in, json_val, depth + 1)
  call json%rename(json_val, 'ref_orb_in')
  call json%add(json_root, json_val)
  call coord_struct_to_json(input%ref_orb_out, json_val, depth + 1)
  call json%rename(json_val, 'ref_orb_out')
  call json%add(json_root, json_val)
  call json%add(json_root, 'g_x0', input%g_x0)
  call json%add(json_root, 'g_y0', input%g_y0)
  call json%add(json_root, 'dgx_dx', input%dgx_dx)
  call json%add(json_root, 'dgx_dy', input%dgx_dy)
  call json%add(json_root, 'dgy_dx', input%dgy_dx)
  call json%add(json_root, 'dgy_dy', input%dgy_dy)
end subroutine rad_int_track_point_struct_to_json
subroutine rad_int_cache1_struct_to_json (input, json_root, depth)
  use rad_int_common, only: rad_int_cache1_struct
  implicit none
  type(json_core) :: json
  type (rad_int_cache1_struct), pointer, intent(in) :: input
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
  if (allocated(input%pt)) then
    !line=29 definition='type (rad_int_track_point_struct), allocatable :: pt(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rad_int_track_point_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='pt' type='type' size='rad_int_track_point_struct' dimension=':' comment='pt(0:n_pt)' default=None
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call rad_int_track_point_struct_to_json(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_pt', int(input%n_pt))
  call json%add(json_root, 'cache_type', int(input%cache_type))
end subroutine rad_int_cache1_struct_to_json
subroutine rad_int_cache_struct_to_json (input, json_root, depth)
  use rad_int_common, only: rad_int_cache_struct
  implicit none
  type(json_core) :: json
  type (rad_int_cache_struct), pointer, intent(in) :: input
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
  if (allocated(input%c_ele)) then
    !line=35 definition='type (rad_int_cache1_struct), allocatable :: c_ele(:)' type_info=TypeInformation(type='type', allocatable=True, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rad_int_cache1_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='c_ele' type='type' size='rad_int_cache1_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'c_ele')
    do i1 = lbound(input%c_ele, 1), ubound(input%c_ele, 1)
      call rad_int_cache1_struct_to_json(input%c_ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'in_use', input%in_use)
end subroutine rad_int_cache_struct_to_json
subroutine rad_int_info_struct_to_json (input, json_root, depth)
  use rad_int_common, only: rad_int_info_struct
  implicit none
  type(json_core) :: json
  type (rad_int_info_struct), pointer, intent(in) :: input
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
  if (associated(input%branch)) then
    call branch_struct_to_json(input%branch, json_val, depth + 1)
    call json%rename(json_val, 'branch')
    call json%add(json_root, json_val)
  endif
  if (associated(input%ele)) then
    call ele_struct_to_json(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  if (associated(input%orbit)) then
    !line=46 definition='type (coord_struct), pointer :: orbit(:)' type_info=TypeInformation(type='type', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=True, private=False, protected=False, public=False, save=False, kind='coord_struct', static=False, target=False, value=False, volatile=False, attributes=()) name='orbit' type='type' size='coord_struct' dimension=':' comment='' default=None
    call json%create_array(json_list1, 'orbit')
    do i1 = lbound(input%orbit, 1), ubound(input%orbit, 1)
      call coord_struct_to_json(input%orbit(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call twiss_struct_to_json(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call twiss_struct_to_json(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  if (associated(input%cache_ele)) then
    call rad_int_cache1_struct_to_json(input%cache_ele, json_val, depth + 1)
    call json%rename(json_val, 'cache_ele')
    call json%add(json_root, json_val)
  endif
  !line=49 definition='real(rp) eta_a(4), eta_b(4)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='eta_a' type='real' size='rp' dimension='4' comment='' default=None
  call json%create_array(json_list1, 'eta_a')
  do i1 = lbound(input%eta_a, 1), ubound(input%eta_a, 1)
    call json%create_real(json_val, input%eta_a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=49 definition='real(rp) eta_a(4), eta_b(4)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='eta_b' type='real' size='rp' dimension='4' comment='' default=None
  call json%create_array(json_list1, 'eta_b')
  do i1 = lbound(input%eta_b, 1), ubound(input%eta_b, 1)
    call json%create_real(json_val, input%eta_b(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  ! parent pointer skip: g (real, bending strength (1/bending_radius))
  call json%add(json_root, 'g2', input%g2)
  call json%add(json_root, 'g_x', input%g_x)
  call json%add(json_root, 'g_y', input%g_y)
  call json%add(json_root, 'dg2_x', input%dg2_x)
  call json%add(json_root, 'dg2_y', input%dg2_y)
end subroutine rad_int_info_struct_to_json
subroutine wiggler_modeling_common_struct_to_json (input, json_root, depth)
  use element_modeling_mod, only: wiggler_modeling_common_struct
  implicit none
  type(json_core) :: json
  type (wiggler_modeling_common_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'integral_g2_wgt', input%integral_g2_wgt)
  call json%add(json_root, 'integral_g3_wgt', input%integral_g3_wgt)
  call json%add(json_root, 'x_wgt', input%x_wgt)
  call json%add(json_root, 'mat6_wgt', input%mat6_wgt)
  call json%add(json_root, 'drift_len_wgt', input%drift_len_wgt)
  call json%add(json_root, 'g_step', input%g_step)
  call json%add(json_root, 'k_step', input%k_step)
  call json%add(json_root, 'len_step', input%len_step)
  call json%add(json_root, 'integration_ds', input%integration_ds)
  call json%add(json_root, 'drift_len_min', input%drift_len_min)
  !line=29 definition='real(rp) :: len_drifts(3)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='len_drifts' type='real' size='rp' dimension='3' comment='' default=None
  call json%create_array(json_list1, 'len_drifts')
  do i1 = lbound(input%len_drifts, 1), ubound(input%len_drifts, 1)
    call json%create_real(json_val, input%len_drifts(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'len_d_end', input%len_d_end)
  call json%add(json_root, 'len_d_end2', input%len_d_end2)
  call json%add(json_root, 'print_results', input%print_results)
end subroutine wiggler_modeling_common_struct_to_json
subroutine mad_energy_struct_to_json (input, json_root, depth)
  use mad_mod, only: mad_energy_struct
  implicit none
  type(json_core) :: json
  type (mad_energy_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'total', input%total)
  call json%add(json_root, 'beta', input%beta)
  call json%add(json_root, 'gamma', input%gamma)
  call json%add(json_root, 'kinetic', input%kinetic)
  call json%add(json_root, 'p0c', input%p0c)
  call json%add(json_root, 'particle', int(input%particle))
end subroutine mad_energy_struct_to_json
subroutine mad_map_struct_to_json (input, json_root, depth)
  use mad_mod, only: mad_map_struct
  implicit none
  type(json_core) :: json
  type (mad_map_struct), pointer, intent(in) :: input
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
  !line=24 definition='real(rp) k(6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='k' type='real' size='rp' dimension='6' comment='0th order map.' default=None
  call json%create_array(json_list1, 'k')
  do i1 = lbound(input%k, 1), ubound(input%k, 1)
    call json%create_real(json_val, input%k(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=25 definition='real(rp) r(6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='r' type='real' size='rp' dimension='6,6' comment='1st order map.' default=None
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%r, 2), ubound(input%r, 2)
    call json%create_array(json_list1, 'r')
    do i1 = lbound(input%r, 1), ubound(input%r, 1)
      call json%create_real(json_val, input%r(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=26 definition='real(rp) t(6,6,6)' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind='rp', static=False, target=False, value=False, volatile=False, attributes=()) name='t' type='real' size='rp' dimension='6,6,6' comment='2nd order map.' default=None
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%t, 3), ubound(input%t, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%t, 2), ubound(input%t, 2)
      call json%create_array(json_list1, 't')
      do i1 = lbound(input%t, 1), ubound(input%t, 1)
        call json%create_real(json_val, input%t(i1, i2, i3), '')
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
end subroutine mad_map_struct_to_json
subroutine ele_attribute_struct_to_json (input, json_root, depth)
  use attribute_mod, only: ele_attribute_struct
  implicit none
  type(json_core) :: json
  type (ele_attribute_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'state', int(input%state))
  call json%add(json_root, 'kind', int(input%kind))
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'ix_attrib', int(input%ix_attrib))
  call json%add(json_root, 'value', input%value)
end subroutine ele_attribute_struct_to_json
subroutine crystal_struct_to_json (input, json_root, depth)
  use xraylib, only: crystal_struct
  implicit none
  type(json_core) :: json
  type (crystal_struct), pointer, intent(in) :: input
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
  call json%add(json_root, 'volume', input%volume)
end subroutine crystal_struct_to_json
subroutine compounddatanist_to_json (input, json_root, depth)
  use xraylib, only: compounddatanist
  implicit none
  type(json_core) :: json
  type (compounddatanist), pointer, intent(in) :: input
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
  call json%add(json_root, 'nelements', int(input%nElements))
  !line=24 definition='integer nElements, elements(1)' type_info=TypeInformation(type='integer', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='elements' type='integer' size=None dimension='1' comment='' default=None
  call json%create_array(json_list1, 'elements')
  do i1 = lbound(input%elements, 1), ubound(input%elements, 1)
    call json%create_integer(json_val, input%elements(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=25 definition='real massFractions(1), density' type_info=TypeInformation(type='real', allocatable=False, asynchronous=False, bind=None, contiguous=False, dimension=None, external=False, intent=None, intrinsic=False, optional=False, parameter=False, pointer=False, private=False, protected=False, public=False, save=False, kind=None, static=False, target=False, value=False, volatile=False, attributes=()) name='massFractions' type='real' size=None dimension='1' comment='' default=None
  call json%create_array(json_list1, 'massfractions')
  do i1 = lbound(input%massFractions, 1), ubound(input%massFractions, 1)
    call json%create_real(json_val, input%massFractions(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'density', input%density)
end subroutine compounddatanist_to_json
subroutine xrlComplex_C_to_json (input, json_root, depth)
  use xraylib, only: xrlComplex_C
  implicit none
  type(json_core) :: json
  type (xrlComplex_C), pointer, intent(in) :: input
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
  call json%add(json_root, 're', input%re)
  call json%add(json_root, 'im', input%im)
end subroutine xrlComplex_C_to_json
end module bmad_json