from __future__ import annotations

import logging
from string import Template
from typing import TYPE_CHECKING

from bmad_cpp_codegen.interface_input_params import c_side_name_translation
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
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
            fortran_ptr_, &data_ptr, 
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
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
            fortran_ptr_, &data_ptr, 
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &c_value);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return ${return_proxy_name}(ptr);
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &element_size
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size
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
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size
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
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, dim, &size_out);
        return size_out;
    }
"""
        ],
    },
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

    cattr_name = c_side_name_translation.get(f"{struct_name}%{attr_name}", attr_name)

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
  void copy_fortran_${struct_name}(const void* src, void* dst);
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
    copy_fortran_${struct_name}(src, dst);
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


from collections import namedtuple
from string import Template
from typing import Dict, Any, List

# Keep the existing FullType as-is
FullType = namedtuple("FullType", ["type_name", "dimensions", "memory_type"])


# Type mappings for consistency
class TypeMappings:
    real = {
        "fortran_type": "real(c_double)",
        "cpp_type": "double",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }
    real16 = {
        "fortran_type": "real(c_long_double)",
        "cpp_type": "long double",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }
    integer = {
        "fortran_type": "integer(c_int)",
        "cpp_type": "int",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }
    integer8 = {
        "fortran_type": "integer(c_long_long)",
        "cpp_type": "long long",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }
    complex = {
        "fortran_type": "complex(c_double_complex)",
        "cpp_type": "std::complex<double>",
        "fortran_complex_type": "complex(c_double_complex)",
        "cpp_complex_type": "std::complex<double>",
    }
    logical = {
        "fortran_type": "logical(c_bool)",
        "cpp_type": "bool",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }
    character = {
        "fortran_type": "character",
        "cpp_type": "char",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }
    type = {
        "fortran_type": "type",
        "cpp_type": "void*",
        "fortran_complex_type": None,
        "cpp_complex_type": None,
    }


class FortranPatterns:
    scalar_getter = Template("""
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    ${fortran_type}, intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
""")

    pointer_getter = Template("""
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
""")

    array_1d_info = Template("""
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
""")

    array_1d_alloc_info = Template("""
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
""")

    array_2d_alloc_info = Template("""
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
""")

    type_array_1d_info = Template("""
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
""")

    type_array_1d_alloc_info = Template("""
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
""")

    type_array_1d_ptr_info = Template("""
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
""")

    character_info = Template("""
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
""")

    character_ptr_info = Template("""
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
""")

    type_scalar_getter = Template("""
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%FATTRNAME)
  end subroutine
""")

    size_query = Template("""
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
""")


class CppPatterns:
    scalar_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, ${cpp_type}* value_out);
""")

    scalar_accessor = Template("""
    ${cpp_type} CATTRNAME() const {
        ${cpp_type} value;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
        return value;
    }
""")

    pointer_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, ${cpp_type}** ptr_out);
""")

    pointer_accessor = Template("""
    ${cpp_type}* CATTRNAME() const {
        ${cpp_type}* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""")

    array_1d_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        ${cpp_type}** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound
    );
""")

    array_1d_accessor = Template("""
    FortranArray1D<${cpp_type}> CATTRNAME() const {
        ${cpp_type}* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<${cpp_type}>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""")

    array_1d_alloc_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        ${cpp_type}** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated
    );
""")

    array_1d_alloc_accessor = Template("""
    FortranArray1D<${cpp_type}> CATTRNAME() const {
        ${cpp_type}* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        
        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );
        
        return FortranArray1D<${cpp_type}>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""")

    array_2d_alloc_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        ${cpp_type}** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated
    );
""")

    array_2d_alloc_accessor = Template("""
    FortranArray2D<${cpp_type}> CATTRNAME() const {
        ${cpp_type}* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        
        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, 
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated
        );
        
        return FortranArray2D<${cpp_type}>(data_ptr, 
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, is_allocated);
    }
""")

    character_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound
    );
""")

    character_accessor = Template("""
    std::string CATTRNAME() const {
        auto char_array = get_FATTRNAME_chars();
        return std::string(char_array.data(), char_array.size());
    }
""")

    character_chars_accessor = Template("""
    FortranArray1D<char> get_FATTRNAME_chars() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;

        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );

        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""")

    character_ptr_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated
    );
""")

    character_ptr_accessor = Template("""
    std::string CATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;

        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );

        if (!is_allocated || size_out == 0) {
            return std::string();
        }

        return std::string(data_ptr, size_out);
    }
""")

    character_ptr_chars_accessor = Template("""
    FortranArray1D<char> get_FATTRNAME_chars() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;

        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated
        );

        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""")

    type_scalar_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, void** ptr_out);
""")

    type_scalar_accessor = Template("""
    ${return_proxy_name} CATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return ${return_proxy_name}(ptr);
    }
""")

    type_ptr_accessor = Template("""
    const void* CATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
""")

    type_array_1d_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        size_t* element_size
    );
""")

    type_array_1d_accessor = Template("""
    FortranTypeArray1D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        size_t element_size;
        
        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &element_size
        );
        
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, true, element_size);
    }
""")

    type_array_1d_alloc_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out, 
        int* lower_bound, 
        int* upper_bound,
        bool* is_allocated,
        size_t* element_size
    );
""")

    type_array_1d_alloc_accessor = Template("""
    FortranTypeArray1D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        size_t element_size;
        
        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size
        );
        
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
    }
""")

    size_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, int dim, int* size_out);
""")

    size_accessor = Template("""
    int CATTRNAME(int dim = 1) const {
        int size_out;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, dim, &size_out);
        return size_out;
    }
""")

    # Special patterns for complex types that need custom handling
    complex_scalar_accessor = Template("""
    std::complex<double> CATTRNAME() const {
        std::complex<double> c_value;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &c_value);
        return c_value;
    }
""")

    complex_ptr_declaration = Template("""
    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, double _Complex** ptr_out);
""")

    complex_ptr_accessor = Template("""
    std::complex<double>* CATTRNAME() const {
        std::complex<double>* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return reinterpret_cast<std::complex<double>*>(ptr);
    }
""")

    complex_array_1d_accessor = Template("""
    FortranArray1D<std::complex<double>> CATTRNAME() const {
        std::complex<double>* data_ptr;
        int size_out, lower_bound, upper_bound;
        
        STRUCTNAME_get_FATTRNAME_info(
            fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound
        );
        
        return FortranArray1D<std::complex<double>>(
            reinterpret_cast<std::complex<double>*>(data_ptr), 
            size_out, lower_bound, upper_bound, true
        );
    }
""")


# Consolidated templates using class-based patterns
templates = {
    # REAL types
    FullType("real", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.scalar_getter.substitute(
                fortran_type=TypeMappings.real["fortran_type"]
            ),
        },
        "cpp": {
            "declaration": CppPatterns.scalar_declaration.substitute(cpp_type=TypeMappings.real["cpp_type"]),
            "accessor": [CppPatterns.scalar_accessor.substitute(cpp_type=TypeMappings.real["cpp_type"])],
        },
    },
    FullType("real", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.pointer_declaration.substitute(cpp_type=TypeMappings.real["cpp_type"]),
            "accessor": [CppPatterns.pointer_accessor.substitute(cpp_type=TypeMappings.real["cpp_type"])],
        },
    },
    FullType("real", 1, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.array_1d_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_1d_declaration.substitute(
                cpp_type=TypeMappings.real["cpp_type"]
            ),
            "accessor": [CppPatterns.array_1d_accessor.substitute(cpp_type=TypeMappings.real["cpp_type"])],
        },
    },
    FullType("complex", 1, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.array_1d_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_1d_declaration.substitute(
                cpp_type=TypeMappings.complex["cpp_type"]
            ),
            "accessor": [CppPatterns.complex_array_1d_accessor.substitute()],
        },
    },
    FullType("integer", 1, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.array_1d_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_1d_declaration.substitute(
                cpp_type=TypeMappings.integer["cpp_type"]
            ),
            "accessor": [CppPatterns.array_1d_accessor.substitute(cpp_type=TypeMappings.integer["cpp_type"])],
        },
    },
    FullType("real", 1, "ALLOC"): {
        "fortran": {
            "getter": FortranPatterns.array_1d_alloc_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_1d_alloc_declaration.substitute(
                cpp_type=TypeMappings.real["cpp_type"]
            ),
            "accessor": [
                CppPatterns.array_1d_alloc_accessor.substitute(cpp_type=TypeMappings.real["cpp_type"])
            ],
        },
    },
    FullType("real", 2, "ALLOC"): {
        "fortran": {
            "getter": FortranPatterns.array_2d_alloc_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_2d_alloc_declaration.substitute(
                cpp_type=TypeMappings.real["cpp_type"]
            ),
            "accessor": [
                CppPatterns.array_2d_alloc_accessor.substitute(cpp_type=TypeMappings.real["cpp_type"])
            ],
        },
    },
    # REAL16 types
    FullType("real16", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.scalar_getter.substitute(
                fortran_type=TypeMappings.real16["fortran_type"]
            ),
        },
        "cpp": {
            "declaration": CppPatterns.scalar_declaration.substitute(
                cpp_type=TypeMappings.real16["cpp_type"]
            ),
            "accessor": [CppPatterns.scalar_accessor.substitute(cpp_type=TypeMappings.real16["cpp_type"])],
        },
    },
    FullType("real16", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.pointer_declaration.substitute(
                cpp_type=TypeMappings.real16["cpp_type"]
            ),
            "accessor": [CppPatterns.pointer_accessor.substitute(cpp_type=TypeMappings.real16["cpp_type"])],
        },
    },
    # INTEGER types
    FullType("integer", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.scalar_getter.substitute(
                fortran_type=TypeMappings.integer["fortran_type"]
            ),
        },
        "cpp": {
            "declaration": CppPatterns.scalar_declaration.substitute(
                cpp_type=TypeMappings.integer["cpp_type"]
            ),
            "accessor": [CppPatterns.scalar_accessor.substitute(cpp_type=TypeMappings.integer["cpp_type"])],
        },
    },
    FullType("integer", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.pointer_declaration.substitute(
                cpp_type=TypeMappings.integer["cpp_type"]
            ),
            "accessor": [CppPatterns.pointer_accessor.substitute(cpp_type=TypeMappings.integer["cpp_type"])],
        },
    },
    FullType("integer", 1, "ALLOC"): {
        "fortran": {
            "getter": FortranPatterns.array_1d_alloc_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_1d_alloc_declaration.substitute(
                cpp_type=TypeMappings.integer["cpp_type"]
            ),
            "accessor": [
                CppPatterns.array_1d_alloc_accessor.substitute(cpp_type=TypeMappings.integer["cpp_type"])
            ],
        },
    },
    FullType("integer", 2, "ALLOC"): {
        "fortran": {
            "getter": FortranPatterns.array_2d_alloc_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.array_2d_alloc_declaration.substitute(
                cpp_type=TypeMappings.integer["cpp_type"]
            ),
            "accessor": [
                CppPatterns.array_2d_alloc_accessor.substitute(cpp_type=TypeMappings.integer["cpp_type"])
            ],
        },
    },
    FullType("integer8", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.scalar_getter.substitute(
                fortran_type=TypeMappings.integer8["fortran_type"]
            ),
        },
        "cpp": {
            "declaration": CppPatterns.scalar_declaration.substitute(
                cpp_type=TypeMappings.integer8["cpp_type"]
            ),
            "accessor": [CppPatterns.scalar_accessor.substitute(cpp_type=TypeMappings.integer8["cpp_type"])],
        },
    },
    FullType("integer8", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.pointer_declaration.substitute(
                cpp_type=TypeMappings.integer8["cpp_type"]
            ),
            "accessor": [CppPatterns.pointer_accessor.substitute(cpp_type=TypeMappings.integer8["cpp_type"])],
        },
    },
    # COMPLEX types
    FullType("complex", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.scalar_getter.substitute(
                fortran_type=TypeMappings.complex["fortran_type"]
            ),
        },
        "cpp": {
            "declaration": CppPatterns.scalar_declaration.substitute(
                cpp_type=TypeMappings.complex["cpp_type"]
            ),
            "accessor": [CppPatterns.complex_scalar_accessor.substitute()],
        },
    },
    FullType("complex", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.complex_ptr_declaration.substitute(),
            "accessor": [CppPatterns.complex_ptr_accessor.substitute()],
        },
    },
    # LOGICAL types
    FullType("logical", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.scalar_getter.substitute(
                fortran_type=TypeMappings.logical["fortran_type"]
            ),
        },
        "cpp": {
            "declaration": CppPatterns.scalar_declaration.substitute(
                cpp_type=TypeMappings.logical["cpp_type"]
            ),
            "accessor": [CppPatterns.scalar_accessor.substitute(cpp_type=TypeMappings.logical["cpp_type"])],
        },
    },
    FullType("logical", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.pointer_declaration.substitute(
                cpp_type=TypeMappings.logical["cpp_type"]
            ),
            "accessor": [CppPatterns.pointer_accessor.substitute(cpp_type=TypeMappings.logical["cpp_type"])],
        },
    },
    # CHARACTER types
    FullType("character", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.character_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.character_declaration.substitute(),
            "accessor": [
                CppPatterns.character_accessor.substitute(),
                CppPatterns.character_chars_accessor.substitute(),
            ],
        },
    },
    FullType("character", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.character_ptr_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.character_ptr_declaration.substitute(),
            "accessor": [
                CppPatterns.character_ptr_accessor.substitute(),
                CppPatterns.character_ptr_chars_accessor.substitute(),
            ],
        },
    },
    # TYPE (derived type - no pointer, just address)
    FullType("type", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.type_scalar_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.type_scalar_declaration.substitute(),
            "accessor": [
                CppPatterns.type_scalar_accessor.substitute(return_proxy_name="${return_proxy_name}")
            ],
        },
    },
    FullType("type", 0, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.pointer_getter.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.type_scalar_declaration.substitute(),
            "accessor": [CppPatterns.type_ptr_accessor.substitute()],
        },
    },
    # type 1D arrays
    FullType("type", 1, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.type_array_1d_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.type_array_1d_declaration.substitute(),
            "accessor": [
                CppPatterns.type_array_1d_accessor.substitute(return_proxy_name="${return_proxy_name}")
            ],
        },
    },
    FullType("type", 1, "PTR"): {
        "fortran": {
            "getter": FortranPatterns.type_array_1d_ptr_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.type_array_1d_alloc_declaration.substitute(),
            "accessor": [
                CppPatterns.type_array_1d_alloc_accessor.substitute(return_proxy_name="${return_proxy_name}")
            ],
        },
    },
    FullType("type", 1, "ALLOC"): {
        "fortran": {
            "getter": FortranPatterns.type_array_1d_alloc_info.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.type_array_1d_alloc_declaration.substitute(),
            "accessor": [
                CppPatterns.type_array_1d_alloc_accessor.substitute(return_proxy_name="${return_proxy_name}")
            ],
        },
    },
    # SIZE queries
    FullType("size", 0, "NOT"): {
        "fortran": {
            "getter": FortranPatterns.size_query.substitute(),
        },
        "cpp": {
            "declaration": CppPatterns.size_declaration.substitute(),
            "accessor": [CppPatterns.size_accessor.substitute()],
        },
    },
}


def validate_templates():
    """
    Validate that the new consolidated templates match the original ones.

    Returns:
        bool: True if validation passes, False otherwise
    """

    errors = []
    successes = 0

    print("Validating Fortran templates...")
    for full_type, template_data in fortran_templates.items():
        if full_type not in templates:
            errors.append(f"Missing FullType in new templates: {full_type}")
            continue

        new_fortran = templates[full_type]["fortran"]["getter"]
        old_fortran = template_data["getter"]

        # Normalize whitespace for comparison
        new_normalized = " ".join(new_fortran.split())
        old_normalized = " ".join(old_fortran.split())

        if new_normalized != old_normalized:
            errors.append(f"Fortran template mismatch for {full_type}")
            print(f"  Expected: {old_normalized}")
            print(f"  Got:      {new_normalized}")
        else:
            successes += 1

    print(f"Fortran validation: {successes} successes")

    print("\nValidating C++ templates...")
    cpp_successes = 0
    for full_type, template_data in cpp_templates.items():
        if full_type not in templates:
            errors.append(f"Missing FullType in new templates: {full_type}")
            continue

        new_cpp_decl = templates[full_type]["cpp"]["declaration"]
        old_cpp_decl = template_data["declaration"]

        # Normalize whitespace for comparison
        new_decl_normalized = " ".join(new_cpp_decl.split())
        old_decl_normalized = " ".join(old_cpp_decl.split())

        if new_decl_normalized != old_decl_normalized:
            errors.append(f"C++ declaration mismatch for {full_type}")
            print(f"  Expected: {old_decl_normalized}")
            print(f"  Got:      {new_decl_normalized}")
        else:
            cpp_successes += 1

        # Compare accessors (they're lists in both old and new)
        new_accessors = templates[full_type]["cpp"]["accessor"]
        old_accessors = template_data["accessor"]

        if len(new_accessors) != len(old_accessors):
            errors.append(
                f"C++ accessor count mismatch for {full_type}: expected {len(old_accessors)}, got {len(new_accessors)}"
            )
            continue

        for i, (new_acc, old_acc) in enumerate(zip(new_accessors, old_accessors)):
            new_acc_normalized = " ".join(new_acc.split())
            old_acc_normalized = " ".join(old_acc.split())

            if new_acc_normalized != old_acc_normalized:
                errors.append(f"C++ accessor {i} mismatch for {full_type}")
                print(f"  Expected: {old_acc_normalized[:100]}...")
                print(f"  Got:      {new_acc_normalized[:100]}...")
            else:
                cpp_successes += 1

    print(f"C++ validation: {cpp_successes} successes")

    if errors:
        print(f"\nValidation FAILED with {len(errors)} errors:")
        for error in errors[:10]:  # Show first 10 errors
            print(f"  - {error}")
        if len(errors) > 10:
            print(f"  ... and {len(errors) - 10} more errors")
        return False
    else:
        print(f"\nValidation PASSED! All templates match.")
        return True


def compare_template_coverage():
    """
    Compare the coverage between old and new template sets.
    """

    old_fortran_keys = set(fortran_templates.keys())
    old_cpp_keys = set(cpp_templates.keys())
    new_keys = set(templates.keys())

    print("Template Coverage Analysis:")
    print(f"Original Fortran templates: {len(old_fortran_keys)}")
    print(f"Original C++ templates: {len(old_cpp_keys)}")
    print(f"New consolidated templates: {len(new_keys)}")

    missing_from_new = (old_fortran_keys | old_cpp_keys) - new_keys
    extra_in_new = new_keys - (old_fortran_keys | old_cpp_keys)

    if missing_from_new:
        print(f"\nMissing from new templates ({len(missing_from_new)}):")
        for key in sorted(missing_from_new):
            print(f"  {key}")

    if extra_in_new:
        print(f"\nExtra in new templates ({len(extra_in_new)}):")
        for key in sorted(extra_in_new):
            print(f"  {key}")

    if not missing_from_new and not extra_in_new:
        print("\nPerfect coverage match!")


if __name__ == "__main__":
    compare_template_coverage()
    validate_templates()
