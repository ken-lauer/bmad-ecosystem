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


def get_condition(cpptype: str, logic_type: str, attr_name: str) -> str:
    target = f"struct_obj%{attr_name}"

    if logic_type == "NOT":
        base = ".true."
    elif logic_type == "ALLOC":
        base = f"allocated({target})"
    elif logic_type == "PTR":
        base = f"associated({target})"
    else:
        raise ValueError(f"Unknown logic_type: {logic_type}")

    # Arrays passed to C/C++ via c_loc must be contiguous otherwise the
    # calculated strides in C++ won't match memory gaps.
    #
    # Non-contiguous arrays just won't be readable by pybmad / C++ for now.
    #
    # Note: 'is_contiguous' is standard F2008.
    if cpptype == "string":
        return base
    return f"{base} .and. is_contiguous({target})"


# ---------------------------------------------------------------------------
# Dynamic Fortran Code Generator for Arrays (Deduplication)
# ---------------------------------------------------------------------------
def generate_fortran_array_routine(
    cpp_type: str, dim: int, is_derived_type: bool = False, logic_type: str = "NOT"
) -> str:
    """
    Generates the Fortran implementation string dynamically for 1D, 2D, 3D arrays,
    handling both standard types and derived types (which need element_size).
    """

    # Argument definitions
    args = [
        "struct_obj_ptr",
        "data_ptr",
        "bounds",
        "strides" if dim > 1 else None,
        "is_allocated",
        "el_size" if is_derived_type else None,
    ]
    args = [a for a in args if a]  # Filter None
    arg_str = ", ".join(args)

    # Bound count
    n_bounds = dim * 2

    # Declaration block
    decls = [
        "type(c_ptr), intent(in), value :: struct_obj_ptr",
        "type(c_ptr), intent(out) :: data_ptr",
        f"integer(c_int), dimension({n_bounds}), intent(out) :: bounds",
        "logical(c_bool), intent(out) :: is_allocated",
        "type(STRUCTNAME), pointer :: struct_obj",
    ]

    if dim > 1:
        decls.append(f"integer(c_int), dimension({dim}), intent(out) :: strides")
        # Helper ints for stride calc
        decls.append("integer :: " + ", ".join(f"d{i}" for i in range(1, dim)))

    if is_derived_type:
        decls.append("integer(c_size_t), intent(out) :: el_size")

    decls_str = "\n    ".join(decls)

    # Condition Block
    # We use a placeholder FATTRNAME to be substituted later
    condition = get_condition(cpp_type, logic_type, "FATTRNAME")

    # Access Pattern (c_loc args)
    # e.g. lbound(struct_obj%FATTRNAME, 1)
    loc_args = ", ".join(f"lbound(struct_obj%FATTRNAME, {i})" for i in range(1, dim + 1))
    ref_args = ", ".join(f"bounds({(i - 1) * 2 + 1})" for i in range(1, dim + 1))  # for element size ref

    # Bound Assignments
    bound_assigns = []
    for i in range(1, dim + 1):
        idx_l = (i - 1) * 2 + 1
        idx_u = (i - 1) * 2 + 2
        bound_assigns.append(f"bounds({idx_l}) = int(lbound(struct_obj%FATTRNAME, {i}), c_int)")
        bound_assigns.append(f"bounds({idx_u}) = int(ubound(struct_obj%FATTRNAME, {i}), c_int)")

    bound_str = "\n      ".join(bound_assigns)

    # Stride Assignments (Standard Column Major Logic)
    stride_assigns = []
    if dim > 1:
        stride_assigns.append("strides(1) = 1_c_int")

        # dim1 size
        calc_dim = []
        calc_dim.append("d1 = bounds(2) - bounds(1) + 1")
        if dim > 2:
            # dim2 size, etc
            calc_dim.append("d2 = bounds(4) - bounds(3) + 1")

        stride_assigns.extend(calc_dim)

        # strides(2) = d1
        stride_assigns.append("strides(2) = d1")
        if dim > 2:
            stride_assigns.append("strides(3) = d1 * d2")

    stride_str = "\n      ".join(stride_assigns)

    # Element Size Logic
    el_size_logic = ""
    if is_derived_type:
        # storage_size returns bits. /8 for bytes.
        el_size_logic = f"el_size = int(storage_size(struct_obj%FATTRNAME({ref_args})) / 8, c_size_t)"

    # Zero-out/Failure Block
    zero_assigns = ["data_ptr = c_null_ptr", "bounds = 0_c_int"]
    if dim > 1:
        zero_assigns.append("strides = 0_c_int")
    if is_derived_type:
        zero_assigns.append("el_size = 0")
    zero_assigns.append("is_allocated = .false.")
    zero_str = "\n      ".join(zero_assigns)

    return f"""
  subroutine STRUCTNAME_get_FATTRNAME_info({arg_str}) &
        bind(c, name='STRUCTNAME_get_FATTRNAME_info')
    {decls_str}
    
    call c_f_pointer(struct_obj_ptr, struct_obj)
    
    if ({condition}) then
      data_ptr = c_loc(struct_obj%FATTRNAME({loc_args}))
      {bound_str}
      {stride_str}
      {el_size_logic}
      is_allocated = .true.
    else
      {zero_str}
    endif
  end subroutine
"""


# ---------------------------------------------------------------------------
# Fortran pattern fragments - SCALARS
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

# ---------------------------------------------------------------------------
# C++ pattern fragments - GETTERS
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

CPP_TYPE_SCALAR_DECL = "    void STRUCTNAME_get_FATTRNAME(const void* struct_obj, void** ptr_out);"

# ---------------------------------------------------------------------------
# Fortran/C++ pattern fragments - SETTERS
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

# Logic: We use 'is_contiguous' here too to be safe if it's a pointer.
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

# Character Arrays are distinct because they return length AND bounds
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


def make_char_array_1d(ptr_type: PointerType) -> TemplateEntry:
    # Note: Character arrays have special handling because of str_len
    # so they don't use the generic generate_fortran_array_routine yet.
    return TemplateEntry(
        fortran_getter=subst(
            FORTRAN_CHAR_ARRAY_1D_ALL, condition=get_condition("string", ptr_type, "FATTRNAME")
        ),
        fortran_setter=None,
        cpp_get_decl=CPP_CHAR_ARRAY_1D_DECL,
        cpp_get_accessors=[CPP_CHAR_ARRAY_1D_ACCESSOR],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_array_template(
    dim: int,
    ptr_type: str,
    cpp_type: str,
    cpp_decl_tmpl: str,
    cpp_acc_tmpl: str,
    is_derived_type: bool = False,
) -> TemplateEntry:
    """
    Generic generator for 1D, 2D, 3D arrays of both Simple and Derived types.
    """
    return TemplateEntry(
        fortran_getter=generate_fortran_array_routine(cpp_type, dim, is_derived_type, ptr_type),
        fortran_setter=None,
        cpp_get_decl=subst(cpp_decl_tmpl, ctype=cpp_type),
        cpp_get_accessors=[subst(cpp_acc_tmpl, ctype=cpp_type)],
        cpp_set_decl=None,
        cpp_set_accessors=[],
    )


def make_char_scalar_dyn(ptr_type: str, setter_pattern: str) -> TemplateEntry:
    return TemplateEntry(
        fortran_getter=subst(
            FORTRAN_CHAR_SCALAR_DYN_GETTER, condition=get_condition("string", ptr_type, "FATTRNAME")
        ),
        fortran_setter=setter_pattern,
        cpp_get_decl=CPP_CHAR_SCALAR_DYN_DECL,
        cpp_get_accessors=[CPP_CHAR_SCALAR_DYN_ACCESSOR],
        cpp_set_decl=CPP_CHARACTER_SET_DECL,
        cpp_set_accessors=[CPP_CHARACTER_SET_ACCESSOR],
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

# 4. Register Templates
templates[FullType("character", 0, "ALLOC")] = make_char_scalar_dyn("ALLOC", FORTRAN_CHAR_ALLOC_SETTER)
templates[FullType("character", 0, "PTR")] = make_char_scalar_dyn("PTR", FORTRAN_CHAR_PTR_SETTER)

# ---------------------------------------------------------------------------
# Arrays 1D / 2D / 3D (Real + Integer + Complex)
# ---------------------------------------------------------------------------

# Templates for C++ side logic
CPP_ARRAY_1D_DECL = (
    "    void STRUCTNAME_get_FATTRNAME_info(const void* s, CTYPE** d, int* bounds, bool* is_alloc);"
)
CPP_ARRAY_1D_ACCESSOR = """
    FortranArray1D<CTYPE> CATTRNAME() const {
        return BmadProxyHelpers::get_array_1d<CTYPE>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""
CPP_ARRAY_2D_DECL = "    void STRUCTNAME_get_FATTRNAME_info(const void* s, CTYPE** d, int* bounds, int* strides, bool* is_alloc);"
CPP_ARRAY_2D_ACCESSOR = """
    FortranArray2D<CTYPE> CATTRNAME() const {
        return BmadProxyHelpers::get_array_2d<CTYPE>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""
CPP_ARRAY_3D_DECL = "    void STRUCTNAME_get_FATTRNAME_info(const void* s, CTYPE** d, int* bounds, int* strides, bool* is_alloc);"
CPP_ARRAY_3D_ACCESSOR = """
    FortranArray3D<CTYPE> CATTRNAME() const {
        return BmadProxyHelpers::get_array_3d<CTYPE>(fortran_ptr_, STRUCTNAME_get_FATTRNAME_info);
    }
"""

std_types = ["real", "integer", "complex"]

for tname in std_types:
    tm = getattr(TypeMappings, tname)

    # Loop over dimensions and logic types
    for ptr_type in ["NOT", "ALLOC", "PTR"]:
        # 1D
        templates[FullType(tname, 1, ptr_type)] = make_array_template(
            1, ptr_type, tm.cpp_type, CPP_ARRAY_1D_DECL, CPP_ARRAY_1D_ACCESSOR
        )
        # 2D
        templates[FullType(tname, 2, ptr_type)] = make_array_template(
            2, ptr_type, tm.cpp_type, CPP_ARRAY_2D_DECL, CPP_ARRAY_2D_ACCESSOR
        )
        # 3D
        templates[FullType(tname, 3, ptr_type)] = make_array_template(
            3, ptr_type, tm.cpp_type, CPP_ARRAY_3D_DECL, CPP_ARRAY_3D_ACCESSOR
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

# Derived Type C++ definitions
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

# Register Type Arrays
for ptr_type in ["NOT", "ALLOC", "PTR"]:
    # 1D Derived
    templates[FullType("type", 1, ptr_type)] = make_array_template(
        1, ptr_type, "void*", CPP_TYPE_ARRAY_1D_DECL, CPP_TYPE_ARRAY_1D_ACCESSOR, is_derived_type=True
    )
    # 2D Derived
    templates[FullType("type", 2, ptr_type)] = make_array_template(
        2, ptr_type, "void*", CPP_TYPE_ARRAY_2D_DECL, CPP_TYPE_ARRAY_2D_ACCESSOR, is_derived_type=True
    )
    # 3D Derived
    templates[FullType("type", 3, ptr_type)] = make_array_template(
        3, ptr_type, "void*", CPP_TYPE_ARRAY_3D_DECL, CPP_TYPE_ARRAY_3D_ACCESSOR, is_derived_type=True
    )

# Character 1D (Standard fixed size array via generic char handler)
templates[FullType("character", 1, "NOT")] = make_char_array_1d("NOT")
templates[FullType("character", 1, "ALLOC")] = make_char_array_1d("ALLOC")


# ---------------------------------------------------------------------------
# Remaining Code Generation Functions
# ---------------------------------------------------------------------------
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
