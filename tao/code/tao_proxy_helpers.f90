module tao_c_proxy_interface
  use bmad
  use tao_interface
  use fortran_cpp_utils, only: to_c_str

  implicit none

  ! C-compatible lattice type enumeration
  integer, parameter :: LATTICE_MODEL = 1
  integer, parameter :: LATTICE_DESIGN = 2  
  integer, parameter :: LATTICE_BASE = 3

contains

  function is_initialized() result(n) bind(c, name='tao_is_initialized')
    integer(c_int) :: n
    if (s%initialized) then
      n = 1
    else
      n = 0
    end if
  end function

  ! Global accessor functions (only these use indices)
  function get_n_universes() result(n) bind(c, name='tao_get_n_universes')
    integer(c_int) :: n
    n = size(s%u)
  end function

  function c_get_universe_ptr(ix_uni) result(ptr) bind(c, name="tao_c_get_universe_ptr")
    integer(c_int), intent(in), value :: ix_uni
    type(tao_universe_struct), pointer :: uni_ptr
    type(c_ptr) :: ptr
   
    uni_ptr => get_universe_ptr(ix_uni)

    if (associated(uni_ptr)) then
      ptr = c_loc(uni_ptr)
    else
      ptr = c_null_ptr
    endif
  end function

  function c_get_tao_lattice_ptr(ix_uni, ix_lat) result(ptr) bind(c, name='tao_c_get_tao_lattice_ptr')
    integer(c_int), intent(in), value :: ix_uni, ix_lat
    type(c_ptr) :: ptr
    type(tao_lattice_struct), pointer :: lat_ptr
    
    lat_ptr => get_tao_lattice_ptr(ix_uni, ix_lat)
    if (associated(lat_ptr)) then
      ptr = c_loc(lat_ptr)
    else
      ptr = c_null_ptr
    endif
  end function

  function c_get_lattice_ptr(ix_uni, ix_lat) result(ptr) bind(c, name='tao_c_get_lattice_ptr')
    integer(c_int), intent(in), value :: ix_uni, ix_lat
    type(c_ptr) :: ptr
    type(lat_struct), pointer :: lat_ptr
    
    lat_ptr => get_lattice_ptr(ix_uni, ix_lat)
    if (associated(lat_ptr)) then
      ptr = c_loc(lat_ptr)
    else
      ptr = c_null_ptr
    endif
  end function

  function c_get_branch_ptr(ix_uni, ix_lat, ix_branch) result(ptr) bind(c, name='tao_c_get_branch_ptr')
    integer(c_int), intent(in), value :: ix_uni, ix_lat, ix_branch
    type(c_ptr) :: ptr
    type(branch_struct), pointer :: branch_ptr
    
    branch_ptr => get_branch_ptr(ix_uni, ix_lat, ix_branch)
    if (associated(branch_ptr)) then
      ptr = c_loc(branch_ptr)
    else
      ptr = c_null_ptr
    endif
  end function

  function c_get_element_ptr(ix_uni, ix_lat, ix_branch, ix_ele) result(ptr) bind(c, name='tao_c_get_element_ptr')
    integer(c_int), intent(in), value :: ix_uni, ix_lat, ix_branch, ix_ele
    type(c_ptr) :: ptr
    type(ele_struct), pointer :: ele_ptr
    
    ele_ptr => get_element_ptr(ix_uni, ix_lat, ix_branch, ix_ele)
    if (associated(ele_ptr)) then
      ptr = c_loc(ele_ptr)
    else
      ptr = c_null_ptr
    endif
  end function

  ! Pointer-based accessor functions (these use C pointers to structures)
  function lat_get_n_branches(lat_ptr) result(n) bind(c, name='tao_lat_get_n_branches')
    type(c_ptr), intent(in), value :: lat_ptr
    integer(c_int) :: n
    type(lat_struct), pointer :: lat
    
    if (c_associated(lat_ptr)) then
      call c_f_pointer(lat_ptr, lat)
      n = size(lat%branch)
    else
      n = -1
    endif
  end function

  function lat_get_branch_ptr(lat_ptr, ix_branch) result(ptr) bind(c, name='tao_lat_get_branch_ptr')
    type(c_ptr), intent(in), value :: lat_ptr
    integer(c_int), intent(in), value :: ix_branch
    type(c_ptr) :: ptr
    type(lat_struct), pointer :: lat
    
    ptr = c_null_ptr
    if (.not. c_associated(lat_ptr)) return
    
    call c_f_pointer(lat_ptr, lat)
    if (ix_branch < lbound(lat%branch, 1) .or. ix_branch > ubound(lat%branch, 1)) return
    
    ptr = c_loc(lat%branch(ix_branch))
  end function

  function branch_get_n_elements(branch_ptr) result(n) bind(c, name='tao_branch_get_n_elements')
    type(c_ptr), intent(in), value :: branch_ptr
    integer(c_int) :: n
    type(branch_struct), pointer :: branch
    
    if (c_associated(branch_ptr)) then
      call c_f_pointer(branch_ptr, branch)
      n = branch%n_ele_max ! ubound(branch%ele, 1)
    else
      n = -1
    endif
  end function

  function branch_get_element_ptr(branch_ptr, ix_ele) result(ptr) bind(c, name='tao_branch_get_element_ptr')
    type(c_ptr), intent(in), value :: branch_ptr
    integer(c_int), intent(in), value :: ix_ele
    type(c_ptr) :: ptr
    type(branch_struct), pointer :: branch
    
    ptr = c_null_ptr
    if (.not. c_associated(branch_ptr)) return
    
    call c_f_pointer(branch_ptr, branch)
    if (ix_ele < lbound(branch%ele, 1) .or. ix_ele > ubound(branch%ele, 1) .or. ix_ele > branch%n_ele_max) return
    
    ptr = c_loc(branch%ele(ix_ele))
  end function

  ! Helper functions for internal use

  function get_universe_ptr(ix_uni) result(uni_ptr)
    integer, intent(in) :: ix_uni
    type(tao_universe_struct), pointer :: uni_ptr
    
    uni_ptr => null()
    if (ix_uni < lbound(s%u, 1) .or. ix_uni > ubound(s%u, 1)) return
    
    uni_ptr => s%u(ix_uni)
  end function

  function get_tao_lattice_ptr(ix_uni, ix_lat) result(lat_ptr)
    integer, intent(in) :: ix_uni, ix_lat
    type(tao_lattice_struct), pointer :: lat_ptr
    
    lat_ptr => null()
    if (ix_uni < lbound(s%u, 1) .or. ix_uni > ubound(s%u, 1)) then
      return
    endif
    
    select case(ix_lat)
    case (LATTICE_MODEL)
      lat_ptr => s%u(ix_uni)%model
    case (LATTICE_DESIGN) 
      lat_ptr => s%u(ix_uni)%design
    case (LATTICE_BASE)
      lat_ptr => s%u(ix_uni)%base
    end select
  end function

  function get_lattice_ptr(ix_uni, ix_lat) result(lat_ptr)
    integer, intent(in) :: ix_uni, ix_lat
    type(tao_lattice_struct), pointer :: tao_lat_ptr
    type(lat_struct), pointer :: lat_ptr

    lat_ptr => null()
    tao_lat_ptr => get_tao_lattice_ptr(ix_uni, ix_lat)
    if (associated(tao_lat_ptr)) then
      lat_ptr => tao_lat_ptr%lat
    endif

  end function

  function get_branch_ptr(ix_uni, ix_lat, ix_branch) result(branch_ptr)
    integer, intent(in) :: ix_uni, ix_lat, ix_branch
    type(branch_struct), pointer :: branch_ptr
    type(lat_struct), pointer :: lat_ptr
    
    branch_ptr => null()
    lat_ptr => get_lattice_ptr(ix_uni, ix_lat)
    if (.not. associated(lat_ptr)) return
    if (ix_branch < lbound(lat_ptr%branch, 1) .or. ix_branch > ubound(lat_ptr%branch, 1)) return
    
    branch_ptr => lat_ptr%branch(ix_branch)
  end function

  function get_element_ptr(ix_uni, ix_lat, ix_branch, ix_ele) result(ele_ptr)
    integer, intent(in) :: ix_uni, ix_lat, ix_branch, ix_ele
    type(ele_struct), pointer :: ele_ptr
    type(branch_struct), pointer :: branch_ptr
    
    ele_ptr => null()
    branch_ptr => get_branch_ptr(ix_uni, ix_lat, ix_branch)
    if (.not. associated(branch_ptr)) return
    if (ix_ele < lbound(branch_ptr%ele, 1) .or. ix_ele > ubound(branch_ptr%ele, 1)) return
    
    ele_ptr => branch_ptr%ele(ix_ele)
  end function

end module tao_c_proxy_interface
