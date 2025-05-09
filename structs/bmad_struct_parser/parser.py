from __future__ import annotations

import argparse
import ast
import dataclasses
import json
import logging
import pathlib
import re
from collections.abc import Sequence
from typing import Any, NamedTuple

from .config import DEFAULT_CONFIG_FILE, ParserConfig, SourceConfig
from .util import STRUCTS_ROOT, FileLine, path_with_respect_to_env, write_file_if_changed

logger = logging.getLogger(__name__)

DefaultType = bool | int | str | float | complex | Sequence[float] | Sequence[int] | Sequence[str] | None
AnyPath = pathlib.Path | str
GENERATED_PATH = STRUCTS_ROOT / "generated"
MODEL_TEMPLATE = STRUCTS_ROOT / "dataclass.tpl"


@dataclasses.dataclass(frozen=True)
class TypeInformation:
    """
    A structured representation of a Fortran type declaration with all its attributes.

    Examples:
    - INTEGER, DIMENSION(10) :: array
    - REAL(KIND=8), INTENT(IN), OPTIONAL :: param
    - CHARACTER(LEN=100), ALLOCATABLE :: dynamic_string
    """

    type: str  # Base type name (e.g., 'INTEGER', 'REAL', 'CHARACTER', 'TYPE')

    allocatable: bool = False  # Whether the variable is allocatable
    asynchronous: bool = False  # Whether the variable can be used in async operations
    bind: str | None = None  # Bind(C) specification
    contiguous: bool = False  # Whether array data is contiguous
    dimension: str | None = None  # Dimension specification
    external: bool = False  # Whether the entity is external
    intent: str | None = None  # Intent specification ('IN', 'OUT', 'INOUT')
    intrinsic: bool = False  # Whether the type is intrinsic
    optional: bool = False  # Whether the variable is optional in a procedure
    parameter: bool = False  # Whether the variable is a parameter (constant)
    pointer: bool = False  # Whether the variable is a pointer
    private: bool = False  # Whether the variable has PUBLIC access
    protected: bool = False  # Whether the variable is protected
    public: bool = False  # Whether the variable has PUBLIC access
    save: bool = False  # Whether the variable has SAVE attribute
    kind: str | None = None  # Size or kind specification
    static: bool = False  # Whether the variable has STATIC attribute
    target: bool = False  # Whether the variable can be target of a pointer
    value: bool = False  # Whether the parameter is passed by value
    volatile: bool = False  # Whether the variable has VOLATILE attribute

    attributes: tuple[str, ...] = ()  # Any other unrecognized attributes

    @classmethod
    def from_data(cls, data: dict[str, Any]) -> TypeInformation:
        """Create a TypeInformation instance from a dictionary."""
        data["attributes"] = tuple(data["attributes"])
        return cls(**data)

    def to_json(self) -> dict[str, Any]:
        """Convert TypeInformation to a JSON-serializable dictionary."""
        result = dataclasses.asdict(self)
        keep_bools = {"bind", "dimension", "intent", "kind", "type"}
        for key, value in list(result.items()):
            if value is None or (key not in keep_bools and not value):
                # Remove 'None' always and defaults otherwise
                result.pop(key)
        return result

    def replace(self, **kwargs) -> TypeInformation:
        """Replace one or more bits of type information."""
        data = dataclasses.asdict(self)
        data.update(**kwargs)
        return type(self).from_data(data)

    def to_fortran_declaration(self) -> str:
        """Recreates the Fortran type declaration string."""
        declaration_parts = [self.type]

        if self.kind is not None:
            declaration_parts[0] += f"({self.kind})"

        attributes = []
        for attr_name in [
            "allocatable",
            "asynchronous",
            "contiguous",
            "external",
            "intrinsic",
            "optional",
            "parameter",
            "pointer",
            "private",
            "protected",
            "public",
            "save",
            "static",
            "target",
            "value",
            "volatile",
        ]:
            if getattr(self, attr_name):
                attributes.append(attr_name)
        if self.bind is not None:
            attributes.append(f"bind({self.bind})")
        if self.dimension is not None:
            attributes.append(f"dimension({self.dimension})")
        if self.intent is not None:
            attributes.append(f"intent({self.intent})")

        attributes.extend(self.attributes)

        if attributes:
            return f"{declaration_parts[0]}, {', '.join(attributes)}"
        return declaration_parts[0]


@dataclasses.dataclass
class StructureMember:
    line: int = 0
    definition: str = ""
    type_info: TypeInformation = dataclasses.field(default_factory=lambda: TypeInformation(type=""))
    name: str = ""
    comment: str = ""
    default: bool | int | str | float | None = ""

    @property
    def kind(self) -> str | None:
        return self.type_info.kind

    @property
    def type(self) -> str:
        return self.type_info.type

    @property
    def dimension(self) -> str | None:
        return self.type_info.dimension

    @property
    def size(self) -> str | None:
        # back-compat
        return self.kind

    @classmethod
    def from_data(cls, data: dict[str, Any]) -> StructureMember:
        """Create a StructureMember instance from a dictionary."""
        data["type_info"] = TypeInformation(**data["type_info"])
        return cls(**data)

    def to_json(self) -> dict[str, Any]:
        """Convert StructureMember to a JSON-serializable dictionary."""
        data = {
            "line": self.line,
            "definition": self.definition,
            "name": self.name,
            "comment": self.comment,
            "default": self.default,
        }
        for key, value in list(data.items()):
            default = getattr(type(self), key, None)
            if default is value or value in {""}:
                data.pop(key)
        data["type_info"] = self.type_info.to_json()
        return data


@dataclasses.dataclass()
class Structure:
    filename: pathlib.Path = pathlib.Path()
    line: int = 0
    name: str = ""
    module: str = ""
    private: bool = False
    lines: list[str] = dataclasses.field(default_factory=list)
    comment: str = ""
    members: dict[str, StructureMember] = dataclasses.field(default_factory=dict)

    @classmethod
    def from_data(cls, data: dict[str, Any]) -> Structure:
        """Create a Structure instance from a dictionary."""
        data = dict(data)
        data["filename"] = pathlib.Path(data.get("filename", ""))
        data["members"] = {
            name: StructureMember.from_data(member) for name, member in data.get("members", {}).items()
        }
        return cls(**data)

    def to_json(self) -> dict[str, Any]:
        """Convert Structure to a JSON-serializable dictionary."""
        data = {
            "filename": str(self.filename),
            "line": self.line,
            "name": self.name,
            "module": self.module,
            "private": self.private,
            "comment": self.comment,
            "members": {
                name: member.to_json() if hasattr(member, "to_json") else member
                for name, member in self.members.items()
            },
        }
        for key, value in list(data.items()):
            default = getattr(type(self), key, None)
            if default is value:
                data.pop(key)
        return data

    def parse(self) -> None:
        skips = {
            "private",
            "sequence",  # ?
            "contains",  # ?
            "procedure next_in_branch",  # ?
        }
        last_member = None
        for lineno, line in enumerate(self.lines[1:], start=self.line + 1):
            if "!" in line:
                line, comment = (part.strip() for part in line.split("!", 1))
            else:
                comment = ""

            if not line or line.lower() in skips:
                if last_member and comment:
                    last_member.comment = f"{last_member.comment} {comment}".strip()
                continue

            type_info = get_type_from_line(line)
            for decl in parse_declaration(line, type_info):
                member_type_info = type_info
                if decl.dimension:
                    member_type_info = member_type_info.replace(dimension=decl.dimension)
                self.members[decl.name] = last_member = StructureMember(
                    name=decl.name,
                    type_info=member_type_info,
                    line=lineno,
                    definition=line,
                    comment=comment,
                    default=decl.default,
                )


def get_in_parenthesis(value: str) -> str:
    assert "(" in value
    assert ")" in value
    after = value.split("(")[1]
    return after.split(")")[0].strip()


def get_type_from_line(line: str) -> TypeInformation:
    if "::" in line:
        line = line[: line.index("::")].strip()
    else:
        # "type (foo) a, b, c" -> "type (foo) a"
        line = _split_variables(line)[0]
        # "type (foo) a" -> "type (foo)"
        line = line.rsplit(" ", 1)[0].strip()

    parts = _split_variables(line)

    type_name = parts[0]
    if "(" in type_name:
        kind = get_in_parenthesis(type_name)
        type_name = type_name.split("(")[0].strip()
    elif "*" in type_name:
        type_name, kind = type_name.split("*", 1)
    else:
        kind = None

    dimension = None
    allocatable = False
    pointer = False
    intent = None
    bind = None
    optional = False
    private = False
    public = False
    parameter = False
    external = False
    target = False
    value = False
    contiguous = False
    protected = False
    asynchronous = False
    save = False  # Already initialized from outside this code block
    static = False  # Already initialized from outside
    intrinsic = False  # Already initialized from outside
    volatile = False  # Already initialized from outside
    attributes = []

    for part in parts[1:]:
        part_lower = part.lower()

        if part_lower == "pointer":
            # Example: REAL, POINTER :: x
            pointer = True
        elif part_lower == "allocatable":
            # Example: REAL, ALLOCATABLE :: array(:)
            allocatable = True
        elif part_lower.startswith("dimension"):
            # Example: REAL, DIMENSION(10) :: array
            # Example: REAL, DIMENSION(:,:) :: matrix
            dimension = get_in_parenthesis(part)

        elif part_lower.startswith("intent"):
            # Example: SUBROUTINE sub(x) REAL, INTENT(IN) :: x
            # Other intents: INTENT(OUT), INTENT(INOUT)
            intent = get_in_parenthesis(part)

        elif part_lower.startswith("bind"):
            # Example: INTEGER, BIND(C) :: counter
            # Example: INTEGER, BIND(C, name="c_counter") :: counter
            bind = get_in_parenthesis(part)
        elif part_lower == "optional":
            # Example: SUBROUTINE sub(x) REAL, OPTIONAL :: x
            optional = True
        elif part_lower == "private":
            # Example: REAL, PRIVATE :: internal_var
            private = True
        elif part_lower == "public":
            # Example: REAL, PUBLIC :: api_var
            public = True
        elif part_lower == "parameter":
            # Example: REAL, PARAMETER :: PI = 3.14159
            parameter = True
        elif part_lower == "external":
            # Example: REAL, EXTERNAL :: func
            external = True
        elif part_lower == "target":
            # Example: REAL, TARGET :: x
            target = True
        elif part_lower == "value":
            # Example: SUBROUTINE sub(x) REAL, VALUE :: x
            value = True
        elif part_lower == "contiguous":
            # Example: REAL, POINTER, CONTIGUOUS :: array(:)
            contiguous = True
        elif part_lower == "protected":
            # Example: REAL, PROTECTED :: config_var
            protected = True
        elif part_lower == "asynchronous":
            # Example: REAL, ASYNCHRONOUS :: async_buffer
            asynchronous = True
        elif part_lower == "save":
            # Example: REAL, SAVE :: persistent_var
            save = True
        elif part_lower == "volatile":
            # Example: INTEGER, VOLATILE :: status_flag
            volatile = True
        elif part_lower == "static":
            # Example: INTEGER, STATIC :: counter
            static = True
        elif part_lower == "intrinsic":
            # Example: REAL, INTRINSIC :: sin
            intrinsic = True
        else:
            logger.warning(f"TODO: handle type information for: {part!r} of {line!r}")
            attributes.append(part)

    return TypeInformation(
        type=type_name,
        kind=kind,
        dimension=dimension,
        allocatable=allocatable,
        pointer=pointer,
        intent=intent,
        bind=bind,
        save=save,
        static=static,
        intrinsic=intrinsic,
        volatile=volatile,
        optional=optional,
        private=private,
        public=public,
        parameter=parameter,
        external=external,
        target=target,
        value=value,
        contiguous=contiguous,
        protected=protected,
        asynchronous=asynchronous,
        attributes=tuple(attributes),
    )


def remove_comment(line: str) -> str:
    # TODO: this is naive and assumes no strings with exclamation points, etc
    if "!" in line:
        return line[: line.index("!")].rstrip()
    return line


def get_names_from_line(line: str) -> list[str]:
    return [decl.name for decl in parse_declaration(line)]


def _split_variables(line: str) -> list[str]:
    variables = []
    in_paren = 0
    in_brackets = 0
    processed = ""
    for ch in line:
        if ch == "(":
            in_paren += 1
        elif ch == ")":
            in_paren -= 1
        elif ch == "[":
            in_brackets += 1
        elif ch == "]":
            in_brackets -= 1

        if not in_paren and not in_brackets and ch == ",":
            if processed.strip():
                variables.append(processed.strip())
                processed = ""
        else:
            processed += ch
    if processed:
        variables.append(processed.strip())
    return variables


class ParsedDeclaration(NamedTuple):
    name: str
    dimension: str | None
    default: str | None


def _split_variable(line: str, type_info: TypeInformation) -> ParsedDeclaration:
    """
    Parse a single variable declaration into a ParsedDeclaration object.

    Parameters
    ----------
    line : str
        The string containing the variable declaration.

    Returns
    -------
    ParsedDeclaration
        An object containing the variable name, dimension, and default value if any.

    Raises
    ------
    ValueError
        If the line starts with an unexpected parenthesis.
    """
    if line.startswith("("):
        raise ValueError(f"{line} starts with ( unexpectedly...")

    in_paren = 0
    processed = ""
    default = None
    for idx, ch in enumerate(line):
        if ch == "(":
            in_paren += 1
        elif ch == ")":
            in_paren -= 1

        if not in_paren and ch == "=":
            default = line[idx + 1 :].strip()
            default = default.lstrip("> ")
            break
        processed += ch

    if "(" in processed:
        name, dimension = processed.split("(", 1)
        dimension = dimension[: dimension.rindex(")")]
    else:
        name, dimension = processed, ""

    return ParsedDeclaration(
        name=name.strip(),
        dimension=type_info.dimension or dimension.strip(),
        default=default.strip() if default else None,
    )


def remove_type_from_declaration(line: str) -> str:
    """Skip just the type name in a declaration like 'real (rp) foo'."""
    if "::" in line:
        return line[line.index("::") + 2 :]

    line = line.strip()

    # Pattern for declarations like "type(kind) variables" or "type variables"
    # Look for a type name followed by optional kind specification
    pattern = re.compile(
        r"""
        ^               # Start of string
        ([a-zA-Z_]+)    # Type name (one or more letters)
        \s*             # Optional whitespace after type
        (?:             # Non-capturing group for optional kind specification
            (?:         # Non-capturing group for two alternatives
                \(      # First alternative: Opening parenthesis for kind
                ([^)]*)  # Kind specification (anything except closing parenthesis)
                \)      # Closing parenthesis for kind
                |       # OR
                \*      # Second alternative: Star for kind
                (\d+)   # One or more digits for the kind number
            )
        )?              # The kind specification is optional
        \s*             # Optional whitespace after kind specification
    """,
        re.VERBOSE,
    )

    match = re.match(pattern, line)
    if match:
        var_start = match.end()
        # Return everything after type(kind)
        return line[var_start:]

    return line


def parse_type_declaration(line: str, type_info: TypeInformation | None = None) -> list[ParsedDeclaration]:
    """
    Parse a Fortran TYPE declaration line into a list of ParsedDeclaration objects.

    Parameters
    ----------
    line : str
        A string containing a Fortran TYPE declaration.

    Returns
    -------
    list[ParsedDeclaration]
        A list of ParsedDeclaration objects representing the variables declared in the line.

    Notes
    -----
    This function handles both simple TYPE declarations and more complex ones
    with variable specifications.
    """
    assert line.lower().startswith("type ") or line.lower().startswith("type(")
    if type_info is None:
        type_info = get_type_from_line(line)

    if "::" in line:
        line = line[line.index("::") + 2 :]
    else:
        if ")" not in line:
            return [ParsedDeclaration(name=line.split()[1], dimension=None, default=None)]
        line = line.split(")", 1)[1].strip()

    return [_split_variable(variable, type_info) for variable in _split_variables(line)]


def parse_declaration(line: str, type_info: TypeInformation | None = None) -> list[ParsedDeclaration]:
    """
    Parse a Fortran declaration line into a list of ParsedDeclaration objects.

    Parameters
    ----------
    line : str
        A string containing a Fortran declaration statement.

    Returns
    -------
    list[ParsedDeclaration]
        A list of ParsedDeclaration objects representing the variables declared in the line.

    Notes
    -----
    This function handles both TYPE declarations and other variable declarations.
    It removes comments from the line before parsing.
    """
    if type_info is None:
        type_info = get_type_from_line(line)

    line = remove_comment(line)
    if line.lower().startswith("type ") or line.lower().startswith("type("):
        return parse_type_declaration(line)

    variables = remove_type_from_declaration(line)
    return [_split_variable(variable, type_info) for variable in _split_variables(variables)]


def find_structs(
    file_lines: list[FileLine],
    filename: pathlib.Path,
    include_private: bool = False,
) -> list[Structure]:
    structs: list[Structure] = []
    struct = None
    in_routine = ""
    module = ""
    private_structs: dict[FileLine, list[str]] = {}
    for file_line in file_lines:
        line = file_line.line
        lower_split = remove_comment(line).lower().strip().split()
        if not lower_split:
            if struct is not None and line.strip():
                # Ensure comments still make their way through
                struct.lines.append(line.strip())
        elif lower_split[0] in {"subroutine", "function"}:
            in_routine = lower_split[1]
        elif lower_split[0] == "module":
            if len(lower_split) == 2:
                module = lower_split[1]
            elif lower_split[1] not in {"procedure"}:
                logger.debug(f"Skipping module line: {lower_split}")
        elif lower_split[0] == "private":
            names = " ".join(lower_split[1:]).replace(",", " ").split()
            private_structs[file_line] = names
        elif lower_split[0] == "type" or lower_split[0].startswith("type,"):
            if struct is not None:
                struct.lines.append(line.strip())
                continue

            squashed = line.lower().replace(" ", "")
            if squashed.startswith("type("):
                continue
            if squashed.startswith("typeis"):  # select type(x) / type is (y)
                continue
            if struct is not None:
                raise RuntimeError(f"{filename}:{file_line.lineno}: In struct: {struct.name} {line}")

            # TYPE structname
            # END TYPE
            #
            # TYPE, BIND(C) :: xrlComplex_C
            #   REAL (C_DOUBLE) :: re
            #   REAL (C_DOUBLE) :: im
            # ENDTYPE
            (struct_name,) = get_names_from_line(line)

            struct = Structure(
                filename=path_with_respect_to_env(file_line.filename, "ACC_ROOT_DIR"),
                module=module,
                name=struct_name,
                line=file_line.lineno,
                lines=[line.strip()],
            )

            if in_routine:
                logger.debug(
                    f"Private structure {struct.name!r} defined in routine {in_routine!r} ({file_line})"
                )
            elif not struct.module:
                logger.debug(f"Skipping structure not in module: {struct.name}")
            else:
                structs.append(struct)
        elif (
            lower_split[:2] == ["end", "subroutine"]
            or lower_split[0] == "endsubroutine"
            or lower_split[:2] == ["end", "function"]
            or lower_split[0] == "endfunction"
        ):
            in_routine = ""
        elif lower_split[:2] == ["end", "type"] or lower_split[0] == "endtype":
            if struct is None:
                raise RuntimeError(f"{filename}:{file_line.lineno}: Not in struct? {line}")
            logger.debug(f"Saw structure: {struct.name}")  # %s", struct)
            struct = None
        elif struct is not None:
            struct.lines.append(line.strip())

    if struct is not None:
        raise RuntimeError(f"Parse failure: {filename}: TYPE {struct.name} has no matching END TYPE?")

    for file_line, private_names in private_structs.items():
        for private_name in private_names:
            for struct in list(structs):
                if (
                    struct.name.lower() == private_name.lower()
                    and struct.filename.name == file_line.filename.name
                ):
                    struct.private = True
                    if not include_private:
                        logger.debug(
                            f"Skipping private struct: {private_name} (from 'private' designation at {file_line})"
                        )
                        structs.remove(struct)

    return structs


def fill_includes(source_config: SourceConfig, filename: pathlib.Path) -> list[FileLine]:
    result = []

    lines = FileLine.from_file(filename)
    for file_line in lines:
        parts = file_line.line.strip().split()
        if parts and parts[0].lower() == "include":
            include_fn = ast.literal_eval(parts[1])

            if include_fn in source_config.skip_includes or pathlib.Path(include_fn).suffix.lower() in {".h"}:
                result.append(file_line)
            else:
                for candidate_path in [filename.parent, *source_config.include_dirs]:
                    include_path = candidate_path / include_fn
                    if include_path.exists():
                        result.extend(fill_includes(source_config, include_path, include_path.read_text()))
                        break
                else:
                    raise FileNotFoundError(include_fn)
        else:
            result.append(file_line)

    return result


def find_structs_in_file(
    parser_config: ParserConfig,  # noqa: ARG001
    source_config: SourceConfig,
    filename: pathlib.Path,
) -> list[Structure]:
    file_lines = fill_includes(source_config, filename)
    return find_structs(
        file_lines=file_lines,
        filename=filename,
    )


def convert(
    parser_config: ParserConfig,
    source_config: SourceConfig,
    output_json_path: pathlib.Path,
) -> list[Structure]:
    structs: list[Structure] = []
    failed = {}
    filenames = sorted(source_config.source_dir.glob("**/*.f90", case_sensitive=False))
    for source_fn in filenames:
        try:
            structs.extend(find_structs_in_file(parser_config, source_config, source_fn))
        except Exception as ex:
            failed[source_fn] = ex

    for to_skip in source_config.skip_structs:
        found = False
        for struct in list(structs):
            if struct.name.lower() == to_skip.lower():
                logger.debug(f"User config skipped struct: {to_skip} (found in {struct.filename})")
                structs.remove(struct)
                found = True
        if not found:
            logger.warning(f"Unknown user-specified struct skip: {to_skip}")

    unique_files = {struct.filename for struct in structs}
    logger.info(f"{source_config.source_dir.name!r} parsing complete:")
    logger.info(f"Path: {source_config.source_dir}")
    logger.info("Total structures: %d", len(structs))
    logger.info("Success:          %d files", len(unique_files))
    logger.info("Failures:         %d files", len(failed))
    for fail, reason in failed.items():
        logger.error(f"Failed: {fail} {reason}")

    for struct in structs:
        struct.parse()

    def struct_sort(struct: Structure):
        return (*struct.filename.parent.parts, struct.name)

    sorted_structs = [struct.to_json() for struct in sorted(structs, key=struct_sort)]
    dumped_json = json.dumps(sorted_structs, indent=2)
    json_filename = pathlib.Path(output_json_path).with_suffix(".json")
    write_file_if_changed(json_filename, dumped_json, description="JSON file", logger=logger)
    return structs


def load_structures_by_filename(fn: pathlib.Path | str) -> list[Structure]:
    with pathlib.Path(fn).open() as fp:
        loaded = json.load(fp)
    return [Structure.from_data(data) for data in loaded]


def load_configured_structures(
    config_file: pathlib.Path = DEFAULT_CONFIG_FILE, output_subpath: str = "structs"
) -> list[Structure]:
    from .util import ACC_ROOT_DIR

    all_structs = []
    conf = ParserConfig.from_file(config_file)
    for source in conf.sources:
        all_structs.extend(load_structures_by_filename(ACC_ROOT_DIR / output_subpath / source.json_filename))
    return all_structs


def convert_and_write(
    parser_config: ParserConfig,
    output_path: pathlib.Path,
):
    def get_output_path(fn: str) -> pathlib.Path:
        output_fn = pathlib.Path(output_path) / fn
        output_fn.parent.mkdir(exist_ok=True, parents=True)
        return output_fn

    for source_config in parser_config.sources:
        convert(parser_config, source_config, get_output_path(source_config.json_filename))


def main():
    argp = argparse.ArgumentParser()
    argp.add_argument("--config", default=str(DEFAULT_CONFIG_FILE))
    argp.add_argument("--output", default=".", nargs="?")
    argp.add_argument("-l", "--log-level", nargs="?", default="INFO")
    args = argp.parse_args()

    logging.basicConfig(
        level=args.log_level.upper(),
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    conf = ParserConfig.from_file(args.config)
    convert_and_write(parser_config=conf, output_path=pathlib.Path(args.output))


if __name__ == "__main__":
    main()
