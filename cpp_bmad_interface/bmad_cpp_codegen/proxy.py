from __future__ import annotations

import logging
from string import Template
from typing import TYPE_CHECKING

from bmad_cpp_codegen.util import snake_to_camel

from .types import FullType

if TYPE_CHECKING:
    from .create_interface import CodegenStructure

logger = logging.getLogger(__name__)


def struct_to_proxy_class_name(name: str) -> str:
    return snake_to_camel(name.removesuffix("_struct") + "_proxy")


def split_signature(cpp_template: str, class_name: str) -> tuple[str, str]:
    """
    Split a C++ method template into header declaration and implementation.
    """
    clean_template = cpp_template.strip()
    assert "{" in clean_template
    signature = clean_template[: clean_template.find("{")].strip()
    header_declaration = signature + ";"

    ret_type_and_method, args = signature.split("(", 1)
    ret_type, method = ret_type_and_method.rsplit(" ", 1)
    impl_sig = f"{ret_type} {class_name}::{method}({args}"
    implementation = clean_template.replace(signature, impl_sig)
    return header_declaration, implementation


fortran_templates = {
    # REAL types
    FullType("real", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_double), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""",
    },
    FullType("real", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    FullType("real", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
    },
    FullType("complex", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
    },
    FullType("integer", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
    },
    FullType("real", 1, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    FullType("real", 2, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2)))
      
      dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      
      stride1 = 1_c_int
      stride2 = dim1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    # REAL16 types
    FullType("real16", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    real(c_long_double), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""",
    },
    FullType("real16", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    # INTEGER types
    FullType("integer", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""",
    },
    FullType("integer", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    FullType("integer", 1, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    FullType("integer", 2, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2)))
      
      dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      
      dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      
      stride1 = 1_c_int
      stride2 = dim1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    FullType("integer8", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_long_long), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""",
    },
    FullType("integer8", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    # COMPLEX types
    FullType("complex", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    complex(c_double_complex), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""",
    },
    FullType("complex", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    # LOGICAL types
    FullType("logical", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    logical(c_bool), intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""",
    },
    FullType("logical", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    # CHARACTER types
    FullType("character", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    type(STRUCTNAME), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME)
    lower_bound = 1_c_int
    upper_bound = int(len_trim(struct_obj%FATTRNAME), c_int)
    size_out = upper_bound - lower_bound + 1
  end subroutine
""",
    },
    FullType("character", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj

    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME)
      lower_bound = 1_c_int
      upper_bound = int(len_trim(struct_obj%FATTRNAME), c_int)
      size_out = upper_bound - lower_bound + 1
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    # TYPE (derived type - no pointer, just address)
    FullType("type", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%FATTRNAME)
  end subroutine
""",
    },
    FullType("type", 0, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      ptr_out = c_loc(struct_obj%FATTRNAME)
    else
      ptr_out = c_null_ptr
    endif
  end subroutine
""",
    },
    # type 1D arrays
    FullType("type", 1, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, element_size) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    integer(c_size_t), intent(out) :: element_size
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    element_size = int(storage_size(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1))) / 8, c_size_t)
  end subroutine
""",
    },
    FullType("type", 1, "PTR"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    FullType("type", 1, "ALLOC"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      element_size = int(storage_size(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine
""",
    },
    # SIZE queries
    FullType("size", 0, "NOT"): {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, dim, size_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    integer(c_int), intent(in), value :: dim
    integer(c_int), intent(out) :: size_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      if (dim >= 1 .and. dim <= rank(struct_obj%FATTRNAME)) then
        size_out = int(size(struct_obj%FATTRNAME, dim), c_int)
      else
        size_out = -1_c_int  ! Invalid dimension
      endif
    else
      size_out = 0_c_int  ! Not allocated
    endif
  end subroutine
""",
    },
}

cpp_templates = {
    # REAL types
    FullType("real", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, double* value_out);
""",
        "accessor": [
            """
    double CATTRNAME() const {
        double value;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &value);
        return value;
    }
"""
        ],
    },
    FullType("real", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, double** ptr_out);
""",
        "accessor": [
            """
    double* CATTRNAME() const {
        double* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ptr;
    }
"""
        ],
    },
    FullType("real", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        double** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""",
        "accessor": [
            """
    FortranArray1D<double> CATTRNAME() const {
        double* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<double>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
"""
        ],
    },
    FullType("complex", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        std::complex<double>** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""",
        "accessor": [
            """
    FortranArray1D<std::complex<double>> CATTRNAME() const {
        std::complex<double>* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<std::complex<double>>(
            reinterpret_cast<std::complex<double>*>(data_ptr), 
            size_out, lower_bound, upper_bound, true
        );
    }
"""
        ],
    },
    FullType("integer", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        int** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""",
        "accessor": [
            """
    FortranArray1D<int> CATTRNAME() const {
        int* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<int>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
"""
        ],
    },
    FullType("real", 1, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        double** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated
    );
""",
        "accessor": [
            """
    FortranArray1D<double> CATTRNAME() const {
        double* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );
        
        return FortranArray1D<double>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
"""
        ],
    },
    FullType("real", 2, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        double** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated
    );
""",
        "accessor": [
            """
    FortranArray2D<double> CATTRNAME() const {
        double* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, 
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated
        );
        
        return FortranArray2D<double>(data_ptr, 
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, is_allocated);
    }
"""
        ],
    },
    # REAL16 types
    FullType("real16", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, long double* value_out);
""",
        "accessor": [
            """
    long double CATTRNAME() const {
        long double value;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &value);
        return value;
    }
"""
        ],
    },
    FullType("real16", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, long double** ptr_out);
""",
        "accessor": [
            """
    long double* CATTRNAME() const {
        long double* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ptr;
    }
"""
        ],
    },
    # INTEGER types
    FullType("integer", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, int* value_out);
""",
        "accessor": [
            """
    int CATTRNAME() const {
        int value;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &value);
        return value;
    }
"""
        ],
    },
    FullType("integer", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, int** ptr_out);
""",
        "accessor": [
            """
    int* CATTRNAME() const {
        int* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ptr;
    }
"""
        ],
    },
    FullType("integer", 1, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        int** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated
    );
""",
        "accessor": [
            """
    FortranArray1D<int> CATTRNAME() const {
        int* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );
        
        return FortranArray1D<int>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
"""
        ],
    },
    FullType("integer", 2, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        int** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated
    );
""",
        "accessor": [
            """
    FortranArray2D<int> CATTRNAME() const {
        int* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, 
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated
        );
        
        return FortranArray2D<int>(data_ptr, 
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, is_allocated);
    }
"""
        ],
    },
    FullType("integer8", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, long long* value_out);
""",
        "accessor": [
            """
    long long CATTRNAME() const {
        long long value;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &value);
        return value;
    }
"""
        ],
    },
    FullType("integer8", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, long long** ptr_out);
""",
        "accessor": [
            """
    long long* CATTRNAME() const {
        long long* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ptr;
    }
"""
        ],
    },
    # COMPLEX types
    FullType("complex", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, std::complex<double>* value_out);
""",
        "accessor": [
            """
    std::complex<double> CATTRNAME() const {
        std::complex<double> c_value;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &c_value);
        return c_value;
    }
"""
        ],
    },
    FullType("complex", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, double _Complex** ptr_out);
""",
        "accessor": [
            """
    std::complex<double>* CATTRNAME() const {
        std::complex<double>* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return reinterpret_cast<std::complex<double>*>(ptr);
    }
"""
        ],
    },
    # LOGICAL types
    FullType("logical", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, bool* value_out);
""",
        "accessor": [
            """
    bool CATTRNAME() const {
        bool value;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &value);
        return value;
    }
"""
        ],
    },
    FullType("logical", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, bool** ptr_out);
""",
        "accessor": [
            """
    bool* CATTRNAME() const {
        bool* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ptr;
    }
"""
        ],
    },
    # CHARACTER types
    FullType("character", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound
    );
""",
        "accessor": [
            """
    std::string CATTRNAME() const {
        auto char_array = get_FATTRNAME_chars();
        return std::string(char_array.data(), char_array.size());
    }
    """,
            """
    FortranArray1D<char> get_FATTRNAME_chars() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;

        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound
        );

        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""",
        ],
    },
    FullType("character", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated
    );
""",
        "accessor": [
            """
    std::string CATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;

        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );

        if (!is_allocated || size_out == 0) {
            return std::string();
        }

        return std::string(data_ptr, size_out);
    }
""",
            """
    FortranArray1D<char> get_FATTRNAME_chars() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;

        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );

        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""",
        ],
    },
    # TYPE (derived type pointer)
    FullType("type", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, void** ptr_out);
""",
        "accessor": [
            """
    ${return_proxy_name} CATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ${return_proxy_name}(get_fortran_ptr());
    }
"""
        ],
    },
    FullType("type", 0, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, void** ptr_out);
""",
        "accessor": [
            """
    const void* CATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), &ptr);
        return ptr;
    }
"""
        ],
    },
    # type 1D arrays
    FullType("type", 1, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        size_t* element_size
    );
""",
        "accessor": [
            """
    FortranTypeArray1D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        size_t element_size;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &element_size
        );
        
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, true, element_size);
    }
"""
        ],
    },
    FullType("type", 1, "PTR"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated,
        size_t* element_size
    );
""",
        "accessor": [
            """
    FortranTypeArray1D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        size_t element_size;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size
        );
        
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
    }
"""
        ],
    },
    FullType("type", 1, "ALLOC"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated,
        size_t* element_size
    );
""",
        "accessor": [
            """
    FortranTypeArray1D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        size_t element_size;
        
        STRUCTNAME_get_FATTRNAME_info(
            get_fortran_ptr(), &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size
        );
        
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
    }
"""
        ],
    },
    # SIZE queries
    FullType("size", 0, "NOT"): {
        "declaration": """
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, int dim, int* size_out);
""",
        "accessor": [
            """
    int CATTRNAME(int dim = 1) const {
        int size_out;
        STRUCTNAME_get_FATTRNAME(get_fortran_ptr(), dim, &size_out);
        return size_out;
    }
"""
        ],
    },
}


cpp_renames = {
    "long": "long_",
}


def generate_accessor_code(struct_name: str, attr_name: str, full_type: FullType):
    """
    Generate Fortran and C++ accessor code for a given struct/attribute/type combination.
    """

    try:
        fortran_template = fortran_templates[full_type]
        cpp_template = cpp_templates[full_type]
    except KeyError as ex:
        raise ValueError(f"Unsupported type: {full_type}") from ex

    cattr_name = cpp_renames.get(attr_name, attr_name)

    def replace_all(s: str) -> str:
        return (
            s.replace("STRUCTNAME", struct_name)
            .replace("FATTRNAME", attr_name)
            .replace("CATTRNAME", cattr_name)
        )

    return {
        "fortran": replace_all(fortran_template["getter"]),
        "cpp_declaration": replace_all(cpp_template["declaration"]),
        "cpp_accessor": [replace_all(acc) for acc in cpp_template["accessor"]],
    }


def create_fortran_proxy_code(fout, structs: list[CodegenStructure]):
    print(
        """\
module bmad_struct_proxy_mod
  use bmad_struct
  use tao_struct
  use, intrinsic :: iso_c_binding
contains
""",
        file=fout,
    )
    for struct in structs:
        print(f"  !! {struct.f_name}", file=fout)
        print(
            f"""
  function allocate_fortran_{struct.f_name}() result(ptr) bind(c)
    implicit none
    type(c_ptr) :: ptr
    type({struct.f_name}), pointer :: fptr

    allocate(fptr)
    ptr = c_loc(fptr)
  end function

  subroutine deallocate_fortran_{struct.f_name}(ptr) bind(c)
    implicit none
    type(c_ptr), value :: ptr
    type({struct.f_name}), pointer :: fptr

    if (c_associated(ptr)) then
      call c_f_pointer(ptr, fptr)
      deallocate(fptr)
    end if
  end subroutine

  subroutine copy_fortran_{struct.f_name}(src_ptr, dst_ptr) bind(c)
    implicit none
    type(c_ptr), value :: src_ptr, dst_ptr
    type({struct.f_name}), pointer :: src, dst

    if (c_associated(src_ptr) .and. c_associated(dst_ptr)) then
      call c_f_pointer(src_ptr, src)
      call c_f_pointer(dst_ptr, dst)
      dst = src  ! Fortran derived type assignment
    end if
  end subroutine

        """,
            file=fout,
        )
        for arg in struct.arg:
            if not arg.is_component:
                continue
            try:
                acc = generate_accessor_code(struct.f_name, arg.f_name, arg.full_type)
            except ValueError as ex:
                print(f"  ! skipped {struct.f_name}%{arg.f_name}: {ex}", file=fout)
                continue

            print(f"  ! {struct.f_name}%{arg.f_name}: {arg.full_type}", file=fout)
            print(acc["fortran"], file=fout)
    print("end module", file=fout)


def get_proxy_header_and_code(
    header_template_src: str, cpp_template_src: str, structs: list[CodegenStructure]
) -> tuple[str, str]:
    c_forward_declarations = []
    subs = {}

    class_template = Template(
        """

extern "C" {
  void* allocate_fortran_${struct_name}();
  void deallocate_fortran_${struct_name}(void* ptr) noexcept;
  void copy_fortran_${struct_name}_struct(const void* src, void* dst);
}

template <>
struct FortranTraits<${class_name}> {
  static void* allocate() {
    return allocate_fortran_${struct_name}();
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_${struct_name}(ptr);
  }
  static void copy(const void* src, void* dst) {
    copy_fortran_${struct_name}_struct(src, dst);
  }
  static constexpr std::string_view type_name() {
    return "${struct_name}";
  }
};

class ${class_name} : public FortranProxy<${class_name}> {
 public:
  using FortranProxy::FortranProxy;
  using FortranProxy::operator=;

  ${class_body}
};
"""
    )

    classes = {}
    all_impl = []
    for struct in structs:
        proxy_class_name = struct_to_proxy_class_name(struct.f_name)
        class_body = []
        for arg in struct.arg:
            if not arg.is_component:
                continue
            try:
                acc = generate_accessor_code(struct.f_name, arg.f_name, arg.full_type)
            except ValueError as ex:
                # print(f"// skipped {struct.f_name}%{arg.f_name}: {ex}", file=fout)
                logging.warning(f"Proxy class {struct.f_name}%{arg.f_name} skipped: {ex}")
                continue

            c_forward_declarations.append(acc["cpp_declaration"])

            for accessor_body in acc["cpp_accessor"]:
                if arg.full_type.type == "type":
                    accessor_body = Template(accessor_body).substitute(
                        return_proxy_name=struct_to_proxy_class_name(arg.kind)
                    )
                sig, impl = split_signature(accessor_body, proxy_class_name)
                all_impl.append(impl)
                class_body.append(f"{sig} // {arg.full_type}")

        subs[f"{struct.f_name}_class_body"] = "\n".join(class_body)

        classes[struct.f_name] = class_body

    class_forward_declarations = []
    proxy_classes = []
    for name, class_body in classes.items():
        class_forward_declarations.append(f"class {struct_to_proxy_class_name(name)};")
        proxy_classes.append(
            class_template.substitute(
                struct_name=name,
                class_name=struct_to_proxy_class_name(name),
                class_body="\n".join(class_body),
            )
        )

    subs["c_forward_declarations"] = "\n".join(c_forward_declarations)
    subs["class_forward_declarations"] = "\n".join(class_forward_declarations)
    subs["proxy_classes"] = "\n".join(proxy_classes)

    header = Template(header_template_src.replace("// ${", "${")).substitute(subs)
    impl = cpp_template_src + "\n".join(all_impl)
    return header, impl


def create_cpp_proxy_header(
    fout, header_template_src: str, cpp_template_src: str, structs: list[CodegenStructure]
):
    header, _ = get_proxy_header_and_code(header_template_src, cpp_template_src, structs)
    fout.write(header)


def create_cpp_proxy_impl(
    fout, header_template_src: str, cpp_template_src: str, structs: list[CodegenStructure]
):
    _, impl = get_proxy_header_and_code(header_template_src, cpp_template_src, structs)
    fout.write(impl)
