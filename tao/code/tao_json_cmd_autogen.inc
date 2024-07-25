subroutine tao_jsonify_complex (input, json_root, depth)

    use json_module
    use json_kinds, only: CK

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

end subroutine tao_jsonify_complex
subroutine tao_jsonify_tao_super_universe_struct (input, json_root, depth)
  use tao_struct, only: tao_super_universe_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_tao_building_wall_struct(input%building_wall, json_val, depth + 1)
  call json%rename(json_val, 'building_wall')
  call json%add(json_root, json_val)
  call tao_jsonify_tao_common_struct(input%com, json_val, depth + 1)
  call json%rename(json_val, 'com')
  call json%add(json_root, json_val)
  call tao_jsonify_tao_global_struct(input%global, json_val, depth + 1)
  call json%rename(json_val, 'global')
  call json%add(json_root, json_val)
  !line=1137 definition='type (tao_cmd_history_struct) :: history(1000) = tao_cmd_history_struct()' name='history' python_name='history' type='tao_cmd_history_struct' python_type='TaoCmdHistoryStruct' size=None dimension='1000' comment='command history' fortran_default='tao_cmd_history_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'history')
  do i1 = lbound(input%history, 1), ubound(input%history, 1)
    call tao_jsonify_tao_cmd_history_struct(input%history(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_tao_init_struct(input%init, json_val, depth + 1)
  call json%rename(json_val, 'init')
  call json%add(json_root, json_val)
  call json%add(json_root, 'initialized', input%initialized)
  if (allocated(input%key)) then
    !line=1132 definition='integer, allocatable :: key(:)' name='key' python_name='key' type='integer, allocatable' python_type='int' size=None dimension=':' comment='' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'key')
    do i1 = lbound(input%key, 1), ubound(input%key, 1)
      call json%create_integer(json_val, input%key(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_tao_mpi_struct(input%mpi, json_val, depth + 1)
  call json%rename(json_val, 'mpi')
  call json%add(json_root, json_val)
  call json%add(json_root, 'n_v1_var_used', int(input%n_v1_var_used))
  call json%add(json_root, 'n_var_used', int(input%n_var_used))
  call tao_jsonify_tao_plot_page_struct(input%plot_page, json_val, depth + 1)
  call json%rename(json_val, 'plot_page')
  call json%add(json_root, json_val)
  if (allocated(input%u)) then
    !line=1130 definition='type (tao_universe_struct), allocatable :: u(:)' name='u' python_name='u' type='tao_universe_struct' python_type='TaoUniverseStruct' size=None dimension=':' comment='array of universes.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'u')
    do i1 = lbound(input%u, 1), ubound(input%u, 1)
      call tao_jsonify_tao_universe_struct(input%u(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%v1_var)) then
    !line=1128 definition='type (tao_v1_var_struct), allocatable :: v1_var(:)' name='v1_var' python_name='v1_var' type='tao_v1_var_struct' python_type='TaoV1VarStruct' size=None dimension=':' comment='The variable types' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'v1_var')
    do i1 = lbound(input%v1_var, 1), ubound(input%v1_var, 1)
      call tao_jsonify_tao_v1_var_struct(input%v1_var(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%var)) then
    !line=1129 definition='type (tao_var_struct), allocatable :: var(:)' name='var' python_name='var' type='tao_var_struct' python_type='TaoVarStruct' size=None dimension=':' comment='array of all variables.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'var')
    do i1 = lbound(input%var, 1), ubound(input%var, 1)
      call tao_jsonify_tao_var_struct(input%var(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_tao_wave_struct(input%wave, json_val, depth + 1)
  call json%rename(json_val, 'wave')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_tao_super_universe_struct

subroutine tao_jsonify_tao_building_wall_struct (input, json_root, depth)
  use tao_struct, only: tao_building_wall_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_tao_building_wall_orientation_struct(input%orientation, json_val, depth + 1)
  call json%rename(json_val, 'orientation')
  call json%add(json_root, json_val)
  if (allocated(input%section)) then
    !line=629 definition='type (tao_building_wall_section_struct), allocatable :: section(:)' name='section' python_name='section' type='tao_building_wall_section_struct' python_type='TaoBuildingWallSectionStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'section')
    do i1 = lbound(input%section, 1), ubound(input%section, 1)
      call tao_jsonify_tao_building_wall_section_struct(input%section(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_building_wall_struct

subroutine tao_jsonify_tao_building_wall_orientation_struct (input, json_root, depth)
  use tao_struct, only: tao_building_wall_orientation_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'theta', input%theta)
  call json%add(json_root, 'x_offset', input%x_offset)
  call json%add(json_root, 'z_offset', input%z_offset)
  
end subroutine tao_jsonify_tao_building_wall_orientation_struct

subroutine tao_jsonify_tao_building_wall_section_struct (input, json_root, depth)
  use tao_struct, only: tao_building_wall_section_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'constraint', trim(input%constraint))
  call json%add(json_root, 'name', trim(input%name))
  if (allocated(input%point)) then
    !line=624 definition='type (tao_building_wall_point_struct), allocatable :: point(:)' name='point' python_name='point' type='tao_building_wall_point_struct' python_type='TaoBuildingWallPointStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'point')
    do i1 = lbound(input%point, 1), ubound(input%point, 1)
      call tao_jsonify_tao_building_wall_point_struct(input%point(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_building_wall_section_struct

subroutine tao_jsonify_tao_building_wall_point_struct (input, json_root, depth)
  use tao_struct, only: tao_building_wall_point_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'radius', input%radius)
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'x_center', input%x_center)
  call json%add(json_root, 'z', input%z)
  call json%add(json_root, 'z_center', input%z_center)
  
end subroutine tao_jsonify_tao_building_wall_point_struct

subroutine tao_jsonify_tao_cmd_history_struct (input, json_root, depth)
  use tao_struct, only: tao_cmd_history_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%cmd)) then
    call json%add(json_root, 'cmd', trim(input%cmd))
  endif
  call json%add(json_root, 'ix', int(input%ix))
  
end subroutine tao_jsonify_tao_cmd_history_struct

subroutine tao_jsonify_tao_common_struct (input, json_root, depth)
  use tao_struct, only: tao_common_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'add_measurement_noise', input%add_measurement_noise)
  !line=736 definition='type (tao_alias_struct) :: alias(200) = tao_alias_struct()' name='alias' python_name='alias' type='tao_alias_struct' python_type='TaoAliasStruct' size=None dimension='200' comment='' fortran_default='tao_alias_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'alias')
  do i1 = lbound(input%alias, 1), ubound(input%alias, 1)
    call tao_jsonify_tao_alias_struct(input%alias(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'all_merit_weights_positive', input%all_merit_weights_positive)
  if (allocated(input%alpha)) then
    !line=743 definition='real(rp), allocatable :: covar(:,:), alpha(:,:)' name='alpha' python_name='alpha' type='real' python_type='float' size=None dimension=':,:' comment='' fortran_default=None default=0.0 default_factory=''
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
  call json%add(json_root, 'cmd', trim(input%cmd))
  if (allocated(input%cmd_file)) then
    !line=739 definition='type (tao_command_file_struct), allocatable :: cmd_file(:)' name='cmd_file' python_name='cmd_file' type='tao_command_file_struct' python_type='TaoCommandFileStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'cmd_file')
    do i1 = lbound(input%cmd_file, 1), ubound(input%cmd_file, 1)
      call tao_jsonify_tao_command_file_struct(input%cmd_file(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'cmd_file_level', int(input%cmd_file_level))
  call json%add(json_root, 'cmd_file_paused', input%cmd_file_paused)
  call json%add(json_root, 'cmd_from_cmd_file', input%cmd_from_cmd_file)
  call json%add(json_root, 'combine_consecutive_elements_of_like_name', input%combine_consecutive_elements_of_like_name)
  call json%add(json_root, 'command_arg_has_been_executed', input%command_arg_has_been_executed)
  if (allocated(input%covar)) then
    !line=743 definition='real(rp), allocatable :: covar(:,:), alpha(:,:)' name='covar' python_name='covar' type='real' python_type='float' size=None dimension=':,:' comment='' fortran_default=None default=0.0 default_factory=''
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
  if (allocated(input%do_loop)) then
    !line=742 definition='type (do_loop_struct), allocatable :: do_loop(:)' name='do_loop' python_name='do_loop' type='do_loop_struct' python_type='DoLoopStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'do_loop')
    do i1 = lbound(input%do_loop, 1), ubound(input%do_loop, 1)
      call tao_jsonify_do_loop_struct(input%do_loop(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'dummy_target', input%dummy_target)
  call json%add(json_root, 'force_chrom_calc', input%force_chrom_calc)
  call json%add(json_root, 'force_rad_int_calc', input%force_rad_int_calc)
  call json%add(json_root, 'have_datums_using_expressions', input%have_datums_using_expressions)
  call json%add(json_root, 'have_tracked_beam', input%have_tracked_beam)
  call json%add(json_root, 'init_beam', input%init_beam)
  call json%add(json_root, 'init_plot_needed', input%init_plot_needed)
  call json%add(json_root, 'init_read_lat_info', input%init_read_lat_info)
  call json%add(json_root, 'init_var', input%init_var)
  !line=770 definition='logical :: is_err_message_printed(2) = .false.' name='is_err_message_printed' python_name='is_err_message_printed' type='logical' python_type='bool' size=None dimension='2' comment='Used by tao_set_invalid' fortran_default='.false.' default=False default_factory=''
  call json%create_array(json_list1, 'is_err_message_printed')
  do i1 = lbound(input%is_err_message_printed, 1), ubound(input%is_err_message_printed, 1)
    call json%create_logical(json_val, input%is_err_message_printed(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ix_ele_taylor', int(input%ix_ele_taylor))
  call json%add(json_root, 'ix_history', int(input%ix_history))
  call json%add(json_root, 'ix_key_bank', int(input%ix_key_bank))
  call json%add(json_root, 'ix_ref_taylor', int(input%ix_ref_taylor))
  !line=737 definition='type (tao_alias_struct) :: key(100) = tao_alias_struct()' name='key' python_name='key' type='tao_alias_struct' python_type='TaoAliasStruct' size=None dimension='100' comment='' fortran_default='tao_alias_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'key')
  do i1 = lbound(input%key, 1), ubound(input%key, 1)
    call tao_jsonify_tao_alias_struct(input%key(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'lattice_calc_done', input%lattice_calc_done)
  call json%add(json_root, 'lev_loop', int(input%lev_loop))
  call json%add(json_root, 'multi_turn_orbit_is_plotted', input%multi_turn_orbit_is_plotted)
  call json%add(json_root, 'n_alias', int(input%n_alias))
  call json%add(json_root, 'n_err_messages_printed', int(input%n_err_messages_printed))
  call json%add(json_root, 'n_history', int(input%n_history))
  call json%add(json_root, 'n_universes', int(input%n_universes))
  call json%add(json_root, 'optimizer_running', input%optimizer_running)
  if (allocated(input%plot_place_buffer)) then
    !line=741 definition='type (tao_plot_region_struct), allocatable :: plot_place_buffer(:)' name='plot_place_buffer' python_name='plot_place_buffer' type='tao_plot_region_struct' python_type='TaoPlotRegionStruct' size=None dimension=':' comment='Used when %external_plotting is on.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'plot_place_buffer')
    do i1 = lbound(input%plot_place_buffer, 1), ubound(input%plot_place_buffer, 1)
      call tao_jsonify_tao_plot_region_struct(input%plot_place_buffer(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'print_to_terminal', input%print_to_terminal)
  call json%add(json_root, 'saved_cmd_line', trim(input%saved_cmd_line))
  call json%add(json_root, 'single_mode', input%single_mode)
  call json%add(json_root, 'single_mode_buffer', trim(input%single_mode_buffer))
  if (allocated(input%symbolic_num)) then
    !line=740 definition='type (named_number_struct), allocatable :: symbolic_num(:)' name='symbolic_num' python_name='symbolic_num' type='named_number_struct' python_type='NamedNumberStruct' size=None dimension=':' comment='Named numbers' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'symbolic_num')
    do i1 = lbound(input%symbolic_num, 1), ubound(input%symbolic_num, 1)
      call tao_jsonify_named_number_struct(input%symbolic_num(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! parent pointer skip: u_working (tao_universe_struct, Index of working universe.)
  call json%add(json_root, 'use_cmd_here', input%use_cmd_here)
  call json%add(json_root, 'use_saved_beam_in_tracking', input%use_saved_beam_in_tracking)
  !line=776 definition="character(16) :: valid_plot_who(10) = ''" name='valid_plot_who' python_name='valid_plot_who' type='character' python_type='str' size='16' dimension='10' comment='model, base, ref etc...' fortran_default="''" default='' default_factory=''
  call json%create_array(json_list1, 'valid_plot_who')
  do i1 = lbound(input%valid_plot_who, 1), ubound(input%valid_plot_who, 1)
    call json%create_string(json_val, trim(input%valid_plot_who(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_tao_common_struct

subroutine tao_jsonify_do_loop_struct (input, json_root, depth)
  use tao_struct, only: do_loop_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'end', int(input%end))
  call json%add(json_root, 'index', int(input%index))
  call json%add(json_root, 'n_line_end', int(input%n_line_end))
  call json%add(json_root, 'n_line_start', int(input%n_line_start))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'start', int(input%start))
  call json%add(json_root, 'step', int(input%step))
  call json%add(json_root, 'value', int(input%value))
  
end subroutine tao_jsonify_do_loop_struct

subroutine tao_jsonify_named_number_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'value', input%value)
  
end subroutine tao_jsonify_named_number_struct

subroutine tao_jsonify_tao_alias_struct (input, json_root, depth)
  use tao_struct, only: tao_alias_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'expanded_str', trim(input%expanded_str))
  call json%add(json_root, 'name', trim(input%name))
  
end subroutine tao_jsonify_tao_alias_struct

subroutine tao_jsonify_tao_command_file_struct (input, json_root, depth)
  use tao_struct, only: tao_command_file_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=715 definition='character(40) cmd_arg(9)' name='cmd_arg' python_name='cmd_arg' type='character' python_type='str' size='40' dimension='9' comment='Command file arguments.' fortran_default=None default='' default_factory='list'
  call json%create_array(json_list1, 'cmd_arg')
  do i1 = lbound(input%cmd_arg, 1), ubound(input%cmd_arg, 1)
    call json%create_string(json_val, trim(input%cmd_arg(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dir', trim(input%dir))
  call json%add(json_root, 'full_name', trim(input%full_name))
  call json%add(json_root, 'ix_unit', int(input%ix_unit))
  call json%add(json_root, 'lattice_calc_save', input%lattice_calc_save)
  call json%add(json_root, 'n_line', int(input%n_line))
  call json%add(json_root, 'paused', input%paused)
  call json%add(json_root, 'plot_save', input%plot_save)
  call json%add(json_root, 'reset_at_end', input%reset_at_end)
  
end subroutine tao_jsonify_tao_command_file_struct

subroutine tao_jsonify_tao_global_struct (input, json_root, depth)
  use tao_struct, only: tao_global_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'beam_dead_cutoff', input%beam_dead_cutoff)
  call json%add(json_root, 'beam_timer_on', input%beam_timer_on)
  call json%add(json_root, 'blank_line_between_commands', input%blank_line_between_commands)
  call json%add(json_root, 'box_plots', input%box_plots)
  call json%add(json_root, 'bunch_to_plot', int(input%bunch_to_plot))
  call json%add(json_root, 'command_file_print_on', input%command_file_print_on)
  call json%add(json_root, 'concatenate_maps', input%concatenate_maps)
  call json%add(json_root, 'datum_err_messages_max', int(input%datum_err_messages_max))
  call json%add(json_root, 'de_lm_step_ratio', input%de_lm_step_ratio)
  call json%add(json_root, 'de_var_to_population_factor', input%de_var_to_population_factor)
  call json%add(json_root, 'debug_on', input%debug_on)
  call json%add(json_root, 'default_branch', int(input%default_branch))
  call json%add(json_root, 'default_universe', int(input%default_universe))
  call json%add(json_root, 'delta_e_chrom', input%delta_e_chrom)
  call json%add(json_root, 'derivative_recalc', input%derivative_recalc)
  call json%add(json_root, 'derivative_uses_design', input%derivative_uses_design)
  call json%add(json_root, 'disable_smooth_line_calc', input%disable_smooth_line_calc)
  call json%add(json_root, 'dmerit_stop_value', input%dmerit_stop_value)
  call json%add(json_root, 'draw_curve_off_scale_warn', input%draw_curve_off_scale_warn)
  call json%add(json_root, 'external_plotting', input%external_plotting)
  call json%add(json_root, 'history_file', trim(input%history_file))
  call json%add(json_root, 'init_lat_sigma_from_beam', input%init_lat_sigma_from_beam)
  call json%add(json_root, 'label_keys', input%label_keys)
  call json%add(json_root, 'label_lattice_elements', input%label_lattice_elements)
  call json%add(json_root, 'lattice_calc_on', input%lattice_calc_on)
  call json%add(json_root, 'lm_opt_deriv_reinit', input%lm_opt_deriv_reinit)
  call json%add(json_root, 'lmdif_eps', input%lmdif_eps)
  call json%add(json_root, 'lmdif_negligible_merit', input%lmdif_negligible_merit)
  call json%add(json_root, 'merit_stop_value', input%merit_stop_value)
  call json%add(json_root, 'n_opti_cycles', int(input%n_opti_cycles))
  call json%add(json_root, 'n_opti_loops', int(input%n_opti_loops))
  call json%add(json_root, 'n_top10_merit', int(input%n_top10_merit))
  call json%add(json_root, 'only_limit_opt_vars', input%only_limit_opt_vars)
  call json%add(json_root, 'opt_match_auto_recalc', input%opt_match_auto_recalc)
  call json%add(json_root, 'opt_with_base', input%opt_with_base)
  call json%add(json_root, 'opt_with_ref', input%opt_with_ref)
  call json%add(json_root, 'opti_write_var_file', input%opti_write_var_file)
  call json%add(json_root, 'optimizer', trim(input%optimizer))
  call json%add(json_root, 'optimizer_allow_user_abort', input%optimizer_allow_user_abort)
  call json%add(json_root, 'optimizer_var_limit_warn', input%optimizer_var_limit_warn)
  call json%add(json_root, 'phase_units', int(input%phase_units))
  call json%add(json_root, 'plot_on', input%plot_on)
  call json%add(json_root, 'print_command', trim(input%print_command))
  call json%add(json_root, 'prompt_color', trim(input%prompt_color))
  call json%add(json_root, 'prompt_string', trim(input%prompt_string))
  call json%add(json_root, 'quiet', trim(input%quiet))
  call json%add(json_root, 'rad_int_calc_on', input%rad_int_calc_on)
  call json%add(json_root, 'random_engine', trim(input%random_engine))
  call json%add(json_root, 'random_gauss_converter', trim(input%random_gauss_converter))
  call json%add(json_root, 'random_seed', int(input%random_seed))
  call json%add(json_root, 'random_sigma_cutoff', input%random_sigma_cutoff)
  call json%add(json_root, 'rf_on', input%rf_on)
  call json%add(json_root, 'single_step', input%single_step)
  call json%add(json_root, 'srdt_gen_n_slices', int(input%srdt_gen_n_slices))
  call json%add(json_root, 'srdt_sxt_n_slices', int(input%srdt_sxt_n_slices))
  call json%add(json_root, 'srdt_use_cache', input%srdt_use_cache)
  call json%add(json_root, 'stop_on_error', input%stop_on_error)
  call json%add(json_root, 'svd_cutoff', input%svd_cutoff)
  call json%add(json_root, 'svd_retreat_on_merit_increase', input%svd_retreat_on_merit_increase)
  call json%add(json_root, 'symbol_import', input%symbol_import)
  call json%add(json_root, 'track_type', trim(input%track_type))
  call json%add(json_root, 'unstable_penalty', input%unstable_penalty)
  call json%add(json_root, 'var_limits_on', input%var_limits_on)
  call json%add(json_root, 'var_out_file', trim(input%var_out_file))
  call json%add(json_root, 'wait_for_cr_in_single_mode', input%wait_for_CR_in_single_mode)
  
end subroutine tao_jsonify_tao_global_struct

subroutine tao_jsonify_tao_init_struct (input, json_root, depth)
  use tao_struct, only: tao_init_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'beam_file_arg', trim(input%beam_file_arg))
  call json%add(json_root, 'beam_init_position_file_arg', trim(input%beam_init_position_file_arg))
  call json%add(json_root, 'building_wall_file_arg', trim(input%building_wall_file_arg))
  call json%add(json_root, 'command_arg', trim(input%command_arg))
  call json%add(json_root, 'data_file_arg', trim(input%data_file_arg))
  call json%add(json_root, 'debug_arg', trim(input%debug_arg))
  call json%add(json_root, 'debug_switch', input%debug_switch)
  call json%add(json_root, 'disable_smooth_line_calc_arg', trim(input%disable_smooth_line_calc_arg))
  call json%add(json_root, 'external_plotting_switch', input%external_plotting_switch)
  call json%add(json_root, 'geometry_arg', trim(input%geometry_arg))
  call json%add(json_root, 'hook_beam_file', trim(input%hook_beam_file))
  call json%add(json_root, 'hook_building_wall_file', trim(input%hook_building_wall_file))
  call json%add(json_root, 'hook_data_file', trim(input%hook_data_file))
  call json%add(json_root, 'hook_init_file', trim(input%hook_init_file))
  call json%add(json_root, 'hook_init_file_arg', trim(input%hook_init_file_arg))
  call json%add(json_root, 'hook_lat_file', trim(input%hook_lat_file))
  call json%add(json_root, 'hook_plot_file', trim(input%hook_plot_file))
  call json%add(json_root, 'hook_startup_file', trim(input%hook_startup_file))
  call json%add(json_root, 'hook_var_file', trim(input%hook_var_file))
  call json%add(json_root, 'init_file_arg', trim(input%init_file_arg))
  call json%add(json_root, 'init_file_arg_path', trim(input%init_file_arg_path))
  call json%add(json_root, 'init_name', trim(input%init_name))
  call json%add(json_root, 'lattice_file_arg', trim(input%lattice_file_arg))
  call json%add(json_root, 'log_startup_arg', trim(input%log_startup_arg))
  call json%add(json_root, 'no_rad_int_arg', trim(input%no_rad_int_arg))
  call json%add(json_root, 'no_stopping_arg', trim(input%no_stopping_arg))
  call json%add(json_root, 'noinit_arg', trim(input%noinit_arg))
  call json%add(json_root, 'noplot_arg', trim(input%noplot_arg))
  call json%add(json_root, 'nostartup_arg', trim(input%nostartup_arg))
  call json%add(json_root, 'parse_cmd_args', input%parse_cmd_args)
  call json%add(json_root, 'plot_file_arg', trim(input%plot_file_arg))
  call json%add(json_root, 'prompt_color_arg', trim(input%prompt_color_arg))
  call json%add(json_root, 'quiet_arg', trim(input%quiet_arg))
  call json%add(json_root, 'reverse_arg', trim(input%reverse_arg))
  call json%add(json_root, 'rf_on_arg', trim(input%rf_on_arg))
  call json%add(json_root, 'slice_lattice_arg', trim(input%slice_lattice_arg))
  call json%add(json_root, 'start_branch_at_arg', trim(input%start_branch_at_arg))
  call json%add(json_root, 'startup_file_arg', trim(input%startup_file_arg))
  call json%add(json_root, 'symbol_import_arg', trim(input%symbol_import_arg))
  call json%add(json_root, 'unique_name_suffix', trim(input%unique_name_suffix))
  call json%add(json_root, 'var_file_arg', trim(input%var_file_arg))
  
end subroutine tao_jsonify_tao_init_struct

subroutine tao_jsonify_tao_mpi_struct (input, json_root, depth)
  use tao_struct, only: tao_mpi_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'host_name', trim(input%host_name))
  call json%add(json_root, 'master', input%master)
  call json%add(json_root, 'max_rank', int(input%max_rank))
  call json%add(json_root, 'on', input%on)
  call json%add(json_root, 'rank', int(input%rank))
  
end subroutine tao_jsonify_tao_mpi_struct

subroutine tao_jsonify_tao_plot_page_struct (input, json_root, depth)
  use tao_struct, only: tao_plot_page_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'axis_label_text_scale', input%axis_label_text_scale)
  call json%add(json_root, 'axis_number_text_scale', input%axis_number_text_scale)
  call tao_jsonify_qp_rect_struct(input%border, json_val, depth + 1)
  call json%rename(json_val, 'border')
  call json%add(json_root, json_val)
  call json%add(json_root, 'curve_legend_line_len', input%curve_legend_line_len)
  call json%add(json_root, 'curve_legend_text_offset', input%curve_legend_text_offset)
  call json%add(json_root, 'delete_overlapping_plots', input%delete_overlapping_plots)
  call json%add(json_root, 'draw_graph_title_suffix', input%draw_graph_title_suffix)
  call tao_jsonify_tao_drawing_struct(input%floor_plan, json_val, depth + 1)
  call json%rename(json_val, 'floor_plan')
  call json%add(json_root, json_val)
  call json%add(json_root, 'floor_plan_shape_scale', input%floor_plan_shape_scale)
  call json%add(json_root, 'floor_plan_text_scale', input%floor_plan_text_scale)
  call json%add(json_root, 'graph_title_text_scale', input%graph_title_text_scale)
  call json%add(json_root, 'id_window', int(input%id_window))
  call json%add(json_root, 'key_table_text_scale', input%key_table_text_scale)
  call tao_jsonify_tao_drawing_struct(input%lat_layout, json_val, depth + 1)
  call json%rename(json_val, 'lat_layout')
  call json%add(json_root, json_val)
  call json%add(json_root, 'lat_layout_shape_scale', input%lat_layout_shape_scale)
  call json%add(json_root, 'lat_layout_text_scale', input%lat_layout_text_scale)
  call json%add(json_root, 'legend_text_scale', input%legend_text_scale)
  call json%add(json_root, 'main_title_text_scale', input%main_title_text_scale)
  call json%add(json_root, 'n_curve_pts', int(input%n_curve_pts))
  if (allocated(input%pattern)) then
    !line=335 definition='type (tao_shape_pattern_struct), allocatable :: pattern(:)' name='pattern' python_name='pattern' type='tao_shape_pattern_struct' python_type='TaoShapePatternStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'pattern')
    do i1 = lbound(input%pattern, 1), ubound(input%pattern, 1)
      call tao_jsonify_tao_shape_pattern_struct(input%pattern(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'plot_display_type', trim(input%plot_display_type))
  if (allocated(input%region)) then
    !line=337 definition='type (tao_plot_region_struct), allocatable :: region(:)' name='region' python_name='region' type='tao_plot_region_struct' python_type='TaoPlotRegionStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'region')
    do i1 = lbound(input%region, 1), ubound(input%region, 1)
      call tao_jsonify_tao_plot_region_struct(input%region(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  !line=339 definition='real(rp) :: size(2) = 0' name='size' python_name='size' type='real' python_type='float' size=None dimension='2' comment='width and height of plot window in pixels.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'size')
  do i1 = lbound(input%size, 1), ubound(input%size, 1)
    call json%create_real(json_val, input%size(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_tao_title_struct(input%subtitle, json_val, depth + 1)
  call json%rename(json_val, 'subtitle')
  call json%add(json_root, json_val)
  if (allocated(input%template)) then
    !line=336 definition='type (tao_plot_struct), allocatable :: template(:)' name='template' python_name='template' type='tao_plot_struct' python_type='TaoPlotStruct' size=None dimension=':' comment='Templates for the plots.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'template')
    do i1 = lbound(input%template, 1), ubound(input%template, 1)
      call tao_jsonify_tao_plot_struct(input%template(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'text_height', input%text_height)
  call tao_jsonify_tao_title_struct(input%title, json_val, depth + 1)
  call json%rename(json_val, 'title')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_tao_plot_page_struct

subroutine tao_jsonify_qp_rect_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'x1', input%x1)
  call json%add(json_root, 'x2', input%x2)
  call json%add(json_root, 'y1', input%y1)
  call json%add(json_root, 'y2', input%y2)
  
end subroutine tao_jsonify_qp_rect_struct

subroutine tao_jsonify_tao_drawing_struct (input, json_root, depth)
  use tao_struct, only: tao_drawing_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%ele_shape)) then
    !line=130 definition='type (tao_ele_shape_struct), allocatable :: ele_shape(:)' name='ele_shape' python_name='ele_shape' type='tao_ele_shape_struct' python_type='TaoEleShapeStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'ele_shape')
    do i1 = lbound(input%ele_shape, 1), ubound(input%ele_shape, 1)
      call tao_jsonify_tao_ele_shape_struct(input%ele_shape(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_drawing_struct

subroutine tao_jsonify_tao_ele_shape_struct (input, json_root, depth)
  use tao_struct, only: tao_ele_shape_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'draw', input%draw)
  call json%add(json_root, 'ele_id', trim(input%ele_id))
  call json%add(json_root, 'ix_key', int(input%ix_key))
  call json%add(json_root, 'label', trim(input%label))
  call json%add(json_root, 'line_width', int(input%line_width))
  call json%add(json_root, 'multi', input%multi)
  call json%add(json_root, 'name_ele', trim(input%name_ele))
  call json%add(json_root, 'offset', input%offset)
  call json%add(json_root, 'shape', trim(input%shape))
  call json%add(json_root, 'size', input%size)
  if (allocated(input%uni)) then
    !line=126 definition='type (tao_ele_pointer_struct), allocatable :: uni(:)' name='uni' python_name='uni' type='tao_ele_pointer_struct' python_type='TaoElePointerStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'uni')
    do i1 = lbound(input%uni, 1), ubound(input%uni, 1)
      call tao_jsonify_tao_ele_pointer_struct(input%uni(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_ele_shape_struct

subroutine tao_jsonify_tao_ele_pointer_struct (input, json_root, depth)
  use tao_struct, only: tao_ele_pointer_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%eles)) then
    !line=109 definition='type (ele_pointer_struct), allocatable :: eles(:)' name='eles' python_name='eles' type='ele_pointer_struct' python_type='ElePointerStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'eles')
    do i1 = lbound(input%eles, 1), ubound(input%eles, 1)
      call tao_jsonify_ele_pointer_struct(input%eles(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_loc', int(input%n_loc))
  
end subroutine tao_jsonify_tao_ele_pointer_struct

subroutine tao_jsonify_ele_pointer_struct (input, json_root, depth)
  use bmad_struct, only: ele_pointer_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%ele)) then
    call tao_jsonify_ele_struct(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'id', int(input%id))
  call tao_jsonify_lat_ele_loc_struct(input%loc, json_val, depth + 1)
  call json%rename(json_val, 'loc')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_ele_pointer_struct

subroutine tao_jsonify_ele_struct (input, json_root, depth)
  use bmad_struct, only: ele_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_twiss_struct(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  if (associated(input%a_pole)) then
    !line=1415 definition='real(rp), pointer :: a_pole(:) => null()' name='a_pole' python_name='a_pole' type='real' python_type='float' size=None dimension=':' comment='knl for multipole elements.' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list1, 'a_pole')
    do i1 = lbound(input%a_pole, 1), ubound(input%a_pole, 1)
      call json%create_real(json_val, input%a_pole(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%a_pole_elec)) then
    !line=1417 definition='real(rp), pointer :: a_pole_elec(:) => null()' name='a_pole_elec' python_name='a_pole_elec' type='real' python_type='float' size=None dimension=':' comment='Electrostatic multipoles. ksnl for multipole elements.' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list1, 'a_pole_elec')
    do i1 = lbound(input%a_pole_elec, 1), ubound(input%a_pole_elec, 1)
      call json%create_real(json_val, input%a_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ac_kick)) then
    call tao_jsonify_ac_kicker_struct(input%ac_kick, json_val, depth + 1)
    call json%rename(json_val, 'ac_kick')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'alias', trim(input%alias))
  call json%add(json_root, 'aperture_at', int(input%aperture_at))
  call json%add(json_root, 'aperture_type', int(input%aperture_type))
  call tao_jsonify_twiss_struct(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  if (associated(input%b_pole)) then
    !line=1416 definition='real(rp), pointer :: b_pole(:) => null()' name='b_pole' python_name='b_pole' type='real' python_type='float' size=None dimension=':' comment='tilt for multipole elements.' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list1, 'b_pole')
    do i1 = lbound(input%b_pole, 1), ubound(input%b_pole, 1)
      call json%create_real(json_val, input%b_pole(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%b_pole_elec)) then
    !line=1418 definition='real(rp), pointer :: b_pole_elec(:) => null()' name='b_pole_elec' python_name='b_pole_elec' type='real' python_type='float' size=None dimension=':' comment='Electrostatic multipoles.' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list1, 'b_pole_elec')
    do i1 = lbound(input%b_pole_elec, 1), ubound(input%b_pole_elec, 1)
      call json%create_real(json_val, input%b_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'bmad_logic', input%bmad_logic)
  call tao_jsonify_bookkeeping_state_struct(input%bookkeeping_state, json_val, depth + 1)
  call json%rename(json_val, 'bookkeeping_state')
  call json%add(json_root, json_val)
  if (associated(input%branch)) then
    call tao_jsonify_branch_struct(input%branch, json_val, depth + 1)
    call json%rename(json_val, 'branch')
    call json%add(json_root, json_val)
  endif
  !line=1410 definition='real(rp) :: c_mat(2,2) = 0' name='c_mat' python_name='c_mat' type='real' python_type='float' size=None dimension='2,2' comment='2x2 C coupling matrix' fortran_default='0' default=0 default_factory=''
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
  if (associated(input%cartesian_map)) then
    !line=1393 definition='type (cartesian_map_struct), pointer :: cartesian_map(:) => null()' name='cartesian_map' python_name='cartesian_map' type='cartesian_map_struct' python_type='CartesianMapStruct' size=None dimension=':' comment='Used to define E/M fields' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'cartesian_map')
    do i1 = lbound(input%cartesian_map, 1), ubound(input%cartesian_map, 1)
      call tao_jsonify_cartesian_map_struct(input%cartesian_map(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'component_name', trim(input%component_name))
  if (associated(input%control)) then
    call tao_jsonify_controller_struct(input%control, json_val, depth + 1)
    call json%rename(json_val, 'control')
    call json%add(json_root, json_val)
  endif
  if (associated(input%converter)) then
    call tao_jsonify_converter_struct(input%converter, json_val, depth + 1)
    call json%rename(json_val, 'converter')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'csr_method', int(input%csr_method))
  if (associated(input%custom)) then
    !line=1419 definition='real(rp), pointer :: custom(:) => null()' name='custom' python_name='custom' type='real' python_type='float' size=None dimension=':' comment='Custom attributes.' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list1, 'custom')
    do i1 = lbound(input%custom, 1), ubound(input%custom, 1)
      call json%create_real(json_val, input%custom(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%cylindrical_map)) then
    !line=1394 definition='type (cylindrical_map_struct), pointer :: cylindrical_map(:) => null()' name='cylindrical_map' python_name='cylindrical_map' type='cylindrical_map_struct' python_type='CylindricalMapStruct' size=None dimension=':' comment='Used to define E/M fields' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'cylindrical_map')
    do i1 = lbound(input%cylindrical_map, 1), ubound(input%cylindrical_map, 1)
      call tao_jsonify_cylindrical_map_struct(input%cylindrical_map(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%descrip)) then
    call json%add(json_root, 'descrip', trim(input%descrip))
  endif
  call json%add(json_root, 'field_calc', int(input%field_calc))
  call json%add(json_root, 'field_master', input%field_master)
  call tao_jsonify_floor_position_struct(input%floor, json_val, depth + 1)
  call json%rename(json_val, 'floor')
  call json%add(json_root, json_val)
  if (associated(input%foil)) then
    call tao_jsonify_foil_struct(input%foil, json_val, depth + 1)
    call json%rename(json_val, 'foil')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'gamma_c', input%gamma_c)
  if (associated(input%gen_grad_map)) then
    !line=1395 definition='type (gen_grad_map_struct), pointer :: gen_grad_map(:) => null()' name='gen_grad_map' python_name='gen_grad_map' type='gen_grad_map_struct' python_type='GenGradMapStruct' size=None dimension=':' comment='Used to define E/M fields.' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'gen_grad_map')
    do i1 = lbound(input%gen_grad_map, 1), ubound(input%gen_grad_map, 1)
      call tao_jsonify_gen_grad_map_struct(input%gen_grad_map(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%grid_field)) then
    !line=1396 definition='type (grid_field_struct), pointer :: grid_field(:) => null()' name='grid_field' python_name='grid_field' type='grid_field_struct' python_type='GridFieldStruct' size=None dimension=':' comment='Used to define E/M fields. The difference between map_ref_orb and time_ref_orb is that map_ref_orb is the reference orbit for the 1st order spin/orbit map which, in general, is non-zero while time_ref_orb follows the reference particle which is generally the zero orbit (non-zero, for example, in the second slice of a sliced wiggler).' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'grid_field')
    do i1 = lbound(input%grid_field, 1), ubound(input%grid_field, 1)
      call tao_jsonify_grid_field_struct(input%grid_field(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%high_energy_space_charge)) then
    call tao_jsonify_high_energy_space_charge_struct(input%high_energy_space_charge, json_val, depth + 1)
    call json%rename(json_val, 'high_energy_space_charge')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'ic1_lord', int(input%ic1_lord))
  call json%add(json_root, 'is_on', input%is_on)
  call json%add(json_root, 'ix1_slave', int(input%ix1_slave))
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_pointer', int(input%ix_pointer))
  call json%add(json_root, 'ixx', int(input%ixx))
  call json%add(json_root, 'iyy', int(input%iyy))
  call json%add(json_root, 'izz', int(input%izz))
  call json%add(json_root, 'key', int(input%key))
  call json%add(json_root, 'logic', input%logic)
  if (associated(input%lord)) then
    call tao_jsonify_ele_struct(input%lord, json_val, depth + 1)
    call json%rename(json_val, 'lord')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'lord_status', int(input%lord_status))
  call tao_jsonify_coord_struct(input%map_ref_orb_in, json_val, depth + 1)
  call json%rename(json_val, 'map_ref_orb_in')
  call json%add(json_root, json_val)
  call tao_jsonify_coord_struct(input%map_ref_orb_out, json_val, depth + 1)
  call json%rename(json_val, 'map_ref_orb_out')
  call json%add(json_root, json_val)
  !line=1409 definition='real(rp) :: mat6(6,6) = 0' name='mat6' python_name='mat6' type='real' python_type='float' size=None dimension='6,6' comment='1st order transport matrix.' fortran_default='0' default=0 default_factory=''
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
  call json%add(json_root, 'mat6_calc_method', int(input%mat6_calc_method))
  if (associated(input%mode3)) then
    call tao_jsonify_mode3_struct(input%mode3, json_val, depth + 1)
    call json%rename(json_val, 'mode3')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'mode_flip', input%mode_flip)
  if (allocated(input%multipole_cache)) then
    call tao_jsonify_multipole_cache_struct(input%multipole_cache, json_val, depth + 1)
    call json%rename(json_val, 'multipole_cache')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'multipoles_on', input%multipoles_on)
  call json%add(json_root, 'n_lord', int(input%n_lord))
  call json%add(json_root, 'n_lord_field', int(input%n_lord_field))
  call json%add(json_root, 'n_lord_ramper', int(input%n_lord_ramper))
  call json%add(json_root, 'n_slave', int(input%n_slave))
  call json%add(json_root, 'n_slave_field', int(input%n_slave_field))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'offset_moves_aperture', input%offset_moves_aperture)
  !line=1405 definition='real(rp) :: old_value(num_ele_attrib$) = 0' name='old_value' python_name='old_value' type='real' python_type='float' size=None dimension='num_ele_attrib$' comment='Used to see if %value(:) array has changed. Note: The reference orbit for spin/orbit matrices is %map_ref_orb_in/out' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'old_value')
  do i1 = lbound(input%old_value, 1), ubound(input%old_value, 1)
    call json%create_real(json_val, input%old_value(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'orientation', int(input%orientation))
  if (associated(input%photon)) then
    call tao_jsonify_photon_element_struct(input%photon, json_val, depth + 1)
    call json%rename(json_val, 'photon')
    call json%add(json_root, json_val)
  endif
  ! skipped explicitly by converter: struct=FIBRE file=a_def_element_fibre_layout.inc member=json_obj
  call json%add(json_root, 'ptc_integration_type', int(input%ptc_integration_type))
  if (associated(input%r)) then
    !line=1420 definition='real(rp), pointer :: r(:,:,:) => null()' name='r' python_name='r' type='real' python_type='float' size=None dimension=':,:,:' comment='For general use. Not used by Bmad.' fortran_default='null()' default=0.0 default_factory=''
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
  if (associated(input%rad_map)) then
    call tao_jsonify_rad_map_ele_struct(input%rad_map, json_val, depth + 1)
    call json%rename(json_val, 'rad_map')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'ref_species', int(input%ref_species))
  call json%add(json_root, 'ref_time', input%ref_time)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 's_start', input%s_start)
  call json%add(json_root, 'scale_multipoles', input%scale_multipoles)
  call json%add(json_root, 'select', input%select)
  call json%add(json_root, 'slave_status', int(input%slave_status))
  call json%add(json_root, 'space_charge_method', int(input%space_charge_method))
  !line=1407 definition='real(rp) :: spin_q(0:3,0:6) = real_garbage$' name='spin_q' python_name='spin_q' type='real' python_type='float' size=None dimension='0:3,0:6' comment='0th and 1st order Spin transport quaternion.' fortran_default='real_garbage$' default=0.0 default_factory=''
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
  !line=1389 definition='type (taylor_struct) :: spin_taylor(0:3) = taylor_struct()' name='spin_taylor' python_name='spin_taylor' type='taylor_struct' python_type='TaylorStruct' size=None dimension='0:3' comment='Quaternion Spin Taylor map.' fortran_default='taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'spin_taylor')
  do i1 = lbound(input%spin_taylor, 1), ubound(input%spin_taylor, 1)
    call tao_jsonify_taylor_struct(input%spin_taylor(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1388 definition='real(rp) :: spin_taylor_ref_orb_in(6) = real_garbage$' name='spin_taylor_ref_orb_in' python_name='spin_taylor_ref_orb_in' type='real' python_type='float' size=None dimension='6' comment='' fortran_default='real_garbage$' default=0.0 default_factory=''
  call json%create_array(json_list1, 'spin_taylor_ref_orb_in')
  do i1 = lbound(input%spin_taylor_ref_orb_in, 1), ubound(input%spin_taylor_ref_orb_in, 1)
    call json%create_real(json_val, input%spin_taylor_ref_orb_in(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'spin_tracking_method', int(input%spin_tracking_method))
  call json%add(json_root, 'sub_key', int(input%sub_key))
  call json%add(json_root, 'symplectify', input%symplectify)
  !line=1387 definition='type (taylor_struct) :: taylor(6) = taylor_struct()' name='taylor' python_name='taylor' type='taylor_struct' python_type='TaylorStruct' size=None dimension='6' comment='Phase space Taylor map.' fortran_default='taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'taylor')
  do i1 = lbound(input%taylor, 1), ubound(input%taylor, 1)
    call tao_jsonify_taylor_struct(input%taylor(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'taylor_map_includes_offsets', input%taylor_map_includes_offsets)
  call tao_jsonify_coord_struct(input%time_ref_orb_in, json_val, depth + 1)
  call json%rename(json_val, 'time_ref_orb_in')
  call json%add(json_root, json_val)
  call tao_jsonify_coord_struct(input%time_ref_orb_out, json_val, depth + 1)
  call json%rename(json_val, 'time_ref_orb_out')
  call json%add(json_root, json_val)
  call json%add(json_root, 'tracking_method', int(input%tracking_method))
  call json%add(json_root, 'type', trim(input%type))
  !line=1404 definition='real(rp) :: value(num_ele_attrib$) = 0' name='value' python_name='value' type='real' python_type='float' size=None dimension='num_ele_attrib$' comment='attribute values.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'value')
  do i1 = lbound(input%value, 1), ubound(input%value, 1)
    call json%create_real(json_val, input%value(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1408 definition='real(rp) :: vec0(6) = 0' name='vec0' python_name='vec0' type='real' python_type='float' size=None dimension='6' comment='0th order transport vector.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'vec0')
  do i1 = lbound(input%vec0, 1), ubound(input%vec0, 1)
    call json%create_real(json_val, input%vec0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%wake)) then
    call tao_jsonify_wake_struct(input%wake, json_val, depth + 1)
    call json%rename(json_val, 'wake')
    call json%add(json_root, json_val)
  endif
  if (associated(input%wall3d)) then
    !line=1391 definition='type (wall3d_struct), pointer :: wall3d(:) => null()' name='wall3d' python_name='wall3d' type='wall3d_struct' python_type='Wall3dStruct' size=None dimension=':' comment='Chamber or capillary wall E/M field structs.' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'wall3d')
    do i1 = lbound(input%wall3d, 1), ubound(input%wall3d, 1)
      call tao_jsonify_wall3d_struct(input%wall3d(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_xy_disp_struct(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call tao_jsonify_xy_disp_struct(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_ele_struct

subroutine tao_jsonify_ac_kicker_struct (input, json_root, depth)
  use bmad_struct, only: ac_kicker_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%amp_vs_time)) then
    !line=681 definition='type (ac_kicker_time_struct), allocatable :: amp_vs_time(:)' name='amp_vs_time' python_name='amp_vs_time' type='ac_kicker_time_struct' python_type='AcKickerTimeStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'amp_vs_time')
    do i1 = lbound(input%amp_vs_time, 1), ubound(input%amp_vs_time, 1)
      call tao_jsonify_ac_kicker_time_struct(input%amp_vs_time(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%frequency)) then
    !line=682 definition='type (ac_kicker_freq_struct), allocatable :: frequency(:)' name='frequency' python_name='frequency' type='ac_kicker_freq_struct' python_type='AcKickerFreqStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'frequency')
    do i1 = lbound(input%frequency, 1), ubound(input%frequency, 1)
      call tao_jsonify_ac_kicker_freq_struct(input%frequency(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_ac_kicker_struct

subroutine tao_jsonify_ac_kicker_freq_struct (input, json_root, depth)
  use bmad_struct, only: ac_kicker_freq_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'amp', input%amp)
  call json%add(json_root, 'f', input%f)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'rf_clock_harmonic', int(input%rf_clock_harmonic))
  
end subroutine tao_jsonify_ac_kicker_freq_struct

subroutine tao_jsonify_ac_kicker_time_struct (input, json_root, depth)
  use bmad_struct, only: ac_kicker_time_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'amp', input%amp)
  call tao_jsonify_spline_struct(input%spline, json_val, depth + 1)
  call json%rename(json_val, 'spline')
  call json%add(json_root, json_val)
  call json%add(json_root, 'time', input%time)
  
end subroutine tao_jsonify_ac_kicker_time_struct

subroutine tao_jsonify_bookkeeping_state_struct (input, json_root, depth)
  use bmad_struct, only: bookkeeping_state_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'attributes', int(input%attributes))
  call json%add(json_root, 'control', int(input%control))
  call json%add(json_root, 'floor_position', int(input%floor_position))
  call json%add(json_root, 'mat6', int(input%mat6))
  call json%add(json_root, 'ptc', int(input%ptc))
  call json%add(json_root, 'rad_int', int(input%rad_int))
  call json%add(json_root, 'ref_energy', int(input%ref_energy))
  call json%add(json_root, 's_position', int(input%s_position))
  
end subroutine tao_jsonify_bookkeeping_state_struct

subroutine tao_jsonify_branch_struct (input, json_root, depth)
  use bmad_struct, only: branch_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_mode_info_struct(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call tao_jsonify_mode_info_struct(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  if (associated(input%ele)) then
    !line=1559 definition='type (ele_struct), pointer :: ele(:) => null()' name='ele' python_name='ele' type='ele_struct' python_type='EleStruct' size=None dimension=':' comment='' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call tao_jsonify_ele_struct(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_from_branch', int(input%ix_from_branch))
  call json%add(json_root, 'ix_from_ele', int(input%ix_from_ele))
  call json%add(json_root, 'ix_to_ele', int(input%ix_to_ele))
  if (associated(input%lat)) then
    call tao_jsonify_lat_struct(input%lat, json_val, depth + 1)
    call json%rename(json_val, 'lat')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'n_ele_max', int(input%n_ele_max))
  call json%add(json_root, 'n_ele_track', int(input%n_ele_track))
  call json%add(json_root, 'name', trim(input%name))
  call tao_jsonify_lat_param_struct(input%param, json_val, depth + 1)
  call json%rename(json_val, 'param')
  call json%add(json_root, json_val)
  call tao_jsonify_ptc_branch1_struct(input%ptc, json_val, depth + 1)
  call json%rename(json_val, 'ptc')
  call json%add(json_root, json_val)
  if (associated(input%wall3d)) then
    !line=1561 definition='type (wall3d_struct), pointer :: wall3d(:) => null()' name='wall3d' python_name='wall3d' type='wall3d_struct' python_type='Wall3dStruct' size=None dimension=':' comment='' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'wall3d')
    do i1 = lbound(input%wall3d, 1), ubound(input%wall3d, 1)
      call tao_jsonify_wall3d_struct(input%wall3d(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_mode_info_struct(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_branch_struct

subroutine tao_jsonify_cartesian_map_struct (input, json_root, depth)
  use bmad_struct, only: cartesian_map_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'field_type', int(input%field_type))
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  if (associated(input%ptr)) then
    call tao_jsonify_cartesian_map_term_struct(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
  !line=710 definition='real(rp) :: r0(3) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='3' comment='Field origin offset.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_cartesian_map_struct

subroutine tao_jsonify_cartesian_map_term_struct (input, json_root, depth)
  use bmad_struct, only: cartesian_map_term_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'file', trim(input%file))
  call json%add(json_root, 'n_link', int(input%n_link))
  if (allocated(input%term)) then
    !line=705 definition='type (cartesian_map_term1_struct), allocatable :: term(:)' name='term' python_name='term' type='cartesian_map_term1_struct' python_type='CartesianMapTerm1Struct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call tao_jsonify_cartesian_map_term1_struct(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_cartesian_map_term_struct

subroutine tao_jsonify_cartesian_map_term1_struct (input, json_root, depth)
  use bmad_struct, only: cartesian_map_term1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'coef', input%coef)
  call json%add(json_root, 'family', int(input%family))
  call json%add(json_root, 'form', int(input%form))
  call json%add(json_root, 'kx', input%kx)
  call json%add(json_root, 'ky', input%ky)
  call json%add(json_root, 'kz', input%kz)
  call json%add(json_root, 'phi_z', input%phi_z)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  
end subroutine tao_jsonify_cartesian_map_term1_struct

subroutine tao_jsonify_controller_struct (input, json_root, depth)
  use bmad_struct, only: controller_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%ramp)) then
    !line=1338 definition='type (control_ramp1_struct), allocatable :: ramp(:)' name='ramp' python_name='ramp' type='control_ramp1_struct' python_type='ControlRamp1Struct' size=None dimension=':' comment='For ramper lord elements' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'ramp')
    do i1 = lbound(input%ramp, 1), ubound(input%ramp, 1)
      call tao_jsonify_control_ramp1_struct(input%ramp(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ramper_lord)) then
    !line=1339 definition='type (ramper_lord_struct), allocatable :: ramper_lord(:)' name='ramper_lord' python_name='ramper_lord' type='ramper_lord_struct' python_type='RamperLordStruct' size=None dimension=':' comment='Ramper lord info for this slave' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'ramper_lord')
    do i1 = lbound(input%ramper_lord, 1), ubound(input%ramper_lord, 1)
      call tao_jsonify_ramper_lord_struct(input%ramper_lord(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%var)) then
    !line=1337 definition='type (control_var1_struct), allocatable :: var(:)' name='var' python_name='var' type='control_var1_struct' python_type='ControlVar1Struct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'var')
    do i1 = lbound(input%var, 1), ubound(input%var, 1)
      call tao_jsonify_control_var1_struct(input%var(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%x_knot)) then
    !line=1340 definition='real(rp), allocatable :: x_knot(:)' name='x_knot' python_name='x_knot' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'x_knot')
    do i1 = lbound(input%x_knot, 1), ubound(input%x_knot, 1)
      call json%create_real(json_val, input%x_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_controller_struct

subroutine tao_jsonify_control_ramp1_struct (input, json_root, depth)
  use bmad_struct, only: control_ramp1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'attribute', trim(input%attribute))
  call json%add(json_root, 'is_controller', input%is_controller)
  call json%add(json_root, 'slave_name', trim(input%slave_name))
  if (allocated(input%stack)) then
    !line=1321 definition='type (expression_atom_struct), allocatable :: stack(:)' name='stack' python_name='stack' type='expression_atom_struct' python_type='ExpressionAtomStruct' size=None dimension=':' comment='Evaluation stack' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call tao_jsonify_expression_atom_struct(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_knot)) then
    !line=1320 definition='real(rp), allocatable :: y_knot(:)' name='y_knot' python_name='y_knot' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'y_knot')
    do i1 = lbound(input%y_knot, 1), ubound(input%y_knot, 1)
      call json%create_real(json_val, input%y_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_control_ramp1_struct

subroutine tao_jsonify_control_var1_struct (input, json_root, depth)
  use bmad_struct, only: control_var1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'old_value', input%old_value)
  call json%add(json_root, 'value', input%value)
  
end subroutine tao_jsonify_control_var1_struct

subroutine tao_jsonify_converter_struct (input, json_root, depth)
  use bmad_struct, only: converter_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%dist)) then
    !line=1294 definition='type (converter_distribution_struct), allocatable :: dist(:)' name='dist' python_name='dist' type='converter_distribution_struct' python_type='ConverterDistributionStruct' size=None dimension=':' comment='Distribution at various thicknesses' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'dist')
    do i1 = lbound(input%dist, 1), ubound(input%dist, 1)
      call tao_jsonify_converter_distribution_struct(input%dist(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'material_type', trim(input%material_type))
  call json%add(json_root, 'species_out', int(input%species_out))
  
end subroutine tao_jsonify_converter_struct

subroutine tao_jsonify_converter_distribution_struct (input, json_root, depth)
  use bmad_struct, only: converter_distribution_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%sub_dist)) then
    !line=1285 definition='type (converter_sub_distribution_struct), allocatable :: sub_dist(:)' name='sub_dist' python_name='sub_dist' type='converter_sub_distribution_struct' python_type='ConverterSubDistributionStruct' size=None dimension=':' comment='Distribution at various pc_in values.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'sub_dist')
    do i1 = lbound(input%sub_dist, 1), ubound(input%sub_dist, 1)
      call tao_jsonify_converter_sub_distribution_struct(input%sub_dist(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'thickness', input%thickness)
  
end subroutine tao_jsonify_converter_distribution_struct

subroutine tao_jsonify_converter_sub_distribution_struct (input, json_root, depth)
  use bmad_struct, only: converter_sub_distribution_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_converter_direction_out_struct(input%dir_out, json_val, depth + 1)
  call json%rename(json_val, 'dir_out')
  call json%add(json_root, json_val)
  call json%add(json_root, 'pc_in', input%pc_in)
  call tao_jsonify_converter_prob_pc_r_struct(input%prob_pc_r, json_val, depth + 1)
  call json%rename(json_val, 'prob_pc_r')
  call json%add(json_root, json_val)
  !line=1263 definition='real(rp) :: spin_in(3)' name='spin_in' python_name='spin_in' type='real' python_type='float' size=None dimension='3' comment='' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'spin_in')
  do i1 = lbound(input%spin_in, 1), ubound(input%spin_in, 1)
    call json%create_real(json_val, input%spin_in(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_converter_sub_distribution_struct

subroutine tao_jsonify_converter_direction_out_struct (input, json_root, depth)
  use bmad_struct, only: converter_direction_out_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_converter_dir_coef_struct(input%alpha_x, json_val, depth + 1)
  call json%rename(json_val, 'alpha_x')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_coef_struct(input%alpha_y, json_val, depth + 1)
  call json%rename(json_val, 'alpha_y')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_coef_struct(input%beta, json_val, depth + 1)
  call json%rename(json_val, 'beta')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_coef_struct(input%c_x, json_val, depth + 1)
  call json%rename(json_val, 'c_x')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_coef_struct(input%dxds_max, json_val, depth + 1)
  call json%rename(json_val, 'dxds_max')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_coef_struct(input%dxds_min, json_val, depth + 1)
  call json%rename(json_val, 'dxds_min')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_coef_struct(input%dyds_max, json_val, depth + 1)
  call json%rename(json_val, 'dyds_max')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_converter_direction_out_struct

subroutine tao_jsonify_converter_dir_coef_struct (input, json_root, depth)
  use bmad_struct, only: converter_dir_coef_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'c0', input%c0)
  if (allocated(input%fit_1d_r)) then
    !line=1246 definition='type (converter_dir_1D_struct), allocatable :: fit_1d_r(:)' name='fit_1d_r' python_name='fit_1d_r' type='converter_dir_1D_struct' python_type='ConverterDir1dStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'fit_1d_r')
    do i1 = lbound(input%fit_1d_r, 1), ubound(input%fit_1d_r, 1)
      call tao_jsonify_converter_dir_1D_struct(input%fit_1d_r(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_converter_dir_2D_struct(input%fit_2d_pc, json_val, depth + 1)
  call json%rename(json_val, 'fit_2d_pc')
  call json%add(json_root, json_val)
  call tao_jsonify_converter_dir_2D_struct(input%fit_2d_r, json_val, depth + 1)
  call json%rename(json_val, 'fit_2d_r')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_converter_dir_coef_struct

subroutine tao_jsonify_converter_dir_1D_struct (input, json_root, depth)
  use bmad_struct, only: converter_dir_1D_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'pc_out', input%pc_out)
  !line=1237 definition='real(rp) :: poly(0:4) = 0' name='poly' python_name='poly' type='real' python_type='float' size=None dimension='0:4' comment='param(r) = Sum: poly(i) * r^i' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'poly')
  do i1 = lbound(input%poly, 1), ubound(input%poly, 1)
    call json%create_real(json_val, input%poly(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_converter_dir_1D_struct

subroutine tao_jsonify_converter_dir_2D_struct (input, json_root, depth)
  use bmad_struct, only: converter_dir_2D_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'k', input%k)
  !line=1242 definition='real(rp) :: poly(0:3) = 0' name='poly' python_name='poly' type='real' python_type='float' size=None dimension='0:3' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'poly')
  do i1 = lbound(input%poly, 1), ubound(input%poly, 1)
    call json%create_real(json_val, input%poly(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_converter_dir_2D_struct

subroutine tao_jsonify_converter_prob_pc_r_struct (input, json_root, depth)
  use bmad_struct, only: converter_prob_pc_r_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%integ_pc_out)) then
    !line=1228 definition='real(rp), allocatable :: integ_pc_out(:)' name='integ_pc_out' python_name='integ_pc_out' type='real' python_type='float' size=None dimension=':' comment='Normalized probability integrated from min pc_out up.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'integ_pc_out')
    do i1 = lbound(input%integ_pc_out, 1), ubound(input%integ_pc_out, 1)
      call json%create_real(json_val, input%integ_pc_out(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%integ_r)) then
    !line=1229 definition='real(rp), allocatable :: integ_r(:,:)' name='integ_r' python_name='integ_r' type='real' python_type='float' size=None dimension=':,:' comment='' fortran_default=None default=0.0 default_factory=''
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
    !line=1230 definition='real(rp), allocatable :: integ_r_ave(:)' name='integ_r_ave' python_name='integ_r_ave' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'integ_r_ave')
    do i1 = lbound(input%integ_r_ave, 1), ubound(input%integ_r_ave, 1)
      call json%create_real(json_val, input%integ_r_ave(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'integrated_prob', input%integrated_prob)
  if (allocated(input%p_norm)) then
    !line=1226 definition='real(rp), allocatable :: p_norm(:,:)' name='p_norm' python_name='p_norm' type='real' python_type='float' size=None dimension=':,:' comment='Normalized probability taking into account. angle_out_max, pc_out_min, and pc_out_max restrictions.' fortran_default=None default=0.0 default_factory=''
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
  if (allocated(input%pc_out)) then
    !line=1219 definition='real(rp), allocatable :: pc_out(:)' name='pc_out' python_name='pc_out' type='real' python_type='float' size=None dimension=':' comment='Grid pc_out values.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'pc_out')
    do i1 = lbound(input%pc_out, 1), ubound(input%pc_out, 1)
      call json%create_real(json_val, input%pc_out(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'pc_out_max', input%pc_out_max)
  call json%add(json_root, 'pc_out_min', input%pc_out_min)
  if (allocated(input%prob)) then
    !line=1221 definition='real(rp), allocatable :: prob(:,:)' name='prob' python_name='prob' type='real' python_type='float' size=None dimension=':,:' comment='Probability grid.' fortran_default=None default=0.0 default_factory=''
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
  if (allocated(input%r)) then
    !line=1220 definition='real(rp), allocatable :: r(:)' name='r' python_name='r' type='real' python_type='float' size=None dimension=':' comment='Grid r_out values.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'r')
    do i1 = lbound(input%r, 1), ubound(input%r, 1)
      call json%create_real(json_val, input%r(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%spin_z)) then
    !line=1222 definition='real(rp), allocatable :: spin_z(:,:)' name='spin_z' python_name='spin_z' type='real' python_type='float' size=None dimension=':,:' comment='Z polarization grid. Stuff below is calculated rather than read in from the lattice file.' fortran_default=None default=0.0 default_factory=''
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
  
end subroutine tao_jsonify_converter_prob_pc_r_struct

subroutine tao_jsonify_coord_struct (input, json_root, depth)
  use bmad_struct, only: coord_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'e_potential', input%E_potential)
  call json%add(json_root, 'beta', input%beta)
  call json%add(json_root, 'charge', input%charge)
  call json%add(json_root, 'direction', int(input%direction))
  call json%add(json_root, 'dt_ref', input%dt_ref)
  !line=534 definition='real(rp) :: field(2) = 0' name='field' python_name='field' type='real' python_type='float' size=None dimension='2' comment='Photon E-field intensity (x,y).' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'field')
  do i1 = lbound(input%field, 1), ubound(input%field, 1)
    call json%create_real(json_val, input%field(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_turn', int(input%ix_turn))
  call json%add(json_root, 'ix_user', int(input%ix_user))
  call json%add(json_root, 'location', int(input%location))
  call json%add(json_root, 'p0c', input%p0c)
  !line=535 definition='real(rp) :: phase(2) = 0' name='phase' python_name='phase' type='real' python_type='float' size=None dimension='2' comment='Photon E-field phase (x,y). phase(1) is also used with RF-time tracking to record the number of RF cycles.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'phase')
  do i1 = lbound(input%phase, 1), ubound(input%phase, 1)
    call json%create_real(json_val, input%phase(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'r', input%r)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'species', int(input%species))
  !line=533 definition='real(rp) :: spin(3) = 0' name='spin' python_name='spin' type='real' python_type='float' size=None dimension='3' comment='Spin.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'spin')
  do i1 = lbound(input%spin, 1), ubound(input%spin, 1)
    call json%create_real(json_val, input%spin(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'state', int(input%state))
  call json%add(json_root, 't', input%t)
  call json%add(json_root, 'time_dir', int(input%time_dir))
  !line=529 definition='real(rp) :: vec(6) = 0' name='vec' python_name='vec' type='real' python_type='float' size=None dimension='6' comment='(x, px, y, py, z, pz). Generally phase space for charged particles. See Bmad manual.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'vec')
  do i1 = lbound(input%vec, 1), ubound(input%vec, 1)
    call json%create_real(json_val, input%vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_coord_struct

subroutine tao_jsonify_cylindrical_map_struct (input, json_root, depth)
  use bmad_struct, only: cylindrical_map_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'dz', input%dz)
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'harmonic', int(input%harmonic))
  call json%add(json_root, 'm', int(input%m))
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  call json%add(json_root, 'phi0_fieldmap', input%phi0_fieldmap)
  if (associated(input%ptr)) then
    call tao_jsonify_cylindrical_map_term_struct(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
  !line=739 definition='real(rp) :: r0(3) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='3' comment='Field origin offset.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'theta0_azimuth', input%theta0_azimuth)
  
end subroutine tao_jsonify_cylindrical_map_struct

subroutine tao_jsonify_cylindrical_map_term_struct (input, json_root, depth)
  use bmad_struct, only: cylindrical_map_term_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'file', trim(input%file))
  call json%add(json_root, 'n_link', int(input%n_link))
  if (allocated(input%term)) then
    !line=727 definition='type (cylindrical_map_term1_struct), allocatable :: term(:)' name='term' python_name='term' type='cylindrical_map_term1_struct' python_type='CylindricalMapTerm1Struct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call tao_jsonify_cylindrical_map_term1_struct(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_cylindrical_map_term_struct

subroutine tao_jsonify_cylindrical_map_term1_struct (input, json_root, depth)
  use bmad_struct, only: cylindrical_map_term1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%b_coef, json_list1, depth+1)
  call json%rename(json_list1, 'b_coef')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%e_coef, json_list1, depth+1)
  call json%rename(json_list1, 'e_coef')
  call json%add(json_root, json_list1)
  
end subroutine tao_jsonify_cylindrical_map_term1_struct

subroutine tao_jsonify_expression_atom_struct (input, json_root, depth)
  use bmad_struct, only: expression_atom_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'value', input%value)
  
end subroutine tao_jsonify_expression_atom_struct

subroutine tao_jsonify_floor_position_struct (input, json_root, depth)
  use bmad_struct, only: floor_position_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'psi', input%psi)
  !line=823 definition='real(rp) :: r(3) = 0' name='r' python_name='r' type='real' python_type='float' size=None dimension='3' comment='(x, y, z) offset from origin' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'theta', input%theta)
  !line=824 definition='real(rp) :: w(3,3) =  mat3_unit$' name='w' python_name='w' type='real' python_type='float' size=None dimension='3,3' comment='W matrix. Columns are unit vectors of the frame axes.' fortran_default='mat3_unit$' default=0.0 default_factory=''
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
  
end subroutine tao_jsonify_floor_position_struct

subroutine tao_jsonify_foil_struct (input, json_root, depth)
  use bmad_struct, only: foil_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%material)) then
    !line=1278 definition='type (material_struct), allocatable :: material(:)' name='material' python_name='material' type='material_struct' python_type='MaterialStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'material')
    do i1 = lbound(input%material, 1), ubound(input%material, 1)
      call tao_jsonify_material_struct(input%material(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_foil_struct

subroutine tao_jsonify_gen_grad_map_struct (input, json_root, depth)
  use bmad_struct, only: gen_grad_map_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'curved_ref_frame', input%curved_ref_frame)
  call json%add(json_root, 'dz', input%dz)
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'field_type', int(input%field_type))
  call json%add(json_root, 'file', trim(input%file))
  if (allocated(input%gg)) then
    !line=755 definition='type (gen_grad1_struct), allocatable :: gg(:)' name='gg' python_name='gg' type='gen_grad1_struct' python_type='GenGrad1Struct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'gg')
    do i1 = lbound(input%gg, 1), ubound(input%gg, 1)
      call tao_jsonify_gen_grad1_struct(input%gg(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'iz0', int(input%iz0))
  call json%add(json_root, 'iz1', int(input%iz1))
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  !line=761 definition='real(rp) :: r0(3) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='3' comment='field origin relative to ele_anchor_pt.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_gen_grad_map_struct

subroutine tao_jsonify_gen_grad1_struct (input, json_root, depth)
  use bmad_struct, only: gen_grad1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%deriv)) then
    !line=750 definition='real(rp), allocatable :: deriv(:,:)' name='deriv' python_name='deriv' type='real' python_type='float' size=None dimension=':,:' comment='Range: (iz0:iz1, 0:2*n_deriv_max+1)' fortran_default=None default=0.0 default_factory=''
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
  call json%add(json_root, 'm', int(input%m))
  call json%add(json_root, 'n_deriv_max', int(input%n_deriv_max))
  call json%add(json_root, 'sincos', int(input%sincos))
  
end subroutine tao_jsonify_gen_grad1_struct

subroutine tao_jsonify_grid_field_struct (input, json_root, depth)
  use bmad_struct, only: grid_field_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=793 definition='type (bicubic_cmplx_coef_struct) bi_coef(4, 2, 3)' name='bi_coef' python_name='bi_coef' type='bicubic_cmplx_coef_struct' python_type='BicubicCmplxCoefStruct' size=None dimension='4, 2, 3' comment='Save computed coefs for faster tracking' fortran_default=None default=None default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%bi_coef, 3), ubound(input%bi_coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%bi_coef, 2), ubound(input%bi_coef, 2)
      call json%create_array(json_list1, 'bi_coef')
      do i1 = lbound(input%bi_coef, 1), ubound(input%bi_coef, 1)
        call tao_jsonify_bicubic_cmplx_coef_struct(input%bi_coef(i1, i2, i3), json_val, depth + 1)
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
  call json%add(json_root, 'curved_ref_frame', input%curved_ref_frame)
  !line=789 definition='real(rp) :: dr(3) = 0' name='dr' python_name='dr' type='real' python_type='float' size=None dimension='3' comment='Grid spacing.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'field_scale', input%field_scale)
  call json%add(json_root, 'field_type', int(input%field_type))
  call json%add(json_root, 'geometry', int(input%geometry))
  call json%add(json_root, 'harmonic', int(input%harmonic))
  call json%add(json_root, 'interpolation_order', int(input%interpolation_order))
  call json%add(json_root, 'master_parameter', int(input%master_parameter))
  call json%add(json_root, 'phi0_fieldmap', input%phi0_fieldmap)
  if (associated(input%ptr)) then
    call tao_jsonify_grid_field_pt_struct(input%ptr, json_val, depth + 1)
    call json%rename(json_val, 'ptr')
    call json%add(json_root, json_val)
  endif
  !line=790 definition='real(rp) :: r0(3) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='3' comment='Field origin relative to ele_anchor_pt.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=794 definition='type (tricubic_cmplx_coef_struct) tri_coef(4, 2, 3)' name='tri_coef' python_name='tri_coef' type='tricubic_cmplx_coef_struct' python_type='TricubicCmplxCoefStruct' size=None dimension='4, 2, 3' comment='Save computed coefs for faster tracking' fortran_default=None default=None default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%tri_coef, 3), ubound(input%tri_coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%tri_coef, 2), ubound(input%tri_coef, 2)
      call json%create_array(json_list1, 'tri_coef')
      do i1 = lbound(input%tri_coef, 1), ubound(input%tri_coef, 1)
        call tao_jsonify_tricubic_cmplx_coef_struct(input%tri_coef(i1, i2, i3), json_val, depth + 1)
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
  
end subroutine tao_jsonify_grid_field_struct

subroutine tao_jsonify_bicubic_cmplx_coef_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=71 definition='complex(rp) :: coef(0:3,0:3) = 0' name='coef' python_name='coef' type='complex' python_type='Complex' size=None dimension='0:3,0:3' comment='Coefs' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%coef, 2), ubound(input%coef, 2)
    call json%create_array(json_list1, 'coef')
    do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
      call tao_jsonify_complex(input%coef(i1, i2), json_val, depth + 1)
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
  
end subroutine tao_jsonify_bicubic_cmplx_coef_struct

subroutine tao_jsonify_grid_field_pt_struct (input, json_root, depth)
  use bmad_struct, only: grid_field_pt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'file', trim(input%file))
  call json%add(json_root, 'n_link', int(input%n_link))
  if (allocated(input%pt)) then
    !line=777 definition='type (grid_field_pt1_struct), allocatable :: pt(:,:,:)' name='pt' python_name='pt' type='grid_field_pt1_struct' python_type='GridFieldPt1Struct' size=None dimension=':,:,:' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list3, 'dim-3')
    do i3 = lbound(input%pt, 3), ubound(input%pt, 3)
      call json%create_array(json_list2, 'dim-2')
      do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
        call json%create_array(json_list1, 'pt')
        do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
          call tao_jsonify_grid_field_pt1_struct(input%pt(i1, i2, i3), json_val, depth + 1)
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
  
end subroutine tao_jsonify_grid_field_pt_struct

subroutine tao_jsonify_grid_field_pt1_struct (input, json_root, depth)
  use bmad_struct, only: grid_field_pt1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=771 definition='complex(rp) :: B(3) = 0' name='B' python_name='b' type='complex' python_type='Complex' size=None dimension='3' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'b')
  do i1 = lbound(input%B, 1), ubound(input%B, 1)
    call tao_jsonify_complex(input%B(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=770 definition='complex(rp) :: E(3) = 0' name='E' python_name='e' type='complex' python_type='Complex' size=None dimension='3' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'e')
  do i1 = lbound(input%E, 1), ubound(input%E, 1)
    call tao_jsonify_complex(input%E(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_grid_field_pt1_struct

subroutine tao_jsonify_high_energy_space_charge_struct (input, json_root, depth)
  use bmad_struct, only: high_energy_space_charge_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_coord_struct(input%closed_orb, json_val, depth + 1)
  call json%rename(json_val, 'closed_orb')
  call json%add(json_root, json_val)
  call json%add(json_root, 'cos_phi', input%cos_phi)
  call json%add(json_root, 'kick_const', input%kick_const)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'sig_x', input%sig_x)
  call json%add(json_root, 'sig_y', input%sig_y)
  call json%add(json_root, 'sig_z', input%sig_z)
  call json%add(json_root, 'sin_phi', input%sin_phi)
  
end subroutine tao_jsonify_high_energy_space_charge_struct

subroutine tao_jsonify_lat_ele_loc_struct (input, json_root, depth)
  use bmad_struct, only: lat_ele_loc_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  
end subroutine tao_jsonify_lat_ele_loc_struct

subroutine tao_jsonify_lat_param_struct (input, json_root, depth)
  use bmad_struct, only: lat_param_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_beam_init_struct(input%beam_init, json_val, depth + 1)
  call json%rename(json_val, 'beam_init')
  call json%add(json_root, json_val)
  call tao_jsonify_bookkeeping_state_struct(input%bookkeeping_state, json_val, depth + 1)
  call json%rename(json_val, 'bookkeeping_state')
  call json%add(json_root, json_val)
  call json%add(json_root, 'default_tracking_species', int(input%default_tracking_species))
  call json%add(json_root, 'g1_integral', input%g1_integral)
  call json%add(json_root, 'g2_integral', input%g2_integral)
  call json%add(json_root, 'g3_integral', input%g3_integral)
  call json%add(json_root, 'geometry', int(input%geometry))
  call json%add(json_root, 'ixx', int(input%ixx))
  call json%add(json_root, 'live_branch', input%live_branch)
  call json%add(json_root, 'n_part', input%n_part)
  call json%add(json_root, 'particle', int(input%particle))
  call json%add(json_root, 'spin_tune', input%spin_tune)
  call json%add(json_root, 'stable', input%stable)
  !line=1472 definition='real(rp) :: t1_no_RF(6,6) = 0' name='t1_no_RF' python_name='t1_no_rf' type='real' python_type='float' size=None dimension='6,6' comment='Full 1-turn matrix with RF off.' fortran_default='0' default=0 default_factory=''
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
  !line=1471 definition='real(rp) :: t1_with_RF(6,6) = 0' name='t1_with_RF' python_name='t1_with_rf' type='real' python_type='float' size=None dimension='6,6' comment='Full 1-turn matrix with RF on.' fortran_default='0' default=0 default_factory=''
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
  call json%add(json_root, 'total_length', input%total_length)
  call json%add(json_root, 'unstable_factor', input%unstable_factor)
  
end subroutine tao_jsonify_lat_param_struct

subroutine tao_jsonify_beam_init_struct (input, json_root, depth)
  use bmad_struct, only: beam_init_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_kv_beam_init_struct(input%KV, json_val, depth + 1)
  call json%rename(json_val, 'KV')
  call json%add(json_root, json_val)
  call json%add(json_root, 'a_emit', input%a_emit)
  call json%add(json_root, 'a_norm_emit', input%a_norm_emit)
  call json%add(json_root, 'b_emit', input%b_emit)
  call json%add(json_root, 'b_norm_emit', input%b_norm_emit)
  call json%add(json_root, 'bunch_charge', input%bunch_charge)
  !line=1153 definition='real(rp) :: center(6) = 0' name='center' python_name='center' type='real' python_type='float' size=None dimension='6' comment='Bench phase space center offset relative to reference.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'center')
  do i1 = lbound(input%center, 1), ubound(input%center, 1)
    call json%create_real(json_val, input%center(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1137 definition='real(rp) :: center_jitter(6) = 0.0' name='center_jitter' python_name='center_jitter' type='real' python_type='float' size=None dimension='6' comment='Bunch center rms jitter' fortran_default='0.0' default=0.0 default_factory=''
  call json%create_array(json_list1, 'center_jitter')
  do i1 = lbound(input%center_jitter, 1), ubound(input%center_jitter, 1)
    call json%create_real(json_val, input%center_jitter(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dpz_dz', input%dPz_dz)
  !line=1131 definition="character(16) :: distribution_type(3) = ''" name='distribution_type' python_name='distribution_type' type='character' python_type='str' size='16' dimension='3' comment='distribution type (in x-px, y-py, and z-pz planes) "ELLIPSE", "KV", "GRID", "FILE", "RAN_GAUSS" or "" = "RAN_GAUSS"' fortran_default="''" default='' default_factory=''
  call json%create_array(json_list1, 'distribution_type')
  do i1 = lbound(input%distribution_type, 1), ubound(input%distribution_type, 1)
    call json%create_string(json_val, trim(input%distribution_type(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'dt_bunch', input%dt_bunch)
  !line=1134 definition='type (ellipse_beam_init_struct) :: ellipse(3) = ellipse_beam_init_struct()' name='ellipse' python_name='ellipse' type='ellipse_beam_init_struct' python_type='EllipseBeamInitStruct' size=None dimension='3' comment='Ellipse beam distribution' fortran_default='ellipse_beam_init_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'ellipse')
  do i1 = lbound(input%ellipse, 1), ubound(input%ellipse, 1)
    call tao_jsonify_ellipse_beam_init_struct(input%ellipse(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1138 definition='real(rp) :: emit_jitter(2)   = 0.0' name='emit_jitter' python_name='emit_jitter' type='real' python_type='float' size=None dimension='2' comment='a and b bunch emittance rms jitter normalized to emittance' fortran_default='0.0' default=0.0 default_factory=''
  call json%create_array(json_list1, 'emit_jitter')
  do i1 = lbound(input%emit_jitter, 1), ubound(input%emit_jitter, 1)
    call json%create_real(json_val, input%emit_jitter(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'full_6d_coupling_calc', input%full_6D_coupling_calc)
  !line=1136 definition='type (grid_beam_init_struct) :: grid(3) = grid_beam_init_struct()' name='grid' python_name='grid' type='grid_beam_init_struct' python_type='GridBeamInitStruct' size=None dimension='3' comment='Grid beam distribution' fortran_default='grid_beam_init_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'grid')
  do i1 = lbound(input%grid, 1), ubound(input%grid, 1)
    call tao_jsonify_grid_beam_init_struct(input%grid(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ix_turn', int(input%ix_turn))
  call json%add(json_root, 'n_bunch', int(input%n_bunch))
  call json%add(json_root, 'n_particle', int(input%n_particle))
  call json%add(json_root, 'position_file', trim(input%position_file))
  call json%add(json_root, 'random_engine', trim(input%random_engine))
  call json%add(json_root, 'random_gauss_converter', trim(input%random_gauss_converter))
  call json%add(json_root, 'random_sigma_cutoff', input%random_sigma_cutoff)
  call json%add(json_root, 'renorm_center', input%renorm_center)
  call json%add(json_root, 'renorm_sigma', input%renorm_sigma)
  call json%add(json_root, 'sig_pz', input%sig_pz)
  call json%add(json_root, 'sig_pz_jitter', input%sig_pz_jitter)
  call json%add(json_root, 'sig_z', input%sig_z)
  call json%add(json_root, 'sig_z_jitter', input%sig_z_jitter)
  call json%add(json_root, 'species', trim(input%species))
  !line=1133 definition='real(rp) :: spin(3) = 0' name='spin' python_name='spin' type='real' python_type='float' size=None dimension='3' comment='Spin (x, y, z)' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'spin')
  do i1 = lbound(input%spin, 1), ubound(input%spin, 1)
    call json%create_real(json_val, input%spin(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 't_offset', input%t_offset)
  call json%add(json_root, 'use_particle_start', input%use_particle_start)
  call json%add(json_root, 'use_t_coords', input%use_t_coords)
  call json%add(json_root, 'use_z_as_t', input%use_z_as_t)
  
end subroutine tao_jsonify_beam_init_struct

subroutine tao_jsonify_ellipse_beam_init_struct (input, json_root, depth)
  use bmad_struct, only: ellipse_beam_init_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'n_ellipse', int(input%n_ellipse))
  call json%add(json_root, 'part_per_ellipse', int(input%part_per_ellipse))
  call json%add(json_root, 'sigma_cutoff', input%sigma_cutoff)
  
end subroutine tao_jsonify_ellipse_beam_init_struct

subroutine tao_jsonify_grid_beam_init_struct (input, json_root, depth)
  use bmad_struct, only: grid_beam_init_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'n_px', int(input%n_px))
  call json%add(json_root, 'n_x', int(input%n_x))
  call json%add(json_root, 'px_max', input%px_max)
  call json%add(json_root, 'px_min', input%px_min)
  call json%add(json_root, 'x_max', input%x_max)
  call json%add(json_root, 'x_min', input%x_min)
  
end subroutine tao_jsonify_grid_beam_init_struct

subroutine tao_jsonify_kv_beam_init_struct (input, json_root, depth)
  use bmad_struct, only: kv_beam_init_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'a', input%A)
  call json%add(json_root, 'n_i2', int(input%n_I2))
  !line=1115 definition='integer :: part_per_phi(2) = 0' name='part_per_phi' python_name='part_per_phi' type='integer' python_type='int' size=None dimension='2' comment='number of particles per angle variable.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'part_per_phi')
  do i1 = lbound(input%part_per_phi, 1), ubound(input%part_per_phi, 1)
    call json%create_integer(json_val, input%part_per_phi(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_kv_beam_init_struct

subroutine tao_jsonify_lat_struct (input, json_root, depth)
  use bmad_struct, only: lat_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%a)) then
    call tao_jsonify_mode_info_struct(input%a, json_val, depth + 1)
    call json%rename(json_val, 'a')
    call json%add(json_root, json_val)
  endif
  if (associated(input%b)) then
    call tao_jsonify_mode_info_struct(input%b, json_val, depth + 1)
    call json%rename(json_val, 'b')
    call json%add(json_root, json_val)
  endif
  call tao_jsonify_beam_init_struct(input%beam_init, json_val, depth + 1)
  call json%rename(json_val, 'beam_init')
  call json%add(json_root, json_val)
  if (allocated(input%branch)) then
    !line=1597 definition='type (branch_struct), allocatable :: branch(:)' name='branch' python_name='branch' type='branch_struct' python_type='BranchStruct' size=None dimension=':' comment='Branch(0:) array' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call tao_jsonify_branch_struct(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%constant)) then
    !line=1591 definition='type (expression_atom_struct), allocatable :: constant(:)' name='constant' python_name='constant' type='expression_atom_struct' python_type='ExpressionAtomStruct' size=None dimension=':' comment='Constants defined in the lattice' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'constant')
    do i1 = lbound(input%constant, 1), ubound(input%constant, 1)
      call tao_jsonify_expression_atom_struct(input%constant(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%control)) then
    !line=1598 definition='type (control_struct), allocatable :: control(:)' name='control' python_name='control' type='control_struct' python_type='ControlStruct' size=None dimension=':' comment='Control list' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'control')
    do i1 = lbound(input%control, 1), ubound(input%control, 1)
      call tao_jsonify_control_struct(input%control(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'creation_hash', int(input%creation_hash))
  if (allocated(input%custom)) then
    !line=1603 definition='real(rp), allocatable :: custom(:)' name='custom' python_name='custom' type='real' python_type='float' size=None dimension=':' comment='Custom attributes.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'custom')
    do i1 = lbound(input%custom, 1), ubound(input%custom, 1)
      call json%create_real(json_val, input%custom(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%ele)) then
    !line=1596 definition='type (ele_struct), pointer ::  ele(:) => null()' name='ele' python_name='ele' type='ele_struct' python_type='EleStruct' size=None dimension=':' comment='Array of elements [=> branch(0)].' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call tao_jsonify_ele_struct(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_ele_struct(input%ele_init, json_val, depth + 1)
  call json%rename(json_val, 'ele_init')
  call json%add(json_root, json_val)
  if (allocated(input%ic)) then
    !line=1610 definition='integer, allocatable :: ic(:)' name='ic' python_name='ic' type='integer, allocatable' python_type='int' size=None dimension=':' comment='Index to %control(:) from slaves.' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'ic')
    do i1 = lbound(input%ic, 1), ubound(input%ic, 1)
      call json%create_integer(json_val, input%ic(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'input_file_name', trim(input%input_file_name))
  call json%add(json_root, 'input_taylor_order', int(input%input_taylor_order))
  call json%add(json_root, 'lattice', trim(input%lattice))
  call tao_jsonify_bookkeeping_state_struct(input%lord_state, json_val, depth + 1)
  call json%rename(json_val, 'lord_state')
  call json%add(json_root, json_val)
  call json%add(json_root, 'machine', trim(input%machine))
  call json%add(json_root, 'n_control_max', int(input%n_control_max))
  if (associated(input%n_ele_max)) then
    call json%add(json_root, 'n_ele_max', int(input%n_ele_max))
  endif
  if (associated(input%n_ele_track)) then
    call json%add(json_root, 'n_ele_track', int(input%n_ele_track))
  endif
  call json%add(json_root, 'n_ic_max', int(input%n_ic_max))
  call tao_jsonify_nametable_struct(input%nametable, json_val, depth + 1)
  call json%rename(json_val, 'nametable')
  call json%add(json_root, json_val)
  if (associated(input%param)) then
    call tao_jsonify_lat_param_struct(input%param, json_val, depth + 1)
    call json%rename(json_val, 'param')
    call json%add(json_root, json_val)
  endif
  call tao_jsonify_coord_struct(input%particle_start, json_val, depth + 1)
  call json%rename(json_val, 'particle_start')
  call json%add(json_root, json_val)
  call json%add(json_root, 'photon_type', int(input%photon_type))
  call tao_jsonify_pre_tracker_struct(input%pre_tracker, json_val, depth + 1)
  call json%rename(json_val, 'pre_tracker')
  call json%add(json_root, json_val)
  if (allocated(input%print_str)) then
    !line=1590 definition='character(100), allocatable :: print_str(:)' name='print_str' python_name='print_str' type='character' python_type='str' size='100' dimension=':' comment='Saved print statements.' fortran_default=None default='' default_factory='list'
    call json%create_array(json_list1, 'print_str')
    do i1 = lbound(input%print_str, 1), ubound(input%print_str, 1)
      call json%create_string(json_val, trim(input%print_str(i1)), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ramper_slave_bookkeeping', int(input%ramper_slave_bookkeeping))
  call json%add(json_root, 'title', trim(input%title))
  call json%add(json_root, 'use_name', trim(input%use_name))
  call json%add(json_root, 'version', int(input%version))
  if (associated(input%z)) then
    call tao_jsonify_mode_info_struct(input%z, json_val, depth + 1)
    call json%rename(json_val, 'z')
    call json%add(json_root, json_val)
  endif
  
end subroutine tao_jsonify_lat_struct

subroutine tao_jsonify_control_struct (input, json_root, depth)
  use bmad_struct, only: control_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'attribute', trim(input%attribute))
  call json%add(json_root, 'ix_attrib', int(input%ix_attrib))
  call tao_jsonify_lat_ele_loc_struct(input%lord, json_val, depth + 1)
  call json%rename(json_val, 'lord')
  call json%add(json_root, json_val)
  call tao_jsonify_lat_ele_loc_struct(input%slave, json_val, depth + 1)
  call json%rename(json_val, 'slave')
  call json%add(json_root, json_val)
  call json%add(json_root, 'slave_name', trim(input%slave_name))
  if (allocated(input%stack)) then
    !line=1304 definition='type (expression_atom_struct), allocatable :: stack(:)' name='stack' python_name='stack' type='expression_atom_struct' python_type='ExpressionAtomStruct' size=None dimension=':' comment='Evaluation stack' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call tao_jsonify_expression_atom_struct(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'value', input%value)
  if (allocated(input%y_knot)) then
    !line=1303 definition='real(rp), allocatable :: y_knot(:)' name='y_knot' python_name='y_knot' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'y_knot')
    do i1 = lbound(input%y_knot, 1), ubound(input%y_knot, 1)
      call json%create_real(json_val, input%y_knot(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_control_struct

subroutine tao_jsonify_material_struct (input, json_root, depth)
  use bmad_struct, only: material_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'area_density', input%area_density)
  call json%add(json_root, 'area_density_used', input%area_density_used)
  call json%add(json_root, 'density', input%density)
  call json%add(json_root, 'density_used', input%density_used)
  call json%add(json_root, 'radiation_length', input%radiation_length)
  call json%add(json_root, 'radiation_length_used', input%radiation_length_used)
  call json%add(json_root, 'species', int(input%species))
  
end subroutine tao_jsonify_material_struct

subroutine tao_jsonify_mode3_struct (input, json_root, depth)
  use bmad_struct, only: mode3_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_twiss_struct(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%c, json_val, depth + 1)
  call json%rename(json_val, 'c')
  call json%add(json_root, json_val)
  !line=911 definition='real(rp) v(6,6)' name='v' python_name='v' type='real' python_type='float' size=None dimension='6,6' comment='' fortran_default=None default=0.0 default_factory=''
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
  call tao_jsonify_twiss_struct(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_mode3_struct

subroutine tao_jsonify_mode_info_struct (input, json_root, depth)
  use bmad_struct, only: mode_info_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'chrom', input%chrom)
  call json%add(json_root, 'emit', input%emit)
  call json%add(json_root, 'sigma', input%sigma)
  call json%add(json_root, 'sigmap', input%sigmap)
  call json%add(json_root, 'stable', input%stable)
  call json%add(json_root, 'tune', input%tune)
  
end subroutine tao_jsonify_mode_info_struct

subroutine tao_jsonify_multipole_cache_struct (input, json_root, depth)
  use bmad_struct, only: multipole_cache_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%a_kick_elec)) then
    !line=948 definition='real(rp), allocatable :: a_kick_elec(:), b_kick_elec(:)' name='a_kick_elec' python_name='a_kick_elec' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'a_kick_elec')
    do i1 = lbound(input%a_kick_elec, 1), ubound(input%a_kick_elec, 1)
      call json%create_real(json_val, input%a_kick_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%a_kick_mag)) then
    !line=943 definition='real(rp), allocatable :: a_kick_mag(:), b_kick_mag(:)' name='a_kick_mag' python_name='a_kick_mag' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'a_kick_mag')
    do i1 = lbound(input%a_kick_mag, 1), ubound(input%a_kick_mag, 1)
      call json%create_real(json_val, input%a_kick_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%a_pole_elec)) then
    !line=947 definition='real(rp), allocatable :: a_pole_elec(:), b_pole_elec(:)' name='a_pole_elec' python_name='a_pole_elec' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'a_pole_elec')
    do i1 = lbound(input%a_pole_elec, 1), ubound(input%a_pole_elec, 1)
      call json%create_real(json_val, input%a_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%a_pole_mag)) then
    !line=942 definition='real(rp), allocatable :: a_pole_mag(:), b_pole_mag(:)' name='a_pole_mag' python_name='a_pole_mag' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'a_pole_mag')
    do i1 = lbound(input%a_pole_mag, 1), ubound(input%a_pole_mag, 1)
      call json%create_real(json_val, input%a_pole_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_kick_elec)) then
    !line=948 definition='real(rp), allocatable :: a_kick_elec(:), b_kick_elec(:)' name='b_kick_elec' python_name='b_kick_elec' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'b_kick_elec')
    do i1 = lbound(input%b_kick_elec, 1), ubound(input%b_kick_elec, 1)
      call json%create_real(json_val, input%b_kick_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_kick_mag)) then
    !line=943 definition='real(rp), allocatable :: a_kick_mag(:), b_kick_mag(:)' name='b_kick_mag' python_name='b_kick_mag' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'b_kick_mag')
    do i1 = lbound(input%b_kick_mag, 1), ubound(input%b_kick_mag, 1)
      call json%create_real(json_val, input%b_kick_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_pole_elec)) then
    !line=947 definition='real(rp), allocatable :: a_pole_elec(:), b_pole_elec(:)' name='b_pole_elec' python_name='b_pole_elec' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'b_pole_elec')
    do i1 = lbound(input%b_pole_elec, 1), ubound(input%b_pole_elec, 1)
      call json%create_real(json_val, input%b_pole_elec(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%b_pole_mag)) then
    !line=942 definition='real(rp), allocatable :: a_pole_mag(:), b_pole_mag(:)' name='b_pole_mag' python_name='b_pole_mag' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'b_pole_mag')
    do i1 = lbound(input%b_pole_mag, 1), ubound(input%b_pole_mag, 1)
      call json%create_real(json_val, input%b_pole_mag(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'elec_valid', input%elec_valid)
  call json%add(json_root, 'ix_kick_elec_max', int(input%ix_kick_elec_max))
  call json%add(json_root, 'ix_kick_mag_max', int(input%ix_kick_mag_max))
  call json%add(json_root, 'ix_pole_elec_max', int(input%ix_pole_elec_max))
  call json%add(json_root, 'ix_pole_mag_max', int(input%ix_pole_mag_max))
  call json%add(json_root, 'mag_valid', input%mag_valid)
  
end subroutine tao_jsonify_multipole_cache_struct

subroutine tao_jsonify_nametable_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%index)) then
    !line=36 definition='integer, allocatable :: index(:)' name='index' python_name='index' type='integer, allocatable' python_type='int' size=None dimension=':' comment='Sorted index for names(:) array. names(an_index(i)) is in alphabetical order.' fortran_default=None default=0 default_factory=''
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
  
end subroutine tao_jsonify_nametable_struct

subroutine tao_jsonify_photon_element_struct (input, json_root, depth)
  use bmad_struct, only: photon_element_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_surface_curvature_struct(input%curvature, json_val, depth + 1)
  call json%rename(json_val, 'curvature')
  call json%add(json_root, json_val)
  call tao_jsonify_surface_displacement_struct(input%displacement, json_val, depth + 1)
  call json%rename(json_val, 'displacement')
  call json%add(json_root, json_val)
  call tao_jsonify_surface_h_misalign_struct(input%h_misalign, json_val, depth + 1)
  call json%rename(json_val, 'h_misalign')
  call json%add(json_root, json_val)
  if (allocated(input%init_energy_prob)) then
    !line=1077 definition='type (spline_struct), allocatable :: init_energy_prob(:)' name='init_energy_prob' python_name='init_energy_prob' type='spline_struct' python_type='SplineStruct' size=None dimension=':' comment='Initial energy probability density' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'init_energy_prob')
    do i1 = lbound(input%init_energy_prob, 1), ubound(input%init_energy_prob, 1)
      call tao_jsonify_spline_struct(input%init_energy_prob(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%integrated_init_energy_prob)) then
    !line=1078 definition='real(rp), allocatable :: integrated_init_energy_prob(:)' name='integrated_init_energy_prob' python_name='integrated_init_energy_prob' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'integrated_init_energy_prob')
    do i1 = lbound(input%integrated_init_energy_prob, 1), ubound(input%integrated_init_energy_prob, 1)
      call json%create_real(json_val, input%integrated_init_energy_prob(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_photon_material_struct(input%material, json_val, depth + 1)
  call json%rename(json_val, 'material')
  call json%add(json_root, json_val)
  call tao_jsonify_pixel_detec_struct(input%pixel, json_val, depth + 1)
  call json%rename(json_val, 'pixel')
  call json%add(json_root, json_val)
  call tao_jsonify_photon_reflect_table_struct(input%reflectivity_table_pi, json_val, depth + 1)
  call json%rename(json_val, 'reflectivity_table_pi')
  call json%add(json_root, json_val)
  call tao_jsonify_photon_reflect_table_struct(input%reflectivity_table_sigma, json_val, depth + 1)
  call json%rename(json_val, 'reflectivity_table_sigma')
  call json%add(json_root, json_val)
  call json%add(json_root, 'reflectivity_table_type', int(input%reflectivity_table_type))
  call tao_jsonify_surface_segmented_struct(input%segmented, json_val, depth + 1)
  call json%rename(json_val, 'segmented')
  call json%add(json_root, json_val)
  call tao_jsonify_photon_target_struct(input%target, json_val, depth + 1)
  call json%rename(json_val, 'target')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_photon_element_struct

subroutine tao_jsonify_photon_material_struct (input, json_root, depth)
  use bmad_struct, only: photon_material_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%f0_m1, json_list1, depth+1)
  call json%rename(json_list1, 'f0_m1')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%f0_m2, json_list1, depth+1)
  call json%rename(json_list1, 'f0_m2')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%f_0, json_list1, depth+1)
  call json%rename(json_list1, 'f_0')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%f_h, json_list1, depth+1)
  call json%rename(json_list1, 'f_h')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%f_hbar, json_list1, depth+1)
  call json%rename(json_list1, 'f_hbar')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%f_hkl, json_list1, depth+1)
  call json%rename(json_list1, 'f_hkl')
  call json%add(json_root, json_list1)
  !line=1057 definition='real(rp) :: h_norm(3) = 0' name='h_norm' python_name='h_norm' type='real' python_type='float' size=None dimension='3' comment='Normalized H vector for crystals.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'h_norm')
  do i1 = lbound(input%h_norm, 1), ubound(input%h_norm, 1)
    call json%create_real(json_val, input%h_norm(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1058 definition='real(rp) :: l_ref(3) = 0' name='l_ref' python_name='l_ref' type='real' python_type='float' size=None dimension='3' comment='Crystal reference orbit displacement vector in element coords.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'l_ref')
  do i1 = lbound(input%l_ref, 1), ubound(input%l_ref, 1)
    call json%create_real(json_val, input%l_ref(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_photon_material_struct

subroutine tao_jsonify_photon_reflect_table_struct (input, json_root, depth)
  use bmad_struct, only: photon_reflect_table_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%angle)) then
    !line=203 definition='real(rp), allocatable :: angle(:)' name='angle' python_name='angle' type='real' python_type='float' size=None dimension=':' comment='Vector of angle values for %p_reflect' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'angle')
    do i1 = lbound(input%angle, 1), ubound(input%angle, 1)
      call json%create_real(json_val, input%angle(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%bragg_angle)) then
    !line=209 definition='real(rp), allocatable :: bragg_angle(:)' name='bragg_angle' python_name='bragg_angle' type='real' python_type='float' size=None dimension=':' comment='Bragg angle at energy values.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'bragg_angle')
    do i1 = lbound(input%bragg_angle, 1), ubound(input%bragg_angle, 1)
      call json%create_real(json_val, input%bragg_angle(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%energy)) then
    !line=204 definition='real(rp), allocatable :: energy(:)' name='energy' python_name='energy' type='real' python_type='float' size=None dimension=':' comment='Vector of energy values for %p_reflect' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'energy')
    do i1 = lbound(input%energy, 1), ubound(input%energy, 1)
      call json%create_real(json_val, input%energy(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%int1)) then
    !line=205 definition='type (interval1_coef_struct), allocatable :: int1(:)' name='int1' python_name='int1' type='interval1_coef_struct' python_type='Interval1CoefStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'int1')
    do i1 = lbound(input%int1, 1), ubound(input%int1, 1)
      call tao_jsonify_interval1_coef_struct(input%int1(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'max_energy', input%max_energy)
  if (allocated(input%p_reflect)) then
    !line=206 definition='real(rp), allocatable :: p_reflect(:,:)' name='p_reflect' python_name='p_reflect' type='real' python_type='float' size=None dimension=':,:' comment='(angle, ev) probability. Log used for smooth surface reflection' fortran_default=None default=0.0 default_factory=''
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
  if (allocated(input%p_reflect_scratch)) then
    !line=208 definition='real(rp), allocatable :: p_reflect_scratch(:)' name='p_reflect_scratch' python_name='p_reflect_scratch' type='real' python_type='float' size=None dimension=':' comment='Scratch space' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'p_reflect_scratch')
    do i1 = lbound(input%p_reflect_scratch, 1), ubound(input%p_reflect_scratch, 1)
      call json%create_real(json_val, input%p_reflect_scratch(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_photon_reflect_table_struct

subroutine tao_jsonify_interval1_coef_struct (input, json_root, depth)
  use bmad_struct, only: interval1_coef_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'c0', input%c0)
  call json%add(json_root, 'c1', input%c1)
  call json%add(json_root, 'n_exp', input%n_exp)
  
end subroutine tao_jsonify_interval1_coef_struct

subroutine tao_jsonify_photon_target_struct (input, json_root, depth)
  use bmad_struct, only: photon_target_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_target_point_struct(input%center, json_val, depth + 1)
  call json%rename(json_val, 'center')
  call json%add(json_root, json_val)
  !line=1047 definition='type (target_point_struct) :: corner(8) = target_point_struct()' name='corner' python_name='corner' type='target_point_struct' python_type='TargetPointStruct' size=None dimension='8' comment='' fortran_default='target_point_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'corner')
  do i1 = lbound(input%corner, 1), ubound(input%corner, 1)
    call tao_jsonify_target_point_struct(input%corner(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_lat_ele_loc_struct(input%ele_loc, json_val, depth + 1)
  call json%rename(json_val, 'ele_loc')
  call json%add(json_root, json_val)
  call json%add(json_root, 'n_corner', int(input%n_corner))
  call json%add(json_root, 'type', int(input%type))
  
end subroutine tao_jsonify_photon_target_struct

subroutine tao_jsonify_pixel_detec_struct (input, json_root, depth)
  use bmad_struct, only: pixel_detec_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=1021 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='dr' python_name='dr' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'n_hit_detec', int(input%n_hit_detec))
  call json%add(json_root, 'n_hit_pixel', int(input%n_hit_pixel))
  call json%add(json_root, 'n_track_tot', int(input%n_track_tot))
  if (allocated(input%pt)) then
    !line=1025 definition='type (pixel_pt_struct), allocatable :: pt(:,:)' name='pt' python_name='pt' type='pixel_pt_struct' python_type='PixelPtStruct' size=None dimension=':,:' comment='Grid of pixels' fortran_default=None default=None default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call tao_jsonify_pixel_pt_struct(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  !line=1021 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_pixel_detec_struct

subroutine tao_jsonify_pixel_pt_struct (input, json_root, depth)
  use bmad_struct, only: pixel_pt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%E_x, json_list1, depth+1)
  call json%rename(json_list1, 'e_x')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%E_y, json_list1, depth+1)
  call json%rename(json_list1, 'e_y')
  call json%add(json_root, json_list1)
  !line=1016 definition='real(rp) :: init_orbit(6) = 0' name='init_orbit' python_name='init_orbit' type='real' python_type='float' size=None dimension='6' comment='Initial orbit at start of lattice statistics.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'init_orbit')
  do i1 = lbound(input%init_orbit, 1), ubound(input%init_orbit, 1)
    call json%create_real(json_val, input%init_orbit(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1017 definition='real(rp) :: init_orbit_rms(6) = 0' name='init_orbit_rms' python_name='init_orbit_rms' type='real' python_type='float' size=None dimension='6' comment='Initial orbit at start of lattice RMS statistics.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'init_orbit_rms')
  do i1 = lbound(input%init_orbit_rms, 1), ubound(input%init_orbit_rms, 1)
    call json%create_real(json_val, input%init_orbit_rms(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'intensity', input%intensity)
  call json%add(json_root, 'intensity_x', input%intensity_x)
  call json%add(json_root, 'intensity_y', input%intensity_y)
  call json%add(json_root, 'n_photon', int(input%n_photon))
  !line=1014 definition='real(rp) :: orbit(6) = 0' name='orbit' python_name='orbit' type='real' python_type='float' size=None dimension='6' comment='x, Vx/c, y, Vy/c, dummy, E - E_ref.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'orbit')
  do i1 = lbound(input%orbit, 1), ubound(input%orbit, 1)
    call json%create_real(json_val, input%orbit(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1015 definition='real(rp) :: orbit_rms(6) = 0' name='orbit_rms' python_name='orbit_rms' type='real' python_type='float' size=None dimension='6' comment='RMS statistics.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'orbit_rms')
  do i1 = lbound(input%orbit_rms, 1), ubound(input%orbit_rms, 1)
    call json%create_real(json_val, input%orbit_rms(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_pixel_pt_struct

subroutine tao_jsonify_pre_tracker_struct (input, json_root, depth)
  use bmad_struct, only: pre_tracker_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'input_file', trim(input%input_file))
  call json%add(json_root, 'ix_ele_end', int(input%ix_ele_end))
  call json%add(json_root, 'ix_ele_start', int(input%ix_ele_start))
  call json%add(json_root, 'who', int(input%who))
  
end subroutine tao_jsonify_pre_tracker_struct

subroutine tao_jsonify_ptc_branch1_struct (input, json_root, depth)
  use bmad_struct, only: ptc_branch1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  ! skipped explicitly by converter: struct=LAYOUT file=a_def_element_fibre_layout.inc member=json_obj
  if (allocated(input%m_u_layout)) then
    !line=1496 definition='type (ptc_layout_pointer_struct), allocatable :: m_u_layout(:)' name='m_u_layout' python_name='m_u_layout' type='ptc_layout_pointer_struct' python_type='PtcLayoutPointerStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'm_u_layout')
    do i1 = lbound(input%m_u_layout, 1), ubound(input%m_u_layout, 1)
      call tao_jsonify_ptc_layout_pointer_struct(input%m_u_layout(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_ptc_branch1_struct

subroutine tao_jsonify_ptc_layout_pointer_struct (input, json_root, depth)
  use bmad_struct, only: ptc_layout_pointer_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  ! skipped explicitly by converter: struct=LAYOUT file=a_def_element_fibre_layout.inc member=json_obj
  
end subroutine tao_jsonify_ptc_layout_pointer_struct

subroutine tao_jsonify_rad_map_ele_struct (input, json_root, depth)
  use bmad_struct, only: rad_map_ele_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_rad_map_struct(input%rm0, json_val, depth + 1)
  call json%rename(json_val, 'rm0')
  call json%add(json_root, json_val)
  call tao_jsonify_rad_map_struct(input%rm1, json_val, depth + 1)
  call json%rename(json_val, 'rm1')
  call json%add(json_root, json_val)
  call json%add(json_root, 'stale', input%stale)
  
end subroutine tao_jsonify_rad_map_ele_struct

subroutine tao_jsonify_rad_map_struct (input, json_root, depth)
  use bmad_struct, only: rad_map_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=957 definition='real(rp) :: damp_dmat(6,6) = 0' name='damp_dmat' python_name='damp_dmat' type='real' python_type='float' size=None dimension='6,6' comment='damp_correction = xfer_mat_with_damping - xfer_mat_without_damping.' fortran_default='0' default=0 default_factory=''
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
  !line=956 definition='real(rp) :: ref_orb(6) = -1' name='ref_orb' python_name='ref_orb' type='real' python_type='float' size=None dimension='6' comment='Reference point around which damp_mat is calculated.' fortran_default='-1' default=-1 default_factory=''
  call json%create_array(json_list1, 'ref_orb')
  do i1 = lbound(input%ref_orb, 1), ubound(input%ref_orb, 1)
    call json%create_real(json_val, input%ref_orb(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=960 definition='real(rp) :: stoc_mat(6,6) = 0' name='stoc_mat' python_name='stoc_mat' type='real' python_type='float' size=None dimension='6,6' comment='Stochastic variance or "kick" (Cholesky decomposed) matrix.' fortran_default='0' default=0 default_factory=''
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
  !line=959 definition='real(rp) :: xfer_damp_mat(6,6) = mat6_unit$' name='xfer_damp_mat' python_name='xfer_damp_mat' type='real' python_type='float' size=None dimension='6,6' comment='1st order matrix: xfer_no_damp_mat + xfer_damp_correction.' fortran_default='mat6_unit$' default=0.0 default_factory=''
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
  !line=958 definition='real(rp) :: xfer_damp_vec(6) = 0' name='xfer_damp_vec' python_name='xfer_damp_vec' type='real' python_type='float' size=None dimension='6' comment='Transfer map with damping 0th order vector.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'xfer_damp_vec')
  do i1 = lbound(input%xfer_damp_vec, 1), ubound(input%xfer_damp_vec, 1)
    call json%create_real(json_val, input%xfer_damp_vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_rad_map_struct

subroutine tao_jsonify_ramper_lord_struct (input, json_root, depth)
  use bmad_struct, only: ramper_lord_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%attrib_ptr)) then
    call json%add(json_root, 'attrib_ptr', input%attrib_ptr)
  endif
  call json%add(json_root, 'ix_con', int(input%ix_con))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  
end subroutine tao_jsonify_ramper_lord_struct

subroutine tao_jsonify_spline_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
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
  
end subroutine tao_jsonify_spline_struct

subroutine tao_jsonify_surface_curvature_struct (input, json_root, depth)
  use bmad_struct, only: surface_curvature_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=1033 definition='real(rp) :: elliptical(3) = 0' name='elliptical' python_name='elliptical' type='real' python_type='float' size=None dimension='3' comment='Total curvature = elliptical + spherical' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'elliptical')
  do i1 = lbound(input%elliptical, 1), ubound(input%elliptical, 1)
    call json%create_real(json_val, input%elliptical(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'has_curvature', input%has_curvature)
  call json%add(json_root, 'spherical', input%spherical)
  !line=1031 definition='real(rp) :: xy(0:6,0:6) = 0' name='xy' python_name='xy' type='real' python_type='float' size=None dimension='0:6,0:6' comment='' fortran_default='0' default=0 default_factory=''
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
  
end subroutine tao_jsonify_surface_curvature_struct

subroutine tao_jsonify_surface_displacement_struct (input, json_root, depth)
  use bmad_struct, only: surface_displacement_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'active', input%active)
  !line=1004 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='dr' python_name='dr' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%pt)) then
    !line=1005 definition='type (surface_displacement_pt_struct), allocatable :: pt(:,:)' name='pt' python_name='pt' type='surface_displacement_pt_struct' python_type='SurfaceDisplacementPtStruct' size=None dimension=':,:' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call tao_jsonify_surface_displacement_pt_struct(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  !line=1004 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_surface_displacement_struct

subroutine tao_jsonify_surface_displacement_pt_struct (input, json_root, depth)
  use bmad_struct, only: surface_displacement_pt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'd2z_dxdy', input%d2z_dxdy)
  call json%add(json_root, 'dz_dx', input%dz_dx)
  call json%add(json_root, 'dz_dy', input%dz_dy)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'z0', input%z0)
  
end subroutine tao_jsonify_surface_displacement_pt_struct

subroutine tao_jsonify_surface_h_misalign_struct (input, json_root, depth)
  use bmad_struct, only: surface_h_misalign_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'active', input%active)
  !line=991 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='dr' python_name='dr' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%pt)) then
    !line=992 definition='type (surface_h_misalign_pt_struct), allocatable :: pt(:,:)' name='pt' python_name='pt' type='surface_h_misalign_pt_struct' python_type='SurfaceHMisalignPtStruct' size=None dimension=':,:' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call tao_jsonify_surface_h_misalign_pt_struct(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  !line=991 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_surface_h_misalign_struct

subroutine tao_jsonify_surface_h_misalign_pt_struct (input, json_root, depth)
  use bmad_struct, only: surface_h_misalign_pt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'rot_t', input%rot_t)
  call json%add(json_root, 'rot_t_rms', input%rot_t_rms)
  call json%add(json_root, 'rot_y', input%rot_y)
  call json%add(json_root, 'rot_y_rms', input%rot_y_rms)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  
end subroutine tao_jsonify_surface_h_misalign_pt_struct

subroutine tao_jsonify_surface_segmented_struct (input, json_root, depth)
  use bmad_struct, only: surface_segmented_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'active', input%active)
  !line=978 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='dr' python_name='dr' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'dr')
  do i1 = lbound(input%dr, 1), ubound(input%dr, 1)
    call json%create_real(json_val, input%dr(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (allocated(input%pt)) then
    !line=979 definition='type (surface_segmented_pt_struct), allocatable :: pt(:,:)' name='pt' python_name='pt' type='surface_segmented_pt_struct' python_type='SurfaceSegmentedPtStruct' size=None dimension=':,:' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%pt, 2), ubound(input%pt, 2)
      call json%create_array(json_list1, 'pt')
      do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
        call tao_jsonify_surface_segmented_pt_struct(input%pt(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  !line=978 definition='real(rp) :: dr(2) = 0, r0(2) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_surface_segmented_struct

subroutine tao_jsonify_surface_segmented_pt_struct (input, json_root, depth)
  use bmad_struct, only: surface_segmented_pt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'dz_dx', input%dz_dx)
  call json%add(json_root, 'dz_dy', input%dz_dy)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y0', input%y0)
  call json%add(json_root, 'z0', input%z0)
  
end subroutine tao_jsonify_surface_segmented_pt_struct

subroutine tao_jsonify_tao_plot_region_struct (input, json_root, depth)
  use tao_struct, only: tao_plot_region_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'list_with_show_plot_command', input%list_with_show_plot_command)
  !line=319 definition='real(rp) :: location(4) = 0' name='location' python_name='location' type='real' python_type='float' size=None dimension='4' comment='[x1, x2, y1, y2] location on page.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'location')
  do i1 = lbound(input%location, 1), ubound(input%location, 1)
    call json%create_real(json_val, input%location(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'name', trim(input%name))
  call tao_jsonify_tao_plot_struct(input%plot, json_val, depth + 1)
  call json%rename(json_val, 'plot')
  call json%add(json_root, json_val)
  call json%add(json_root, 'setup_done', input%setup_done)
  call json%add(json_root, 'visible', input%visible)
  
end subroutine tao_jsonify_tao_plot_region_struct

subroutine tao_jsonify_tao_plot_struct (input, json_root, depth)
  use tao_struct, only: tao_plot_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'autoscale_gang_x', input%autoscale_gang_x)
  call json%add(json_root, 'autoscale_gang_y', input%autoscale_gang_y)
  call json%add(json_root, 'autoscale_x', input%autoscale_x)
  call json%add(json_root, 'autoscale_y', input%autoscale_y)
  call json%add(json_root, 'default_plot', input%default_plot)
  call json%add(json_root, 'description', trim(input%description))
  if (allocated(input%graph)) then
    !line=296 definition='type (tao_graph_struct), allocatable :: graph(:)' name='graph' python_name='graph' type='tao_graph_struct' python_type='TaoGraphStruct' size=None dimension=':' comment='individual graphs of a plot' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'graph')
    do i1 = lbound(input%graph, 1), ubound(input%graph, 1)
      call tao_jsonify_tao_graph_struct(input%graph(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_plot', int(input%ix_plot))
  call json%add(json_root, 'list_with_show_plot_command', input%list_with_show_plot_command)
  call json%add(json_root, 'n_curve_pts', int(input%n_curve_pts))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'phantom', input%phantom)
  ! parent pointer skip: r (tao_plot_region_struct, pointer to parent.)
  call json%add(json_root, 'type', trim(input%type))
  call json%add(json_root, 'x_axis_type', trim(input%x_axis_type))
  
end subroutine tao_jsonify_tao_plot_struct

subroutine tao_jsonify_tao_graph_struct (input, json_root, depth)
  use tao_struct, only: tao_graph_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'allow_wrap_around', input%allow_wrap_around)
  !line=273 definition='integer :: box(4) = 0' name='box' python_name='box' type='integer' python_type='int' size=None dimension='4' comment='Defines which box the plot is put in.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'box')
  do i1 = lbound(input%box, 1), ubound(input%box, 1)
    call json%create_integer(json_val, input%box(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'clip', input%clip)
  if (allocated(input%curve)) then
    !line=260 definition='type (tao_curve_struct), allocatable :: curve(:)' name='curve' python_name='curve' type='tao_curve_struct' python_type='TaoCurveStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'curve')
    do i1 = lbound(input%curve, 1), ubound(input%curve, 1)
      call tao_jsonify_tao_curve_struct(input%curve(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_qp_point_struct(input%curve_legend_origin, json_val, depth + 1)
  call json%rename(json_val, 'curve_legend_origin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'draw_axes', input%draw_axes)
  call json%add(json_root, 'draw_curve_legend', input%draw_curve_legend)
  call json%add(json_root, 'draw_grid', input%draw_grid)
  call json%add(json_root, 'draw_only_good_user_data_or_vars', input%draw_only_good_user_data_or_vars)
  call json%add(json_root, 'draw_title', input%draw_title)
  call tao_jsonify_tao_floor_plan_struct(input%floor_plan, json_val, depth + 1)
  call json%rename(json_val, 'floor_plan')
  call json%add(json_root, json_val)
  call json%add(json_root, 'is_valid', input%is_valid)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'limited', input%limited)
  call tao_jsonify_qp_rect_struct(input%margin, json_val, depth + 1)
  call json%rename(json_val, 'margin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'name', trim(input%name))
  ! parent pointer skip: p (tao_plot_struct, pointer to parent plot)
  call tao_jsonify_qp_rect_struct(input%scale_margin, json_val, depth + 1)
  call json%rename(json_val, 'scale_margin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'symbol_size_scale', input%symbol_size_scale)
  !line=257 definition="character(100) :: text_legend(10) = ''" name='text_legend' python_name='text_legend' type='character' python_type='str' size='100' dimension='10' comment='Array for holding descriptive info.' fortran_default="''" default='' default_factory=''
  call json%create_array(json_list1, 'text_legend')
  do i1 = lbound(input%text_legend, 1), ubound(input%text_legend, 1)
    call json%create_string(json_val, trim(input%text_legend(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_qp_point_struct(input%text_legend_origin, json_val, depth + 1)
  call json%rename(json_val, 'text_legend_origin')
  call json%add(json_root, json_val)
  !line=258 definition="character(100) :: text_legend_out(10) = ''" name='text_legend_out' python_name='text_legend_out' type='character' python_type='str' size='100' dimension='10' comment='Array for holding descriptive info.' fortran_default="''" default='' default_factory=''
  call json%create_array(json_list1, 'text_legend_out')
  do i1 = lbound(input%text_legend_out, 1), ubound(input%text_legend_out, 1)
    call json%create_string(json_val, trim(input%text_legend_out(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'title', trim(input%title))
  call json%add(json_root, 'title_suffix', trim(input%title_suffix))
  call json%add(json_root, 'type', trim(input%type))
  call json%add(json_root, 'why_invalid', trim(input%why_invalid))
  call tao_jsonify_qp_axis_struct(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call tao_jsonify_qp_axis_struct(input%x2, json_val, depth + 1)
  call json%rename(json_val, 'x2')
  call json%add(json_root, json_val)
  call json%add(json_root, 'x_axis_scale_factor', input%x_axis_scale_factor)
  call tao_jsonify_qp_axis_struct(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call tao_jsonify_qp_axis_struct(input%y2, json_val, depth + 1)
  call json%rename(json_val, 'y2')
  call json%add(json_root, json_val)
  call json%add(json_root, 'y2_mirrors_y', input%y2_mirrors_y)
  
end subroutine tao_jsonify_tao_graph_struct

subroutine tao_jsonify_qp_axis_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
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
  
end subroutine tao_jsonify_qp_axis_struct

subroutine tao_jsonify_qp_point_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  
end subroutine tao_jsonify_qp_point_struct

subroutine tao_jsonify_tao_curve_struct (input, json_root, depth)
  use tao_struct, only: tao_curve_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'component', trim(input%component))
  call json%add(json_root, 'data_index', trim(input%data_index))
  call json%add(json_root, 'data_source', trim(input%data_source))
  if (allocated(input%data_type)) then
    call json%add(json_root, 'data_type', trim(input%data_type))
  endif
  call json%add(json_root, 'data_type_x', trim(input%data_type_x))
  call json%add(json_root, 'draw_error_bars', input%draw_error_bars)
  call json%add(json_root, 'draw_line', input%draw_line)
  call json%add(json_root, 'draw_symbol_index', input%draw_symbol_index)
  call json%add(json_root, 'draw_symbols', input%draw_symbols)
  call json%add(json_root, 'ele_ref_name', trim(input%ele_ref_name))
  if (allocated(input%err_symb)) then
    !line=207 definition='real(rp), allocatable :: err_symb(:)' name='err_symb' python_name='err_symb' type='real' python_type='float' size=None dimension=':' comment='Error bars' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'err_symb')
    do i1 = lbound(input%err_symb, 1), ubound(input%err_symb, 1)
      call json%create_real(json_val, input%err_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! parent pointer skip: g (tao_graph_struct, pointer to parent graph)
  call tao_jsonify_tao_histogram_struct(input%hist, json_val, depth + 1)
  call json%rename(json_val, 'hist')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call json%add(json_root, 'ix_ele_ref', int(input%ix_ele_ref))
  call json%add(json_root, 'ix_ele_ref_track', int(input%ix_ele_ref_track))
  if (allocated(input%ix_line)) then
    !line=203 definition='integer, allocatable :: ix_line(:)' name='ix_line' python_name='ix_line' type='integer, allocatable' python_type='int' size=None dimension=':' comment='Used by wave and aperture curves.' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'ix_line')
    do i1 = lbound(input%ix_line, 1), ubound(input%ix_line, 1)
      call json%create_integer(json_val, input%ix_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%ix_symb)) then
    !line=209 definition='integer, allocatable :: ix_symb(:)' name='ix_symb' python_name='ix_symb' type='integer, allocatable' python_type='int' size=None dimension=':' comment='Corresponding index in d1_data%d(:) array.' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'ix_symb')
    do i1 = lbound(input%ix_symb, 1), ubound(input%ix_symb, 1)
      call json%create_integer(json_val, input%ix_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'legend_text', trim(input%legend_text))
  call tao_jsonify_qp_line_struct(input%line, json_val, depth + 1)
  call json%rename(json_val, 'line')
  call json%add(json_root, json_val)
  call json%add(json_root, 'message_text', trim(input%message_text))
  call json%add(json_root, 'n_turn', int(input%n_turn))
  call json%add(json_root, 'name', trim(input%name))
  call tao_jsonify_tao_curve_orbit_struct(input%orbit, json_val, depth + 1)
  call json%rename(json_val, 'orbit')
  call json%add(json_root, json_val)
  call json%add(json_root, 'smooth_line_calc', input%smooth_line_calc)
  if (allocated(input%symb_size)) then
    !line=208 definition='real(rp), allocatable :: symb_size(:)' name='symb_size' python_name='symb_size' type='real' python_type='float' size=None dimension=':' comment='Symbol size. Used with symbol_size_scale.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'symb_size')
    do i1 = lbound(input%symb_size, 1), ubound(input%symb_size, 1)
      call json%create_real(json_val, input%symb_size(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_qp_symbol_struct(input%symbol, json_val, depth + 1)
  call json%rename(json_val, 'symbol')
  call json%add(json_root, json_val)
  call json%add(json_root, 'symbol_every', int(input%symbol_every))
  call json%add(json_root, 'use_y2', input%use_y2)
  call json%add(json_root, 'valid', input%valid)
  call json%add(json_root, 'why_invalid', trim(input%why_invalid))
  if (allocated(input%x_line)) then
    !line=200 definition='real(rp), allocatable :: x_line(:)' name='x_line' python_name='x_line' type='real' python_type='float' size=None dimension=':' comment='Coords for drawing a curve' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'x_line')
    do i1 = lbound(input%x_line, 1), ubound(input%x_line, 1)
      call json%create_real(json_val, input%x_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%x_symb)) then
    !line=204 definition='real(rp), allocatable :: x_symb(:)' name='x_symb' python_name='x_symb' type='real' python_type='float' size=None dimension=':' comment='Coords for drawing the symbols' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'x_symb')
    do i1 = lbound(input%x_symb, 1), ubound(input%x_symb, 1)
      call json%create_real(json_val, input%x_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y2_line)) then
    !line=202 definition='real(rp), allocatable :: y2_line(:)' name='y2_line' python_name='y2_line' type='real' python_type='float' size=None dimension=':' comment='Second array needed for beam chamber curve.' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'y2_line')
    do i1 = lbound(input%y2_line, 1), ubound(input%y2_line, 1)
      call json%create_real(json_val, input%y2_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'y_axis_scale_factor', input%y_axis_scale_factor)
  if (allocated(input%y_line)) then
    !line=201 definition='real(rp), allocatable :: y_line(:)' name='y_line' python_name='y_line' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'y_line')
    do i1 = lbound(input%y_line, 1), ubound(input%y_line, 1)
      call json%create_real(json_val, input%y_line(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%y_symb)) then
    !line=205 definition='real(rp), allocatable :: y_symb(:)' name='y_symb' python_name='y_symb' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'y_symb')
    do i1 = lbound(input%y_symb, 1), ubound(input%y_symb, 1)
      call json%create_real(json_val, input%y_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call tao_jsonify_tao_curve_color_struct(input%z_color, json_val, depth + 1)
  call json%rename(json_val, 'z_color')
  call json%add(json_root, json_val)
  if (allocated(input%z_symb)) then
    !line=206 definition='real(rp), allocatable :: z_symb(:)' name='z_symb' python_name='z_symb' type='real' python_type='float' size=None dimension=':' comment='Symbol color' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'z_symb')
    do i1 = lbound(input%z_symb, 1), ubound(input%z_symb, 1)
      call json%create_real(json_val, input%z_symb(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_curve_struct

subroutine tao_jsonify_qp_line_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'pattern', trim(input%pattern))
  call json%add(json_root, 'width', int(input%width))
  
end subroutine tao_jsonify_qp_line_struct

subroutine tao_jsonify_qp_symbol_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'color', trim(input%color))
  call json%add(json_root, 'fill_pattern', trim(input%fill_pattern))
  call json%add(json_root, 'height', input%height)
  call json%add(json_root, 'line_width', int(input%line_width))
  call json%add(json_root, 'type', trim(input%type))
  
end subroutine tao_jsonify_qp_symbol_struct

subroutine tao_jsonify_tao_curve_color_struct (input, json_root, depth)
  use tao_struct, only: tao_curve_color_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'autoscale', input%autoscale)
  call json%add(json_root, 'data_type', trim(input%data_type))
  call json%add(json_root, 'is_on', input%is_on)
  call json%add(json_root, 'max', input%max)
  call json%add(json_root, 'min', input%min)
  
end subroutine tao_jsonify_tao_curve_color_struct

subroutine tao_jsonify_tao_curve_orbit_struct (input, json_root, depth)
  use tao_struct, only: tao_curve_orbit_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 't', input%t)
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  
end subroutine tao_jsonify_tao_curve_orbit_struct

subroutine tao_jsonify_tao_floor_plan_struct (input, json_root, depth)
  use tao_struct, only: tao_floor_plan_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'correct_distortion', input%correct_distortion)
  call json%add(json_root, 'draw_building_wall', input%draw_building_wall)
  call json%add(json_root, 'draw_only_first_pass', input%draw_only_first_pass)
  call json%add(json_root, 'flip_label_side', input%flip_label_side)
  call json%add(json_root, 'orbit_color', trim(input%orbit_color))
  call json%add(json_root, 'orbit_lattice', trim(input%orbit_lattice))
  call json%add(json_root, 'orbit_pattern', trim(input%orbit_pattern))
  call json%add(json_root, 'orbit_scale', input%orbit_scale)
  call json%add(json_root, 'orbit_width', int(input%orbit_width))
  call json%add(json_root, 'rotation', input%rotation)
  call json%add(json_root, 'size_is_absolute', input%size_is_absolute)
  call json%add(json_root, 'view', trim(input%view))
  
end subroutine tao_jsonify_tao_floor_plan_struct

subroutine tao_jsonify_tao_histogram_struct (input, json_root, depth)
  use tao_struct, only: tao_histogram_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'center', input%center)
  call json%add(json_root, 'density_normalized', input%density_normalized)
  call json%add(json_root, 'maximum', input%maximum)
  call json%add(json_root, 'minimum', input%minimum)
  call json%add(json_root, 'number', int(input%number))
  call json%add(json_root, 'weight_by_charge', input%weight_by_charge)
  call json%add(json_root, 'width', input%width)
  
end subroutine tao_jsonify_tao_histogram_struct

subroutine tao_jsonify_tao_shape_pattern_struct (input, json_root, depth)
  use tao_struct, only: tao_shape_pattern_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_qp_line_struct(input%line, json_val, depth + 1)
  call json%rename(json_val, 'line')
  call json%add(json_root, json_val)
  call json%add(json_root, 'name', trim(input%name))
  if (allocated(input%pt)) then
    !line=140 definition='type (tao_shape_pattern_point_struct), allocatable :: pt(:)' name='pt' python_name='pt' type='tao_shape_pattern_point_struct' python_type='TaoShapePatternPointStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call tao_jsonify_tao_shape_pattern_point_struct(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_shape_pattern_struct

subroutine tao_jsonify_tao_shape_pattern_point_struct (input, json_root, depth)
  use tao_struct, only: tao_shape_pattern_point_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'radius', input%radius)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'y', input%y)
  
end subroutine tao_jsonify_tao_shape_pattern_point_struct

subroutine tao_jsonify_tao_title_struct (input, json_root, depth)
  use tao_struct, only: tao_title_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'draw_it', input%draw_it)
  call json%add(json_root, 'justify', trim(input%justify))
  call json%add(json_root, 'string', trim(input%string))
  call json%add(json_root, 'units', trim(input%units))
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  
end subroutine tao_jsonify_tao_title_struct

subroutine tao_jsonify_tao_universe_struct (input, json_root, depth)
  use tao_struct, only: tao_universe_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%base)) then
    call tao_jsonify_tao_lattice_struct(input%base, json_val, depth + 1)
    call json%rename(json_val, 'base')
    call json%add(json_root, json_val)
  endif
  call tao_jsonify_tao_beam_uni_struct(input%beam, json_val, depth + 1)
  call json%rename(json_val, 'beam')
  call json%add(json_root, json_val)
  call tao_jsonify_tao_universe_calc_struct(input%calc, json_val, depth + 1)
  call json%rename(json_val, 'calc')
  call json%add(json_root, json_val)
  if (allocated(input%d2_data)) then
    !line=1103 definition='type (tao_d2_data_struct), allocatable :: d2_data(:)' name='d2_data' python_name='d2_data' type='tao_d2_data_struct' python_type='TaoD2DataStruct' size=None dimension=':' comment='The data types' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'd2_data')
    do i1 = lbound(input%d2_data, 1), ubound(input%d2_data, 1)
      call tao_jsonify_tao_d2_data_struct(input%d2_data(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%dModel_dVar)) then
    !line=1110 definition='real(rp), allocatable :: dModel_dVar(:,:)' name='dModel_dVar' python_name='dmodel_dvar' type='real' python_type='float' size=None dimension=':,:' comment='Derivative matrix.' fortran_default=None default=0.0 default_factory=''
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
  if (allocated(input%data)) then
    !line=1104 definition='type (tao_data_struct), allocatable :: data(:)' name='data' python_name='data' type='tao_data_struct' python_type='TaoDataStruct' size=None dimension=':' comment='Array of all data.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'data')
    do i1 = lbound(input%data, 1), ubound(input%data, 1)
      call tao_jsonify_tao_data_struct(input%data(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (associated(input%design)) then
    call tao_jsonify_tao_lattice_struct(input%design, json_val, depth + 1)
    call json%rename(json_val, 'design')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'design_same_as_previous', input%design_same_as_previous)
  call tao_jsonify_tao_dynamic_aperture_struct(input%dynamic_aperture, json_val, depth + 1)
  call json%rename(json_val, 'dynamic_aperture')
  call json%add(json_root, json_val)
  call tao_jsonify_lat_ele_order_struct(input%ele_order, json_val, depth + 1)
  call json%rename(json_val, 'ele_order')
  call json%add(json_root, json_val)
  call json%add(json_root, 'is_on', input%is_on)
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  if (associated(input%model)) then
    call tao_jsonify_tao_lattice_struct(input%model, json_val, depth + 1)
    call json%rename(json_val, 'model')
    call json%add(json_root, json_val)
  endif
  if (associated(input%model_branch)) then
    !line=1102 definition='type (tao_model_branch_struct), pointer :: model_branch(:)' name='model_branch' python_name='bmad_model_branch' type='tao_model_branch_struct' python_type='TaoModelBranchStruct' size=None dimension=':' comment='model specific information' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'bmad_model_branch')
    do i1 = lbound(input%model_branch, 1), ubound(input%model_branch, 1)
      call tao_jsonify_tao_model_branch_struct(input%model_branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_d2_data_used', int(input%n_d2_data_used))
  call json%add(json_root, 'n_data_used', int(input%n_data_used))
  call json%add(json_root, 'picked_uni', input%picked_uni)
  call tao_jsonify_tao_ping_scale_struct(input%ping_scale, json_val, depth + 1)
  call json%rename(json_val, 'ping_scale')
  call json%add(json_root, json_val)
  call tao_jsonify_lat_struct(input%scratch_lat, json_val, depth + 1)
  call json%rename(json_val, 'scratch_lat')
  call json%add(json_root, json_val)
  call tao_jsonify_tao_spin_map_struct(input%spin_map, json_val, depth + 1)
  call json%rename(json_val, 'spin_map')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_tao_universe_struct

subroutine tao_jsonify_lat_ele_order_struct (input, json_root, depth)
  use bmad_struct, only: lat_ele_order_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%branch)) then
    !line=880 definition='type (lat_ele_order_array_struct), allocatable :: branch(:)' name='branch' python_name='branch' type='lat_ele_order_array_struct' python_type='LatEleOrderArrayStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call tao_jsonify_lat_ele_order_array_struct(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_lat_ele_order_struct

subroutine tao_jsonify_lat_ele_order_array_struct (input, json_root, depth)
  use bmad_struct, only: lat_ele_order_array_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%ele)) then
    !line=861 definition='type (lat_ele_order1_struct), allocatable :: ele(:)' name='ele' python_name='ele' type='lat_ele_order1_struct' python_type='LatEleOrder1Struct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call tao_jsonify_lat_ele_order1_struct(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_lat_ele_order_array_struct

subroutine tao_jsonify_lat_ele_order1_struct (input, json_root, depth)
  use bmad_struct, only: lat_ele_order1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_order', int(input%ix_order))
  
end subroutine tao_jsonify_lat_ele_order1_struct

subroutine tao_jsonify_tao_beam_uni_struct (input, json_root, depth)
  use tao_struct, only: tao_beam_uni_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'always_reinit', input%always_reinit)
  call json%add(json_root, 'dump_at', trim(input%dump_at))
  call json%add(json_root, 'dump_file', trim(input%dump_file))
  call json%add(json_root, 'saved_at', trim(input%saved_at))
  call json%add(json_root, 'track_beam_in_universe', input%track_beam_in_universe)
  
end subroutine tao_jsonify_tao_beam_uni_struct

subroutine tao_jsonify_tao_d2_data_struct (input, json_root, depth)
  use tao_struct, only: tao_d2_data_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%d1)) then
    !line=492 definition='type (tao_d1_data_struct), allocatable :: d1(:)' name='d1' python_name='d1' type='tao_d1_data_struct' python_type='TaoD1DataStruct' size=None dimension=':' comment='Points to children' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'd1')
    do i1 = lbound(input%d1, 1), ubound(input%d1, 1)
      call tao_jsonify_tao_d1_data_struct(input%d1(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'data_date', trim(input%data_date))
  call json%add(json_root, 'data_file_name', trim(input%data_file_name))
  call json%add(json_root, 'data_read_in', input%data_read_in)
  !line=491 definition="character(80) :: descrip(10) = ''" name='descrip' python_name='descrip' type='character' python_type='str' size='80' dimension='10' comment='Array for descriptive information.' fortran_default="''" default='' default_factory=''
  call json%create_array(json_list1, 'descrip')
  do i1 = lbound(input%descrip, 1), ubound(input%descrip, 1)
    call json%create_string(json_val, trim(input%descrip(i1)), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'ix_d2_data', int(input%ix_d2_data))
  call json%add(json_root, 'ix_ref', int(input%ix_ref))
  call json%add(json_root, 'ix_universe', int(input%ix_universe))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'ref_date', trim(input%ref_date))
  call json%add(json_root, 'ref_file_name', trim(input%ref_file_name))
  call json%add(json_root, 'ref_read_in', input%ref_read_in)
  
end subroutine tao_jsonify_tao_d2_data_struct

subroutine tao_jsonify_tao_d1_data_struct (input, json_root, depth)
  use tao_struct, only: tao_d1_data_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%d)) then
    !line=476 definition='type (tao_data_struct), pointer :: d(:) => null()' name='d' python_name='d' type='tao_data_struct' python_type='TaoDataStruct' size=None dimension=':' comment='Pointer to the appropriate section in u%data' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'd')
    do i1 = lbound(input%d, 1), ubound(input%d, 1)
      call tao_jsonify_tao_data_struct(input%d(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! parent pointer skip: d2 (tao_d2_data_struct, ptr to parent d2_data)
  call json%add(json_root, 'name', trim(input%name))
  
end subroutine tao_jsonify_tao_d1_data_struct

subroutine tao_jsonify_tao_data_struct (input, json_root, depth)
  use tao_struct, only: tao_data_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'base_value', input%base_value)
  ! parent pointer skip: d1 (tao_d1_data_struct, Pointer to the parent d1_data_struct)
  call json%add(json_root, 'data_source', trim(input%data_source))
  if (allocated(input%data_type)) then
    call json%add(json_root, 'data_type', trim(input%data_type))
  endif
  call json%add(json_root, 'delta_merit', input%delta_merit)
  call json%add(json_root, 'design_value', input%design_value)
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'ele_ref_name', trim(input%ele_ref_name))
  call json%add(json_root, 'ele_start_name', trim(input%ele_start_name))
  call json%add(json_root, 'err_message_printed', input%err_message_printed)
  call json%add(json_root, 'error_rms', input%error_rms)
  call json%add(json_root, 'eval_point', int(input%eval_point))
  call json%add(json_root, 'exists', input%exists)
  call json%add(json_root, 'good_base', input%good_base)
  call json%add(json_root, 'good_design', input%good_design)
  call json%add(json_root, 'good_meas', input%good_meas)
  call json%add(json_root, 'good_model', input%good_model)
  call json%add(json_root, 'good_opt', input%good_opt)
  call json%add(json_root, 'good_plot', input%good_plot)
  call json%add(json_root, 'good_ref', input%good_ref)
  call json%add(json_root, 'good_user', input%good_user)
  call json%add(json_root, 'id', trim(input%id))
  call json%add(json_root, 'invalid_value', input%invalid_value)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call json%add(json_root, 'ix_d1', int(input%ix_d1))
  call json%add(json_root, 'ix_dmodel', int(input%ix_dModel))
  call json%add(json_root, 'ix_data', int(input%ix_data))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_ele_merit', int(input%ix_ele_merit))
  call json%add(json_root, 'ix_ele_ref', int(input%ix_ele_ref))
  call json%add(json_root, 'ix_ele_start', int(input%ix_ele_start))
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  call json%add(json_root, 'meas_value', input%meas_value)
  call json%add(json_root, 'merit', input%merit)
  call json%add(json_root, 'merit_type', trim(input%merit_type))
  call json%add(json_root, 'bmad_model_value', input%model_value)
  call json%add(json_root, 'old_value', input%old_value)
  call json%add(json_root, 'ref_value', input%ref_value)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 's_offset', input%s_offset)
  call tao_jsonify_tao_spin_map_struct(input%spin_map, json_val, depth + 1)
  call json%rename(json_val, 'spin_map')
  call json%add(json_root, json_val)
  if (allocated(input%stack)) then
    !line=466 definition='type (tao_eval_stack1_struct), allocatable :: stack(:)' name='stack' python_name='stack' type='tao_eval_stack1_struct' python_type='TaoEvalStack1Struct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'stack')
    do i1 = lbound(input%stack, 1), ubound(input%stack, 1)
      call tao_jsonify_tao_eval_stack1_struct(input%stack(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'useit_opt', input%useit_opt)
  call json%add(json_root, 'useit_plot', input%useit_plot)
  call json%add(json_root, 'weight', input%weight)
  call json%add(json_root, 'why_invalid', trim(input%why_invalid))
  
end subroutine tao_jsonify_tao_data_struct

subroutine tao_jsonify_tao_dynamic_aperture_struct (input, json_root, depth)
  use tao_struct, only: tao_dynamic_aperture_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'a_emit', input%a_emit)
  call json%add(json_root, 'b_emit', input%b_emit)
  call json%add(json_root, 'ellipse_scale', input%ellipse_scale)
  call tao_jsonify_aperture_param_struct(input%param, json_val, depth + 1)
  call json%rename(json_val, 'param')
  call json%add(json_root, json_val)
  if (allocated(input%pz)) then
    !line=1043 definition='real(rp), allocatable :: pz(:)' name='pz' python_name='pz' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'pz')
    do i1 = lbound(input%pz, 1), ubound(input%pz, 1)
      call json%create_real(json_val, input%pz(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%scan)) then
    !line=1042 definition='type (aperture_scan_struct), allocatable :: scan(:)' name='scan' python_name='scan' type='aperture_scan_struct' python_type='ApertureScanStruct' size=None dimension=':' comment='One scan for each pz.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'scan')
    do i1 = lbound(input%scan, 1), ubound(input%scan, 1)
      call tao_jsonify_aperture_scan_struct(input%scan(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_dynamic_aperture_struct

subroutine tao_jsonify_aperture_param_struct (input, json_root, depth)
  use bmad_struct, only: aperture_param_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'abs_accuracy', input%abs_accuracy)
  call json%add(json_root, 'max_angle', input%max_angle)
  call json%add(json_root, 'min_angle', input%min_angle)
  call json%add(json_root, 'n_angle', int(input%n_angle))
  call json%add(json_root, 'n_turn', int(input%n_turn))
  call json%add(json_root, 'rel_accuracy', input%rel_accuracy)
  call json%add(json_root, 'start_ele', trim(input%start_ele))
  call json%add(json_root, 'x_init', input%x_init)
  call json%add(json_root, 'y_init', input%y_init)
  
end subroutine tao_jsonify_aperture_param_struct

subroutine tao_jsonify_aperture_scan_struct (input, json_root, depth)
  use bmad_struct, only: aperture_scan_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%point)) then
    !line=2077 definition='type (aperture_point_struct), allocatable :: point(:)' name='point' python_name='point' type='aperture_point_struct' python_type='AperturePointStruct' size=None dimension=':' comment='Set of aperture points at different angles.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'point')
    do i1 = lbound(input%point, 1), ubound(input%point, 1)
      call tao_jsonify_aperture_point_struct(input%point(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'pz_start', input%pz_start)
  call tao_jsonify_coord_struct(input%ref_orb, json_val, depth + 1)
  call json%rename(json_val, 'ref_orb')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_aperture_scan_struct

subroutine tao_jsonify_aperture_point_struct (input, json_root, depth)
  use bmad_struct, only: aperture_point_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'i_turn', int(input%i_turn))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'plane', int(input%plane))
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'y', input%y)
  
end subroutine tao_jsonify_aperture_point_struct

subroutine tao_jsonify_tao_eval_stack1_struct (input, json_root, depth)
  use tao_struct, only: tao_eval_stack1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%info)) then
    !line=102 definition='type (tao_expression_info_struct), allocatable :: info(:)' name='info' python_name='info' type='tao_expression_info_struct' python_type='TaoExpressionInfoStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'info')
    do i1 = lbound(input%info, 1), ubound(input%info, 1)
      call tao_jsonify_tao_expression_info_struct(input%info(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'scale', input%scale)
  call json%add(json_root, 'type', int(input%type))
  if (allocated(input%value)) then
    !line=101 definition='real(rp), allocatable :: value(:)' name='value' python_name='value' type='real' python_type='float' size=None dimension=':' comment='' fortran_default=None default=0.0 default_factory=''
    call json%create_array(json_list1, 'value')
    do i1 = lbound(input%value, 1), ubound(input%value, 1)
      call json%create_real(json_val, input%value(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%value_ptr)) then
    !line=103 definition='type (tao_real_pointer_struct), allocatable :: value_ptr(:)' name='value_ptr' python_name='value_ptr' type='tao_real_pointer_struct' python_type='TaoRealPointerStruct' size=None dimension=':' comment='Used to point to data, lattice parameters, etc' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'value_ptr')
    do i1 = lbound(input%value_ptr, 1), ubound(input%value_ptr, 1)
      call tao_jsonify_tao_real_pointer_struct(input%value_ptr(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_eval_stack1_struct

subroutine tao_jsonify_tao_expression_info_struct (input, json_root, depth)
  use tao_struct, only: tao_expression_info_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%ele)) then
    call tao_jsonify_ele_struct(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'good', input%good)
  call json%add(json_root, 's', input%s)
  
end subroutine tao_jsonify_tao_expression_info_struct

subroutine tao_jsonify_tao_lattice_struct (input, json_root, depth)
  use tao_struct, only: tao_lattice_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'chrom_calc_ok', input%chrom_calc_ok)
  call tao_jsonify_lat_struct(input%high_E_lat, json_val, depth + 1)
  call json%rename(json_val, 'high_E_lat')
  call json%add(json_root, json_val)
  call tao_jsonify_lat_struct(input%lat, json_val, depth + 1)
  call json%rename(json_val, 'lat')
  call json%add(json_root, json_val)
  call tao_jsonify_lat_struct(input%low_E_lat, json_val, depth + 1)
  call json%rename(json_val, 'low_E_lat')
  call json%add(json_root, json_val)
  call json%add(json_root, 'name', trim(input%name))
  call tao_jsonify_rad_int_all_ele_struct(input%rad_int, json_val, depth + 1)
  call json%rename(json_val, 'rad_int')
  call json%add(json_root, json_val)
  if (allocated(input%tao_branch)) then
    !line=957 definition='type (tao_lattice_branch_struct), allocatable :: tao_branch(:)' name='tao_branch' python_name='tao_branch' type='tao_lattice_branch_struct' python_type='TaoLatticeBranchStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'tao_branch')
    do i1 = lbound(input%tao_branch, 1), ubound(input%tao_branch, 1)
      call tao_jsonify_tao_lattice_branch_struct(input%tao_branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  ! parent pointer skip: u (tao_universe_struct, Parent universe)
  
end subroutine tao_jsonify_tao_lattice_struct

subroutine tao_jsonify_rad_int_all_ele_struct (input, json_root, depth)
  use bmad_struct, only: rad_int_all_ele_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%branch)) then
    !line=2343 definition='type (rad_int_branch_struct), allocatable :: branch(:)' name='branch' python_name='branch' type='rad_int_branch_struct' python_type='RadIntBranchStruct' size=None dimension=':' comment='Array is indexed from 0' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'branch')
    do i1 = lbound(input%branch, 1), ubound(input%branch, 1)
      call tao_jsonify_rad_int_branch_struct(input%branch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_rad_int_all_ele_struct

subroutine tao_jsonify_rad_int_branch_struct (input, json_root, depth)
  use bmad_struct, only: rad_int_branch_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%ele)) then
    !line=2339 definition='type (rad_int1_struct), allocatable :: ele(:)' name='ele' python_name='ele' type='rad_int1_struct' python_type='RadInt1Struct' size=None dimension=':' comment='Array is indexed from 0' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call tao_jsonify_rad_int1_struct(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_rad_int_branch_struct

subroutine tao_jsonify_rad_int1_struct (input, json_root, depth)
  use bmad_struct, only: rad_int1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
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
  
end subroutine tao_jsonify_rad_int1_struct

subroutine tao_jsonify_tao_lattice_branch_struct (input, json_root, depth)
  use tao_struct, only: tao_lattice_branch_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_tao_lat_mode_struct(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call tao_jsonify_tao_lat_mode_struct(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call tao_jsonify_bmad_normal_form_struct(input%bmad_normal_form, json_val, depth + 1)
  call json%rename(json_val, 'bmad_normal_form')
  call json%add(json_root, json_val)
  if (allocated(input%bunch_params)) then
    !line=920 definition='type (bunch_params_struct), allocatable :: bunch_params(:)' name='bunch_params' python_name='bunch_params' type='bunch_params_struct' python_type='BunchParamsStruct' size=None dimension=':' comment='Per element' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'bunch_params')
    do i1 = lbound(input%bunch_params, 1), ubound(input%bunch_params, 1)
      call tao_jsonify_bunch_params_struct(input%bunch_params(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%bunch_params_comb)) then
    !line=921 definition='type (bunch_track_struct), allocatable :: bunch_params_comb(:)' name='bunch_params_comb' python_name='bunch_params_comb' type='bunch_track_struct' python_type='BunchTrackStruct' size=None dimension=':' comment='A comb for each bunch in beam.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'bunch_params_comb')
    do i1 = lbound(input%bunch_params_comb, 1), ubound(input%bunch_params_comb, 1)
      call tao_jsonify_bunch_track_struct(input%bunch_params_comb(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'cache_n_pts', int(input%cache_n_pts))
  call json%add(json_root, 'cache_x_max', input%cache_x_max)
  call json%add(json_root, 'cache_x_min', input%cache_x_min)
  call json%add(json_root, 'comb_ds_save', input%comb_ds_save)
  call json%add(json_root, 'comb_max_ds_save', input%comb_max_ds_save)
  call json%add(json_root, 'has_open_match_element', input%has_open_match_element)
  call json%add(json_root, 'ix_rad_int_cache', int(input%ix_rad_int_cache))
  if (allocated(input%lat_sigma)) then
    !line=918 definition='type (tao_lat_sigma_struct), allocatable :: lat_sigma(:)' name='lat_sigma' python_name='lat_sigma' type='tao_lat_sigma_struct' python_type='TaoLatSigmaStruct' size=None dimension=':' comment='Sigma matrix derived from lattice (not beam).' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'lat_sigma')
    do i1 = lbound(input%lat_sigma, 1), ubound(input%lat_sigma, 1)
      call tao_jsonify_tao_lat_sigma_struct(input%lat_sigma(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'mode_flip_here', input%mode_flip_here)
  call tao_jsonify_normal_modes_struct(input%modes_6d, json_val, depth + 1)
  call json%rename(json_val, 'modes_6d')
  call json%add(json_root, json_val)
  call tao_jsonify_normal_modes_struct(input%modes_ri, json_val, depth + 1)
  call json%rename(json_val, 'modes_ri')
  call json%add(json_root, json_val)
  call json%add(json_root, 'n_hterms', int(input%n_hterms))
  call tao_jsonify_coord_struct(input%orb0, json_val, depth + 1)
  call json%rename(json_val, 'orb0')
  call json%add(json_root, json_val)
  if (allocated(input%orbit)) then
    !line=922 definition='type (coord_struct), allocatable :: orbit(:)' name='orbit' python_name='orbit' type='coord_struct' python_type='CoordStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'orbit')
    do i1 = lbound(input%orbit, 1), ubound(input%orbit, 1)
      call tao_jsonify_coord_struct(input%orbit(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%plot_cache)) then
    !line=923 definition='type (tao_plot_cache_struct), allocatable :: plot_cache(:)' name='plot_cache' python_name='plot_cache' type='tao_plot_cache_struct' python_type='TaoPlotCacheStruct' size=None dimension=':' comment='Plotting data cache' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'plot_cache')
    do i1 = lbound(input%plot_cache, 1), ubound(input%plot_cache, 1)
      call tao_jsonify_tao_plot_cache_struct(input%plot_cache(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'plot_cache_valid', input%plot_cache_valid)
  call tao_jsonify_ptc_normal_form_struct(input%ptc_normal_form, json_val, depth + 1)
  call json%rename(json_val, 'ptc_normal_form')
  call json%add(json_root, json_val)
  call tao_jsonify_tao_spin_polarization_struct(input%spin, json_val, depth + 1)
  call json%rename(json_val, 'spin')
  call json%add(json_root, json_val)
  if (allocated(input%spin_ele)) then
    !line=919 definition='type (tao_spin_ele_struct), allocatable :: spin_ele(:)' name='spin_ele' python_name='spin_ele' type='tao_spin_ele_struct' python_type='TaoSpinEleStruct' size=None dimension=':' comment='Spin stuff' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'spin_ele')
    do i1 = lbound(input%spin_ele, 1), ubound(input%spin_ele, 1)
      call tao_jsonify_tao_spin_ele_struct(input%spin_ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'spin_map_valid', input%spin_map_valid)
  call tao_jsonify_summation_rdt_struct(input%srdt, json_val, depth + 1)
  call json%rename(json_val, 'srdt')
  call json%add(json_root, json_val)
  ! parent pointer skip: tao_lat (tao_lattice_struct, Parent tao_lat)
  call json%add(json_root, 'track_state', int(input%track_state))
  call json%add(json_root, 'twiss_valid', input%twiss_valid)
  
end subroutine tao_jsonify_tao_lattice_branch_struct

subroutine tao_jsonify_bmad_normal_form_struct (input, json_root, depth)
  use bmad_struct, only: bmad_normal_form_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=1526 definition='type (taylor_struct) :: A(6) = taylor_struct()' name='A' python_name='a' type='taylor_struct' python_type='TaylorStruct' size=None dimension='6' comment='Map from Floquet -> Lab coordinates' fortran_default='taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'a')
  do i1 = lbound(input%A, 1), ubound(input%A, 1)
    call tao_jsonify_taylor_struct(input%A(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1527 definition='type (taylor_struct) :: A_inv(6) = taylor_struct()' name='A_inv' python_name='a_inv' type='taylor_struct' python_type='TaylorStruct' size=None dimension='6' comment='Map from Lab -> Floquet coordinates' fortran_default='taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'a_inv')
  do i1 = lbound(input%A_inv, 1), ubound(input%A_inv, 1)
    call tao_jsonify_taylor_struct(input%A_inv(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1529 definition='type (complex_taylor_struct) :: F(6) = complex_taylor_struct()' name='F' python_name='f' type='complex_taylor_struct' python_type='ComplexTaylorStruct' size=None dimension='6' comment='Vector field factorization in phasor basis:' fortran_default='complex_taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'f')
  do i1 = lbound(input%F, 1), ubound(input%F, 1)
    call tao_jsonify_complex_taylor_struct(input%F(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1530 definition='type (complex_taylor_struct) :: L(6) = complex_taylor_struct()' name='L' python_name='L' type='complex_taylor_struct' python_type='ComplexTaylorStruct' size=None dimension='6' comment='L component' fortran_default='complex_taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'L')
  do i1 = lbound(input%L, 1), ubound(input%L, 1)
    call tao_jsonify_complex_taylor_struct(input%L(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1525 definition='type (taylor_struct) :: M(6) = taylor_struct()' name='M' python_name='m' type='taylor_struct' python_type='TaylorStruct' size=None dimension='6' comment='One-turn taylor map: M = A o N o A_inv, N = exp(:h:)' fortran_default='taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'm')
  do i1 = lbound(input%M, 1), ubound(input%M, 1)
    call tao_jsonify_taylor_struct(input%M(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1528 definition='type (taylor_struct) :: dhdj(6) = taylor_struct()' name='dhdj' python_name='dhdj' type='taylor_struct' python_type='TaylorStruct' size=None dimension='6' comment='Nonlinear tune function operating on Floquet coordinates' fortran_default='taylor_struct()' default=None default_factory=''
  call json%create_array(json_list1, 'dhdj')
  do i1 = lbound(input%dhdj, 1), ubound(input%dhdj, 1)
    call tao_jsonify_taylor_struct(input%dhdj(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%ele_origin)) then
    call tao_jsonify_ele_struct(input%ele_origin, json_val, depth + 1)
    call json%rename(json_val, 'ele_origin')
    call json%add(json_root, json_val)
  endif
  if (allocated(input%h)) then
    !line=1531 definition='type (resonance_h_struct), allocatable :: h(:)' name='h' python_name='h' type='resonance_h_struct' python_type='ResonanceHStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'h')
    do i1 = lbound(input%h, 1), ubound(input%h, 1)
      call tao_jsonify_resonance_h_struct(input%h(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_bmad_normal_form_struct

subroutine tao_jsonify_bunch_params_struct (input, json_root, depth)
  use bmad_struct, only: bunch_params_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_twiss_struct(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%c, json_val, depth + 1)
  call json%rename(json_val, 'c')
  call json%add(json_root, json_val)
  call tao_jsonify_coord_struct(input%centroid, json_val, depth + 1)
  call json%rename(json_val, 'centroid')
  call json%add(json_root, json_val)
  call json%add(json_root, 'charge_live', input%charge_live)
  call json%add(json_root, 'charge_tot', input%charge_tot)
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'location', int(input%location))
  call json%add(json_root, 'n_bad_steps', int(input%n_bad_steps))
  call json%add(json_root, 'n_good_steps', int(input%n_good_steps))
  call json%add(json_root, 'n_particle_live', int(input%n_particle_live))
  call json%add(json_root, 'n_particle_lost_in_ele', int(input%n_particle_lost_in_ele))
  call json%add(json_root, 'n_particle_tot', int(input%n_particle_tot))
  !line=1185 definition='real(rp) :: rel_max(7) = 0' name='rel_max' python_name='rel_max' type='real' python_type='float' size=None dimension='7' comment='Max orbit relative to centroid. 7 -> time.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'rel_max')
  do i1 = lbound(input%rel_max, 1), ubound(input%rel_max, 1)
    call json%create_real(json_val, input%rel_max(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1186 definition='real(rp) :: rel_min(7) = 0' name='rel_min' python_name='rel_min' type='real' python_type='float' size=None dimension='7' comment='Min orbit relative to_centroid. 7 -> time.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'rel_min')
  do i1 = lbound(input%rel_min, 1), ubound(input%rel_min, 1)
    call json%create_real(json_val, input%rel_min(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 's', input%s)
  !line=1184 definition='real(rp) :: sigma(6,6) = 0' name='sigma' python_name='sigma' type='real' python_type='float' size=None dimension='6,6' comment='beam size matrix' fortran_default='0' default=0 default_factory=''
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
  call json%add(json_root, 'sigma_t', input%sigma_t)
  call json%add(json_root, 't', input%t)
  call json%add(json_root, 'twiss_valid', input%twiss_valid)
  call tao_jsonify_twiss_struct(input%x, json_val, depth + 1)
  call json%rename(json_val, 'x')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%y, json_val, depth + 1)
  call json%rename(json_val, 'y')
  call json%add(json_root, json_val)
  call tao_jsonify_twiss_struct(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_bunch_params_struct

subroutine tao_jsonify_bunch_track_struct (input, json_root, depth)
  use bmad_struct, only: bunch_track_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'ds_save', input%ds_save)
  call json%add(json_root, 'max_ds_save', input%max_ds_save)
  call json%add(json_root, 'n_pt', int(input%n_pt))
  if (allocated(input%pt)) then
    !line=1207 definition='type (bunch_params_struct), allocatable :: pt(:)' name='pt' python_name='pt' type='bunch_params_struct' python_type='BunchParamsStruct' size=None dimension=':' comment='Array indexed from 0' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'pt')
    do i1 = lbound(input%pt, 1), ubound(input%pt, 1)
      call tao_jsonify_bunch_params_struct(input%pt(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_bunch_track_struct

subroutine tao_jsonify_complex_taylor_struct (input, json_root, depth)
  use bmad_struct, only: complex_taylor_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%ref, json_list1, depth+1)
  call json%rename(json_list1, 'ref')
  call json%add(json_root, json_list1)
  if (associated(input%term)) then
    !line=488 definition='type (complex_taylor_term_struct), pointer :: term(:) => null()' name='term' python_name='term' type='complex_taylor_term_struct' python_type='ComplexTaylorTermStruct' size=None dimension=':' comment='' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call tao_jsonify_complex_taylor_term_struct(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_complex_taylor_struct

subroutine tao_jsonify_complex_taylor_term_struct (input, json_root, depth)
  use bmad_struct, only: complex_taylor_term_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%coef, json_list1, depth+1)
  call json%rename(json_list1, 'coef')
  call json%add(json_root, json_list1)
  !line=470 definition='integer :: expn(6)' name='expn' python_name='expn' type='integer' python_type='int' size=None dimension='6' comment='' fortran_default=None default=0 default_factory=''
  call json%create_array(json_list1, 'expn')
  do i1 = lbound(input%expn, 1), ubound(input%expn, 1)
    call json%create_integer(json_val, input%expn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_complex_taylor_term_struct

subroutine tao_jsonify_normal_modes_struct (input, json_root, depth)
  use bmad_struct, only: normal_modes_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_anormal_mode_struct(input%a, json_val, depth + 1)
  call json%rename(json_val, 'a')
  call json%add(json_root, json_val)
  call tao_jsonify_anormal_mode_struct(input%b, json_val, depth + 1)
  call json%rename(json_val, 'b')
  call json%add(json_root, json_val)
  call json%add(json_root, 'dpz_damp', input%dpz_damp)
  call json%add(json_root, 'e_loss', input%e_loss)
  call tao_jsonify_linac_normal_mode_struct(input%lin, json_val, depth + 1)
  call json%rename(json_val, 'lin')
  call json%add(json_root, json_val)
  call json%add(json_root, 'momentum_compaction', input%momentum_compaction)
  call json%add(json_root, 'pz_aperture', input%pz_aperture)
  call json%add(json_root, 'pz_average', input%pz_average)
  call json%add(json_root, 'rf_voltage', input%rf_voltage)
  call json%add(json_root, 'sige_e', input%sigE_E)
  call json%add(json_root, 'sig_z', input%sig_z)
  !line=1934 definition='real(rp) :: synch_int(0:3) = 0' name='synch_int' python_name='synch_int' type='real' python_type='float' size=None dimension='0:3' comment='Synchrotron integrals I0, I1, I2, and I3' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'synch_int')
  do i1 = lbound(input%synch_int, 1), ubound(input%synch_int, 1)
    call json%create_real(json_val, input%synch_int(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_anormal_mode_struct(input%z, json_val, depth + 1)
  call json%rename(json_val, 'z')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_normal_modes_struct

subroutine tao_jsonify_anormal_mode_struct (input, json_root, depth)
  use bmad_struct, only: anormal_mode_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'alpha_damp', input%alpha_damp)
  call json%add(json_root, 'chrom', input%chrom)
  call json%add(json_root, 'emittance', input%emittance)
  call json%add(json_root, 'emittance_no_vert', input%emittance_no_vert)
  call json%add(json_root, 'j_damp', input%j_damp)
  !line=1916 definition='real(rp) :: synch_int(4:6) = 0' name='synch_int' python_name='synch_int' type='real' python_type='float' size=None dimension='4:6' comment='Synchrotron integrals' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'synch_int')
  do i1 = lbound(input%synch_int, 1), ubound(input%synch_int, 1)
    call json%create_real(json_val, input%synch_int(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'tune', input%tune)
  
end subroutine tao_jsonify_anormal_mode_struct

subroutine tao_jsonify_linac_normal_mode_struct (input, json_root, depth)
  use bmad_struct, only: linac_normal_mode_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'a_emittance_end', input%a_emittance_end)
  call json%add(json_root, 'b_emittance_end', input%b_emittance_end)
  call json%add(json_root, 'i2_e4', input%i2_E4)
  call json%add(json_root, 'i3_e7', input%i3_E7)
  call json%add(json_root, 'i5a_e6', input%i5a_E6)
  call json%add(json_root, 'i5b_e6', input%i5b_E6)
  call json%add(json_root, 'sig_e1', input%sig_E1)
  
end subroutine tao_jsonify_linac_normal_mode_struct

subroutine tao_jsonify_ptc_normal_form_struct (input, json_root, depth)
  use bmad_struct, only: ptc_normal_form_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%ele_origin)) then
    call tao_jsonify_ele_struct(input%ele_origin, json_val, depth + 1)
    call json%rename(json_val, 'ele_origin')
    call json%add(json_root, json_val)
  endif
  call tao_jsonify_c_quaternion(input%isf, json_val, depth + 1)
  call json%rename(json_val, 'isf')
  call json%add(json_root, json_val)
  call tao_jsonify_c_normal_form(input%normal_form, json_val, depth + 1)
  call json%rename(json_val, 'normal_form')
  call json%add(json_root, json_val)
  call tao_jsonify_probe_8(input%one_turn_map, json_val, depth + 1)
  call json%rename(json_val, 'one_turn_map')
  call json%add(json_root, json_val)
  !line=1537 definition='real(rp) orb0(6)' name='orb0' python_name='orb0' type='real' python_type='float' size=None dimension='6' comment='Closed orbit at element.' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'orb0')
  do i1 = lbound(input%orb0, 1), ubound(input%orb0, 1)
    call json%create_real(json_val, input%orb0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_c_taylor(input%path_length, json_val, depth + 1)
  call json%rename(json_val, 'path_length')
  call json%add(json_root, json_val)
  !line=1539 definition='type (c_taylor) phase(3)' name='phase' python_name='phase' type='c_taylor' python_type='CTaylor' size=None dimension='3' comment='Phase/chromaticity maps' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'phase')
  do i1 = lbound(input%phase, 1), ubound(input%phase, 1)
    call tao_jsonify_c_taylor(input%phase(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_c_taylor(input%spin_tune, json_val, depth + 1)
  call json%rename(json_val, 'spin_tune')
  call json%add(json_root, json_val)
  ! skipped explicitly by converter: struct=INTERNAL_STATE file=a_def_element_fibre_layout.inc member=json_obj
  call json%add(json_root, 'valid_map', input%valid_map)
  
end subroutine tao_jsonify_ptc_normal_form_struct

subroutine tao_jsonify_c_normal_form (input, json_root, depth)
  use ptc_spin, only: c_normal_form
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (c_normal_form), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_c_damap(input%As, json_val, depth + 1)
  call json%rename(json_val, 'As')
  call json%add(json_root, json_val)
  call tao_jsonify_c_damap(input%Atot, json_val, depth + 1)
  call json%rename(json_val, 'Atot')
  call json%add(json_root, json_val)
  call tao_jsonify_c_vector_field(input%H, json_val, depth + 1)
  call json%rename(json_val, 'H')
  call json%add(json_root, json_val)
  call tao_jsonify_c_vector_field(input%H_l, json_val, depth + 1)
  call json%rename(json_val, 'H_l')
  call json%add(json_root, json_val)
  call tao_jsonify_c_vector_field(input%H_nl, json_val, depth + 1)
  call json%rename(json_val, 'H_nl')
  call json%add(json_root, json_val)
  !line=497 definition='integer NRES,M(NDIM2t/2,NRESO),ms(NRESO)' name='M' python_name='m' type='integer' python_type='int' size=None dimension='NDIM2t/2,NRESO' comment='@1 stores resonances to be left in the map, including spin (ms)' fortran_default=None default=0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%M, 2), ubound(input%M, 2)
    call json%create_array(json_list1, 'm')
    do i1 = lbound(input%M, 1), ubound(input%M, 1)
      call json%create_integer(json_val, input%M(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'nres', int(input%NRES))
  call tao_jsonify_c_damap(input%a1, json_val, depth + 1)
  call json%rename(json_val, 'a1')
  call json%add(json_root, json_val)
  call tao_jsonify_c_damap(input%a2, json_val, depth + 1)
  call json%rename(json_val, 'a2')
  call json%add(json_root, json_val)
  call tao_jsonify_c_damap(input%a_t, json_val, depth + 1)
  call json%rename(json_val, 'a_t')
  call json%add(json_root, json_val)
  !line=494 definition='complex(dp) b_ijr(6,6)' name='b_ijr' python_name='b_ijr' type='complex' python_type='Complex' size=None dimension='6,6' comment='@1   stochastic kick in resonance basis' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%b_ijr, 2), ubound(input%b_ijr, 2)
    call json%create_array(json_list1, 'b_ijr')
    do i1 = lbound(input%b_ijr, 1), ubound(input%b_ijr, 1)
      call tao_jsonify_complex(input%b_ijr(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=499 definition='real(dp) tune(NDIM2t/2),damping(NDIM2t/2),spin_tune,quaternion_angle' name='damping' python_name='damping' type='real' python_type='float' size=None dimension='NDIM2t/2' comment='@1 Stores simple information' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'damping')
  do i1 = lbound(input%damping, 1), ubound(input%damping, 1)
    call json%create_real(json_val, input%damping(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=495 definition='real(dp) emittance(3)' name='emittance' python_name='emittance' type='real' python_type='float' size=None dimension='3' comment='@1  Equilibrium emittances as defined by Chao (computed from s_ijr(2*i-1,2*i) i=1,2,3 ) ! controls resonances left in normal form' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'emittance')
  do i1 = lbound(input%emittance, 1), ubound(input%emittance, 1)
    call json%create_real(json_val, input%emittance(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  ! parent pointer skip: g (c_factored_lie, @1 nonlinear part of a in phasors)
  call tao_jsonify_c_factored_lie(input%ker, json_val, depth + 1)
  call json%rename(json_val, 'ker')
  call json%add(json_root, json_val)
  !line=497 definition='integer NRES,M(NDIM2t/2,NRESO),ms(NRESO)' name='ms' python_name='ms' type='integer' python_type='int' size=None dimension='NRESO' comment='@1 stores resonances to be left in the map, including spin (ms) ! redundant stuff' fortran_default=None default=0 default_factory=''
  call json%create_array(json_list1, 'ms')
  do i1 = lbound(input%ms, 1), ubound(input%ms, 1)
    call json%create_integer(json_val, input%ms(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call tao_jsonify_c_damap(input%n, json_val, depth + 1)
  call json%rename(json_val, 'n')
  call json%add(json_root, json_val)
  call json%add(json_root, 'positive', input%positive)
  call json%add(json_root, 'quaternion_angle', input%quaternion_angle)
  !line=492 definition='complex(dp) s_ij0(6,6)' name='s_ij0' python_name='s_ij0' type='complex' python_type='Complex' size=None dimension='6,6' comment='@1  equilibrium beam sizes' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%s_ij0, 2), ubound(input%s_ij0, 2)
    call json%create_array(json_list1, 's_ij0')
    do i1 = lbound(input%s_ij0, 1), ubound(input%s_ij0, 1)
      call tao_jsonify_complex(input%s_ij0(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=493 definition='complex(dp) s_ijr(6,6)' name='s_ijr' python_name='s_ijr' type='complex' python_type='Complex' size=None dimension='6,6' comment='@1  equilibrium beam sizes in resonance basis' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%s_ijr, 2), ubound(input%s_ijr, 2)
    call json%create_array(json_list1, 's_ijr')
    do i1 = lbound(input%s_ijr, 1), ubound(input%s_ijr, 1)
      call tao_jsonify_complex(input%s_ijr(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  call json%add(json_root, 'spin_tune', input%spin_tune)
  !line=499 definition='real(dp) tune(NDIM2t/2),damping(NDIM2t/2),spin_tune,quaternion_angle' name='tune' python_name='tune' type='real' python_type='float' size=None dimension='NDIM2t/2' comment='@1 Stores simple information' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'tune')
  do i1 = lbound(input%tune, 1), ubound(input%tune, 1)
    call json%create_real(json_val, input%tune(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_c_normal_form

subroutine tao_jsonify_c_damap (input, json_root, depth)
  use ptc_spin, only: c_damap
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (c_damap), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%cm)) then
    !line=444 definition='complex(dp), pointer :: cm(:,:)=> null()' name='cm' python_name='cm' type='complex' python_type='Complex' size=None dimension=':,:' comment='Moment matrix (transpose of Yu Matrix)' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%cm, 2), ubound(input%cm, 2)
      call json%create_array(json_list1, 'cm')
      do i1 = lbound(input%cm, 1), ubound(input%cm, 1)
        call tao_jsonify_complex(input%cm(i1, i2), json_val, depth + 1)
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  !line=438 definition='complex(dp) e_ij(6,6)' name='e_ij' python_name='e_ij' type='complex' python_type='Complex' size=None dimension='6,6' comment='@1 stochastic fluctuation in radiation theory Number of planes allocated' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%e_ij, 2), ubound(input%e_ij, 2)
    call json%create_array(json_list1, 'e_ij')
    do i1 = lbound(input%e_ij, 1), ubound(input%e_ij, 1)
      call tao_jsonify_complex(input%e_ij(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  if (associated(input%m)) then
    !line=446 definition='real(dpn),pointer :: m(:,:)=> null()' name='m' python_name='m' type='real' python_type='float' size=None dimension=':,:' comment='SO(3) is deprecated in FPP and computed from quaternion if needed' fortran_default='null()' default=0.0 default_factory=''
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%m, 2), ubound(input%m, 2)
      call json%create_array(json_list1, 'm')
      do i1 = lbound(input%m, 1), ubound(input%m, 1)
        call json%create_real(json_val, input%m(i1, i2), '')
        call json%add(json_list1, json_val)
      enddo
      call json%add(json_list2, json_list1)
      nullify(json_list1)
    enddo
    call json%add(json_root, json_list2)
    nullify(json_list2)
  endif
  call json%add(json_root, 'n', int(input%n))
  call tao_jsonify_c_quaternion(input%q, json_val, depth + 1)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  call tao_jsonify_c_spinmatrix(input%s, json_val, depth + 1)
  call json%rename(json_val, 's')
  call json%add(json_root, json_val)
  !line=435 definition='type (c_taylor) v(lnv)' name='v' python_name='v' type='c_taylor' python_type='CTaylor' size=None dimension='lnv' comment='@1 orbital part of the map' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%v, 1), ubound(input%v, 1)
    call tao_jsonify_c_taylor(input%v(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=442 definition='complex(dp) x0(lnv)' name='x0' python_name='x0' type='complex' python_type='Complex' size=None dimension='lnv' comment="Lie map matrix  (Yu's square matrix)" fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'x0')
  do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
    call tao_jsonify_complex(input%x0(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_c_damap

subroutine tao_jsonify_c_factored_lie (input, json_root, depth)
  use ptc_spin, only: c_factored_lie
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (c_factored_lie), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'dir', int(input%dir))
  if (associated(input%f)) then
    !line=483 definition='type (c_vector_field), pointer :: f(:)=>null()' name='f' python_name='f' type='c_vector_field' python_type='CVectorField' size=None dimension=':' comment='' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'f')
    do i1 = lbound(input%f, 1), ubound(input%f, 1)
      call tao_jsonify_c_vector_field(input%f(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n', int(input%n))
  
end subroutine tao_jsonify_c_factored_lie

subroutine tao_jsonify_c_quaternion (input, json_root, depth)
  use ptc_spin, only: c_quaternion
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (c_quaternion), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=429 definition='type(c_taylor) x(0:3)' name='x' python_name='x' type='c_taylor' python_type='CTaylor' size=None dimension='0:3' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call tao_jsonify_c_taylor(input%x(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_c_quaternion

subroutine tao_jsonify_c_spinmatrix (input, json_root, depth)
  use ptc_spin, only: c_spinmatrix
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (c_spinmatrix), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=415 definition='type(c_taylor) s(3,3)' name='s' python_name='s' type='c_taylor' python_type='CTaylor' size=None dimension='3,3' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%s, 2), ubound(input%s, 2)
    call json%create_array(json_list1, 's')
    do i1 = lbound(input%s, 1), ubound(input%s, 1)
      call tao_jsonify_c_taylor(input%s(i1, i2), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  
end subroutine tao_jsonify_c_spinmatrix

subroutine tao_jsonify_C_taylor (input, json_root, depth)
  use ptc_spin, only: C_taylor
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (C_taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'i', int(input%I))
  
end subroutine tao_jsonify_C_taylor

subroutine tao_jsonify_c_vector_field (input, json_root, depth)
  use ptc_spin, only: c_vector_field
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (c_vector_field), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'eps', input%eps)
  call json%add(json_root, 'n', int(input%n))
  call json%add(json_root, 'nrmax', int(input%nrmax))
  call tao_jsonify_c_quaternion(input%q, json_val, depth + 1)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  !line=468 definition='type (c_taylor) v(lnv)' name='v' python_name='v' type='c_taylor' python_type='CTaylor' size=None dimension='lnv' comment='quaternion part' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'v')
  do i1 = lbound(input%v, 1), ubound(input%v, 1)
    call tao_jsonify_c_taylor(input%v(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_c_vector_field

subroutine tao_jsonify_probe_8 (input, json_root, depth)
  use ptc_spin, only: probe_8
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (probe_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=362 definition='real(dp) E_ij(6,6)' name='E_ij' python_name='e_ij' type='real' python_type='float' size=None dimension='6,6' comment='Envelope for stochastic radiation' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list2, 'dim-2')
  do i2 = lbound(input%E_ij, 2), ubound(input%E_ij, 2)
    call json%create_array(json_list1, 'e_ij')
    do i1 = lbound(input%E_ij, 1), ubound(input%E_ij, 1)
      call json%create_real(json_val, input%E_ij(i1, i2), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_list2, json_list1)
    nullify(json_list1)
  enddo
  call json%add(json_root, json_list2)
  nullify(json_list2)
  !line=360 definition='type(rf_phasor_8)  ac(nacmax)' name='ac' python_name='ac' type='rf_phasor_8' python_type='RfPhasor8' size=None dimension='nacmax' comment='Modulation of magnet' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'ac')
  do i1 = lbound(input%ac, 1), ubound(input%ac, 1)
    call tao_jsonify_rf_phasor_8(input%ac(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'e', input%e)
  ! skipped explicitly by converter: struct=INTEGRATION_NODE file=a_def_element_fibre_layout.inc member=json_obj
  call json%add(json_root, 'nac', int(input%nac))
  call tao_jsonify_quaternion_8(input%q, json_val, depth + 1)
  call json%rename(json_val, 'q')
  call json%add(json_root, json_val)
  !line=358 definition='type(spinor_8) s(3)' name='s' python_name='s' type='spinor_8' python_type='Spinor8' size=None dimension='3' comment='Polymorphic spin s(1:3)' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 's')
  do i1 = lbound(input%s, 1), ubound(input%s, 1)
    call tao_jsonify_spinor_8(input%s(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  ! parent pointer skip: u (logical, )
  call json%add(json_root, 'use_q', input%use_q)
  !line=357 definition='type(real_8) x(6)' name='x' python_name='x' type='real_8' python_type='Real8' size=None dimension='6' comment='Polymorphic orbital ray' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call tao_jsonify_real_8(input%x(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=363 definition='real(dp) x0(6)' name='x0' python_name='x0' type='real' python_type='float' size=None dimension='6' comment='initial value of the ray for TPSA calculations with c_damap stuff for exception' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'x0')
  do i1 = lbound(input%x0, 1), ubound(input%x0, 1)
    call json%create_real(json_val, input%x0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_probe_8

subroutine tao_jsonify_quaternion_8 (input, json_root, depth)
  use ptc_spin, only: quaternion_8
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (quaternion_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=134 definition='type(real_8) x(0:3)' name='x' python_name='x' type='real_8' python_type='Real8' size=None dimension='0:3' comment='' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call tao_jsonify_real_8(input%x(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_quaternion_8

subroutine tao_jsonify_REAL_8 (input, json_root, depth)
  use ptc_spin, only: REAL_8
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (REAL_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'alloc', input%ALLOC)
  call json%add(json_root, 'i', int(input%I))
  call json%add(json_root, 'kind', int(input%KIND))
  call json%add(json_root, 'r', input%R)
  call json%add(json_root, 's', input%S)
  call tao_jsonify_TAYLOR(input%T, json_val, depth + 1)
  call json%rename(json_val, 'T')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_REAL_8

subroutine tao_jsonify_taylor (input, json_root, depth)
  use ptc_spin, only: taylor
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (taylor), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'i', int(input%I))
  
end subroutine tao_jsonify_taylor

subroutine tao_jsonify_resonance_h_struct (input, json_root, depth)
  use bmad_struct, only: resonance_h_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%c_val, json_list1, depth+1)
  call json%rename(json_list1, 'c_val')
  call json%add(json_root, json_list1)
  call json%add(json_root, 'id', trim(input%id))
  
end subroutine tao_jsonify_resonance_h_struct

subroutine tao_jsonify_rf_phasor_8 (input, json_root, depth)
  use ptc_spin, only: rf_phasor_8
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (rf_phasor_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_real_8(input%om, json_val, depth + 1)
  call json%rename(json_val, 'om')
  call json%add(json_root, json_val)
  call json%add(json_root, 't', input%t)
  !line=339 definition='type(real_8)  x(2)' name='x' python_name='x' type='real_8' python_type='Real8' size=None dimension='2' comment='The two hands of the clock' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call tao_jsonify_real_8(input%x(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_rf_phasor_8

subroutine tao_jsonify_spinor_8 (input, json_root, depth)
  use ptc_spin, only: spinor_8
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (spinor_8), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=165 definition='type(real_8) x(3)' name='x' python_name='x' type='real_8' python_type='Real8' size=None dimension='3' comment='x(3) = (s_x, s_y, s_z)   with  |s|=1' fortran_default=None default=None default_factory=''
  call json%create_array(json_list1, 'x')
  do i1 = lbound(input%x, 1), ubound(input%x, 1)
    call tao_jsonify_real_8(input%x(i1), json_val, depth + 1)
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_spinor_8

subroutine tao_jsonify_summation_rdt_struct (input, json_root, depth)
  use srdt_mod, only: summation_rdt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_complex(input%h00111, json_list1, depth+1)
  call json%rename(json_list1, 'h00111')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h00201, json_list1, depth+1)
  call json%rename(json_list1, 'h00201')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h00220, json_list1, depth+1)
  call json%rename(json_list1, 'h00220')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h00310, json_list1, depth+1)
  call json%rename(json_list1, 'h00310')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h00400, json_list1, depth+1)
  call json%rename(json_list1, 'h00400')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h10002, json_list1, depth+1)
  call json%rename(json_list1, 'h10002')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h10020, json_list1, depth+1)
  call json%rename(json_list1, 'h10020')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h10110, json_list1, depth+1)
  call json%rename(json_list1, 'h10110')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h10200, json_list1, depth+1)
  call json%rename(json_list1, 'h10200')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h11001, json_list1, depth+1)
  call json%rename(json_list1, 'h11001')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h11110, json_list1, depth+1)
  call json%rename(json_list1, 'h11110')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h11200, json_list1, depth+1)
  call json%rename(json_list1, 'h11200')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h20001, json_list1, depth+1)
  call json%rename(json_list1, 'h20001')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h20020, json_list1, depth+1)
  call json%rename(json_list1, 'h20020')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h20110, json_list1, depth+1)
  call json%rename(json_list1, 'h20110')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h20200, json_list1, depth+1)
  call json%rename(json_list1, 'h20200')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h21000, json_list1, depth+1)
  call json%rename(json_list1, 'h21000')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h22000, json_list1, depth+1)
  call json%rename(json_list1, 'h22000')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h30000, json_list1, depth+1)
  call json%rename(json_list1, 'h30000')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h31000, json_list1, depth+1)
  call json%rename(json_list1, 'h31000')
  call json%add(json_root, json_list1)
  call tao_jsonify_complex(input%h40000, json_list1, depth+1)
  call json%rename(json_list1, 'h40000')
  call json%add(json_root, json_list1)
  
end subroutine tao_jsonify_summation_rdt_struct

subroutine tao_jsonify_tao_lat_mode_struct (input, json_root, depth)
  use tao_struct, only: tao_lat_mode_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'chrom', input%chrom)
  call json%add(json_root, 'growth_rate', input%growth_rate)
  
end subroutine tao_jsonify_tao_lat_mode_struct

subroutine tao_jsonify_tao_lat_sigma_struct (input, json_root, depth)
  use tao_struct, only: tao_lat_sigma_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=868 definition='real(rp) :: mat(6,6) = 0' name='mat' python_name='mat' type='real' python_type='float' size=None dimension='6,6' comment='' fortran_default='0' default=0 default_factory=''
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
  
end subroutine tao_jsonify_tao_lat_sigma_struct

subroutine tao_jsonify_tao_model_branch_struct (input, json_root, depth)
  use tao_struct, only: tao_model_branch_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_tao_beam_branch_struct(input%beam, json_val, depth + 1)
  call json%rename(json_val, 'beam')
  call json%add(json_root, json_val)
  if (allocated(input%ele)) then
    !line=993 definition='type (tao_model_element_struct), allocatable :: ele(:)' name='ele' python_name='ele' type='tao_model_element_struct' python_type='TaoModelElementStruct' size=None dimension=':' comment='Per element information' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'ele')
    do i1 = lbound(input%ele, 1), ubound(input%ele, 1)
      call tao_jsonify_tao_model_element_struct(input%ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_model_branch_struct

subroutine tao_jsonify_tao_beam_branch_struct (input, json_root, depth)
  use tao_struct, only: tao_beam_branch_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_beam_struct(input%beam_at_start, json_val, depth + 1)
  call json%rename(json_val, 'beam_at_start')
  call json%add(json_root, json_val)
  call tao_jsonify_beam_init_struct(input%beam_init, json_val, depth + 1)
  call json%rename(json_val, 'beam_init')
  call json%add(json_root, json_val)
  call tao_jsonify_beam_init_struct(input%beam_init_used, json_val, depth + 1)
  call json%rename(json_val, 'beam_init_used')
  call json%add(json_root, json_val)
  call json%add(json_root, 'init_starting_distribution', input%init_starting_distribution)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_track_end', int(input%ix_track_end))
  call json%add(json_root, 'ix_track_start', int(input%ix_track_start))
  call json%add(json_root, 'track_end', trim(input%track_end))
  call json%add(json_root, 'track_start', trim(input%track_start))
  
end subroutine tao_jsonify_tao_beam_branch_struct

subroutine tao_jsonify_beam_struct (input, json_root, depth)
  use bmad_struct, only: beam_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (allocated(input%bunch)) then
    !line=1105 definition='type (bunch_struct), allocatable :: bunch(:)' name='bunch' python_name='bunch' type='bunch_struct' python_type='BunchStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'bunch')
    do i1 = lbound(input%bunch, 1), ubound(input%bunch, 1)
      call tao_jsonify_bunch_struct(input%bunch(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_beam_struct

subroutine tao_jsonify_bunch_struct (input, json_root, depth)
  use bmad_struct, only: bunch_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'charge_live', input%charge_live)
  call json%add(json_root, 'charge_tot', input%charge_tot)
  call json%add(json_root, 'drift_between_t_and_s', input%drift_between_t_and_s)
  call json%add(json_root, 'ix_bunch', int(input%ix_bunch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_turn', int(input%ix_turn))
  if (allocated(input%ix_z)) then
    !line=1086 definition='integer, allocatable :: ix_z(:)' name='ix_z' python_name='ix_z' type='integer, allocatable' python_type='int' size=None dimension=':' comment='bunch%ix_z(1) is index of head particle, etc.' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'ix_z')
    do i1 = lbound(input%ix_z, 1), ubound(input%ix_z, 1)
      call json%create_integer(json_val, input%ix_z(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_bad', int(input%n_bad))
  call json%add(json_root, 'n_good', int(input%n_good))
  call json%add(json_root, 'n_live', int(input%n_live))
  if (allocated(input%particle)) then
    !line=1085 definition='type (coord_struct), allocatable :: particle(:)' name='particle' python_name='particle' type='coord_struct' python_type='CoordStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'particle')
    do i1 = lbound(input%particle, 1), ubound(input%particle, 1)
      call tao_jsonify_coord_struct(input%particle(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 't0', input%t0)
  call json%add(json_root, 't_center', input%t_center)
  call json%add(json_root, 'z_center', input%z_center)
  
end subroutine tao_jsonify_bunch_struct

subroutine tao_jsonify_tao_model_element_struct (input, json_root, depth)
  use tao_struct, only: tao_model_element_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_beam_struct(input%beam, json_val, depth + 1)
  call json%rename(json_val, 'beam')
  call json%add(json_root, json_val)
  call json%add(json_root, 'save_beam_internally', input%save_beam_internally)
  call json%add(json_root, 'save_beam_to_file', input%save_beam_to_file)
  
end subroutine tao_jsonify_tao_model_element_struct

subroutine tao_jsonify_tao_ping_scale_struct (input, json_root, depth)
  use tao_struct, only: tao_ping_scale_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'a_mode_meas', input%a_mode_meas)
  call json%add(json_root, 'a_mode_ref', input%a_mode_ref)
  call json%add(json_root, 'b_mode_meas', input%b_mode_meas)
  call json%add(json_root, 'b_mode_ref', input%b_mode_ref)
  
end subroutine tao_jsonify_tao_ping_scale_struct

subroutine tao_jsonify_tao_plot_cache_struct (input, json_root, depth)
  use tao_struct, only: tao_plot_cache_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_ele_struct(input%ele, json_val, depth + 1)
  call json%rename(json_val, 'ele')
  call json%add(json_root, json_val)
  call json%add(json_root, 'err', input%err)
  call tao_jsonify_coord_struct(input%orbit, json_val, depth + 1)
  call json%rename(json_val, 'orbit')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_tao_plot_cache_struct

subroutine tao_jsonify_tao_real_pointer_struct (input, json_root, depth)
  use tao_struct, only: tao_real_pointer_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%good_user)) then
    call json%add(json_root, 'good_user', input%good_user)
  endif
  if (associated(input%good_value)) then
    call json%add(json_root, 'good_value', input%good_value)
  endif
  if (associated(input%r)) then
    call json%add(json_root, 'r', input%r)
  endif
  
end subroutine tao_jsonify_tao_real_pointer_struct

subroutine tao_jsonify_tao_spin_ele_struct (input, json_root, depth)
  use tao_struct, only: tao_spin_ele_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_tao_spin_dn_dpz_struct(input%dn_dpz, json_val, depth + 1)
  call json%rename(json_val, 'dn_dpz')
  call json%add(json_root, json_val)
  !line=879 definition='real(rp) :: orb_eigen_val(6) = 0' name='orb_eigen_val' python_name='orb_eigen_val' type='real' python_type='float' size=None dimension='6' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'orb_eigen_val')
  do i1 = lbound(input%orb_eigen_val, 1), ubound(input%orb_eigen_val, 1)
    call json%create_real(json_val, input%orb_eigen_val(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=880 definition='real(rp) :: orb_eigen_vec(6,6) = 0' name='orb_eigen_vec' python_name='orb_eigen_vec' type='real' python_type='float' size=None dimension='6,6' comment='(j,:) is j^th vector' fortran_default='0' default=0 default_factory=''
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
  !line=881 definition='real(rp) :: spin_eigen_vec(6,3) = 0' name='spin_eigen_vec' python_name='spin_eigen_vec' type='real' python_type='float' size=None dimension='6,3' comment='(j,:) is j^th vector' fortran_default='0' default=0 default_factory=''
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
  
end subroutine tao_jsonify_tao_spin_ele_struct

subroutine tao_jsonify_tao_spin_dn_dpz_struct (input, json_root, depth)
  use tao_struct, only: tao_spin_dn_dpz_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=873 definition='real(rp) partial(3,3)' name='partial' python_name='partial' type='real' python_type='float' size=None dimension='3,3' comment='partial(i:) is spin n0 derivative wrt pz for i^th oscillation mode (1 => a-mode, etc.)' fortran_default=None default=0.0 default_factory=''
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
  !line=874 definition='real(rp) partial2(3,3)' name='partial2' python_name='partial2' type='real' python_type='float' size=None dimension='3,3' comment='partial(i:) is spin n0 derivative wrt pz with i^th oscillation mode missing (1 => a-mode, etc.)' fortran_default=None default=0.0 default_factory=''
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
  !line=872 definition='real(rp) vec(3)' name='vec' python_name='vec' type='real' python_type='float' size=None dimension='3' comment='n0 derivative wrt pz.' fortran_default=None default=0.0 default_factory=''
  call json%create_array(json_list1, 'vec')
  do i1 = lbound(input%vec, 1), ubound(input%vec, 1)
    call json%create_real(json_val, input%vec(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_tao_spin_dn_dpz_struct

subroutine tao_jsonify_tao_spin_map_struct (input, json_root, depth)
  use tao_struct, only: tao_spin_map_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_spin_axis_struct(input%axis0, json_val, depth + 1)
  call json%rename(json_val, 'axis0')
  call json%add(json_root, json_val)
  call tao_jsonify_spin_axis_struct(input%axis1, json_val, depth + 1)
  call json%rename(json_val, 'axis1')
  call json%add(json_root, json_val)
  call tao_jsonify_spin_axis_struct(input%axis_input, json_val, depth + 1)
  call json%rename(json_val, 'axis_input')
  call json%add(json_root, json_val)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_ref', int(input%ix_ref))
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  call tao_jsonify_spin_orbit_map1_struct(input%map1, json_val, depth + 1)
  call json%rename(json_val, 'map1')
  call json%add(json_root, json_val)
  !line=387 definition='real(rp) :: mat8(8,8) = 0' name='mat8' python_name='mat8' type='real' python_type='float' size=None dimension='8,8' comment='' fortran_default='0' default=0 default_factory=''
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
  call json%add(json_root, 'valid', input%valid)
  
end subroutine tao_jsonify_tao_spin_map_struct

subroutine tao_jsonify_spin_axis_struct (input, json_root, depth)
  use bmad_struct, only: spin_axis_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=274 definition='real(rp) :: l(3) = 0' name='l' python_name='L' type='real' python_type='float' size=None dimension='3' comment='Transverse axis.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'L')
  do i1 = lbound(input%l, 1), ubound(input%l, 1)
    call json%create_real(json_val, input%l(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=276 definition='real(rp) :: m(3) = 0' name='m' python_name='m' type='real' python_type='float' size=None dimension='3' comment='Transverse axis.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'm')
  do i1 = lbound(input%m, 1), ubound(input%m, 1)
    call json%create_real(json_val, input%m(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=275 definition='real(rp) :: n0(3) = 0' name='n0' python_name='n0' type='real' python_type='float' size=None dimension='3' comment='Invariant spin axis on closed orbit.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'n0')
  do i1 = lbound(input%n0, 1), ubound(input%n0, 1)
    call json%create_real(json_val, input%n0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_spin_axis_struct

subroutine tao_jsonify_spin_orbit_map1_struct (input, json_root, depth)
  use bmad_struct, only: spin_orbit_map1_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=305 definition='real(rp) :: orb_mat(6,6) = 0' name='orb_mat' python_name='orb_mat' type='real' python_type='float' size=None dimension='6,6' comment='Orbital matrix' fortran_default='0' default=0 default_factory=''
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
  !line=307 definition='real(rp) :: spin_q(0:3,0:6) = 0' name='spin_q' python_name='spin_q' type='real' python_type='float' size=None dimension='0:3,0:6' comment='0th and 1st order quaternion spin map' fortran_default='0' default=0 default_factory=''
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
  !line=306 definition='real(rp) :: vec0(6) = 0' name='vec0' python_name='vec0' type='real' python_type='float' size=None dimension='6' comment='Orbital 0th order map: r_out = mat6 * r_in + vec0' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'vec0')
  do i1 = lbound(input%vec0, 1), ubound(input%vec0, 1)
    call json%create_real(json_val, input%vec0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_spin_orbit_map1_struct

subroutine tao_jsonify_tao_spin_polarization_struct (input, json_root, depth)
  use tao_struct, only: tao_spin_polarization_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'depol_rate', input%depol_rate)
  !line=893 definition='real(rp) :: depol_rate_partial(3) = real_garbage$' name='depol_rate_partial' python_name='depol_rate_partial' type='real' python_type='float' size=None dimension='3' comment='Depolarization rate (1/sec) using only single mode to calc dn_dpz.' fortran_default='real_garbage$' default=0.0 default_factory=''
  call json%create_array(json_list1, 'depol_rate_partial')
  do i1 = lbound(input%depol_rate_partial, 1), ubound(input%depol_rate_partial, 1)
    call json%create_real(json_val, input%depol_rate_partial(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=894 definition='real(rp) :: depol_rate_partial2(3) = real_garbage$' name='depol_rate_partial2' python_name='depol_rate_partial2' type='real' python_type='float' size=None dimension='3' comment='Depolarization rate (1/sec) using only two modes to calc dn_dpz.' fortran_default='real_garbage$' default=0.0 default_factory=''
  call json%create_array(json_list1, 'depol_rate_partial2')
  do i1 = lbound(input%depol_rate_partial2, 1), ubound(input%depol_rate_partial2, 1)
    call json%create_real(json_val, input%depol_rate_partial2(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'integral_1ns', input%integral_1ns)
  call json%add(json_root, 'integral_bdn', input%integral_bdn)
  call json%add(json_root, 'integral_bn', input%integral_bn)
  call json%add(json_root, 'integral_dn2', input%integral_dn2)
  call json%add(json_root, 'pol_limit_dk', input%pol_limit_dk)
  !line=889 definition='real(rp) :: pol_limit_dk_partial(3) = real_garbage$' name='pol_limit_dk_partial' python_name='pol_limit_dk_partial' type='real' python_type='float' size=None dimension='3' comment='Limit using only single mode to calc dn_dpz' fortran_default='real_garbage$' default=0.0 default_factory=''
  call json%create_array(json_list1, 'pol_limit_dk_partial')
  do i1 = lbound(input%pol_limit_dk_partial, 1), ubound(input%pol_limit_dk_partial, 1)
    call json%create_real(json_val, input%pol_limit_dk_partial(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=890 definition='real(rp) :: pol_limit_dk_partial2(3) = real_garbage$' name='pol_limit_dk_partial2' python_name='pol_limit_dk_partial2' type='real' python_type='float' size=None dimension='3' comment='Limit using only single mode to calc dn_dpz' fortran_default='real_garbage$' default=0.0 default_factory=''
  call json%create_array(json_list1, 'pol_limit_dk_partial2')
  do i1 = lbound(input%pol_limit_dk_partial2, 1), ubound(input%pol_limit_dk_partial2, 1)
    call json%create_real(json_val, input%pol_limit_dk_partial2(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'pol_limit_st', input%pol_limit_st)
  call json%add(json_root, 'pol_rate_bks', input%pol_rate_bks)
  call tao_jsonify_spin_orbit_map1_struct(input%q_1turn, json_val, depth + 1)
  call json%rename(json_val, 'q_1turn')
  call json%add(json_root, json_val)
  if (allocated(input%q_ele)) then
    !line=901 definition='type (spin_orbit_map1_struct), allocatable :: q_ele(:)' name='q_ele' python_name='q_ele' type='spin_orbit_map1_struct' python_type='SpinOrbitMap1Struct' size=None dimension=':' comment='Save results from spin_concat_linear_maps in tao_spin_polarization.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'q_ele')
    do i1 = lbound(input%q_ele, 1), ubound(input%q_ele, 1)
      call tao_jsonify_spin_orbit_map1_struct(input%q_ele(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'tune', input%tune)
  call json%add(json_root, 'valid', input%valid)
  
end subroutine tao_jsonify_tao_spin_polarization_struct

subroutine tao_jsonify_tao_universe_calc_struct (input, json_root, depth)
  use tao_struct, only: tao_universe_calc_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'chrom_for_data', input%chrom_for_data)
  call json%add(json_root, 'chrom_for_plotting', input%chrom_for_plotting)
  call json%add(json_root, 'dynamic_aperture', input%dynamic_aperture)
  call json%add(json_root, 'lat_sigma_for_data', input%lat_sigma_for_data)
  call json%add(json_root, 'lat_sigma_for_plotting', input%lat_sigma_for_plotting)
  call json%add(json_root, 'lattice', input%lattice)
  call json%add(json_root, 'one_turn_map', input%one_turn_map)
  call json%add(json_root, 'rad_int_for_data', input%rad_int_for_data)
  call json%add(json_root, 'rad_int_for_plotting', input%rad_int_for_plotting)
  call json%add(json_root, 'spin_matrices', input%spin_matrices)
  call json%add(json_root, 'srdt_for_data', int(input%srdt_for_data))
  call json%add(json_root, 'track', input%track)
  call json%add(json_root, 'twiss', input%twiss)
  
end subroutine tao_jsonify_tao_universe_calc_struct

subroutine tao_jsonify_tao_v1_var_struct (input, json_root, depth)
  use tao_struct, only: tao_v1_var_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'ix_v1_var', int(input%ix_v1_var))
  call json%add(json_root, 'name', trim(input%name))
  if (associated(input%v)) then
    !line=590 definition='type (tao_var_struct), pointer :: v(:) => null()' name='v' python_name='v' type='tao_var_struct' python_type='TaoVarStruct' size=None dimension=':' comment='Pointer to the appropriate section in s%var.' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'v')
    do i1 = lbound(input%v, 1), ubound(input%v, 1)
      call tao_jsonify_tao_var_struct(input%v(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_tao_v1_var_struct

subroutine tao_jsonify_tao_var_struct (input, json_root, depth)
  use tao_struct, only: tao_var_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'attrib_name', trim(input%attrib_name))
  if (associated(input%base_value)) then
    call json%add(json_root, 'base_value', input%base_value)
  endif
  call json%add(json_root, 'correction_value', input%correction_value)
  call json%add(json_root, 'dmerit_dvar', input%dMerit_dVar)
  call json%add(json_root, 'delta_merit', input%delta_merit)
  call json%add(json_root, 'design_value', input%design_value)
  call json%add(json_root, 'ele_name', trim(input%ele_name))
  call json%add(json_root, 'exists', input%exists)
  call json%add(json_root, 'extend_val', input%extend_val)
  call json%add(json_root, 'good_opt', input%good_opt)
  call json%add(json_root, 'good_plot', input%good_plot)
  call json%add(json_root, 'good_user', input%good_user)
  call json%add(json_root, 'good_var', input%good_var)
  call json%add(json_root, 'high_lim', input%high_lim)
  call json%add(json_root, 'id', trim(input%id))
  call json%add(json_root, 'ix_attrib', int(input%ix_attrib))
  call json%add(json_root, 'ix_dvar', int(input%ix_dvar))
  call json%add(json_root, 'ix_key_table', int(input%ix_key_table))
  call json%add(json_root, 'ix_v1', int(input%ix_v1))
  call json%add(json_root, 'ix_var', int(input%ix_var))
  call json%add(json_root, 'key_bound', input%key_bound)
  call json%add(json_root, 'key_delta', input%key_delta)
  call json%add(json_root, 'key_val0', input%key_val0)
  call json%add(json_root, 'low_lim', input%low_lim)
  call json%add(json_root, 'meas_value', input%meas_value)
  call json%add(json_root, 'merit', input%merit)
  call json%add(json_root, 'merit_type', trim(input%merit_type))
  if (associated(input%model_value)) then
    call json%add(json_root, 'bmad_model_value', input%model_value)
  endif
  call json%add(json_root, 'old_value', input%old_value)
  call json%add(json_root, 'ref_value', input%ref_value)
  call json%add(json_root, 's', input%s)
  call json%add(json_root, 'scratch_value', input%scratch_value)
  if (allocated(input%slave)) then
    !line=547 definition='type (tao_var_slave_struct), allocatable :: slave(:)' name='slave' python_name='slave' type='tao_var_slave_struct' python_type='TaoVarSlaveStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'slave')
    do i1 = lbound(input%slave, 1), ubound(input%slave, 1)
      call tao_jsonify_tao_var_slave_struct(input%slave(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'step', input%step)
  call json%add(json_root, 'useit_opt', input%useit_opt)
  call json%add(json_root, 'useit_plot', input%useit_plot)
  ! parent pointer skip: v1 (tao_v1_var_struct, Pointer to the parent.)
  call json%add(json_root, 'weight', input%weight)
  
end subroutine tao_jsonify_tao_var_struct

subroutine tao_jsonify_tao_var_slave_struct (input, json_root, depth)
  use tao_struct, only: tao_var_slave_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  if (associated(input%base_value)) then
    call json%add(json_root, 'base_value', input%base_value)
  endif
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'ix_uni', int(input%ix_uni))
  if (associated(input%model_value)) then
    call json%add(json_root, 'bmad_model_value', input%model_value)
  endif
  
end subroutine tao_jsonify_tao_var_slave_struct

subroutine tao_jsonify_tao_wave_struct (input, json_root, depth)
  use tao_struct, only: tao_wave_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=1065 definition='real(rp) :: amp_a(2) = 0, amp_b(2) = 0, amp_ba(2) = 0' name='amp_a' python_name='amp_a' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'amp_a')
  do i1 = lbound(input%amp_a, 1), ubound(input%amp_a, 1)
    call json%create_real(json_val, input%amp_a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1065 definition='real(rp) :: amp_a(2) = 0, amp_b(2) = 0, amp_ba(2) = 0' name='amp_b' python_name='amp_b' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'amp_b')
  do i1 = lbound(input%amp_b, 1), ubound(input%amp_b, 1)
    call json%create_real(json_val, input%amp_b(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1065 definition='real(rp) :: amp_a(2) = 0, amp_b(2) = 0, amp_ba(2) = 0' name='amp_ba' python_name='amp_ba' type='real' python_type='float' size=None dimension='2' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'amp_ba')
  do i1 = lbound(input%amp_ba, 1), ubound(input%amp_ba, 1)
    call json%create_real(json_val, input%amp_ba(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'amp_ba_r', input%amp_ba_r)
  call json%add(json_root, 'amp_ba_s', input%amp_ba_s)
  call tao_jsonify_tao_graph_struct(input%base_graph, json_val, depth + 1)
  call json%rename(json_val, 'base_graph')
  call json%add(json_root, json_val)
  call json%add(json_root, 'chi_a', input%chi_a)
  call json%add(json_root, 'chi_ba', input%chi_ba)
  call json%add(json_root, 'chi_c', input%chi_c)
  !line=1066 definition='real(rp) :: coef_a(4) = 0, coef_b(4) = 0, coef_ba(4) = 0' name='coef_a' python_name='coef_a' type='real' python_type='float' size=None dimension='4' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'coef_a')
  do i1 = lbound(input%coef_a, 1), ubound(input%coef_a, 1)
    call json%create_real(json_val, input%coef_a(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1066 definition='real(rp) :: coef_a(4) = 0, coef_b(4) = 0, coef_ba(4) = 0' name='coef_b' python_name='coef_b' type='real' python_type='float' size=None dimension='4' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'coef_b')
  do i1 = lbound(input%coef_b, 1), ubound(input%coef_b, 1)
    call json%create_real(json_val, input%coef_b(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=1066 definition='real(rp) :: coef_a(4) = 0, coef_b(4) = 0, coef_ba(4) = 0' name='coef_ba' python_name='coef_ba' type='real' python_type='float' size=None dimension='4' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'coef_ba')
  do i1 = lbound(input%coef_ba, 1), ubound(input%coef_ba, 1)
    call json%create_real(json_val, input%coef_ba(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  if (associated(input%d1_dat)) then
    call tao_jsonify_tao_d1_data_struct(input%d1_dat, json_val, depth + 1)
    call json%rename(json_val, 'd1_dat')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'data_type', trim(input%data_type))
  call json%add(json_root, 'i_a1', int(input%i_a1))
  call json%add(json_root, 'i_a2', int(input%i_a2))
  call json%add(json_root, 'i_b1', int(input%i_b1))
  call json%add(json_root, 'i_b2', int(input%i_b2))
  call json%add(json_root, 'i_curve_wrap_pt', int(input%i_curve_wrap_pt))
  call json%add(json_root, 'ix_a1', int(input%ix_a1))
  call json%add(json_root, 'ix_a2', int(input%ix_a2))
  call json%add(json_root, 'ix_b1', int(input%ix_b1))
  call json%add(json_root, 'ix_b2', int(input%ix_b2))
  if (allocated(input%ix_data)) then
    !line=1071 definition='integer, allocatable :: ix_data(:)' name='ix_data' python_name='ix_data' type='integer, allocatable' python_type='int' size=None dimension=':' comment='Translates from plot point to datum index' fortran_default=None default=0 default_factory=''
    call json%create_array(json_list1, 'ix_data')
    do i1 = lbound(input%ix_data, 1), ubound(input%ix_data, 1)
      call json%create_integer(json_val, input%ix_data(i1), '')
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%kick)) then
    !line=1073 definition='type (tao_wave_kick_pt_struct), allocatable :: kick(:)' name='kick' python_name='kick' type='tao_wave_kick_pt_struct' python_type='TaoWaveKickPtStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'kick')
    do i1 = lbound(input%kick, 1), ubound(input%kick, 1)
      call tao_jsonify_tao_wave_kick_pt_struct(input%kick(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'n_a', int(input%n_a))
  call json%add(json_root, 'n_b', int(input%n_b))
  call json%add(json_root, 'n_func', int(input%n_func))
  call json%add(json_root, 'n_kick', int(input%n_kick))
  if (associated(input%region)) then
    call tao_jsonify_tao_plot_region_struct(input%region, json_val, depth + 1)
    call json%rename(json_val, 'region')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'rms_phi', input%rms_phi)
  call json%add(json_root, 'rms_phi_r', input%rms_phi_r)
  call json%add(json_root, 'rms_phi_s', input%rms_phi_s)
  call json%add(json_root, 'rms_rel_a', input%rms_rel_a)
  call json%add(json_root, 'rms_rel_ar', input%rms_rel_ar)
  call json%add(json_root, 'rms_rel_as', input%rms_rel_as)
  call json%add(json_root, 'rms_rel_b', input%rms_rel_b)
  call json%add(json_root, 'rms_rel_br', input%rms_rel_br)
  call json%add(json_root, 'rms_rel_bs', input%rms_rel_bs)
  call json%add(json_root, 'rms_rel_k', input%rms_rel_k)
  call json%add(json_root, 'rms_rel_kr', input%rms_rel_kr)
  call json%add(json_root, 'rms_rel_ks', input%rms_rel_ks)
  
end subroutine tao_jsonify_tao_wave_struct

subroutine tao_jsonify_tao_wave_kick_pt_struct (input, json_root, depth)
  use tao_struct, only: tao_wave_kick_pt_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'amp', input%amp)
  if (associated(input%ele)) then
    call tao_jsonify_ele_struct(input%ele, json_val, depth + 1)
    call json%rename(json_val, 'ele')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'ix_dat_before_kick', int(input%ix_dat_before_kick))
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'phi_r', input%phi_r)
  call json%add(json_root, 'phi_s', input%phi_s)
  call json%add(json_root, 's', input%s)
  
end subroutine tao_jsonify_tao_wave_kick_pt_struct

subroutine tao_jsonify_target_point_struct (input, json_root, depth)
  use bmad_struct, only: target_point_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=1040 definition='real(rp) :: r(3) = 0' name='r' python_name='r' type='real' python_type='float' size=None dimension='3' comment='(x, y, z)' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r')
  do i1 = lbound(input%r, 1), ubound(input%r, 1)
    call json%create_real(json_val, input%r(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_target_point_struct

subroutine tao_jsonify_taylor_struct (input, json_root, depth)
  use bmad_struct, only: taylor_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'ref', input%ref)
  if (associated(input%term)) then
    !line=479 definition='type (taylor_term_struct), pointer :: term(:) => null()' name='term' python_name='term' type='taylor_term_struct' python_type='TaylorTermStruct' size=None dimension=':' comment='' fortran_default='null()' default=None default_factory=''
    call json%create_array(json_list1, 'term')
    do i1 = lbound(input%term, 1), ubound(input%term, 1)
      call tao_jsonify_taylor_term_struct(input%term(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_taylor_struct

subroutine tao_jsonify_taylor_term_struct (input, json_root, depth)
  use bmad_struct, only: taylor_term_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'coef', input%coef)
  !line=465 definition='integer :: expn(6) = 0' name='expn' python_name='expn' type='integer' python_type='int' size=None dimension='6' comment='' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'expn')
  do i1 = lbound(input%expn, 1), ubound(input%expn, 1)
    call json%create_integer(json_val, input%expn(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_taylor_term_struct

subroutine tao_jsonify_tricubic_cmplx_coef_struct (input, json_root, depth)
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  !line=127 definition='complex(rp) :: coef(0:3,0:3,0:3) = 0' name='coef' python_name='coef' type='complex' python_type='Complex' size=None dimension='0:3,0:3,0:3' comment='Coefs' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list3, 'dim-3')
  do i3 = lbound(input%coef, 3), ubound(input%coef, 3)
    call json%create_array(json_list2, 'dim-2')
    do i2 = lbound(input%coef, 2), ubound(input%coef, 2)
      call json%create_array(json_list1, 'coef')
      do i1 = lbound(input%coef, 1), ubound(input%coef, 1)
        call tao_jsonify_complex(input%coef(i1, i2, i3), json_val, depth + 1)
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
  
end subroutine tao_jsonify_tricubic_cmplx_coef_struct

subroutine tao_jsonify_twiss_struct (input, json_root, depth)
  use bmad_struct, only: twiss_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'alpha', input%alpha)
  call json%add(json_root, 'beta', input%beta)
  call json%add(json_root, 'deta_ds', input%deta_ds)
  call json%add(json_root, 'emit', input%emit)
  call json%add(json_root, 'eta', input%eta)
  call json%add(json_root, 'etap', input%etap)
  call json%add(json_root, 'gamma', input%gamma)
  call json%add(json_root, 'norm_emit', input%norm_emit)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'sigma', input%sigma)
  call json%add(json_root, 'sigma_p', input%sigma_p)
  
end subroutine tao_jsonify_twiss_struct

subroutine tao_jsonify_wake_struct (input, json_root, depth)
  use bmad_struct, only: wake_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call tao_jsonify_wake_lr_struct(input%lr, json_val, depth + 1)
  call json%rename(json_val, 'lr')
  call json%add(json_root, json_val)
  call tao_jsonify_wake_sr_struct(input%sr, json_val, depth + 1)
  call json%rename(json_val, 'sr')
  call json%add(json_root, json_val)
  
end subroutine tao_jsonify_wake_struct

subroutine tao_jsonify_wake_lr_struct (input, json_root, depth)
  use bmad_struct, only: wake_lr_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'amp_scale', input%amp_scale)
  call json%add(json_root, 'file', trim(input%file))
  call json%add(json_root, 'freq_spread', input%freq_spread)
  if (allocated(input%mode)) then
    !line=649 definition='type (wake_lr_mode_struct), allocatable :: mode(:)' name='mode' python_name='mode' type='wake_lr_mode_struct' python_type='WakeLrModeStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'mode')
    do i1 = lbound(input%mode, 1), ubound(input%mode, 1)
      call tao_jsonify_wake_lr_mode_struct(input%mode(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'self_wake_on', input%self_wake_on)
  call json%add(json_root, 't_ref', input%t_ref)
  call json%add(json_root, 'time_scale', input%time_scale)
  
end subroutine tao_jsonify_wake_lr_struct

subroutine tao_jsonify_wake_lr_mode_struct (input, json_root, depth)
  use bmad_struct, only: wake_lr_mode_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'q', input%Q)
  call json%add(json_root, 'r_over_q', input%R_over_Q)
  call json%add(json_root, 'a_cos', input%a_cos)
  call json%add(json_root, 'a_sin', input%a_sin)
  call json%add(json_root, 'angle', input%angle)
  call json%add(json_root, 'b_cos', input%b_cos)
  call json%add(json_root, 'b_sin', input%b_sin)
  call json%add(json_root, 'damp', input%damp)
  call json%add(json_root, 'freq', input%freq)
  call json%add(json_root, 'freq_in', input%freq_in)
  call json%add(json_root, 'm', int(input%m))
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'polarized', input%polarized)
  
end subroutine tao_jsonify_wake_lr_mode_struct

subroutine tao_jsonify_wake_sr_struct (input, json_root, depth)
  use bmad_struct, only: wake_sr_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'amp_scale', input%amp_scale)
  call json%add(json_root, 'file', trim(input%file))
  if (allocated(input%long)) then
    !line=618 definition='type (wake_sr_mode_struct), allocatable :: long(:)' name='long' python_name='long' type='wake_sr_mode_struct' python_type='WakeSrModeStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'long')
    do i1 = lbound(input%long, 1), ubound(input%long, 1)
      call tao_jsonify_wake_sr_mode_struct(input%long(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'scale_with_length', input%scale_with_length)
  if (allocated(input%trans)) then
    !line=619 definition='type (wake_sr_mode_struct), allocatable :: trans(:)' name='trans' python_name='trans' type='wake_sr_mode_struct' python_type='WakeSrModeStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'trans')
    do i1 = lbound(input%trans, 1), ubound(input%trans, 1)
      call tao_jsonify_wake_sr_mode_struct(input%trans(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%z)) then
    !line=617 definition='type (wake_sr_z_struct), allocatable :: z(:)' name='z' python_name='z' type='wake_sr_z_struct' python_type='WakeSrZStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'z')
    do i1 = lbound(input%z, 1), ubound(input%z, 1)
      call tao_jsonify_wake_sr_z_struct(input%z(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'z_max', input%z_max)
  call json%add(json_root, 'z_ref_long', input%z_ref_long)
  call json%add(json_root, 'z_ref_trans', input%z_ref_trans)
  call json%add(json_root, 'z_scale', input%z_scale)
  
end subroutine tao_jsonify_wake_sr_struct

subroutine tao_jsonify_wake_sr_mode_struct (input, json_root, depth)
  use bmad_struct, only: wake_sr_mode_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'a_cos', input%a_cos)
  call json%add(json_root, 'a_sin', input%a_sin)
  call json%add(json_root, 'amp', input%amp)
  call json%add(json_root, 'b_cos', input%b_cos)
  call json%add(json_root, 'b_sin', input%b_sin)
  call json%add(json_root, 'damp', input%damp)
  call json%add(json_root, 'k', input%k)
  call json%add(json_root, 'phi', input%phi)
  call json%add(json_root, 'polarization', int(input%polarization))
  call json%add(json_root, 'position_dependence', int(input%position_dependence))
  
end subroutine tao_jsonify_wake_sr_mode_struct

subroutine tao_jsonify_wake_sr_z_struct (input, json_root, depth)
  use bmad_struct, only: wake_sr_z_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
  implicit none
  
  type(json_core) :: json
  type (wake_sr_z_struct), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  
  integer i1, i2, i3, i4, i5, i6
  type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5
  
  if (.not. present(depth)) depth = 0
  if (depth > 10) then
    call json%create_string(json_root, 'too deep', '')
    return
  endif
  
  if (.not. associated(input)) then
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'plane', int(input%plane))
  call json%add(json_root, 'position_dependence', int(input%position_dependence))
  if (allocated(input%w)) then
    !line=608 definition='type(spline_struct), allocatable :: w(:)' name='w' python_name='w' type='spline_struct' python_type='SplineStruct' size=None dimension=':' comment='Wake vs time.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'w')
    do i1 = lbound(input%w, 1), ubound(input%w, 1)
      call tao_jsonify_spline_struct(input%w(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%w_sum1)) then
    !line=609 definition='type(spline_struct), allocatable :: w_sum1(:), w_sum2(:)' name='w_sum1' python_name='w_sum1' type='spline_struct' python_type='SplineStruct' size=None dimension=':' comment='Running sums used when tracking.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'w_sum1')
    do i1 = lbound(input%w_sum1, 1), ubound(input%w_sum1, 1)
      call tao_jsonify_spline_struct(input%w_sum1(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  if (allocated(input%w_sum2)) then
    !line=609 definition='type(spline_struct), allocatable :: w_sum1(:), w_sum2(:)' name='w_sum2' python_name='w_sum2' type='spline_struct' python_type='SplineStruct' size=None dimension=':' comment='Running sums used when tracking.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'w_sum2')
    do i1 = lbound(input%w_sum2, 1), ubound(input%w_sum2, 1)
      call tao_jsonify_spline_struct(input%w_sum2(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_wake_sr_z_struct

subroutine tao_jsonify_wall3d_struct (input, json_root, depth)
  use bmad_struct, only: wall3d_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'clear_material', trim(input%clear_material))
  call json%add(json_root, 'ele_anchor_pt', int(input%ele_anchor_pt))
  call json%add(json_root, 'ix_wall3d', int(input%ix_wall3d))
  call json%add(json_root, 'n_link', int(input%n_link))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'opaque_material', trim(input%opaque_material))
  if (allocated(input%section)) then
    !line=458 definition='type (wall3d_section_struct), allocatable :: section(:)' name='section' python_name='section' type='wall3d_section_struct' python_type='Wall3dSectionStruct' size=None dimension=':' comment='Indexed from 1.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'section')
    do i1 = lbound(input%section, 1), ubound(input%section, 1)
      call tao_jsonify_wall3d_section_struct(input%section(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'superimpose', input%superimpose)
  call json%add(json_root, 'thickness', input%thickness)
  call json%add(json_root, 'type', int(input%type))
  
end subroutine tao_jsonify_wall3d_struct

subroutine tao_jsonify_wall3d_section_struct (input, json_root, depth)
  use bmad_struct, only: wall3d_section_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'dr_ds', input%dr_ds)
  call json%add(json_root, 'dx0_ds', input%dx0_ds)
  call json%add(json_root, 'dy0_ds', input%dy0_ds)
  call json%add(json_root, 'ix_branch', int(input%ix_branch))
  call json%add(json_root, 'ix_ele', int(input%ix_ele))
  call json%add(json_root, 'material', trim(input%material))
  call json%add(json_root, 'n_vertex_input', int(input%n_vertex_input))
  call json%add(json_root, 'name', trim(input%name))
  !line=439 definition='real(rp) :: p1_coef(3) = 0' name='p1_coef' python_name='p1_coef' type='real' python_type='float' size=None dimension='3' comment='Spline coefs for p0 function' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'p1_coef')
  do i1 = lbound(input%p1_coef, 1), ubound(input%p1_coef, 1)
    call json%create_real(json_val, input%p1_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=440 definition='real(rp) :: p2_coef(3) = 0' name='p2_coef' python_name='p2_coef' type='real' python_type='float' size=None dimension='3' comment='Spline coefs for p1 function' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'p2_coef')
  do i1 = lbound(input%p2_coef, 1), ubound(input%p2_coef, 1)
    call json%create_real(json_val, input%p2_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 'patch_in_region', input%patch_in_region)
  !line=431 definition='real(rp) :: r0(2) = 0' name='r0' python_name='r0' type='real' python_type='float' size=None dimension='2' comment='Center of section Section-to-section spline interpolation of the center of the section' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'r0')
  do i1 = lbound(input%r0, 1), ubound(input%r0, 1)
    call json%create_real(json_val, input%r0(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  call json%add(json_root, 's', input%s)
  if (associated(input%surface)) then
    call tao_jsonify_photon_reflect_surface_struct(input%surface, json_val, depth + 1)
    call json%rename(json_val, 'surface')
    call json%add(json_root, json_val)
  endif
  call json%add(json_root, 'thickness', input%thickness)
  call json%add(json_root, 'type', int(input%type))
  if (allocated(input%v)) then
    !line=419 definition='type (wall3d_vertex_struct), allocatable :: v(:)' name='v' python_name='v' type='wall3d_vertex_struct' python_type='Wall3dVertexStruct' size=None dimension=':' comment='Array of vertices. Always stored relative.' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'v')
    do i1 = lbound(input%v, 1), ubound(input%v, 1)
      call tao_jsonify_wall3d_vertex_struct(input%v(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  call json%add(json_root, 'vertices_state', int(input%vertices_state))
  !line=435 definition='real(rp) :: x0_coef(0:3) = 0' name='x0_coef' python_name='x0_coef' type='real' python_type='float' size=None dimension='0:3' comment='Spline coefs for x-center' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'x0_coef')
  do i1 = lbound(input%x0_coef, 1), ubound(input%x0_coef, 1)
    call json%create_real(json_val, input%x0_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  !line=436 definition='real(rp) :: y0_coef(0:3) = 0' name='y0_coef' python_name='y0_coef' type='real' python_type='float' size=None dimension='0:3' comment='Spline coefs for y-center Section-to_section spline interpolation of the wall.' fortran_default='0' default=0 default_factory=''
  call json%create_array(json_list1, 'y0_coef')
  do i1 = lbound(input%y0_coef, 1), ubound(input%y0_coef, 1)
    call json%create_real(json_val, input%y0_coef(i1), '')
    call json%add(json_list1, json_val)
  enddo
  call json%add(json_root, json_list1)
  nullify(json_list1)
  
end subroutine tao_jsonify_wall3d_section_struct

subroutine tao_jsonify_photon_reflect_surface_struct (input, json_root, depth)
  use bmad_struct, only: photon_reflect_surface_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'description', trim(input%description))
  call json%add(json_root, 'ix_surface', int(input%ix_surface))
  call json%add(json_root, 'name', trim(input%name))
  call json%add(json_root, 'reflectivity_file', trim(input%reflectivity_file))
  call json%add(json_root, 'roughness_correlation_len', input%roughness_correlation_len)
  call json%add(json_root, 'surface_roughness_rms', input%surface_roughness_rms)
  if (allocated(input%table)) then
    !line=220 definition='type (photon_reflect_table_struct), allocatable :: table(:)' name='table' python_name='table' type='photon_reflect_table_struct' python_type='PhotonReflectTableStruct' size=None dimension=':' comment='' fortran_default=None default=None default_factory=''
    call json%create_array(json_list1, 'table')
    do i1 = lbound(input%table, 1), ubound(input%table, 1)
      call tao_jsonify_photon_reflect_table_struct(input%table(i1), json_val, depth + 1)
      call json%add(json_list1, json_val)
    enddo
    call json%add(json_root, json_list1)
    nullify(json_list1)
  endif
  
end subroutine tao_jsonify_photon_reflect_surface_struct

subroutine tao_jsonify_wall3d_vertex_struct (input, json_root, depth)
  use bmad_struct, only: wall3d_vertex_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'angle', input%angle)
  call json%add(json_root, 'radius_x', input%radius_x)
  call json%add(json_root, 'radius_y', input%radius_y)
  call json%add(json_root, 'tilt', input%tilt)
  call json%add(json_root, 'type', int(input%type))
  call json%add(json_root, 'x', input%x)
  call json%add(json_root, 'x0', input%x0)
  call json%add(json_root, 'y', input%y)
  call json%add(json_root, 'y0', input%y0)
  
end subroutine tao_jsonify_wall3d_vertex_struct

subroutine tao_jsonify_xy_disp_struct (input, json_root, depth)
  use bmad_struct, only: xy_disp_struct
  
  use json_module
  use json_string_utilities, only: integer_to_string
  use json_kinds, only: CK
  
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
    call json%create_null(json_root, name)
    return
  endif
  call json%create_object(json_root, name)
  call json%add(json_root, 'deta_ds', input%deta_ds)
  call json%add(json_root, 'eta', input%eta)
  call json%add(json_root, 'etap', input%etap)
  call json%add(json_root, 'sigma', input%sigma)
  
end subroutine tao_jsonify_xy_disp_struct

