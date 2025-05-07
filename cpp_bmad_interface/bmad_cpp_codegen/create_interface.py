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
import shutil
import string
import subprocess
import sys
import tempfile
import textwrap
from collections.abc import Callable
from dataclasses import dataclass, field, fields
from typing import Literal, NamedTuple

import bmad_struct_parser
from bmad_struct_parser import Structure as ParsedStructure
from bmad_struct_parser.parser import StructureMember

from . import interface_input_params as params

CODEGEN_ROOT = pathlib.Path(__file__).resolve().absolute().parent

if "ACC_ROOT_DIR" in os.environ:
    ACC_ROOT_DIR = pathlib.Path(os.environ["ACC_ROOT_DIR"]).resolve().absolute()
else:
    ACC_ROOT_DIR = CODEGEN_ROOT.parents[2]

CPP_INTERFACE_ROOT = ACC_ROOT_DIR / "cpp_bmad_interface"
STRUCT_PARSER_ROOT = ACC_ROOT_DIR / "structs"
TEMPLATES_PATH = CODEGEN_ROOT / "templates"

DEFAULT_CONFIG = STRUCT_PARSER_ROOT / "bmad_struct_parser" / "config.yaml"
CLANG_FORMAT_PATH = os.environ.get("CLANG_FORMAT_PATH", shutil.which("clang-format"))

assert DEFAULT_CONFIG.exists(), f"Default config doesn't exist: {DEFAULT_CONFIG}"

##################################################################################
##################################################################################
# Settings

N_CHAR_MAX = 95
DEBUG = False  # Change to True to enable more verbose printout
DEBUG_EQUALITY = False
DEBUG_INSTANTIATION = False

# Constants

REAL = "real"
CMPLX = "complex"
INT = "integer"
INT8 = "integer8"
LOGIC = "logical"
CHAR = "character"
STRUCT = "type"
SIZE = "size"
ArgumentType = Literal["real", "complex", "integer", "integer8", "logical", "character", "type", "size"]

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
            raise ValueError(f"Dimension of type from template is not integer: {type=} {dim=}") from None

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
    lines = textwrap.wrap(line, width=N_CHAR_MAX, initial_indent=indent, subsequent_indent=indent + "    ")

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
class CSideTransform:
    c_class: str = ""  # EG: 'CPP_ele_Array'

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
        return f"{self.c_class},  {self.to_f2_arg},  {self.to_f2_call},  {self.to_c2_arg}"


@dataclass
class FortranSideTransform:
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
    f_side : FortranSideTransform
        Fortran side translation.
    c_side : CSideTransform
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
    member: StructureMember | None = None
    f_side: FortranSideTransform = field(default_factory=FortranSideTransform)
    c_side: CSideTransform = field(default_factory=CSideTransform)

    @property
    def is_pointer(self) -> bool:
        return self.pointer_type == {"PTR", "ALLOC"}

    @classmethod
    def from_fstruct(cls, fstruct: ParsedStructure, member: StructureMember):
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

        return cls(
            is_component=True,
            f_name=member.name,
            c_name=params.c_side_name_translation.get(f"{fstruct.name}%{member.name}", member.name),
            type=type_,
            kind=member.kind or "",
            pointer_type=pointer_type,
            array=member.dimension.replace(" ", "").split(",") if member.dimension else [],
            init_value=str(member.default) if member.default else None,
            comment=member.comment,
            member=member,
        )

    @property
    def full_type(self):
        return FullType(self.type, len(self.array), self.pointer_type)

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

        if not self.ubound[0].isnumeric():
            # NOTE: special case: n_pole_maxx->Bmad::N_POLE_MAXX
            return self.ubound[0], "Bmad::" + self.ubound[0].upper().rstrip("$")

        f_dim1 = str(1 + int(self.ubound[0]) - int(self.lbound[0]))
        c_dim1 = f_dim1
        return f_dim1, c_dim1

    @property
    def f_dims(self):
        if not self.array:
            return ()
        if len(self.array) == 1:
            return (self.f_dim1,)
        if len(self.array) == 2:
            return (self.f_dim1, self.dim2)
        if len(self.array) == 3:
            return (self.f_dim1, self.dim2, self.dim3)
        raise NotImplementedError(len(self.array))

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
        return 1 + int(self.ubound[2]) - int(self.lbound[2])

    def should_translate(self, struct_name: str) -> bool:
        return (
            self.kind not in params.component_no_translate_list
            and f"{struct_name}%{self.f_name}" not in params.component_no_translate_list
        )

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
        self.f_side.replace_all("KIND", kind)
        self.c_side.replace_all("KIND", kind)

    def _handle_init_values(self) -> None:
        """
        Process initialization values for the argument.

        Handles Fortran to C++ initialization value conversion.
        """
        # On Fortran side "complex abc(2) = 0" is allowed but on C++ side want "0.0" for init value.
        # Therefore, ignore "0" as an init value.

        if not self.init_value or self.init_value == "0" or self.init_value[0] == ">":
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
        elif ("d" in self.init_value or "D" in self.init_value) and is_number(self.init_value):
            self.c_side.construct_value = self.init_value.replace("d", "e").replace("D", "e")
        else:
            self.c_side.construct_value = self.init_value

        # If there is an array of values, just use first one.
        if len(self.c_side.construct_value) > 0 and self.c_side.construct_value[0] == "[":
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
        self.c_side.test_pat = self.c_side.test_pat.replace("STR_LEN", self.kind)
        self.f_side.to_c_var = [var.replace("STR_LEN", self.kind) for var in self.f_side.to_c_var]

        self._handle_lbound(struct)
        if self.type == "type":
            self._handle_type_argument()

        if self.pointer_type == NOT:
            # not a pointer/dynamically allocated type;
            # replace DIM1, DIM2, DIM3 here
            if len(self.array) >= 1:
                self.f_side.replace_all("DIM1", self.f_dim1)
                self.c_side.replace_all("DIM1", self.c_dim1)

            if len(self.array) >= 2:
                self.f_side.to_c2_call = self.f_side.to_c2_call.replace("DIM2", f"{self.f_dim1}*{self.dim2}")
                self.f_side.replace_all("DIM2", str(self.dim2))
                self.c_side.replace_all("DIM2", str(self.dim2))

            if len(self.array) >= 3:
                self.f_side.to_c2_call = self.f_side.to_c2_call.replace(
                    "DIM3", f"{self.f_dim1}*{self.dim2}*{self.dim3}"
                )
                self.f_side.replace_all("DIM3", str(self.dim3))
                self.c_side.replace_all("DIM3", str(self.dim3))

        self.f_side.replace_all("NAME", self.f_name)
        self.c_side.replace_all("NAME", self.c_name)
        self._handle_init_values()

    def original_repr(self) -> str:
        return f'["{self.type}({self.kind})", "{self.pointer_type}", "{self.f_name}", {self.array}, {self.lbound} {self.ubound} "{self.init_value}"]'


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
        return f"[name: {self.short_name}, #arg: {len(self.arg)}]"


@dataclasses.dataclass
class TemplateImporter:
    section: re.Pattern
    type: re.Pattern
    begin: re.Pattern
    end: re.Pattern
    special_case: re.Pattern

    @classmethod
    def from_prefix(cls, prefix: str) -> TemplateImporter:
        return TemplateImporter(
            # These must be on their own line:
            section=re.compile(rf"^\s*{prefix}\s*section:.*\s*$", flags=re.MULTILINE),
            special_case=re.compile(rf"^\s*{prefix}\s*case:(.*):(.*)$\n^(.*)$", flags=re.MULTILINE),
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

    def get_special_cases(self, section: str) -> dict[FullType, dict[str, str]]:
        res = {}
        for type_str, tag, value in self.special_case.findall(section):
            full_type = FullType.from_template(type_str)
            res.setdefault(full_type, {})
            res[full_type][tag] = value
        return res

    def split_tags(self, section: str) -> dict[str, str]:
        by_tag = {}
        for begin in self.begin.finditer(section):
            tag = begin.group(1).lower()

            tag_contents = section[begin.span()[1] :].lstrip("\n\r")
            end = self.end.search(tag_contents)
            if end is None:
                raise RuntimeError(f"begin:{tag} without end:{tag}. Context:\n{tag_contents}")
            if end.group(1).lower() != tag:
                end_tag = end.group(1)
                raise RuntimeError(
                    f"begin:{tag} has a mismatched end tag end:{end_tag}  Context:\n{tag_contents}"
                )

            by_tag[tag] = tag_contents[: end.span()[0]].rstrip()
        return by_tag

    def get_types(self, contents: str) -> list[FullType]:
        return [FullType.from_template(type_str) for type_str in self.type.findall(contents)]

    @classmethod
    def from_file(cls, transform_cls, template_contents: str):
        transforms = {}
        custom_overrides = {}

        if transform_cls is CSideTransform:
            importer = TemplateImporter.from_prefix("////")
        elif transform_cls is FortranSideTransform:
            importer = TemplateImporter.from_prefix("!!!!")
        else:
            raise NotImplementedError(transform_cls)

        def set_tag(full_type: FullType, tag: str, value: str) -> None:
            if tag not in valid_fields and not hasattr(transform_cls, tag):
                raise ValueError(f"Unexpected special case tag: {tag!r} found in section:\n{section}")
            if full_type not in transforms:
                transforms[full_type] = transform_cls()

            if "!!!! " in value or "//// " in value:
                raise ValueError(f"Special characters found in value: {value=}. Section:\n{section}")
            setattr(transforms[full_type], tag, value)

        valid_fields = {fld.name for fld in fields(transform_cls)}
        for section in importer.split_sections(template_contents):
            types = importer.get_types(section)
            tags = importer.split_tags(section)
            special_cases = importer.get_special_cases(section)
            for full_type in types:
                for tag, value in tags.items():
                    set_tag(full_type, tag, value)

            for full_type, tag_to_value in special_cases.items():
                for tag, value in tag_to_value.items():
                    set_tag(full_type, tag, value)

            for tag, value in tags.items():
                if "%" in tag:
                    custom_overrides[tag] = value

        return transforms, custom_overrides


##################################################################################
##################################################################################
def match_structure_definition(
    parsed_structures: list[ParsedStructure],
    struct: Structure,
):
    for fstruct in parsed_structures:
        if struct.f_name == fstruct.name:
            break
    else:
        raise RuntimeError(f"Structure not found: {struct.f_name}")

    struct.f_name = fstruct.name
    struct.short_name = fstruct.name.removesuffix("_struct")
    struct.cpp_class = "CPP_" + struct.short_name
    struct.arg = [Argument.from_fstruct(fstruct, member) for member in fstruct.members.values()]


def set_translations(struct: Structure, c_overrides, f_overrides) -> None:
    # Throw out any sub-structures that are not to be translated
    struct.arg = [arg for arg in struct.arg if arg.should_translate(struct.f_name)]

    for key, value in c_overrides.items():
        override_arg, attr = key.split(".", 1)
        if override_arg == f"{struct.f_name}%":
            assert attr in [fld.name for fld in fields(Structure)], key
            setattr(struct, attr, value.rstrip("; \n"))

    # Add translation info to each argument
    for arg in struct.arg:
        # Skip arguments without translation definitions
        if arg.full_type not in f_transforms:
            print(
                f"NO TRANSLATION FOR: {struct.short_name}%{arg.f_name} [{arg.full_type}]",
                file=sys.stderr,
            )
            continue

        arg_full_name = f"{struct.f_name}%{arg.f_name}"
        arg.f_side = copy.deepcopy(f_transforms[arg.full_type])
        arg.c_side = copy.deepcopy(c_transforms[arg.full_type])

        for key, value in c_overrides.items():
            override_arg, attr = key.split(".", 1)
            if arg_full_name == override_arg:
                assert attr in [fld.name for fld in fields(CSideTransform)], key
                setattr(arg.c_side, attr, value.rstrip(" \n;"))

        for key, value in f_overrides.items():
            override_arg, attr = key.split(".", 1)
            if arg_full_name == override_arg:
                assert attr in [fld.name for fld in fields(FortranSideTransform)], key
                setattr(arg.f_side, attr, value)


def add_array_bound_info_for_pointer_structures(struct: Structure) -> None:
    idx_argument = 0
    while idx_argument < len(struct.arg):
        arg = struct.arg[idx_argument]
        idx_argument += 1  # Increment early since we'll be inserting elements

        # Skip non-pointer types
        if arg.pointer_type == NOT:
            continue

        # Handle scalar pointers
        if len(arg.array) == 0:
            if "n_" in arg.c_side.to_f_setup:
                full_type = FullType(SIZE, 1, NOT)
                # Insert size parameter for the scalar pointer
                size_arg = Argument(
                    is_component=False,
                    type="integer",
                    f_side=copy.deepcopy(f_transforms[full_type]),
                    c_side=copy.deepcopy(c_transforms[full_type]),
                    f_name="n_" + arg.f_name,
                    c_name="n_" + arg.c_name,
                )
                struct.arg.insert(idx_argument, size_arg)
                idx_argument += 1
            continue

        # Handle array pointers
        if len(arg.array) >= 1 and "n1_" in arg.c_side.to_f_setup:
            # Create and insert size parameters for all dimensions
            for dim in range(1, min(len(arg.array) + 1, 4)):  # Support up to 3 dimensions
                full_type = FullType(SIZE, dim, NOT)
                size_arg = Argument(
                    is_component=False,
                    type="integer",
                    f_side=copy.deepcopy(f_transforms[full_type]),
                    c_side=copy.deepcopy(c_transforms[full_type]),
                    f_name=f"n{dim}_" + arg.f_name,
                    c_name=f"n{dim}_" + arg.c_name,
                )

                struct.arg.insert(idx_argument, size_arg)
                idx_argument += 1


# ******************************************************************************
# ******************************************************************************
# ******************************************************************************
# Output portion
#
def write_parsed_structures(structs, fn):
    """
    Write parsed structure definitions to a file.
    """
    with pathlib.Path(fn).open("w") as f_out:
        for struct in structs:
            f_out.write("******************************************\n")
            f_out.write(f"{struct.f_name}    {len(struct.arg)}\n")
            for arg in struct.arg:
                f_out.write(f"    {arg.original_repr()}\n")


def check_missing(structs: list[Structure]):
    # Report any structs not found
    missing_structs = [struct.f_name for struct in structs if struct.short_name == ""]
    for name in missing_structs:
        print(f"NOT FOUND: {name}", file=sys.stderr)

    # Exit if any structs are missing
    if missing_structs:
        sys.exit("COULD NOT FIND ALL THE STRUCTS! STOPPING HERE!")

    # Create set of defined struct names
    defined_struct_names = {struct.f_name for struct in structs}
    # Track all missing struct definitions
    missing_struct_definitions = []

    # Check that all referenced struct types have definitions
    for parent_struct in structs:
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


def create_fortran_interface(f_face, structs: list[Structure], params):
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

    for struct in structs:
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

    for struct in structs:
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
        f_face.write("    import c_bool, c_double, c_ptr, c_char, c_int, c_long, c_double_complex\n")
        f_face.write("    !! f_side.to_c2_type :: f_side.to_c2_name\n")
        f_face.write("    type(c_ptr), value :: C\n")
        for arg_type, args in list(to_c2_call_def.items()):
            if not arg_type:
                raise RuntimeError("No argument type?")
            for i in range(1 + (len(args) - 1) // 7):
                f_face.write(f"    {arg_type} :: {', '.join(args[i * 7 : i * 7 + 7])}\n")

        f_face.write(
            f"""\
end subroutine
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
            if arg.f_side.to_c_trans:
                f_face.write(f"!! f_side.to_c_trans[{arg.full_type}]\n")
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
            f_face.write(f"!! f_side.to_f2_trans[{arg.full_type}]\n")
            f_face.write(f"{arg.f_side.to_f2_trans}\n")

        f_face.write(
            f"""
end subroutine {s_name}_to_f2
"""
        )

    ########################
    # End stuff

    f_face.write("end module\n")


def create_fortran_equality_check_code(f_equ, structs: list[Structure]):
    f_equ.write(
        textwrap.dedent(f"""\
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
        """)
    )

    f_equ.write("\n".join(params.equality_use_statements))

    f_equ.write("""

interface operator (==)
""")

    for i in range(0, len(structs), 5):
        f_equ.write(
            "  module procedure " + ", ".join(f"eq_{f.short_name}" for f in structs[i : i + 5]) + "\n"
        )

    f_equ.write("""\
end interface

contains
""")

    for struct in structs:
        f_equ.write(
            textwrap.dedent(f"""

            !--------------------------------------------------------------------------------
            !--------------------------------------------------------------------------------

            elemental function eq_{struct.short_name} (f1, f2) result (is_eq)

            implicit none

            type({struct.short_name}_struct), intent(in) :: f1, f2
            logical is_eq

            !

            is_eq = .true.
            """)
        )

        for arg in struct.arg:
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue

            f_equ.write(f"!! f_side.equality_test[{arg.full_type}]\n")

            print(arg.f_side.equality_test, file=f_equ)

        f_equ.write(f"\nend function eq_{struct.short_name}\n")

    f_equ.write("end module\n")


def write_tests_main(f_test, structs: list[Structure]):
    f_test.write(
        textwrap.dedent(
            """\
            program cpp_bmad_interface_test

            use bmad_cpp_test_mod

            logical ok, all_ok

            !

            all_ok = .true.
            """
        )
    )

    for struct in structs:
        f_test.write("call test1_f_" + struct.short_name + "(ok); if (.not. ok) all_ok = .false.\n")

    f_test.write(
        textwrap.dedent(
            """\
            print *
            if (all_ok) then
              print *, 'Bottom Line: Everything OK!'
              call exit(0)
            else
              print *, 'BOTTOM LINE: PROBLEMS FOUND!'
              call exit(1)
            endif

            end program
            """
        )
    )


def write_tests_mod(f_test, structs: list[Structure]):
    f_test.write(
        textwrap.dedent(
            f"""\
            module bmad_cpp_test_mod

            use json_module, only: json_core, json_value

            use bmad_cpp_convert_mod
            use {params.equality_mod_file}
            """
        )
    )

    f_test.write("\n".join(params.test_use_statements) + "\n\n")

    f_test.write("contains\n\n")

    for struct in structs:
        f_test.write(
            textwrap.dedent(
                f"""\
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
                  print *, '    Wrote JSON files for comparison (test_f_{struct.short_name}_pattern_4_*.json)'
    
                endif

                ! clean up test pattern data - < 3 deallocates arrays and such
                call set_{struct.short_name}_test_pattern (f_{struct.short_name}, -1)
                call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, -1)

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
                  print *, '    Wrote JSON files for comparison (test_f_{struct.short_name}_pattern_2_*.json)'

                endif

                call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, 3)
                call {struct.short_name}_to_c (c_loc(f2_{struct.short_name}), c_{struct.short_name})

                ! clean up test pattern data - < 3 deallocates arrays and such
                call set_{struct.short_name}_test_pattern (f_{struct.short_name}, -1)
                call set_{struct.short_name}_test_pattern (f2_{struct.short_name}, -1)

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
        )

        for i, arg in enumerate(struct.arg, 1):
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            f_test.write(f"!! f_side.test_pat[{arg.full_type}] {arg.c_side.c_class}\n")

            print(arg.f_side.test_pat.replace("ARGIDX", str(i)), file=f_test)

        f_test.write(
            f"""
end subroutine set_{struct.short_name}_test_pattern
"""
        )

    f_test.write("""
end module
""")


def get_to_json_source(struct: Structure) -> list[str]:
    args = [arg for arg in struct.arg if arg.is_component and arg.member is not None]

    members = ", ".join("{" + f'"{arg.c_name}", obj.{arg.c_name}' + "}" for arg in args)

    return [
        f"void to_json(json &j, const {struct.cpp_class} &obj) {{",
        f"j = json {{ {members} }};",
        "}",
        f"""
        ostream &operator<<(ostream &os, const {struct.cpp_class} &obj) {{
          json j;
          to_json(j, obj);
          std::string str = nlohmann::to_string(j);
          os << str;
          return os;
        }}
        """,
    ]


def write_cpp_json_source(file, structs: list[Structure]) -> None:
    """Write C++ classes definitions for Bmad / C++ structure interface."""
    header_template = string.Template(
        textwrap.dedent(
            """\
            //+
            // C++ JSON helpers for Bmad / C++ structure interface.
            //
            // This file is generated as part of the Bmad/C++ interface code generation.
            // The code generation files can be found in cpp_bmad_interface.
            //
            // DO NOT EDIT THIS FILE DIRECTLY! 
            //-
            
            #include <iostream>
            #include <memory>
            #include <optional>
            
            #include "cpp_bmad_classes.h"
            #include "converter_templates.h"
            #include "json.hpp"
            ${include_headers}
            
            using namespace Bmad;
            using std::ostream;
            using std::size_t;
            using json = nlohmann::json;
           
            namespace std {
            template<typename T>
            void to_json(json& j, const complex<T>& d) {
                j = {d.real(), d.imag()};
            }
            void from_json(const json& j, Complex &d) {
                d.real(j.at(0).get<double>());
                d.imag(j.at(1).get<double>());
            }
            } // namespace: std

            namespace Bmad {

            //--------------------------------------------------------------------
            ${json_helpers}
            //--------------------------------------------------------------------
            } // namespace Bmad
            """
        )
    )

    include_headers = "\n".join(params.include_header_files)
    json_helpers = "\n".join("\n".join(get_to_json_source(struct)) for struct in structs)
    file.write(header_template.substitute(include_headers=include_headers, json_helpers=json_helpers))


def get_class_lines(struct: Structure) -> list[str]:
    member_vars = []
    for arg in struct.arg:
        if not arg.is_component:
            continue
        class_initializer = (
            "{" + arg.c_side.class_initializer.strip() + "}" if arg.c_side.class_initializer.strip() else ""
        )
        member_vars.append(f"  {arg.c_side.c_class} {arg.c_name}{class_initializer.strip()};")

    constructor_body = struct.c_constructor_body
    destructor_body = ""
    if DEBUG_INSTANTIATION:
        constructor_body = f'{constructor_body}\nstd::cout << "{struct.cpp_class}(): " << this << std::endl;'
        destructor_body = f'{destructor_body}\nstd::cout << "~{struct.cpp_class}(): " << this << std::endl;'

    template = string.Template(
        textwrap.dedent(r"""\
        //--------------------------------------------------------------------
        // ${cpp_class}
        
        class Opaque_${short_name}_class {};  // Opaque class for pointers to corresponding fortran structs.
        
        class ${cpp_class}: public std::enable_shared_from_this<${cpp_class}> {
        public:
        ${member_vars}
        ${c_extra_methods}
          ${cpp_class}(${c_constructor_arg_list}) {
          ${constructor_body}
          }

        virtual ~${cpp_class}() {
            ${destructor_body}
        }
        std::shared_ptr<${cpp_class}> getptr() { return shared_from_this(); }
        friend ostream& operator<<(ostream &os, const ${cpp_class} &obj);
        };

        extern "C" void ${short_name}_to_c (const Opaque_${short_name}_class*, ${cpp_class}&);
        extern "C" void ${short_name}_to_f (const ${cpp_class}&, Opaque_${short_name}_class*);
        
        bool operator== (const ${cpp_class}&, const ${cpp_class}&);
        void to_json(json &, const ${cpp_class} &);
        """)
    )
    return template.substitute(
        cpp_class=struct.cpp_class,
        short_name=struct.short_name,
        member_vars="\n".join(member_vars),
        c_extra_methods=struct.c_extra_methods,
        c_constructor_arg_list=struct.c_constructor_arg_list,
        constructor_body=constructor_body,
        destructor_body=destructor_body,
    ).splitlines()


def write_cpp_classes(file, structs: list[Structure]) -> None:
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
            #define CPP_BMAD_CLASSES
            
            #include <iostream>
            #include <memory>
            #include <optional>
            
            #include "converter_templates.h"
            #include "json.hpp"
            ${include_headers}
            
            using namespace Bmad;
            using std::shared_ptr, std::make_shared;
            using std::ostream;
            using std::size_t;
            using json = nlohmann::json;

            namespace std {
            template<typename T>
            void to_json(json&, const complex<T>&);
            template<typename T>
            void from_json(const json&, complex<T> &);
            } // namespace: std

            namespace Bmad {

            //--------------------------------------------------------------------
            ${class_definitions}
            //--------------------------------------------------------------------

            }

            #endif
            """
        )
    )

    include_headers = "\n".join(params.include_header_files)
    class_definitions = "\n".join("\n".join(get_class_lines(struct)) for struct in structs)
    file.write(
        header_template.substitute(include_headers=include_headers, class_definitions=class_definitions)
    )


def write_cpp_convert(file, header: str, structs: list[Structure]):
    """Write C++ classes definitions for Bmad / C++ structure interface."""
    file.write(header)

    for struct in structs:
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
            file.write(f"  // c_side.to_f_setup[{arg.full_type}] {arg.c_side.c_class}\n")
            print(arg.c_side.to_f_setup, file=file)

        file.write("\n")
        file.write("  // c_side.to_f2_call\n")

        if DEBUG:
            for arg in struct.arg:
                file.write(f"  // {arg.c_side.to_f2_call} == {arg.c_name}: {arg.full_type}\n")

        line = f"{struct.short_name}_to_f2 (F"
        for arg in struct.arg:
            line += f", {arg.c_side.to_f2_call.strip()}"
        line += ");"
        file.write(wrap_line(line, "  ", ""))

        file.write("\n")

        for arg in struct.arg:
            if arg.c_side.to_f_cleanup == "":
                continue
            file.write(f"  // c_side.to_f_cleanup[{arg.full_type}]\n")
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
            file.write(f"  // c_side.to_c2_set[{arg.full_type}] {arg.c_side.c_class}\n")
            file.write(f"{arg.c_side.to_c2_set}\n")

        file.write("}\n")


def write_cpp_equality(file, header: str, structs: list[Structure]):
    file.write(header)

    print("namespace Bmad {", file=file)
    for struct in structs:
        file.write("\n//--------------------------------------------------------------\n\n")
        file.write(f"bool operator== (const {struct.cpp_class}& x, const {struct.cpp_class}& y) {{\n")
        file.write("  bool is_eq = true;\n")

        for arg in struct.arg:
            if not arg.is_component:
                continue
            if f"{struct.f_name}%{arg.f_name}" in params.interface_ignore_list:
                continue
            print(arg.c_side.equality_test, file=file)
            if DEBUG_EQUALITY:
                file.write(
                    f'  if (!is_eq) {{ std::cout << "not equal: {struct.cpp_class}.{arg.c_name}" << "\\n"; }}\n'
                )

        file.write("  return is_eq;\n")
        file.write("};\n\n")
    print("} // namespace Bmad", file=file)


def write_cpp_test(file, structs: list[Structure]):
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
#include <fstream>
#include <iostream>
#include "cpp_bmad_classes.h"

using namespace std;
using namespace Bmad;
""")

    for struct in params.structs_defined_externally:
        head = struct.replace("_struct", "")
        file.write(f"void set_CPP_{head}_test_pattern (CPP_{head}& C, int ix_patt);\n")

    for struct in structs:
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
            file.write(f"  // c_side.test_pat[{arg.full_type}]\n")
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

    {{
        std::ofstream c_file("{struct.short_name}.pat1.c.actual.txt");
        c_file << C;
    }}
    
    {{
        std::ofstream c2_file("{struct.short_name}.pat1.c2.expected.txt");
        c2_file << C2;
    }}
    
    cout << "     C written to {struct.short_name}.pat1.c.actual.txt" << endl;
    cout << "     C2 written to {struct.short_name}.pat1.c2.expected.txt" << endl;
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
    {{
        std::ofstream c_file("{struct.short_name}.pat3.c.expected.txt");
        c_file << C;
    }}
    
    {{
        std::ofstream c2_file("{struct.short_name}.pat3.c2.actual.txt");
        c2_file << C2;
    }}
   
    throw std::runtime_error("foo");

    cout << "     C written to {struct.short_name}.pat3.c.expected.txt" << endl;
    cout << "     C2 written to {struct.short_name}.pat3.c2.actual.txt" << endl;
    c_ok = false;
  }}

  set_{struct.cpp_class}_test_pattern (C2, 4);
  {struct.short_name}_to_f (C2, F);
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

        contents = temp_file.read()

    if CLANG_FORMAT_PATH and target_path.suffix in (".h", ".hpp", ".cpp"):
        try:
            formatted_content = subprocess.run(
                [CLANG_FORMAT_PATH],
                input=contents.encode(),
                capture_output=True,
                check=True,
            )
        except subprocess.SubprocessError:
            print_debug(f"Clang-format failed for {target_path}")
        else:
            contents = formatted_content.stdout.decode()

    if not target_path.exists():
        target_path.parent.mkdir(parents=True, exist_ok=True)
        print(
            f"* Writing to {target_path} (new file) {len(contents)} bytes",
            file=sys.stderr,
        )
        target_path.write_text(contents)
        return True

    target_content = target_path.read_text()

    if contents != target_content:
        print(
            f"* Writing to {target_path} (new contents) {len(target_content)} -> {len(contents)} bytes",
            file=sys.stderr,
        )
        target_path.write_text(contents)
        return True

    print(f"* Not writing {target_path} (contents same)", file=sys.stderr)
    return False


def get_parsed_files() -> list[Structure]:
    """Return a list of serialized (already-parsed) structures."""
    return bmad_struct_parser.load_all_structures(*[ACC_ROOT_DIR / fn for fn in params.struct_def_yaml_files])


def get_structure_definitions() -> list[Structure]:
    parsed_structures = get_parsed_files()

    structs: list[Structure] = []

    for name in params.struct_list:
        struct = Structure(name)
        match_structure_definition(parsed_structures, struct)
        set_translations(struct, c_overrides=c_overrides, f_overrides=f_overrides)

        add_array_bound_info_for_pointer_structures(struct)
        print_debug("\nStruct: " + str(struct))
        for arg in struct.arg:
            arg.fix_struct_arg_placeholders(struct)

        structs.append(struct)
    return structs


def generate():
    # TODO refactor globals
    global params  # noqa: PLW0603

    include_dir = CPP_INTERFACE_ROOT / "include"
    include_dir.mkdir(exist_ok=True)

    if len(sys.argv) > 1:
        master_input_file = sys.argv[1]
        params = __import__(sys.argv[1])
        print(f"Custom input file: {master_input_file}", file=sys.stderr)

    structs = get_structure_definitions()
    n_found = sum(1 for struct in structs if struct.short_name)

    # Print diagnostics
    print(f"Number of structs in input list: {len(structs)}", file=sys.stderr)
    print(f"Number of structs found:         {n_found}", file=sys.stderr)

    check_missing(structs)
    write_output(structs)


def write_output(structs: list[Structure]) -> None:
    if DEBUG:
        write_parsed_structures(structs, "f_structs.parsed")

    write_if_differs(
        create_fortran_interface,
        ACC_ROOT_DIR / params.code_dir / "bmad_cpp_convert_mod.f90",
        structs,
        params,
    )
    write_if_differs(
        create_fortran_equality_check_code,
        (ACC_ROOT_DIR / params.equality_mod_dir / params.equality_mod_file).with_suffix(".f90"),
        structs,
    )

    write_if_differs(
        write_tests_main,
        ACC_ROOT_DIR / params.test_dir / "main.f90",
        structs,
    )
    write_if_differs(
        write_tests_mod,
        ACC_ROOT_DIR / params.test_dir / "bmad_cpp_test_mod.f90",
        structs,
    )
    write_if_differs(
        write_cpp_classes,
        CPP_INTERFACE_ROOT / "include" / "cpp_bmad_classes.h",
        structs,
    )
    write_if_differs(
        write_cpp_json_source,
        CPP_INTERFACE_ROOT / "code" / "cpp_classes_json.cpp",
        structs,
    )
    convert_header = (CODEGEN_ROOT / "convert_template.cpp").read_text()

    write_if_differs(
        write_cpp_convert,
        ACC_ROOT_DIR / params.code_dir / "cpp_bmad_convert.cpp",
        convert_header,
        structs,
    )

    equality_header = (CODEGEN_ROOT / "equality_template.cpp").read_text()
    write_if_differs(
        write_cpp_equality,
        ACC_ROOT_DIR / params.code_dir / "cpp_equality.cpp",
        equality_header,
        structs,
    )
    write_if_differs(
        write_cpp_test,
        ACC_ROOT_DIR / params.test_dir / "cpp_bmad_test.cpp",
        structs,
    )


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


def load_transforms():
    # TODO: refactor globals
    global c_transforms
    global f_transforms
    global c_overrides
    global f_overrides

    c_transforms, c_overrides = TemplateImporter.from_file(
        CSideTransform, (TEMPLATES_PATH / "c_side.cpp").read_text()
    )
    f_transforms, f_overrides = TemplateImporter.from_file(
        FortranSideTransform, (TEMPLATES_PATH / "f_side.f90").read_text()
    )

    for type_, transform in f_transforms.items():
        if isinstance(transform.to_f2_var, str):
            transform.to_f2_var = transform.to_f2_var.splitlines()
        if isinstance(transform.to_c_var, str):
            transform.to_c_var = transform.to_c_var.splitlines()
        if type_.ptr == ALLOC:
            transform.replace_all("associated_or_allocated(", "allocated(")
        else:
            transform.replace_all("associated_or_allocated(", "associated(")
        transform.replace_all("TEST_VALUE", transform.test_value)

    for type_, transform in c_transforms.items():
        transform.c_class = transform.c_class.strip()
        transform.to_c2_arg = transform.to_c2_arg.rstrip(", ")
        transform.to_f2_call = transform.to_f2_call.rstrip(", ")
        transform.replace_all("TEST_VALUE", transform.test_value.rstrip(" ;"))
        transform.replace_all("CTYPE", get_c_type(type_.type))


c_transforms: dict[FullType, CSideTransform]
f_transforms: dict[FullType, FortranSideTransform]
c_overrides: dict[str, str]
f_overrides: dict[str, str]

load_transforms()

if __name__ == "__main__":
    generate()
