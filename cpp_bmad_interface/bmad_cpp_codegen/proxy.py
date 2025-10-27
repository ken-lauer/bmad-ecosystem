from __future__ import annotations

import logging
from dataclasses import dataclass
from string import Template
from typing import TYPE_CHECKING

from bmad_cpp_codegen.interface_input_params import c_side_name_translation
from bmad_cpp_codegen.util import snake_to_camel

from .types import FullType

if TYPE_CHECKING:
    from .create_interface import CodegenStructure

logger = logging.getLogger(__name__)


@dataclass
class TypeMapping:
    fortran_type: str
    cpp_type: str


class TypeMappings:
    real = TypeMapping(
        fortran_type="real(c_double)",
        cpp_type="double",
    )
    real16 = TypeMapping(
        fortran_type="real(c_long_double)",
        cpp_type="long double",
    )
    integer = TypeMapping(
        fortran_type="integer(c_int)",
        cpp_type="int",
    )
    integer8 = TypeMapping(
        fortran_type="integer(c_long_long)",
        cpp_type="long long",
    )
    complex = TypeMapping(
        fortran_type="complex(c_double_complex)",
        cpp_type="std::complex<double>",
    )
    logical = TypeMapping(
        fortran_type="logical(c_bool)",
        cpp_type="bool",
    )
    character = TypeMapping(
        fortran_type="character",  # length handled later
        cpp_type="char",
    )
    type = TypeMapping(
        fortran_type="type",  # placeholder; actual derived type name later
        cpp_type="void*",
    )


@dataclass
class TemplateEntry:
    """Container for all code generation templates for a specific type."""

    fortran_getter: str
    fortran_setter: str | None
    cpp_get_decl: str
    cpp_get_accessors: list[str]
    cpp_set_decl: str | None
    cpp_set_accessors: list[str]


# ---------------------------------------------------------------------------
# Reusable Fortran pattern fragments - GETTERS
# ---------------------------------------------------------------------------
FORTRAN_SCALAR_GETTER = """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, value_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    FORTRANTYPE, intent(out) :: value_out
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    value_out = struct_obj%FATTRNAME
  end subroutine
"""

FORTRAN_POINTER_GETTER = """
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
"""

FORTRAN_ARRAY_1D_INFO = """
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
"""

FORTRAN_ARRAY_1D_ALLOC_INFO = """
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
"""

FORTRAN_ARRAY_1D_PTR_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
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
"""

FORTRAN_ARRAY_2D_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2)))
    dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    dim1_size = dim1_upper - dim1_lower + 1
    dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
    dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
    dim2_size = dim2_upper - dim2_lower + 1
    stride1 = 1_c_int
    stride2 = dim1_size
  end subroutine
"""

FORTRAN_ARRAY_2D_ALLOC_INFO = """
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
"""

FORTRAN_ARRAY_3D_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      dim3_size, dim3_lower, dim3_upper, &
      stride1, stride2, stride3) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: dim3_size, dim3_lower, dim3_upper
    integer(c_int), intent(out) :: stride1, stride2, stride3
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3)))
    dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    dim1_size = dim1_upper - dim1_lower + 1
    dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
    dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
    dim2_size = dim2_upper - dim2_lower + 1
    dim3_lower = int(lbound(struct_obj%FATTRNAME, 3), c_int)
    dim3_upper = int(ubound(struct_obj%FATTRNAME, 3), c_int)
    dim3_size = dim3_upper - dim3_lower + 1
    stride1 = 1_c_int
    stride2 = dim1_size
    stride3 = dim1_size * dim2_size
  end subroutine
"""

FORTRAN_ARRAY_3D_ALLOC_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      dim3_size, dim3_lower, dim3_upper, &
      stride1, stride2, stride3, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: dim3_size, dim3_lower, dim3_upper
    integer(c_int), intent(out) :: stride1, stride2, stride3
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3)))
      dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      dim3_lower = int(lbound(struct_obj%FATTRNAME, 3), c_int)
      dim3_upper = int(ubound(struct_obj%FATTRNAME, 3), c_int)
      dim3_size = dim3_upper - dim3_lower + 1
      stride1 = 1_c_int
      stride2 = dim1_size
      stride3 = dim1_size * dim2_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      dim3_size = 0_c_int; dim3_lower = 0_c_int; dim3_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int; stride3 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
"""

FORTRAN_ARRAY_3D_PTR_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      dim3_size, dim3_lower, dim3_upper, &
      stride1, stride2, stride3, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: dim3_size, dim3_lower, dim3_upper
    integer(c_int), intent(out) :: stride1, stride2, stride3
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3)))
      dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      dim3_lower = int(lbound(struct_obj%FATTRNAME, 3), c_int)
      dim3_upper = int(ubound(struct_obj%FATTRNAME, 3), c_int)
      dim3_size = dim3_upper - dim3_lower + 1
      stride1 = 1_c_int
      stride2 = dim1_size
      stride3 = dim1_size * dim2_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      dim3_size = 0_c_int; dim3_lower = 0_c_int; dim3_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int; stride3 = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
"""

# ---------------------------------------------------------------------------
# Reusable Fortran pattern fragments - SETTERS
# ---------------------------------------------------------------------------
FORTRAN_SCALAR_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, value_in) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    FORTRANTYPE, intent(in), value :: value_in
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    struct_obj%FATTRNAME = value_in
  end subroutine
"""

FORTRAN_POINTER_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, value_in) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    FORTRANTYPE, intent(in), value :: value_in
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      struct_obj%FATTRNAME = value_in
    endif
  end subroutine
"""

FORTRAN_TYPE_SCALAR_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, src_ptr) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: src_ptr
    type(STRUCTNAME), pointer :: struct_obj
    type(ATTRTYPE), pointer :: src_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    call c_f_pointer(src_ptr, src_obj)
    struct_obj%FATTRNAME = src_obj
  end subroutine
"""

FORTRAN_TYPE_POINTER_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, src_ptr) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: src_ptr
    type(STRUCTNAME), pointer :: struct_obj
    type(ATTRTYPE), pointer :: src_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (associated(struct_obj%FATTRNAME)) then
      call c_f_pointer(src_ptr, src_obj)
      struct_obj%FATTRNAME = src_obj
    endif
  end subroutine
"""

# ---------------------------------------------------------------------------
# Reusable C++ pattern fragments - GETTERS
# ---------------------------------------------------------------------------
CPP_SCALAR_DECL = "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, CTYPE* value_out);"
CPP_SCALAR_ACCESSOR = """
    CTYPE CATTRNAME() const {
        CTYPE value;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &value);
        return value;
    }
"""

CPP_POINTER_DECL = "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, CTYPE** ptr_out);"
CPP_POINTER_ACCESSOR = """
    CTYPE* CATTRNAME() const {
        CTYPE* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return ptr;
    }
"""

CPP_ARRAY_1D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        CTYPE** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound
    );
"""

CPP_ARRAY_1D_ACCESSOR = """
    FortranArray1D<CTYPE> CATTRNAME() const {
        CTYPE* data_ptr;
        int size_out, lower_bound, upper_bound;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound);
        return FortranArray1D<CTYPE>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
"""

CPP_ARRAY_1D_ALLOC_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        CTYPE** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated
    );
"""

CPP_ARRAY_1D_ALLOC_ACCESSOR = """
    FortranArray1D<CTYPE> CATTRNAME() const {
        CTYPE* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated);
        return FortranArray1D<CTYPE>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
"""

CPP_ARRAY_2D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        CTYPE** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2
    );
"""

CPP_ARRAY_2D_ACCESSOR = """
    FortranArray2D<CTYPE> CATTRNAME() const {
        CTYPE* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2);
        return FortranArray2D<CTYPE>(data_ptr,
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, true);
    }
"""

CPP_ARRAY_2D_ALLOC_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        CTYPE** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated
    );
"""

CPP_ARRAY_2D_ALLOC_ACCESSOR = """
    FortranArray2D<CTYPE> CATTRNAME() const {
        CTYPE* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated);
        return FortranArray2D<CTYPE>(data_ptr,
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, is_allocated);
    }
"""

CPP_ARRAY_3D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        CTYPE** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* dim3_size, int* dim3_lower, int* dim3_upper,
        int* stride1, int* stride2, int* stride3
    );
"""

CPP_ARRAY_3D_ACCESSOR = """
    FortranArray3D<CTYPE> CATTRNAME() const {
        CTYPE* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int dim3_size, dim3_lower, dim3_upper;
        int stride1, stride2, stride3;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &dim3_size, &dim3_lower, &dim3_upper,
            &stride1, &stride2, &stride3);
        return FortranArray3D<CTYPE>(data_ptr,
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            dim3_size, dim3_lower, dim3_upper,
            stride1, stride2, stride3, true);
    }
"""

CPP_ARRAY_3D_ALLOC_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        CTYPE** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* dim3_size, int* dim3_lower, int* dim3_upper,
        int* stride1, int* stride2, int* stride3,
        bool* is_allocated
    );
"""

CPP_ARRAY_3D_ALLOC_ACCESSOR = """
    FortranArray3D<CTYPE> CATTRNAME() const {
        CTYPE* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int dim3_size, dim3_lower, dim3_upper;
        int stride1, stride2, stride3;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &dim3_size, &dim3_lower, &dim3_upper,
            &stride1, &stride2, &stride3, &is_allocated);
        return FortranArray3D<CTYPE>(data_ptr,
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            dim3_size, dim3_lower, dim3_upper,
            stride1, stride2, stride3, is_allocated);
    }
"""

CPP_TYPE_SCALAR_DECL = "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, void** ptr_out);"
CPP_TYPE_ARRAY_1D_ALLOC_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated,
        size_t* element_size
    );
"""

CPP_SIZE_DECL = "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, int dim, int* size_out);"
CPP_SIZE_ACCESSOR = """
    int CATTRNAME(int dim = 1) const {
        int size_out;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, dim, &size_out);
        return size_out;
    }
"""

# ---------------------------------------------------------------------------
# Reusable C++ pattern fragments - SETTERS
# ---------------------------------------------------------------------------
CPP_SCALAR_SET_DECL = "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, CTYPE value_in);"
CPP_SCALAR_SET_ACCESSOR = """
    void set_CATTRNAME(CTYPE value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value);
    }
"""

CPP_POINTER_SET_DECL = "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, CTYPE value_in);"
CPP_POINTER_SET_ACCESSOR = """
    void set_CATTRNAME(CTYPE value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value);
    }
"""

CPP_TYPE_SCALAR_SET_DECL = "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, const void* src_ptr);"
CPP_TYPE_SCALAR_SET_ACCESSOR = """
    void set_CATTRNAME(const ${return_proxy_name}& src) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, src.get_fortran_ptr());
    }
"""

CPP_TYPE_POINTER_SET_DECL = "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, const void* src_ptr);"
CPP_TYPE_POINTER_SET_ACCESSOR = """
    void set_CATTRNAME(const ${return_proxy_name}& src) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, src.get_fortran_ptr());
    }
"""


def subst(s: str, **kw) -> str:
    """Substitute all upper-case keyword argument names with their respective values."""
    out = s
    for k, v in kw.items():
        out = out.replace(k.upper(), v)
    return out


def make_scalar(fortran_type: str, cpp_type: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=subst(FORTRAN_SCALAR_GETTER, fortrantype=fortran_type),
        fortran_setter=subst(FORTRAN_SCALAR_SETTER, fortrantype=fortran_type),
        cpp_get_decl=subst(CPP_SCALAR_DECL, ctype=cpp_type),
        cpp_get_accessors=[subst(CPP_SCALAR_ACCESSOR, ctype=cpp_type)],
        cpp_set_decl=subst(CPP_SCALAR_SET_DECL, ctype=cpp_type),
        cpp_set_accessors=[subst(CPP_SCALAR_SET_ACCESSOR, ctype=cpp_type)],
    )


def make_scalar_pointer(fortran_type: str, cpp_type: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=FORTRAN_POINTER_GETTER,
        fortran_setter=subst(FORTRAN_POINTER_SETTER, fortrantype=fortran_type),
        cpp_get_decl=subst(CPP_POINTER_DECL, ctype=cpp_type),
        cpp_get_accessors=[subst(CPP_POINTER_ACCESSOR, ctype=cpp_type)],
        cpp_set_decl=subst(CPP_POINTER_SET_DECL, ctype=cpp_type),
        cpp_set_accessors=[subst(CPP_POINTER_SET_ACCESSOR, ctype=cpp_type)],
    )


def make_array_1d(fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=fortran_pattern,
        fortran_setter=None,  # No setter for arrays yet
        cpp_get_decl=subst(cpp_decl, ctype=cpp_type),
        cpp_get_accessors=[subst(cpp_accessor, ctype=cpp_type)],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_array_2d(fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=fortran_pattern,
        fortran_setter=None,
        cpp_get_decl=subst(cpp_decl, ctype=cpp_type),
        cpp_get_accessors=[subst(cpp_accessor, ctype=cpp_type)],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_array_3d(fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=fortran_pattern,
        fortran_setter=None,
        cpp_get_decl=subst(cpp_decl, ctype=cpp_type),
        cpp_get_accessors=[subst(cpp_accessor, ctype=cpp_type)],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


# ---------------------------------------------------------------------------
# Build templates dictionary
# ---------------------------------------------------------------------------
templates: dict[FullType, TemplateEntry] = {}

# Scalar simple types (non complex, non character, non derived)
for tname in ["real", "real16", "integer", "integer8", "logical"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 0, "NOT")] = make_scalar(tm.fortran_type, tm.cpp_type)
    templates[FullType(tname, 0, "PTR")] = make_scalar_pointer(tm.fortran_type, tm.cpp_type)

# Complex scalar (custom accessor but same scalar getter)
templates[FullType("complex", 0, "NOT")] = TemplateEntry(
    fortran_getter=subst(FORTRAN_SCALAR_GETTER, fortrantype=TypeMappings.complex.fortran_type),
    fortran_setter=subst(FORTRAN_SCALAR_SETTER, fortrantype=TypeMappings.complex.fortran_type),
    cpp_get_decl=subst(CPP_SCALAR_DECL, ctype=TypeMappings.complex.cpp_type),
    cpp_get_accessors=[
        """
    std::complex<double> CATTRNAME() const {
        std::complex<double> c_value;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &c_value);
        return c_value;
    }
"""
    ],
    cpp_set_decl=subst(CPP_SCALAR_SET_DECL, ctype=TypeMappings.complex.cpp_type),
    cpp_set_accessors=[
        """
    void set_CATTRNAME(std::complex<double> value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value);
    }
"""
    ],
)

# Complex pointer scalar (unique declaration/accessor)
templates[FullType("complex", 0, "PTR")] = TemplateEntry(
    fortran_getter=FORTRAN_POINTER_GETTER,
    fortran_setter=subst(FORTRAN_POINTER_SETTER, fortrantype=TypeMappings.complex.fortran_type),
    cpp_get_decl="    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, double _Complex** ptr_out);",
    cpp_get_accessors=[
        """
    std::complex<double>* CATTRNAME() const {
        std::complex<double>* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return reinterpret_cast<std::complex<double>*>(ptr);
    }
"""
    ],
    cpp_set_decl="    void STRUCTNAME_set_FATTRNAME(void* struct_obj, std::complex<double> value_in);",
    cpp_set_accessors=[
        """
    void set_CATTRNAME(std::complex<double> value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value);
    }
"""
    ],
)

# Character scalar (NOT) - fixed length
FORTRAN_CHARACTER_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, str_ptr, str_len) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: str_ptr
    integer(c_int), intent(in), value :: str_len
    type(STRUCTNAME), pointer :: struct_obj
    character(len=:), pointer :: str_in
    integer :: copy_len, field_len
    call c_f_pointer(struct_obj_ptr, struct_obj)
    field_len = len(struct_obj%FATTRNAME)
    copy_len = min(str_len, field_len)
    call c_f_pointer(str_ptr, str_in)
    if (copy_len > 0) then
      struct_obj%FATTRNAME(1:copy_len) = str_in(1:copy_len)
    endif
    if (copy_len < field_len) then
      struct_obj%FATTRNAME(copy_len+1:field_len) = ' '
    endif
  end subroutine
"""

FORTRAN_CHARACTER_ALLOC_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, str_ptr, str_len) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: str_ptr
    integer(c_int), intent(in), value :: str_len
    type(STRUCTNAME), pointer :: struct_obj
    character(len=:), pointer :: str_in
    integer :: copy_len
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      deallocate(struct_obj%FATTRNAME)
    endif
    if (str_len > 0) then
      allocate(character(len=str_len) :: struct_obj%FATTRNAME)
      call c_f_pointer(str_ptr, str_in)
      struct_obj%FATTRNAME = str_in(1:str_len)
    endif
  end subroutine
"""

CPP_CHARACTER_SET_DECL = (
    "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, const char* str_ptr, int str_len);"
)
CPP_CHARACTER_SET_ACCESSOR = """
    void set_CATTRNAME(const std::string& value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value.c_str(), static_cast<int>(value.length()));
    }
"""

# Character pointer scalar (PTR) - pointer with fixed length
FORTRAN_CHARACTER_PTR_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, str_ptr, str_len) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: str_ptr
    integer(c_int), intent(in), value :: str_len
    type(STRUCTNAME), pointer :: struct_obj
    character(len=str_len), pointer :: str_in
    integer :: copy_len, field_len
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (.not. associated(struct_obj%FATTRNAME)) then
      allocate(struct_obj%FATTRNAME)
    endif
    field_len = len(struct_obj%FATTRNAME)
    copy_len = min(str_len, field_len)
    call c_f_pointer(str_ptr, str_in)
    if (copy_len > 0) then
      struct_obj%FATTRNAME(1:copy_len) = str_in(1:copy_len)
    endif
    if (copy_len < field_len) then
      struct_obj%FATTRNAME(copy_len+1:field_len) = ' '
    endif
  end subroutine
"""

CPP_CHARACTER_PTR_SET_DECL = (
    "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, const char* str_ptr, int str_len);"
)
CPP_CHARACTER_PTR_SET_ACCESSOR = """
    void set_CATTRNAME(const std::string& value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value.c_str(), static_cast<int>(value.length()));
    }
"""

# Character scalar (NOT)
templates[FullType("character", 0, "NOT")] = TemplateEntry(
    fortran_getter="""
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
    fortran_setter=FORTRAN_CHARACTER_SETTER,
    cpp_get_decl="""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound
    );
""",
    cpp_get_accessors=[
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
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound);
        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""",
    ],
    cpp_set_decl=CPP_CHARACTER_SET_DECL,
    cpp_set_accessors=[CPP_CHARACTER_SET_ACCESSOR],
)

# Character scalar (ALLOC)
templates[FullType("character", 0, "ALLOC")] = TemplateEntry(
    fortran_getter="""
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
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
    fortran_setter=FORTRAN_CHARACTER_ALLOC_SETTER,
    cpp_get_decl="""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated
    );
""",
    cpp_get_accessors=[
        """
    std::string CATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated);
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
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated);
        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""",
    ],
    cpp_set_decl=CPP_CHARACTER_SET_DECL,
    cpp_set_accessors=[CPP_CHARACTER_SET_ACCESSOR],
)

# Character pointer scalar (PTR)
templates[FullType("character", 0, "PTR")] = TemplateEntry(
    fortran_getter="""
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
    fortran_setter=FORTRAN_CHARACTER_PTR_SETTER,
    cpp_get_decl="""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        bool* is_allocated
    );
""",
    cpp_get_accessors=[
        """
    std::string CATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated);
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
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated);
        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, is_allocated);
    }
""",
    ],
    cpp_set_decl=CPP_CHARACTER_PTR_SET_DECL,
    cpp_set_accessors=[CPP_CHARACTER_PTR_SET_ACCESSOR],
)

# Character 1D NOT
templates[FullType("character", 1, "NOT")] = TemplateEntry(
    fortran_getter="""
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, str_len) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound, str_len
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
    lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    size_out = upper_bound - lower_bound + 1
    str_len = int(len(struct_obj%FATTRNAME), c_int)
  end subroutine
""",
    fortran_setter=None,
    cpp_get_decl="""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        int* str_len
    );
""",
    cpp_get_accessors=[
        """
    FortranCharArray1D CATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound, str_len;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &str_len);
        return FortranCharArray1D(data_ptr, size_out, lower_bound, upper_bound, str_len, true);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# Character 1D ALLOC
templates[FullType("character", 1, "ALLOC")] = TemplateEntry(
    fortran_getter="""
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, size_out, lower_bound, upper_bound, str_len, is_allocated) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: size_out, lower_bound, upper_bound, str_len
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      lower_bound = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      upper_bound = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      size_out = upper_bound - lower_bound + 1
      str_len = int(len(struct_obj%FATTRNAME), c_int)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      lower_bound = 0_c_int
      upper_bound = -1_c_int
      size_out = 0_c_int
      str_len = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
""",
    fortran_setter=None,
    cpp_get_decl="""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        char** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        int* str_len,
        bool* is_allocated
    );
""",
    cpp_get_accessors=[
        """
    FortranCharArray1D CATTRNAME() const {
        char* data_ptr;
        int size_out, lower_bound, upper_bound, str_len;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &str_len, &is_allocated);
        return FortranCharArray1D(data_ptr, size_out, lower_bound, upper_bound, str_len, is_allocated);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# 1D arrays (non-alloc) of real, integer
for tname in ["real", "integer"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 1, "NOT")] = make_array_1d(
        FORTRAN_ARRAY_1D_INFO,
        CPP_ARRAY_1D_DECL,
        CPP_ARRAY_1D_ACCESSOR,
        tm.cpp_type,
    )

# Complex 1D NOT (custom accessor)
templates[FullType("complex", 1, "NOT")] = TemplateEntry(
    fortran_getter=FORTRAN_ARRAY_1D_INFO,
    fortran_setter=None,
    cpp_get_decl=subst(CPP_ARRAY_1D_DECL, ctype=TypeMappings.complex.cpp_type),
    cpp_get_accessors=[
        """
    FortranArray1D<std::complex<double>> CATTRNAME() const {
        std::complex<double>* data_ptr;
        int size_out, lower_bound, upper_bound;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound);
        return FortranArray1D<std::complex<double>>(reinterpret_cast<std::complex<double>*>(data_ptr),
            size_out, lower_bound, upper_bound, true);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# 1D alloc arrays for real, integer, complex
for tname in ["real", "integer"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 1, "ALLOC")] = make_array_1d(
        FORTRAN_ARRAY_1D_ALLOC_INFO,
        CPP_ARRAY_1D_ALLOC_DECL,
        CPP_ARRAY_1D_ALLOC_ACCESSOR,
        tm.cpp_type,
    )

# Complex 1D ALLOC (custom accessor)
templates[FullType("complex", 1, "ALLOC")] = TemplateEntry(
    fortran_getter=FORTRAN_ARRAY_1D_ALLOC_INFO,
    fortran_setter=None,
    cpp_get_decl=subst(CPP_ARRAY_1D_ALLOC_DECL, ctype=TypeMappings.complex.cpp_type),
    cpp_get_accessors=[
        """
    FortranArray1D<std::complex<double>> CATTRNAME() const {
        std::complex<double>* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated);
        return FortranArray1D<std::complex<double>>(reinterpret_cast<std::complex<double>*>(data_ptr),
            size_out, lower_bound, upper_bound, is_allocated);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# 1D PTR real
templates[FullType("real", 1, "PTR")] = make_array_1d(
    FORTRAN_ARRAY_1D_PTR_INFO,
    CPP_ARRAY_1D_ALLOC_DECL,
    CPP_ARRAY_1D_ALLOC_ACCESSOR,
    TypeMappings.real.cpp_type,
)

# 2D NOT arrays for real, complex
for tname in ["real"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 2, "NOT")] = make_array_2d(
        FORTRAN_ARRAY_2D_INFO,
        CPP_ARRAY_2D_DECL,
        CPP_ARRAY_2D_ACCESSOR,
        tm.cpp_type,
    )

# Complex 2D NOT (custom accessor)
templates[FullType("complex", 2, "NOT")] = TemplateEntry(
    fortran_getter=FORTRAN_ARRAY_2D_INFO,
    fortran_setter=None,
    cpp_get_decl=subst(CPP_ARRAY_2D_DECL, ctype=TypeMappings.complex.cpp_type),
    cpp_get_accessors=[
        """
    FortranArray2D<std::complex<double>> CATTRNAME() const {
        std::complex<double>* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2);
        return FortranArray2D<std::complex<double>>(reinterpret_cast<std::complex<double>*>(data_ptr),
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            stride1, stride2, true);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# 2D alloc arrays for real & integer
for tname in ["real", "integer"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 2, "ALLOC")] = make_array_2d(
        FORTRAN_ARRAY_2D_ALLOC_INFO,
        CPP_ARRAY_2D_ALLOC_DECL,
        CPP_ARRAY_2D_ALLOC_ACCESSOR,
        tm.cpp_type,
    )

# 3D NOT arrays for complex, type
templates[FullType("complex", 3, "NOT")] = TemplateEntry(
    fortran_getter=FORTRAN_ARRAY_3D_INFO,
    fortran_setter=None,
    cpp_get_decl=subst(CPP_ARRAY_3D_DECL, ctype=TypeMappings.complex.cpp_type),
    cpp_get_accessors=[
        """
    FortranArray3D<std::complex<double>> CATTRNAME() const {
        std::complex<double>* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int dim3_size, dim3_lower, dim3_upper;
        int stride1, stride2, stride3;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &dim3_size, &dim3_lower, &dim3_upper,
            &stride1, &stride2, &stride3);
        return FortranArray3D<std::complex<double>>(reinterpret_cast<std::complex<double>*>(data_ptr),
            dim1_size, dim1_lower, dim1_upper,
            dim2_size, dim2_lower, dim2_upper,
            dim3_size, dim3_lower, dim3_upper,
            stride1, stride2, stride3, true);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# 3D PTR real
templates[FullType("real", 3, "PTR")] = make_array_3d(
    FORTRAN_ARRAY_3D_PTR_INFO,
    CPP_ARRAY_3D_ALLOC_DECL,
    CPP_ARRAY_3D_ALLOC_ACCESSOR,
    TypeMappings.real.cpp_type,
)

# Derived type scalar (NOT) - unique accessor
templates[FullType("type", 0, "NOT")] = TemplateEntry(
    fortran_getter="""
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%FATTRNAME)
  end subroutine
""",
    fortran_setter=FORTRAN_TYPE_SCALAR_SETTER,
    cpp_get_decl=CPP_TYPE_SCALAR_DECL,
    cpp_get_accessors=[
        """
    ${return_proxy_name} CATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        return ${return_proxy_name}(ptr);
    }
"""
    ],
    cpp_set_decl=CPP_TYPE_SCALAR_SET_DECL,
    cpp_set_accessors=[CPP_TYPE_SCALAR_SET_ACCESSOR],
)

# Derived type scalar pointer (PTR) - different accessor
templates[FullType("type", 0, "PTR")] = TemplateEntry(
    fortran_getter=FORTRAN_POINTER_GETTER,
    fortran_setter=FORTRAN_TYPE_POINTER_SETTER,
    cpp_get_decl=CPP_TYPE_SCALAR_DECL,
    cpp_get_accessors=[
        """
    std::optional<${return_proxy_name}> CATTRNAME() const {
        void* ptr;
        STRUCTNAME_get_FATTRNAME(fortran_ptr_, &ptr);
        if (!ptr) return std::nullopt;
        return ${return_proxy_name}(ptr);
    }
"""
    ],
    cpp_set_decl=CPP_TYPE_POINTER_SET_DECL,
    cpp_set_accessors=[CPP_TYPE_POINTER_SET_ACCESSOR],
)

# Derived type 1D NOT: element_size
templates[FullType("type", 1, "NOT")] = TemplateEntry(
    fortran_getter="""
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
    fortran_setter=None,  # Arrays skipped for now
    cpp_get_decl="""
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* size_out,
        int* lower_bound,
        int* upper_bound,
        size_t* element_size
    );
""",
    cpp_get_accessors=[
        """
    ${return_proxy_name}Array1D CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        size_t element_size;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &element_size);
        return ${return_proxy_name}Array1D(data_ptr, size_out, lower_bound, upper_bound, true, element_size);
    }
"""
    ],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# Derived type 1D PTR (associated semantics) & ALLOC (allocated semantics) share alloc decl/accessor pattern
FORTRAN_TYPE_ARRAY_1D_PTR_INFO = """
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
"""

FORTRAN_TYPE_ARRAY_1D_ALLOC_INFO = """
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
"""

CPP_TYPE_ARRAY_1D_ALLOC_ACCESSOR = """
    ${return_proxy_name}Array1D CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        size_t element_size;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size);
        return ${return_proxy_name}Array1D(data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
    }
"""

templates[FullType("type", 1, "PTR")] = TemplateEntry(
    fortran_getter=FORTRAN_TYPE_ARRAY_1D_PTR_INFO,
    fortran_setter=None,  # Arrays skipped for now
    cpp_get_decl=CPP_TYPE_ARRAY_1D_ALLOC_DECL,
    cpp_get_accessors=[CPP_TYPE_ARRAY_1D_ALLOC_ACCESSOR],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

templates[FullType("type", 1, "ALLOC")] = TemplateEntry(
    fortran_getter=FORTRAN_TYPE_ARRAY_1D_ALLOC_INFO,
    fortran_setter=None,  # Arrays skipped for now
    cpp_get_decl=CPP_TYPE_ARRAY_1D_ALLOC_DECL,
    cpp_get_accessors=[CPP_TYPE_ARRAY_1D_ALLOC_ACCESSOR],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# Derived type 2D ALLOC
FORTRAN_TYPE_ARRAY_2D_ALLOC_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      stride1, stride2, is_allocated, element_size) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: stride1, stride2
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
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
      element_size = int(storage_size(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine
"""

CPP_TYPE_ARRAY_2D_ALLOC_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* stride1, int* stride2,
        bool* is_allocated,
        size_t* element_size
    );
"""

CPP_TYPE_ARRAY_2D_ALLOC_ACCESSOR = """
    FortranTypeArray2D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int stride1, stride2;
        bool is_allocated;
        size_t element_size;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &stride1, &stride2, &is_allocated, &element_size);
        
        std::array<int, 2> sizes = {dim1_size, dim2_size};
        std::array<int, 2> lower_bounds = {dim1_lower, dim2_lower};
        std::array<int, 2> upper_bounds = {dim1_upper, dim2_upper};
        std::array<size_t, 2> strides = {static_cast<size_t>(stride1), static_cast<size_t>(stride2)};
        
        return FortranTypeArray2D<${return_proxy_name}>(data_ptr,
            sizes, lower_bounds, upper_bounds, strides,
            is_allocated, element_size);
    }
"""

templates[FullType("type", 2, "ALLOC")] = TemplateEntry(
    fortran_getter=FORTRAN_TYPE_ARRAY_2D_ALLOC_INFO,
    fortran_setter=None,
    cpp_get_decl=CPP_TYPE_ARRAY_2D_ALLOC_DECL,
    cpp_get_accessors=[CPP_TYPE_ARRAY_2D_ALLOC_ACCESSOR],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# Derived type 3D NOT
FORTRAN_TYPE_ARRAY_3D_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      dim3_size, dim3_lower, dim3_upper, &
      stride1, stride2, stride3, element_size) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: dim3_size, dim3_lower, dim3_upper
    integer(c_int), intent(out) :: stride1, stride2, stride3
    integer(c_size_t), intent(out) :: element_size
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3)))
    dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
    dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
    dim1_size = dim1_upper - dim1_lower + 1
    dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
    dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
    dim2_size = dim2_upper - dim2_lower + 1
    dim3_lower = int(lbound(struct_obj%FATTRNAME, 3), c_int)
    dim3_upper = int(ubound(struct_obj%FATTRNAME, 3), c_int)
    dim3_size = dim3_upper - dim3_lower + 1
    stride1 = 1_c_int
    stride2 = dim1_size
    stride3 = dim1_size * dim2_size
    element_size = int(storage_size(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3))) / 8, c_size_t)
  end subroutine
"""

CPP_TYPE_ARRAY_3D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* dim3_size, int* dim3_lower, int* dim3_upper,
        int* stride1, int* stride2, int* stride3,
        size_t* element_size
    );
"""

CPP_TYPE_ARRAY_3D_ACCESSOR = """
    FortranTypeArray3D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int dim3_size, dim3_lower, dim3_upper;
        int stride1, stride2, stride3;
        size_t element_size;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &dim3_size, &dim3_lower, &dim3_upper,
            &stride1, &stride2, &stride3, &element_size);
        
        std::array<int, 3> sizes = {dim1_size, dim2_size, dim3_size};
        std::array<int, 3> lower_bounds = {dim1_lower, dim2_lower, dim3_lower};
        std::array<int, 3> upper_bounds = {dim1_upper, dim2_upper, dim3_upper};
        std::array<size_t, 3> strides = {static_cast<size_t>(stride1), 
                                          static_cast<size_t>(stride2), 
                                          static_cast<size_t>(stride3)};
        
        return FortranTypeArray3D<${return_proxy_name}>(data_ptr,
            sizes, lower_bounds, upper_bounds, strides,
            true, element_size);
    }
"""

templates[FullType("type", 3, "NOT")] = TemplateEntry(
    fortran_getter=FORTRAN_TYPE_ARRAY_3D_INFO,
    fortran_setter=None,
    cpp_get_decl=CPP_TYPE_ARRAY_3D_DECL,
    cpp_get_accessors=[CPP_TYPE_ARRAY_3D_ACCESSOR],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)

# Derived type 3D ALLOC
FORTRAN_TYPE_ARRAY_3D_ALLOC_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, &
      dim1_size, dim1_lower, dim1_upper, &
      dim2_size, dim2_lower, dim2_upper, &
      dim3_size, dim3_lower, dim3_upper, &
      stride1, stride2, stride3, is_allocated, element_size) bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: dim1_size, dim1_lower, dim1_upper
    integer(c_int), intent(out) :: dim2_size, dim2_lower, dim2_upper
    integer(c_int), intent(out) :: dim3_size, dim3_lower, dim3_upper
    integer(c_int), intent(out) :: stride1, stride2, stride3
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: element_size
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    if (allocated(struct_obj%FATTRNAME)) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3)))
      dim1_lower = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      dim1_upper = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      dim1_size = dim1_upper - dim1_lower + 1
      dim2_lower = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      dim2_upper = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      dim2_size = dim2_upper - dim2_lower + 1
      dim3_lower = int(lbound(struct_obj%FATTRNAME, 3), c_int)
      dim3_upper = int(ubound(struct_obj%FATTRNAME, 3), c_int)
      dim3_size = dim3_upper - dim3_lower + 1
      stride1 = 1_c_int
      stride2 = dim1_size
      stride3 = dim1_size * dim2_size
      element_size = int(storage_size(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      dim1_size = 0_c_int; dim1_lower = 0_c_int; dim1_upper = -1_c_int
      dim2_size = 0_c_int; dim2_lower = 0_c_int; dim2_upper = -1_c_int
      dim3_size = 0_c_int; dim3_lower = 0_c_int; dim3_upper = -1_c_int
      stride1 = 0_c_int; stride2 = 0_c_int; stride3 = 0_c_int
      element_size = 0_c_size_t
      is_allocated = .false.
    endif
  end subroutine
"""

CPP_TYPE_ARRAY_3D_ALLOC_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* struct_obj,
        void** data_ptr,
        int* dim1_size, int* dim1_lower, int* dim1_upper,
        int* dim2_size, int* dim2_lower, int* dim2_upper,
        int* dim3_size, int* dim3_lower, int* dim3_upper,
        int* stride1, int* stride2, int* stride3,
        bool* is_allocated,
        size_t* element_size
    );
"""

CPP_TYPE_ARRAY_3D_ALLOC_ACCESSOR = """
    FortranTypeArray3D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int dim1_size, dim1_lower, dim1_upper;
        int dim2_size, dim2_lower, dim2_upper;
        int dim3_size, dim3_lower, dim3_upper;
        int stride1, stride2, stride3;
        bool is_allocated;
        size_t element_size;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr,
            &dim1_size, &dim1_lower, &dim1_upper,
            &dim2_size, &dim2_lower, &dim2_upper,
            &dim3_size, &dim3_lower, &dim3_upper,
            &stride1, &stride2, &stride3, &is_allocated, &element_size);
        
        std::array<int, 3> sizes = {dim1_size, dim2_size, dim3_size};
        std::array<int, 3> lower_bounds = {dim1_lower, dim2_lower, dim3_lower};
        std::array<int, 3> upper_bounds = {dim1_upper, dim2_upper, dim3_upper};
        std::array<size_t, 3> strides = {static_cast<size_t>(stride1), 
                                          static_cast<size_t>(stride2), 
                                          static_cast<size_t>(stride3)};
        
        return FortranTypeArray3D<${return_proxy_name}>(data_ptr,
            sizes, lower_bounds, upper_bounds, strides,
            is_allocated, element_size);
    }
"""

templates[FullType("type", 3, "ALLOC")] = TemplateEntry(
    fortran_getter=FORTRAN_TYPE_ARRAY_3D_ALLOC_INFO,
    fortran_setter=None,
    cpp_get_decl=CPP_TYPE_ARRAY_3D_ALLOC_DECL,
    cpp_get_accessors=[CPP_TYPE_ARRAY_3D_ALLOC_ACCESSOR],
    cpp_set_decl=None,
    cpp_set_accessors=[],
)


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


def generate_accessor_code(struct_name: str, attr_name: str, full_type: FullType, attr_kind: str = ""):
    """
    Generate Fortran and C++ accessor code for a given struct/attribute/type combination.
    """

    try:
        tpl = templates[full_type]
    except KeyError as ex:
        raise ValueError(f"Unsupported type: {full_type}") from ex

    cattr_name = c_side_name_translation.get(f"{struct_name}%{attr_name}", attr_name)

    to_replace = {"structname": struct_name, "fattrname": attr_name, "cattrname": cattr_name}
    if attr_kind:
        to_replace["attrtype"] = attr_kind

    def replace_all(s: str) -> str:
        return subst(s, **to_replace)

    return {
        "fortran_getter": replace_all(tpl.fortran_getter),
        "fortran_setter": replace_all(tpl.fortran_setter) if tpl.fortran_setter else None,
        "cpp_get_decl": replace_all(tpl.cpp_get_decl),
        "cpp_get_accessors": [replace_all(acc) for acc in tpl.cpp_get_accessors],
        "cpp_set_decl": replace_all(tpl.cpp_set_decl) if tpl.cpp_set_decl else None,
        "cpp_set_accessors": [replace_all(acc) for acc in tpl.cpp_set_accessors]
        if tpl.cpp_set_accessors
        else [],
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
    function allocate_fortran_{struct.f_name}(n, element_size) result(ptr) bind(c)
    implicit none
    integer(c_int), value :: n
    integer(c_size_t), intent(out) :: element_size
    type(c_ptr) :: ptr
    type({struct.f_name}), pointer :: fptr
    type({struct.f_name}), pointer :: fptr_array(:)

    if (n <= 0) then
        allocate(fptr)
        ptr = c_loc(fptr)
        element_size = int(storage_size(fptr) / 8, c_size_t)
    else
        allocate(fptr_array(n))
        ptr = c_loc(fptr_array)
        element_size = int(storage_size(fptr_array(1)) / 8, c_size_t)
    end if
    end function

    subroutine deallocate_fortran_{struct.f_name}(ptr, n) bind(c)
    implicit none
    type(c_ptr), value :: ptr
    integer(c_int), value :: n
    type({struct.f_name}), pointer :: fptr
    type({struct.f_name}), pointer :: fptr_array(:)

    if (c_associated(ptr)) then
        if (n <= 0) then
        call c_f_pointer(ptr, fptr)
        deallocate(fptr)
        else
        call c_f_pointer(ptr, fptr_array, [n])
        deallocate(fptr_array)
        end if
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
                acc = generate_accessor_code(struct.f_name, arg.f_name, arg.full_type, arg.kind)
            except ValueError as ex:
                print(f"  ! skipped {struct.f_name}%{arg.f_name}: {ex}", file=fout)
                continue

            print(f"  ! {struct.f_name}%{arg.f_name}: {arg.full_type}", file=fout)
            print(acc["fortran_getter"], file=fout)
            if acc["fortran_setter"]:
                print(acc["fortran_setter"], file=fout)
    print("end module", file=fout)


def get_proxy_header_and_code(
    header_template_src: str, cpp_template_src: str, structs: list[CodegenStructure]
) -> tuple[str, str]:
    c_forward_declarations = []
    subs = {}

    class_template = Template(
        """

template <>
struct FortranTraits<${class_name}> {
  static void* allocate() {
    size_t sz;
    return allocate_fortran_${struct_name}(0, &sz);
  }
  static void deallocate(void* ptr) noexcept {
    deallocate_fortran_${struct_name}(ptr, 0);
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
                acc = generate_accessor_code(struct.f_name, arg.f_name, arg.full_type, arg.kind)
            except ValueError as ex:
                logging.warning(f"Proxy class {struct.f_name}%{arg.f_name} skipped: {ex}")
                continue

            # Add getter declarations
            c_forward_declarations.append(acc["cpp_get_decl"])

            # Add getter accessors
            for accessor_body in acc["cpp_get_accessors"]:
                if arg.full_type.type == "type":
                    accessor_body = Template(accessor_body).substitute(
                        return_proxy_name=struct_to_proxy_class_name(arg.kind)
                    )
                sig, impl = split_signature(accessor_body, proxy_class_name)
                all_impl.append(impl)
                class_body.append(f"{sig} // {arg.full_type}")

            # Add setter declarations and accessors
            if acc["cpp_set_decl"]:
                c_forward_declarations.append(acc["cpp_set_decl"])

                for accessor_body in acc["cpp_set_accessors"]:
                    if arg.full_type.type == "type":
                        accessor_body = Template(accessor_body).substitute(
                            return_proxy_name=struct_to_proxy_class_name(arg.kind)
                        )
                    sig, impl = split_signature(accessor_body, proxy_class_name)
                    all_impl.append(impl)
                    class_body.append(sig)

        subs[f"{struct.f_name}_class_body"] = "\n".join(class_body)
        classes[struct.f_name] = class_body

    class_forward_declarations = []
    proxy_classes = []

    class_forward_declarations.append('extern "C" {')
    for struct_name in classes:
        class_forward_declarations.append(f"""
  void* allocate_fortran_{struct_name}(int n, size_t *element_size);
  void deallocate_fortran_{struct_name}(void* ptr, int n) noexcept;
  void copy_fortran_{struct_name}(const void* src, void* dst);
  """)

    class_forward_declarations.append("}")

    for struct_name, class_body in classes.items():
        class_name = struct_to_proxy_class_name(struct_name)
        class_forward_declarations.append(f"class {class_name};")
        class_forward_declarations.append(f"""
using {class_name}Array1D = FortranTypeArray1D<
    {class_name},
    allocate_fortran_{struct_name},
    deallocate_fortran_{struct_name}
>;
        """)
        proxy_classes.append(
            class_template.substitute(
                struct_name=struct_name,
                class_name=struct_to_proxy_class_name(struct_name),
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
