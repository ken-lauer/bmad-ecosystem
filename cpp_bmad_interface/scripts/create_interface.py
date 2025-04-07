#!/usr/bin/env python3

# Note: Run this script in the cpp_bmad_interface directory.

# Script to read in Fortran structures and create:
#   Corresponding C++ class
#   Translator between Fortran structure and C++ class
#   Routines to check for equality between instances of a given fortran structure.
#   Routines to check for equality between instances of a given C++ class
#   Program to check the Fortran / C++ translator

# Note: The corresponding C++ class component for a pointer or allocatable Fortran
# scalar struct component is an array whose length is zero if the Fortran component
# is nullified and whose length is 1 otherwise.

from __future__ import annotations

import copy
import os
import pathlib
import re
import sys
import textwrap
from dataclasses import dataclass, field
from typing import Any

SCRIPTS_PATH = pathlib.Path(__file__).resolve().parent
CPP_INTERFACE_ROOT = SCRIPTS_PATH.parent

##################################################################################
##################################################################################
# Settings

N_CHAR_MAX = 95
DEBUG = False  # Change to True to enable printout

# Constants

NOT = "NOT"
PTR = "PTR"
ALLOC = "ALLOC"

T = True
F = False

REAL = "real"
CMPLX = "complex"
INT = "integer"
INT8 = "integer8"
LOGIC = "logical"
CHAR = "character"
STRUCT = "type"
SIZE = "size"

NOT, PTR, ALLOC = (
    "NOT",
    "PTR",
    "ALLOC",
)

##################################################################################
##################################################################################


def is_number(s: str) -> bool:
    try:
        float(s.replace("d", "e").replace("D", "e"))
        return True
    except ValueError:
        return False


def wrap_line(line, indent, cont_char):
    """
    Wrap a line of text to a maximum width with appropriate indentation and continuation character.

    Parameters
    ----------
    line : str
        The text line to wrap
    indent : str
        String to use for initial indentation
    cont_char : str
        Character to append to continued lines

    Returns
    -------
    str
        A string with the wrapped line
    """
    lines = textwrap.wrap(
        line, width=N_CHAR_MAX, initial_indent=indent, subsequent_indent=indent + "    "
    )

    result = []
    for i, wrapped_line in enumerate(lines):
        if i < len(lines) - 1:
            result.append(wrapped_line + cont_char + "\n")
        else:
            result.append(wrapped_line + "\n")

    return "".join(result)


def print_debug(line):
    if DEBUG:
        print(line, file=sys.stderr)


def indent(string: str, numspace: int) -> str:
    """Indent each line of the string by numspace spaces."""
    prefix = " " * numspace
    lines = string.splitlines(keepends=True)
    indented_lines = [prefix + line for line in lines]
    return "".join(indented_lines)


@dataclass
class c_side_trans_class:
    c_class: str = ""  # EG: 'CPP_ele_Array'
    c_class_suffix: str = ""  # EG: '*'

    # C++ --> Fortran
    # |   C++     |    Fortran |
    # obj_to_f() -> obj_to_f2()
    #
    # (C) handles obj_to_f()  - picks out class members
    # (F) handles obj_to_f2() - takes flattened class members to reconstruct a new Fortran structure

    # C -> F setup code:
    to_f_setup: str = ""
    # C -> F cleanup code:
    to_f_cleanup: str = ""
    # C -> F2 argument type:
    to_f2_arg: str = ""
    # C -> F2 how to pass the argument when calling f2 (F) from C
    to_f2_call: str = ""

    # Fortran --> C++
    # | Fortran   |  C++       |
    # obj_to_c() -> obj_to_c2()
    #
    # (F) handles obj_to_c()  - picks out structure members
    # (C) handles obj_to_c2() - takes flattened class members to reconstruct a new C++ class instance

    # C2 function: parameter type
    to_c2_arg: str = ""
    # C2 function: how to set the value on the new instance
    to_c2_set: str = "  C.NAME = z_NAME;"

    # C++ class constructor initializer list item
    constructor: str = "NAME(VALUE)"
    # C++ class constructor initializer value ("VALUE" gets replaced with this)
    construct_value: str = "0"
    # C++ class destructor code
    destructor: str = ""

    # How to compare instances of this type
    equality_test: str = "  is_eq = is_eq && (x.NAME == y.NAME);\n"
    # The pattern to be used in the test suite to fill this instance
    test_pat: str = "  rhs = XXX + offset; C.NAME = TEST_VALUE;\n"
    # The pattern to be used in the test suite to fill this instance
    # "TEST_VALUE" in "test_pat" gets replaced with this.
    test_value: str = ""

    def __repr__(self):
        return "{},  {},  {},  {}".format(
            self.c_class,
            self.to_f2_arg,
            self.to_f2_call,
            self.to_c2_arg,
        )


@dataclass
class f_side_trans_class:
    # Fortran -> C++:
    #
    # | Fortran   |  C++       |
    # obj_to_c() -> obj_to_c2()
    #
    # (F) handles obj_to_c()  - picks out structure members
    # (C) handles obj_to_c2() - takes flattened class members to reconstruct a new C++ class instance
    #
    # F -> C: variable list: defines for the obj_to_c function
    to_c_var: list[str] = field(default_factory=list)
    # F -> C: how to translate the Fortran value to C
    to_c_trans: str = ""
    # F -> C2: how to call obj_to_c2() from fortran with the argument
    to_c2_call: str = ""
    # F -> C2: how to define the local variable in to_c to call to_c2:
    to_c2_type: str = ""
    # F -> C2: the name for the fortran variable in to_c:
    to_c2_name: str = ""
    # F -> C2: the Fortran subroutine argument specification of to_c2:
    to_c2_f2_sub_arg: str = "z_NAME"

    # C++ -> Fortran:
    #
    # |   C++     |    Fortran |
    # obj_to_f() -> obj_to_f2()
    #
    # (C) handles obj_to_f()  - picks out class members
    # (F) handles obj_to_f2() - takes flattened class members to reconstruct a new Fortran structure
    to_f2_type: str = ""
    to_f2_name: str = ""
    to_f2_trans: str = "F%NAME = z_NAME"
    to_f2_var: list[str] = field(default_factory=list)

    equality_test: str = "is_eq = is_eq .and. all(f1%NAME == f2%NAME)\n"
    test_pat: str = "rhs = XXX + offset; F%NAME = TEST_VALUE\n"
    size_var: list[str] = field(
        default_factory=list
    )  # For communicating the size of allocatable and pointer variables
    test_value: str = ""


@dataclass
class arg_class:
    """
    Represents an argument or component in the Fortran to C++ interface.

    Attributes
    ----------
    is_component : bool
        Whether this is a structure component. If False, it's an array bound.
    f_name : str
        Fortran side name of argument (lowercase).
    c_name : str
        C++ side name of argument, potentially mangled to avoid reserved word conflicts.
    type : str
        Fortran type without parameters, e.g., 'real', 'type', 'character'.
    kind : str
        Fortran kind, e.g., '', 'rp', 'coord_struct'.
    pointer_type : str
        Pointer type: NOT, PTR, or ALLOC.
    array : List[str]
        Array dimension specifications, e.g., [':', ':'] or ['0:6', '3'].
    full_array : str
        Complete array specification, e.g., '(:,:)', '(0:6, 3)'.
    lbound : List[Any]
        Lower bounds for each array dimension.
    ubound : List[Any]
        Upper bounds for each array dimension.
    init_value : str
        Initialization value.
    comment : str
        Comment from the Fortran structure definition.
    f_side : int
        Fortran side translation.
    c_side : int
        C++ side translation.
    """

    is_component: bool = True
    f_name: str = ""
    c_name: str = ""
    type: str = ""
    kind: str = ""
    pointer_type: str = NOT
    array: list[str] = field(default_factory=list)
    full_array: str = ""
    lbound: list[Any] = field(default_factory=list)
    ubound: list[Any] = field(default_factory=list)
    init_value: str = ""
    comment: str = ""
    f_side: f_side_trans_class = field(default_factory=f_side_trans_class)
    c_side: c_side_trans_class = field(default_factory=c_side_trans_class)
    split_line: list[str] = field(default_factory=list)

    def get_dim1(self) -> tuple[str, str]:
        if self.ubound[0][-1] == "$":
            f_dim1 = self.ubound[0]
            c_dim1 = "Bmad::" + self.ubound[0][0:-1].upper()
            if self.lbound[0] != "1":
                print('lbound not "1" with parameter upper bound!', file=sys.stderr)
                sys.exit("STOPPING HERE")
        else:
            f_dim1 = str(1 + int(self.ubound[0]) - int(self.lbound[0]))
            c_dim1 = f_dim1
        return f_dim1, c_dim1

    @property
    def c_dim1(self) -> str:
        _, c_dim1 = self.get_dim1()
        return c_dim1

    @property
    def f_dim1(self) -> str:
        f_dim1, _ = self.get_dim1()
        return f_dim1

    @property
    def dim2(self) -> int:
        return 1 + int(self.ubound[1]) - int(self.lbound[1])

    @property
    def dim3(self) -> int:
        return 1 + int(arg.ubound[2]) - int(arg.lbound[2])

    def replace_name_placeholders(self):
        """Replace NAME placeholders with argument names on both C and Fortran sides."""
        # Fortran side
        self.f_side.to_c_var = [
            var.replace("NAME", self.f_name) for var in self.f_side.to_c_var
        ]
        self.f_side.to_c_trans = self.f_side.to_c_trans.replace("NAME", self.f_name)
        self.f_side.to_c2_call = self.f_side.to_c2_call.replace("NAME", self.f_name)
        self.f_side.to_c2_f2_sub_arg = self.f_side.to_c2_f2_sub_arg.replace(
            "NAME", self.f_name
        )
        self.f_side.to_c2_name = self.f_side.to_c2_name.replace("NAME", self.f_name)
        self.f_side.to_f2_var = [
            var.replace("NAME", self.f_name) for var in self.f_side.to_f2_var
        ]
        self.f_side.to_f2_trans = self.f_side.to_f2_trans.replace("NAME", self.f_name)
        self.f_side.to_f2_name = self.f_side.to_f2_name.replace("NAME", self.f_name)
        self.f_side.equality_test = self.f_side.equality_test.replace(
            "NAME", self.f_name
        )
        self.f_side.test_pat = self.f_side.test_pat.replace("NAME", self.f_name)

        # C side
        self.c_side.to_c2_arg = self.c_side.to_c2_arg.replace("NAME", self.c_name)
        self.c_side.to_c2_set = self.c_side.to_c2_set.replace("NAME", self.c_name)
        self.c_side.to_f_setup = self.c_side.to_f_setup.replace("NAME", self.c_name)
        self.c_side.to_f_cleanup = self.c_side.to_f_cleanup.replace("NAME", self.c_name)
        self.c_side.to_f2_call = self.c_side.to_f2_call.replace("NAME", self.c_name)
        self.c_side.equality_test = self.c_side.equality_test.replace(
            "NAME", self.c_name
        )
        self.c_side.test_pat = self.c_side.test_pat.replace("NAME", self.c_name)
        self.c_side.constructor = self.c_side.constructor.replace("NAME", self.c_name)
        self.c_side.destructor = self.c_side.destructor.replace("NAME", self.c_name)

    def original_repr(self) -> str:
        return '["{}({})", "{}", "{}", {}, "{}" {} {} "{}"]'.format(
            self.type,
            self.kind,
            self.pointer_type,
            self.f_name,
            self.array,
            self.full_array,
            self.lbound,
            self.ubound,
            self.init_value,
        )


@dataclass
class struct_def_class:
    f_name: str = ""  # Struct name on Fortran side
    short_name: str = ""  # Struct name without trailing '_struct'. Note: C++ name is 'CPP_<short_name>'
    cpp_class: str = ""  # C++ name.
    arg: list[arg_class] = field(
        default_factory=list
    )  # Array of arg_class. List of structrure components + array bound dimensions.
    c_constructor_arg_list: str = ""
    c_constructor_body: str = ""  # Body of the C++ constructor
    c_extra_methods: str = ""  # Additional custom methods

    def __str__(self) -> str:
        return "[name: %s, #arg: %i]" % (self.short_name, len(self.arg))


x2 = " " * 2
x4 = " " * 4
x6 = " " * 6
x8 = " " * 8

jd1_loop = "do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1\n"
jd2_loop = "do jd2 = 1, size(F%NAME,2); lb2 = lbound(F%NAME,2) - 1\n"
jd3_loop = "do jd3 = 1, size(F%NAME,3); lb3 = lbound(F%NAME,3) - 1\n"

rhs1 = "  rhs = 100 + jd1 + XXX + offset\n"
rhs2 = "  rhs = 100 + jd1 + 10*jd2 + XXX + offset\n"
rhs3 = "  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + XXX + offset\n"

set1 = "  F%NAME(jd1+lb1) = TEST_VALUE\n"
set2 = "  F%NAME(jd1+lb1,jd2+lb2) = TEST_VALUE\n"
set3 = "  F%NAME(jd1+lb1,jd2+lb2,jd3+lb3) = TEST_VALUE\n"


def initialize_f_side_trans() -> dict[tuple[str, int, str], f_side_trans_class]:
    f_side_trans: dict[tuple[str, int, str], f_side_trans_class] = {}

    for type in [REAL, CMPLX, INT, INT8, LOGIC, STRUCT, SIZE]:
        for dim in range(4):
            f_side_trans[type, dim, NOT] = make_f_side_trans_basic(type, dim)
            f_side_trans[type, dim, PTR] = make_f_side_trans_ptr(
                f_side_trans[type, dim, NOT], type, dim
            )

    make_special_f_trans(f_side_trans)
    return f_side_trans


# --------------------------------------
def make_f_side_trans_basic(type: str, dim: int):
    test_pat1 = f"{jd1_loop}{rhs1}{set1}enddo\n"
    test_pat2 = f"{jd1_loop}{jd2_loop}{rhs2}{set2}enddo; enddo\n"
    test_pat3 = f"{jd1_loop}{jd2_loop}{jd3_loop}{rhs3}{set3}enddo; enddo; enddo\n"

    f = f_side_trans_class()

    # Set type-specific properties
    if type == REAL:
        f.to_c2_type = "real(c_double)"
        f.test_value = "rhs"
    elif type == CMPLX:
        f.to_c2_type = "complex(c_double_complex)"
        f.test_value = "cmplx(rhs, 100+rhs)"
    elif type == INT:
        f.to_c2_type = "integer(c_int)"
        f.test_value = "rhs"
    elif type == INT8:
        f.to_c2_type = "integer(c_long)"
        f.test_value = "rhs"
    elif type == LOGIC:
        f.to_c2_type = "logical(c_bool)"
        f.test_value = "(modulo(rhs, 2) == 0)"
    elif type == STRUCT:
        f.to_c2_type = "type(c_ptr)"
        f.test_value = "TEST_VALUE"
    elif type == SIZE:
        f.to_c2_call = "NAME"
        f.to_c2_type = "integer(c_int), value"
        f.to_c2_name = "NAME"
        f.to_f2_type = "integer(c_int), value"
        f.to_f2_name = "NAME"
        f.to_f2_trans = ""
        f.to_c2_f2_sub_arg = "NAME"
        f.to_c_var = ["integer(c_int) :: NAME"]
        f.test_value = ""
        return f

    # Dimension-specific properties
    if dim == 0:
        f.to_c2_name = "z_NAME"
        f.equality_test = "is_eq = is_eq .and. (f1%NAME == f2%NAME)\n"
        f.to_c2_call = "F%NAME"

        if type == LOGIC:
            f.to_c2_call = "c_logic(F%NAME)"
            f.to_f2_trans = "F%NAME = f_logic(z_NAME)"
            f.equality_test = f.equality_test.replace("==", ".eqv.")
        elif type == STRUCT:
            f.to_c2_type = "type(c_ptr), value"
            f.to_c2_call = "c_loc(F%NAME)"
            f.to_f2_trans = "call KIND_to_f(z_NAME, c_loc(F%NAME))"
            f.test_pat = "call set_KIND_test_pattern (F%NAME, ix_patt)\n"

    elif dim == 1:
        f.to_c2_call = "fvec2vec(F%NAME, DIM1)"
        f.to_c2_name = "z_NAME(*)"
        f.to_f2_trans = "F%NAME = z_NAME(1:DIM1)"
        f.test_pat = test_pat1

        if type == LOGIC:
            f.to_f2_trans = "call vec2fvec (z_NAME, F%NAME)"
            f.equality_test = f.equality_test.replace("==", ".eqv.")
        elif type == STRUCT:
            f.to_c2_call = "z_NAME"
            f.to_f2_trans = f"{jd1_loop}  call KIND_to_f(z_NAME(jd1), c_loc(F%NAME(jd1+lb1)))\nenddo"
            f.test_pat = f"{jd1_loop}{rhs1}  call set_KIND_test_pattern (F%NAME(jd1+lb1), ix_patt+jd1)\nenddo\n"
            f.to_c_var = ["type(c_ptr) :: z_NAME(DIM1)"]
            f.to_c_trans = f"{jd1_loop}  z_NAME(jd1) = c_loc(F%NAME(jd1+lb1))\nenddo\n"

    elif dim == 2:
        f.to_f2_trans = "call vec2mat(z_NAME, F%NAME)"
        f.to_c2_call = "mat2vec(F%NAME, DIM2)"
        f.to_c2_name = "z_NAME(*)"
        f.test_pat = test_pat2

        if type == LOGIC:
            f.equality_test = f.equality_test.replace("==", ".eqv.")
        elif type == STRUCT:
            f.to_c2_call = "z_NAME"
            f.to_f2_trans = (
                f"{jd1_loop}{jd2_loop}  call KIND_to_f(z_NAME(DIM2*(jd1-1) + jd2), "
                f"c_loc(F%NAME(jd1+lb1,jd2+lb2)))\nenddo; enddo\n"
            )
            f.test_pat = (
                f"{jd1_loop}{jd2_loop}{rhs2}  call set_KIND_test_pattern "
                f"(F%NAME(jd1+lb1,jd2+lb2), ix_patt+jd1+10*jd2)\nenddo; enddo\n"
            )
            f.to_c_var = ["type(c_ptr) :: z_NAME(DIM1*DIM2)"]
            f.to_c_trans = (
                f"{jd1_loop}{jd2_loop}  z_NAME(DIM2*(jd1-1) + jd2) = "
                f"c_loc(F%NAME(jd1+lb1,jd2+lb2))\nenddo; enddo\n"
            )

    elif dim == 3:
        f.to_f2_trans = "call vec2tensor(z_NAME, F%NAME)"
        f.to_c2_call = "tensor2vec(F%NAME, DIM3)"
        f.to_c2_name = "z_NAME(*)"
        f.test_pat = test_pat3

        if type == LOGIC:
            f.equality_test = f.equality_test.replace("==", ".eqv.")
        elif type == STRUCT:
            f.to_c2_call = "z_NAME"
            f.to_f2_trans = (
                f"{jd1_loop}{jd2_loop}{jd3_loop}  call KIND_to_f(z_NAME(DIM3*DIM2*(jd1-1) + "
                f"DIM3*(jd2-1) + jd3), c_loc(F%NAME(jd1+lb1,jd2+lb2,jd3+lb3)))\n"
                f"enddo; enddo; enddo\n"
            )
            f.test_pat = (
                f"{jd1_loop}{jd2_loop}{jd3_loop}{rhs3}  call set_KIND_test_pattern "
                f"(F%NAME(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+10*jd2+100*jd3)\n"
                f"enddo; enddo; enddo\n"
            )
            f.to_c_var = ["type(c_ptr) :: z_NAME(DIM1*DIM2*DIM3)"]
            f.to_c_trans = (
                f"{jd1_loop}{jd2_loop}{jd3_loop}  z_NAME(DIM3*DIM2*(jd1-1) + DIM3*(jd2-1) + jd3) = "
                f"c_loc(F%NAME(jd1+lb1,jd2+lb2,jd3+lb3))\nenddo; enddo; enddo\n"
            )

    # Final processing
    f.test_pat = f.test_pat.replace("TEST_VALUE", f.test_value)
    if f.to_f2_type == "":
        f.to_f2_type = f.to_c2_type
    if f.to_f2_name == "":
        f.to_f2_name = f.to_c2_name

    return f


def make_f_side_trans_ptr(f: f_side_trans_class, type: str, dim: int):
    equality_test_pointer = """\
is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))
if (.not. is_eq) return
if (associated(f1%NAME)) is_eq = all(shape(f1%NAME) == shape(f2%NAME))
if (.not. is_eq) return
if (associated(f1%NAME)) is_eq = all(f1%NAME == f2%NAME)
"""
    to_f2_trans_pointer = """\
if (associated(F%NAME)) then
  if (n1_NAME == 0 .or. any(shape(F%NAME) /= [DIMS])) deallocate(F%NAME)
  if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
endif
if (n1_NAME /= 0) then
  call c_f_pointer (z_NAME, f_NAME, [TOTDIM])
  if (.not. associated(F%NAME)) allocate(F%NAME(DIMS))
  SET
else
  if (associated(F%NAME)) deallocate(F%NAME)
endif
"""

    fp = f_side_trans_class()
    fp.to_c2_type = f.to_c2_type
    fp.to_c2_name = "z_NAME(*)"
    fp.to_f2_type = "type(c_ptr), value"
    fp.to_f2_name = "z_NAME"
    fp.to_f2_var = [f.to_f2_type + ", pointer :: f_NAME(:)"]

    # ---------------------
    # Pointer, dim = 0

    if dim == 0:
        fp.to_f2_var = [f.to_f2_type + ", pointer :: f_NAME"]
        fp.to_c2_name = "z_NAME"
        fp.to_c2_call = "F%NAME"
        fp.to_f2_trans = """\
if (n_NAME == 0) then                                                                                  
  if (associated(F%NAME)) deallocate(F%NAME)                                                           
else                                                                                                   
  call c_f_pointer (z_NAME, f_NAME)                                                                    
  if (.not. associated(F%NAME)) allocate(F%NAME)                                                       
  F%NAME = f_NAME
endif                                                                                                  
"""

        fp.to_c_trans = """\
n_NAME = 0
if (associated(F%NAME)) n_NAME = 1
"""

        fp.equality_test = """
is_eq = is_eq .and. (associated(f1%NAME) .eqv. associated(f2%NAME))
if (.not. is_eq) return
if (associated(f1%NAME)) is_eq = (f1%NAME == f2%NAME)
"""

        test_pat = """\
if (ix_patt < 3) then
  if (associated(F%NAME)) deallocate (F%NAME)
else
  if (.not. associated(F%NAME)) allocate (F%NAME)
  rhs = XXX + offset
  SET
endif
"""

        fp.test_pat = test_pat.replace("SET", "F%NAME = " + f.test_value)

        if type == LOGIC:
            fp.equality_test = fp.equality_test.replace("== f", ".eqv. f")
            fp.to_f2_trans = fp.to_f2_trans.replace("= f_NAME", "= f_logic(f_NAME)")
            fp.to_c2_call = "fscalar2scalar(F%NAME, n_NAME)"
            fp.to_c2_type = "logical(c_bool)"

        if type == STRUCT:
            fp.to_c2_call = "c_loc(F%NAME)"
            fp.to_c2_type = "type(c_ptr), value"
            fp.to_f2_var = ["type(KIND_struct), pointer :: f_NAME"]
            fp.test_pat = test_pat.replace(
                "SET", "call set_KIND_test_pattern (F%NAME, ix_patt)"
            )
            fp.to_f2_trans = """\
if (n_NAME == 0) then
  if (associated(F%NAME)) deallocate(F%NAME)
else
  if (.not. associated(F%NAME)) allocate(F%NAME)
  call KIND_to_f (z_NAME, c_loc(F%NAME))
endif
"""

    # ---------------------
    # Pointer, dim = 1

    if dim == 1:
        fp.to_c2_call = "fvec2vec(F%NAME, n1_NAME)"
        fp.to_f2_trans = (
            to_f2_trans_pointer.replace("DIMS", "n1_NAME")
            .replace("TOTDIM", "n1_NAME")
            .replace("SET", "F%NAME = f_NAME(1:n1_NAME)")
        )
        fp.equality_test = equality_test_pointer

        fp.to_c_trans = """\
n1_NAME = 0
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME, 1)
endif
"""
        tp1 = """
if (ix_patt < 3) then
  if (associated(F%NAME)) deallocate (F%NAME)
else
  if (.not. associated(F%NAME)) allocate (F%NAME(-1:1))
"""

        fp.test_pat = "".join(
            (
                tp1,
                x2,
                jd1_loop,
                x2,
                rhs1,
                x2,
                set1.replace("TEST_VALUE", f.test_value),
                "  enddo\n",
                "endif\n",
            )
        )

        if type == LOGIC:
            fp.equality_test = fp.equality_test.replace("== f", ".eqv. f")
            fp.to_f2_trans = fp.to_f2_trans.replace(
                "F%NAME = f_NAME(1:n1_NAME)", "call vec2fvec (f_NAME, F%NAME)"
            )

        if type == STRUCT:
            fp.to_c2_call = "z_NAME"
            fp.to_c2_type = "type(c_ptr)"
            fp.to_c2_name = "z_NAME(*)"
            fp.to_f2_type = fp.to_c2_type
            fp.to_f2_name = fp.to_c2_name
            fp.to_c_var = ["type(c_ptr), allocatable :: z_NAME(:)"]
            fp.to_f2_var = []
            fp.test_pat = (
                tp1
                + x2
                + jd1_loop
                + x4
                + "call set_KIND_test_pattern (F%NAME(jd1+lb1), ix_patt+jd1)\n"
                + "  enddo\n"
                + "endif\n"
            )
            ## fp.equality_test = fp.equality_test.replace
            fp.to_c_trans = """ \
n1_NAME = 0
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME); lb1 = lbound(F%NAME, 1) - 1
  allocate (z_NAME(n1_NAME))
  do jd1 = 1, n1_NAME
    z_NAME(jd1) = c_loc(F%NAME(jd1+lb1))
  enddo
endif
"""
            fp.to_f2_trans = """\
if (n1_NAME == 0) then
  if (associated(F%NAME)) deallocate(F%NAME)
else
  if (associated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (.not. associated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1))
  do jd1 = 1, n1_NAME
    call KIND_to_f (z_NAME(jd1), c_loc(F%NAME(jd1+LBOUND-1)))
  enddo
endif
"""

    # ---------------------
    # Pointer, dim = 2

    if dim == 2:
        fp.to_c2_call = "mat2vec(F%NAME, n1_NAME*n2_NAME)"
        fp.to_f2_trans = (
            to_f2_trans_pointer.replace("DIMS", "n1_NAME, n2_NAME")
            .replace("TOTDIM", "n1_NAME*n2_NAME")
            .replace("SET", "call vec2mat(f_NAME, F%NAME)")
        )
        fp.equality_test = equality_test_pointer

        fp.to_c_trans = """\
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME, 1)
  n2_NAME = size(F%NAME, 2)
else
  n1_NAME = 0; n2_NAME = 0
endif
"""
        tp2 = """
if (ix_patt < 3) then
  if (associated(F%NAME)) deallocate (F%NAME)
else
  if (.not. associated(F%NAME)) allocate (F%NAME(-1:1, 2))
"""
        fp.test_pat = (
            tp2
            + x2
            + jd1_loop
            + x2
            + jd2_loop
            + x2
            + rhs2
            + x2
            + set2.replace("TEST_VALUE", f.test_value)
            + "  enddo; enddo\n"
            + "endif\n"
        )

        if type == LOGIC:
            fp.equality_test = fp.equality_test.replace("== f", ".eqv. f")

        if type == STRUCT:
            fp.to_c2_call = "z_NAME"
            fp.to_c2_type = "type(c_ptr)"
            fp.to_c2_name = "z_NAME(*)"
            fp.to_f2_type = fp.to_c2_type
            fp.to_f2_name = fp.to_c2_name
            fp.to_c_var = ["type(c_ptr), allocatable :: z_NAME(:)"]
            fp.to_f2_var = []
            fp.test_pat = (
                tp2
                + x2
                + jd1_loop
                + x2
                + jd2_loop
                + x4
                + "call set_KIND_test_pattern (F%NAME(jd1+lb1,jd2+lb2), ix_patt+jd1+2*jd2)\n"
                + "  enddo\n"
                + "  enddo\n"
                + "endif\n"
            )
            ## fp.equality_test = fp.equality_test.replace
            fp.to_c_trans = """\
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME, 1); lb1 = lbound(F%NAME, 1) - 1
  n2_NAME = size(F%NAME, 2); lb2 = lbound(F%NAME, 2) - 1
  allocate (z_NAME(n1_NAME * n2_NAME))
  do jd1 = 1, n1_NAME; do jd2 = 1, n2_NAME
    z_NAME(n2_NAME*(jd1-1) + jd2) = c_loc(F%NAME(jd1+lb1, jd2+lb2))
  enddo;  enddo
else
  n1_NAME = 0; n2_NAME = 0
endif
"""
            fp.to_f2_trans = """\
if (n1_NAME == 0) then
  if (associated(F%NAME)) deallocate(F%NAME)
else
  if (associated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (.not. associated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1, LBOUND:n2_NAME+LBOUND-1))
  do jd1 = 1, n1_NAME
  do jd2 = 1, n2_NAME
    call KIND_to_f (z_NAME(n2_NAME*(jd1-1) + jd2), c_loc(F%NAME(jd1+LBOUND-1,jd2+LBOUND-1)))
  enddo
  enddo
endif
"""

    # ---------------------
    # Pointer, dim = 3

    if dim == 3:
        fp.to_c2_call = "tensor2vec(F%NAME, n1_NAME*n2_NAME*n3_NAME)"
        fp.to_f2_trans = (
            to_f2_trans_pointer.replace("DIMS", "n1_NAME, n2_NAME, n3_NAME")
            .replace("TOTDIM", "n1_NAME*n2_NAME*n3_NAME")
            .replace("SET", "call vec2tensor(f_NAME, F%NAME)")
        )
        fp.equality_test = equality_test_pointer

        fp.to_c_trans = """\
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME, 1)
  n2_NAME = size(F%NAME, 2)
  n3_NAME = size(F%NAME, 3)
else
  n1_NAME = 0; n2_NAME = 0; n3_NAME = 0
endif
"""

        tp3 = """\
if (ix_patt < 3) then
  if (associated(F%NAME)) deallocate (F%NAME)
else
  if (.not. associated(F%NAME)) allocate (F%NAME(-1:1, 2, 1))
"""
        fp.test_pat = (
            tp3
            + x2
            + jd1_loop
            + x2
            + jd2_loop
            + x2
            + jd3_loop
            + x2
            + rhs3
            + x2
            + set3.replace("TEST_VALUE", f.test_value)
            + "  enddo; enddo; enddo\n"
            + "endif\n"
        )

        if type == LOGIC:
            fp.equality_test = fp.equality_test.replace("== f", ".eqv. f")

        if type == STRUCT:
            fp.to_c2_call = "z_NAME"
            fp.to_c2_type = "type(c_ptr)"
            fp.to_c2_name = "z_NAME(*)"
            fp.to_f2_type = fp.to_c2_type
            fp.to_f2_name = fp.to_c2_name
            fp.to_c_var = ["type(c_ptr), allocatable :: z_NAME(:)"]
            fp.to_f2_var = []
            fp.test_pat = (
                tp3
                + x2
                + jd1_loop
                + x2
                + jd2_loop
                + x2
                + jd3_loop
                + x4
                + "call set_KIND_test_pattern (F%NAME(jd1+lb1,jd2+lb2,jd3+lb3), ix_patt+jd1+2*jd2+3*jd3)\n"
                + "  enddo\n"
                + "  enddo\n"
                + "  enddo\n"
                + "endif\n"
            )
            ## fp.equality_test = fp.equality_test.replace
            fp.to_c_trans = """\
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME, 1); lb1 = lbound(F%NAME, 1) - 1
  n2_NAME = size(F%NAME, 2); lb2 = lbound(F%NAME, 2) - 1
  n3_NAME = size(F%NAME, 3); lb3 = lbound(F%NAME, 3) - 1
  allocate (z_NAME(n1_NAME * n2_NAME * n3_NAME))
  do jd1 = 1, n1_NAME; do jd2 = 1, n2_NAME; do jd3 = 1, n3_NAME
    z_NAME(n3_NAME*n2_NAME*(jd1-1) + n3_NAME*(jd2-1) + jd3) = c_loc(F%NAME(jd1+lb1, jd2+lb2, jd3+lb3))
  enddo;  enddo; enddo
else
  n1_NAME = 0; n2_NAME = 0; n3_NAME = 0
endif
"""
            fp.to_f2_trans = """\
if (n1_NAME == 0) then
  if (associated(F%NAME)) deallocate(F%NAME)
else
  if (associated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME, n2_NAME, n3_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (.not. associated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1, LBOUND:n2_NAME+LBOUND-1, LBOUND:n3_NAME+LBOUND-1))
  do jd1 = 1, n1_NAME;  do jd2 = 1, n2_NAME;  do jd3 = 1, n3_NAME
    call KIND_to_f (z_NAME(n3_NAME*n2_NAME*(jd1-1) + n3_NAME*(jd2-1) + jd3), c_loc(F%NAME(jd1+LBOUND-1,jd2+LBOUND-1,jd3+LBOUND-1)))
  enddo;  enddo;  enddo
endif
"""
    return fp


def make_special_f_trans(f_side_trans):
    # ---------------------------
    # CHAR 0 NOT - Character scalar, not a pointer/allocatable

    f_side_trans[CHAR, 0, NOT] = f_side_trans_class()
    fc = f_side_trans[CHAR, 0, NOT]
    fc.to_c2_call = "trim(F%NAME) // c_null_char"
    fc.to_c2_type = "character(c_char)"
    fc.to_c2_name = "z_NAME(*)"
    fc.to_f2_type = fc.to_c2_type
    fc.to_f2_name = fc.to_c2_name
    fc.equality_test = "is_eq = is_eq .and. (f1%NAME == f2%NAME)\n"
    fc.test_pat = (
        "do jd1 = 1, len(F%NAME)\n"
        '  F%NAME(jd1:jd1) = char(ichar("a") + modulo(100+XXX+offset+jd1, 26))\n'
        "enddo\n"
    )
    fc.to_f2_trans = "call to_f_str(z_NAME, F%NAME)"

    # CHAR 0 PTR - Character scalar pointer

    f_side_trans[CHAR, 0, PTR] = copy.deepcopy(f_side_trans[INT, 0, PTR])
    fc = f_side_trans[CHAR, 0, PTR]
    fc.to_c2_type = "character(c_char)"
    fc.to_c2_name = "z_NAME(*)"
    fc.to_f2_type = fc.to_c2_type
    fc.to_f2_name = fc.to_c2_name
    fc.to_f2_trans = """\
if (n_NAME == 0) then
  if (associated(F%NAME)) deallocate(F%NAME)
else
  if (.not. associated(F%NAME)) allocate(F%NAME)
  call to_f_str(z_NAME, F%NAME)
endif
"""
    fc.to_c_var = ["character(STR_LEN+1), target :: f_NAME"]
    fc.to_c_trans = """\
n_NAME = 0
if (associated(F%NAME)) then
  n_NAME = 1
  f_NAME = trim(F%NAME) // c_null_char 
endif
"""
    fc.to_c2_call = "f_NAME"
    fc.test_pat = """\
if (ix_patt < 3) then
  if (associated(F%NAME)) deallocate (F%NAME)
else
  if (.not. associated(F%NAME)) allocate (F%NAME)
  do jd1 = 1, len(F%NAME)
    F%NAME(jd1:jd1) = char(ichar("a") + modulo(100+XXX+offset+jd1, 26))
  enddo
endif
"""

    # CHAR 1 NOT - Character array, not a pointer/allocatable

    f_side_trans[CHAR, 1, NOT] = copy.deepcopy(f_side_trans[STRUCT, 1, NOT])
    fc = f_side_trans[CHAR, 1, NOT]
    fc.to_c2_name = "z_NAME(*)"
    fc.to_f2_type = fc.to_c2_type
    fc.to_f2_name = fc.to_c2_name
    fc.to_f2_var = ["character(c_char), pointer :: f_NAME"]
    fc.test_pat = """\
do jd1 = lbound(F%NAME, 1), ubound(F%NAME, 1)
  do jd = 1, len(F%NAME(jd1))
    F%NAME(jd1)(jd:jd) = char(ichar("a") + modulo(100+XXX+offset+10*jd+jd1, 26))
  enddo
enddo
"""
    fc.to_f2_trans = "\n".join(
        [
            jd1_loop.rstrip(),
            "  call c_f_pointer (z_NAME(jd1), f_NAME)",
            "  call to_f_str(f_NAME, F%NAME(jd1+lb1))",
            "enddo",
            "",
        ]
    )

    fc.to_c_trans = "\n".join(
        [
            jd1_loop.rstrip(),
            "  a_NAME(jd1) = trim(F%NAME(jd1+lb1)) // c_null_char",
            "  z_NAME(jd1) = c_loc(a_NAME(jd1))",
            "enddo",
            "",
        ]
    )
    fc.to_c_var += ["character(STR_LEN+1), target :: a_NAME(DIM1)"]

    # CHAR 1 PTR - Character array pointer

    f_side_trans[CHAR, 1, PTR] = copy.deepcopy(f_side_trans[STRUCT, 1, PTR])
    fc = f_side_trans[CHAR, 1, PTR]
    fc.to_c2_type = "type(c_ptr)"
    fc.to_c2_name = "z_NAME(*)"
    fc.to_f2_type = fc.to_c2_type
    fc.to_f2_name = fc.to_c2_name
    fc.to_f2_var = ["character(c_char), pointer :: f_NAME"]
    fc.test_pat = """\
if (ix_patt < 3) then
  if (associated(F%NAME)) deallocate (F%NAME)
else
  if (.not. associated(F%NAME)) allocate (F%NAME(3))
  do jd1 = 1, 3
  do jd = 1, len(F%NAME)
    F%NAME(jd1)(jd:jd) = char(ichar("a") + modulo(100+XXX+offset+10*jd+jd1, 26))
  enddo; enddo
endif
"""
    fc.to_f2_trans = """\
if (n1_NAME == 0) then
  if (associated(F%NAME)) deallocate(F%NAME)
else
  if (associated(F%NAME)) then
    if (n1_NAME == 0 .or. any(shape(F%NAME) /= [n1_NAME])) deallocate(F%NAME)
    if (any(lbound(F%NAME) /= LBOUND)) deallocate(F%NAME)
  endif
  if (.not. associated(F%NAME)) allocate(F%NAME(LBOUND:n1_NAME+LBOUND-1))
  do jd1 = 1, n1_NAME
    call c_f_pointer (z_NAME(jd1), f_NAME)
    call to_f_str(f_NAME, F%NAME(jd1+LBOUND-1))
  enddo
endif
"""
    fc.to_c_trans = """\
n1_NAME = 0
if (associated(F%NAME)) then
  n1_NAME = size(F%NAME); lb1 = lbound(F%NAME, 1) - 1
  allocate (a_NAME(n1_NAME))
  allocate (z_NAME(n1_NAME))
  do jd1 = 1, n1_NAME
    a_NAME(jd1) = trim(F%NAME(jd1+lb1)) // c_null_char
    z_NAME(jd1) = c_loc(a_NAME(jd1))
  enddo
endif
"""
    fc.to_c_var += ["character(STR_LEN+1), allocatable, target :: a_NAME(:)"]

    # --------------------------------------------------------------------------------------
    # Allocatable components are very similar to pointer components
    # with the simple replacement of 'associated' for 'allocated'.

    for trans in list(f_side_trans.keys()):
        if trans[2] == PTR:
            trans_alloc = (trans[0], trans[1], ALLOC)
            f_side_trans[trans_alloc] = copy.deepcopy(f_side_trans[trans])
            t = f_side_trans[trans_alloc]
            t.to_f2_trans = t.to_f2_trans.replace("associated", "allocated")
            t.to_c_trans = t.to_c_trans.replace("associated", "allocated")
            t.test_pat = t.test_pat.replace("associated", "allocated")
            t.equality_test = t.equality_test.replace("associated", "allocated")


test_pat_pointer1 = """\
  if (ix_patt < 3) 
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
"""

equality_test_pointer = """\
  is_eq = is_eq && ((x.NAME == NULL) == (y.NAME == NULL));
  if (!is_eq) return false;
  if (x.NAME != NULL) is_eq = TEST;
"""

for1 = "  for (size_t i = 0; i < C.NAME.size(); i++)"
for2 = "  for (size_t j = 0; j < C.NAME[0].size(); j++) "
for3 = "  for (size_t k = 0; k < C.NAME[0][0].size(); k++)"

test_pat1 = for1 + "\n    {int rhs = 101 + i + XXX + offset; C.NAME[i] = TEST_VALUE;}"
test_pat2 = (
    for1
    + for2
    + "\n    {int rhs = 101 + i + 10*(j+1) + XXX + offset; C.NAME[i][j] = TEST_VALUE;}"
)
test_pat3 = (
    for1
    + for2
    + for3
    + "\n"
    + x4
    + "{int rhs = 101 + i + 10*(j+1) + 100*(k+1) + XXX + offset; C.NAME[i][j][k] = TEST_VALUE;}"
)


def configure_c_side_trans_by_type(
    type: str,
    dim: int,
    c: c_side_trans_class,
):
    """Configure a c_side_trans object based on type, dimension. Not a pointer type."""
    if type == REAL:
        c_type = "Real"
        c_arg = "c_Real"
        c.test_value = "rhs"
        c.construct_value = "0.0"
    elif type == CMPLX:
        c_type = "Complex"
        c_arg = "c_Complex"
        c.test_value = "Complex(rhs, 100+rhs)"
        c.construct_value = "0.0"
    elif type == INT:
        c_type = "Int"
        c_arg = "c_Int"
        c.test_value = "rhs"
        c.construct_value = "0"
    elif type == INT8:
        c_type = "Int8"
        c_arg = "c_Int8"
        c.test_value = "rhs"
        c.construct_value = "0"
    elif type == LOGIC:
        c_type = "Bool"
        c_arg = "c_Bool"
        c.test_value = "(rhs % 2 == 0)"
        c.construct_value = "false"
    elif type == STRUCT:
        c_type = "CPP_KIND"
        c_arg = "const CPP_KIND"
        c.test_value = ""
        c.construct_value = ""
    elif type == SIZE:
        c.to_f2_arg = "Int"
        c.to_f2_call = "NAME"
        c.to_c2_arg = "Int NAME"
        return
    else:
        raise NotImplementedError(type)

    # Configure based on dimension
    if dim == 0:
        configure_c_dim0(c, c_type, c_arg, type)
    elif dim == 1:
        configure_c_dim1(c, c_type, c_arg, type)
    elif dim == 2:
        configure_c_dim2(c, c_type, c_arg, type)
    elif dim == 3:
        configure_c_dim3(c, c_type, c_arg, type)

    # Apply test pattern
    c.test_pat = c.test_pat.replace("TEST_VALUE", c.test_value)

    # Special handling for STRUCT type
    if type == STRUCT:
        c.to_c2_arg = "const Opaque_KIND_class* z_NAME"
        if dim > 0:
            c.to_f2_arg = c.to_f2_arg.replace("Arr", "**")
            c.to_c2_arg = "const Opaque_KIND_class** z_NAME"
            c.to_f2_call = "z_NAME"


def configure_c_dim0(c, c_type, c_arg, type):
    """Configure for dimension 0"""
    c.c_class = c_type
    c.to_f2_arg = c_arg + "&"
    c.to_f2_call = "C.NAME"
    c.to_c2_arg = c_arg + "& z_NAME"

    if type == STRUCT:
        c.constructor = "NAME()"
        c.to_c2_set = "  KIND_to_c(z_NAME, C.NAME);"
        c.test_pat = "  set_CPP_KIND_test_pattern(C.NAME, ix_patt);\n"


def configure_c_dim1(c, c_type, c_arg, type):
    """Configure for dimension 1"""
    c.c_class = c_type + "_ARRAY"
    c.to_f2_arg = c_arg + "Arr"
    c.to_f2_call = "&C.NAME[0]"
    c.to_c2_arg = c_arg + "Arr z_NAME"
    c.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"

    if type == STRUCT:
        c.constructor = "NAME(CPP_KIND_ARRAY(DIM1))"
        c.to_c2_set = "\n".join(
            (
                "for (size_t i = 0; i < C.NAME.size(); i++)",
                "{ C.NAME[i] = make_shared<CPP_KIND>(); KIND_to_c(z_NAME[i], *C.NAME[i]); }",
            )
        )
        c.test_pat = test_pat1.replace(
            "C.NAME[i] = TEST_VALUE",
            "set_CPP_KIND_test_pattern(*C.NAME[i], ix_patt+i+1)",
        )
        c.to_f_setup = """\
  const CPP_KIND* z_NAME[DIM1];
  for (int i = 0; i < DIM1; i++) {z_NAME[i] = C.NAME[i].get();}
"""
    else:
        c.constructor = "NAME(DIM1, VALUE)"
        c.to_c2_set = "  C.NAME << z_NAME;"
        c.test_pat = test_pat1


def configure_c_dim2(c, c_type, c_arg, type):
    """Configure for dimension 2"""
    c.c_class = c_type + "_MATRIX"
    c.to_f2_arg = c_arg + "Arr"
    c.to_f2_call = "z_NAME"
    c.to_c2_arg = c_arg + "Arr z_NAME"
    c.constructor = "NAME(CPP_KIND_MATRIX(DIM1, CPP_KIND_ARRAY(DIM2)))"
    c.to_c2_set = "  C.NAME << z_NAME;"
    c.test_pat = test_pat2
    c.to_f_setup = (
        "  " + c_type + " z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);\n"
    )
    c.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"

    if type == STRUCT:
        c.constructor = "NAME(CPP_KIND_MATRIX(DIM1, CPP_KIND_ARRAY(DIM2)))"
        c.to_c2_set = (
            for1
            + for2
            + "\n    {int m = DIM2*i + j; KIND_to_c(z_NAME[m], *C.NAME[i][j].get());}"
        )
        c.test_pat = test_pat2.replace(
            "C.NAME[i][j] = TEST_VALUE",
            "set_CPP_KIND_test_pattern(*C.NAME[i][j], ix_patt+i+1+10*(j+1))",
        )
        c.to_f_setup = (
            "  const CPP_KIND* z_NAME[DIM1*DIM2];\n"
            + for1
            + for2
            + "\n    {int m = DIM2*i + j; z_NAME[m] = C.NAME[i][j].get();}\n"
        )


def configure_c_dim3(c, c_type, c_arg, type):
    """Configure for dimension 3"""
    c.c_class = c_type + "_TENSOR"
    c.to_f2_arg = c_arg + "Arr"
    c.to_f2_call = "z_NAME"
    c.to_c2_arg = c_arg + "Arr z_NAME"
    c.constructor = (
        f"NAME({c_type}_TENSOR(DIM1, {c_type}_MATRIX(DIM2, {c_type}_ARRAY(DIM3))))"
    )
    c.to_c2_set = "  C.NAME << z_NAME;"
    c.test_pat = test_pat3
    c.to_f_setup = (
        "  " + c_type + " z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);\n"
    )
    c.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"

    if type == STRUCT:
        c.constructor = (
            "NAME(CPP_KIND_TENSOR(DIM1, CPP_KIND_MATRIX(DIM2, CPP_KIND_ARRAY(DIM3))))"
        )
        c.to_c2_set = (
            for1
            + for2
            + for3
            + "\n    {int m = DIM3*DIM2*i + DIM3*j + k; KIND_to_c(z_NAME[m], *C.NAME[i][j][k].get());}"
        )
        c.test_pat = c.test_pat.replace(
            "C.NAME[i][j][k] = TEST_VALUE",
            "set_CPP_KIND_test_pattern(*C.NAME[i][j][k], ix_patt+i+1+10*(j+1)+100*(k+1))",
        )
        c.to_f_setup = (
            "  const CPP_KIND* z_NAME[DIM1*DIM2*DIM3];\n"
            + for1
            + for2
            + for3
            + "\n    {int m = DIM3*DIM2*i + DIM3*j + k; z_NAME[m] = C.NAME[i][j][k].get();}\n"
        )


def configure_c_pointer(
    cp: c_side_trans_class,
    c: c_side_trans_class,
    dim: int,
    type: str,
    c_type: str,
    c_arg: str,
):
    """Configure pointer version of the class"""
    # Copy the original configuration
    cp.destructor = ""

    if type == STRUCT:
        cp.to_c2_arg = "Opaque_KIND_class** z_NAME"
    else:
        cp.to_f2_arg = c_arg + "Arr"
        cp.to_c2_arg = cp.to_f2_arg + " z_NAME"

    # Dimension-specific pointer configuration
    if dim == 0:
        configure_pointer_dim0(cp, c, c_type, type)
    elif dim == 1:
        configure_pointer_dim1(cp, c, c_type, type)
    elif dim == 2:
        configure_pointer_dim2(cp, c, c_type, type)
    elif dim == 3:
        configure_pointer_dim3(cp, c, c_type, type)
    else:
        raise NotImplementedError(dim)

    cp.test_pat = cp.test_pat.replace("TEST_VALUE", c.test_value)


def configure_pointer_dim0(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 0"""
    cp.c_class = f"shared_ptr<{cp.c_class}>"
    # cp.c_class_suffix = ""
    cp.constructor = "NAME(NULL)"
    cp.destructor = ""
    cp.test_pat = "\n".join(
        (
            "  if (ix_patt < 3) ",
            "    C.NAME = NULL;",
            "  else {",
            f"    C.NAME = make_shared<{c_type}>();",
            indent(c.test_pat.replace("C.NAME", "(*C.NAME)"), 2) + "  }",
        )
    )
    cp.to_f_setup = "  size_t n_NAME = 0; if (C.NAME != nullptr) n_NAME = 1;\n"
    cp.equality_test = """\
  is_eq = is_eq && ((x.NAME == NULL) == (y.NAME == NULL));
  if (!is_eq) return false;
  if (x.NAME != NULL) is_eq = (*x.NAME == *y.NAME);
"""
    cp.to_c2_set = """\
  if (n_NAME == 0) {
    C.NAME = nullptr;
  } else {
    C.NAME = make_shared<KIND>();
    SET
  }
""".replace("KIND", c_type)

    if type == STRUCT:
        cp.to_f2_call = "*C.NAME"
        cp.to_c2_arg = "Opaque_KIND_class* z_NAME"
        cp.to_c2_set = cp.to_c2_set.replace("SET", "KIND_to_c(z_NAME, *C.NAME);")
    else:
        cp.to_f2_call = "C.NAME.get()"
        cp.to_c2_set = cp.to_c2_set.replace("SET", "*C.NAME = *z_NAME;")


def configure_pointer_dim1(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 1"""
    cp.constructor = cp.constructor.replace("DIM1", "0")
    cp.to_f2_call = "z_NAME"
    cp.to_c2_set = """
  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
"""
    cp.test_pat = test_pat_pointer1 + indent(c.test_pat, 2) + "  }\n"
    cp.to_f_setup = """\
  int n1_NAME = C.NAME.size();
  c_TYPEArr z_NAME = NULL;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
""".replace("TYPE", c_type)

    if type == STRUCT:
        cp.constructor = "NAME(CPP_KIND_ARRAY(0))"
        cp.test_pat = (
            test_pat_pointer1
            + x2
            + for1
            + "  {set_CPP_KIND_test_pattern(*C.NAME[i], ix_patt+i+1);}\n"
            + "  }\n"
        )
        cp.to_f_setup = """\
  int n1_NAME = C.NAME.size();
  const CPP_KIND** z_NAME = NULL;
  if (n1_NAME != 0) {
    z_NAME = new const CPP_KIND*[n1_NAME];
    for (int i = 0; i < n1_NAME; i++) z_NAME[i] = C.NAME[i].get();
  }
"""
        cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (int i = 0; i < n1_NAME; i++) { C.NAME[i] = make_shared<CPP_KIND>(); KIND_to_c(z_NAME[i], *C.NAME[i]); }
"""
        cp.to_f_cleanup = " delete[] z_NAME;\n"


def configure_pointer_dim2(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 2"""
    cp.constructor = cp.constructor.replace("DIM1", "0").replace("DIM2", "0")
    cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (int i = 0; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
"""
    cp.test_pat = (
        test_pat_pointer1
        + indent((for1 + "\n    C.NAME[i].resize(2);\n" + c.test_pat), 2)
        + "  }\n"
    )
    cp.to_f_cleanup = "  delete z_NAME;\n"
    cp.to_f_setup = """\
  int n1_NAME = C.NAME.size(), n2_NAME = 0;
  TYPE* z_NAME = NULL;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new TYPE [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
""".replace("TYPE", c_type)
    cp.to_f_cleanup = "  delete[] z_NAME;\n"

    if type == STRUCT:
        cp.constructor = "NAME(CPP_KIND_MATRIX(0, CPP_KIND_ARRAY(0)))"
        cp.test_pat = (
            test_pat_pointer1
            + """\
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);\n
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        set_CPP_KIND_test_pattern(*C.NAME[i][j], ix_patt+i+2*j+3);
      }
    }
  }
"""
        )
        cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (int i = 0; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (int j = 0; j < n2_NAME; j++) KIND_to_c(z_NAME[n2_NAME*i+j], *C.NAME[i][j].get());
  }
"""
        cp.to_f_setup = """
  int n1_NAME = C.NAME.size(), n2_NAME = 0;
  const TYPE** z_NAME = NULL;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new const TYPE* [n1_NAME*n2_NAME];
    for (int i = 0; i < n1_NAME; i++) {
      for (int j = 0; j < n2_NAME; j++) z_NAME[i*n2_NAME + j] = C.NAME[i][j].get();}
  }
""".replace("TYPE", c_type)


def configure_pointer_dim3(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 3"""
    cp.constructor = (
        cp.constructor.replace("DIM1", "0").replace("DIM2", "0").replace("DIM3", "0")
    )

    cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (size_t i = 0; i < C.NAME.size(); i++) {
    C.NAME[i].resize(n2_NAME);
    for (size_t j = 0; j < C.NAME[0].size(); j++)
      C.NAME[i][j].resize(n3_NAME);
  }
  C.NAME << z_NAME;
"""

    cp.test_pat = """\
  if (ix_patt < 3) 
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        C.NAME[i][j].resize(1);
        for (size_t k = 0; k < C.NAME[0][0].size(); k++) {
          int rhs = 101 + i + 10*(j+1) + 100*(k+1) + XXX + offset; C.NAME[i][j][k] = TEST_VALUE;
        }
      }
    }
  }
"""

    cp.to_f_cleanup = "  delete z_NAME;\n"
    cp.to_f_setup = """
  int n1_NAME = C.NAME.size(), n2_NAME = 0, n3_NAME = 0;
  TYPE* z_NAME = NULL;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new TYPE [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
""".replace("TYPE", c_type)
    cp.to_f_cleanup = "  delete[] z_NAME;\n"

    if type == STRUCT:
        cp.constructor = (
            "NAME(CPP_KIND_TENSOR(0, CPP_KIND_MATRIX(0, CPP_KIND_ARRAY(0))))"
        )

        cp.to_c2_set = """
  C.NAME.resize(n1_NAME);
  for (int i = 0; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (int j = 0; j < n2_NAME; j++) {
      C.NAME[i][j].resize(n3_NAME);
      for (int k = 0; k < n3_NAME; k++) {
        KIND_to_c(z_NAME[n3_NAME*n2_NAME*i+n3_NAME*j+k], *C.NAME[i][j][k].get());
    } } }
"""
        cp.test_pat = """\
  if (ix_patt < 3) 
    C.NAME.resize(0);
  else {
    C.NAME.resize(3);
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        C.NAME[i][j].resize(1);
        for (size_t k = 0; k < C.NAME[0][0].size(); k++) {
          set_CPP_KIND_test_pattern(*C.NAME[i][j][k], ix_patt+i+2*j+3*k+6);
    } } }
  }
"""
        cp.to_f_setup = """
  int n1_NAME = C.NAME.size(), n2_NAME = 0, n3_NAME = 0;
  const TYPE** z_NAME = NULL;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new const TYPE* [n1_NAME*n2_NAME*n3_NAME];
    for (int i = 0; i < n1_NAME; i++) {
      for (int j = 0; j < n2_NAME; j++) {
        for (int k = 0; k < n3_NAME; k++) {
          z_NAME[i*n2_NAME*n3_NAME + j*n3_NAME + k] = C.NAME[i][j][k].get();
    } } }
  }
""".replace("TYPE", c_type)


def setup_common_c_side_trans():
    """Initialize the c_side_trans dictionary with configured objects for all combinations."""
    c_side_trans = {}

    for type_val in [REAL, CMPLX, INT, INT8, LOGIC, STRUCT, SIZE]:
        for dim in range(4):
            # Create and configure non-pointer version
            c_side_trans[type_val, dim, NOT] = c_side_trans_class()
            c = c_side_trans[type_val, dim, NOT]

            configure_c_side_trans_by_type(type_val, dim, c)

            # Create and configure pointer version (except for SIZE type)
            if type_val != SIZE:
                # Create a deep copy of the non-pointer version
                c_side_trans[type_val, dim, PTR] = copy.deepcopy(c)
                cp = c_side_trans[type_val, dim, PTR]

                # Configure pointer-specific attributes
                configure_c_pointer(
                    cp,
                    c,
                    dim,
                    type_val,
                    get_c_type(type_val),
                    get_c_arg(type_val),
                )

    return c_side_trans


def get_c_type(type_val: str) -> str:
    """Get the C++ type string for a given type value"""
    type_mapping = {
        REAL: "Real",
        CMPLX: "Complex",
        INT: "Int",
        INT8: "Int8",
        LOGIC: "Bool",
        STRUCT: "CPP_KIND",
    }

    if type_val in type_mapping:
        return type_mapping[type_val]

    raise NotImplementedError(f"Unknown type: {type_val}")


def get_c_arg(type_val: str) -> str:
    """Get the C++ argument type string for a given type value"""
    type_mapping = {
        REAL: "c_Real",
        CMPLX: "c_Complex",
        INT: "c_Int",
        INT8: "c_Int8",
        LOGIC: "c_Bool",
        STRUCT: "const CPP_KIND",
    }

    if type_val in type_mapping:
        return type_mapping[type_val]

    raise NotImplementedError(f"Unknown type: {type_val}")


def setup_char_not_pointer(c_side_trans):
    """Set up translation for CHAR, 0, NOT (character scalar, not pointer)."""
    c_side_trans[CHAR, 0, NOT] = c_side_trans_class()
    c_side_trans[CHAR, 0, NOT].c_class = "string"
    c_side_trans[CHAR, 0, NOT].to_f2_arg = "c_Char"
    c_side_trans[CHAR, 0, NOT].to_f2_call = "C.NAME.c_str()"
    c_side_trans[CHAR, 0, NOT].to_c2_arg = "c_Char z_NAME"
    c_side_trans[CHAR, 0, NOT].test_pat = (
        "  C.NAME.resize(STR_LEN);\n"
        + test_pat1.replace("TEST_VALUE", "'a' + rhs % 26")
    )
    c_side_trans[CHAR, 0, NOT].constructor = "NAME()"


def setup_char_pointer(c_side_trans):
    """Set up translation for CHAR, 0, PTR (character scalar pointer)."""
    c_side_trans[CHAR, 0, PTR] = copy.deepcopy(c_side_trans[STRUCT, 0, PTR])
    cc = c_side_trans[CHAR, 0, PTR]
    cc.c_class = "shared_ptr<string>"
    cc.constructor = "NAME(NULL)"
    cc.destructor = ""
    cc.to_f2_call = "z_NAME"
    cc.to_f2_arg = "c_Char"
    cc.to_f_setup = """\
  size_t n_NAME = 0;
  const char* z_NAME = NULL;  
  if (C.NAME != NULL) {
    z_NAME = C.NAME->c_str();
    n_NAME = 1;
  }
"""
    cc.to_c2_arg = "c_Char z_NAME"
    cc.to_c2_set = """\
  if (n_NAME == 0) {
    C.NAME = nullptr;
  }
  else {
    C.NAME = make_shared<string>(z_NAME);
  }
"""
    cc.test_pat = """\
  if (ix_patt < 3) 
    C.NAME = nullptr;
  else {
    C.NAME = make_shared<string>(STR_LEN, ' ');
    for (size_t i = 0; i < C.NAME->size(); i++) {
      (*C.NAME)[i] = 'a' + (101 + i + XXX + offset) % 26; }
  }
"""


def setup_char_array(c_side_trans):
    """Set up translation for CHAR, 1, NOT (character array, not pointer)."""
    c_side_trans[CHAR, 1, NOT] = c_side_trans_class()
    cc = c_side_trans[CHAR, 1, NOT]
    cc.c_class = "String_ARRAY"
    cc.to_f2_arg = "c_Char*"
    cc.to_f_setup = """\
  c_Char z_NAME[DIM1];
  for (int i = 0; i < DIM1; i++) {z_NAME[i] = C.NAME[i].c_str();}
"""
    cc.to_c2_arg = "c_Char* z_NAME"
    cc.test_pat = (
        for1
        + """ {
    C.NAME[i].resize(STR_LEN);
    for (size_t j = 0; j < C.NAME[i].size(); j++) 
      {C.NAME[i][j] = 'a' + (101 + i + 10*(j+1) + XXX + offset) % 26;}
  }
"""
    )
    cc.constructor = "NAME(String_ARRAY(DIM1))"
    cc.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"
    cc.to_f2_call = c_side_trans[STRUCT, 1, NOT].to_f2_call
    cc.to_c2_set = for1 + " C.NAME[i] = z_NAME[i];"


def setup_char_array_pointer(c_side_trans):
    """Set up translation for CHAR, 1, PTR (character array pointer)."""
    c_side_trans[CHAR, 1, PTR] = copy.deepcopy(c_side_trans[STRUCT, 1, PTR])
    cc = c_side_trans[CHAR, 1, PTR]
    cc.c_class = "String_ARRAY"
    cc.constructor = "NAME(String_ARRAY(0))"
    cc.destructor = ""
    cc.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"
    cc.to_f2_arg = "c_Char*"
    cc.to_c2_arg = "c_Char* z_NAME"
    cc.to_f_setup = """\
  int n1_NAME = C.NAME.size();
  c_Char* z_NAME = NULL;
  if (n1_NAME != 0) {
    z_NAME = new c_Char[n1_NAME];
    for (int i = 0; i < n1_NAME; i++) z_NAME[i] = C.NAME[i].c_str();
  }
"""
    cc.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (int i = 0; i < n1_NAME; i++) C.NAME[i] = z_NAME[i];
"""
    cc.test_pat = (
        test_pat_pointer1
        + x2
        + for1
        + "{\n"
        + x6
        + "C.NAME[i].resize(STR_LEN);\n"
        + x4
        + for2
        + "{\n"
        + x8
        + "C.NAME[i][j] = 'a' + (101 + i + 10*(j+1) + XXX + offset) % 26;\n"
        + x4
        + "} }\n"
        + x2
        + "}\n"
    )


def setup_allocatable_components(c_side_trans):
    """Set up allocatable components based on pointer components."""
    for trans in list(c_side_trans.keys()):
        if trans[2] == PTR:
            trans_alloc = (trans[0], trans[1], ALLOC)
            c_side_trans[trans_alloc] = copy.deepcopy(c_side_trans[trans])


def initialize_c_side_trans() -> dict[tuple[str, int, str], c_side_trans_class]:
    """Initialize the c_side_trans dictionary with all required translations."""
    c_side_trans = setup_common_c_side_trans()

    # Set up different character type handlers
    setup_char_not_pointer(c_side_trans)
    setup_char_pointer(c_side_trans)
    setup_char_array(c_side_trans)
    setup_char_array_pointer(c_side_trans)

    # Set up allocatable components
    setup_allocatable_components(c_side_trans)

    return c_side_trans


##################################################################################
##################################################################################
# Get the list of structs
# See test_interface_input.py (or whatever file is used).

# Regular expressions for parsing
re_end_type = re.compile(r"^\s*end\s*type")  # Match to: 'end type'
# Regular expression for initial parsing splits
re_match1 = re.compile(r"([,(]|::|\s+)")  # Match to: ',', '::', '(', ' '
# Regular expression for additional parsing splits
re_match2 = re.compile("([=[,(]|::)")  # Match to: ',', '::', '(', '[', '='
#    Regular expression to match 'contains' statement
re_contains = re.compile(
    r"^\s*contains"
)  # Match to: 'contains' (indicating type procedures are defined.)


##################################################################################
##################################################################################
def parse_structure_definitions(struct_definitions, params):
    """
    Parse Fortran structure definitions from specified files.

    Parameters
    ----------
    struct_definitions : list
        List to store structure definitions
    params : object
        Parameters containing file paths and translation dictionaries

    Notes
    -----
    Parsing handles various Fortran type definitions. Current restrictions to avoid:
      1) Line continuations: '&'
      2) Dimensions: "integer, dimension(7) :: abc"
      3) Kind: "integer(kind = 8) abc"
      4) Variable inits using "," or "(" characters: "real abc(2) = [1, 2]"
    """

    for file_name in params.struct_def_files:
        parse_file(
            file_name,
            struct_definitions,
            params,
        )


def parse_file(
    file_name: str,
    struct_definitions: list,
    params,
) -> None:
    """
    Parse a single Fortran module file for structure definitions.

    Parameters
    ----------
    file_name : str
        Path to the Fortran module file
    struct_definitions : list
        List to store structure definitions
    params : object
        Parameters containing name translation dictionaries
    """
    with open(file_name) as f_module_file:
        for line in f_module_file:
            split_line = line.lower().split()
            if len(split_line) < 2 or split_line[0] != "type":
                continue

            for struct in struct_definitions:
                if struct.f_name == split_line[1]:
                    break
            else:
                continue

            struct.short_name = struct.f_name[:-7]  # Remove '_struct' suffix
            struct.cpp_class = "CPP_" + struct.short_name

            # Collect the struct components
            parse_struct_components(
                f_module_file,
                struct,
                params,
            )


def parse_struct_components(f_module_file, struct, params) -> None:
    """
    Parse components of a Fortran structure.

    Parameters
    ----------
    f_module_file : file
        Open file handle to the Fortran module file
    struct : object
        Structure object to populate with component information
    params : object
        Parameters containing name translation dictionaries
    """
    found_contains_statement = False

    for line in f_module_file:
        if re_end_type.match(line):
            break
        if re_contains.match(line):
            found_contains_statement = True
        if found_contains_statement:
            continue

        print_debug("\nStart: " + line.strip())

        # Remove comments
        part = line.partition("!")
        comment = part[2].strip()
        line = part[0].strip()

        if not line:
            continue  # Blank line

        print_debug("P1: " + line.strip())

        base_arg = parse_component_line(line, comment)
        if base_arg:
            # Process all components on this line
            process_components(base_arg, line, struct, params)


def parse_component_line(line: str, comment: str) -> arg_class:
    """
    Parse a single line containing Fortran structure component definitions.

    Parameters
    ----------
    line : str
        Line of Fortran code (comments removed)
    comment : str
        Comment for this line

    Returns
    -------
    arg_class
        Base argument with type information parsed
    """
    base_arg = arg_class()
    base_arg.comment = comment

    # Get base_arg.type
    split_line = re_match1.split(line, 1)
    print_debug("P2: " + str(split_line))

    base_arg.type = split_line.pop(0)
    if base_arg.type == "integer" and split_line[0][0] == "(":
        base_arg.type = "integer8"

    if split_line[0][0] == " ":
        split_line = re_match2.split(split_line[1], 1)
        if split_line[0] == "":
            split_line.pop(0)

    print_debug("P3: " + str(split_line))

    # Add type information if there is more...
    if split_line[0] == "(":
        split_line = split_line[1].partition(")")
        base_arg.kind = split_line[0].strip()
        split_line = re_match2.split(split_line[2].lstrip(), 1)
        if split_line[0] == "":
            split_line.pop(0)  # EG: "real(rp) :: ..."

    print_debug("P4: " + str(split_line))

    if split_line[0] == ",":
        split_line = split_line[1].partition("::")

        if split_line[0].strip() == "allocatable":
            base_arg.pointer_type = ALLOC
        elif split_line[0].strip() == "pointer":
            base_arg.pointer_type = PTR

        split_line = [split_line[2].lstrip()]

    if split_line[0] == "::":
        split_line.pop(0)

    # Join split_line into one string so that we are starting from a definite state
    if len(split_line) > 1:
        split_line = ["".join(split_line)]

    print_debug("P5: " + str(split_line))

    base_arg.split_line = split_line
    return base_arg


def process_components(base_arg: arg_class, line: str, struct, params) -> None:
    """
    Process all components defined on a single line.

    Parameters
    ----------
    base_arg : arg_class
        Base argument with type information
    line : str
        Original line of Fortran code
    struct : object
        Structure object to add components to
    params : object
        Parameters containing name translation dictionaries
    """
    split_line = base_arg.split_line

    while True:
        print_debug("L1: " + str(split_line))

        if len(split_line) > 1:
            print(
                "Confused parsing of struct component: "
                + line.strip()
                + " in: "
                + struct.f_name,
                file=sys.stderr,
            )

        split_line = re_match2.split(split_line[0], 1)
        print_debug("L2: " + str(split_line))

        arg = copy.deepcopy(base_arg)
        arg.f_name = split_line.pop(0).strip().lower()

        # Handle reserved words on the C++ side
        full_name = struct.f_name + "%" + arg.f_name
        if full_name in params.c_side_name_translation:
            arg.c_name = params.c_side_name_translation[full_name]
        else:
            arg.c_name = arg.f_name

        if len(split_line) == 0:
            struct.arg.append(arg)
            break

        # Get array bounds
        if split_line[0] == "(":
            arg = parse_array_bounds(arg, split_line)
            split_line = arg.split_line

        print_debug("L3: " + str(split_line))

        if len(split_line) == 0:
            struct.arg.append(arg)
            break

        # Get initial value
        if split_line[0] == "=":
            arg, split_line = parse_init_value(arg, split_line)

        print_debug("L4: " + str(split_line))

        struct.arg.append(arg)
        if len(split_line) == 0 or split_line[0] == "":
            break

        if split_line[0] != ",":
            print(
                'Expected "," while parsing: ' + line.strip() + " in: " + struct.f_name,
                file=sys.stderr,
            )

        split_line.pop(0)


def parse_array_bounds(arg: arg_class, split_line: list) -> arg_class:
    """
    Parse array bounds from a component definition.

    Parameters
    ----------
    arg : arg_class
        Argument to update with array information
    split_line : list
        Current split line being processed

    Returns
    -------
    arg_class
        Updated argument with array bounds
    """
    split_line = split_line[1].lstrip().partition(")")
    arg.full_array = "(" + split_line[0].strip().replace(" ", "") + ")"
    arg.array = arg.full_array[1:-1].split(",")

    print_debug("L2p1: " + str(split_line))

    split_line = re_match2.split(split_line[2].lstrip(), 1)
    print_debug("L2p2: " + str(split_line))

    if split_line[0] == "":
        split_line.pop(0)  # Needed for EG: "integer aaa(5)"

    if arg.array[0] != ":":  # If has explicit bounds...
        for dim in arg.array:
            if ":" in dim:
                arg.lbound.append(dim.partition(":")[0])
                arg.ubound.append(dim.partition(":")[2])
            else:
                arg.lbound.append("1")
                arg.ubound.append(dim)

    arg.split_line = split_line
    return arg


def parse_init_value(arg: arg_class, split_line: list) -> tuple:
    """
    Parse initialization value from a component definition.

    Parameters
    ----------
    arg : arg_class
        Argument to update with initialization information
    split_line : list
        Current split line being processed

    Returns
    -------
    tuple
        (updated arg, updated split_line)
    """
    split_line = re_match2.split(split_line[1].lstrip(), 1)
    print_debug("L3p1: " + str(split_line))

    # If have EG: "b(2) = [3, 4], c => null()" need to
    # combine back "(...)" or "[...]" construct which is part of init string.
    if len(split_line) > 1 and (split_line[1] == "(" or split_line[1] == "["):
        split0 = split_line[0] + split_line[1]
        n_parens = 1

        ix = 0
        for ix, char in enumerate(split_line[2]):
            split0 = split0 + char
            if char == "(" or char == "[":
                n_parens = n_parens + 1
            if char == ")" or char == "]":
                n_parens = n_parens - 1
            if n_parens == 0:
                break
        split1 = split_line[2][ix + 1 :]
        if split1 == "":
            split_line = [split0]
        elif split1[0] == ",":
            split_line = [split0, ",", split1[1:]]
        else:
            raise RuntimeError(f"Parse init value failed: {split_line}")

    print_debug("L3p2: " + str(split_line))

    arg.init_value = split_line[0]
    if len(split_line) == 1:
        split_line[0] = ""
    else:
        split_line.pop(0)

    return arg, split_line


def remove_untranslated(struct: struct_def_class) -> None:
    # Throw out any sub-structures that are not to be translated
    struct.arg = [
        arg
        for arg in struct.arg
        if not (
            arg.kind in params.component_no_translate_list
            or f"{struct.f_name}%{arg.f_name}" in params.component_no_translate_list
        )
    ]

    # Add translation info to each argument
    for arg in struct.arg:
        n_dim = len(arg.array)
        p_type = arg.pointer_type
        translation_key = (arg.type, n_dim, p_type)

        # Skip arguments without translation definitions
        if translation_key not in f_side_trans:
            print(
                f"NO TRANSLATION FOR: {struct.short_name}%{arg.f_name} "
                f"[{arg.type}, {n_dim}, {p_type}]",
                file=sys.stderr,
            )
            continue

        # Apply translations
        arg.f_side = copy.deepcopy(f_side_trans[translation_key])
        arg.c_side = copy.deepcopy(c_side_trans[translation_key])


def add_array_bound_info_for_pointer_structures(struct: struct_def_class) -> None:
    ia = 0
    while ia < len(struct.arg):
        arg = struct.arg[ia]
        ia += 1  # Increment early since we'll be inserting elements

        # Skip non-pointer types
        if arg.pointer_type == NOT:
            continue

        # Handle scalar pointers
        if len(arg.array) == 0:
            if "n_" in arg.c_side.to_f_setup:
                # Insert size parameter for the scalar pointer
                size_arg = arg_class()
                size_arg.is_component = False
                size_arg.type = "integer"
                size_arg.f_side = copy.deepcopy(f_side_trans[SIZE, 1, NOT])
                size_arg.c_side = copy.deepcopy(c_side_trans[SIZE, 1, NOT])
                size_arg.f_name = "n_" + arg.f_name
                size_arg.c_name = "n_" + arg.c_name

                struct.arg.insert(ia, size_arg)
                ia += 1
            continue

        # Handle array pointers
        if len(arg.array) >= 1 and "n1_" in arg.c_side.to_f_setup:
            # Create and insert size parameters for all dimensions
            for dim in range(
                1, min(len(arg.array) + 1, 4)
            ):  # Support up to 3 dimensions
                size_arg = arg_class()
                size_arg.is_component = False
                size_arg.type = "integer"
                size_arg.f_side = copy.deepcopy(f_side_trans[SIZE, dim, NOT])
                size_arg.c_side = copy.deepcopy(c_side_trans[SIZE, dim, NOT])
                size_arg.f_name = f"n{dim}_" + arg.f_name
                size_arg.c_name = f"n{dim}_" + arg.c_name

                struct.arg.insert(ia, size_arg)
                ia += 1


def fix_struct_arg_placeholders(struct: struct_def_class, arg: arg_class) -> None:
    """
    Substitute placeholder names in argument patterns with actual values.

    This function processes an argument object, replacing placeholders like "NAME", "DIM1", etc.,
    with the actual values relevant to the structure and argument.

    Parameters
    ----------
    struct : struct_def_class
        The structure definition containing the argument
    arg : arg_class
        The argument to process
    """
    print_debug("Arg: " + str(arg))
    p_type = arg.pointer_type

    # Replace string length placeholders
    _replace_string_length_placeholders(arg)

    # Handle array bounds
    _handle_lbound(struct, arg)

    # Handle 'type' arguments
    if arg.type == "type":
        _handle_type_argument(arg)

    # Handle array dimensions
    if len(arg.array) >= 1 and p_type == NOT:
        _handle_first_dimension(arg)

    if len(arg.array) >= 2 and p_type == NOT:
        _handle_second_dimension(arg)

    if len(arg.array) >= 3 and p_type == NOT:
        _handle_third_dimension(arg)

    # Replace name placeholders
    arg.replace_name_placeholders()

    # Handle initialization values
    _handle_init_values(arg)


def _replace_string_length_placeholders(arg: arg_class) -> None:
    """Replace STR_LEN placeholders with the argument's kind."""
    arg.c_side.test_pat = arg.c_side.test_pat.replace("STR_LEN", arg.kind)
    arg.f_side.to_c_var = [
        var.replace("STR_LEN", arg.kind) for var in arg.f_side.to_c_var
    ]


def _handle_lbound(struct: struct_def_class, arg: arg_class) -> None:
    """Handle the lower bound replacement."""
    id_name = struct.short_name + "%" + arg.f_name
    lbound = params.f_side_lbound(id_name)
    arg.f_side.to_f2_trans = arg.f_side.to_f2_trans.replace("LBOUND", lbound)


def _handle_type_argument(arg: arg_class) -> None:
    """Process 'type' arguments by replacing KIND placeholders."""
    kind = arg.kind[:-7]
    arg.f_side.to_f2_trans = arg.f_side.to_f2_trans.replace("KIND", kind)
    arg.f_side.to_f2_var = [var.replace("KIND", kind) for var in arg.f_side.to_f2_var]
    arg.f_side.test_pat = arg.f_side.test_pat.replace("KIND", kind)
    arg.c_side.test_pat = arg.c_side.test_pat.replace("KIND", kind)
    arg.c_side.c_class = arg.c_side.c_class.replace("KIND", kind)
    arg.c_side.to_c2_set = arg.c_side.to_c2_set.replace("KIND", kind)
    arg.c_side.to_f_setup = arg.c_side.to_f_setup.replace("KIND", kind)
    arg.c_side.to_f2_arg = arg.c_side.to_f2_arg.replace("KIND", kind)
    arg.c_side.to_c2_arg = arg.c_side.to_c2_arg.replace("KIND", kind)
    arg.c_side.constructor = arg.c_side.constructor.replace("KIND", kind)


def _handle_first_dimension(arg: arg_class) -> None:
    """Handle the first dimension of an array argument."""
    arg.c_side.to_f_setup = arg.c_side.to_f_setup.replace("DIM1", arg.c_dim1)
    arg.f_side.to_f2_trans = arg.f_side.to_f2_trans.replace("DIM1", arg.f_dim1)
    arg.f_side.test_pat = arg.f_side.test_pat.replace("DIM1", arg.f_dim1)
    arg.f_side.to_c_var = [
        var.replace("DIM1", arg.f_dim1) for var in arg.f_side.to_c_var
    ]
    arg.f_side.to_c_trans = arg.f_side.to_c_trans.replace("DIM1", arg.f_dim1)
    arg.f_side.to_c2_call = arg.f_side.to_c2_call.replace("DIM1", arg.f_dim1)
    arg.c_side.to_c2_set = arg.c_side.to_c2_set.replace("DIM1", arg.c_dim1)
    arg.c_side.constructor = arg.c_side.constructor.replace("DIM1", arg.c_dim1)


def _handle_second_dimension(arg: arg_class) -> None:
    """Handle the second dimension of an array argument."""
    dim2 = str(arg.dim2)
    arg.c_side.to_f_setup = arg.c_side.to_f_setup.replace("DIM2", dim2)
    arg.f_side.to_f2_trans = arg.f_side.to_f2_trans.replace("DIM2", dim2)
    arg.f_side.test_pat = arg.f_side.test_pat.replace("DIM2", dim2)
    arg.f_side.to_c_var = [var.replace("DIM2", dim2) for var in arg.f_side.to_c_var]
    arg.f_side.to_c_trans = arg.f_side.to_c_trans.replace("DIM2", dim2)
    arg.f_side.to_c2_call = arg.f_side.to_c2_call.replace(
        "DIM2", arg.f_dim1 + "*" + dim2
    )
    arg.c_side.to_c2_set = arg.c_side.to_c2_set.replace("DIM2", dim2)
    arg.c_side.constructor = arg.c_side.constructor.replace("DIM2", dim2)


def _handle_third_dimension(arg: arg_class) -> None:
    """Handle the third dimension of an array argument."""
    dim3 = str(arg.dim3)
    arg.c_side.to_f_setup = arg.c_side.to_f_setup.replace("DIM3", dim3)
    arg.f_side.to_f2_trans = arg.f_side.to_f2_trans.replace("DIM3", dim3)
    arg.f_side.test_pat = arg.f_side.test_pat.replace("DIM3", dim3)
    arg.f_side.to_c_var = [var.replace("DIM3", dim3) for var in arg.f_side.to_c_var]
    arg.f_side.to_c_trans = arg.f_side.to_c_trans.replace("DIM3", dim3)
    arg.f_side.to_c2_call = arg.f_side.to_c2_call.replace(
        "DIM3", f"{arg.f_dim1}*{arg.dim2}*{dim3}"
    )
    arg.c_side.to_c2_set = arg.c_side.to_c2_set.replace("DIM3", dim3)
    arg.c_side.constructor = arg.c_side.constructor.replace("DIM3", dim3)


def _handle_init_values(arg: arg_class) -> None:
    """
    Process initialization values for the argument.

    Handles Fortran to C++ initialization value conversion.
    """
    # On Fortran side "complex abc(2) = 0" is allowed but on C++ side want "0.0" for init value.
    # Therefore, ignore "0" as an init value.

    if arg.init_value == "":
        pass
    elif arg.init_value == "0":
        pass
    elif arg.init_value[0] == ">":  # Pointer: '=> null()'
        pass
    elif "_rp" in arg.init_value:
        arg.init_value = arg.init_value.replace("_rp", "")
    elif arg.init_value == ".true.":
        arg.c_side.construct_value = "true"
    elif arg.init_value == ".false.":
        arg.c_side.construct_value = "false"
    elif "$" in arg.init_value:
        arg.c_side.construct_value = "Bmad::" + arg.init_value[:-1].upper()
    elif ("d" in arg.init_value or "D" in arg.init_value) and is_number(arg.init_value):
        arg.c_side.construct_value = arg.init_value.replace("d", "e").replace("D", "e")
    else:
        arg.c_side.construct_value = arg.init_value

    # If there is an array of values, just use first one.
    if len(arg.c_side.construct_value) > 0 and arg.c_side.construct_value[0] == "[":
        arg.c_side.construct_value = arg.c_side.construct_value[1:].split(",")[0]

    # Replace constructor value and CPP_KIND placeholders
    arg.c_side.constructor = arg.c_side.constructor.replace(
        "VALUE", arg.c_side.construct_value
    ).replace(
        "CPP_KIND",
        arg.c_side.c_class.replace("_MATRIX", "").replace("_ARRAY", ""),
    )


def write_parsed_structures(struct_definitions, fn):
    """
    Write parsed structure definitions to a file.
    """
    with open(fn, "wt") as f_out:
        for struct in struct_definitions:
            f_out.write("******************************************\n")
            f_out.write(f"{struct.f_name}    {len(struct.arg)}\n")
            for arg in struct.arg:
                f_out.write(f"    {arg.original_repr()}\n")


def check_missing():
    # Report any structs not found
    missing_structs = [
        struct.f_name for struct in struct_definitions if struct.short_name == ""
    ]
    for name in missing_structs:
        print(f"NOT FOUND: {name}", file=sys.stderr)

    # Exit if any structs are missing
    if n_found < n_total:
        sys.exit("COULD NOT FIND ALL THE STRUCTS! STOPPING HERE!")

    # Create set of defined struct names
    defined_struct_names = {struct.f_name for struct in struct_definitions}
    # Track all missing struct definitions
    missing_struct_definitions = []

    # Check that all referenced struct types have definitions
    for parent_struct in struct_definitions:
        for fld in parent_struct.arg:
            # Skip non-struct fields and externally defined structs
            if fld.type != STRUCT or fld.kind in params.structs_defined_externally:
                continue

            # Check if the struct type is defined
            if fld.kind not in defined_struct_names:
                missing_struct_definitions.append(
                    f"Missing definition for struct '{fld.kind}' which is used in '{parent_struct.short_name}'"
                )

    # Exit with error if any struct definitions are missing
    if missing_struct_definitions:
        for error_message in missing_struct_definitions:
            print(error_message, file=sys.stderr)
        sys.exit(1)


def create_fortran_interface(struct_definitions, params, f_face):
    # Create Fortran side of interface...

    # First the header
    f_face.write("""
!+
! Fortran side of the Bmad / C++ structure interface.
!
! This file is generated by the Bmad/C++ interface code generation.
! The code generation files can be found in cpp_bmad_interface.
!
! DO NOT EDIT THIS FILE DIRECTLY! 
!-

module bmad_cpp_convert_mod

""")

    f_face.write("\n".join(params.conversion_use_statements))

    f_face.write("""
use fortran_cpp_utils
use, intrinsic :: iso_c_binding
""")

    ##############
    # ZZZ_to_f interface

    for struct in struct_definitions:
        f_face.write(
            f"""
!--------------------------------------------------------------------------

interface 
  subroutine {struct.short_name}_to_f (C, Fp) bind(c)
    import c_ptr
    type(c_ptr), value :: C, Fp
  end subroutine
end interface
"""
        )

    f_face.write("\ncontains\n")

    ##############
    # ZZZ_to_c definitions

    for struct in struct_definitions:
        s_name = struct.short_name

        f_face.write(
            f"""
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine {s_name}_to_c (Fp, C) bind(c)
!
! Routine to convert a Bmad {s_name}_struct to a C++ CPP_{s_name} structure
!
! Input:
!   Fp -- type(c_ptr), value :: Input Bmad {s_name}_struct structure.
!
! Output:
!   C -- type(c_ptr), value :: Output C++ CPP_{s_name} struct.
!-

subroutine {s_name}_to_c (Fp, C) bind(c)

implicit none

interface
"""
        )

        to_c2_call_def = {}

        for arg in struct.arg:
            if arg.f_side.to_c2_type not in to_c2_call_def:
                to_c2_call_def[arg.f_side.to_c2_type] = []
            to_c2_call_def[arg.f_side.to_c2_type].append(arg.f_side.to_c2_name)

        line = f"subroutine {s_name}_to_c2 (C"
        for arg in struct.arg:
            line += f", {arg.f_side.to_c2_f2_sub_arg}"
        line += ") bind(c)\n"

        f_face.write("  !! f_side.to_c2_f2_sub_arg\n")
        f_face.write(wrap_line(line, "  ", " &"))
        f_face.write(
            "    import c_bool, c_double, c_ptr, c_char, c_int, c_long, c_double_complex\n"
        )
        f_face.write("    !! f_side.to_c2_type :: f_side.to_c2_name\n")
        f_face.write("    type(c_ptr), value :: C\n")
        for arg_type, args in list(to_c2_call_def.items()):
            for i in range(1 + (len(args) - 1) // 7):
                f_face.write(
                    f"    {arg_type} :: {', '.join(args[i * 7 : i * 7 + 7])}\n"
                )

        f_face.write(
            f"""  end subroutine
end interface

type(c_ptr), value :: Fp
type(c_ptr), value :: C
type({s_name}_struct), pointer :: F
integer jd, jd1, jd2, jd3, lb1, lb2, lb3
"""
        )

        f_face.write("!! f_side.to_c_var\n")
        for arg in struct.arg:
            for var in arg.f_side.to_c_var:
                f_face.write(f"{var}\n")

        f_face.write(
            """
!

call c_f_pointer (Fp, F)

"""
        )

        for arg in struct.arg:
            if arg.f_side.to_c_trans == "":
                continue
            f_face.write(
                f"!! f_side.to_c_trans[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            f_face.write(arg.f_side.to_c_trans)

        f_face.write("\n" + "!! f_side.to_c2_call\n")

        line = f"call {s_name}_to_c2 (C"
        for arg in struct.arg:
            line += f", {arg.f_side.to_c2_call}"
        line += ")"
        f_face.write(wrap_line(line, "", " &"))

        f_face.write(
            f"""
end subroutine {s_name}_to_c

!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine {s_name}_to_f2 (Fp, ...etc...) bind(c)
!
! Routine used in converting a C++ CPP_{s_name} structure to a Bmad {s_name}_struct structure.
! This routine is called by {s_name}_to_c and is not meant to be called directly.
!
! Input:
!   ...etc... -- Components of the structure. See the {s_name}_to_f2 code for more details.
!
! Output:
!   Fp -- type(c_ptr), value :: Bmad {s_name}_struct structure.
!-

"""
        )

        f_face.write("!! f_side.to_c2_f2_sub_arg\n")
        line = f"subroutine {struct.short_name}_to_f2 (Fp"
        for arg in struct.arg:
            line += f", {arg.f_side.to_c2_f2_sub_arg}"
        line += ") bind(c)"
        f_face.write(wrap_line(line, "", " &"))

        f_face.write(f"""

implicit none

type(c_ptr), value :: Fp
type({struct.short_name}_struct), pointer :: F
integer jd, jd1, jd2, jd3, lb1, lb2, lb3
""")

        # Collect arguments by type for cleaner output
        f2_arg_list = {}
        for arg in struct.arg:
            if arg.f_side.to_f2_type not in f2_arg_list:
                f2_arg_list[arg.f_side.to_f2_type] = []
            f2_arg_list[arg.f_side.to_f2_type].append(arg.f_side.to_f2_name)

            # Process additional variables
            for var in arg.f_side.to_f2_var:
                var_type, var_name = [x.strip() for x in var.split("::", 1)]
                if var_type not in f2_arg_list:
                    f2_arg_list[var_type] = []
                f2_arg_list[var_type].append(var_name)

        f_face.write("!! f_side.to_f2_var && f_side.to_f2_type :: f_side.to_f2_name\n")
        for arg_type, arg_list in f2_arg_list.items():
            # Write at most 7 variables per line
            for i in range(0, len(arg_list), 7):
                f_face.write(f"{arg_type} :: {', '.join(arg_list[i : i + 7])}\n")

        f_face.write("""
call c_f_pointer (Fp, F)

""")

        for arg in struct.arg:
            if not arg.f_side.to_f2_trans:
                continue
            f_face.write(
                f"!! f_side.to_f2_trans[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            f_face.write(f"{arg.f_side.to_f2_trans}\n")

        f_face.write(
            f"""
end subroutine {s_name}_to_f2
"""
        )

    ########################
    # End stuff

    f_face.write("end module\n")


def create_fortran_equality_check_code():
    f_equ.write(
        f"""\
!+
! Module {params.equality_mod_file}
!
! This module defines a set of functions which overload the equality operator ("==").
! These functions test for equality between instances of a given structure. 
!
! This file is generated as a by product of the Bmad/C++ interface code generation
! The code generation files can be found in cpp_bmad_interface.
!
! DO NOT EDIT THIS FILE DIRECTLY! 
!- 

module {params.equality_mod_file}
"""
    )

    f_equ.write("\n".join(params.equality_use_statements))

    f_equ.write("""

interface operator (==)
""")

    for i in range(0, len(struct_definitions), 5):
        f_equ.write(
            "  module procedure "
            + ", ".join(f"eq_{f.short_name}" for f in struct_definitions[i : i + 5])
            + "\n"
        )

    f_equ.write("""\
end interface

contains
""")

    for struct in struct_definitions:
        f_equ.write(
            f"""
!--------------------------------------------------------------------------------
!--------------------------------------------------------------------------------

elemental function eq_{struct.short_name} (f1, f2) result (is_eq)

implicit none

type({struct.short_name}_struct), intent(in) :: f1, f2
logical is_eq

!

is_eq = .true.
"""
        )

        for arg in struct.arg:
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue

            f_equ.write(
                f"!! f_side.equality_test[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )

            f_equ.write(arg.f_side.equality_test)

        f_equ.write(f"\nend function eq_{struct.short_name}\n")

    f_equ.write("end module\n")


def write_tests_main(f_test):
    f_test.write("""
program cpp_bmad_interface_test

use bmad_cpp_test_mod

logical ok, all_ok

!

all_ok = .true.
""")

    for struct in struct_definitions:
        f_test.write(
            "call test1_f_"
            + struct.short_name
            + "(ok); if (.not. ok) all_ok = .false.\n"
        )

    f_test.write("""
print *
if (all_ok) then
  print *, 'Bottom Line: Everything OK!'
else
  print *, 'BOTTOM LINE: PROBLEMS FOUND!'
endif

end program
""")


def write_tests_mod(f_test):
    f_test.write(
        f"""
module bmad_cpp_test_mod

use bmad_cpp_convert_mod
use {params.equality_mod_file}
"""
    )

    f_test.write("\n".join(params.test_use_statements) + "\n\n")

    f_test.write("contains\n\n")

    for struct in struct_definitions:
        f_test.write(
            f"""
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_{struct.short_name} (ok)

implicit none

type({struct.short_name}_struct), target :: f_{struct.short_name}, f2_{struct.short_name}
logical(c_bool) c_ok
logical ok

interface
  subroutine test_c_{struct.short_name} (c_{struct.short_name}, c_ok) bind(c)
    import c_ptr, c_bool
    type(c_ptr), value :: c_{struct.short_name}
    logical(c_bool) c_ok
  end subroutine
end interface

!

ok = .true.
call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, 1)

call test_c_{struct.short_name}(c_loc(f2_{struct.short_name}), c_ok)
if (.not. f_logic(c_ok)) ok = .false.

call set_{struct.short_name}_test_pattern (f_{struct.short_name}, 4)
if (f_{struct.short_name} == f2_{struct.short_name}) then
  print *, '{struct.short_name}: C side convert C->F: Good'
else
  print *, '{struct.short_name}: C SIDE CONVERT C->F: FAILED!'
  ok = .false.
endif

end subroutine test1_f_{struct.short_name}

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_{struct.short_name} (c_{struct.short_name}, c_ok) bind(c)

implicit  none

type(c_ptr), value ::  c_{struct.short_name}
type({struct.short_name}_struct), target :: f_{struct.short_name}, f2_{struct.short_name}
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call {struct.short_name}_to_f (c_{struct.short_name}, c_loc(f_{struct.short_name}))

call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, 2)
if (f_{struct.short_name} == f2_{struct.short_name}) then
  print *, '{struct.short_name}: F side convert C->F: Good'
else
  print *, '{struct.short_name}: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)
endif

call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, 3)
call {struct.short_name}_to_c (c_loc(f2_{struct.short_name}), c_{struct.short_name})

end subroutine test2_f_{struct.short_name}

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine set_{struct.short_name}_test_pattern (F, ix_patt)

implicit none

type({struct.short_name}_struct) F
integer ix_patt, offset, jd, jd1, jd2, jd3, lb1, lb2, lb3, rhs

!

offset = 100 * ix_patt

"""
        )

        for i, arg in enumerate(struct.arg, 1):
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            f_test.write(
                f"!! f_side.test_pat[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )

            f_test.write(arg.f_side.test_pat.replace("XXX", str(i)))

        f_test.write(
            f"""
end subroutine set_{struct.short_name}_test_pattern
"""
        )

    f_test.write("""
end module
""")


def write_cpp_classes(file):
    """Write C++ classes definitions for Bmad / C++ structure interface."""
    file.write("""
//+
// C++ classes definitions for Bmad / C++ structure interface.
//
// This file is generated as part of the Bmad/C++ interface code generation.
// The code generation files can be found in cpp_bmad_interface.
//
// DO NOT EDIT THIS FILE DIRECTLY! 
//-

#ifndef CPP_BMAD_CLASSES

#include <complex>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

template<typename T>
using Array = std::vector<std::shared_ptr<T>>;
template<typename T>
using Matrix  = std::vector<Array<T>>;
template<typename T>
using Tensor  = std::vector<Matrix<T>>;

""")

    # Include additional header files
    for line in params.include_header_files:
        file.write(f"{line}\n")

    # Write array/matrix/tensor typedefs for each struct
    for struct in struct_definitions:
        file.write(f"""
class {struct.cpp_class};
using {struct.cpp_class}_ARRAY  = vector<shared_ptr<{struct.cpp_class}>>;
using {struct.cpp_class}_MATRIX = vector<{struct.cpp_class}_ARRAY>;
using {struct.cpp_class}_TENSOR = vector<{struct.cpp_class}_MATRIX>;
""")

    # Write class definitions for each struct
    for struct in struct_definitions:
        file.write(f"""
//--------------------------------------------------------------------
// {struct.cpp_class}

class Opaque_{struct.short_name}_class {{}};  // Opaque class for pointers to corresponding fortran structs.

class {struct.cpp_class} : public std::enable_shared_from_this<{struct.cpp_class}> {{
public:
""")

        # Write class member variables
        for arg in struct.arg:
            if not arg.is_component:
                continue
            file.write(
                f"  {arg.c_side.c_class}{arg.c_side.c_class_suffix} {arg.c_name};\n"
            )

        # Extra methods
        file.write(struct.c_extra_methods)

        # Constructor declaration
        file.write(f"""
  {struct.cpp_class}({struct.c_constructor_arg_list}) :
""")

        # Constructor initialization list
        construct_list = []
        for arg in struct.arg:
            if not arg.is_component:
                continue
            construct_list.append(arg.c_side.constructor)

        file.write(f"    {',\n    '.join(construct_list)}\n")
        constructor_body = struct.c_constructor_body.replace("NAME", struct.cpp_class)

        # if DEBUG:
        debug_constructed = (
            f'std::cout << "{struct.cpp_class}(): " << this << std::endl;'
        )
        if constructor_body:
            constructor_body = "\n".join((debug_constructed, constructor_body))
        else:
            constructor_body = debug_constructed
        file.write(f"    {{{constructor_body}}}\n\n")

        file.write(
            f"  std::shared_ptr<{struct.cpp_class}> getptr() {{ return shared_from_this(); }}"
        )

        # TODO: copy constructor, move constructor, ... = default?
        #
        # Destructor
        file.write("\n")
        file.write(f"  ~{struct.cpp_class}() {{\n")

        # if DEBUG:
        file.write(f'  std::cout << "~{struct.cpp_class}(): " << this << std::endl;\n')

        for arg in struct.arg:
            if arg.c_side.destructor == "":
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            file.write(f"    {arg.c_side.destructor}\n")

        file.write("  }\n")

        # End class and write extern C functions and operators
        file.write(f"""
}};   // End Class

extern "C" void {struct.short_name}_to_c (const Opaque_{struct.short_name}_class*, {struct.cpp_class}&);
extern "C" void {struct.short_name}_to_f (const {struct.cpp_class}&, Opaque_{struct.short_name}_class*);

bool operator== (const {struct.cpp_class}&, const {struct.cpp_class}&);

""")

    # Write end of file
    file.write("""
//--------------------------------------------------------------------

#define CPP_BMAD_CLASSES
#endif
""")


def write_cpp_convert(file):
    """Write C++ classes definitions for Bmad / C++ structure interface."""
    file.write("""
//+
// C++ side of the Bmad / C++ structure interface.
//
// This file is generated as part of the Bmad/C++ interface code generation.
// The code generation files can be found in cpp_bmad_interface.
//
// DO NOT EDIT THIS FILE DIRECTLY! 
//-

#include <iostream>
#include "converter_templates.h"
#include "cpp_bmad_classes.h"

""")

    for struct in struct_definitions:
        # ZZZ_to_f2
        file.write(f"""
//--------------------------------------------------------------------
//--------------------------------------------------------------------
// {struct.cpp_class}

extern "C" void {struct.short_name}_to_c (const Opaque_{struct.short_name}_class*, {struct.cpp_class}&);

""")

        file.write("// c_side.to_f2_arg\n")

        line = f'extern "C" void {struct.short_name}_to_f2 (Opaque_{struct.short_name}_class*'
        for arg in struct.arg:
            line += f", {arg.c_side.to_f2_arg}"
        line += ");"

        file.write(wrap_line(line, "", ""))

        # ZZZ_to_f
        file.write("\n")
        file.write(
            f'extern "C" void {struct.short_name}_to_f (const {struct.cpp_class}& C, Opaque_{struct.short_name}_class* F) {{\n'
        )

        for arg in struct.arg:
            if arg.c_side.to_f_setup == "":
                continue
            file.write(
                f"  // c_side.to_f_setup[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            file.write(arg.c_side.to_f_setup)

        file.write("\n")
        file.write("  // c_side.to_f2_call\n")

        if DEBUG:
            for arg in struct.arg:
                file.write(
                    f"  // {arg.c_side.to_f2_call} == {arg.c_name}: {arg.type} {len(arg.array)} {arg.pointer_type}\n"
                )

        line = f"{struct.short_name}_to_f2 (F"
        for arg in struct.arg:
            line += f", {arg.c_side.to_f2_call}"
        line += ");"
        file.write(wrap_line(line, "  ", ""))

        file.write("\n")

        for arg in struct.arg:
            if arg.c_side.to_f_cleanup == "":
                continue
            file.write(
                f"  // c_side.to_f_cleanup[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            file.write(arg.c_side.to_f_cleanup)

        file.write("}\n")

        # ZZZ_to_c2
        file.write("\n")
        file.write("// c_side.to_c2_arg\n")

        line = f'extern "C" void {struct.short_name}_to_c2 ({struct.cpp_class}& C'
        for arg in struct.arg:
            line += f", {arg.c_side.to_c2_arg}"
        line += ") {"
        file.write(wrap_line(line, "", ""))

        file.write("\n")
        for arg in struct.arg:
            if not arg.is_component:
                continue
            file.write(
                f"  // c_side.to_c2_set[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            file.write(f"{arg.c_side.to_c2_set}\n")

        file.write("}\n")


def write_cpp_equality(header: str, file):
    file.write(header)

    for struct in struct_definitions:
        file.write(
            "\n//--------------------------------------------------------------\n\n"
        )
        file.write(
            f"bool operator== (const {struct.cpp_class}& x, const {struct.cpp_class}& y) {{\n"
        )
        file.write("  bool is_eq = true;\n")

        for arg in struct.arg:
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            file.write(arg.c_side.equality_test)

        file.write("  return is_eq;\n")
        file.write("};\n\n")

        file.write(
            f"template bool is_all_equal (const {struct.cpp_class}_ARRAY&, const {struct.cpp_class}_ARRAY&);\n"
        )
        file.write(
            f"template bool is_all_equal (const {struct.cpp_class}_MATRIX&, const {struct.cpp_class}_MATRIX&);\n"
        )


def write_cpp_test(file):
    file.write("""
//+
// C++ classes definitions for Bmad / C++ structure interface.
//
// This file is generated as part of the Bmad/C++ interface code generation.
// The code generation files can be found in cpp_bmad_interface.
//
// DO NOT EDIT THIS FILE DIRECTLY! 
//-

#include <stdio.h>
#include <iostream>
#include "cpp_bmad_classes.h"

using namespace std;
""")

    for struct in params.structs_defined_externally:
        head = struct.replace("_struct", "")
        file.write(f"void set_CPP_{head}_test_pattern (CPP_{head}& C, int ix_patt);\n")

    for struct in struct_definitions:
        file.write(f"""
//--------------------------------------------------------------
//--------------------------------------------------------------

extern "C" void test2_f_{struct.short_name} ({struct.cpp_class}&, bool&);

void set_{struct.cpp_class}_test_pattern ({struct.cpp_class}& C, int ix_patt) {{

  int rhs, offset = 100 * ix_patt;

""")

        for i, arg in enumerate(struct.arg, 1):
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            file.write(
                f"  // c_side.test_pat[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            file.write(arg.c_side.test_pat.replace("XXX", str(i)) + "\n")

        file.write(f"""
}}

//--------------------------------------------------------------

extern "C" void test_c_{struct.short_name} (Opaque_{struct.short_name}_class* F, bool& c_ok) {{

  {struct.cpp_class} C, C2;

  c_ok = true;

  {struct.short_name}_to_c (F, C);
  set_{struct.cpp_class}_test_pattern (C2, 1);

  if (C == C2) {{
    cout << " {struct.short_name}: C side convert F->C: Good" << endl;
  }} else {{
    cout << " {struct.short_name}: C SIDE CONVERT F->C: FAILED!" << endl;
    c_ok = false;
  }}

  set_{struct.cpp_class}_test_pattern (C2, 2);
  bool c_ok2;
  test2_f_{struct.short_name} (C2, c_ok2);
  if (!c_ok2) c_ok = false;

  set_{struct.cpp_class}_test_pattern (C, 3);
  if (C == C2) {{
    cout << " {struct.short_name}: F side convert F->C: Good" << endl;
  }} else {{
    cout << " {struct.short_name}: F SIDE CONVERT F->C: FAILED!" << endl;
    c_ok = false;
  }}

  set_{struct.cpp_class}_test_pattern (C2, 4);
  {struct.short_name}_to_f (C2, F);

}}
""")


# NOTE: the script is meant to be run from '/cpp_bmad_interface'.
os.chdir(CPP_INTERFACE_ROOT)

if not os.path.exists("include"):
    os.makedirs("include")

if len(sys.argv) > 1:
    master_input_file = sys.argv[1]
    params = __import__(sys.argv[1])
else:
    master_input_file = "interface_input_params"
    import interface_input_params as params

print("Input file: " + master_input_file, file=sys.stderr)

if not os.path.exists(params.test_dir):
    sys.exit("DIRECTORY DOES NOT EXIST: " + params.test_dir)

f_side_trans = initialize_f_side_trans()
c_side_trans = initialize_c_side_trans()

struct_definitions: list[struct_def_class] = []
for name in params.struct_list:
    struct_definitions.append(struct_def_class(name))

parse_structure_definitions(struct_definitions, params)

for struct in struct_definitions:
    remove_untranslated(struct)

for struct in struct_definitions:
    add_array_bound_info_for_pointer_structures(struct)

for struct in struct_definitions:
    print_debug("\nStruct: " + str(struct))
    for arg in struct.arg:
        fix_struct_arg_placeholders(struct, arg)

##################################################################################
# Customize the interface code

params.customize(struct_definitions)

if DEBUG:
    write_parsed_structures(struct_definitions, "f_structs.parsed")

n_found = sum(1 for struct in struct_definitions if struct.short_name != "")
n_total = len(struct_definitions)

# Print diagnostics
print(f"Number of structs in input list: {n_total}", file=sys.stderr)
print(f"Number of structs found:         {n_found}", file=sys.stderr)

check_missing()

with open(params.code_dir + "/bmad_cpp_convert_mod.f90", "w") as file:
    create_fortran_interface(struct_definitions, params, file)
with open(
    os.path.join(params.equality_mod_dir, params.equality_mod_file + ".f90"), "w"
) as f_equ:
    create_fortran_equality_check_code()
with open(os.path.join(params.test_dir, "main.f90"), "w") as file:
    write_tests_main(file)
with open(os.path.join(params.test_dir, "bmad_cpp_test_mod.f90"), "w") as file:
    write_tests_mod(file)
with open(os.path.join("include", "cpp_bmad_classes.h"), "w") as file:
    write_cpp_classes(file)
with open(os.path.join(params.code_dir, "cpp_bmad_convert.cpp"), "w") as file:
    write_cpp_convert(file)
with open(SCRIPTS_PATH / "equality_template.cpp", "r") as file:
    equality_header = file.read()
with open(os.path.join(params.code_dir, "cpp_equality.cpp"), "w") as file:
    write_cpp_equality(equality_header, file)
with open(os.path.join(params.test_dir, "cpp_bmad_test.cpp"), "w") as file:
    write_cpp_test(file)
