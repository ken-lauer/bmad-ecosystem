from __future__ import annotations

import logging
from dataclasses import dataclass
from string import Template
from typing import TYPE_CHECKING

from bmad_cpp_codegen.interface_input_params import c_side_name_translation
from bmad_cpp_codegen.util import snake_to_camel

from .types import ArgumentType, FullType, PointerType

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
        fortran_type="character",
        cpp_type="char",
    )
    type = TypeMapping(
        fortran_type="type",
        cpp_type="void*",
    )


@dataclass
class TemplateEntry:
    fortran_getter: str
    fortran_setter: str | None
    cpp_get_decl: str
    cpp_get_accessors: list[str]
    cpp_set_decl: str | None
    cpp_set_accessors: list[str]


# ---------------------------------------------------------------------------
# Fortran pattern fragments - GETTERS
# grouping array bounds into array arguments
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

# Note: We use is_allocated for both allocated() and associated() checks via logic inside the sub
FORTRAN_ARRAY_1D_ALL_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, is_allocated) &
        bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(2), intent(out) :: bounds ! 1:lower, 2:upper
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      bounds = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
"""

FORTRAN_ARRAY_2D_ALL_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, strides, is_allocated) &
        bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(4), intent(out) :: bounds ! 1:dim1L, 2:dim1U, 3:dim2L, 4:dim2U
    integer(c_int), dimension(2), intent(out) :: strides
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    integer :: d1_size
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2)))
      bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      bounds(3) = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      bounds(4) = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      
      d1_size = bounds(2) - bounds(1) + 1
      strides(1) = 1_c_int
      strides(2) = d1_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      bounds = 0_c_int; strides = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
"""

FORTRAN_ARRAY_3D_ALL_INFO = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, strides, is_allocated) &
      bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(6), intent(out) :: bounds
    integer(c_int), dimension(3), intent(out) :: strides
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    integer :: d1_size, d2_size
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME( &
        lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2), lbound(struct_obj%FATTRNAME,3)))
        
      bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      bounds(3) = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      bounds(4) = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      bounds(5) = int(lbound(struct_obj%FATTRNAME, 3), c_int)
      bounds(6) = int(ubound(struct_obj%FATTRNAME, 3), c_int)
      
      d1_size = bounds(2) - bounds(1) + 1
      d2_size = bounds(4) - bounds(3) + 1
      strides(1) = 1_c_int
      strides(2) = d1_size
      strides(3) = d1_size * d2_size
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      bounds = 0_c_int; strides = 0_c_int
      is_allocated = .false.
    endif
  end subroutine
"""

# ---------------------------------------------------------------------------
# Reusable C++ pattern fragments - GETTERS (Using BmadProxyHelpers)
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

# C++ declarations always pass array pointers for bounds now
CPP_ARRAY_1D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(const void* s, CTYPE** d, int* bounds, bool* is_alloc);
"""
CPP_ARRAY_1D_ACCESSOR = """
    FortranArray1D<CTYPE> CATTRNAME() const {
        return BmadProxyHelpers::get_array_1d<CTYPE>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""

CPP_ARRAY_2D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(const void* s, CTYPE** d, int* bounds, int* strides, bool* is_alloc);
"""
CPP_ARRAY_2D_ACCESSOR = """
    FortranArray2D<CTYPE> CATTRNAME() const {
        return BmadProxyHelpers::get_array_2d<CTYPE>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""

CPP_ARRAY_3D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(const void* s, CTYPE** d, int* bounds, int* strides, bool* is_alloc);
"""
CPP_ARRAY_3D_ACCESSOR = """
    FortranArray3D<CTYPE> CATTRNAME() const {
        return BmadProxyHelpers::get_array_3d<CTYPE>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""

CPP_TYPE_SCALAR_DECL = "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, void** ptr_out);"

CPP_TYPE_ARRAY_1D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* s, 
        void** d, 
        int* bounds, 
        bool* is_alloc, 
        size_t* el_size
    );
"""
CPP_TYPE_ARRAY_1D_ACCESSOR = """
    ${return_proxy_name}Array1D CATTRNAME() const {
        return BmadProxyHelpers::get_type_array_1d<${return_proxy_name}Array1D>(
            fortran_ptr_, 
            STRUCTNAME_get_FATTRNAME_info
        );
    }
"""

CPP_TYPE_ARRAY_2D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* s, void** d, int* bounds, int* strides, bool* a, size_t* es
    );
"""

CPP_TYPE_ARRAY_2D_ACCESSOR = """
    ${return_proxy_name}Array2D CATTRNAME() const {
        return BmadProxyHelpers::get_type_array_2d<${return_proxy_name}Array2D>(
            fortran_ptr_, 
            STRUCTNAME_get_FATTRNAME_info
        );
    }
"""

CPP_TYPE_ARRAY_3D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
         const void* s, void** d, int* bounds, int* strides, bool* a, size_t* es
    );
"""

CPP_TYPE_ARRAY_3D_ACCESSOR = """
    ${return_proxy_name}Array3D CATTRNAME() const {
        return BmadProxyHelpers::get_type_array_3d<${return_proxy_name}Array3D>(
            fortran_ptr_, 
            STRUCTNAME_get_FATTRNAME_info
        );
    }
"""

# ---------------------------------------------------------------------------
# Reusable Fortran/C++ pattern fragments - SETTERS
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

CPP_SCALAR_SET_DECL = "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, CTYPE value_in);"
CPP_SCALAR_SET_ACCESSOR = """
    void set_CATTRNAME(CTYPE value) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, value);
    }
"""
CPP_POINTER_SET_DECL = CPP_SCALAR_SET_DECL
CPP_POINTER_SET_ACCESSOR = CPP_SCALAR_SET_ACCESSOR

CPP_TYPE_SCALAR_SET_DECL = "    void STRUCTNAME_set_FATTRNAME(void* struct_obj, const void* src_ptr);"
CPP_TYPE_SCALAR_SET_ACCESSOR = """
    void set_CATTRNAME(const ${return_proxy_name}& src) {
        STRUCTNAME_set_FATTRNAME(fortran_ptr_, src.get_fortran_ptr());
    }
"""
CPP_TYPE_POINTER_SET_DECL = CPP_TYPE_SCALAR_SET_DECL
CPP_TYPE_POINTER_SET_ACCESSOR = CPP_TYPE_SCALAR_SET_ACCESSOR


# ---------------------------------------------------------------------------
# Character scalars / Array 1D
# ---------------------------------------------------------------------------

FORTRAN_CHAR_SCALAR_DYN_GETTER = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, str_len, is_allocated) &
    bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), intent(out) :: str_len
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME)
      ! Use 'len' for full length including spaces, or 'len_trim' if preferred.
      ! usually for allocatables, 'len' is the desired exact memory size.
      str_len = int(len(struct_obj%FATTRNAME), c_int)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      str_len = 0
      is_allocated = .false.
    endif
  end subroutine
"""

FORTRAN_CHAR_ALLOC_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, str_ptr, str_len) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: str_ptr
    integer(c_int), intent(in), value :: str_len
    type(STRUCTNAME), pointer :: struct_obj
    character(len=str_len), pointer :: temp_str
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (allocated(struct_obj%FATTRNAME)) deallocate(struct_obj%FATTRNAME)
    
    if (str_len > 0) then
       call c_f_pointer(str_ptr, temp_str)
       allocate(struct_obj%FATTRNAME, source=temp_str)
       struct_obj%FATTRNAME = temp_str(1:str_len)
    endif
  end subroutine
"""
FORTRAN_CHAR_PTR_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, str_ptr, str_len) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: str_ptr
    integer(c_int), intent(in), value :: str_len
    type(STRUCTNAME), pointer :: struct_obj
    character(len=str_len), pointer :: temp_str
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (associated(struct_obj%FATTRNAME)) deallocate(struct_obj%FATTRNAME)
    
    if (str_len > 0) then
        call c_f_pointer(str_ptr, temp_str)
        allocate(struct_obj%FATTRNAME, source=temp_str)
    else
        nullify(struct_obj%FATTRNAME)
    endif
  end subroutine
"""
# Standard Fortran Pattern for Char Array 1D (handles PTR, ALLOC, and standard arrays)
FORTRAN_CHAR_ARRAY_1D_ALL = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, str_len, is_allocated) &
      bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(2), intent(out) :: bounds
    integer(c_int), intent(out) :: str_len
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
      bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      str_len = int(len(struct_obj%FATTRNAME), c_int)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr
      bounds = 0
      str_len = 0
      is_allocated = .false.
    endif
  end subroutine
"""

CPP_CHAR_SCALAR_DYN_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* s, 
        char** d, 
        int* len, 
        bool* is_alloc
    );
"""

CPP_CHAR_SCALAR_DYN_ACCESSOR = """
    std::string CATTRNAME() const {
        return BmadProxyHelpers::get_string(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""
CPP_CHAR_ARRAY_1D_DECL = """
    void STRUCTNAME_get_FATTRNAME_info(
        const void* s, 
        char** d, 
        int* bounds,    // [lower, upper]
        int* str_len, 
        bool* is_alloc
    );
"""

CPP_CHAR_ARRAY_1D_ACCESSOR = """
    FortranCharArray1D CATTRNAME() const {
        return BmadProxyHelpers::get_char_array_1d(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""


def subst(s: str, **kw) -> str:
    out = s
    for k, v in kw.items():
        out = out.replace(k.upper(), v)
    return out


# ---------------------------------------------------------------------------
# Structure/Proxy Name Helpers
# ---------------------------------------------------------------------------
def struct_to_proxy_class_name(name: str) -> str:
    return snake_to_camel(name.removesuffix("_struct") + "_proxy")


# ---------------------------------------------------------------------------
# Template Makers
# ---------------------------------------------------------------------------
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


def get_condition(logic_type: str) -> str:
    if logic_type == "NOT":
        return ".true."
    if logic_type == "ALLOC":
        return "allocated(struct_obj%FATTRNAME)"
    if logic_type == "PTR":
        return "associated(struct_obj%FATTRNAME)"
    raise ValueError(f"Unknown logic_type: {logic_type}")


def make_char_array_1d(ptr_type: PointerType) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=subst(FORTRAN_CHAR_ARRAY_1D_ALL, condition=get_condition(ptr_type)),
        fortran_setter=None,
        cpp_get_decl=CPP_CHAR_ARRAY_1D_DECL,
        cpp_get_accessors=[CPP_CHAR_ARRAY_1D_ACCESSOR],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_array_1d(
    fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str, ptr_type: str
) -> TemplateEntry:
    """ptr_type is either '.true.' (passed-through for non-alloc), 'allocated(...)', or 'associated(...)'"""
    return TemplateEntry(
        fortran_getter=subst(fortran_pattern, condition=get_condition(ptr_type)),
        fortran_setter=None,
        cpp_get_decl=subst(cpp_decl, ctype=cpp_type),
        cpp_get_accessors=[subst(cpp_accessor, ctype=cpp_type)],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_array_2d(
    fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str, ptr_type: str
) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=subst(fortran_pattern, condition=get_condition(ptr_type)),
        fortran_setter=None,
        cpp_get_decl=subst(cpp_decl, ctype=cpp_type),
        cpp_get_accessors=[subst(cpp_accessor, ctype=cpp_type)],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_array_3d(
    fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str, ptr_type: str
) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=subst(fortran_pattern, condition=get_condition(ptr_type)),
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

# Scalar simple types
_simple_types: list[ArgumentType] = ["real", "real16", "integer", "integer8", "logical"]
for tname in _simple_types:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 0, "NOT")] = make_scalar(tm.fortran_type, tm.cpp_type)
    templates[FullType(tname, 0, "PTR")] = make_scalar_pointer(tm.fortran_type, tm.cpp_type)

# Complex Scalar (custom accessors needed)
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

# Complex Pointer scalar
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

# ---------------------------------------------------------------------------
# Simplified Character Handling (Direct Assignment when NOT alloc/ptr)
# ---------------------------------------------------------------------------
FORTRAN_CHARACTER_SIMPLE_SETTER = """
  subroutine STRUCTNAME_set_FATTRNAME(struct_obj_ptr, str_ptr, str_len) bind(c, name='STRUCTNAME_set_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(in), value :: str_ptr
    integer(c_int), intent(in), value :: str_len
    type(STRUCTNAME), pointer :: struct_obj
    character(len=str_len), pointer :: str_in
    call c_f_pointer(struct_obj_ptr, struct_obj)
    call c_f_pointer(str_ptr, str_in)
    struct_obj%FATTRNAME = str_in ! implicitly handles padding
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

# Character scalar (NOT)
templates[FullType("character", 0, "NOT")] = TemplateEntry(
    # Note: Getter remains complex because it handles dynamic lengths of the Fortran string
    fortran_getter="""
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, is_allocated) &
    bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(2), intent(out) :: bounds
    logical(c_bool), intent(out) :: is_allocated
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    data_ptr = c_loc(struct_obj%FATTRNAME)
    bounds(1) = 1_c_int
    bounds(2) = int(len_trim(struct_obj%FATTRNAME), c_int)
    is_allocated = .true.
  end subroutine
""",
    fortran_setter=FORTRAN_CHARACTER_SIMPLE_SETTER,
    cpp_get_decl="void STRUCTNAME_get_FATTRNAME_info(const void* s, char** d, int* bounds, bool* a);",
    cpp_get_accessors=[
        """
    std::string CATTRNAME() const {
        FortranArray1D<char> arr = BmadProxyHelpers::get_array_1d<char>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
        return std::string(arr.data(), arr.size());
    }
"""
    ],
    cpp_set_decl=CPP_CHARACTER_SET_DECL,
    cpp_set_accessors=[CPP_CHARACTER_SET_ACCESSOR],
)


def make_char_scalar_dyn(ptr_type: str, setter_pattern: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=subst(FORTRAN_CHAR_SCALAR_DYN_GETTER, condition=get_condition(ptr_type)),
        fortran_setter=setter_pattern,
        cpp_get_decl=CPP_CHAR_SCALAR_DYN_DECL,
        cpp_get_accessors=[CPP_CHAR_SCALAR_DYN_ACCESSOR],
        cpp_set_decl=CPP_CHARACTER_SET_DECL,  # Reused from previous steps
        cpp_set_accessors=[CPP_CHARACTER_SET_ACCESSOR],  # Reused
    )


# 4. Register Templates
templates[FullType("character", 0, "ALLOC")] = make_char_scalar_dyn("ALLOC", FORTRAN_CHAR_ALLOC_SETTER)
templates[FullType("character", 0, "PTR")] = make_char_scalar_dyn("PTR", FORTRAN_CHAR_PTR_SETTER)

# Arrays 1D / 2D / 3D (Real + Integer)
real_and_integer_types: list[ArgumentType] = ["real", "integer"]
for tname in real_and_integer_types:
    tm = getattr(TypeMappings, tname)

    # 1D
    templates[FullType(tname, 1, "NOT")] = make_array_1d(
        FORTRAN_ARRAY_1D_ALL_INFO, CPP_ARRAY_1D_DECL, CPP_ARRAY_1D_ACCESSOR, tm.cpp_type, ptr_type="NOT"
    )
    templates[FullType(tname, 1, "ALLOC")] = make_array_1d(
        FORTRAN_ARRAY_1D_ALL_INFO,
        CPP_ARRAY_1D_DECL,
        CPP_ARRAY_1D_ACCESSOR,
        tm.cpp_type,
        ptr_type="ALLOC",
    )
    templates[FullType(tname, 1, "PTR")] = make_array_1d(
        FORTRAN_ARRAY_1D_ALL_INFO,
        CPP_ARRAY_1D_DECL,
        CPP_ARRAY_1D_ACCESSOR,
        tm.cpp_type,
        ptr_type="PTR",
    )

    # 2D
    if tname == "real":  # Only real 2D NOT defined previously
        templates[FullType(tname, 2, "NOT")] = make_array_2d(
            FORTRAN_ARRAY_2D_ALL_INFO,
            CPP_ARRAY_2D_DECL,
            CPP_ARRAY_2D_ACCESSOR,
            tm.cpp_type,
            ptr_type="NOT",
        )
    templates[FullType(tname, 2, "ALLOC")] = make_array_2d(
        FORTRAN_ARRAY_2D_ALL_INFO,
        CPP_ARRAY_2D_DECL,
        CPP_ARRAY_2D_ACCESSOR,
        tm.cpp_type,
        ptr_type="ALLOC",
    )

    # 3D (Pointer)
    templates[FullType(tname, 3, "PTR")] = make_array_3d(
        FORTRAN_ARRAY_3D_ALL_INFO,
        CPP_ARRAY_3D_DECL,
        CPP_ARRAY_3D_ACCESSOR,
        tm.cpp_type,
        ptr_type="PTR",
    )

# Complex arrays (custom accessor because cast needed on helper result)
COMPLEX_1D_ACCESSOR = """
     FortranArray1D<std::complex<double>> CATTRNAME() const {
        // Complex needs explicit cast handling if not using void*,
        // but the standard helper works if we declare get_..._info as taking complex*
        return BmadProxyHelpers::get_array_1d<std::complex<double>>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
     }
"""

# Actually, checking our templates, TypeMapping.complex.cpp_type is std::complex.
# The C routines take std::complex<double>**. The helper deduces <T> as std::complex<double>.
# The helper should work directly without custom casting logic if signatures match.
templates[FullType("complex", 1, "NOT")] = make_array_1d(
    FORTRAN_ARRAY_1D_ALL_INFO,
    CPP_ARRAY_1D_DECL,
    CPP_ARRAY_1D_ACCESSOR,
    TypeMappings.complex.cpp_type,
    "NOT",
)
templates[FullType("complex", 1, "ALLOC")] = make_array_1d(
    FORTRAN_ARRAY_1D_ALL_INFO,
    CPP_ARRAY_1D_DECL,
    CPP_ARRAY_1D_ACCESSOR,
    TypeMappings.complex.cpp_type,
    "ALLOC",
)
templates[FullType("complex", 2, "NOT")] = make_array_2d(
    FORTRAN_ARRAY_2D_ALL_INFO,
    CPP_ARRAY_2D_DECL,
    CPP_ARRAY_2D_ACCESSOR,
    TypeMappings.complex.cpp_type,
    "NOT",
)
templates[FullType("complex", 3, "NOT")] = make_array_3d(
    FORTRAN_ARRAY_3D_ALL_INFO,
    CPP_ARRAY_3D_DECL,
    CPP_ARRAY_3D_ACCESSOR,
    TypeMappings.complex.cpp_type,
    "NOT",
)


# ---------------------------------------------------------------------------
# Derived Types
# ---------------------------------------------------------------------------

# Type Scalar (NOT)
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

# Type Scalar (PTR) - Returns Optional
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

# Type Array 1D (NOT/PTR/ALLOC)
# Requires element_size handling, slightly different than standard helpers
FORTRAN_TYPE_ARRAY_1D_ALL = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, is_allocated, el_size) &
      bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(2), intent(out) :: bounds
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: el_size
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
        data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME, 1)))
        bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
        bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
        ! storage_size returns bits, divide by 8
        el_size = int(storage_size(struct_obj%FATTRNAME(bounds(1))) / 8, c_size_t)
        is_allocated = .true.
    else
        data_ptr = c_null_ptr
        bounds = 0
        el_size = 0
        is_allocated = .false.
    endif
  end subroutine
"""

FORTRAN_TYPE_ARRAY_2D_ALL = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, strides, is_allocated, el_size) &
    bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(4), intent(out) :: bounds
    integer(c_int), dimension(2), intent(out) :: strides
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: el_size
    type(STRUCTNAME), pointer :: struct_obj
    integer :: d1, d2
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME(lbound(struct_obj%FATTRNAME,1), lbound(struct_obj%FATTRNAME,2)))
      bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      bounds(3) = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      bounds(4) = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      
      d1 = bounds(2) - bounds(1) + 1
      strides(1) = 1_c_int
      strides(2) = d1
      el_size = int(storage_size(struct_obj%FATTRNAME(bounds(1), bounds(3))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr; bounds = 0; strides = 0; el_size = 0
      is_allocated = .false.
    endif
  end subroutine
"""

# Fortran 3D Pattern
FORTRAN_TYPE_ARRAY_3D_ALL = """
  subroutine STRUCTNAME_get_FATTRNAME_info(struct_obj_ptr, data_ptr, bounds, strides, is_allocated, el_size) &
    bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: data_ptr
    integer(c_int), dimension(6), intent(out) :: bounds
    integer(c_int), dimension(3), intent(out) :: strides
    logical(c_bool), intent(out) :: is_allocated
    integer(c_size_t), intent(out) :: el_size
    type(STRUCTNAME), pointer :: struct_obj
    integer :: d1, d2
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if (CONDITION) then
      data_ptr = c_loc(struct_obj%FATTRNAME( &
        lbound(struct_obj%FATTRNAME,1), &
        lbound(struct_obj%FATTRNAME,2), &
        lbound(struct_obj%FATTRNAME,3)  &
      ))
      bounds(1) = int(lbound(struct_obj%FATTRNAME, 1), c_int)
      bounds(2) = int(ubound(struct_obj%FATTRNAME, 1), c_int)
      bounds(3) = int(lbound(struct_obj%FATTRNAME, 2), c_int)
      bounds(4) = int(ubound(struct_obj%FATTRNAME, 2), c_int)
      bounds(5) = int(lbound(struct_obj%FATTRNAME, 3), c_int)
      bounds(6) = int(ubound(struct_obj%FATTRNAME, 3), c_int)
      
      d1 = bounds(2) - bounds(1) + 1
      d2 = bounds(4) - bounds(3) + 1
      strides(1) = 1_c_int
      strides(2) = d1
      strides(3) = d1 * d2
      el_size = int(storage_size(struct_obj%FATTRNAME(bounds(1), bounds(3), bounds(5))) / 8, c_size_t)
      is_allocated = .true.
    else
      data_ptr = c_null_ptr; bounds = 0; strides = 0; el_size = 0
      is_allocated = .false.
    endif
  end subroutine
"""


def make_type_array_1d(ptr_type: str):
    return TemplateEntry(
        fortran_getter=subst(FORTRAN_TYPE_ARRAY_1D_ALL, condition=get_condition(ptr_type)),
        fortran_setter=None,
        cpp_get_decl=CPP_TYPE_ARRAY_1D_DECL,
        cpp_get_accessors=[CPP_TYPE_ARRAY_1D_ACCESSOR],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_type_array_2d(ptr_type: str):
    return TemplateEntry(
        fortran_getter=subst(FORTRAN_TYPE_ARRAY_2D_ALL, condition=get_condition(ptr_type)),
        fortran_setter=None,
        cpp_get_decl=CPP_TYPE_ARRAY_2D_DECL,
        cpp_get_accessors=[CPP_TYPE_ARRAY_2D_ACCESSOR],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_type_array_3d(ptr_type: str):
    return TemplateEntry(
        fortran_getter=subst(FORTRAN_TYPE_ARRAY_3D_ALL, condition=get_condition(ptr_type)),
        fortran_setter=None,
        cpp_get_decl=CPP_TYPE_ARRAY_3D_DECL,
        cpp_get_accessors=[CPP_TYPE_ARRAY_3D_ACCESSOR],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


templates[FullType("type", 1, "NOT")] = make_type_array_1d("NOT")
templates[FullType("type", 1, "PTR")] = make_type_array_1d("PTR")
templates[FullType("type", 1, "ALLOC")] = make_type_array_1d("ALLOC")
templates[FullType("type", 2, "NOT")] = make_type_array_2d("NOT")
templates[FullType("type", 2, "ALLOC")] = make_type_array_2d("ALLOC")
templates[FullType("type", 3, "NOT")] = make_type_array_3d("NOT")
templates[FullType("type", 3, "ALLOC")] = make_type_array_3d("ALLOC")

# Character 1D NOT (Standard fixed size array)
templates[FullType("character", 1, "NOT")] = make_char_array_1d("NOT")

# Character 1D ALLOC (Allocatable array)
templates[FullType("character", 1, "ALLOC")] = make_char_array_1d("ALLOC")

# Character 1D PTR (Pointer array) - TODO?
# templates[FullType("character", 1, "PTR")] = make_char_array_1d("associated")
#
# Remaining Code Generation Functions (struct_to_proxy_class_name, split_signature, etc.)
# continue from here same as original file...


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
using {class_name}Array2D = FortranTypeArray2D<{class_name}>;
using {class_name}Array3D = FortranTypeArray3D<{class_name}>;
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
