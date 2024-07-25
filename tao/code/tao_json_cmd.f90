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

#include "tao_json_cmd_autogen.inc"

end subroutine tao_json_cmd
