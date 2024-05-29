!+
! Subroutine tao_json_cmd (input_str)
!
! Print information in a form easily parsed by a scripting program like python.
!
! Output will be printed to the terminal or written to a file depending upon the switches embedded
! in the input_str string argument. See the routine "end_stuff" below. For a few commands (for
! example, the "python lat_list" command), the output can be stored on the tao_c_interface_com%c_integer (for 
! integer output) or tao_c_interface_com%c_real (for real output) arrays for faster processing.
!
! Note: The syntax for "parameter list form" is:
!   {component_name};{type};{can_vary};{component_value(s)}
!
! {type} is the type of the parameter and is one of:
!   INT         ! Integer number
!   INT_ARR     ! Integer array.
!   REAL        ! Real number
!   REAL_ARR    ! Real array
!   COMPLEX     ! Complex number (Re;Im)
!   LOGIC       ! Logical: "T" or "F".
!   INUM        ! Integer whose allowed values can be obtained using the "python inum" command.
!   ENUM        ! String whose allowed values can be obtained using the "python enum" command.
!   FILE        ! Name of file.
!   CRYSTAL     ! Crystal name string. EG: "Si(111)"
!   DAT_TYPE    ! Data type string. EG: "orbit.x"
!   DAT_TYPE_Z  ! Data type string if plot%x_axis_type = 'data'. Otherwise is a data_type_z enum.
!   SPECIES     ! Species name string. EG: "H2SO4++"
!   ELE_PARAM   ! Lattice element parameter string. EG "K1"
!   STR         ! String that does not fall into one of the above string categories.
!   STR_ARR     ! String array
!   STRUCT      ! Structure. In this case {component_value} is of the form:
!                   {name1};{type1};{value1};{name2};{type2};{value2};...
!   COMPONENT   ! For curve component parameters.
!
! {can_vay} indicates if the component can be varied. It is one of:
!   T         ! Can vary
!   F         ! Cannot vary
!   I         ! Ignore (Do not display)
!
! If the {component_name} has a "^" symbol in it: The component is an enum or inum. Example: "graph^type"
! In this case, use the entire string when using "python enum" but suppress everything before the "^"
! when displaying the compoent.
!
! Input:
!   input_str  -- Character(*): What to show.
!-

subroutine tao_json_cmd (input_str)

use tao_interface, dummy => tao_json_cmd
use location_encode_mod, only: location_encode
use twiss_and_track_mod, only: twiss_and_track_at_s
use wall3d_mod, only: calc_wall_radius
use tao_command_mod, only: tao_next_switch, tao_cmd_split, tao_next_word
use tao_init_data_mod, only: tao_point_d1_to_data
use tao_init_variables_mod, only: tao_point_v1_to_var, tao_var_stuffit2
use tao_c_interface_mod, only: tao_c_interface_com, re_allocate_c_double
use tao_plot_mod, only: tao_set_floor_plan_axis_label
use tao_data_and_eval_mod, only: tao_evaluate_expression
use tao_dmerit_mod, only: tao_dmodel_dvar_calc
use tao_input_struct, only: tao_ele_shape_input, tao_ele_shape_input_to_struct
use opti_de_mod, only: opti_de_param
use rad_6d_mod, only: emit_6d

use json_module
use json_string_utilities, only: integer_to_string


implicit none

type (tao_universe_struct), pointer :: u
type (tao_d2_data_struct), pointer :: d2_ptr
type (tao_d1_data_struct), pointer :: d1_ptr
type (tao_d2_data_struct), allocatable :: d2_temp(:)
type (tao_d1_data_struct), allocatable :: d1_temp(:)
type (tao_data_struct), pointer :: data, d_ptr
type (tao_data_struct), allocatable :: d_temp(:)
type (tao_data_struct), target :: datum
type (tao_v1_var_array_struct), allocatable, target :: v1_array(:)
type (tao_v1_var_struct), pointer :: v1_ptr
type (tao_var_struct), pointer :: v_ptr, var
type (tao_var_array_struct), allocatable, target :: v_array(:)
type (tao_v1_var_struct), allocatable :: v1_temp(:)
type (tao_var_struct), allocatable :: v_temp(:)
type (tao_plot_array_struct), allocatable :: plots(:)
type (tao_graph_array_struct), allocatable :: graphs(:)
type (tao_curve_array_struct), allocatable :: curves(:)
type (tao_plot_region_struct), pointer :: pr
type (tao_plot_struct), allocatable :: plot_temp(:)
type (tao_plot_struct), pointer :: p
type (tao_graph_struct), pointer :: g
type (tao_graph_struct) :: graph
type (tao_graph_struct), allocatable :: graph_temp(:)
type (tao_curve_struct), allocatable :: curve_temp(:)
type (tao_curve_struct), pointer :: c
type (tao_lattice_struct), pointer :: tao_lat
type (tao_plot_region_struct), pointer :: region
type (tao_d2_data_array_struct), allocatable :: d2_array(:)
type (tao_d1_data_array_struct), allocatable :: d1_array(:)
type (tao_data_array_struct), allocatable :: d_array(:)
type (beam_struct), pointer :: beam
type (beam_init_struct), pointer :: beam_init
type (lat_struct), pointer :: lat
type (bunch_struct), pointer :: bunch
type (ele_struct), pointer :: ele, ele0, ele1, ele2, lord, slave
type (ele_struct), target :: this_ele
type (coord_struct), pointer :: orbit
type (coord_struct), target :: orb, orb_start, orb_end, orb_here
type (bunch_params_struct), pointer :: bunch_params
type (bunch_params_struct), pointer :: bunch_p
type (bunch_track_struct), pointer :: bunch_params_comb(:)
type (bunch_track_struct), pointer :: comb1
type (ele_pointer_struct), allocatable :: eles(:), eles2(:)
type (branch_struct), pointer :: branch
type (tao_model_branch_struct), pointer :: model_branch
type (random_state_struct) ran_state
type (ele_attribute_struct) attrib
type (ac_kicker_struct), pointer :: ac
type (cartesian_map_struct), pointer :: ct_map
type (cartesian_map_term1_struct), pointer :: ctt
type (cylindrical_map_struct), pointer :: cy_map
type (cylindrical_map_term1_struct), pointer :: cyt
type (em_field_struct) :: field
type (taylor_struct) taylor(6)
type (taylor_term_struct), pointer :: tt
type (floor_position_struct) floor, floor1, floor2, end1, end2, f_orb
type (tao_floor_plan_struct), pointer :: fp
type (wake_struct), pointer :: wake
type (wake_sr_mode_struct), pointer :: wsr
type (wake_lr_mode_struct), pointer :: lr_mode
type (wall3d_struct), pointer :: wall3d
type (wall3d_section_struct), pointer :: sec
type (gen_grad_map_struct), pointer :: gg_map
type (gen_grad1_struct), pointer :: gg
type (twiss_struct), pointer :: twiss_arr(:)
type (em_taylor_term_struct), pointer :: em_tt
type (grid_field_struct), pointer :: g_field
type (grid_field_pt1_struct), pointer :: g_pt
type (tao_drawing_struct), pointer :: drawing
type (tao_shape_pattern_struct), pointer :: pattern
type (tao_shape_pattern_struct), allocatable :: pat_temp(:)
type (tao_shape_pattern_point_struct), allocatable :: pat_pt_temp(:)
type (tao_ele_shape_struct), pointer :: shapes(:)
type (tao_ele_shape_struct), allocatable :: shapes_temp(:)
type (tao_ele_shape_struct), pointer :: shape
type (tao_ele_shape_input) shape_input
type (photon_element_struct), pointer :: ph
type (qp_axis_struct) x_ax, y_ax
type (tao_building_wall_section_struct), pointer :: bws
type (tao_building_wall_section_struct), allocatable :: bws_temp(:)
type (tao_building_wall_point_struct), pointer :: bwp(:)
type (tao_building_wall_point_struct), allocatable :: bwp_temp(:)
type (tao_dynamic_aperture_struct), pointer :: da
type (tao_wave_kick_pt_struct), pointer :: wk
type (tao_model_element_struct), pointer :: tao_ele
type (tao_lattice_branch_struct), pointer :: tao_branch
type (all_pointer_struct) a_ptr
type (control_var1_struct), pointer :: cvar

type(json_core) :: json
type(json_value),pointer :: json_root, json_obj, json_arr, json_val

real(rp) z, s_pos, value, values(40), y1, y2, v_old(3), r_vec(3), dr_vec(3), w_old(3,3), v_vec(3), dv_vec(3)
real(rp) length, angle, cos_t, sin_t, cos_a, sin_a, ang, s_here, z1, z2, rdummy, time1, gamma
real(rp) x_bend(0:400), y_bend(0:400), dx_bend(0:400), dy_bend(0:400), dx_orbit(0:400), dy_orbit(0:400)
real(rp) a(0:n_pole_maxx), b(0:n_pole_maxx), a2(0:n_pole_maxx), b2(0:n_pole_maxx)
real(rp) knl(0:n_pole_maxx), tn(0:n_pole_maxx)
real(rp) mat6(6,6), vec0(6), array(7)
real(rp), allocatable :: real_arr(:), value_arr(:)

type (tao_spin_map_struct), pointer :: sm
real(rp) n0(3), l0(3), m0(3), qs, q, xi_sum, xi_diff
complex(rp) eval(6), evec(6,6), n_eigen(6,3)

integer :: i, j, k, ib, id, iv, iv0, ie, ip, is, iu, nn, md, ct, nl2, n, ix, ix2, iu_write, data_type
integer :: ix_ele, ix_ele1, ix_ele2, ix_branch, ix_bunch, ix_d2, n_who, ix_pole_max, attrib_type, loc
integer :: ios, n_loc, ix_line, n_d1, ix_min(20), ix_max(20), n_delta, why_not_free, ix_uni, ix_shape_min
integer line_width, n_bend, ic, num_ele, n_arr, n_add, n1, n2, i0, i1, i2, n_order
integer, allocatable :: index_arr(:), int_arr(:)
integer, target :: nl
integer, pointer :: nl_ptr

logical :: err, print_flag, opened, doprint, free, matched, track_only, use_real_array_buffer, can_vary
logical first_time, found_one, calc_ok, no_slaves, index_order, ok
logical, allocatable :: picked(:), logic_arr(:)

character(*) input_str
character(len(input_str)) line
character(n_char_show), allocatable, target :: li(:)
character(n_char_show), pointer :: li_ptr(:)
character(n_char_show) li2
character(300), allocatable :: name_arr(:)
character(200) file_name, all_who, tail_str
character(40) imt, jmt, rmt, lmt, amt, amt2, iamt, vamt, rmt2, ramt, cmt, label_name
character(40) who, max_loc, ele_name, name1(40), name2(40), a_name, name, attrib_name, command
character(40), allocatable :: str_arr(:)
character(20), allocatable :: name_list(:)
character(20) cmd, which, v_str, head, tail
character(20) switch, color, shape_shape
character(1) :: mode(3) = ['a', 'b', 'c']
character(*), parameter :: r_name = 'tao_json_cmd'

!

line = input_str
doprint = .true.
opened = .false.
tao_c_interface_com%n_real = 0
tao_c_interface_com%n_int = 0

do
  call tao_next_switch (line, [character(8):: '-append ', '-write', '-noprint'], .false., switch, err)
  if (err) return
  if (switch == '') exit

  select case (switch)
  case ('-noprint')
    doprint = .false.

  case ('-append', '-write')
    call tao_next_word(line, file_name)
    iu_write = lunget()

    if (switch == '-append') then
      open (iu_write, file = file_name, position = 'APPEND', status = 'UNKNOWN', recl = 500)
    else
      open (iu_write, file = file_name, status = 'REPLACE', recl = 500)
    endif

    opened = .true.
  end select
enddo

call string_trim(line, line, ix)
cmd = line(1:ix)
call string_trim(line(ix+1:), line, ix_line)

! Needed:
!   EM field
!   HOM
!   x_axis_type (variable parameter)

call match_word (cmd, [character(40) :: &
          'global', &
          'plot_page', &
          'lattice_model', &
          'universe', &
          'plot_curve', 'plot_graph', 'plot_histogram', 'plot_lat_layout', 'plot_line', &
          'plot_template_manage', 'plot_graph_manage', 'plot_curve_manage', &
          'plot_list', 'plot_symbol', 'plot_transfer', 'plot1' &
          ], ix, matched_name = command)

if (ix == 0) then
  call out_io (s_error$, r_name, 'json what? "What" not recognized: ' // command)
  return
endif

if (ix < 0) then
  call out_io (s_error$, r_name, 'json what? Ambiguous command: ' // command)
  return
endif

amt  = '(100a)'
amt2 = '(a, l1, 10a)'
imt  = '(a, 100(i0, a))'
jmt  = '(i0, a, i0)'
rmt  = '(a, 100(es22.14, a))'
ramt = '(a, 100(a, es22.14))'
rmt2 = '(a, l1, a, 100(es22.14, a))'
lmt  = '(a, 100(l1, a))'
vamt = '(a, i0, 3a)'

nl = 0
call re_allocate_lines (li, 200)

li_ptr => li   ! To get around ifort bug
nl_ptr => nl   ! To get around ifort bug

select case (command)

  case ('plot_page')
    call tao_jsonify_tao_plot_page_struct(s%plot_page, json_root)
    call json%print(json_root)
    call json%destroy(json_root)
    nullify(json_root)

  case ('universe')
    call tao_jsonify_tao_super_universe_struct(s, json_root)
    call json%print(json_root)
    call json%destroy(json_root)
    nullify(json_root)

  case ('lattice_model')
    u => point_to_uni(line, .false., err); if (err) return
    call tao_jsonify_tao_lattice_struct(u%model, json_root)
    call json%print(json_root)
    call json%destroy(json_root)
    nullify(json_root)

  case ('global')
    call tao_jsonify_tao_global_struct(s%global, json_root)
    call json%print(json_root)
    call json%destroy(json_root)
    nullify(json_root)

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_curve
!
! Output curve information for a plot.
!
! Notes
! -----
! Command syntax:
!   python plot_curve {curve_name}
! 
! Parameters
! ----------
! curve_name
!
! Returns
! -------
! string_list
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    curve_name: r13.g.a

case ('plot_curve')

  call tao_find_plots (err, line, 'BOTH', curve = curves, only_visible = .false.)

  if (err .or. size(curves) /= 1) then
    call invalid ('Not a valid curve')
    return
  endif

  c => curves(1)%c
  ix_uni = c%ix_universe

  nl=incr(nl); write (li(nl), amt) 'name;STR;T;',                             trim(c%name)
  nl=incr(nl); write (li(nl), amt) 'data_source;ENUM;T;',                     trim(c%data_source)
  nl=incr(nl); write (li(nl), amt) 'data_type_x;DAT_TYPE_Z;T;',               trim(c%data_type_x)
  nl=incr(nl); write (li(nl), amt) 'data_type;DAT_TYPE;T;',                   trim(c%data_type)
  nl=incr(nl); write (li(nl), amt) 'component;COMPONENT;T;',                  trim(c%component)
  nl=incr(nl); write (li(nl), amt) 'ele_ref_name;STR;T;',                     trim(c%ele_ref_name)
  nl=incr(nl); write (li(nl), amt) 'legend_text;STR;T;',                      trim(c%legend_text)
  nl=incr(nl); write (li(nl), amt) 'message_text;STR;F;',                     trim(c%message_text)
  nl=incr(nl); write (li(nl), amt) 'why_invalid;STR;I;',                      trim(c%why_invalid)
  nl=incr(nl); write (li(nl), rmt) 'y_axis_scale_factor;REAL;T;',             c%y_axis_scale_factor
  nl=incr(nl); write (li(nl), imt) 'ix_universe;INUM;T;',                     c%ix_universe
  nl=incr(nl); write (li(nl), imt) 'symbol_every;INT;T;',                     c%symbol_every
  nl=incr(nl); write (li(nl), jmt) ix_uni, '^ix_branch;INUM;T;',              c%ix_branch
  nl=incr(nl); write (li(nl), imt) 'ix_ele_ref;INT;I;',                       c%ix_ele_ref
  nl=incr(nl); write (li(nl), imt) 'ix_ele_ref_track;INT;I;',                 c%ix_ele_ref_track
  nl=incr(nl); write (li(nl), jmt) ix_uni, '^ix_bunch;INUM;T;',               c%ix_bunch
  nl=incr(nl); write (li(nl), lmt) 'use_y2;LOGIC;T;',                         c%use_y2
  nl=incr(nl); write (li(nl), lmt) 'draw_line;LOGIC;T;',                      c%draw_line
  nl=incr(nl); write (li(nl), lmt) 'draw_symbols;LOGIC;T;',                   c%draw_symbols
  nl=incr(nl); write (li(nl), lmt) 'draw_symbol_index;LOGIC;T;',              c%draw_symbol_index
  nl=incr(nl); write (li(nl), lmt) 'draw_error_bars;LOGIC;T;',                c%draw_error_bars
  nl=incr(nl); write (li(nl), lmt) 'smooth_line_calc;LOGIC;T;',               c%smooth_line_calc
  nl=incr(nl); write (li(nl), lmt) 'z_color.is_on;LOGIC;I;',                  c%z_color%is_on
  nl=incr(nl); write (li(nl), rmt) 'z_color.min;REAL;T;',                     c%z_color%min
  nl=incr(nl); write (li(nl), rmt) 'z_color.max;REAL;T;',                     c%z_color%max
  nl=incr(nl); write (li(nl), lmt) 'z_color.autoscale;LOGIC;I;',              c%z_color%autoscale
  nl=incr(nl); write (li(nl), amt) 'z_color.data_type;ENUM;T;',               trim(c%z_color%data_type)
  nl=incr(nl); write (li(nl), lmt) 'valid;LOGIC;I;',                          c%valid
  nl=incr(nl); write (li(nl), '(a, i0, 4a)') 'line;STRUCT;T;width;INT;', c%line%width, &
                      ';color;ENUM;', trim(c%line%color), ';line^pattern;ENUM;', c%line%pattern

  nl=incr(nl); write (li(nl), '(9a, i0)')  'symbol;STRUCT;T;symbol^type;ENUM;', trim(c%symbol%type), &
                      ';color;ENUM;', trim(c%symbol%color), ';height;REAL;', to_str(c%symbol%height, 4), &
                      ';fill_pattern;ENUM;', trim(c%symbol%fill_pattern), ';line_width;INT;', c%symbol%line_width

  nl=incr(nl); write (li(nl), imt)  'symbol.line_width;INT;T;',               c%symbol%line_width

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_lat_layout
!
! Output plot Lat_layout info
!
! Notes
! -----
! Command syntax:
!   python plot_lat_layout {ix_uni}@{ix_branch}
!
! Note: The returned list of element positions is not ordered in increasing
!       longitudinal position.
! 
! Parameters
! ----------
! ix_uni: 1
! ix_branch: 0
!
! Returns
! -------
! string_list
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/cesr/tao.init
!  args:
!    ix_uni: 1
!    ix_branch: 0 

case ('plot_lat_layout')

  u => point_to_uni(line, .true., err); if (err) return
  ix_branch = parse_branch(line, u, .false., err); if (err) return
  branch => u%model%lat%branch(ix_branch)

  call out_io (s_error$, r_name, 'loop')
  call json%create_object(json_root, '')

  do i = 1, branch%n_ele_track
    ele => branch%ele(i)
    if (ele%slave_status == super_slave$) cycle

    ix_shape_min = 1
    do
      call tao_ele_shape_info (u%ix_uni, ele, s%plot_page%lat_layout%ele_shape, shape, label_name, y1, y2, ix_shape_min)
      y1 = y1 * s%plot_page%lat_layout_shape_scale
      y2 = y2 * s%plot_page%lat_layout_shape_scale
      if (.not. associated(shape)) exit
      if (.not. shape%draw) cycle
      call integer_to_string(i, "(ss,I0)", imt)
      call json%create_object(json_val, imt)
      call json%add(json_val, 's_start', ele%s_start)
      call json%add(json_val, 's', ele%s)
      call json%add(json_val, 'line_width', shape%line_width)
      call json%add(json_val, 'shape', trim(shape%shape))
      call json%add(json_val, 'y1', y1)
      call json%add(json_val, 'y2', y2)
      call json%add(json_val, 'color', trim(shape%color))
      call json%add(json_val, 'label_name', trim(label_name))
      call json%add(json_root, json_val)

    enddo
  enddo

  call json%print(json_root)
  call json%destroy(json_root)
!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_list
!
! Output list of plot templates or plot regions.
!
! Notes
! -----
! Command syntax:
!   python plot_list {r_or_g}
!
! where "{r/g}" is:
!   "r"      ! list regions of the form ix;region_name;plot_name;visible;x1;x2;y1;y2
!   "t"      ! list template plots of the form ix;name
! 
! Parameters
! ----------
! r_or_g
!
! Returns
! -------
! string_list
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/cesr/tao.init
!  args:
!    r_or_g: r


case ('plot_list')
  if (line == 't') then
    do i = 1, size(s%plot_page%template)
      p => s%plot_page%template(i)
      if (p%phantom) cycle
      if (p%name == '') cycle
      if (p%name == 'scratch') cycle
      nl=incr(nl); write (li(nl), '(i0, 2a)') i, ';', trim(p%name)
    enddo

  elseif (line == 'r') then
    do i = 1, size(s%plot_page%region)
      pr => s%plot_page%region(i)
      if (pr%name == '') cycle
      ! nl=incr(nl); write (li(nl), '(i0, 5a, l1, 8a)') i, ';', trim(pr%name), ';', trim(pr%plot%name), ';', pr%visible, ';', &
      !                 re_str(pr%location(1), 4), ';', re_str(pr%location(2), 4), ';', re_str(pr%location(3), 4), ';', re_str(pr%location(4), 4)
    enddo

  else
    call invalid ('Expect "r" or "t"')
  endif

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_graph
!
! Output graph info.
!
! Notes
! -----
! Command syntax:
!   python plot_graph {graph_name}
!
! {graph_name} is in the form:
!   {p_name}.{g_name}
! where
!   {p_name} is the plot region name if from a region or the plot name if a template plot.
!   This name is obtained from the python plot_list command.
!   {g_name} is the graph name obtained from the python plot1 command.
! 
! Parameters
! ----------
! graph_name
!
! Returns
! -------
! string_list
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    graph_name: beta.g

case ('plot_graph')

  call tao_find_plots (err, line, 'BOTH', graph = graphs, only_visible = .false.)

  if (err .or. size(graphs) /= 1) then
    call invalid ('Bad graph name')
    return
  endif

  g => graphs(1)%g

  if (g%type == 'floor_plan') then
    call tao_set_floor_plan_axis_label (g, g%x, x_ax, 'X')
    call tao_set_floor_plan_axis_label (g, g%y, y_ax, 'Y')
  else
    x_ax = g%x
    y_ax = g%y
  endif

  n = 0
  if (allocated(g%curve)) n = size(g%curve)

  nl=incr(nl); write (li(nl), imt) 'num_curves;INT;T;',                       n
  do i = 1, n
    nl=incr(nl); write (li(nl), vamt) 'curve[', i, '];STR;T;',                g%curve(i)%name
  enddo

  nl=incr(nl); write (li(nl), amt) 'name;STR;T;',                               trim(g%name)
  nl=incr(nl); write (li(nl), amt) 'graph^type;ENUM;T;',                        trim(g%type)
  nl=incr(nl); write (li(nl), amt) 'title;STR;T;',                              trim(g%title)
  nl=incr(nl); write (li(nl), amt) 'title_suffix;STR;F;',                       trim(g%title_suffix)
  nl=incr(nl); write (li(nl), amt) 'why_invalid;STR;F;',                        trim(g%why_invalid)
  nl=incr(nl); write (li(nl), rmt) 'x_axis_scale_factor;REAL;T;',               g%x_axis_scale_factor
  nl=incr(nl); write (li(nl), rmt) 'symbol_size_scale;REAL;T;',                 g%symbol_size_scale
  nl=incr(nl); write (li(nl), jmt) g%ix_universe, '^ix_branch;INUM;T;',         g%ix_branch
  nl=incr(nl); write (li(nl), imt) 'ix_universe;INUM;T;',                       g%ix_universe
  nl=incr(nl); write (li(nl), lmt) 'clip;LOGIC;T;',                             g%clip
  nl=incr(nl); write (li(nl), lmt) 'is_valid;LOGIC;F;',                         g%is_valid
  nl=incr(nl); write (li(nl), lmt) 'y2_mirrors_y;LOGIC;T;',                     g%y2_mirrors_y
  nl=incr(nl); write (li(nl), lmt) 'limited;LOGIC;F;',                          g%limited
  nl=incr(nl); write (li(nl), lmt) 'draw_axes;LOGIC;T;',                        g%draw_axes
  nl=incr(nl); write (li(nl), lmt) 'draw_curve_legend;LOGIC;T;',                g%draw_curve_legend
  nl=incr(nl); write (li(nl), lmt) 'draw_grid;LOGIC;T;',                        g%draw_grid
  nl=incr(nl); write (li(nl), lmt) 'draw_only_good_user_data_or_vars;LOGIC;T;', g%draw_only_good_user_data_or_vars

  fp => g%floor_plan
  nl=incr(nl); write (li(nl), '(50a)') 'floor_plan;STRUCT;T', ';view;ENUM;', fp%view, &
      ';rotation;REAL;', to_str(fp%rotation, 6), ';flip_label_side;LOGIC;', logic_str(fp%flip_label_side), &
      ';size_is_absolute;LOGIC;', logic_str(fp%size_is_absolute), ';draw_building_wall;LOGIC;', logic_str(fp%draw_building_wall), &
      ';draw_only_first_pass;LOGIC;', logic_str(fp%draw_only_first_pass), ';correct_distortion;LOGIC;', logic_str(fp%correct_distortion), &
      ';orbit_scale;REAL;', to_str(fp%orbit_scale, 4), ';orbit_color;ENUM;', trim(fp%orbit_color), &
      ';orbit_lattice;ENUM;', trim(fp%orbit_lattice), &
      ';orbit_width;INT;', int_str(fp%orbit_width), ';orbit_pattern;ENUM;', trim(fp%orbit_pattern)
  

  if (s%global%external_plotting) then
    nl=incr(nl); write (li(nl), '(6a, 2(a, l1))') 'x;STRUCT;T;label;STR;', trim(x_ax%label), &
                            ';max;REAL;', to_str(x_ax%max,6), ';min;REAL;', to_str(x_ax%min,6), &
                            ';draw_label;LOGIC;', x_ax%draw_label, ';draw_numbers;LOGIC;', x_ax%draw_numbers
    nl=incr(nl); write (li(nl), '(6a, 2(a, l1))') 'y;STRUCT;T;label;STR;', trim(y_ax%label), &
                            ';max;REAL;', to_str(y_ax%max,6), ';min;REAL;', to_str(y_ax%min,6), &
                            ';draw_label;LOGIC;', y_ax%draw_label, ';draw_numbers;LOGIC;', y_ax%draw_numbers
    nl=incr(nl); write (li(nl), '(6a, 2(a, l1))') 'y2;STRUCT;T;label;STR;', trim(g%y2%label), &
                            ';max;REAL;', to_str(g%y2%max,6), ';min;REAL;', to_str(g%y2%min,6), &
                            ';draw_label;LOGIC;', g%y2%draw_label, ';draw_numbers;LOGIC;', g%y2%draw_numbers
  else
    nl=incr(nl); write (li(nl), '(16a, 3(a, i0), 2(a, l1), 2(a, i0), 4a)') 'x;STRUCT;T;label;STR;', trim(x_ax%label), &
                    ';label_color;ENUM;', trim(x_ax%label_color), ';label_offset;REAL;', to_str(x_ax%label_offset,6), &
                    ';max;REAL;', to_str(x_ax%max,6), ';min;REAL;', to_str(x_ax%min,6), &
                    ';axis^type;ENUM;', trim(x_ax%type), ';bounds;ENUM;', trim(x_ax%bounds), &
                    ';number_offset;REAL;', to_str(x_ax%number_offset,6), ';major_div_nominal;INT;', x_ax%major_div_nominal, &
                    ';minor_div;INT;', x_ax%minor_div, ';minor_div_max;INT;', x_ax%minor_div_max, &
                    ';draw_label;LOGIC;', x_ax%draw_label, ';draw_numbers;LOGIC;', x_ax%draw_numbers, &
                    ';tick_side;INUM;', x_ax%tick_side, ';number_side;INUM;', x_ax%number_side, &
                    ';major_tick_len;REAL;', to_str(x_ax%major_tick_len,6), ';minor_tick_len;REAL;', to_str(x_ax%minor_tick_len,6)

    nl=incr(nl); write (li(nl), '(16a, 3(a, i0), 2(a, l1), 2(a, i0), 4a)') 'y;STRUCT;T;label;STR;', trim(y_ax%label), &
                    ';label_color;ENUM;', trim(y_ax%label_color), ';label_offset;REAL;', to_str(y_ax%label_offset,6), &
                    ';max;REAL;', to_str(y_ax%max,6), ';min;REAL;', to_str(y_ax%min,6), &
                    ';axis^type;ENUM;', trim(y_ax%type), ';bounds;ENUM;', trim(y_ax%bounds), &
                    ';number_offset;REAL;', to_str(y_ax%number_offset,6), ';major_div_nominal;INT;', y_ax%major_div_nominal, &
                    ';minor_div;INT;', y_ax%minor_div, ';minor_div_max;INT;', y_ax%minor_div_max, &
                    ';draw_label;LOGIC;', y_ax%draw_label, ';draw_numbers;LOGIC;', y_ax%draw_numbers, &
                    ';tick_side;INUM;', y_ax%tick_side, ';number_side;INUM;', y_ax%number_side, &
                    ';major_tick_len;REAL;', to_str(y_ax%major_tick_len,6), ';minor_tick_len;REAL;', to_str(y_ax%minor_tick_len,6)

    nl=incr(nl); write (li(nl), '(16a, 3(a, i0), 2(a, l1), 2(a, i0), 4a)') 'y2;STRUCT;T;label;STR;', trim(g%y2%label), &
                    ';label_color;ENUM;', trim(g%y2%label_color), ';label_offset;REAL;', to_str(g%y2%label_offset,6), &
                    ';max;REAL;', to_str(g%y2%max,6), ';min;REAL;', to_str(g%y2%min,6), &
                    ';axis^type;ENUM;', trim(g%y2%type), ';bounds;ENUM;', trim(g%y2%bounds), &
                    ';number_offset;REAL;', to_str(g%y2%number_offset,6), ';major_div_nominal;INT;', g%y2%major_div_nominal, &
                    ';minor_div;INT;', g%y2%minor_div, ';minor_div_max;INT;', g%y2%minor_div_max, &
                    ';draw_label;LOGIC;', g%y2%draw_label, ';draw_numbers;LOGIC;', g%y2%draw_numbers, &
                    ';tick_side;INUM;', g%y2%tick_side, ';number_side;INUM;', g%y2%number_side, &
                    ';major_tick_len;REAL;', to_str(g%y2%major_tick_len,6), ';minor_tick_len;REAL;', to_str(g%y2%minor_tick_len,6)

  endif

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_histogram
!
! Output plot histogram info.
!
! Notes
! -----
! Command syntax:
!   python plot_histogram {curve_name}
! 
! Parameters
! ----------
! curve_name
!
! Returns
! -------
! string_list
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    curve_name: r33.g.x

case ('plot_histogram')

  call tao_find_plots (err, line, 'BOTH', curve = curves, only_visible = .false.)

  if (err .or. size(curves) /= 1) then
    call invalid ('Bad curve name')
    return
  endif

  c => curves(1)%c

  nl=incr(nl); write (li(nl), lmt) 'density_normalized;LOGIC;T;',          c%hist%density_normalized
  nl=incr(nl); write (li(nl), lmt) 'weight_by_charge;LOGIC;T;',            c%hist%weight_by_charge
  nl=incr(nl); write (li(nl), rmt) 'minimum;REAL;T;',                      c%hist%minimum
  nl=incr(nl); write (li(nl), rmt) 'maximum;REAL;T;',                      c%hist%maximum
  nl=incr(nl); write (li(nl), rmt) 'width;REAL;T;',                        c%hist%width
  nl=incr(nl); write (li(nl), rmt) 'center;REAL;T;',                       c%hist%center
  nl=incr(nl); write (li(nl), imt) 'number;REAL;T;',                       c%hist%number

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_template_manage
!
! Template plot creation or destruction.
!
! Notes
! -----
! Command syntax:
!   python plot_template_manage {template_location}^^{template_name}^^
!                          {n_graph}^^{graph_names}
!
! Where:
!   {template_location} is the location to place or delete a template plot. Use "@Tnnn" syntax for the location.
!   {template_name} is the name of the template plot. If deleting a plot this name is immaterial.
!   {n_graph} is the number of associated graphs. If set to -1 then any existing template plot is deleted.
!   {graph_names} are the names of the graphs.  graph_names should be in the form:
!      graph1_name^^graph2_name^^...^^graphN_name
!   for N=n_graph names
!
! Parameters
! ----------
! template_location
! template_name
! n_graph : default=-1
! graph_names : default=
!
! Returns
! -------
! None
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    template_location: @T1
!    template_name: beta
!    n_graph: 2
!    graph_names: g1^^g2


case ('plot_template_manage')

  call split_this_line (line, name1, -1, err);         if (err) return

  call tao_find_plots (err, name1(1), 'TEMPLATE', plots, only_visible = .false.)
  if (size(plots) == 0) then
    call invalid('No plot template location found for: ' // name1(1))
    return
  endif
  p => plots(1)%p

  if (.not. is_integer(name1(3))) then
    call invalid ('Number of graphs string not an integer: ' // name1(3))
    return
  endif

  read(name1(3), *) n

  !

  if (n == -1) then
    ix = p%ix_plot
    n1 = size(s%plot_page%template)
    s%plot_page%template(ix:n1-1) = s%plot_page%template(ix+1:n1)
    do i = ix, n1
      s%plot_page%template(i)%ix_plot = i
    enddo
    return
  endif

  !

  if (allocated(p%graph)) deallocate(p%graph)
  allocate(p%graph(n))

  p%name = name1(2)

  do i = 1, n
    p%graph(i)%name = name1(i+3)
    p%graph(i)%p => p
  enddo

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_curve_manage
!
! Template plot curve creation/destruction
!
! Notes
! -----
! Command syntax:
!   python plot_curve_manage {graph_name}^^{curve_index}^^{curve_name}
!
! If {curve_index} corresponds to an existing curve then this curve is deleted.
! In this case the {curve_name} is ignored and does not have to be present.
! If {curve_index} does not not correspond to an existing curve, {curve_index}
! must be one greater than the number of curves.
! 
! Parameters
! ----------
! graph_name
! curve_index
! curve_name
!
! Returns
! -------
! None
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    graph_name: beta.g
!    curve_index: 1
!    curve_name: r13.g.a

case ('plot_curve_manage')

  call split_this_line (line, name1, -1, err);         if (err) return
  call tao_find_plots (err, name1(1), 'TEMPLATE', graph = graphs, only_visible = .false.)
  if (size(graphs) /= 1) then
    if (size(graphs) == 0) call invalid('No graph found for: ' // name1(1))
    if (size(graphs) > 1)  call invalid('Multiple graphs found for: ' // name1(1))
    return
  endif

  g => graphs(1)%g

  if (allocated(g%curve)) then
    n1 = size(g%curve)
    call move_alloc(g%curve, curve_temp)
  else
    n1 = 0
  endif

  if (.not. is_integer(name1(2))) then
    call invalid ('Curve index not an integer: ' // name1(2))
    return
  endif
  read(name1(2), *) n
  if (n > n1 + 1) then
    call invalid ('Curve index out of range: ' // name1(2))
    return
  endif

  if (n == n1 + 1) then
    allocate (g%curve(n))
    if (n1 /= 0) g%curve(1:n1) = curve_temp
    g%curve(n)%name = name1(3)
    g%curve(n)%g => g

  else  ! Remove curve
    allocate (g%curve(n1-1))
    g%curve(1:n-1) = curve_temp(1:n-1)
    g%curve(n:n1-1) = curve_temp(n+1:n1)
  endif

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_graph_manage
!
! Template plot graph creation/destruction
!
! Notes
! -----
! Command syntax:
!   python plot_graph_manage {plot_name}^^{graph_index}^^{graph_name}
!
! If {graph_index} corresponds to an existing graph then this graph is deleted.
! In this case the {graph_name} is ignored and does not have to be present.
! If {graph_index} does not not correspond to an existing graph, {graph_index}
! must be one greater than the number of graphs.
! 
! Parameters
! ----------
! plot_name
! graph_index
! graph_name
!
! Returns
! -------
! None
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    plot_name: beta
!    graph_index: 1
!    graph_name: beta.g

case ('plot_graph_manage')

  call split_this_line (line, name1, -1, err);         if (err) return
  call tao_find_plots (err, name1(1), 'TEMPLATE', plots, only_visible = .false.)
  if (size(plots) /= 1) then
    if (size(plots) == 0) call invalid('No plot found for: ' // name1(1))
    if (size(plots) > 1)  call invalid('Multiple plots found for: ' // name1(1))
    return
  endif

  p => plots(1)%p

  if (allocated(p%graph)) then
    n1 = size(p%graph)
    call move_alloc(p%graph, graph_temp)
  else
    n1 = 0
  endif

  if (.not. is_integer(name1(2))) then
    call invalid ('Graph index not an integer: ' // name1(2))
    return
  endif
  read(name1(2), *) n
  if (n > n1 + 1) then
    call invalid ('Graph index out of range: ' // name1(2))
    return
  endif

  if (n == n1 + 1) then
    allocate (p%graph(n))
    if (n1 /= 0) p%graph(1:n1) = graph_temp
    p%graph(n)%name = name1(3)
    p%graph(n)%p => p

  else  ! Remove graph
    allocate (p%graph(n1-1))
    p%graph(1:n-1) = graph_temp(1:n-1)
    p%graph(n:n1-1) = graph_temp(n+1:n1)
  endif

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_line
!
! Output points used to construct the "line" associated with a plot curve.
!
! Notes
! -----
! Command syntax:
!   python plot_line {region_name}.{graph_name}.{curve_name} {x_or_y}
!
! Optional {x-or-y} may be set to "x" or "y" to get the smooth line points x or y 
! component put into the real array buffer.
! Note: The plot must come from a region, and not a template, since no template plots 
!       have associated line data.
! Examples:
!   python plot_line r13.g.a   ! String array output.
!   python plot_line r13.g.a x ! x-component of line points loaded into the real array buffer.
!   python plot_line r13.g.a y ! y-component of line points loaded into the real array buffer.
! 
! Parameters
! ----------
! region_name
! graph_name
! curve_name
! x_or_y : optional
!
! Returns
! -------
! string_list
!   if x_or_y == ''
! real_array
!   if x_or_y != ''
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_plot_line -external_plotting
!  args:
!    region_name: beta
!    graph_name: g
!    curve_name: a
!    x_or_y:
!
! Example: 2
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_plot_line -external_plotting
!  args:
!    region_name: beta
!    graph_name: g
!    curve_name: a
!    x_or_y: y

case ('plot_line')

  call string_trim(line(ix_line+1:), tail_str, ix2)
  line = line(1:ix_line)
  call tao_find_plots (err, line, 'REGION', curve = curves, only_visible = .false.)

  if (size(curves) /= 1) then
    call invalid ('Not a valid curve name')
    return
  endif

  c => curves(1)%c
  if (.not. allocated(c%x_line)) then
    call invalid ('No line associated with curve')
    return
  endif

if (.not. c%valid) then
  call invalid ('Invalid since: ' // c%why_invalid)
  return
endif

  n = size(c%x_line)

  select case (tail_str)
  case ('x', 'y')
    if (.not. allocated(tao_c_interface_com%c_real)) allocate (tao_c_interface_com%c_real(n))
    if (size(tao_c_interface_com%c_real) < n) then
      deallocate (tao_c_interface_com%c_real)
      allocate (tao_c_interface_com%c_real(n))
    endif

    tao_c_interface_com%n_real = n

    if (tail_str == 'x') then
      tao_c_interface_com%c_real(1:n) = c%x_line
    else
      tao_c_interface_com%c_real(1:n) = c%y_line
    endif

  case ('')
    do i = 1, n
      nl=incr(nl); write (li(nl), '(i0, 2(a, es22.14))') i, ';', c%x_line(i), ';', c%y_line(i)
    enddo

  case default
    call invalid ('word after curve name not "x" nor "y"')
  end select


!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_symbol
!
! Output locations to draw symbols for a plot curve.
!
! Notes
! -----
! Command syntax:
!   python plot_symbol {region_name}.{graph_name}.{curve_name} {x_or_y}
!
! Optional {x_or_y} may be set to "x" or "y" to get the symbol x or y 
! positions put into the real array buffer.
! Note: The plot must come from a region, and not a template, 
!       since no template plots have associated symbol data.
! Examples:
!   python plot_symbol r13.g.a       ! String array output.
!   python plot_symbol r13.g.a x     ! x-component of the symbol positions 
!                                      loaded into the real array buffer.
!   python plot_symbol r13.g.a y     ! y-component of the symbol positions 
!                                      loaded into the real array buffer.
! 
! Parameters
! ----------
! region_name
! graph_name
! curve_name
! x_or_y
!
! Returns
! -------
! string_list
!   if x_or_y == ''
! real_array
!   if x_or_y != ''
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_plot_line -external_plotting
!  args:
!    region_name: r13
!    graph_name: g
!    curve_name: a
!    x_or_y: 
!
! Example: 2
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_plot_line -external_plotting
!  args:
!    region_name: r13
!    graph_name: g
!    curve_name: a
!    x_or_y: y

case ('plot_symbol')

  call string_trim(line(ix_line+1:), tail_str, ix2)
  line = line(1:ix_line)
  call tao_find_plots (err, line, 'REGION', curve = curves, only_visible = .false.)

  if (size(curves) /= 1) then
    call invalid ('Not a valid curve name.')
    return
  endif

  c => curves(1)%c
  if (.not. allocated(c%x_symb)) then
    call invalid ('No symbol array associated with curve.')
    return
  endif

  n = size(c%x_symb)

  select case (tail_str)
  case ('x', 'y')
    if (.not. allocated(tao_c_interface_com%c_real)) allocate (tao_c_interface_com%c_real(n))
    if (size(tao_c_interface_com%c_real) < n) then
      deallocate (tao_c_interface_com%c_real)
      allocate (tao_c_interface_com%c_real(n))
    endif

    tao_c_interface_com%n_real = n

    if (tail_str == 'x') then
      tao_c_interface_com%c_real(1:n) = c%x_symb
    else
      tao_c_interface_com%c_real(1:n) = c%y_symb
    endif

  case ('')
    do i = 1, size(c%x_symb)
      if (allocated(c%ix_symb)) then
        nl=incr(nl); write (li(nl), '(2(i0, a), 2(es22.14, a))') i, ';', c%ix_symb(i), ';', c%x_symb(i), ';', c%y_symb(i)
      else
        nl=incr(nl); write (li(nl), '(2(i0, a), 2(es22.14, a))') i, ';', 0, ';', c%x_symb(i), ';', c%y_symb(i)
      endif
    enddo

  case default
    call invalid ('word after curve name not "x" nor "y"')
  end select

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot_transfer
!
! Output transfer plot parameters from the "from plot" to the "to plot" (or plots).
!
! Notes
! -----
! Command syntax:
!   python plot_transfer {from_plot} {to_plot}
!
! To avoid confusion, use "@Tnnn" and "@Rnnn" syntax for {from_plot}.
! If {to_plot} is not present and {from_plot} is a template plot, the "to plots" 
!  are the equivalent region plots with the same name. And vice versa 
!  if {from_plot} is a region plot.
! 
! Parameters
! ----------
! from_plot
! to_plot
!
! Returns
! -------
! None
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    from_plot: r13
!    to_plot: r23 

case ('plot_transfer')

  call tao_find_plots (err, line(1:ix_line), 'BOTH', plots, only_visible = .false.)
  if (size(plots) /= 1) then
    call invalid ('Number of "from plots" found is not exactly one.')
    return
  endif

  p => plots(1)%p

  call string_trim(line(ix_line+1:), line, ix_line)
  if (line == '') then
    if (associated(p%r)) then
      do i = 1, size(s%plot_page%template)
        if (s%plot_page%template(i)%name /= p%name) cycle
        call tao_plot_struct_transfer (p, s%plot_page%template(i))
      enddo

    else
      do i = 1, size(s%plot_page%region)
        if (s%plot_page%region(i)%plot%name /= p%name) cycle
        call tao_plot_struct_transfer (p, s%plot_page%region(i)%plot)
      enddo
    endif

  else
    call tao_find_plots (err, line(1:ix_line), 'BOTH', plots, only_visible = .false.)
    if (size(plots) == 0) then
      call invalid ('Number of "to plots" is zero.')
      return
    endif

    do i = 1, size(plots)
      call tao_plot_struct_transfer (p, plots(i)%p)
    enddo
  endif

!------------------------------------------------------------------------------------------------
!------------------------------------------------------------------------------------------------
!%% plot1
!
! Output info on a given plot.
!
! Notes
! -----
! Command syntax:
!   python plot1 {name}
!
! {name} should be the region name if the plot is associated with a region.
! Output syntax is parameter list form. See documentation at the beginning of this file.
! 
! Parameters
! ----------
! name
!
! Returns
! -------
! string_list
!
! Examples
! --------
! Example: 1
!  init: -init $ACC_ROOT_DIR/regression_tests/python_test/tao.init_optics_matching
!  args:
!    name: beta

case ('plot1')

  call tao_find_plots (err, line, 'BOTH', plots, print_flag = .false., only_visible = .false.)
  if (err) then
    call invalid ('Expect "r" or "t" at end.')
    return
  endif

  p => plots(1)%p

  n = 0
  if (allocated(p%graph)) n = size(p%graph)

  nl=incr(nl); write (li(nl), imt) 'num_graphs;INT;T;',                       n
  do i = 1, n
    nl=incr(nl); write (li(nl), vamt) 'graph[', i, '];STR;T;',              p%graph(i)%name
  enddo

  nl=incr(nl); write (li(nl), amt) 'name;STR;T;',                             trim(p%name)
  nl=incr(nl); write (li(nl), amt) 'description;STR;T;',                      trim(p%description)
  nl=incr(nl); write (li(nl), amt) 'x_axis_type;ENUM;T;',                     trim(p%x_axis_type)
  nl=incr(nl); write (li(nl), lmt) 'autoscale_x;LOGIC;T;',                    p%autoscale_x
  nl=incr(nl); write (li(nl), lmt) 'autoscale_y;LOGIC;T;',                    p%autoscale_y
  nl=incr(nl); write (li(nl), lmt) 'autoscale_gang_x;LOGIC;T;',               p%autoscale_gang_x
  nl=incr(nl); write (li(nl), lmt) 'autoscale_gang_y;LOGIC;T;',               p%autoscale_gang_y
  nl=incr(nl); write (li(nl), imt) 'n_curve_pts;INT;T;',                      p%n_curve_pts


!----------------------------------------------------------------------

case default

  call out_io (s_error$, r_name, "json command internal error, shouldn't be here!")

end select

call end_stuff(li, nl)

!----------------------------------------------------------------------
! return through scratch

contains

subroutine end_stuff(li, nl)


character(n_char_show), allocatable :: li(:)
integer nl, i

!

if (doprint) then
  call out_io (s_blank$, r_name, li(1:nl))
endif

if (opened) then
  do i = 1, nl
    write (iu_write, '(a)') trim(li(i))
  enddo
  close (iu_write)
endif

end subroutine

!----------------------------------------------------------------------
! contains

function point_to_uni (line, compound_word, err) result (u)

type (tao_universe_struct), pointer :: u
integer ix, ix_universe, ios
logical compound_word, err
character(*) line

! A compound_word is something like "2@q10w" or "q10w". A non-compound word is something like "2" which
! just represents a universe index.

nullify(u)
err = .false.

if (compound_word) then
  ix = tao_uni_ampersand_index(line)
  if (ix == 0) then
    ix_universe = s%global%default_universe
  elseif (line(1:ix-1) == '') then
    ix_universe = s%global%default_universe
    line = line(ix+1:)
  else
    read (line(1:ix-1), *,  iostat = ios)  ix_universe
    if (ios /= 0) ix_universe = -999
    line = line(ix+1:)
  endif
else
  if (len_trim(line) == 0) then
    ix_universe = s%global%default_universe
  else
    ! In this case line is just a universe number
    read (line, *,  iostat = ios)  ix_universe
    if (ios /= 0) ix_universe = -999
  endif
endif

u => tao_pointer_to_universe(ix_universe, .true.)

if (.not. associated(u)) then
  call invalid ('bad universe index')
  err = .true.
endif

end function point_to_uni

!----------------------------------------------------------------------
! contains

function incr(n) result (n1)

integer n, n1

n1 = n + 1
if (n1 > size(li)) call re_allocate_lines (li, int(1.5 * n1))

end function

!----------------------------------------------------------------------
! contains

subroutine re_allocate_lines (li, n_lines)

character(n_char_show), allocatable :: li(:)
integer n_lines

!

if (.not. allocated(li)) allocate (li(n_lines))
if (size(li) < n_lines) call re_allocate (li, n_lines)

end subroutine re_allocate_lines

!----------------------------------------------------------------------
! contains

function point_to_tao_lat (line, u, err, which, tail_str) result (tao_lat)

type (tao_lattice_struct), pointer :: tao_lat
type (tao_universe_struct) u
integer ix
logical err
character(*) line
character(*), optional :: which, tail_str


err = .true.
nullify(tao_lat)

call string_trim(line, line, ix)
if (present(tail_str)) call string_trim(line(ix+1:), tail_str, i)
line = line(1:ix)

ix = index(line, '|')
if (ix == 0) then
  tao_lat => u%model
  err = .false.
  return
endif

select case (line(ix+1:))
case ('model')
  tao_lat => u%model
case ('base')
  tao_lat => u%base
case ('design')
  tao_lat => u%design
case ('')
  tao_lat => u%model
case default
  call invalid ('Expecting "|{which}" where {which} must be one of "model", "base", or "design"')
  return
end select

if (present(which)) then
  which = line(ix+1:)
  if (which == '') which = 'model'
endif

line = line(1:ix-1)
err = .false.

end function point_to_tao_lat

!----------------------------------------------------------------------
! contains

function point_to_ele (line, lat, err) result (ele)

type (lat_struct) lat
type (ele_struct), pointer :: ele
type (ele_pointer_struct), allocatable :: eles(:)
integer n_loc
character(*) line
logical err

!

err = .true.
nullify(ele)
call lat_ele_locator (line, lat, eles, n_loc)

select case (n_loc)
case (0) 
  call invalid ('Cannot locate element.')
  return
case (1)
  ! Good
case default
  call invalid ('Multiple matches to element.')
  return
end select

ele => eles(1)%ele
err = .false.

end function point_to_ele

!----------------------------------------------------------------------
! contains

function parse_branch (line, u, has_separator, err) result (ix_branch)

type (tao_universe_struct) u
integer ix, ios, ix_branch
logical has_separator, err
character(*) line
character(40) str

!

err = .false.
ix_branch = s%global%default_branch
if (line(1:1) == ' ') return

if (has_separator) then
  ix = index(line, '>>')

  if (ix == 0) then
    call invalid ('Missing ">>"')
    err = .true.
    return
  endif

  if (ix /= 1) then
    read (line(1:ix-1), *, iostat = ios) ix_branch
    if (ios /= 0) ix_branch = -999
  endif
  line = line(ix+2:)

elseif (len_trim(line) /= 0) then
  read (line, *, iostat = ios) ix_branch
  if (ios /= 0) ix_branch = -999
endif

if (ix_branch < 0 .or. ix_branch > ubound(u%design%lat%branch, 1)) then
  call invalid ('Out of range branch index')
  err = .true.
  return
endif

end function parse_branch

!----------------------------------------------------------------------
! contains

! function parse_real (line, err) result (a_real)
! 
! real(rp) a_real
! logical err
! character(*) line
! 
! a_real = string_to_real (line, real_garbage$, err)
! if (err .or. a_real == real_garbage$) then
!   call invalid ('Bad real number')
!   return
! endif
! 
! end function parse_real

!----------------------------------------------------------------------
! contains

function parse_int (line, err_flag, min_bound, max_bound, dflt_val) result (a_int)

integer a_int
integer, optional :: min_bound, max_bound, dflt_val
logical err, err_flag
character(*) line

!

err_flag = .true.


a_int = string_to_int (line, integer_option(int_garbage$, dflt_val), err)

if (err .or. a_int == int_garbage$) then
  call invalid ('Bad int number')
  return
endif

if (present(min_bound)) then
  if (a_int < min_bound) then
    call invalid ('Integer below lower bound')
    return
  endif
endif

if (present(max_bound)) then
  if (a_int > max_bound) then
    call invalid ('Integer above upper bound')
    return
  endif
endif

err_flag = .false.

end function parse_int

!----------------------------------------------------------------------
! contains

subroutine orbit_out (orbit)

type (coord_struct) orbit

nl=incr(nl); write (li(nl), rmt) 'x;REAL;F;',                                orbit%vec(1)
nl=incr(nl); write (li(nl), rmt) 'px;REAL;F;',                               orbit%vec(2)
nl=incr(nl); write (li(nl), rmt) 'y;REAL;F;',                                orbit%vec(3)
nl=incr(nl); write (li(nl), rmt) 'py;REAL;F;',                               orbit%vec(4)
nl=incr(nl); write (li(nl), rmt) 'z;REAL;F;',                                orbit%vec(5)
nl=incr(nl); write (li(nl), rmt) 'pz;REAL;F;',                               orbit%vec(6)

nl=incr(nl); write (li(nl), ramt) 'spin;REAL_ARR;F',                         (';', orbit%spin(i), i = 1, 3)
nl=incr(nl); write (li(nl), ramt) 'field;REAL_ARR;F',                        (';', orbit%field(i), i = 1, 2)
nl=incr(nl); write (li(nl), ramt) 'phase;REAL_ARR;F',                        (';', orbit%phase(i), i = 1, 2)

nl=incr(nl); write (li(nl), rmt) 's;REAL;F;',                                orbit%s
nl=incr(nl); write (li(nl), rmt) 't;REAL;F;',                                orbit%t
nl=incr(nl); write (li(nl), rmt) 'charge;REAL;F;',                           orbit%charge
nl=incr(nl); write (li(nl), rmt) 'dt_ref;REAL;F;',                           orbit%dt_ref
nl=incr(nl); write (li(nl), rmt) 'p0c;REAL;F;',                              orbit%p0c
nl=incr(nl); write (li(nl), rmt) 'beta;REAL;F;',                             orbit%beta
nl=incr(nl); write (li(nl), imt) 'ix_ele;INT;F;',                            orbit%ix_ele
nl=incr(nl); write (li(nl), amt) 'state;STR;F;',                             trim(coord_state_name(orbit%state))
nl=incr(nl); write (li(nl), imt) 'direction;INT;F;',                         orbit%direction
nl=incr(nl); write (li(nl), amt) 'species;SPECIES;F;',                       trim(species_name(orbit%species))
nl=incr(nl); write (li(nl), amt) 'location;STR;F;',                          trim(location_name(orbit%location))

end subroutine orbit_out

!----------------------------------------------------------------------
! contains

subroutine coord_out(bunch, coordinate)
type (bunch_struct) :: bunch
character(20) coordinate
integer :: i_vec, n

! Allocate scratch
n = size(bunch%particle)
call reallocate_c_real_scratch(n)

! Add data
select case (coordinate)
case ('x')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%vec(1)
case ('px')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%vec(2)
case ('y')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%vec(3)
case ('py')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%vec(4)
case ('z')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%vec(5)
case ('pz')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%vec(6)
case ('s')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%s
case ('t')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%t
case ('charge')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%charge
case ('p0c')
  tao_c_interface_com%c_real(1:n) = bunch%particle(:)%p0c
case ('state')
  call reallocate_c_integer_scratch(n)
  tao_c_interface_com%c_integer(1:n) = bunch%particle(:)%state
case ('ix_ele')
  call reallocate_c_integer_scratch(n)
  tao_c_interface_com%c_integer(1:n) = bunch%particle(:)%ix_ele
case default
  call invalid ('coordinate not "x", "px", etc. ')
  return
end select

end subroutine coord_out

!----------------------------------------------------------------------
! contains

subroutine reallocate_c_real_scratch(n)
integer :: n
if (.not. allocated(tao_c_interface_com%c_real)) allocate (tao_c_interface_com%c_real(n))
if (size(tao_c_interface_com%c_real) < n) then
  deallocate (tao_c_interface_com%c_real)
  allocate (tao_c_interface_com%c_real(n))
endif
tao_c_interface_com%n_real = n
end subroutine

subroutine reallocate_c_integer_scratch(n)
integer :: n
if (.not. allocated(tao_c_interface_com%c_integer)) allocate (tao_c_interface_com%c_integer(n))
if (size(tao_c_interface_com%c_integer) < n) then
  deallocate (tao_c_interface_com%c_integer)
  allocate (tao_c_interface_com%c_integer(n))
endif
tao_c_interface_com%n_int = n
end subroutine

!----------------------------------------------------------------------
! contains

subroutine twiss_out (twiss, prefix, suffix, emit_out, can_vary)

type (twiss_struct) twiss
character(*) prefix, suffix
character(20) fmt
character(8) v_str
logical, optional :: emit_out, can_vary

if (logic_option(.false., can_vary)) then
  v_str = ';REAL;T;'
else
  v_str = ';REAL;F;'
endif

fmt = '(4a, es22.14)'

nl=incr(nl); write (li(nl), fmt) prefix, 'beta_', suffix, v_str,                twiss%beta
nl=incr(nl); write (li(nl), fmt) prefix,  'alpha_', suffix, v_str,              twiss%alpha
nl=incr(nl); write (li(nl), fmt) prefix,  'gamma_', suffix, ';REAL;F;',         twiss%gamma
nl=incr(nl); write (li(nl), fmt) prefix,  'phi_', suffix, v_str,                twiss%phi
nl=incr(nl); write (li(nl), fmt) prefix,  'eta_', suffix, v_str,                twiss%eta
nl=incr(nl); write (li(nl), fmt) prefix,  'etap_', suffix, v_str,               twiss%etap

if (logic_option(.false., emit_out)) then
  nl=incr(nl); write (li(nl), fmt) prefix, 'sigma_', suffix, ';REAL;F;',       twiss%sigma
  nl=incr(nl); write (li(nl), fmt) prefix, 'sigma_p_', suffix, ';REAL;F;',     twiss%sigma_p
  nl=incr(nl); write (li(nl), fmt) prefix, 'emit_', suffix, ';REAL;F;',        twiss%emit
  nl=incr(nl); write (li(nl), fmt) prefix, 'norm_emit_', suffix, ';REAL;F;',   twiss%norm_emit
endif

end subroutine twiss_out

!----------------------------------------------------------------------
! contains

subroutine xy_disp_out (xy_disp, suffix, can_vary)
! Similar to twiss_out
type (xy_disp_struct) xy_disp
character(*) suffix
character(20) fmt
character(8) v_str
logical, optional ::  can_vary

if (logic_option(.false., can_vary)) then
  v_str = ';REAL;T;'
else
  v_str = ';REAL;F;'
endif

fmt = '(3a, es22.14)'

nl=incr(nl); write (li(nl), fmt) 'eta_', suffix, v_str,                           xy_disp%eta
nl=incr(nl); write (li(nl), fmt) 'etap_', suffix, v_str,                          xy_disp%etap

end subroutine xy_disp_out

!----------------------------------------------------------------------
! contains

subroutine destroy_this_data_d2 (d2_name)

type (tao_d2_data_struct), pointer :: d2_ptr
type (tao_d1_data_struct), pointer :: d1_ptr
type (tao_d2_data_array_struct), allocatable :: d2_array(:)
type (tao_d1_data_array_struct), allocatable :: d1_array(:)
type (tao_universe_struct), pointer :: u

integer i, j, ix_d2, i1, i2, n1, n_delta
logical err

character(*) d2_name

!

call tao_find_data (err, d2_name, d2_array = d2_array)
if (err .or. .not. allocated(d2_array)) then
  call invalid ('Not a valid d2 data name')
  return
endif

d2_ptr => d2_array(1)%d2
u => s%u(d2_ptr%ix_universe)
ix_d2 = d2_ptr%ix_d2_data

d1_ptr => d2_ptr%d1(1)
i1 = lbound(d1_ptr%d, 1)
i1 = d1_ptr%d(i1)%ix_data

n1 = size(d2_ptr%d1)
d1_ptr => d2_ptr%d1(n1)
i2 = ubound(d1_ptr%d, 1)
i2 = d1_ptr%d(i2)%ix_data

n_delta = i2 + 1 - i1

! Squeeze u%d2_data and u%data arrays

do i = ix_d2, u%n_d2_data_used - 1
  u%d2_data(i) = u%d2_data(i+1)
  u%d2_data(i)%ix_d2_data = i
  do j = 1, size(u%d2_data(i)%d1)
    d1_ptr => u%d2_data(i)%d1(j)
    d1_ptr%d2 => u%d2_data(i)
    i1 = d1_ptr%d(lbound(d1_ptr%d,1))%ix_data - n_delta
    i2 = d1_ptr%d(ubound(d1_ptr%d,1))%ix_data - n_delta
    u%data(i1:i2) = u%data(i1+n_delta:i2+n_delta)
    call tao_point_d1_to_data(d1_ptr, u%data(i1:i2), u%data(i1)%ix_d1)
    do k = i1, i2
      u%data(k)%ix_data = k
    enddo
  enddo
enddo

u%n_d2_data_used = u%n_d2_data_used - 1
u%n_data_used = u%n_data_used - n_delta

end subroutine destroy_this_data_d2

!----------------------------------------------------------------------
! contains

subroutine destroy_this_var_v1(v1_name)

type (tao_v1_var_array_struct), allocatable, target :: v1_array(:)
type (tao_v1_var_struct), pointer :: v1_ptr

integer j, k, i1, i2, n_delta, n

character(*) v1_name

logical err

!

call tao_find_var (err, v1_name, v1_array = v1_array)
if (err .or. .not. allocated(v1_array)) then
  call invalid ('Not a valid v1 var name')
  return
endif

v1_ptr => v1_array(1)%v1
i1 = lbound(v1_ptr%v, 1)
i1 = v1_ptr%v(i1)%ix_var
i2 = ubound(v1_ptr%v, 1)
i2 = v1_ptr%v(i2)%ix_var

n_delta = i2 + 1 - i1

n = s%n_var_used

do j = v1_ptr%ix_v1_var, s%n_v1_var_used - 1
  s%v1_var(j) = s%v1_var(j+1)
  v1_ptr => s%v1_var(j)
  v1_ptr%ix_v1_var = j
  i1 = v1_ptr%v(lbound(v1_ptr%v,1))%ix_var
  i2 = v1_ptr%v(ubound(v1_ptr%v,1))%ix_var
  s%var(i1-n_delta:i2-n_delta) = s%var(i1:i2)
  call tao_point_v1_to_var(s%v1_var(j), s%var(i1-n_delta:i2-n_delta), s%var(i1-n_delta)%ix_v1)
  do k = i1-n_delta, i2-n_delta
    s%var(k)%ix_var = k
  enddo
enddo

s%n_v1_var_used = s%n_v1_var_used - 1
s%n_var_used = s%n_var_used - n_delta

end subroutine destroy_this_var_v1

!----------------------------------------------------------------------
! contains

function match_ele_name (match_str, ele, err) result (is_a_match)

type (ele_struct) ele

integer ix, key

character(*) match_str
character(60) string

logical err, is_a_match

!

is_a_match = .false.
err = .false.

if (match_str == '*') then
  is_a_match = .true.
  return
endif

! key::name construct

string = match_str
ix = index(string, '::')
if (ix /= 0) then
  if (string(:ix-1) /= "*") then
    key = key_name_to_key_index (string(:ix-1), .true.)
    if (key < 1) then
      call invalid ('BAD ELEMENT KEY: ' // string(:ix-1))
      err = .true.
      return
    endif

    if (ele%key /= key) then
      is_a_match = .false.
      return
    endif
  endif

  string = string(ix+2:)
endif

!

if (index(string, "*") /= 0 .or. index(string, "%") /= 0) then
  is_a_match = match_wild(ele%name, string)
else
  is_a_match = (ele%name == string)
endif

end function match_ele_name

!----------------------------------------------------------------------
! contains

subroutine invalid (why_invalid, err)

character(*) why_invalid
logical, optional :: err

nl=incr(nl); li(nl) = 'INVALID'
call out_io (s_error$, r_name, '"json ' // trim(input_str) // '": ' // why_invalid)
call end_stuff(li, nl)
if (present(err)) err = .true.

end subroutine invalid

!----------------------------------------------------------------------
! contains

! function re_str(r, n_signif) result (str)
! 
! real(rp) r
! integer n_signif
! character(:), allocatable :: str
! character(20) string
! 
! string = real_to_string(r, 20, n_signif = n_signif)
! allocate (character(len_trim(adjustl(string))):: str)
! str = trim(adjustl(string))
! 
! end function re_str

!----------------------------------------------------------------------
! contains

function real_part_str(z) result (str)

complex(rp) z
character(23) str

write (str, '(a, es22.14)') ';', real(z)

end function real_part_str

!----------------------------------------------------------------------
! contains

function cmplx_str(z) result (str)

complex(rp) z
character(46) str

write (str, '(2(a, es22.14))') ';', real(z), ';', aimag(z)

end function cmplx_str

!----------------------------------------------------------------------
! contains

subroutine split_this_line (line, array, target_num, err, actual_num, space_sep)

character(*) line
character(len(line)) str
character(*) :: array(:)

integer target_num
integer, optional :: actual_num
integer i, ix
logical err, space
logical, optional :: space_sep

! For input, "^^" is used as the separator instead of ";" since the Tao code that
! calls json_cmd will interpret ";" as a command separator and will thus mangle
! the input_str argument.

str = line
err = .true.
array = ''
space = logic_option(.false., space_sep)

do i = 1, 1000
  if (i > size(array)) then
    call invalid('LINE SPLITTING ARRAY OVERFLOW.')
    return
  endif

  if (space) then
    call string_trim(str, str, ix)
    if (ix == 0) exit
    array(i) = str(1:ix)
    str = str(ix+1:)
  else
    ix = index(str, '^^')
    if (ix == 0) then
      array(i) = str
      exit
    endif
    array(i) = str(1:ix-1)
    str = str(ix+2:)
  endif
enddo

if (space) i = i - 1
if (present(actual_num)) actual_num = i

err = (target_num > 0 .and. i /= target_num)
if (err) then
  call invalid('NUMBER OF COMPONENTS ON LINE NOT CORRECT.')
endif

end subroutine split_this_line

!----------------------------------------------------------------------
! contains

function str_val (str_in, str_dflt) result (str_out)

character(*) str_in, str_dflt
character(max(len(str_in), len(str_dflt))) str_out

if (str_in == '') then
  str_out = str_dflt
else
  str_out = str_in
endif

end function str_val

!----------------------------------------------------------------------
! contains

function logic_val (str_in, logic_dflt, err) result (logic_out)

character(*) str_in
logical logic_dflt, err, logic_out
integer ios

err = .false.

if (str_in == '') then
  logic_out = logic_dflt
  return
endif

read (str_in, *, iostat = ios) logic_out
err = (ios /= 0)
if (err) then
  call invalid ('Not a logical: ' // str_in)
endif

end function logic_val

!----------------------------------------------------------------------
! contains

function real_val (str_in, real_dflt, err) result (real_out)

character(*) str_in
real(rp) real_dflt, real_out
integer ios
logical err

err = .false.

if (str_in == '') then
  real_out = real_dflt
  return
endif

read (str_in, *, iostat = ios) real_out
err = (ios /= 0)
if (err) then
  call invalid ('Not a real: ' // str_in)
endif

end function real_val

!----------------------------------------------------------------------
! contains

function int_val (str_in, int_dflt, err) result (int_out)

character(*) str_in
integer int_dflt, int_out
integer ios
logical err

err = .false.

if (str_in == '') then
  int_out = int_dflt
  return
endif

read (str_in, *, iostat = ios) int_out
err = (ios /= 0)
if (err) then
  call invalid ('Not an integer: ' // str_in)
endif

end function int_val

!----------------------------------------------------------------------
! contains

function ele_param_value(name, ele, orbit, data_type, err) result (value)

type (ele_struct) ele
type (coord_struct) orbit
real(rp) value
integer data_type, ix
logical err
character(*) name
character(40) attrib_name

!

err = .true.
data_type = is_real$

select case (name)
case ('orbit.floor.x', 'orbit.floor.y', 'orbit.floor.z')
  floor%r = [orbit%vec(1), orbit%vec(3), ele%value(l$)]
  floor1 = coords_local_curvilinear_to_floor (floor, ele, .false.)
  select case (name)
  case ('orbit.floor.x')
    value = floor1%r(1)
  case ('orbit.floor.y')
    value = floor1%r(2)
  case ('orbit.floor.z')
    value = floor1%r(3)
  end select
case ('orbit.spin.1')
  value = orbit%spin(1)
case ('orbit.spin.2')
  value = orbit%spin(2)
case ('orbit.spin.3')
  value = orbit%spin(3)
case ('orbit.vec.1')
  value = orbit%vec(1)
case ('orbit.vec.2')
  value = orbit%vec(2)
case ('orbit.vec.3')
  value = orbit%vec(3)
case ('orbit.vec.4')
  value = orbit%vec(4)
case ('orbit.vec.5')
  value = orbit%vec(5)
case ('orbit.vec.6')
  value = orbit%vec(6)
case ('orbit.t')
  value = orbit%t
case ('orbit.beta')
  value = orbit%beta
case ('orbit.state')
  value = orbit%state
  data_type = is_integer$
case ('orbit.pc')  
  value = (1 + orbit%vec(6)) * orbit%p0c
case ('orbit.energy', 'orbit.e_tot')  ! orbit.e_tot is old style
  call convert_pc_to ((1 + orbit%vec(6)) * orbit%p0c, orbit%species, E_tot = value)
case ('ele.ix_ele')
  value = ele%ix_ele
  data_type = is_integer$        
case ('ele.ix_branch')
  value = ele%ix_branch
case ('ele.a.beta')
  value = ele%a%beta
case ('ele.a.alpha')
  value = ele%a%alpha
case ('ele.a.eta')
  value = ele%a%eta
case ('ele.a.etap')
  value = ele%a%etap
case ('ele.a.gamma')
  value = ele%a%gamma
case ('ele.a.phi')
  value = ele%a%phi
case ('ele.b.beta')
  value = ele%b%beta
case ('ele.b.alpha')
  value = ele%b%alpha
case ('ele.b.eta')
  value = ele%b%eta
case ('ele.b.etap')
  value = ele%b%etap
case ('ele.b.gamma')
  value = ele%b%gamma
case ('ele.b.phi')
  value = ele%b%phi
case ('ele.e_tot')
  value = ele%value(e_tot$)
case ('ele.p0c')
  value = ele%value(p0c$)
case ('ele.ref_time')
  value = ele%ref_time
case ('ele.ref_time_start')
  value = ele%value(ref_time_start$)
case ('ele.x.eta')
  value = ele%x%eta
case ('ele.x.etap')
  value = ele%x%etap
case ('ele.y.eta')
  value = ele%y%eta
case ('ele.y.etap')
  value = ele%y%etap
case ('ele.s')
  value = ele%s
case ('ele.l')
  value = ele%value(l$)
case ('ele.gamma_c')
  value = ele%gamma_c
case default
  call str_upcase (attrib_name, name)
  ix = index(attrib_name, '.')

  if (attrib_name(1:ix-1) == 'ELE') then
    attrib_name = attrib_name(ix+1:)
    call pointer_to_attribute (ele, attrib_name, .true., a_ptr, err, .false.)
  else
    err = .true.
  endif

  if (err) then
    call invalid ('Bad {who}: ' // name); return
  endif

  if (associated(a_ptr%r)) then
    value = a_ptr%r
  elseif (associated(a_ptr%i)) then
    data_type = is_integer$
    value = a_ptr%i
  else
    call invalid ('{who} does not evaluate to an integer or real: ' // name); return
    err = .true.
    return
  endif
end select

err = .false.

end function ele_param_value

!----------------------------------------------------------------------
! contains

!+
! Function parse_ele_with_s_offset(line, tao_lat, ele, err) result (s_pos)
!
! Parse something like:  "{ix_branch}>>{ele}@{s_offset}".
!
! Input:
!   line      -- character(*): String to parse
!   tao_lat   -- tao_lattice_struct: Tao structure containing lattice
!
! Output:
!   line      -- character(*): String with parsed stuff removed.
!   ele       -- ele_struct, pointer: Pointer to element.
!   err       -- logical: Set True if there is an error.
!   s_pos     -- real(rp): S-position -> ele%s + offset.
!-

function parse_ele_with_s_offset(line, tao_lat, ele, err) result (s_pos)

type (tao_lattice_struct) tao_lat
type (ele_struct), pointer :: ele
type (ele_pointer_struct), allocatable :: eles(:)
type (tao_expression_info_struct), allocatable :: info(:)

real(rp) s_pos, s_offset
real(rp), allocatable :: values(:)

integer ix, ixa, ix_branch, n_loc

character(*) line
character(40) ele_name
logical err

!

err = .false.
s_pos = 0

call string_trim (line, line, ix)
if (ix == 0) then
  ele => tao_lat%lat%ele(0)
  return
endif

ixa = index(line, '->')
if (ixa == 0) then
  ele_name = line(:ix)

else
  ele_name = line(:ixa-1)
  if (ix > ixa+1) then
    call tao_evaluate_expression (line(ixa+2:ix), 1, .false., values, err, .true., info, dflt_uni = tao_lat%u%ix_uni)
    if (err) return
    s_pos = values(1)
  endif
endif

call string_trim(line(ix+1:), line, ix)


if (ele_name == '') then
  ele => tao_lat%lat%ele(0)
else
  call lat_ele_locator (ele_name, tao_lat%lat, eles, n_loc, err)

  if (err) return
  if (n_loc == 0) then
    call invalid('No element found matching: ' // ele_name, err)
    return
  elseif (n_loc > 1) then
    call invalid('Multiple elements found matching: ' // ele_name, err)
    return
  endif

  ele => eles(1)%ele
endif

s_pos = s_pos + ele%s

end function parse_ele_with_s_offset

!----------------------------------------------------------------------
! contains

subroutine bunch_params_out (bunch_params)

type (bunch_params_struct) bunch_params

!

call twiss_out(bunch_params%x, 'twiss_', 'x', emit_out = .true.)
call twiss_out(bunch_params%y, 'twiss_', 'y', emit_out = .true.)
call twiss_out(bunch_params%z, 'twiss_', 'z', emit_out = .true.)
call twiss_out(bunch_params%a, 'twiss_', 'a', emit_out = .true.)
call twiss_out(bunch_params%b, 'twiss_', 'b', emit_out = .true.)
call twiss_out(bunch_params%c, 'twiss_', 'c', emit_out = .true.)

! Sigma matrix
do i = 1, 6
  do j = 1,6
    nl=incr(nl); write (li(nl), '(a, i0, i0, a, es22.14)') 'sigma_', i, j, ';REAL;F;', bunch_params%sigma(i,j)
  enddo
enddo

! Relative min, max, centroid
do i = 1, 6
  nl=incr(nl); write (li(nl), '(a, i0, a, es22.14)') 'rel_min_', i, ';REAL;F;',      bunch_params%rel_min(i)
  nl=incr(nl); write (li(nl), '(a, i0, a, es22.14)') 'rel_max_', i, ';REAL;F;',      bunch_params%rel_max(i)
  nl=incr(nl); write (li(nl), '(a, i0, a, es22.14)') 'centroid_vec_', i, ';REAL;F;', bunch_params%centroid%vec(i)
enddo

nl=incr(nl); write (li(nl), rmt) 'centroid_t;REAL;F;',                       bunch_params%centroid%t
nl=incr(nl); write (li(nl), rmt) 'centroid_p0c;REAL;F;',                     bunch_params%centroid%p0c
nl=incr(nl); write (li(nl), rmt) 'centroid_beta;REAL;F;',                    bunch_params%centroid%beta
nl=incr(nl); write (li(nl), imt) 'ix_ele;INT;F;',                            bunch_params%centroid%ix_ele
nl=incr(nl); write (li(nl), imt) 'direction;INT;F;',                         bunch_params%centroid%direction
nl=incr(nl); write (li(nl), amt) 'species;SPECIES;F;',                       trim(species_name(bunch_params%centroid%species))
nl=incr(nl); write (li(nl), amt) 'location;ENUM;F;',                         trim(location_name(bunch_params%centroid%location))
nl=incr(nl); write (li(nl), rmt) 's;REAL;F;',                                bunch_params%s
nl=incr(nl); write (li(nl), rmt) 't;REAL;F;',                                bunch_params%t
nl=incr(nl); write (li(nl), rmt) 'sigma_t;REAL;F;',                          bunch_params%sigma_t
nl=incr(nl); write (li(nl), rmt) 'charge_live;REAL;F;',                      bunch_params%charge_live
nl=incr(nl); write (li(nl), imt) 'n_particle_tot;INT;F;',                    bunch_params%n_particle_tot
nl=incr(nl); write (li(nl), imt) 'n_particle_live;INT;F;',                   bunch_params%n_particle_live
nl=incr(nl); write (li(nl), imt) 'n_particle_lost_in_ele;INT;F;',            bunch_params%n_particle_lost_in_ele

end subroutine bunch_params_out

!----------------------------------------------------------------------
! contains

subroutine real_array_out(val_arr, use_buffer, ix0, ix1)

real(rp) val_arr(:)
integer, optional :: ix0, ix1
integer i, j, n_arr
logical use_buffer

!

n_arr = integer_option(size(val_arr), ix1) - integer_option(1, ix0) + 1

if (use_buffer) then
  call re_allocate_c_double(tao_c_interface_com%c_real, n_arr, .false.)
  tao_c_interface_com%n_real = n_arr
  tao_c_interface_com%c_real(1:n_arr) = val_arr(1:n_arr)

else  ! string_list
  do i = 1, n_arr
    j = i + integer_option(1, ix0) - 1
    nl=incr(nl); write (li(nl), '(i0, a, es22.14)') j, ';', val_arr(i)
  enddo
endif

end subroutine real_array_out

!----------------------------------------------------------------------
! contains

subroutine write_this_floor(floor, name, can_vary)

type(floor_position_struct) :: floor
character(*) name
logical can_vary
integer i, j

!

nl=incr(nl); write (li(nl), rmt2) trim(name) // ';REAL_ARR;', can_vary, (';', floor%r(i), i = 1, 3), ';', floor%theta, ';', floor%phi, ';', floor%psi
nl=incr(nl); write (li(nl), rmt2) trim(name) // '-W;REAL_ARR;', .false., ((';', floor%w(i,j), i = 1, 3), j = 1, 3)

end subroutine write_this_floor

!----------------------------------------------------------------------
! contains

recursive subroutine write_this_ele_floor(ele, loc, can_vary, suffix)

type (ele_struct), target :: ele
type (ele_struct), pointer :: ele0

integer n, ie, loc
logical can_vary
character(*) suffix

!


if (ele%lord_status /= super_lord$ .and. ele%lord_status /= girder_lord$ .and. ele%n_slave > 0) then
  do ie = 1, ele%n_slave
    ele0 => pointer_to_slave(ele, ie)
    call write_this_ele_floor(ele0, loc, can_vary, '-Slave' // int_str(ie))
  enddo
  return
endif

!

if (ele%ix_ele == 0) then
  ele0 => ele
else
  ele0 => pointer_to_next_ele(ele, -1)
endif

select case (loc)
case (1)
  call write_this_floor(ele0%floor, 'Reference' // suffix, can_vary)
  call write_this_floor(ele_geometry_with_misalignments (ele, 0.0_rp), 'Actual' // suffix, .false.)
case (2)
  call ele_geometry(ele0%floor, ele, floor, 0.5_rp)
  call write_this_floor(floor, 'Reference' // suffix, can_vary)
  call write_this_floor(ele_geometry_with_misalignments (ele, 0.5_rp), 'Actual' // suffix, .false.)
case (3)
  call write_this_floor(ele%floor, 'Reference' // suffix, can_vary)
  call write_this_floor(ele_geometry_with_misalignments (ele), 'Actual' // suffix, .false.)
end select

end subroutine write_this_ele_floor

#include "tao_json_cmd_autogen.inc"

end subroutine tao_json_cmd
