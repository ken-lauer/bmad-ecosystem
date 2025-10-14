#!/usr/bin/env python3
"""
Script to create:

* C++ classes for Fortran structures
* Translator between Fortran structure and C++ class
* Routines to check for equality between instances of a given Fortran structure.
* Routines to check for equality between instances of a given C++ class
* Program to check the Fortran / C++ translator

Note: The corresponding C++ class component for a pointer or allocatable Fortran
scalar struct component is an array whose length is zero if the Fortran component
is nullified and whose length is 1 otherwise.
"""

from __future__ import annotations

import copy
import logging
import pathlib
import sys
import textwrap
from dataclasses import dataclass, field

import bmad_struct_parser
from bmad_struct_parser import Structure as ParsedStructure
from bmad_struct_parser.parser import StructureMember

from . import interface_input_params as params
from . import transforms
from .enums import ENUM_FILENAME, write_enums
from .paths import (
    ACC_ROOT_DIR,
    CODEGEN_ROOT,
    CPP_INTERFACE_ROOT,
)
from .proxy import (
    create_cpp_proxy_header,
    create_cpp_proxy_impl,
    create_fortran_proxy_code,
    struct_to_proxy_class_name,
)
from .transforms import CSideTransform, FortranSideTransform
from .types import (
    ALLOC,
    CHAR,
    CMPLX,
    INT,
    INT8,
    LOGIC,
    NOT,
    PTR,
    REAL,
    REAL16,
    SIZE,
    STRUCT,
    ArgumentType,
    FullType,
    PointerType,
)
from .util import write_if_differs

logger = logging.getLogger(__name__)

DEBUG = False  # Change to True to enable more verbose printout
DEBUG_EQUALITY = False
DEBUG_INSTANTIATION = False


def print_debug(line):
    if DEBUG:
        logger.warning(line)


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
        if member.kind and member.type.lower() == "integer":
            type_ = INT8
        else:
            type_ = member.type

        if member.kind and member.kind.lower() == "qp" and member.type.lower() == "real":
            type_ = REAL16

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
                logger.error('lbound not "1" with parameter upper bound!')
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
        self.c_side.replace_all("PROXYCLS", struct_to_proxy_class_name(kind))

    def _fix_struct_arg_placeholders(self) -> None:
        """
        Substitute placeholder names in argument patterns with actual values.

        This function processes an argument object, replacing placeholders like "NAME", "DIM1", etc.,
        with the actual values relevant to the structure and argument.
        """
        print_debug("self: " + str(self))

        if self.type == "type":
            self._handle_type_argument()

        if self.pointer_type == NOT:
            # not a pointer/dynamically allocated type;
            # replace DIM1, DIM2, DIM3 here
            if len(self.array) >= 1:
                self.f_side.replace_all("DIM1", self.f_dim1)
                self.c_side.replace_all("DIM1", self.c_dim1)

            if len(self.array) >= 2:
                self.f_side.replace_all("DIM2", str(self.dim2))
                self.c_side.replace_all("DIM2", str(self.dim2))

            if len(self.array) >= 3:
                self.f_side.replace_all("DIM3", str(self.dim3))
                self.c_side.replace_all("DIM3", str(self.dim3))

        self.f_side.replace_all("NAME", self.f_name)
        self.c_side.replace_all("NAME", self.c_name)

    def original_repr(self) -> str:
        return f'["{self.type}({self.kind})", "{self.pointer_type}", "{self.f_name}", {self.array}, {self.lbound} {self.ubound} "{self.init_value}"]'


@dataclass
class CodegenStructure:
    f_name: str = ""  # Struct name on Fortran side
    short_name: str = ""  # Struct name without trailing '_struct'. Note: C++ name is 'CPP_<short_name>'
    cpp_class: str = ""  # C++ name.
    arg: list[Argument] = field(
        default_factory=list
    )  # List of structrure components + array bound dimensions.
    c_constructor_arg_list: str = ""
    c_constructor_body: str = ""  # Body of the C++ class_initializer
    c_extra_methods: str = ""  # Additional custom methods

    module: str = "unknown_module"
    parsed: ParsedStructure | None = None

    @property
    def args_to_convert(self):
        return [arg for arg in self.arg if f"{self.f_name}%{arg.f_name}" not in params.interface_ignore_list]

    @property
    def recursive(self) -> bool:
        return any(
            arg.is_component
            and arg.type == "type"
            and arg.member is not None
            and arg.member.type_info.kind.lower() == self.f_name.lower()
            for arg in self.arg
        )

    def __str__(self) -> str:
        return f"[name: {self.short_name}, #arg: {len(self.arg)}]"


##################################################################################
##################################################################################
def match_structure_definition(
    parsed_structures: list[ParsedStructure],
    struct: CodegenStructure,
):
    for fstruct in parsed_structures:
        if struct.f_name == fstruct.name:
            break
    else:
        raise RuntimeError(f"Structure not found: {struct.f_name!r}")

    struct.f_name = fstruct.name
    struct.short_name = fstruct.name.removesuffix("_struct")
    struct.cpp_class = struct_to_proxy_class_name(fstruct.name)
    struct.arg = [Argument.from_fstruct(fstruct, member) for member in fstruct.members.values()]
    struct.module = fstruct.module
    struct.parsed = fstruct


def set_translations(struct: CodegenStructure) -> None:
    # Throw out any sub-structures that are not to be translated
    struct.arg = [arg for arg in struct.arg if arg.should_translate(struct.f_name)]

    for arg in struct.arg:
        if arg.full_type not in transforms.f_transforms:
            logger.error(
                f"NO TRANSLATION FOR: {struct.short_name}%{arg.f_name} [{arg.full_type}]",
            )
            continue

        arg.f_side = copy.deepcopy(transforms.f_transforms[arg.full_type])
        arg.c_side = copy.deepcopy(transforms.c_transforms[arg.full_type])


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


def check_missing(structs: list[CodegenStructure]):
    # Report any structs not found
    missing_structs = [struct.f_name for struct in structs if struct.short_name == ""]
    for name in missing_structs:
        logger.error(f"NOT FOUND: {name}")

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
            logger.error(error_message)
        sys.exit(1)


def filter_structs(
    structs: list[CodegenStructure], allowed_modules: set[str], ignored_modules: set[str]
) -> list[CodegenStructure]:
    return [
        struct
        for struct in structs
        if struct.module in allowed_modules or struct.module not in ignored_modules
    ]


def create_fortran_equality_check_code(f_equ, structs: list[CodegenStructure], module_name: str):
    f_equ.write(
        textwrap.dedent(f"""\
        !+
        ! Module {module_name}
        !
        ! This module defines a set of functions which overload the equality operator ("==").
        ! These functions test for equality between instances of a given structure. 
        !
        ! This file is generated as a by product of the Bmad/C++ interface code generation
        ! The code generation files can be found in cpp_bmad_interface.
        !
        ! DO NOT EDIT THIS FILE DIRECTLY! 
        !- 

        module {module_name}
        """)
    )

    if module_name != "equality_mod":
        print("use equality_mod", file=f_equ)

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
        equ_defn = textwrap.dedent(f"""

            !--------------------------------------------------------------------------------
            !--------------------------------------------------------------------------------

            elemental function eq_{struct.short_name} (f1, f2) result (is_eq)

            use {struct.module}, only: {struct.f_name}
            implicit none

            type({struct.f_name}), intent(in) :: f1, f2
            logical is_eq

            !

            is_eq = .true.
            """)

        if struct.recursive:
            equ_defn = equ_defn.replace("elemental function", "recursive elemental function")

        f_equ.write(equ_defn)

        for arg in struct.args_to_convert:
            if not arg.is_component:
                continue

            f_equ.write(f"!! f_side.equality_test[{arg.full_type}]\n")

            print(arg.f_side.equality_test, file=f_equ)

        f_equ.write(f"\nend function eq_{struct.short_name}\n")

    f_equ.write("end module\n")


# def get_to_json_source(struct: CodegenStructure) -> list[str]:
#     args = [arg for arg in struct.args_to_convert if arg.is_component and arg.member is not None]
#
#     name_to_value = {arg.c_name: f"obj.{arg.c_name}" for arg in args}
#     # if struct.cpp_class == "CPP_ele":
#     #     name_to_value.pop("lord")
#     #     fixup_lines = [
#     #         "if (obj.lord.has_value()) {",
#     #         '    j["lord"] = json{*obj.lord.value()};',
#     #         "}",
#     #     ]
#     # else:
#     fixup_lines = []
#
#     members = ", ".join("{" + f'"{name}", {value}' + "}" for name, value in name_to_value.items())
#
#     return [
#         f"void to_json(json &j, const {struct.cpp_class} &obj) {{",
#         f"j = json {{ {members} }};",
#         *fixup_lines,
#         "}",
#         f"""
#         ostream &operator<<(ostream &os, const {struct.cpp_class} &obj) {{
#           json j;
#           to_json(j, obj);
#           std::string str = nlohmann::to_string(j);
#           os << str;
#           return os;
#         }}
#         """,
#     ]
#
#
# def write_cpp_json_source(file, structs: list[CodegenStructure]) -> None:
#     """Write C++ JSON serialization code."""
#     header_template = string.Template(
#         textwrap.dedent(
#             """\
#             //+
#             // C++ JSON helpers for Bmad / C++ structure interface.
#             //
#             // This file is generated as part of the Bmad/C++ interface code generation.
#             // The code generation files can be found in cpp_bmad_interface.
#             //
#             // DO NOT EDIT THIS FILE DIRECTLY!
#             //-
#
#             #include <iostream>
#             #include <memory>
#             #include <optional>
#
#             #include "converter_templates.h"
#             #include "json.hpp"
#             ${include_headers}
#
#             using namespace Bmad;
#             using std::ostream;
#             using std::size_t;
#             using json = nlohmann::json;
#
#             namespace std {
#             template<typename T>
#             void to_json(json& j, const complex<T>& d) {
#                 j = {d.real(), d.imag()};
#             }
#             void from_json(const json& j, Complex &d) {
#                 d.real(j.at(0).get<double>());
#                 d.imag(j.at(1).get<double>());
#             }
#             } // namespace: std
#
#             namespace Bmad {
#             //--------------------------------------------------------------------
#             ${json_helpers}
#             //--------------------------------------------------------------------
#             } // namespace Bmad
#             """
#         )
#     )
#
#     include_headers = "\n".join(params.include_header_files)
#     json_helpers = "\n".join("\n".join(get_to_json_source(struct)) for struct in structs)
#     file.write(header_template.substitute(include_headers=include_headers, json_helpers=json_helpers))


def get_parsed_files() -> list[CodegenStructure]:
    """Return a list of serialized (already-parsed) structures."""
    structures = []
    for fn in params.struct_def_json_files:
        structures.extend(bmad_struct_parser.load_structures_by_filename(ACC_ROOT_DIR / fn))
    return structures


def get_structure_definitions() -> list[CodegenStructure]:
    parsed_structures = get_parsed_files()

    structs: list[CodegenStructure] = []

    for name in params.struct_list:
        struct = CodegenStructure(name)
        match_structure_definition(parsed_structures, struct)
        set_translations(struct)

        print_debug("\nStruct: " + str(struct))
        for arg in struct.arg:
            arg._fix_struct_arg_placeholders()

        structs.append(struct)
    return structs


def generate():
    # TODO refactor globals
    global params  # noqa: PLW0603

    logging.basicConfig(level="INFO")
    logger.setLevel("DEBUG")

    include_dir = CPP_INTERFACE_ROOT / "include"
    include_dir.mkdir(exist_ok=True)

    if len(sys.argv) > 1:
        master_input_file = sys.argv[1]
        params = __import__(sys.argv[1])
        logging.error(f"Custom input file: {master_input_file}")

    structs = get_structure_definitions()
    n_found = sum(1 for struct in structs if struct.short_name)

    # Print diagnostics
    logging.info(f"Number of structs in input list: {len(structs)}")
    logging.info(f"Number of structs found:         {n_found}")

    check_missing(structs)
    write_output(structs)
    write_if_differs(write_enums, ENUM_FILENAME)


def write_output(structs: list[CodegenStructure]) -> None:
    if DEBUG:
        write_parsed_structures(structs, "f_structs.parsed")

    bmad_structs = [struct for struct in structs if struct.parsed.filename.parts[1].lower() not in {"tao"}]
    tao_structs = [struct for struct in structs if struct.parsed.filename.parts[1].lower() == "tao"]

    write_if_differs(
        create_fortran_equality_check_code,
        ACC_ROOT_DIR / "bmad" / "modules" / "equality_mod.f90",
        bmad_structs,
        module_name="equality_mod",
    )
    write_if_differs(
        create_fortran_equality_check_code,
        ACC_ROOT_DIR / "tao" / "code" / "tao_equality_mod.f90",
        tao_structs,
        module_name="tao_equality_mod",
    )
    write_if_differs(
        create_fortran_proxy_code,
        CPP_INTERFACE_ROOT / "code" / "proxy_mod.f90",
        structs,
    )
    cpp_proxy_header_template = (CODEGEN_ROOT / "tao_proxies.tpl.hpp").read_text()
    cpp_proxy_cpp_template = (CODEGEN_ROOT / "tao_proxies.tpl.cpp").read_text()
    write_if_differs(
        create_cpp_proxy_header,
        CPP_INTERFACE_ROOT / "include" / "tao_proxies.hpp",
        cpp_proxy_header_template,
        cpp_proxy_cpp_template,
        structs,
    )
    write_if_differs(
        create_cpp_proxy_impl,
        CPP_INTERFACE_ROOT / "code" / "tao_proxies.cpp",
        cpp_proxy_header_template,
        cpp_proxy_cpp_template,
        structs,
    )


def get_c_type(type_val: str) -> str:
    """Get the C++ type string for a given type value"""
    type_mapping = {
        REAL: "Real",
        REAL16: "Real",
        CMPLX: "Complex",
        INT: "Int",
        INT8: "Int8",
        LOGIC: "Bool",
        CHAR: "string",
        SIZE: "Int",
        STRUCT: "PROXYCLS",
    }

    if type_val in type_mapping:
        return type_mapping[type_val]

    raise NotImplementedError(f"Unknown type: {type_val}")


if __name__ == "__main__":
    generate()
