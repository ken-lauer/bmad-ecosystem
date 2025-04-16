from __future__ import annotations

import argparse
import ast
import json
import keyword
import logging
import os
import pathlib
from typing import NamedTuple, Sequence

import jinja2
import pydantic
import yaml

logger = logging.getLogger(__name__)

size_ignore = {"rp", "dp", "hsize_t"}

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
    sources: list[SourcePaths]

    @classmethod
    def from_file(cls, filename: pathlib.Path) -> ParserConfig:
        with open(filename) as fp:
            contents = yaml.safe_load(fp)
        return cls.model_validate(contents)


class SourcePaths(pydantic.BaseModel, frozen=True):
    source_dir: pathlib.Path
    fortran_filename: pathlib.Path
    yaml_filename: str
    python_filename: str
    python_import_name: str
    function_prefix: str

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
    name: str = ""
    python_name: str = ""
    type: str = ""
    python_type: str = ""
    size: str | None = None
    dimension: str | None = None
    comment: str = ""
    fortran_default: bool | int | str | float | None = ""
    default: DefaultType = ""
    default_factory: str = ""

    @pydantic.field_validator("size")
    @classmethod
    def _validate_size(cls, size: str | None):
        if not size:
            return None
        if size in size_ignore or not size.isnumeric():
            return None
        return size


class StructureInfo(pydantic.BaseModel):
    class_name: str = ""
    comment: str = ""
    members: dict[str, StructureMember] = pydantic.Field(default_factory=dict)


todo = set()


class Structure(pydantic.BaseModel):
    filename: pathlib.Path
    line: int
    name: str
    module: str
    lines: list[str] = pydantic.Field(default_factory=list, exclude=True)
    info: StructureInfo = pydantic.Field(default_factory=StructureInfo)

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
                line, comment = [part.strip() for part in line.split("!", 1)]
            else:
                line, comment = line, ""

            if not line or line.lower() in skips:
                if last_member and comment:
                    last_member.comment = f"{last_member.comment} {comment}".strip()
                continue

            for decl in parse_declaration(line):
                type_, size = get_type_from_line(line)
                try:
                    python_type = get_python_type(type_)
                except NotImplementedError:
                    todo.add(type_.lower())
                    continue

                default, default_factory = get_default(python_type, size, decl.default)

                self.info.members[decl.name] = StructureMember(
                    name=decl.name,
                    python_name=get_python_member_name(decl.name),
                    type=type_,
                    python_type=python_type,
                    line=lineno,
                    definition=line,
                    comment=comment,
                    size=size,
                    dimension=decl.dimension,
                    fortran_default=decl.default,
                    default=default,
                    default_factory=default_factory,
                )
                last_member = self.info.members[decl.name]


def get_default(
    python_type: str, size: str | None, fortran_default: str
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


def get_type_from_line(line: str) -> tuple[str, str | None]:
    if "::" in line:
        type_ = line[: line.index("::")].strip()
    else:
        type_ = line.split()[0]

    type_ = type_.rstrip(", ")
    if line.lower().startswith("type(") or line.lower().startswith("type "):
        type_ = get_in_parenthesis(line)
        return type_, None

    if "(" in type_:
        size = get_in_parenthesis(type_)
        type_ = type_.split("(")[0].strip()
        return type_, size

    if "*" in type_:
        type_, size = type_.split("*", 1)
        return type_.strip(), size.strip()
    return type_, None


def remove_comment(line: str) -> str:
    # TODO: this is naive and assumes no strings with exclamation points, etc
    if "!" in line:
        return line[: line.index("!")].rstrip()
    return line


def get_names_from_line(line: str) -> list[str]:
    return [name for name, *_ in parse_declaration(line)]


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


def _split_variable(line: str) -> ParsedDeclaration:
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
        dimension=dimension.strip(),
        default=default.strip() if default else None,
    )


def parse_type_declaration(line: str) -> list[ParsedDeclaration]:
    assert line.lower().startswith("type ") or line.lower().startswith("type(")

    if "::" in line:
        line = line[line.index("::") + 2 :]
    else:
        if ")" not in line:
            return [
                ParsedDeclaration(name=line.split()[1], dimension=None, default=None)
            ]
        line = line.split(")", 1)[1].strip()

    return [_split_variable(variable) for variable in _split_variables(line)]


def parse_declaration(line: str) -> list[ParsedDeclaration]:
    line = remove_comment(line)
    if line.lower().startswith("type ") or line.lower().startswith("type("):
        return parse_type_declaration(line)

    if "::" in line:
        line = line[line.index("::") + 2 :]
    else:
        line = " ".join(line.split()[1:])

    return [_split_variable(variable) for variable in _split_variables(line)]


def get_python_member_name(name: str) -> str:
    name = name.lower()
    assert name
    if (
        keyword.iskeyword(name)
        or name in dir(__builtins__)
        or name in {"str", "int", "float", "list", "tuple"}
    ):
        return f"{name}_"
    if not name.isidentifier():
        return f"bmad_{name}"
    if name.startswith("model_"):
        return f"bmad_{name}"
    return {
        "lambda": "lambda_",
        "global": "global_",
        "as": "as_",
        "l": "L",
    }.get(name, name)


def get_python_type(name: str) -> str:
    type_map = {
        "logical": "bool",
        "integer": "int",
        "real": "float",
        "character": "str",
        "complex": "Complex",  #  -> builtin type not supported
    }
    # name_case = name
    name = name.lower()
    if name in type_map:
        return type_map[name]
    for delim in "(, ":
        part = name.split(delim)[0]
        if part in type_map:
            # logical, allocatable (for example)
            return type_map[part]
    assert not name.startswith("character")
    # if name.endswith("_struct"):
    # name = name.split(",")[0].strip()
    # if name == "type":
    #     return "type"
    renames = {
        "TreeElementZhe": "TreeElement",
    }
    class_name = to_class_name(name)
    return renames.get(class_name, class_name)
    # raise NotImplementedError(name_case)


def find_structs(
    contents: str,
    by_class_name: dict[str, Structure],
    filename: pathlib.Path,
) -> dict[str, Structure]:
    structs = {}
    in_struct = ""
    module = filename.stem
    for num, line in enumerate(contents.splitlines(), 1):
        lower_line = line.lower().split()
        if not lower_line:
            ...
        elif lower_line[0] == "module":
            if len(lower_line) == 2:
                module = lower_line[1]
            else:
                logger.debug(f"Skipping module line: {lower_line}")
        elif lower_line[0] == "type" or lower_line[0].startswith("type,"):
            if line.lower().replace(" ", "").startswith("type("):
                if in_struct:
                    structs[in_struct].lines.append(line.strip())
                continue
            if line.lower().startswith("type is"):
                # select type(x) / type is (y)
                continue
            if in_struct:
                raise RuntimeError(f"{filename}:{num}: In struct: {in_struct} {line}")
            (in_struct,) = get_names_from_line(line)
            class_name = to_class_name(in_struct)
            while class_name in by_class_name:
                class_name += "_"
            assert module != "Sc_euclidean"
            structs[in_struct] = Structure(
                filename=filename,
                module=module,
                name=in_struct,
                line=num,
                lines=[line.strip()],
                info=StructureInfo(class_name=class_name),
            )
            by_class_name[class_name] = structs[in_struct]
        elif lower_line[:2] == ["end", "type"] or lower_line[0] == "endtype":
            if not in_struct:
                raise RuntimeError(f"{filename}:{num}: Not in struct? {line}")
            logger.debug(f"Saw structure: {in_struct}")  # , structs[in_struct])
            in_struct = ""
        elif in_struct:
            structs[in_struct].lines.append(line.strip())

    return structs


skip_includes = ["fftw3.f03", "mpif.h"]


def fill_includes(filename: pathlib.Path, contents: str) -> str:
    result = []
    for line in contents.splitlines():
        parts = line.strip().split()
        if parts and parts[0].lower() == "include":
            include_fn = parts[1].replace("'", "")

            if include_fn in skip_includes or not include_fn.lower().endswith(
                ".f90"
            ):  # TODO config file
                result.append(line)
            else:
                include_path = filename.parent / include_fn
                result.extend(include_path.read_text().splitlines())
                # TODO: no recursive includes
        else:
            result.append(line)

    return "\n".join(result)


def find_structs_in_file(
    filename: pathlib.Path,
    by_class_name: dict[str, Structure],
) -> dict[str, Structure]:
    with open(filename, encoding="latin-1") as fp:
        contents = fp.read()

    contents = fill_includes(filename, contents)
    return find_structs(
        contents=contents,
        by_class_name=by_class_name,
        filename=filename,
    )


def to_class_name(bmad_name: str) -> str:
    """Convert a bmad struct name to a dataclass name."""
    name_chars = list(bmad_name.capitalize())
    renames = {}
    while "_" in name_chars:
        idx = name_chars.index("_")
        name_chars.pop(idx)
        if idx < len(name_chars):
            name_chars[idx] = name_chars[idx].upper()
    class_name = "".join(name_chars)
    return renames.get(class_name, class_name)


def convert(
    path: pathlib.Path,
    yaml_path: pathlib.Path,
) -> dict[pathlib.Path, dict[str, Structure]]:
    by_file = {}
    failed = {}
    by_class_name = {}
    filenames = list(path.glob("**/*.f90", case_sensitive=False))
    # filenames.extend(list(path.glob("**/*.inc", case_sensitive=False)))
    for source_fn in filenames:
        try:
            by_file[source_fn] = find_structs_in_file(source_fn, by_class_name)
        except Exception as ex:
            failed[source_fn] = ex
            raise

    logger.info(
        f"{path.name!r} total structures: %d",
        sum(len(structs) for structs in by_file.values()),
    )
    logger.info(f"Path: {path}")
    logger.info(
        "Total structures: %d", sum(len(structs) for structs in by_file.values())
    )
    logger.info("Success:          %d", len(by_file))
    logger.info("Failures:         %d", len(failed))
    for fail, reason in failed.items():
        logger.error(f"Failed: {fail} {reason}")

    for source_fn, structs in by_file.items():
        for _, info in structs.items():
            info.parse()

    info_adapter = pydantic.TypeAdapter(dict[pathlib.Path, dict[str, Structure]])
    dumped = json.loads(info_adapter.dump_json(by_file))

    with open(yaml_path, "wt") as fp:
        yaml.safe_dump(dumped, fp)

    for item in sorted(todo):
        logger.error(f"(TODO) not yet supported: {item}")

    return by_file


StructureFile = dict[pathlib.Path, dict[str, Structure]]


def load_structures(fn: pathlib.Path | str) -> StructureFile:
    with open(fn) as fp:
        loaded = yaml.safe_load(fp)
    info_adapter = pydantic.TypeAdapter(StructureFile)
    return info_adapter.validate_python(loaded)


# def load_all_structures_by_class_name() -> dict[str, Structure]:
#     by_name = {}
#     for paths in all_source_to_paths.values():
#         for _, structs in load_structures(GENERATED_PATH / paths["yaml"]).items():
#             for struct in structs.values():
#                 by_name[struct.info.class_name] = struct
#     return by_name


def get_all_structure_names(path: AnyPath) -> list[str]:
    res = []
    for structs in load_structures(path).values():
        for struct in structs.values():
            res.append(struct.info.class_name)
    return res


def get_classes_to_import(
    structs_by_filename: StructureFile, importable: dict[str, str]
) -> dict[str, set[str]]:
    res: dict[str, set[str]] = {}
    for _, structs in structs_by_filename.items():
        for struct in structs.values():
            for member in struct.info.members.values():
                if member.python_type in importable:
                    source = importable[member.python_type]
                    res.setdefault(source, set()).add(member.python_type)
    return res


def _custom_repr(obj: object) -> str:
    """A tweaked ``repr`` to always return double quotes."""
    result = repr(obj)
    return result.replace("'", '"')


def render_python_source(
    structs: StructureFile,
    *,
    template_filename: AnyPath = MODEL_TEMPLATE,
    classes_to_import: dict[str, set[str]],
) -> str:
    """
    Load the structure yaml file and generate dataclass source code for it.

    Parameters
    ----------
    path : str or pathlib.Path
        Path to the structure yaml file.

    Returns
    -------
    str
        Generated Python source code.
    """

    struct_file = pydantic.TypeAdapter(StructureFile)
    dict_structs = struct_file.dump_python(structs)
    template = pathlib.Path(template_filename).read_text()

    def maybe_raw_string(value: str) -> str:
        if "\\" in value:
            return "r"
        return ""

    env = jinja2.Environment()
    env.filters["repr"] = _custom_repr
    env.filters["maybe_raw_string"] = maybe_raw_string
    env.filters["splitlines"] = str.splitlines
    tpl = env.from_string(template)

    return tpl.render(
        all_structs=dict_structs,
        type_map={
            "string": "str",
            "double": "float",
            "integer": "int",
        },
        to_import=classes_to_import,
    ).strip()


def make_all_models(
    path: AnyPath,
    *,
    base_path: pathlib.Path = pathlib.Path("."),
    template_filename: AnyPath = MODEL_TEMPLATE,
    imports: dict[pathlib.Path, SourcePaths],
) -> str:
    """
    Load the structure yaml file and generate dataclass source code for it.

    Parameters
    ----------
    path : str or pathlib.Path
        Path to the structure yaml file.

    Returns
    -------
    str
        Generated Python source code.
    """

    structs = load_structures(path)

    import_structs = {
        struct_name: import_paths.python_import_name
        for _, import_paths in imports.items()
        for struct_name in get_all_structure_names(
            base_path / import_paths.yaml_filename
        )
    }

    classes_to_import = get_classes_to_import(structs, import_structs)
    return render_python_source(
        structs,
        template_filename=template_filename,
        classes_to_import=classes_to_import,
    )


def get_class_references(
    by_name: dict[str, Structure],
    name: str,
) -> set[str]:
    res: set[str] = set()

    struct = by_name[name]
    for member in struct.info.members.values():
        if member.python_type in by_name:
            res.add(member.python_type)
            res |= get_class_references(by_name, member.python_type)
    return res


# def make_model_subset(
#     limit_to: list[str],
#     *,
#     template_filename: AnyPath = MODEL_TEMPLATE,
# ) -> str:
#     """
#     Load the structure yaml file and generate dataclass source code for it.
#
#     Parameters
#     ----------
#     path : str or pathlib.Path
#         Path to the structure yaml file.
#
#     Returns
#     -------
#     str
#         Generated Python source code.
#     """
#
#     by_name = load_all_structures_by_class_name()
#
#     to_add = set()
#     for name in limit_to:
#         refs = get_class_references(by_name, name)
#         refs = refs - to_add
#         for ref in refs:
#             print(f"Adding new reference for {name}: {ref}")
#         to_add |= refs
#
#     limit_to = sorted(set(limit_to) | to_add)
#     by_name = {name: by_name[name] for name in limit_to}
#     return render_python_source(
#         {pathlib.Path(): by_name},
#         template_filename=template_filename,
#         classes_to_import={},
#     )


def convert_and_write(
    config: ParserConfig, output_path: pathlib.Path, classes: list[str] | None = None
):
    def get_output_path(fn: str) -> pathlib.Path:
        output_fn = pathlib.Path(output_path) / fn
        output_fn.parent.mkdir(exist_ok=True, parents=True)
        return output_fn

    for source in config.sources:
        convert(source.source_dir, get_output_path(source.yaml_filename))

    for source in config.sources:
        python_source = make_all_models(
            get_output_path(source.yaml_filename),
            base_path=output_path,
            imports={
                other.source_dir: other
                for other in config.sources
                if other.source_dir != source.source_dir
            },
        )
        get_output_path(source.python_filename).write_text(python_source)


def main():
    argp = argparse.ArgumentParser()
    argp.add_argument("--config", nargs="?")
    # argp.add_argument("--path", dest="paths", nargs="*")
    # argp.add_argument("--cls", dest="classes", nargs="*")
    argp.add_argument("--output", default=".", nargs="?")
    argp.add_argument("-l", "--log-level", nargs="?", default="INFO")
    args = argp.parse_args()

    logging.basicConfig(
        level=args.log_level.upper(),
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    # if args.config:
    conf = ParserConfig.from_file(args.config)
    convert_and_write(config=conf, output_path=pathlib.Path(args.output))
    # else:
    #     # convert_and_write(paths=args.paths, classes=args.classes, output=args.output)
    #     raise NotImplementedError


if __name__ == "__main__":
    main()
