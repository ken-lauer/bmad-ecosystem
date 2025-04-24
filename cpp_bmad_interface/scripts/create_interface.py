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
import dataclasses
import os
import pathlib
import re
import string
import sys
import tempfile
import textwrap
from dataclasses import dataclass, field, fields
from typing import Callable, Literal, NamedTuple

import bmad_struct_parser
from bmad_struct_parser import Structure as FortranStructure
from bmad_struct_parser.parser import StructureMember

SCRIPTS_PATH = pathlib.Path(__file__).resolve().parent
CPP_INTERFACE_ROOT = SCRIPTS_PATH.parent
ACC_ROOT_DIR = CPP_INTERFACE_ROOT.parent
STRUCT_PARSER_ROOT = ACC_ROOT_DIR / "structs"
TEMPLATES_PATH = SCRIPTS_PATH.parent / "templates"

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


class FullType(NamedTuple):
    type: ArgumentType
    dim: int
    ptr: PointerType

    def sort_key(self):
        return (self.dim, self.ptr, self.type)

    def __str__(self) -> str:
        return f"{self.dim}D_{self.ptr}_{self.type}"

    @staticmethod
    def from_template(type: str) -> FullType:
        dim, ptr, type_name = type.split("_")

        try:
            dim = int(dim.lower().rstrip("d"))
        except TypeError:
            raise ValueError(
                f"Dimension of type from template is not integer: {type=} {dim=}"
            )

        if type_name not in (
            "real",
            "complex",
            "integer",
            "integer8",
            "logical",
            "character",
            "type",
            "size",
        ):
            raise ValueError(f"Unexpected type: {type_name}")
        if ptr not in ("NOT", "PTR", "ALLOC"):
            raise ValueError(f"Invalid pointer type: {type=} {ptr=}")
        return FullType(type_name, dim, ptr)


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

    def replace_all(self, old: str, new: str) -> None:
        for fld in fields(self):
            value = getattr(self, fld.name)

            if isinstance(value, str):
                setattr(self, fld.name, value.replace(old, new))
            else:
                setattr(self, fld.name, [v.replace(old, new) for v in value])

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

    @property
    def to_c2_f2_sub_arg(self) -> str:
        if "(" in self.to_f2_name:
            return self.to_f2_name.split("(")[0].strip()
        return self.to_f2_name.strip()

    def replace_all(self, old: str, new: str) -> None:
        for fld in fields(self):
            value = getattr(self, fld.name)

            if isinstance(value, str):
                setattr(self, fld.name, value.replace(old, new))
            else:
                setattr(self, fld.name, [v.replace(old, new) for v in value])

    @property
    def to_c2_type_and_name(self):
        return f"{self.to_c2_type} :: {self.to_c2_name}"

    @to_c2_type_and_name.setter
    def to_c2_type_and_name(self, value):
        type, name = value.split("::")
        self.to_c2_type = type.strip()
        self.to_c2_name = name.strip()

    @property
    def to_f2_type_and_name(self):
        return f"{self.to_f2_type} :: {self.to_f2_name}"

    @to_f2_type_and_name.setter
    def to_f2_type_and_name(self, value):
        type, name = value.split("::")
        self.to_f2_type = type.strip()
        self.to_f2_name = name.strip()


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
        if self.type.lower() != "type":
            return

        kind = self.kind
        if kind.lower().endswith("_struct"):
            kind = kind[: -len("_struct")]

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


def get_c_type(type_val: str) -> str:
    """Get the C++ type string for a given type value"""
    type_mapping = {
        REAL: "Real",
        CMPLX: "Complex",
        INT: "Int",
        INT8: "Int8",
        LOGIC: "Bool",
        CHAR: "string",
        SIZE: "Int",
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
        CHAR: "c_Char",
        SIZE: "c_Int",
        STRUCT: "const CPP_KIND",
    }

    if type_val in type_mapping:
        return type_mapping[type_val]

    raise NotImplementedError(f"Unknown type: {type_val}")


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
            print(arg.f_side.to_c_trans, file=f_face)

        f_face.write("\n" + "!! f_side.to_c2_call\n")

        line = f"call {s_name}_to_c2 (C"
        for arg in struct.arg:
            line += f", {arg.f_side.to_c2_call.strip()}"
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

            print(arg.f_side.equality_test, file=f_equ)
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

            print(arg.f_side.test_pat.replace("ARGIDX", str(i)), file=f_test)

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
            line += f", {arg.c_side.to_f2_arg.strip()}"
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
            print(arg.c_side.to_f_setup, file=file)

        file.write("\n")
        file.write("  // c_side.to_f2_call\n")

        if DEBUG:
            for arg in struct.arg:
                file.write(
                    f"  // {arg.c_side.to_f2_call} == {arg.c_name}: {arg.type} {len(arg.array)} {arg.pointer_type}\n"
                )

        line = f"{struct.short_name}_to_f2 (F"
        for arg in struct.arg:
            line += f", {arg.c_side.to_f2_call.strip()}"
        line += ");"
        file.write(wrap_line(line, "  ", ""))

        file.write("\n")

        for arg in struct.arg:
            if arg.c_side.to_f_cleanup == "":
                continue
            file.write(
                f"  // c_side.to_f_cleanup[{arg.type}, {len(arg.array)}, {arg.pointer_type}]\n"
            )
            print(arg.c_side.to_f_cleanup, file=file)

        file.write("}\n")

        # ZZZ_to_c2
        file.write("\n")
        file.write("// c_side.to_c2_arg\n")

        line = f'extern "C" void {struct.short_name}_to_c2 ({struct.cpp_class}& C'
        for arg in struct.arg:
            line += f", {arg.c_side.to_c2_arg.strip()}"
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
            print(arg.c_side.equality_test, file=file)
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

c_side_trans_custom_overrides = {}
f_side_trans_custom_overrides = {}


@dataclasses.dataclass
class TemplateImporter:
    section: re.Pattern
    section_with_match: re.Pattern
    type: re.Pattern
    begin: re.Pattern
    end: re.Pattern

    @classmethod
    def from_prefix(cls, prefix: str) -> TemplateImporter:
        return TemplateImporter(
            # These must be on their own line:
            section=re.compile(rf"^\s*{prefix}\s*section:.*\s*$", flags=re.MULTILINE),
            section_with_match=re.compile(
                rf"^\s*{prefix}\s*section:(.*)\s*$", flags=re.MULTILINE
            ),
            type=re.compile(rf"^\s*{prefix}\s*type:(.*)\s*$", flags=re.MULTILINE),
            # This may appear anywhere in a line
            begin=re.compile(rf"^.*{prefix}\s*begin:(.*).*\s*$", flags=re.MULTILINE),
            end=re.compile(rf"{prefix}\s*end:(.*)\s*$", flags=re.MULTILINE),
        )

    def split_sections(self, contents: str) -> list[str]:
        sections = self.section.split(contents)[1:]
        for section in sections:
            assert "section:" not in section
        return sections

    def split_tags(self, section: str) -> dict[str, str]:
        by_tag = {}
        for begin in self.begin.finditer(section):
            tag = begin.group(1).lower()

            tag_contents = section[begin.span()[1] :].lstrip("\n\r")
            end = self.end.search(tag_contents)
            if end is None:
                raise RuntimeError(
                    f"begin:{tag} without end:{tag}. Context:\n{tag_contents}"
                )
            if end.group(1).lower() != tag:
                end_tag = end.group(1)
                raise RuntimeError(
                    f"begin:{tag} has a mismatched end tag end:{end_tag}  Context:\n{tag_contents}"
                )

            by_tag[tag] = tag_contents[: end.span()[0]].rstrip()
        return by_tag

    def get_types(self, contents: str) -> list[str]:
        return self.type.findall(contents)


def import_template(
    cls,
    template_contents: str,
):
    """Initialize the c_side_trans dictionary with configured objects for all combinations."""
    transformers = {}

    if cls is c_side_trans_class:
        importer = TemplateImporter.from_prefix("////")
    elif cls is f_side_trans_class:
        importer = TemplateImporter.from_prefix("!!!!")
    else:
        raise NotImplementedError(cls)

    valid_fields = {fld.name for fld in fields(cls)}
    for section in importer.split_sections(template_contents):
        types = importer.get_types(section)
        tags = importer.split_tags(section)
        for tag in tags:
            if tag not in valid_fields and not hasattr(cls, tag):
                raise ValueError(
                    f"Unexpected tag: {tag!r} found in section:\n{section}"
                )
        for type_str in types:
            full_type = FullType.from_template(type_str)
            if full_type not in transformers:
                transformers[full_type] = cls()

            for tag, value in tags.items():
                setattr(transformers[full_type], tag, value)

    return transformers


c_side_trans: dict[FullType, c_side_trans_class] = import_template(
    c_side_trans_class, (TEMPLATES_PATH / "c_side.cpp").read_text()
)
f_side_trans: dict[FullType, f_side_trans_class] = import_template(
    f_side_trans_class, (TEMPLATES_PATH / "f_side.f90").read_text()
)

for type_, trans in f_side_trans.items():
    if isinstance(trans.to_f2_var, str):
        trans.to_f2_var = trans.to_f2_var.splitlines()
    if isinstance(trans.to_c_var, str):
        trans.to_c_var = trans.to_c_var.splitlines()
    if type_.ptr == ALLOC:
        trans.replace_all("associated_or_allocated(", "allocated(")
    else:
        trans.replace_all("associated_or_allocated(", "associated(")
    # trans.replace_all("TO_F2_TYPE", trans.to_f2_type)
    trans.replace_all("TEST_VALUE", trans.test_value)
    assert "TO_F2_TYPE" not in str(trans)

for type_, trans in c_side_trans.items():
    trans.replace_all("C_TYPE", get_c_type(type_.type))
    trans.replace_all("C_ARG", get_c_arg(type_.type))
    trans.replace_all("TEST_VALUE", trans.test_value)

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
