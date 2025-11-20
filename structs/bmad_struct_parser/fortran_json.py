from __future__ import annotations

import argparse
import dataclasses
import logging
import pathlib
import textwrap

from .parser import (
    DEFAULT_CONFIG_FILE,
    ParserConfig,
    SourceConfig,
    Structure,
    StructureMember,
    load_structures_by_filename,
)
from .util import write_file_if_changed

logger = logging.getLogger(__name__)


@dataclasses.dataclass
class JsonDumpMember:
    var: str
    member: StructureMember
    code: str
    imports: dict[str, list[str]] = dataclasses.field(default_factory=dict)


@dataclasses.dataclass
class JsonDumpCode:
    name: str
    code: str
    imports: dict[str, list[str]] = dataclasses.field(default_factory=dict)


default_subroutines = {
    "complex_to_json": """\
subroutine complex_to_json (input, json_root, depth, max_depth)
  use precision_def, only: dp

  implicit none

  type(json_core) :: json
  type (complex(dp)), intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth

  call json%create_array(json_root, '')
  call json%create_real(json_val, real(input), '')
  call json%add(json_root, json_val)
  call json%create_real(json_val, aimag(input), '')
  call json%add(json_root, json_val)

end subroutine complex_to_json
"""
}

default_header = """\
use, intrinsic :: iso_fortran_env
use json_module
use json_string_utilities, only: integer_to_string
use json_kinds, only: CK

integer, parameter, private :: dp = REAL64
"""


@dataclasses.dataclass
class FortranSource:
    module: str
    imports: list[str] = dataclasses.field(default_factory=list)
    header: str = default_header
    footer: str = ""
    precision_module: str = "precision_def"
    subroutines: dict[str, str] = dataclasses.field(default_factory=lambda: dict(default_subroutines))

    def __str__(self):
        subroutine_text = "\n".join(sub for sub in self.subroutines.values())
        subroutine_text = subroutine_text.replace(
            "use precision_def, only: dp",
            f"use {self.precision_module}, only: dp",
        )

        source_lines = "\n".join(
            (
                f"module {self.module}",
                self.header,
                "contains",
                subroutine_text,
                self.footer,
                f"end module {self.module}",
            )
        )
        return "\n".join(line for line in source_lines.splitlines() if line.strip())


def to_subroutine_name(struct: Structure | str) -> str:
    name = struct.name if isinstance(struct, Structure) else struct
    return f"{name}_to_json"


def _get_variable_accessor(member: StructureMember, var_access: str) -> str:
    """Wraps the variable string in trim/real conversion if necessary."""
    dtype = member.type.lower()
    if dtype == "character":
        return f"trim({var_access})"
    if dtype == "real" and str(member.type_info.kind).lower() == "qp":
        # Quad -> dual precision only
        return f"real({var_access}, dp)"
    return var_access


@dataclasses.dataclass()
class Converter:
    structs: list[Structure]
    importable: dict[SourceConfig, list[Structure]] = dataclasses.field(default_factory=dict)
    generated: set[str] = dataclasses.field(default_factory=set)
    seen: set[str] = dataclasses.field(default_factory=set)
    imports: dict[SourceConfig, list[str]] = dataclasses.field(default_factory=dict)

    # Cache for import lookup
    _import_map: dict[str, tuple[SourceConfig, Structure]] = dataclasses.field(init=False)
    _by_name: dict[str, Structure] = dataclasses.field(init=False)

    def __post_init__(self):
        self._by_name = {st.name.lower(): st for st in self.structs}
        self._import_map = {}
        for source_config, struct_list in self.importable.items():
            for st in struct_list:
                self._import_map[st.name.lower()] = (source_config, st)

    def resolve_import(self, type_name: str) -> tuple[Structure | None, dict[str, list[str]]]:
        type_lower = type_name.lower()

        # 1. Structure is in the file currently being processed
        if type_lower in self._by_name:
            return self._by_name[type_lower], {}

        # 2. Structure is imported from another config
        if type_lower in self._import_map:
            source_config, struct = self._import_map[type_lower]
            module_name = source_config.fortran_filename.stem
            return struct, {module_name: [to_subroutine_name(type_name)]}

        logger.warning(f"Could not resolve structure import: {type_name}")
        return None, {}

    def _generate_value_add(
        self,
        member: StructureMember,
        var_access: str,
        parent_json_var: str,
        key: str = "",
    ) -> tuple[str, dict[str, list[str]]]:
        """Generates code to add a value to a JSON parent."""
        imports = {}
        dtype = member.type.lower()
        var_expr = _get_variable_accessor(member, var_access)

        # Array elements: empty string
        # Struct members: member name
        key_arg = f"'{key}'" if key else "''"

        if dtype in {"integer", "logical", "real", "character"}:
            if dtype == "integer":
                # Integer may need explicit cast depending on kind
                var_expr = f"int({var_expr})"
            line = f"call json%add({parent_json_var}, {key_arg}, {var_expr})"

        elif dtype == "complex":
            sub_name = "complex_to_json"
            line = "\n".join(
                (
                    f"call {sub_name}({var_expr}, json_val, depth=depth + 1, max_depth=max_depth)",
                    f"call json%rename(json_val, {key_arg})" if key_arg != "''" else "",
                    f"call json%add({parent_json_var}, json_val)",
                )
            )

        elif dtype == "type":
            assert member.kind is not None
            self.seen.add(member.kind)
            _, type_imports = self.resolve_import(member.kind)
            imports.update(type_imports)

            sub_name = to_subroutine_name(member.kind)
            line = "\n".join(
                (
                    f"call {sub_name}({var_expr}, json_val, depth=depth + 1, max_depth=max_depth)",
                    f"call json%rename(json_val, {key_arg})" if key_arg != "''" else "",
                    f"call json%add({parent_json_var}, json_val)",
                )
            )
        else:
            raise NotImplementedError(f"Member type: {dtype}")

        return line, imports

    def _generate_array_dump(
        self, struct_var: str, member: StructureMember, parent_json_var: str
    ) -> tuple[str, dict[str, list[str]]]:
        """
        Generates nested loops for arrays.
        """
        assert member.dimension

        ndims = member.dimension.count(",") + 1
        imports = {}
        lines = []

        indices = ", ".join(f"i{dim}" for dim in range(1, ndims + 1))
        var_access = f"{struct_var}%{member.name}({indices})"

        indent = ""
        for dim in range(ndims, 0, -1):
            current_list = f"json_list{dim}"
            name = member.name.lower() if dim == ndims else ""

            lines.append(f"{indent}call json%create_array({current_list}, '{name}')")
            lines.append(
                f"{indent}do i{dim} = lbound({struct_var}%{member.name}, {dim}), ubound({struct_var}%{member.name}, {dim})"
            )
            indent += "  "

        # Inner Body: add scalar/type to the innermost list
        innermost_list = f"json_list1"

        # Note that array element keys are empty strings
        body_code, body_imports = self._generate_value_add(
            member, var_access, parent_json_var=innermost_list, key=""
        )
        imports.update(body_imports)
        lines.append(textwrap.indent(body_code, indent))

        for dim in range(1, ndims + 1):
            indent = indent[:-2]
            current_list = f"json_list{dim}"

            lines.append(f"{indent}enddo")

            if dim == ndims:
                # Outermost list: This gets added to the top-level (a JSON object).
                lines.append(f"{indent}call json%add({parent_json_var}, {current_list})")
            else:
                parent_list = f"json_list{dim + 1}"
                lines.append(f"{indent}call json%add({parent_list}, {current_list})")
                lines.append(f"{indent}nullify({current_list})")

        return "\n".join(lines), imports

    def get_struct_dump_code(
        self,
        struct: Structure,
        struct_var: str,
        member: StructureMember,
        parent_json_var: str,
        source: SourceConfig | None = None,
    ) -> JsonDumpMember:
        full_member_name = f"{struct.name}%{member.name}"
        if source and (
            full_member_name.lower() in source.json_config.skip_members
            or full_member_name in source.json_config.skip_members
        ):
            # NOTE: You can exclude certain members by the full member name (either exact match or all lower-case)
            # This would be in the form: "struct%member"
            return JsonDumpMember(var="", member=member, code=f"! skipped: {full_member_name}")

        wrapper_fmt = "{code}"
        if member.type_info.pointer:
            wrapper_fmt = f"if (associated({struct_var}%{member.name})) then\n{{code}}\nendif"
        elif member.type_info.allocatable:
            wrapper_fmt = f"if (allocated({struct_var}%{member.name})) then\n{{code}}\nendif"

        indent_fn = lambda s: textwrap.indent(s, "  ")

        if member.dimension:
            # Array case
            code, imports = self._generate_array_dump(struct_var, member, parent_json_var)
            if "{code}" in wrapper_fmt:
                code = wrapper_fmt.replace("{code}", indent_fn(code))
            return JsonDumpMember(var=struct_var, member=member, code=code, imports=imports)

        # Manual skips. TODO: This should be addressed in the config instead.
        # 1. Never recurse into the parent ("parent" in comment)
        # 2. 'g', 'p', and 'u' typically refer to structs higher in the
        #    hierarchy that may include the current one
        # 3. If anything goes as high as the universe/superuniverse, it's
        #    definitely looping
        if (
            "parent" in member.comment.lower()
            or member.name.lower() in {"g", "p", "u"}
            or member.type.lower() in {"tao_super_universe_struct", "tao_universe_struct"}
        ):
            return JsonDumpMember(var="", member=member, code=f"! skipped (hardcoded): {member.name}")

        # Scalar case
        code, imports = self._generate_value_add(
            member,
            f"{struct_var}%{member.name}",
            parent_json_var,
            key=member.name.lower(),
        )

        if "{code}" in wrapper_fmt:
            code = wrapper_fmt.replace("{code}", indent_fn(code))

        return JsonDumpMember(var="", member=member, code=code, imports=imports)

    def get_struct_dump_subroutine(
        self,
        source: SourceConfig,
        struct: Structure,
        root_variable: str = "json_root",
    ) -> JsonDumpCode:
        subroutine_name = to_subroutine_name(struct.name)
        all_imports = {}
        body_lines = []

        body_lines.append(f"call json%create_object({root_variable}, '')")

        max_dim = 0
        for member in struct.members.values():
            if member.dimension:
                dims = member.dimension.count(",") + 1
                if dims > max_dim:
                    max_dim = dims

            dump = self.get_struct_dump_code(
                struct=struct,
                struct_var="input",
                member=member,
                parent_json_var=root_variable,
                source=source,
            )

            for mod, funcs in dump.imports.items():
                all_imports.setdefault(mod, []).extend(funcs)

            body_lines.append(dump.code)

        imports_str = "\n".join(
            f"use {fn}, only: {', '.join(sorted(set(fns)))}" for fn, fns in all_imports.items()
        )

        local_vars = []
        if max_dim > 0:
            # i1, i2...
            vars_index = ", ".join(f"i{n}" for n in range(1, max_dim + 1))
            local_vars.append(f"integer :: {vars_index}")
            # json_list1, json_list2...
            vars_json = ", ".join(f"json_list{n}" for n in range(1, max_dim + 1))
            local_vars.append(f"type (json_value), pointer :: {vars_json}")

        local_vars_str = "\n".join(local_vars)

        subroutine_text = f"""\
subroutine {subroutine_name} (input, json_root, depth, max_depth)
  use {struct.module}, only: {struct.name}
  {imports_str}

  implicit none

  type(json_core) :: json
  type ({struct.name}), pointer, intent(in) :: input
  type (json_value), pointer :: json_val
  type (json_value), pointer, intent(inout) :: json_root
  integer, optional, value :: depth
  integer, optional, value :: max_depth
  {local_vars_str}

  if (.not. present(depth)) depth = 0
  if (present(max_depth) .and. depth >= max_depth) then
    call json%create_null(json_root, '')
    return
  endif

  if (.not. associated(input)) then
    call json%create_null(json_root, '')
    return
  endif
"""

        indented_body = textwrap.indent("\n".join(body_lines), "  ")
        full_code = f"{subroutine_text}\n{indented_body}\n\nend subroutine {subroutine_name}\n"

        return JsonDumpCode(name=subroutine_name, code=full_code, imports=all_imports)


def convert_all(
    source: SourceConfig,
    structs: list[Structure],
    importable: dict[SourceConfig, list[Structure]],
):
    conv = Converter(structs=structs, importable=importable)
    fortran = FortranSource(module=source.fortran_filename.stem, precision_module=source.precision_module)

    def sort_key(item: tuple[str, Structure]):
        name, _struct = item
        return name

    for name, struct in sorted(conv._by_name.items(), key=sort_key):
        if struct.filename.name in source.json_config.skip_files:
            logger.debug(f"Skipping {name} from file {struct.filename}")
            continue

        logger.debug(f"Generating: {name}")
        subroutine = conv.get_struct_dump_subroutine(source, struct)
        fortran.subroutines[subroutine.name] = subroutine.code
        conv.generated.add(name)

    write_file_if_changed(
        source.fortran_filename,
        str(fortran),
        logger=logger,
        description="JSON Fortran code",
    )
    logger.info("Total structures: %d", len(conv.seen))


def main():
    argp = argparse.ArgumentParser()
    argp.add_argument("-d", "--working-directory", default=".")
    argp.add_argument("--config", nargs="?", default=str(DEFAULT_CONFIG_FILE))
    argp.add_argument("-l", "--log-level", nargs="?", default="INFO")
    args = argp.parse_args()

    logging.basicConfig(
        level=args.log_level.upper(),
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    logger.info("Generating code for Fortran JSON conversion...")

    try:
        conf = ParserConfig.from_file(args.config)
    except Exception as ex:
        logger.error(f"Failed to load config: {ex}")
        return

    working_dir = pathlib.Path(args.working_directory)
    by_source = {
        source: load_structures_by_filename(working_dir / source.json_filename) for source in conf.sources
    }

    for source, structs in by_source.items():
        logger.info(f"Working on {source.source_dir}")
        convert_all(
            source,
            structs,
            importable={s: st for s, st in by_source.items() if st is not structs},
        )


if __name__ == "__main__":
    main()
