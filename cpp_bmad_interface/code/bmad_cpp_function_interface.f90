module bmad_cpp_function_interface

use bmad_interface, only: bmad_parser, lat_struct
use bmad_cpp_convert_mod, only: lat_to_c
use bmad_struct, only: lat_struct
use fortran_cpp_utils
use, intrinsic :: iso_c_binding


! interface
!
!   function cpp_bmad_parser (lat_file, lat, make_mats6, digested_read_ok, use_line, err_flag, parse_lat) bind(c) result(err_flag)
!     import c_ptr
!     import lat_struct
!
!     implicit none
!     character(*) lat_file
!     type (c_ptr), target :: lat
!     type (c_ptr), optional :: parse_lat
!     logical, optional :: make_mats6
!     logical, optional :: digested_read_ok
!     logical :: err_flag
!     character(*), optional :: use_line
!   end function
!
! end interface

contains

  function cpp_bmad_parser (lat_file, lat) bind(c) result(err_flag)
    ! , make_mats6, digested_read_ok, use_line, parse_lat
    use, intrinsic :: iso_c_binding, only: c_char, c_ptr, c_bool
    implicit none
    character(kind=c_char), intent(in) :: lat_file(*)
    type (c_ptr), intent(in), value :: lat
    ! ref: https://gcc.gnu.org/onlinedocs/gcc-4.7.1/gfortran/Working-with-Pointers.html
    ! type(c_ptr) matches with 'void**'
    ! type(c_ptr), value matches with 'void*'
    type (c_ptr) :: parse_lat
    type (lat_struct), target :: f_lat
    type (lat_struct) :: f_parse_lat
    type (c_ptr) :: ptr_f_lat
    logical :: make_mats6
    logical :: digested_read_ok
    logical :: f_err_flag
    logical :: err_flag
    character(len=100) :: use_line = ''
    ! logical, intent(in), optional :: make_mats6
    ! logical, intent(out), optional :: digested_read_ok
    ! logical :: err_flag
    ! character(*), intent(in), optional :: use_line
    
    character(len=1000) :: f_lat_file

    call to_f_str(lat_file, f_lat_file)
 
    if (.not. c_associated(lat)) then
      err_flag = .true.
      return
    endIf

    call bmad_parser(f_lat_file, f_lat, make_mats6, digested_read_ok, use_line, err_flag, f_parse_lat)

    ptr_f_lat = c_loc(f_lat)

    if (.not. c_associated(ptr_f_lat)) then
      err_flag = .true.
      return
    endIf

    call lat_to_c(ptr_f_lat, lat)
    err_flag = .false.

  end function cpp_bmad_parser

end module
