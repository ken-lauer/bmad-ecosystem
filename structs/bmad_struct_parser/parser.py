from __future__ import annotations

import argparse
import ast
import json
import logging
import os
import pathlib
from typing import NamedTuple
from collections.abc import Sequence

import pydantic
import yaml

logger = logging.getLogger(__name__)

size_ignore = {}
# size_ignore = {"rp", "dp", "hsize_t"}

DefaultType = (
    bool
    | int
    | str
    | float
    | complex
    | Sequence[float]
    | Sequence[int]
    | Sequence[str]
    | None
)
AnyPath = pathlib.Path | str
MODULE_PATH = pathlib.Path(__file__).resolve().parent
GENERATED_PATH = MODULE_PATH / "generated"
MODEL_TEMPLATE = MODULE_PATH / "dataclass.tpl"


class ParserConfig(pydantic.BaseModel):
    sources: list[SourceConfig]

    @classmethod
    def from_file(cls, filename: pathlib.Path) -> ParserConfig:
        with open(filename) as fp:
            contents = yaml.safe_load(fp)
        return cls.model_validate(contents)


class JsonConfig(pydantic.BaseModel, frozen=True):
    skip_members: tuple[str, ...] = ()
    skip_files: tuple[str, ...] = ()


class SourceConfig(pydantic.BaseModel, frozen=True):
    source_dir: pathlib.Path
    fortran_filename: pathlib.Path
    yaml_filename: str
    python_filename: str
    python_import_name: str
    function_prefix: str
    skip_includes: tuple[str, ...] = ()
    json_config: JsonConfig = JsonConfig()
    skip_structs: tuple[str, ...] = ()
    include_dirs: tuple[pathlib.Path, ...] = ()

    @pydantic.field_validator("include_dirs")
    @classmethod
    def validate_include_dirs(
        cls, values: list[pathlib.Path | str]
    ) -> tuple[pathlib.Path, ...]:
        expanded_paths = [pathlib.Path(os.path.expandvars(str(v))) for v in values]
        for path in expanded_paths:
            if not path.is_dir():
                raise ValueError(f"Path is not a directory: {path}")

        return tuple(expanded_paths)

    @pydantic.field_validator("fortran_filename")
    @classmethod
    def validate_fortran_filename(cls, v: pathlib.Path | str) -> pathlib.Path:
        # Expand environment variables in the path
        expanded_path = pathlib.Path(os.path.expandvars(str(v)))

        if expanded_path.is_dir():
            raise ValueError(f"Path is a directory: {expanded_path}")

        expanded_path.parent.mkdir(exist_ok=True, parents=True)
        return expanded_path

    @pydantic.field_validator("source_dir")
    @classmethod
    def validate_source_path(cls, v: pathlib.Path | str) -> pathlib.Path:
        # Expand environment variables in the path
        expanded_path = pathlib.Path(os.path.expandvars(str(v)))

        if not expanded_path.exists():
            raise ValueError(f"Path does not exist: {expanded_path}")

        return expanded_path


class StructureMember(pydantic.BaseModel):
    line: int
    definition: str
    type_info: TypeInformation
    name: str = ""
    type: str = ""
    size: str | None = None
    dimension: str | None = None
    comment: str = ""
    default: bool | int | str | float | None = ""

    @pydantic.field_validator("size")
    @classmethod
    def _validate_size(cls, size: str | None):
        if not size:
            return None
        if size in size_ignore:  #  or not size.isnumeric():
            return None
        return size

    @property
    def kind(self) -> str | None:
        return self.size


class Structure(pydantic.BaseModel):
    filename: pathlib.Path
    line: int
    name: str
    module: str
    private: bool = False
    lines: list[str] = pydantic.Field(default_factory=list, exclude=True)
    comment: str = ""
    members: dict[str, StructureMember] = pydantic.Field(default_factory=dict)

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
                line, comment = line, ""

            if not line or line.lower() in skips:
                if last_member and comment:
                    last_member.comment = f"{last_member.comment} {comment}".strip()
                continue

            type_info = get_type_from_line(line)
            for decl in parse_declaration(line, type_info):
                self.members[decl.name] = StructureMember(
                    name=decl.name,
                    type=type_info.type,
                    type_info=type_info,
                    line=lineno,
                    definition=line,
                    comment=comment,
                    size=type_info.size,
                    dimension=decl.dimension,
                    default=decl.default,
                )
                last_member = self.members[decl.name]


def path_with_respect_to_env(path: pathlib.Path, env_var_name: str) -> pathlib.Path:
    """
    Convert an absolute path to a path relative to an environment variable.

    If the path starts with the value of the environment variable, it will be
    replaced with the variable name prefixed with a dollar sign.

    Parameters
    ----------
    path : pathlib.Path
        The absolute path to convert.
    env_var_name : str
        The name of the environment variable to use as a base path.

    Returns
    -------
    pathlib.Path
        If the path starts with the environment variable's value, returns the path
        with the prefix replaced with $ENV_VAR_NAME. Otherwise, returns the original path.

    Examples
    --------
    >>> os.environ['HOME'] = '/home/user'
    >>> path = pathlib.Path('/home/user/documents/file.txt')
    >>> path_with_respect_to_env(path, 'HOME')
    PosixPath('$HOME/documents/file.txt')
    """
    try:
        env_var = os.environ[env_var_name]
    except KeyError:
        return path

    env_path = pathlib.Path(env_var)
    if path.parts[: len(env_path.parts)] != env_path.parts:
        return path

    return pathlib.Path(f"${env_var_name}", *path.parts[len(env_path.parts) :])


def get_default(
    python_type: str, size: str | None, fortran_default: str | None
) -> tuple[DefaultType, str]:
    if fortran_default:
        if fortran_default.lower() == ".false.":
            return False, ""
        if fortran_default.lower() == ".true.":
            return True, ""
        if fortran_default.lower() == "real_garbage$":
            return 0.0, ""
        if fortran_default.lower() == "int_garbage$":
            return 0, ""
        if fortran_default.endswith("$"):  # some constant?
            ...
        else:
            if python_type == "float":
                # 10d3 -> 10e3
                fortran_default = fortran_default.lower().replace("d", "e")
                fortran_default = fortran_default.removesuffix("_rp")
            try:
                default = ast.literal_eval(fortran_default)
                if isinstance(default, list):
                    return tuple(default), ""
                return default, ""
            except (SyntaxError, ValueError):
                pass

    try:
        int(size or "abc")
    except ValueError:
        size = None
    if not size:
        default = {
            "str": "",
            "int": 0,
            "float": 0.0,
            "type": None,
            "bool": False,
            "Complex": 0.0,
        }.get(python_type, None)
        return default, ""
    return "", "list"


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
        size = get_in_parenthesis(type_name)
        type_name = type_name.split("(")[0].strip()
    elif "*" in type_name:
        type_name, size = type_name.split("*", 1)
    else:
        size = None

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
        kind=size,
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


class TypeInformation(pydantic.BaseModel, frozen=True):
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

    @property
    def size(self):
        # TODO: redo this; 'kind' is more appropriate here
        return self.kind  # back-compat


class FileLine(NamedTuple):
    filename: pathlib.Path
    lineno: int
    line: str

    def __str__(self):
        return f"{self.filename}:{self.lineno}"


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


def parse_type_declaration(
    line: str, type_info: TypeInformation | None = None
) -> list[ParsedDeclaration]:
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
            return [
                ParsedDeclaration(name=line.split()[1], dimension=None, default=None)
            ]
        line = line.split(")", 1)[1].strip()

    return [_split_variable(variable, type_info) for variable in _split_variables(line)]


def parse_declaration(
    line: str, type_info: TypeInformation | None = None
) -> list[ParsedDeclaration]:
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

    if "::" in line:
        line = line[line.index("::") + 2 :]
    else:
        line = " ".join(line.split()[1:])

    return [_split_variable(variable, type_info) for variable in _split_variables(line)]


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
            ...
        elif lower_split[0] in {"subroutine", "function"}:
            in_routine = lower_split[1]
        elif lower_split[0] == "module":
            if len(lower_split) == 2:
                module = lower_split[1]
            else:
                if lower_split[1] not in {"procedure"}:
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
                raise RuntimeError(
                    f"{filename}:{file_line.lineno}: In struct: {struct.name} {line}"
                )

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
                raise RuntimeError(
                    f"{filename}:{file_line.lineno}: Not in struct? {line}"
                )
            logger.debug(f"Saw structure: {struct.name}")  # %s", struct)
            struct = None
        elif struct is not None:
            struct.lines.append(line.strip())

    if struct is not None:
        raise RuntimeError(
            f"Parse failure: {filename}: TYPE {struct.name} has no matching END TYPE?"
        )

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


def fill_includes(
    source_config: SourceConfig, filename: pathlib.Path, contents: str
) -> list[FileLine]:
    result = []
    for lineno, line in enumerate(contents.splitlines(), 1):
        parts = line.strip().split()
        file_line = FileLine(filename=filename, lineno=lineno, line=line)
        if parts and parts[0].lower() == "include":
            include_fn = ast.literal_eval(parts[1])

            if include_fn in source_config.skip_includes or pathlib.Path(
                include_fn
            ).suffix.lower() in {".h"}:
                result.append(file_line)
            else:
                for candidate_path in [filename.parent, *source_config.include_dirs]:
                    include_path = candidate_path / include_fn
                    if include_path.exists():
                        result.extend(
                            fill_includes(
                                source_config, include_path, include_path.read_text()
                            )
                        )
                        break
                else:
                    raise FileNotFoundError(include_fn)
        else:
            result.append(file_line)

    return result


def find_structs_in_file(
    parser_config: ParserConfig,
    source_config: SourceConfig,
    filename: pathlib.Path,
) -> list[Structure]:
    contents = filename.read_text(encoding="latin-1")
    file_lines = fill_includes(source_config, filename, contents)
    return find_structs(
        file_lines=file_lines,
        filename=filename,
    )


def convert(
    parser_config: ParserConfig,
    source_config: SourceConfig,
    yaml_path: pathlib.Path,
) -> list[Structure]:
    structs: list[Structure] = []
    failed = {}
    filenames = list(source_config.source_dir.glob("**/*.f90", case_sensitive=False))
    for source_fn in filenames:
        try:
            structs.extend(
                find_structs_in_file(parser_config, source_config, source_fn)
            )
        except Exception as ex:
            failed[source_fn] = ex
            raise

    for to_skip in source_config.skip_structs:
        for struct in list(structs):
            if struct.name.lower() == to_skip.lower():
                logger.debug(
                    f"User config skipped struct: {to_skip} (found in {struct.filename})"
                )
                structs.remove(struct)
                break
        else:
            logger.warning(f"Unknown user-specified struct skip: {to_skip}")

    unique_files = set(struct.filename for struct in structs)
    logger.info(f"{source_config.source_dir.name!r} parsing complete:")
    logger.info(f"Path: {source_config.source_dir}")
    logger.info("Total structures: %d", len(structs))
    logger.info("Success:          %d files", len(unique_files))
    logger.info("Failures:         %d files", len(failed))
    for fail, reason in failed.items():
        logger.error(f"Failed: {fail} {reason}")

    for struct in structs:
        struct.parse()

    info_adapter = pydantic.TypeAdapter("list[Structure]")
    dumped_json = info_adapter.dump_json(structs, exclude_defaults=True)
    dumped = json.loads(dumped_json)

    yaml_path.with_suffix(".json").write_bytes(dumped_json)
    with open(yaml_path, "w") as fp:
        yaml.safe_dump(dumped, fp, sort_keys=False)

    return structs


def load_structures(fn: pathlib.Path | str) -> list[Structure]:
    with open(fn) as fp:
        loaded = yaml.safe_load(fp)
    info_adapter = pydantic.TypeAdapter("list[Structure]")
    return info_adapter.validate_python(loaded)


def load_all_structures(*yaml_paths: pathlib.Path | str) -> list[Structure]:
    all_structs = []
    for yaml_path in yaml_paths:
        all_structs.extend(load_structures(yaml_path))
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
        convert(
            parser_config, source_config, get_output_path(source_config.yaml_filename)
        )


def main():
    argp = argparse.ArgumentParser()
    argp.add_argument("--config", nargs="?")
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
