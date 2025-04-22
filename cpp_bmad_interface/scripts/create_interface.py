#!/usr/bin/env python3
"""

Note: Run this script in the cpp_bmad_interface directory.

Script to read in Fortran structures and create:
  Corresponding C++ class
  Translator between Fortran structure and C++ class
  Routines to check for equality between instances of a given fortran structure.
  Routines to check for equality between instances of a given C++ class
  Program to check the Fortran / C++ translator

Note: The corresponding C++ class component for a pointer or allocatable Fortran
scalar struct component is an array whose length is zero if the Fortran component
is nullified and whose length is 1 otherwise.
"""

from __future__ import annotations

import copy
import os
import pathlib
import re
import string
import sys
import tempfile
import textwrap
from dataclasses import dataclass, field
from typing import Callable, Literal

import bmad_struct_parser
from bmad_struct_parser import Structure as FortranStructure
from bmad_struct_parser.parser import StructureMember

SCRIPTS_PATH = pathlib.Path(__file__).resolve().parent
CPP_INTERFACE_ROOT = SCRIPTS_PATH.parent
ACC_ROOT_DIR = CPP_INTERFACE_ROOT.parent
STRUCT_PARSER_ROOT = ACC_ROOT_DIR / "structs"

DEFAULT_CONFIG = STRUCT_PARSER_ROOT / "config.yaml"

assert DEFAULT_CONFIG.exists(), f"Default config doesn't exist: {DEFAULT_CONFIG}"

##################################################################################
##################################################################################
# Settings

N_CHAR_MAX = 95
DEBUG = False  # Change to True to enable printout

# Constants

REAL = "real"
CMPLX = "complex"
INT = "integer"
INT8 = "integer8"
LOGIC = "logical"
CHAR = "character"
STRUCT = "type"
SIZE = "size"
ArgumentType = Literal[
    "real", "complex", "integer", "integer8", "logical", "character", "type", "size"
]

NOT = "NOT"
PTR = "PTR"
ALLOC = "ALLOC"
PointerType = Literal["NOT", "PTR", "ALLOC"]

do_not_share_classes = {
    # "CPP_grid_field_pt",
    # "CPP_grid_field_pt1",
    # "CPP_surface_segmented_pt",
    # "CPP_pixel_pt",
    # "CPP_surface_displacement_pt",
    # "CPP_surface_h_misalign_pt",
    # "CPP_surface_segmented_pt",
}

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
    c_instantiation_suffix: str = ""  # EG: '[]'

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

    # C++ class class_initializer initializer list item
    class_initializer: str = "{ VALUE }"
    # C++ class class_initializer initializer value ("VALUE" gets replaced with this)
    construct_value: str = "0"
    # C++ class destructor code
    destructor: str = ""

    # How to compare instances of this type
    equality_test: str = "  is_eq = is_eq && (x.NAME == y.NAME);\n"
    # The pattern to be used in the test suite to fill this instance
    test_pat: str = "  rhs = ARGIDX + offset; C.NAME = TEST_VALUE;\n"
    # The pattern to be used in the test suite to fill this instance
    # "TEST_VALUE" in "test_pat" gets replaced with this.
    test_value: str = ""

    def __str__(self):
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
    test_pat: str = "rhs = ARGIDX + offset; F%NAME = TEST_VALUE\n"
    test_value: str = ""


@dataclass
class Argument:
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
    lbound : List[Any]
        Lower bounds for each array dimension.
    ubound : List[Any]
        Upper bounds for each array dimension.
    init_value : str
        Initialization value.
    comment : str
        Comment from the Fortran structure definition.
    f_side : f_side_trans_class
        Fortran side translation.
    c_side : c_side_trans_class
        C++ side translation.
    """

    is_component: bool = True
    f_name: str = ""
    c_name: str = ""
    type: ArgumentType = "real"
    kind: str = ""
    pointer_type: PointerType = NOT
    array: list[str] = field(default_factory=list)
    init_value: str | None = None
    comment: str = ""
    f_side: f_side_trans_class = field(default_factory=f_side_trans_class)
    c_side: c_side_trans_class = field(default_factory=c_side_trans_class)
    split_line: list[str] = field(default_factory=list)

    # Only for routine parameters:
    intent: Literal["inout", "in", "out", ""] = ""
    optional: bool = False

    @property
    def lbound(self) -> list[str]:
        if not self.array or self.array[0] == ":":
            return []

        return [dim.split(":")[0] if ":" in dim else "1" for dim in self.array]

    @property
    def ubound(self) -> list[str]:
        if not self.array or self.array[0] == ":":
            return []

        return [dim.split(":")[1] if ":" in dim else dim for dim in self.array]

    def get_dim1(self) -> tuple[str, str]:
        if self.ubound[0][-1] == "$":
            f_dim1 = self.ubound[0]
            c_dim1 = "Bmad::" + self.ubound[0][0:-1].upper()
            if self.lbound[0] != "1":
                print('lbound not "1" with parameter upper bound!', file=sys.stderr)
                sys.exit("STOPPING HERE")
            if self.ubound[0].lower() == "num_ele_attrib$":
                # NOTE: special case: this is an element attributes array, and we intend
                # to keep the array indices the same from C++/Fortran.
                return "num_ele_attrib$", "Bmad::NUM_ELE_ATTRIB+1"
        else:
            f_dim1 = str(1 + int(self.ubound[0]) - int(self.lbound[0]))
            c_dim1 = f_dim1
        return f_dim1, c_dim1

    @property
    def c_dims(self):
        if not self.array:
            return ()
        if len(self.array) == 1:
            return (self.c_dim1,)
        if len(self.array) == 2:
            return (self.c_dim1, self.dim2)
        if len(self.array) == 3:
            return (self.c_dim1, self.dim2, self.dim3)
        raise NotImplementedError(len(self.array))

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

    def should_translate(self, struct_name: str) -> bool:
        return (
            self.kind not in params.component_no_translate_list
            and f"{struct_name}%{self.f_name}" not in params.component_no_translate_list
        )

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
        self.c_side.class_initializer = self.c_side.class_initializer.replace(
            "NAME", self.c_name
        )
        self.c_side.destructor = self.c_side.destructor.replace("NAME", self.c_name)

    def _replace_string_length_placeholders(self) -> None:
        """Replace STR_LEN placeholders with the argument's kind."""
        self.c_side.test_pat = self.c_side.test_pat.replace("STR_LEN", self.kind)
        self.f_side.to_c_var = [
            var.replace("STR_LEN", self.kind) for var in self.f_side.to_c_var
        ]

    def _handle_lbound(self, struct: Structure) -> None:
        """Handle the lower bound replacement."""
        id_name = struct.short_name + "%" + self.f_name
        lbound = params.f_side_lbound(id_name)
        self.f_side.to_f2_trans = self.f_side.to_f2_trans.replace("LBOUND", lbound)

    def _handle_type_argument(self) -> None:
        """Process 'type' arguments by replacing KIND placeholders."""
        kind = self.kind[:-7]
        if not kind:
            raise RuntimeError("Kind is empty?")
        self.f_side.to_f2_trans = self.f_side.to_f2_trans.replace("KIND", kind)
        self.f_side.to_f2_var = [
            var.replace("KIND", kind) for var in self.f_side.to_f2_var
        ]
        self.f_side.test_pat = self.f_side.test_pat.replace("KIND", kind)
        self.c_side.test_pat = self.c_side.test_pat.replace("KIND", kind)
        self.c_side.c_class = self.c_side.c_class.replace("KIND", kind)
        self.c_side.to_c2_set = self.c_side.to_c2_set.replace("KIND", kind)
        self.c_side.to_f_setup = self.c_side.to_f_setup.replace("KIND", kind)
        self.c_side.to_f2_arg = self.c_side.to_f2_arg.replace("KIND", kind)
        self.c_side.to_c2_arg = self.c_side.to_c2_arg.replace("KIND", kind)
        self.c_side.class_initializer = self.c_side.class_initializer.replace(
            "KIND", kind
        )

    def _handle_first_dimension(self) -> None:
        """Handle the first dimension of an array argument."""
        if not self.lbound:
            return
        self.c_side.to_f_setup = self.c_side.to_f_setup.replace("DIM1", self.c_dim1)
        self.f_side.to_f2_trans = self.f_side.to_f2_trans.replace("DIM1", self.f_dim1)
        self.f_side.test_pat = self.f_side.test_pat.replace("DIM1", self.f_dim1)
        self.f_side.to_c_var = [
            var.replace("DIM1", self.f_dim1) for var in self.f_side.to_c_var
        ]
        self.f_side.to_c_trans = self.f_side.to_c_trans.replace("DIM1", self.f_dim1)
        self.f_side.to_c2_call = self.f_side.to_c2_call.replace("DIM1", self.f_dim1)
        self.c_side.to_c2_set = self.c_side.to_c2_set.replace("DIM1", self.c_dim1)
        self.c_side.class_initializer = self.c_side.class_initializer.replace(
            "DIM1", self.c_dim1
        )
        self.c_side.c_instantiation_suffix = self.c_side.c_instantiation_suffix.replace(
            "DIM1", self.c_dim1
        )
        self.c_side.c_class = self.c_side.c_class.replace("DIM1", self.c_dim1)

    def _handle_second_dimension(self) -> None:
        """Handle the second dimension of an array argument."""
        if not self.lbound:
            return
        dim2 = str(self.dim2)
        self.c_side.to_f_setup = self.c_side.to_f_setup.replace("DIM2", dim2)
        self.f_side.to_f2_trans = self.f_side.to_f2_trans.replace("DIM2", dim2)
        self.f_side.test_pat = self.f_side.test_pat.replace("DIM2", dim2)
        self.f_side.to_c_var = [
            var.replace("DIM2", dim2) for var in self.f_side.to_c_var
        ]
        self.f_side.to_c_trans = self.f_side.to_c_trans.replace("DIM2", dim2)
        self.f_side.to_c2_call = self.f_side.to_c2_call.replace(
            "DIM2", self.f_dim1 + "*" + dim2
        )
        self.c_side.to_c2_set = self.c_side.to_c2_set.replace("DIM2", dim2)
        self.c_side.class_initializer = self.c_side.class_initializer.replace(
            "DIM2", dim2
        )
        self.c_side.c_instantiation_suffix = self.c_side.c_instantiation_suffix.replace(
            "DIM2", dim2
        )
        self.c_side.c_class = self.c_side.c_class.replace("DIM2", str(self.dim2))

    def _handle_third_dimension(self) -> None:
        """Handle the third dimension of an array argument."""
        if not self.lbound:
            return
        dim3 = str(self.dim3)
        self.c_side.to_f_setup = self.c_side.to_f_setup.replace("DIM3", dim3)
        self.f_side.to_f2_trans = self.f_side.to_f2_trans.replace("DIM3", dim3)
        self.f_side.test_pat = self.f_side.test_pat.replace("DIM3", dim3)
        self.f_side.to_c_var = [
            var.replace("DIM3", dim3) for var in self.f_side.to_c_var
        ]
        self.f_side.to_c_trans = self.f_side.to_c_trans.replace("DIM3", dim3)
        self.f_side.to_c2_call = self.f_side.to_c2_call.replace(
            "DIM3", f"{self.f_dim1}*{self.dim2}*{dim3}"
        )
        self.c_side.to_c2_set = self.c_side.to_c2_set.replace("DIM3", dim3)
        self.c_side.class_initializer = self.c_side.class_initializer.replace(
            "DIM3", dim3
        )
        self.c_side.c_instantiation_suffix = self.c_side.c_instantiation_suffix.replace(
            "DIM3", dim3
        )
        self.c_side.c_class = self.c_side.c_class.replace("DIM3", str(self.dim3))

    def _handle_init_values(self) -> None:
        """
        Process initialization values for the argument.

        Handles Fortran to C++ initialization value conversion.
        """
        # On Fortran side "complex abc(2) = 0" is allowed but on C++ side want "0.0" for init value.
        # Therefore, ignore "0" as an init value.

        if not self.init_value:
            pass
        elif self.init_value == "0":
            pass
        elif self.init_value[0] == ">":  # Pointer: '=> null()'
            pass
        elif "_rp" in self.init_value:
            self.init_value = self.init_value.replace("_rp", "")
        elif self.init_value == ".true.":
            self.c_side.construct_value = "true"
        elif self.init_value == ".false.":
            self.c_side.construct_value = "false"
        elif self.init_value.startswith("'"):
            self.c_side.construct_value = self.init_value.replace("'", '"')
        elif self.init_value == "pi":
            self.c_side.construct_value = "Bmad::pi"
        elif "$" in self.init_value:
            self.c_side.construct_value = "Bmad::" + self.init_value[:-1].upper()
        elif ("d" in self.init_value or "D" in self.init_value) and is_number(
            self.init_value
        ):
            self.c_side.construct_value = self.init_value.replace("d", "e").replace(
                "D", "e"
            )
        else:
            self.c_side.construct_value = self.init_value

        # If there is an array of values, just use first one.
        if (
            len(self.c_side.construct_value) > 0
            and self.c_side.construct_value[0] == "["
        ):
            self.c_side.construct_value = self.c_side.construct_value[1:].split(",")[0]

        # Replace class_initializer value and CPP_KIND placeholders
        self.c_side.class_initializer = self.c_side.class_initializer.replace(
            "VALUE", self.c_side.construct_value
        ).replace("CPP_KIND", self.c_side.c_class)

    def fix_struct_arg_placeholders(self, struct: Structure) -> None:
        """
        Substitute placeholder names in argument patterns with actual values.

        This function processes an argument object, replacing placeholders like "NAME", "DIM1", etc.,
        with the actual values relevant to the structure and argument.

        Parameters
        ----------
        struct : Structure
            The structure definition containing the argument
        """
        print_debug("self: " + str(self))
        p_type = self.pointer_type

        # Replace string length placeholders
        self._replace_string_length_placeholders()

        # Handle array bounds
        self._handle_lbound(struct)

        # Handle 'type' arguments
        if self.type == "type":
            self._handle_type_argument()

        # Handle array dimensions
        if p_type == NOT:
            # not a pointer/dynamically allocated type;
            # replace DIM1, DIM2, DIM3 here
            if len(self.array) >= 1:
                self._handle_first_dimension()

            if len(self.array) >= 2:
                self._handle_second_dimension()

            if len(self.array) >= 3:
                self._handle_third_dimension()

        # Replace name placeholders
        self.replace_name_placeholders()

        # Handle initialization values
        self._handle_init_values()

    def original_repr(self) -> str:
        return '["{}({})", "{}", "{}", {}, {} {} "{}"]'.format(
            self.type,
            self.kind,
            self.pointer_type,
            self.f_name,
            self.array,
            self.lbound,
            self.ubound,
            self.init_value,
        )


@dataclass
class Structure:
    f_name: str = ""  # Struct name on Fortran side
    short_name: str = ""  # Struct name without trailing '_struct'. Note: C++ name is 'CPP_<short_name>'
    cpp_class: str = ""  # C++ name.
    arg: list[Argument] = field(
        default_factory=list
    )  # List of structrure components + array bound dimensions.
    c_constructor_arg_list: str = ""
    c_constructor_body: str = ""  # Body of the C++ class_initializer
    c_extra_methods: str = ""  # Additional custom methods

    def __str__(self) -> str:
        return "[name: %s, #arg: %i]" % (self.short_name, len(self.arg))

    @property
    def by_f_name(self) -> dict[str, Argument]:
        return {arg.f_name for arg in self.arguments}


@dataclass
class Subroutine(Structure):
    # Reusing Structure as a base class, for better or worse...
    arg_order: list[str] = field(default_factory=list)  # arguments, as defined in the
    result_arg: str = ""


x2 = " " * 2
x4 = " " * 4
x6 = " " * 6
x8 = " " * 8

jd1_loop = "do jd1 = 1, size(F%NAME,1); lb1 = lbound(F%NAME,1) - 1\n"
jd2_loop = "do jd2 = 1, size(F%NAME,2); lb2 = lbound(F%NAME,2) - 1\n"
jd3_loop = "do jd3 = 1, size(F%NAME,3); lb3 = lbound(F%NAME,3) - 1\n"

rhs1 = "  rhs = 100 + jd1 + ARGIDX + offset\n"
rhs2 = "  rhs = 100 + jd1 + 10*jd2 + ARGIDX + offset\n"
rhs3 = "  rhs = 100 + jd1 + 10*jd2 + 100*jd3 + ARGIDX + offset\n"

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
    # f.test_pat = f.test_pat.replace("TEST_VALUE", f.test_value)
    if f.to_f2_type == "":
        f.to_f2_type = f.to_c2_type
    if f.to_f2_name == "":
        f.to_f2_name = f.to_c2_name

    f.to_c2_type = "TO_C2_TYPE"
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
    fp.to_f2_var = ["TO_F2_TYPE, pointer :: f_NAME(:)"]

    # ---------------------
    # Pointer, dim = 0

    if dim == 0:
        fp.to_f2_var = ["TO_F2_TYPE, pointer :: f_NAME"]
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
  rhs = ARGIDX + offset
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
                set1,  # .replace("TEST_VALUE", f.test_value),
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
            + set2  # .replace("TEST_VALUE", f.test_value)
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
            + set3  # .replace("TEST_VALUE", f.test_value)
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
        '  F%NAME(jd1:jd1) = char(ichar("a") + modulo(100+ARGIDX+offset+jd1, 26))\n'
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
    F%NAME(jd1:jd1) = char(ichar("a") + modulo(100+ARGIDX+offset+jd1, 26))
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
    F%NAME(jd1)(jd:jd) = char(ichar("a") + modulo(100+ARGIDX+offset+10*jd+jd1, 26))
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
    F%NAME(jd1)(jd:jd) = char(ichar("a") + modulo(100+ARGIDX+offset+10*jd+jd1, 26))
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

test_pat1 = (
    for1 + "\n    {int rhs = 101 + i + ARGIDX + offset; C.NAME[i] = TEST_VALUE;}"
)
test_pat2 = (
    for1
    + for2
    + "\n    {int rhs = 101 + i + 10*(j+1) + ARGIDX + offset; C.NAME[i][j] = TEST_VALUE;}"
)
test_pat3 = (
    for1
    + for2
    + for3
    + "\n"
    + x4
    + "{int rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset; C.NAME[i][j][k] = TEST_VALUE;}"
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

    c_type = "C_TYPE"
    c_arg = "C_ARG"

    # Configure based on dimension
    if dim == 0:
        configure_c_dim0_non_ptr(c, c_type, c_arg, type)
    elif dim == 1:
        configure_c_dim1_non_ptr(c, c_type, c_arg, type)
    elif dim == 2:
        configure_c_dim2_non_ptr(c, c_type, c_arg, type)
    elif dim == 3:
        configure_c_dim3_non_ptr(c, c_type, c_arg, type)

    # Apply test pattern
    c.test_pat = c.test_pat  # .replace("TEST_VALUE", c.test_value)

    # Special handling for STRUCT type
    if type == STRUCT:
        c.to_c2_arg = "const Opaque_KIND_class* z_NAME"
        if dim > 0:
            c.to_f2_arg = c.to_f2_arg.replace("Arr", "**")
            c.to_c2_arg = "const Opaque_KIND_class** z_NAME"
            c.to_f2_call = "z_NAME"


def configure_c_dim0_non_ptr(c, c_type, c_arg, type):
    """Configure for dimension 0"""
    c.c_class = c_type
    c.to_f2_arg = c_arg + "&"
    c.to_f2_call = "C.NAME"
    c.to_c2_arg = c_arg + "& z_NAME"

    if type == STRUCT:
        c.class_initializer = ""
        c.to_c2_set = "  KIND_to_c(z_NAME, C.NAME);"
        c.test_pat = "  set_CPP_KIND_test_pattern(C.NAME, ix_patt);\n"


def configure_c_dim1_non_ptr(c, c_type, c_arg, type):
    """Configure for dimension 1"""
    c.c_class = f"FixedArray1D<{c_type}, DIM1>"
    c.c_instantiation_suffix = "{VALUE}"
    c.to_f2_arg = c_arg + "Arr"
    c.to_f2_call = "&C.NAME[0]"
    c.to_c2_arg = c_arg + "Arr z_NAME"
    c.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"

    if type == STRUCT:
        c.class_initializer = ""
        c.to_c2_set = "\n".join(
            (
                "for (size_t i = 0; i < C.NAME.size(); i++)",
                "{ KIND_to_c(z_NAME[i], C.NAME[i]); }",
            )
        )
        c.test_pat = test_pat1.replace(
            "C.NAME[i] = TEST_VALUE",
            "set_CPP_KIND_test_pattern(C.NAME[i], ix_patt+i+1)",
        )
        c.to_f_setup = """\
  const CPP_KIND* z_NAME[DIM1];
  for (int i = 0; i < DIM1; i++) {z_NAME[i] = &C.NAME[i];}
"""
    else:
        c.to_c2_set = "  C.NAME << z_NAME;"
        c.test_pat = test_pat1


def configure_c_dim2_non_ptr(c, c_type, c_arg, type):
    """Configure for dimension 2"""
    c.c_class = f"FixedArray2D<{c_type}, DIM1, DIM2>"
    c.to_f2_arg = c_arg + "Arr"
    c.to_f2_call = "z_NAME"
    c.to_c2_arg = c_arg + "Arr z_NAME"
    c.class_initializer = ""
    c.to_c2_set = "  C.NAME << z_NAME;"
    c.test_pat = test_pat2
    c.to_f_setup = (
        "  " + c_type + " z_NAME[DIM1*DIM2]; matrix_to_vec(C.NAME, z_NAME);\n"
    )
    c.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"

    if type == STRUCT:
        c.c_class = f"SharedVector2D<{c_type}>"
        c.to_c2_set = (
            for1
            + for2
            + "\n    {auto m = DIM2*i + j; KIND_to_c(z_NAME[m], *C.NAME[i][j].get());}"
        )
        c.test_pat = test_pat2.replace(
            "C.NAME[i][j] = TEST_VALUE",
            "set_CPP_KIND_test_pattern(*C.NAME[i][j], ix_patt+i+1+10*(j+1))",
        )
        c.to_f_setup = (
            "  const CPP_KIND* z_NAME[DIM1*DIM2];\n"
            + for1
            + for2
            + "\n    {auto m = DIM2*i + j; z_NAME[m] = C.NAME[i][j].get();}\n"
        )


def configure_c_dim3_non_ptr(c, c_type, c_arg, type):
    """Configure for dimension 3"""
    c.c_class = f"FixedArray3D<{c_type}, DIM1, DIM2, DIM3>"
    c.to_f2_arg = c_arg + "Arr"
    c.to_f2_call = "z_NAME"
    c.to_c2_arg = c_arg + "Arr z_NAME"
    c.class_initializer = ""
    c.to_c2_set = "  C.NAME << z_NAME;"
    c.test_pat = test_pat3
    c.to_f_setup = (
        "  " + c_type + " z_NAME[DIM1*DIM2*DIM3]; tensor_to_vec(C.NAME, z_NAME);\n"
    )
    c.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"

    if type == STRUCT:
        c.c_class = f"SharedVector3D<{c_type}>"
        c.to_c2_set = (
            for1
            + for2
            + for3
            + "\n    {auto m = DIM3*DIM2*i + DIM3*j + k; KIND_to_c(z_NAME[m], *C.NAME[i][j][k].get());}"
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
            + "\n    {auto m = DIM3*DIM2*i + DIM3*j + k; z_NAME[m] = C.NAME[i][j][k].get();}\n"
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
        configure_c_dim0_ptr(cp, c, c_type, type)
    elif dim == 1:
        configure_c_dim1_ptr(cp, c, c_type, type)
    elif dim == 2:
        configure_c_dim2_ptr(cp, c, c_type, type)
    elif dim == 3:
        configure_c_dim3_ptr(cp, c, c_type, type)
    else:
        raise NotImplementedError(dim)

    # cp.test_pat = cp.test_pat.replace("TEST_VALUE", c.test_value)


def configure_c_dim0_ptr(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 0"""
    cp.c_class = f"shared_ptr<{cp.c_class}>"
    cp.class_initializer = "nullptr"
    cp.destructor = ""
    cp.test_pat = "\n".join(
        (
            "  if (ix_patt < 3) ",
            "    C.NAME = nullptr;",
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


def configure_c_dim1_ptr(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 1"""
    cp.c_class = f"VariableArray1D<{c_type}>"
    cp.class_initializer = ""  # cp.class_initializer.replace("DIM1", "0")
    cp.c_instantiation_suffix = ""
    cp.to_f2_call = "z_NAME"
    cp.to_c2_set = """
  C.NAME.resize(n1_NAME);
  C.NAME << z_NAME;
"""
    cp.test_pat = test_pat_pointer1 + indent(c.test_pat, 2) + "  }\n"
    cp.to_f_setup = """\
  auto n1_NAME = C.NAME.size();
  c_TYPEArr z_NAME = nullptr;
  if (n1_NAME > 0) {
    z_NAME = &C.NAME[0];
  }
""".replace("TYPE", c_type)

    if type == STRUCT:
        cp.class_initializer = ""
        cp.test_pat = (
            test_pat_pointer1
            + x2
            + for1
            + "  {set_CPP_KIND_test_pattern(C.NAME[i], ix_patt+i+1);}\n"
            + "  }\n"
        )
        cp.to_f_setup = """\
  auto n1_NAME = C.NAME.size();
  const CPP_KIND** z_NAME = nullptr;
  if (n1_NAME != 0) {
    z_NAME = new const CPP_KIND*[n1_NAME];
    for (auto i{0}; i < n1_NAME; i++) z_NAME[i] = &C.NAME[i];
  }
"""
        cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) { KIND_to_c(z_NAME[i], C.NAME[i]); }
"""
        cp.to_f_cleanup = "  if (z_NAME) delete[] z_NAME;\n"


def configure_c_dim2_ptr(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 2"""
    cp.c_class = f"VariableArray2D<{c_type}>"
    cp.class_initializer = cp.class_initializer.replace("DIM1", "0").replace(
        "DIM2", "0"
    )
    cp.c_instantiation_suffix = ""
    cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i].resize(n2_NAME);
  C.NAME << z_NAME;
"""
    cp.test_pat = (
        test_pat_pointer1
        + indent((for1 + "\n    C.NAME[i].resize(2);\n" + c.test_pat), 2)
        + "  }\n"
    )
    cp.to_f_cleanup = "  delete z_NAME;\n"
    cp.to_f_setup = """\
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  TYPE* z_NAME = nullptr;
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new TYPE [n1_NAME*n2_NAME];
    matrix_to_vec (C.NAME, z_NAME);
  }
""".replace("TYPE", c_type)
    cp.to_f_cleanup = "  if (z_NAME) delete[] z_NAME;\n"

    if type == STRUCT:
        cp.test_pat = (
            test_pat_pointer1
            + """\
    for (size_t i = 0; i < C.NAME.size(); i++) {
      C.NAME[i].resize(2);\n
      for (size_t j = 0; j < C.NAME[0].size(); j++) {
        auto &item = C.NAME[i][j];
        set_CPP_KIND_test_pattern(item, ix_patt+i+2*j+3);
      }
    }
  }
"""
        )
        cp.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (auto j{0}; j < n2_NAME; j++) {
        auto &item = C.NAME[i][j];
        KIND_to_c(z_NAME[n2_NAME*i+j], item);
    }
  }
"""
        cp.to_f_setup = """
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  const TYPE** z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    z_NAME = new const TYPE* [n1_NAME*n2_NAME];
    for (auto i{0}; i < n1_NAME; i++) {
      for (auto j{0}; j < n2_NAME; j++) {
        z_NAME[i*n2_NAME + j] = &C.NAME[i][j];
      }
    }
  }
""".replace("TYPE", c_type)


def configure_c_dim3_ptr(
    cp: c_side_trans_class, c: c_side_trans_class, c_type: str, type: str
):
    """Configure pointer for dimension 3"""
    cp.c_class = f"VariableArray3D<{c_type}>"
    cp.c_instantiation_suffix = ""
    cp.class_initializer = (
        cp.class_initializer.replace("DIM1", "0")
        .replace("DIM2", "0")
        .replace("DIM3", "0")
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
          auto rhs = 101 + i + 10*(j+1) + 100*(k+1) + ARGIDX + offset;
          C.NAME[i][j][k] = TEST_VALUE;
        }
      }
    }
  }
"""

    cp.to_f_cleanup = "  delete z_NAME;\n"
    cp.to_f_setup = """
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  TYPE* z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new TYPE [C.NAME.size()*C.NAME[0].size()*C.NAME[0][0].size()];
    tensor_to_vec (C.NAME, z_NAME);
  }
""".replace("TYPE", c_type)
    cp.to_f_cleanup = "  if (z_NAME) delete[] z_NAME;\n"

    if type == STRUCT:
        cp.to_c2_set = """
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) {
    C.NAME[i].resize(n2_NAME);
    for (auto j{0}; j < n2_NAME; j++) {
      C.NAME[i][j].resize(n3_NAME);
      for (auto k{0}; k < n3_NAME; k++) {
        // C.NAME[i][j][k] = make_shared<CPP_KIND>();
        KIND_to_c(z_NAME[n3_NAME*n2_NAME*i+n3_NAME*j+k], C.NAME[i][j][k]);
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
          // C.NAME[i][j][k] = make_shared<CPP_KIND>();
          set_CPP_KIND_test_pattern(C.NAME[i][j][k], ix_patt+i+2*j+3*k+6);
        }
      }
    }
  }
"""
        cp.to_f_setup = """
  auto n1_NAME { C.NAME.size() };
  auto n2_NAME { std::size_t{0} };
  auto n3_NAME { std::size_t{0} };
  const TYPE** z_NAME { nullptr };
  if (n1_NAME > 0) {
    n2_NAME = C.NAME[0].size();
    n3_NAME = C.NAME[0][0].size();
    z_NAME = new const TYPE* [n1_NAME*n2_NAME*n3_NAME];
    for (auto i{0}; i < n1_NAME; i++) {
      for (auto j{0}; j < n2_NAME; j++) {
        for (auto k{0}; k < n3_NAME; k++) {
          z_NAME[i*n2_NAME*n3_NAME + j*n3_NAME + k] = &C.NAME[i][j][k];
        }
      }
    }
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
                    "C_TYPE",  # get_c_type(type_val), # TODO
                    "C_ARG",  # TODO #  get_c_arg(type_val),
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
        + test_pat1  # .replace("TEST_VALUE", "'a' + rhs % 26")
    )
    # c_side_trans[CHAR, 0, NOT].class_initializer = ""


def setup_char_pointer(c_side_trans):
    """Set up translation for CHAR, 0, PTR (character scalar pointer)."""
    c_side_trans[CHAR, 0, PTR] = copy.deepcopy(c_side_trans[STRUCT, 0, PTR])
    cc = c_side_trans[CHAR, 0, PTR]
    cc.c_class = "shared_ptr<string>"
    cc.destructor = ""
    cc.to_f2_call = "z_NAME"
    cc.to_f2_arg = "c_Char"
    cc.to_f_setup = """\
  size_t n_NAME = 0;
  const char* z_NAME = nullptr;
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
      (*C.NAME)[i] = 'a' + (101 + i + ARGIDX + offset) % 26; }
  }
"""


def setup_char_array(c_side_trans):
    """Set up translation for CHAR, 1, NOT (character array, not pointer)."""
    c_side_trans[CHAR, 1, NOT] = c_side_trans_class()
    cc = c_side_trans[CHAR, 1, NOT]
    cc.c_class = "FixedArray1D<string, DIM1>"
    cc.to_f2_arg = "c_Char*"
    cc.to_f_setup = """\
  c_Char z_NAME[DIM1];
  for (auto i{0}; i < DIM1; i++) {z_NAME[i] = C.NAME[i].c_str();}
"""
    cc.to_c2_arg = "c_Char* z_NAME"
    cc.test_pat = (
        for1
        + """ {
    C.NAME[i].resize(STR_LEN);
    for (size_t j = 0; j < C.NAME[i].size(); j++) 
      {C.NAME[i][j] = 'a' + (101 + i + 10*(j+1) + ARGIDX + offset) % 26;}
  }
"""
    )
    cc.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"
    cc.to_f2_call = c_side_trans[STRUCT, 1, NOT].to_f2_call
    cc.to_c2_set = for1 + " C.NAME[i] = z_NAME[i];"


def setup_char_array_pointer(c_side_trans):
    """Set up translation for CHAR, 1, PTR (character array pointer)."""
    c_side_trans[CHAR, 1, PTR] = copy.deepcopy(c_side_trans[STRUCT, 1, PTR])
    cc = c_side_trans[CHAR, 1, PTR]
    cc.c_class = "VariableArray1D<string>"
    cc.destructor = ""
    cc.equality_test = "  is_eq = is_eq && is_all_equal(x.NAME, y.NAME);\n"
    cc.to_f2_arg = "c_Char*"
    cc.to_c2_arg = "c_Char* z_NAME"
    cc.to_f_setup = """\
  auto n1_NAME{ C.NAME.size() };
  c_Char* z_NAME = nullptr;
  if (n1_NAME != 0) {
    z_NAME = new c_Char[n1_NAME];
    for (auto i{0}; i < n1_NAME; i++) z_NAME[i] = C.NAME[i].c_str();
  }
"""
    cc.to_c2_set = """\
  C.NAME.resize(n1_NAME);
  for (auto i{0}; i < n1_NAME; i++) C.NAME[i] = z_NAME[i];
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
        + "C.NAME[i][j] = 'a' + (101 + i + 10*(j+1) + ARGIDX + offset) % 26;\n"
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
re_end_type = re.compile(
    r"^\s*end\s+(type|subroutine)"
)  # Match to: 'end type' or 'end subroutine'
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
def argument_from_fstruct(
    fstruct: FortranStructure, member: StructureMember
) -> Argument:
    if member.size and member.type.lower() == "integer":
        type_ = INT8
    else:
        type_ = member.type

    if member.type_info.pointer:
        pointer_type = PTR
    elif member.type_info.allocatable:
        pointer_type = ALLOC
    else:
        pointer_type = NOT

    return Argument(
        is_component=True,
        f_name=member.name,
        c_name=params.c_side_name_translation.get(
            f"{fstruct.name}%{member.name}", member.name
        ),
        type=type_,
        kind=member.kind or "",
        pointer_type=pointer_type,
        array=member.dimension.replace(" ", "").split(",") if member.dimension else [],
        init_value=str(member.fortran_default) if member.fortran_default else None,
        comment=member.comment,
    )


def arguments_from_fstruct(fstruct: FortranStructure) -> list[Argument]:
    return [
        argument_from_fstruct(fstruct, member)
        for name, member in fstruct.info.members.items()
    ]


def match_structure_definition(
    fortran_structures: list[FortranStructure],
    struct: Structure,
):
    for fstruct in fortran_structures:
        if struct.f_name == fstruct.name:
            break
    else:
        raise RuntimeError(f"Structure not found: {struct.f_name}")

    struct.f_name = fstruct.name
    struct.short_name = fstruct.name.removesuffix("_struct")
    struct.cpp_class = "CPP_" + struct.short_name
    struct.arg = arguments_from_fstruct(fstruct)


def set_translations(struct: Structure) -> None:
    # Throw out any sub-structures that are not to be translated
    struct.arg = [arg for arg in struct.arg if arg.should_translate(struct.f_name)]

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

        arg_full_name = f"{struct.f_name}%{arg.f_name}"

        try:
            arg.f_side = f_side_trans_custom_overrides[arg_full_name]
        except KeyError:
            arg.f_side = copy.deepcopy(f_side_trans[translation_key])
        try:
            arg.c_side = c_side_trans_custom_overrides[arg_full_name]
        except KeyError:
            arg.c_side = copy.deepcopy(c_side_trans[translation_key])


def add_array_bound_info_for_pointer_structures(struct: Structure) -> None:
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
                size_arg = Argument()
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
                size_arg = Argument()
                size_arg.is_component = False
                size_arg.type = "integer"
                size_arg.f_side = copy.deepcopy(f_side_trans[SIZE, dim, NOT])
                size_arg.c_side = copy.deepcopy(c_side_trans[SIZE, dim, NOT])
                size_arg.f_name = f"n{dim}_" + arg.f_name
                size_arg.c_name = f"n{dim}_" + arg.c_name

                struct.arg.insert(ia, size_arg)
                ia += 1


# def parse_bmad_routine_file(fortran_code):
#     """
#     Parse a Fortran file containing subroutines and return a dictionary
#     mapping subroutine names to their content.
#     """
#     subroutine_blocks = {}
#
#     # Split the code into lines
#     lines = fortran_code.strip().split("\n")
#
#     current_subroutine = None
#     current_content = []
#
#     for line in lines:
#         line = line.strip()
#         lower = line.lower()
#         if lower.startswith("subroutine ") or lower.startswith("recursive subroutine "):
#             if lower.startswith("recursive "):
#                 lower = lower.removeprefix("recursive ")
#             # If we were already collecting a subroutine, save it before starting a new one
#             if current_subroutine:
#                 subroutine_blocks[current_subroutine] = "\n".join(current_content)
#
#             subroutine_name = line.split()[1].split("(")[0]
#             arguments = tuple(
#                 arg.strip() for arg in line.split("(")[1].rstrip(")").split(",")
#             )
#             current_subroutine = (subroutine_name, arguments)
#             current_content = [line]
#         elif line.lower().startswith("end subroutine"):
#             current_content.append(line)
#             assert current_subroutine is not None
#             subroutine_blocks[current_subroutine] = "\n".join(current_content)
#             current_subroutine = None
#             current_content = []
#         elif current_subroutine:
#             current_content.append(line)
#
#     # In case there's a final subroutine without an explicit end
#     if current_subroutine:
#         subroutine_blocks[current_subroutine] = "\n".join(current_content)
#
#     return subroutine_blocks


# def parse_bmad_routines(params):
#     subroutines = {}
#
#     for fn in params.routine_interface_files:
#         fortran_code = pathlib.Path(fn).read_text()
#         lines = fortran_code.splitlines()
#         lines = lines[lines.index("interface") :]
#         lines = lines[: lines.index("end interface")]
#         name_to_subroutine_contents = parse_bmad_routine_file("\n".join(lines))
#
#         for (name, args), contents in name_to_subroutine_contents.items():
#             subroutine = Subroutine(name, arg_order=args)
#             parse_struct_components(
#                 lines=[
#                     line.strip()
#                     for line in contents.splitlines()[1:]
#                     if line.strip() and line.strip() not in ("import", "implicit none")
#                 ],
#                 struct=subroutine,
#                 params=params,
#             )
#             for arg in subroutine.arg:
#                 if arg.pointer_type == "NOT" and arg.array:
#                     arg.pointer_type = "ALLOC"
#                     # arg.c_side.c_class = f"{arg.c_side.c_class}*"
#
#             set_translations(subroutine)
#             for arg in subroutine.arg:
#                 arg.fix_struct_arg_placeholders(struct)
#             subroutines[name] = subroutine
#     return subroutines


# ******************************************************************************
# ******************************************************************************
# ******************************************************************************
# Output portion
#
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


def create_fortran_interface(f_face, struct_definitions, params):
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
            if not arg_type:
                raise RuntimeError("No argument type?")
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


def create_fortran_equality_check_code(f_equ):
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
            # f_equ.write('std::cout << ')

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

use json_module, only: json_core, json_value

use bmad_cpp_convert_mod
use {params.equality_mod_file}
"""
    )

    f_test.write("\n".join(params.test_use_statements) + "\n\n")

    f_test.write("contains\n\n")

    for struct in struct_definitions:
        # if struct.cpp_class == "CPP_ele":
        #
        #     def debug_arg(arg: Argument):
        #         if arg.pointer_type != "NOT":
        #             if arg.type == "type":
        #                 return "! skip"
        #             return f"""\
        #             if (associated(f2_ele%{arg.f_name})) then
        #                 print *, "f2_ele%{arg.f_name}=", f2_ele%{arg.f_name}
        #             endif
        #             """
        #         return f'\
        #             print *, "f2_ele%{arg.f_name}=", f2_ele%{arg.f_name}'
        #
        #     f_debug_code = "\n".join(
        #         f"! {arg}\n" + debug_arg(arg) for arg in struct.arg if arg.is_component
        #     )
        # else:
        #     f_debug_code = ""
        f_debug_code = ""
        f_test.write(
            f"""
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test1_f_{struct.short_name} (ok)

implicit none

type({struct.short_name}_struct), target :: f_{struct.short_name}, f2_{struct.short_name}

type(json_core) :: json
type(json_value), pointer :: json_root

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
  print *, '[4] {struct.short_name}: C side convert C->F: Good'
else
  print *, '[4] {struct.short_name}: C SIDE CONVERT C->F: FAILED!'
  ok = .false.

  nullify(json_root)
  call {struct.f_name}_to_json(f_{struct.short_name}, json_root)
  call json%print(json_root, 'test_f_{struct.short_name}_pattern_4_expected_f.json')
  call json%destroy(json_root)

  nullify(json_root)
  call {struct.f_name}_to_json(f2_{struct.short_name}, json_root)
  call json%print(json_root, 'test_f_{struct.short_name}_pattern_4_actual_f2cpp.json')
  call json%destroy(json_root)

endif

end subroutine test1_f_{struct.short_name}

!---------------------------------------------------------------------------------
!---------------------------------------------------------------------------------

subroutine test2_f_{struct.short_name} (c_{struct.short_name}, c_ok) bind(c)

implicit none

type(json_core) :: json
type(json_value), pointer :: json_root

type(c_ptr), value :: c_{struct.short_name}
type({struct.short_name}_struct), target :: f_{struct.short_name}, f2_{struct.short_name}
logical(c_bool) c_ok

!

c_ok = c_logic(.true.)
call {struct.short_name}_to_f (c_{struct.short_name}, c_loc(f_{struct.short_name}))

call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, 2)
if (f_{struct.short_name} == f2_{struct.short_name}) then
  print *, '[2] {struct.short_name}: F side convert C->F: Good'
else
  print *, '[2] {struct.short_name}: F SIDE CONVERT C->F: FAILED!'
  c_ok = c_logic(.false.)

  nullify(json_root)
  call {struct.f_name}_to_json(f_{struct.short_name}, json_root)
  call json%print(json_root, 'test_f_{struct.short_name}_pattern_2_actual_fcpp.json')
  call json%destroy(json_root)

  nullify(json_root)
  call {struct.f_name}_to_json(f2_{struct.short_name}, json_root)
  call json%print(json_root, 'test_f_{struct.short_name}_pattern_2_expected_f2.json')
  call json%destroy(json_root)

endif

{f_debug_code}

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
                f"!! f_side.test_pat[{arg.type}, {len(arg.array)}, {arg.pointer_type}] {arg.c_side.c_class}\n"
            )

            f_test.write(arg.f_side.test_pat.replace("ARGIDX", str(i)))

        f_test.write(
            f"""
end subroutine set_{struct.short_name}_test_pattern
"""
        )

    f_test.write("""
end module
""")


def get_class_repr(struct: Structure) -> str:
    lines = []

    for arg in struct.arg:
        if not arg.is_component:
            continue

        if arg.pointer_type == "PTR" and not arg.array:
            lines.append(
                f'os << "{arg.c_name}="; if (obj.{arg.c_name} == nullptr) {{ os << "nullptr"; }} else {{ os << obj.{arg.c_name}; }}; os << ", ";'
            )
        else:
            lines.append(f'os << "{arg.c_name}=" << obj.{arg.c_name} << ", ";')

    if lines:
        lines[-1] = lines[-1].replace('os << ", ";', "")
        lines[-1] = lines[-1].replace(' << ", "', "")

    return string.Template("""
  friend ostream& operator<<(ostream& os, const ${cpp_class}& obj) {
    os << "${cpp_class}{";
    ${lines}
    os << "}";
    return os;
  }

  std::string repr() const {
    std::ostringstream os;
    os << this;
    return os.str();
  }
    """).substitute(
        cpp_class=struct.cpp_class,
        lines=indent("\n".join(lines), 4).lstrip(),
    )


def get_class_lines(struct: Structure) -> list[str]:
    is_shared = struct.cpp_class not in do_not_share_classes
    maybe_shared = (
        f": public std::enable_shared_from_this<{struct.cpp_class}> "
        if is_shared
        else ""
    )

    # Build class member variables
    member_vars = []
    for arg in struct.arg:
        if not arg.is_component:
            continue
        init = (
            f" = {arg.c_side.class_initializer}" if arg.c_side.class_initializer else ""
        )
        member_vars.append(f"  {arg.c_side.c_class} {arg.c_name}{init};")

    # Build constructor body
    constructor_body = ""
    if DEBUG:
        debug_constructed = (
            f'std::cout << "{struct.cpp_class}(): " << this << std::endl;'
        )
        constructor_body = debug_constructed

    # Build destructor content
    destructor_content = ""
    if is_shared:
        destructor_lines = []
        for arg in struct.arg:
            if arg.c_side.destructor == "":
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            destructor_lines.append(f"    {arg.c_side.destructor}")
        destructor_content = "\n".join(destructor_lines)

    repr_lines = get_class_repr(struct).splitlines()
    template = string.Template(
        textwrap.dedent("""\
        //--------------------------------------------------------------------
        // ${cpp_class}
        
        class Opaque_${short_name}_class {};  // Opaque class for pointers to corresponding fortran structs.
        
        class ${cpp_class}${maybe_shared} {
        public:
        ${member_vars}
        ${c_extra_methods}
          ${cpp_class}(${c_constructor_arg_list}) {
          ${constructor_body}
          }
        ${destructor}${repr_methods}
        };
        
        extern "C" void ${short_name}_to_c (const Opaque_${short_name}_class*, ${cpp_class}&);
        extern "C" void ${short_name}_to_f (const ${cpp_class}&, Opaque_${short_name}_class*);
        
        bool operator== (const ${cpp_class}&, const ${cpp_class}&);
        """)
    )
    return template.substitute(
        cpp_class=struct.cpp_class,
        short_name=struct.short_name,
        maybe_shared=maybe_shared,
        member_vars="\n".join(member_vars),
        c_extra_methods=struct.c_extra_methods,
        c_constructor_arg_list=struct.c_constructor_arg_list,
        constructor_body=constructor_body,
        destructor=f"""
  virtual ~{struct.cpp_class}() {{ {destructor_content} }}
  std::shared_ptr<{struct.cpp_class}> getptr() {{ return shared_from_this(); }}
"""
        if is_shared
        else "",
        repr_methods="\n".join(repr_lines),
    ).splitlines()


def write_cpp_classes(file) -> None:
    """Write C++ classes definitions for Bmad / C++ structure interface."""
    header_template = string.Template(
        textwrap.dedent(
            """\
            //+
            // C++ classes definitions for Bmad / C++ structure interface.
            //
            // This file is generated as part of the Bmad/C++ interface code generation.
            // The code generation files can be found in cpp_bmad_interface.
            //
            // DO NOT EDIT THIS FILE DIRECTLY! 
            //-
            
            #ifndef CPP_BMAD_CLASSES
            
            #include <iostream>
            #include <memory>
            
            #include "converter_templates.h"
            ${include_headers}
            
            using namespace Bmad;
            using std::shared_ptr, std::make_shared;
            using std::ostream;
            
            ${class_definitions}
            
            //--------------------------------------------------------------------
            
            #define CPP_BMAD_CLASSES
            #endif
            """
        )
    )

    # Build the include headers string
    include_headers = "\n".join(params.include_header_files)

    # Build the class definitions string
    class_definitions = "\n".join(
        "\n".join(get_class_lines(struct)) for struct in struct_definitions
    )

    # Write the file content at once
    file.write(
        header_template.substitute(
            include_headers=include_headers, class_definitions=class_definitions
        )
    )


def write_cpp_convert(file, header: str):
    """Write C++ classes definitions for Bmad / C++ structure interface."""
    file.write(header)

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
                f"  // c_side.to_f_setup[{arg.type}, {len(arg.array)}, {arg.pointer_type}] {arg.c_side.c_class}\n"
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
                f"  // c_side.to_c2_set[{arg.type}, {len(arg.array)}, {arg.pointer_type}] {arg.c_side.c_class}\n"
            )
            file.write(f"{arg.c_side.to_c2_set}\n")

        file.write("}\n")


def write_cpp_equality(file, header: str):
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
            if DEBUG:
                file.write(
                    f'  if (!is_eq) {{ std::cout << "not equal: {struct.cpp_class}.{arg.c_name}" << "\\n"; }}\n'
                )

        file.write("  return is_eq;\n")
        file.write("};\n\n")

        # file.write(
        #     f"template bool is_all_equal (const FixedArray1D<{struct.cpp_class}>&, const FixedArray1D<{struct.cpp_class}>&);\n"
        # )
        # file.write(
        #     f"template bool is_all_equal (const Matrix<{struct.cpp_class}>&, const Matrix<{struct.cpp_class}>&);\n"
        # )


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
using namespace Bmad;
""")

    for struct in params.structs_defined_externally:
        head = struct.replace("_struct", "")
        file.write(f"void set_CPP_{head}_test_pattern (CPP_{head}& C, int ix_patt);\n")

    for struct in struct_definitions:
        c_debug_code = ""
        # c_debug_code = ""
        # if struct.cpp_class == "CPP_ele":
        #     c_debug_code = """
        #
        #  set_CPP_ele_test_pattern(C2, 4);
        #  ele_to_f(C2, F);
        #  cout << " [4] C2 = " << C2 << endl;
        #  ele_to_c(F, C);
        #  cout << " back " << endl;
        #  cout << " [4] C = " << C << endl;
        #
        #      """

        file.write(f"""
//--------------------------------------------------------------
//--------------------------------------------------------------

extern "C" void test2_f_{struct.short_name} ({struct.cpp_class}&, bool&);

void set_{struct.cpp_class}_test_pattern ({struct.cpp_class}& C, int ix_patt) {{

  auto rhs = 0;
  auto offset = 100 * ix_patt;

""")

        for i, arg in enumerate(struct.arg, 1):
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            file.write(
                f"  // c_side.test_pat[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            file.write(arg.c_side.test_pat.replace("ARGIDX", str(i)) + "\n")

        file.write(f"""
}}

//--------------------------------------------------------------

extern "C" void test_c_{struct.short_name} (Opaque_{struct.short_name}_class* F, bool& c_ok) {{

  {struct.cpp_class} C, C2;

  c_ok = true;

  {struct.short_name}_to_c (F, C);
  set_{struct.cpp_class}_test_pattern (C2, 1);

  cout << "" << endl;
  if (C == C2) {{
    cout << " [1] {struct.short_name}: C side convert F->C: Good" << endl;
  }} else {{
    cout << " [1] {struct.short_name}: C SIDE CONVERT F->C: FAILED!" << endl;
    cout << " [1] C  = " << C << endl;
    cout << " [1] C2 = " << C2 << endl;
    c_ok = false;
  }}

  set_{struct.cpp_class}_test_pattern (C2, 2);
  bool c_ok2;
  test2_f_{struct.short_name} (C2, c_ok2);
  if (!c_ok2) c_ok = false;

  set_{struct.cpp_class}_test_pattern (C, 3);
  if (C == C2) {{
    cout << " [3] {struct.short_name}: F side convert F->C: Good" << endl;
  }} else {{
    cout << " [3] {struct.short_name}: F SIDE CONVERT F->C: FAILED!" << endl;
    cout << " [3] C  = " << C << endl;
    cout << " [3] C2 = " << C2 << endl;
    c_ok = false;
  }}

  set_{struct.cpp_class}_test_pattern (C2, 4);
  {struct.short_name}_to_f (C2, F);

  {c_debug_code}
}}
""")


def write_if_differs(
    write_func: Callable,
    target_path: pathlib.Path | str,
    *args,
    **kwargs,
) -> bool:
    """
    Execute a write function to a temporary file first, and only write to the target file
    if the contents differ from the existing file or if the target file doesn't exist.

    Parameters
    ----------
    write_func : Callable
        Function that performs the writing operation; should accept a file object as its first argument
    target_path : pathlib.Path
        Path to the target file that may be written to
    *args : Any
        Additional positional arguments to pass to write_func
    **kwargs : Any
        Additional keyword arguments to pass to write_func

    Returns
    -------
    bool
        True if the target file was updated, False if no update was needed

    Notes
    -----
    This function assumes text contents and does not handle encoding specifications.
    """
    target_path = pathlib.Path(target_path)

    with tempfile.NamedTemporaryFile(mode="w+", delete=False) as temp_file:
        write_func(temp_file, *args, **kwargs)

        temp_file.flush()
        temp_file.seek(0)
        content = temp_file.read()

    if not target_path.exists():
        target_path.parent.mkdir(parents=True, exist_ok=True)
        print(
            f"* Writing to {target_path} (new file) {len(content)} bytes",
            file=sys.stderr,
        )
        target_path.write_text(content)
        return True

    target_content = target_path.read_text()

    if content != target_content:
        print(
            f"* Writing to {target_path} (new contents) {len(target_content)} -> {len(content)} bytes",
            file=sys.stderr,
        )
        target_path.write_text(content)
        return True

    print(f"* Not writing {target_path} (contents same)", file=sys.stderr)
    return False


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

c_side_trans_custom_overrides = {}
f_side_trans_custom_overrides = {}


def _wrap_block(lines, block, tag, comment):
    if isinstance(block, str):
        block = block.rstrip()
        block = [line.rstrip() for line in block.splitlines()]

    if not block:
        return

    indent = " " * (len(block[0]) - len(block[0].lstrip()))
    lines.extend(
        [
            f"{indent}{comment}start:{tag}",
            *block,
            f"{indent}{comment}end:{tag}",
        ]
    )


def wrap_block_c(lines, block, tag):
    return _wrap_block(lines, block, tag, comment="//// ")


def wrap_block_f(lines, block, tag):
    return _wrap_block(lines, block, tag, comment="!!!! ")


def export_c2(file):
    to_f = {}

    def add(
        key, dct: dict[str, list[str]], value: str, prefix: str = "", suffix: str = ""
    ) -> None:
        type_name, ndim, ptr = key
        key_str = f"{ndim}D_{ptr}_{type_name}"

        value = value.strip()
        value = f"{prefix}{value}{suffix}"
        dct.setdefault(value, [])
        dct[value].append(key_str)

    for key, trans in c_side_trans.items():
        lines = []
        lines.append("void TO_F (const CppClass& C, OpaqueClass* F) {")

        if trans.to_f_setup:
            wrap_block_c(lines, f"  {trans.to_f_setup}", "setup")

        lines.append("")

        lines.append("  to_f2(F,")
        wrap_block_c(lines, f"  {trans.to_f2_call}", "to_f2_call")
        lines.append("  );")

        lines.append("")

        # for arg in struct.arg:
        # lines.append(
        #     f"  // c_side.to_f_cleanup[{arg.type}, {len(arg.array)}, {arg.pointer_type}]"
        # )
        if trans.to_f_cleanup:
            wrap_block_c(lines, trans.to_f_cleanup, "cleanup")

        lines.append("}")

        add(key, to_f, "\n".join(lines))

    to_c2 = {}
    for key, trans in c_side_trans.items():
        lines = []
        lines.append("void TO_C2 (STRUCT_CPP_CLASS& C,")
        wrap_block_c(lines, trans.to_f_cleanup, "cleanup")
        lines.append("  //// start:c2_arg")
        # for arg in struct.arg:
        lines.append("  " + trans.to_c2_arg)
        lines.append("  //// start:c2_arg")
        lines.append(") {")

        # for arg in struct.arg:
        lines.append("  //// start:c2_set")
        lines.append(trans.to_c2_set)
        lines.append("  //// end:c2_set")

        lines.append("}")
        add(key, to_c2, "\n".join(lines))

    simple = {
        "equality_test": {},
        "test_pat": {},
        "test_value": {},
    }
    for func_name, dct in simple.items():
        for key, trans in c_side_trans.items():
            lines = []
            lines.append(f"void {func_name.upper()} (STRUCT_CPP_CLASS& C) {{")
            if func_name == "equality":
                lines.append("  bool is_eq = true;")

            lines.append(f"  //// start:{func_name}")
            # for arg in struct.arg:
            lines.append(getattr(trans, func_name).rstrip())
            lines.append(f"  //// end:{func_name}")

            lines.append("}")
            add(key, dct, "\n".join(lines))

    classes = {}
    # for key, trans in c_side_trans.items():
    #     lines = []
    #     lines.append("class STRUCT_CPP_CLASS {")
    #     lines.append("public:")
    #     # for arg in struct.arg:
    #     lines.append(
    #         f"  ARG_C_CLASS ARG_NAME{trans.c_instantiation_suffix} {trans.construct_value}"
    #     )
    #
    #     # lines.append("  //// start:c2_set")
    #     # lines.append(trans.to_c2_set)
    #     # lines.append("  //// end:c2_set")
    #
    #     lines.append("};")
    #     add(key, classes, "\n".join(lines))

    print(
        """
// vi: syntax=cpp
//
#include <cstddef>

class OpaqueClass {};
class CppClass {
public:
  void **NAME;
};
""",
        file=file,
    )

    for func in [
        "to_f",
        "to_c2",
        "classes",
    ]:
        dct = locals()[func]
        for code, keys in sorted(dct.items(), key=lambda kv: tuple(kv[1])):
            for key in sorted(keys):
                print(f"//// {key}", file=file)
            print(f"{code}", file=file)
            print(file=file)
    for func_name, dct in simple.items():
        for code, keys in sorted(dct.items()):
            for key in sorted(keys):
                print(f"//// {key}", file=file)
            print(f"{code}", file=file)
            print(file=file)


def export_f2(file):
    to_c = {}
    to_f2 = {}

    def add(
        key, dct: dict[str, list[str]], value: str, prefix: str = "", suffix: str = ""
    ) -> None:
        # TODO lazy
        value = value.replace("allocated(", "associated_or_allocated(")
        value = value.replace("associated(", "associated_or_allocated(")

        type_name, ndim, ptr = key
        key_str = f"{ndim}D_{ptr}_{type_name}"

        value = value.strip()
        value = f"{prefix}{value}{suffix}"
        dct.setdefault(value, [])
        dct[value].append(key_str)

    for key, trans in f_side_trans.items():
        lines = []
        lines.append("subroutine to_c (Fp, C) bind(C)")
        # NOTE: c2_f2_sub_arg can be derived from to_c2_name (I think)
        # lines.append("implicit none")
        # lines.append("interface")
        # lines.append("  subroutine to_c2 (C, !!!! start:c2_f2_sub_arg")
        # # for arg in struct.arg:
        # lines.append(
        #     f"                   !!!! end:c2_f2_sub_arg"
        # )
        # lines.append("                  ) bind(c)")
        #
        # # lines.append("    type(c_ptr), value :: C")
        # # for arg_type, args in list(to_c2_call_def.items()):
        # #     if not arg_type:
        # #         raise RuntimeError("No argument type?")
        # #     for i in range(1 + (len(args) - 1) // 7):
        # #         lines.append(
        # #             f"    {arg_type} :: {', '.join(args[i * 7 : i * 7 + 7])}\n"
        # #         )
        # lines.append("  end subroutine")
        # lines.append("end interface")
        #         lines.append(
        #             """  end subroutine
        # end interface
        #
        # """
        # type(c_ptr), value :: Fp, C
        # type(NAME_struct), pointer :: F
        # )
        # wrap_block_f(
        #     lines, f"{trans.to_c2_type} :: {trans.to_c2_name}", "to_c2_type_and_name"
        # )
        # TODO: can we infer this too?

        wrap_block_f(
            lines, "\n".join(var.lstrip() for var in trans.to_c_var), "to_c_var"
        )

        lines.append("call c_f_pointer (Fp, F)")

        # for arg in struct.arg:
        #     if arg.f_side.to_c_trans == "":
        #         continue
        #     lines.append(
        #         f"!! f_side.to_c_trans[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
        #     )
        wrap_block_f(lines, trans.to_c_trans.strip(), "to_c_trans")

        lines.append("call to_c2 (C, ")
        wrap_block_f(lines, "  " + trans.to_c2_call.lstrip(), "to_c2_call")
        lines.append(")")

        lines.append("end subroutine to_c")
        lines.append("")

        # TODO lazy
        block = "\n".join(lines)
        add(
            key,
            to_c,
            textwrap.indent(block, "  ").replace("  end subroutine", "end subroutine"),
        )

    for key, trans in f_side_trans.items():
        lines = []
        lines.append("    subroutine to_f2 (C,")
        wrap_block_f(lines, "  " + trans.to_c2_f2_sub_arg, "to_c2_f2_sub_arg")
        lines.append("  ) bind(c)")
        wrap_block_f(
            lines, f"{trans.to_f2_type} :: {trans.to_f2_name}", "to_f2_type_and_name"
        )
        wrap_block_f(
            lines, "\n".join(var.lstrip() for var in trans.to_f2_var), "to_f2_var"
        )
        lines.append("call c_f_pointer (Fp, F)")
        wrap_block_f(lines, trans.to_f2_trans, "to_f2_trans")
        lines.append("end subroutine to_f2")
        lines.append("")

        # TODO lazy
        block = "\n".join(lines)
        block = block.replace("allocated", "associated_or_allocated(")
        block = block.replace("associated(", "associated_or_allocated)")
        add(
            key,
            to_f2,
            textwrap.indent(block, "  ").replace("  end subroutine", "end subroutine"),
        )
    simple = {
        "equality_test": {},
        "test_pat": {},
        "test_value": {},
    }
    for func_name, dct in simple.items():
        for key, trans in f_side_trans.items():
            lines = []
            lines.append(f"subroutine {func_name.upper()} ()")
            # if func_name == "equality":
            #     lines.append("  bool is_eq = true;")

            wrap_block_f(lines, getattr(trans, func_name).rstrip(), func_name)

            lines.append("end subroutine")
            add(key, dct, "\n".join(lines))

    to_c_header = """
! vi: syntax=fortran
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!--------------------------------------------------------------------------
!+
! Subroutine to_c (Fp, C) bind(c)
!
! Routine to convert a Bmad {s_name}_struct to a C++ CPP_{s_name} structure
!
! Input:
!   Fp -- type(c_ptr), value :: Input Bmad structure.
!
! Output:
!   C -- type(c_ptr), value :: Output C++ struct.
!-
"""

    to_f2_header = """
! vi: syntax=fortran
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

    for func, header in [
        ("to_c", to_c_header),
        ("to_f2", to_f2_header),
    ]:
        print(header, file=file)
        dct = locals()[func]
        for code, keys in sorted(dct.items(), key=lambda kv: tuple(kv[1])):
            for key in sorted(keys):
                print(f"!!!! {key}", file=file)
            print(f"{code}", file=file)
            print(file=file)

    for func_name, dct in simple.items():
        for code, keys in sorted(dct.items()):
            for key in sorted(keys):
                print(f"!!!! {key}", file=file)
            print(f"{code}", file=file)
            print(file=file)


write_if_differs(export_c2, "exported.cpp")
write_if_differs(export_f2, "exported.f90")


fortran_structures = bmad_struct_parser.load_all_structures(
    *params.struct_def_yaml_files
)

struct_definitions: list[Structure] = []

for name in params.struct_list:
    struct = Structure(name)
    match_structure_definition(fortran_structures, struct)
    set_translations(struct)

    add_array_bound_info_for_pointer_structures(struct)
    print_debug("\nStruct: " + str(struct))
    for arg in struct.arg:
        arg.fix_struct_arg_placeholders(struct)

    struct_definitions.append(struct)

# *Customization hook*

params.customize(struct_definitions)

# routines = parse_bmad_routines(params)

if DEBUG:
    write_parsed_structures(struct_definitions, "f_structs.parsed")

n_found = sum(1 for struct in struct_definitions if struct.short_name != "")
n_total = len(struct_definitions)

# Print diagnostics
print(f"Number of structs in input list: {n_total}", file=sys.stderr)
print(f"Number of structs found:         {n_found}", file=sys.stderr)

check_missing()

write_if_differs(
    create_fortran_interface,
    pathlib.Path(params.code_dir) / "bmad_cpp_convert_mod.f90",
    struct_definitions,
    params,
)
write_if_differs(
    create_fortran_equality_check_code,
    pathlib.Path(params.equality_mod_dir) / (params.equality_mod_file + ".f90"),
)

write_if_differs(write_tests_main, pathlib.Path(params.test_dir) / "main.f90")
write_if_differs(
    write_tests_mod, pathlib.Path(params.test_dir) / "bmad_cpp_test_mod.f90"
)
write_if_differs(write_cpp_classes, pathlib.Path("include") / "cpp_bmad_classes.h")
convert_header = (SCRIPTS_PATH / "convert_template.cpp").read_text()

write_if_differs(
    write_cpp_convert,
    pathlib.Path(params.code_dir) / "cpp_bmad_convert.cpp",
    convert_header,
)

equality_header = (SCRIPTS_PATH / "equality_template.cpp").read_text()
write_if_differs(
    write_cpp_equality,
    pathlib.Path(params.code_dir) / "cpp_equality.cpp",
    equality_header,
)
write_if_differs(write_cpp_test, pathlib.Path(params.test_dir) / "cpp_bmad_test.cpp")
