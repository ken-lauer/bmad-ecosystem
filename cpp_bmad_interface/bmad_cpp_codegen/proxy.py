from __future__ import annotations

import logging
from collections import namedtuple
from string import Template
from typing import TYPE_CHECKING, Any

from bmad_cpp_codegen.interface_input_params import c_side_name_translation
from bmad_cpp_codegen.util import snake_to_camel

from .types import FullType

if TYPE_CHECKING:
    from .create_interface import CodegenStructure

logger = logging.getLogger(__name__)


TypeMapping = namedtuple("TypeMapping", ["fortran_type", "cpp_type"])


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


# ---------------------------------------------------------------------------
# Reusable (multi-use) Fortran pattern fragments
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


# ---------------------------------------------------------------------------
# Reusable (multi-use) C++ pattern fragments
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
# Helpers that perform simple substitutions
# ---------------------------------------------------------------------------
def subst(s: str, **kw) -> str:
    out = s
    for k, v in kw.items():
        out = out.replace(k.upper(), v)
    return out


def make_scalar(fortran_type: str, cpp_type: str):
    return {
        "fortran": {"getter": subst(FORTRAN_SCALAR_GETTER, fortrantype=fortran_type)},
        "cpp": {
            "declaration": subst(CPP_SCALAR_DECL, ctype=cpp_type),
            "accessor": [subst(CPP_SCALAR_ACCESSOR, ctype=cpp_type)],
        },
    }


def make_scalar_pointer(cpp_type: str):
    return {
        "fortran": {"getter": FORTRAN_POINTER_GETTER},
        "cpp": {
            "declaration": subst(CPP_POINTER_DECL, ctype=cpp_type),
            "accessor": [subst(CPP_POINTER_ACCESSOR, ctype=cpp_type)],
        },
    }


def make_array_1d(fortran_pattern: str, cpp_decl: str, cpp_accessor: str, cpp_type: str):
    return {
        "fortran": {"getter": fortran_pattern},
        "cpp": {
            "declaration": subst(cpp_decl, ctype=cpp_type),
            "accessor": [subst(cpp_accessor, ctype=cpp_type)],
        },
    }


def make_array_2d_alloc(cpp_type: str):
    return {
        "fortran": {"getter": FORTRAN_ARRAY_2D_ALLOC_INFO},
        "cpp": {
            "declaration": subst(CPP_ARRAY_2D_ALLOC_DECL, ctype=cpp_type),
            "accessor": [subst(CPP_ARRAY_2D_ALLOC_ACCESSOR, ctype=cpp_type)],
        },
    }


# ---------------------------------------------------------------------------
# Build templates dictionary
# ---------------------------------------------------------------------------
templates: dict[FullType, dict[str, Any]] = {}

# Scalar simple types (non complex, non character, non derived)
for tname in ["real", "real16", "integer", "integer8", "logical"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 0, "NOT")] = make_scalar(tm.fortran_type, tm.cpp_type)
    templates[FullType(tname, 0, "PTR")] = make_scalar_pointer(tm.cpp_type)

# Complex scalar (custom accessor but same scalar getter)
templates[FullType("complex", 0, "NOT")] = {
    "fortran": {"getter": subst(FORTRAN_SCALAR_GETTER, fortrantype=TypeMappings.complex.fortran_type)},
    "cpp": {
        "declaration": subst(CPP_SCALAR_DECL, ctype=TypeMappings.complex.cpp_type),
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
}
# Complex pointer scalar (unique declaration/accessor)
templates[FullType("complex", 0, "PTR")] = {
    "fortran": {"getter": FORTRAN_POINTER_GETTER},
    "cpp": {
        "declaration": "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, double _Complex** ptr_out);",
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
}

# Character scalar (NOT)
templates[FullType("character", 0, "NOT")] = {
    "fortran": {
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
"""
    },
    "cpp": {
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
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound);
        return FortranArray1D<char>(data_ptr, size_out, lower_bound, upper_bound, true);
    }
""",
        ],
    },
}

# Character pointer scalar (PTR)
templates[FullType("character", 0, "PTR")] = {
    "fortran": {
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
"""
    },
    "cpp": {
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
    },
}

# 1D arrays (non-alloc) of real, complex, integer
for tname in ["real", "complex", "integer"]:
    tm = getattr(TypeMappings, tname)
    if tname == "complex":
        # special accessor for complex array
        templates[FullType("complex", 1, "NOT")] = {
            "fortran": {"getter": FORTRAN_ARRAY_1D_INFO},
            "cpp": {
                "declaration": subst(CPP_ARRAY_1D_DECL, ctype=tm.cpp_type),
                "accessor": [
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
            },
        }
    else:
        templates[FullType(tname, 1, "NOT")] = make_array_1d(
            FORTRAN_ARRAY_1D_INFO,
            CPP_ARRAY_1D_DECL,
            CPP_ARRAY_1D_ACCESSOR,
            tm.cpp_type,
        )

# 1D alloc arrays for real & integer
for tname in ["real", "integer"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 1, "ALLOC")] = make_array_1d(
        FORTRAN_ARRAY_1D_ALLOC_INFO,
        CPP_ARRAY_1D_ALLOC_DECL,
        CPP_ARRAY_1D_ALLOC_ACCESSOR,
        tm.cpp_type,
    )

# 2D alloc arrays for real & integer
for tname in ["real", "integer"]:
    tm = getattr(TypeMappings, tname)
    templates[FullType(tname, 2, "ALLOC")] = make_array_2d_alloc(tm.cpp_type)

# Derived type scalar (NOT) - unique accessor
templates[FullType("type", 0, "NOT")] = {
    "fortran": {
        "getter": """
  subroutine STRUCTNAME_get_FATTRNAME(struct_obj_ptr, ptr_out) bind(c, name='STRUCTNAME_get_FATTRNAME')
    type(c_ptr), intent(in), value :: struct_obj_ptr
    type(c_ptr), intent(out) :: ptr_out
    type(STRUCTNAME), pointer :: struct_obj
    call c_f_pointer(struct_obj_ptr, struct_obj)
    ptr_out = c_loc(struct_obj%FATTRNAME)
  end subroutine
"""
    },
    "cpp": {
        "declaration": CPP_TYPE_SCALAR_DECL,
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
}

# Derived type scalar pointer (PTR) - different accessor
templates[FullType("type", 0, "PTR")] = {
    "fortran": {"getter": FORTRAN_POINTER_GETTER},
    "cpp": {
        "declaration": CPP_TYPE_SCALAR_DECL,
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
}

# Derived type 1D NOT: element_size
templates[FullType("type", 1, "NOT")] = {
    "fortran": {
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
"""
    },
    "cpp": {
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
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &element_size);
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, true, element_size);
    }
"""
        ],
    },
}

# Derived type 1D PTR (associated semantics) & ALLOC (allocated semantics) share alloc decl/accessor pattern
# We inline two different Fortran getters but reuse C++ alloc declaration/accessor.
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
    FortranTypeArray1D<${return_proxy_name}> CATTRNAME() const {
        void* data_ptr;
        int size_out, lower_bound, upper_bound;
        bool is_allocated;
        size_t element_size;
        STRUCTNAME_get_FATTRNAME_info(fortran_ptr_, &data_ptr, &size_out, &lower_bound, &upper_bound, &is_allocated, &element_size);
        return FortranTypeArray1D<${return_proxy_name}>(data_ptr, size_out, lower_bound, upper_bound, is_allocated, element_size);
    }
"""

templates[FullType("type", 1, "PTR")] = {
    "fortran": {"getter": FORTRAN_TYPE_ARRAY_1D_PTR_INFO},
    "cpp": {
        "declaration": CPP_TYPE_ARRAY_1D_ALLOC_DECL,
        "accessor": [CPP_TYPE_ARRAY_1D_ALLOC_ACCESSOR],
    },
}
templates[FullType("type", 1, "ALLOC")] = {
    "fortran": {"getter": FORTRAN_TYPE_ARRAY_1D_ALLOC_INFO},
    "cpp": {
        "declaration": CPP_TYPE_ARRAY_1D_ALLOC_DECL,
        "accessor": [CPP_TYPE_ARRAY_1D_ALLOC_ACCESSOR],
    },
}


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


def generate_accessor_code(struct_name: str, attr_name: str, full_type: FullType):
    """
    Generate Fortran and C++ accessor code for a given struct/attribute/type combination.
    """

    try:
        tpl = templates[full_type]
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
        "fortran": replace_all(tpl["fortran"]["getter"]),
        "cpp_declaration": replace_all(tpl["cpp"]["declaration"]),
        "cpp_accessor": [replace_all(acc) for acc in tpl["cpp"]["accessor"]],
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
