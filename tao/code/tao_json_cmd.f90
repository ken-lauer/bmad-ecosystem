!+
! Subroutine tao_json_cmd (input_str)
!
! Print information in JSON format.
!
!-

subroutine tao_json_cmd (input_str)

use tao_interface, dummy => tao_json_cmd

use json_module
use json_string_utilities, only: integer_to_string
use json_kinds, only: CK
use tao_c_interface_mod, only: tao_c_interface_com
use tao_command_mod, only: tao_next_switch, tao_next_word
use tao_json, only: tao_plot_page_struct_to_json, tao_global_struct_to_json, &
            tao_super_universe_struct_to_json, tao_lattice_struct_to_json
use bmad_json, only: ele_struct_to_json

implicit none

type (tao_universe_struct), pointer :: u
type(json_core) :: json
type(json_value), pointer :: json_root

type (tao_lattice_struct), pointer :: tao_lat
type (ele_struct), pointer :: ele
integer :: iu_write, ix, ix_line
logical :: err, opened, array_out

character(*) input_str
character(*), parameter :: r_name = 'tao_json_cmd'
character(20) cmd
character(20) switch
character(200) file_name
character(200) tail_str
character(40) command
character(40) which
character(len(input_str)) line

!

nullify(json_root)
line = input_str
opened = .false.
array_out = .false.

do
  call tao_next_switch (line, [character(10):: '-append', '-write', '-array_out'], .false., switch, err)
  if (err) return
  if (switch == '') exit

  select case (switch)
  case ('-array_out')
    array_out = .true.

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

call match_word (cmd, [character(40) :: &
  'ele', &
  'global', &
  'lattice', &
  'plot_page', &
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

select case (command)

  case ('plot_page')
    call tao_plot_page_struct_to_json(s%plot_page, json_root)

  case ('universe')
    call tao_super_universe_struct_to_json(s, json_root)

  case ('lattice')
    u => point_to_uni(line, .true., err); if (err) return
    tao_lat => point_to_tao_lat(line, u, err, which, tail_str); if (err) return
    call tao_lattice_struct_to_json(u%model, json_root)

  case ('ele')
    u => point_to_uni(line, .true., err); if (err) return
    tao_lat => point_to_tao_lat(line, u, err, which, tail_str); if (err) return
    ele => point_to_ele(line, tao_lat%lat, err); if (err) return
    call ele_struct_to_json(ele, json_root)

  case ('global')
    call tao_global_struct_to_json(s%global, json_root)

!----------------------------------------------------------------------

case default

  call out_io (s_error$, r_name, "json command internal error, shouldn't be here!")

end select

call end_stuff()

!----------------------------------------------------------------------
! return through scratch

contains

subroutine end_stuff()

  integer :: str_len
  character(kind=CK,len=:), allocatable :: str

  if (associated(json_root)) then
    if (array_out) then
      call json%serialize(json_root, str)

      str_len = len(str)
      call reallocate_c_string_scratch(str_len + 1)
      tao_c_interface_com%c_string(1:str_len) = transfer(str(1:str_len), tao_c_interface_com%c_string(1:str_len))
      tao_c_interface_com%c_string(str_len + 1) = c_null_char

    elseif (opened) then
      call json%print(json_root, iu_write)
      close (iu_write)

    else
      call json%print(json_root)
    endif
    call json%destroy(json_root)
    nullify(json_root)
  endif

end subroutine

!----------------------------------------------------------------------
! contains

subroutine reallocate_c_string_scratch(n)
integer :: n
if (.not. allocated(tao_c_interface_com%c_string)) allocate (tao_c_interface_com%c_string(n))
if (size(tao_c_interface_com%c_string) < n) then
  deallocate (tao_c_interface_com%c_string)
  allocate (tao_c_interface_com%c_string(n))
endif
tao_c_interface_com%n_char = n
end subroutine

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
  ix = tao_uni_atsign_index(line)
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

function point_to_tao_lat (line, u, err, which, tail_str) result (tao_lat)

type (tao_lattice_struct), pointer :: tao_lat
type (tao_universe_struct) u
integer i, ix
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

subroutine invalid (why_invalid, err)

character(*) why_invalid
logical, optional :: err

call out_io (s_error$, r_name, '"json ' // trim(input_str) // '": ' // why_invalid)
call end_stuff()
if (present(err)) err = .true.

end subroutine invalid

end subroutine tao_json_cmd

