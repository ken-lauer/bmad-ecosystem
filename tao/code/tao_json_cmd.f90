!+
! Subroutine tao_json_cmd (input_str)
!
! Print information in JSON format.
!
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

call out_io (s_error$, r_name, 'json got: ' // cmd)

call match_word (cmd, [character(40) :: &
          'global', &
          'plot_page', &
          'lattice_model', &
          'universe'], &
          ix, matched_name = command)

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

subroutine invalid (why_invalid, err)

character(*) why_invalid
logical, optional :: err

nl=incr(nl); li(nl) = 'INVALID'
call out_io (s_error$, r_name, '"json ' // trim(input_str) // '": ' // why_invalid)
call end_stuff(li, nl)
if (present(err)) err = .true.

end subroutine invalid

#include "tao_json_cmd_autogen.inc"

end subroutine tao_json_cmd
