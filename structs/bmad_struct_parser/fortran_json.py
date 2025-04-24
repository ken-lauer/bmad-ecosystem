from __future__ import annotations

import argparse
import logging
import pathlib
import textwrap
from typing import Literal

import pydantic

from .parser import (
    ParserConfig,
    SourceConfig,
    Structure,
    StructureFile,
    StructureMember,
    load_structures,
)

# filename_skips = {
#     "a_def_element_fibre_layout",
# }

skips = {
    # "cylindrical_map_term1_struct",
    # "fibre",
    # "layout",
    # "c_normal_form",
}

logger = logging.getLogger(__name__)


class JsonDumpMember(pydantic.BaseModel):
    var: str
    member: StructureMember
    code: str
    imports: dict[str, list[str]] = {}


class JsonDumpCode(pydantic.BaseModel):
    name: str
    code: str
    imports: dict[str, list[str]]


class FortranSource(pydantic.BaseModel):
    module: str
    imports: list[str] = []
    header: str = """
    """

    footer: str = """
    """

    subroutines: dict[str, str] = {
        "complex_to_json": """\
subroutine complex_to_json (input, json_root, depth)

    use json_module
    use json_kinds, only: CK
    use precision_def, only: rp

    implicit none

    type(json_core) :: json
    type (complex(rp)), intent(in) :: input
    type (json_value), pointer :: json_val
    type (json_value), pointer, intent(inout) :: json_root
    integer, optional, value :: depth

    call json%create_array(json_root, '')
    call json%create_real(json_val, real(input), '')
    call json%add(json_root, json_val)
    call json%create_real(json_val, aimag(input), '')
    call json%add(json_root, json_val)

end subroutine complex_to_json
"""
    }

    def __str__(self):
        subroutines = "\n".join(sub for sub in self.subroutines.values())
        source_lines = "\n".join(
            (
                f"module {self.module}",
                "contains",
                self.header,
                subroutines,
                self.footer,
                f"end module {self.module}",
            )
        )
        return "\n".join(line for line in source_lines.splitlines() if line.strip())


def _split_defn_words(defn: str) -> list[str]:
    separators = "(), \t[]"
    words = []
    last = []
    for ch in defn:
        if ch in separators:
            words.append("".join(last))
            last = []
        else:
            last.append(ch)
    return words


def get_structures_by_name(
    struct_file: StructureFile,
    attr: Literal["python", "bmad"],
) -> dict[str, Structure]:
    by_name: dict[str, Structure] = {}
    for _, structs in struct_file.items():
        for struct in structs.values():
            if attr == "python":
                by_name[struct.info.class_name] = struct
            else:
                by_name[struct.name.lower()] = struct
    return by_name


def get_structures_name_to_import(struct_file: StructureFile) -> dict[str, str]:
    by_name: dict[str, Structure] = {}
    # TODO: config for destination fortran filename...
    for fn, structs in struct_file.items():
        for struct in structs.values():
            by_name[struct.name.lower()] = fn  # struct.filename.name
    return by_name


def to_subroutine_name(struct: Structure | str):
    if isinstance(struct, Structure):
        name = struct.name
    else:
        name = struct

    return f"{name}_to_json"


class ListBuilder(pydantic.BaseModel):
    struct_var: str
    member: StructureMember
    iter_var: str
    json_list_var: str
    parent_json_var: str
    json_value_var: str
    key: str

    def create_loop(self) -> str:
        member = self.member
        assert member.dimension
        num_dimensions = member.dimension.count(",") + 1

        iter_vars = ", ".join(
            f"{self.iter_var}{dim}" for dim in range(1, num_dimensions + 1)
        )
        if member.python_type in {"int", "float", "bool"}:
            create = {
                "int": "create_integer",
                "float": "create_real",
                "bool": "create_logical",
            }[member.python_type]
            iteration = f"call json%{create}({self.json_value_var}, {self.struct_var}%{member.name}({iter_vars}), '')"
        elif member.python_type in {"str"}:
            iteration = f"call json%create_string({self.json_value_var}, trim({self.struct_var}%{member.name}({iter_vars})), '')"
        elif member.type.lower() in {"complex"}:
            conv_subroutine = to_subroutine_name(member.type)
            iteration = f"call {conv_subroutine}({self.struct_var}%{member.name}({iter_vars}), {self.json_value_var}, depth + 1)"
        elif member.type.lower() == "type":
            assert member.kind is not None
            conv_subroutine = to_subroutine_name(member.kind)
            iteration = f"call {conv_subroutine}({self.struct_var}%{member.name}({iter_vars}), {self.json_value_var}, depth + 1)"
        else:
            raise NotImplementedError(
                f"Member type: {member.type=} {member.kind=} {member=}"
            )

        def iter_dimension(dim: int, loop: str, key: str = ""):
            before = (
                f"call json%create_array({self.json_list_var}{dim}, {key})\n"
                f"do {self.iter_var}{dim} = lbound({self.struct_var}%{member.name}, {dim}), ubound({self.struct_var}%{member.name}, {dim})"
            )
            if dim == 1:
                inner = (
                    f"{loop}\n"
                    f"call json%add({self.json_list_var}{dim}, {self.json_value_var})"
                )
            else:
                inner = loop

            if dim == num_dimensions:
                after = "\n".join(
                    (
                        "enddo",
                        f"call json%add({self.parent_json_var}, {self.json_list_var}{dim})",
                        f"nullify({self.json_list_var}{dim})",
                    )
                )
            else:
                next_dim = dim + 1
                after = "\n".join(
                    (
                        "enddo",
                        f"call json%add({self.json_list_var}{next_dim}, {self.json_list_var}{dim})",
                        f"nullify({self.json_list_var}{dim})",
                    )
                )
            return "\n".join(
                (
                    before,
                    textwrap.indent(inner, "  "),
                    after,
                )
            )

        res = iteration
        for dimension in range(1, num_dimensions + 1):
            res = iter_dimension(
                dimension,
                loop=res,
                key=repr(self.key) if dimension == 1 else repr(f"dim-{dimension}"),
            )

        assert "do i1" in res
        res = f"!{member}\n{res}"
        return res


class Converter(pydantic.BaseModel):
    structs: StructureFile
    importable: dict[SourceConfig, StructureFile] = {}
    generated: set[str] = set()
    seen: set[str] = set()
    imports: dict[StructureFile, list[str]] = {}

    @property
    def by_bmad_name(self) -> dict[str, Structure]:
        return get_structures_by_name(self.structs, "bmad")

    @property
    def by_class_name(self) -> dict[str, Structure]:
        return get_structures_by_name(self.structs, "python")

    def _get_json_dump_code_array(
        self,
        struct_var: str,
        member: StructureMember,
        parent_json_var: str,
        member_json_var: str = "json_obj",
        # print_: bool = False,
        # destroy: bool = False,
    ) -> JsonDumpMember:
        assert member.dimension

        builder = ListBuilder(
            struct_var=struct_var,
            member=member,
            iter_var="i",
            json_list_var="json_list",
            json_value_var="json_val",
            parent_json_var=parent_json_var,
            key=member.python_name,
        )
        code = builder.create_loop()
        defn_words = _split_defn_words(member.definition.lower())
        if "pointer" in defn_words:
            code = "\n".join(
                (
                    f"if (associated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        if "allocatable" in defn_words:
            code = "\n".join(
                (
                    f"if (allocated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        return JsonDumpMember(var=struct_var, member=member, code=code)

    def _find_importable_structure(self, name: str) -> tuple[SourceConfig, Structure]:
        for source_config, struct_file in self.importable.items():
            for _, structs in struct_file.items():
                for struct in structs.values():
                    if name.lower() == struct.name.lower():
                        return source_config, struct

        raise ValueError(f"Structure not found to import: {name}")

    def resolve_import(self, type: str) -> tuple[Structure, dict[str, list[str]]]:
        try:
            struct = self.by_bmad_name[type.lower()]
        except KeyError:
            struct_source_config, struct = self._find_importable_structure(type.lower())
            to_json_module = struct_source_config.fortran_filename.stem
            return struct, {to_json_module: [to_subroutine_name(type)]}
        return struct, {}

    def get_json_dump_code(
        self,
        struct: Structure,
        struct_var: str,
        member: StructureMember,
        parent_json_var: str,
        member_json_var: str = "json_obj",
        source: SourceConfig | None = None,
        # print_: bool = False,
        # destroy: bool = False,
    ) -> JsonDumpMember:
        imports = {}
        if source is not None:
            full_member_name = f"{struct.name}%{member.name}"
            if (
                full_member_name in source.json_config.skip_members
                or full_member_name.lower() in source.json_config.skip_members
            ):
                return JsonDumpMember(
                    var=member_json_var,
                    member=member,
                    code=f"! config skip_members: {full_member_name} ({member.type}, {member.comment})",
                )

        if member.type.lower() == "type":
            assert member.kind is not None
            self.seen.add(member.kind)

        if member.dimension:
            struct_member = self._get_json_dump_code_array(
                struct_var=struct_var,
                member=member,
                parent_json_var=parent_json_var,
                member_json_var=member_json_var,
            )
            if member.type.lower() == "type":
                assert member.kind is not None
                _, struct_member.imports = self.resolve_import(member.kind)
            return struct_member

        # TODO: what conditions can we add here to avoid recursing through the graph?
        # baking it into the json dumping code seems not so feasible
        if (
            "parent" in member.comment.lower()
            or member.name.lower()
            in {
                "g",
                "p",
                "u",
            }
            or member.type.lower()
            in {"tao_super_universe_struct", "tao_universe_struct"}
        ):
            return JsonDumpMember(
                var=member_json_var,
                member=member,
                code=f"! parent pointer skip: {member.name} ({member.type}, {member.comment})",
            )

        if member.python_type in {"int"}:
            code = f"call json%add({parent_json_var}, '{member.python_name}', int({struct_var}%{member.name}))"
        elif member.python_type in {"float", "bool"}:
            code = f"call json%add({parent_json_var}, '{member.python_name}', {struct_var}%{member.name})"
        elif member.python_type in {"str"}:
            code = f"call json%add({parent_json_var}, '{member.python_name}', trim({struct_var}%{member.name}))"
        elif member.python_type in {"Complex"}:
            json_list_var = "json_list"
            list_var = f"{json_list_var}1"
            code = "\n".join(
                (
                    f"call complex_to_json({struct_var}%{member.name}, {list_var}, depth+1)",
                    f"call json%rename({list_var}, '{member.python_name}')",
                    f"call json%add({parent_json_var}, {list_var})",
                )
            )
        elif member.type.lower() == "type":
            assert member.kind is not None
            struct, imports = self.resolve_import(member.kind)
            conv_subroutine = to_subroutine_name(member.kind)
            code = "\n".join(
                (
                    f"call {conv_subroutine}({struct_var}%{member.name}, json_val, depth + 1)",
                    f"call json%rename(json_val, '{member.name}')",
                    f"call json%add({parent_json_var}, json_val)",
                )
            )
        else:
            raise NotImplementedError(
                f"Member type: {member.type=} {member.kind=} {member=}"
            )

        defn_words = _split_defn_words(member.definition.lower())
        if "pointer" in defn_words:
            code = "\n".join(
                (
                    f"if (associated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        if "allocatable" in defn_words:
            code = "\n".join(
                (
                    f"if (allocated({struct_var}%{member.name})) then",
                    textwrap.indent(code, "  "),
                    "endif",
                )
            )
        return JsonDumpMember(
            var=member_json_var, member=member, code=code, imports=imports
        )

    def get_struct_dump_code(
        self,
        struct_var: str,
        struct: Structure,
        root_variable: str = "json_root",
        key: str = "",
        print_: bool = True,
        destroy: bool = True,
        source: SourceConfig | None = None,
    ) -> JsonDumpCode:
        if not key:
            key = "''"
        lines = [
            f"call json%create_object({root_variable}, {key})",
        ]

        all_imports: dict[str, list[str]] = {}
        for member in struct.info.members.values():
            member_dump = self.get_json_dump_code(
                struct=struct,
                struct_var=struct_var,
                member=member,
                parent_json_var=root_variable,
                member_json_var="json_obj",
                source=source,
            )

            for name, imports in member_dump.imports.items():
                all_imports.setdefault(name, []).extend(imports)

            # if False:
            #     lines.append(
            #         f"print *, '{struct.name}%{member.name}, depth=', depth",
            #     )
            lines.extend(member_dump.code.splitlines())

        if print_:
            lines.append(f"call json%print({root_variable})")

        if destroy:
            lines.append(f"call json%destroy({root_variable})")
            lines.append(f"nullify({root_variable})")

        return JsonDumpCode(name="", code="\n".join(lines), imports=all_imports)

    def get_struct_dump_subroutine(
        self,
        source: SourceConfig,
        struct: Structure,
        root_variable: str = "json_root",
        print_: bool = True,
        destroy: bool = True,
    ) -> JsonDumpCode:
        subroutine_name = to_subroutine_name(struct.name)

        lines = [f"subroutine {subroutine_name} (input, json_root, depth)"]
        # if struct.name.lower() in skips or struct.filename.stem in filename_skips:
        #     raise ValueError(f"skipped subroutine: {subroutine_name}")

        dump_code = self.get_struct_dump_code(
            "input",
            struct,
            root_variable="json_root",
            key="",  # TODO: "name"?
            print_=False,
            destroy=False,
            source=source,
        )

        imports = "\n".join(
            f"use {fn}, only: {', '.join(sorted(set(imports)))}"
            for fn, imports in dump_code.imports.items()
        )

        lines += textwrap.dedent(
            f"""\
            use {struct.module}, only: {struct.name}

            use json_module
            use json_string_utilities, only: integer_to_string
            use json_kinds, only: CK
            {imports}

            implicit none

            type(json_core) :: json
            type ({struct.name}), pointer, intent(in) :: input
            type (json_value), pointer :: json_val
            type (json_value), pointer, intent(inout) :: json_root
            integer, optional, value :: depth

            integer i1, i2, i3, i4, i5, i6
            type (json_value), pointer :: json_list1, json_list2, json_list3, json_list4, json_list5

            if (.not. present(depth)) depth = 0
            if (depth > 10) then
              call json%create_string(json_root, 'too deep', '')
              return
            endif

            if (.not. associated(input)) then
              call json%create_null(json_root, '')
              return
            endif
            """.rstrip()
        ).splitlines()

        def should_indent(text: str) -> bool:
            return not (
                text.startswith("subroutine") or text.startswith("end subroutine")
            )

        lines.extend(dump_code.code.splitlines())
        lines.append("")
        lines.append(f"end subroutine {subroutine_name}")
        lines.append("")
        return JsonDumpCode(
            name=subroutine_name,
            code=textwrap.indent(
                "\n".join(lines), prefix="  ", predicate=should_indent
            ),
            imports=dump_code.imports,
        )


def get_used_structures(
    struct: Structure,
    structures: dict[str, Structure],
    seen: set[str] | None = None,
) -> set[str]:
    if seen is None:
        seen = set()
    elif struct.name.lower() in seen:
        return seen

    seen.add(struct.name.lower())
    for member in struct.info.members.values():
        type_name = member.type.lower()
        if type_name in structures and type_name not in seen:
            seen.add(type_name)
            seen = seen | get_used_structures(
                structures[type_name],
                structures,
                seen=seen,
            )
    return seen


def make_struct_tree(structures: dict[str, Structure]) -> dict[str, set[str]]:
    res: dict[str, set[str]] = {}
    for name, struct in structures.items():
        res[name] = get_used_structures(struct, structures)
    return res


def convert_all(
    source: SourceConfig,
    structs: StructureFile,
    importable: dict[SourceConfig, StructureFile],
):
    conv = Converter(structs=structs, importable=importable)
    fortran = FortranSource(module=source.fortran_filename.stem)

    for name, struct in conv.by_bmad_name.items():
        if struct.filename.name in source.json_config.skip_files:
            logger.debug(f"Skipping {name} from file {struct.filename}")
            continue

        logger.debug(f"Generating: {name}")
        # if name.lower() in skips or by_name[name].filename.stem in filename_skips:
        #     conv.generated.add(name)
        #     continue
        subroutine = conv.get_struct_dump_subroutine(source, struct)
        fortran.subroutines[subroutine.name] = subroutine.code
        conv.generated.add(name)

    source.fortran_filename.write_text(str(fortran))
    logger.info("Total structures: %d", len(conv.seen))


def dump_usage_tree(structs: StructureFile):
    conv = Converter(structs=structs)
    return make_struct_tree(conv.by_bmad_name)


def main():
    argp = argparse.ArgumentParser()
    argp.add_argument("-d", "--working-directory", default=".")
    argp.add_argument("--config", nargs="?", default="config.yaml")
    argp.add_argument("-l", "--log-level", nargs="?", default="INFO")
    args = argp.parse_args()

    logging.basicConfig(
        level=args.log_level.upper(),
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    logger.info("Generating code for Fortran JSON conversion...")
    conf = ParserConfig.from_file(args.config)

    working_dir = pathlib.Path(args.working_directory)
    by_source = {
        source: load_structures(working_dir / source.yaml_filename)
        for source in conf.sources
    }
    for source, structs in by_source.items():
        logger.info(f"Working on {source.source_dir}")
        structs = load_structures(working_dir / source.yaml_filename)
        # usage_tree = dump_usage_tree(structs)
        convert_all(
            source,
            structs,
            importable={
                source: st for source, st in by_source.items() if st is not structs
            },
        )


if __name__ == "__main__":
    # convert("lat_struct")
    main()
