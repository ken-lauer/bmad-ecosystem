from __future__ import annotations

import dataclasses
import os
import pathlib
import tomllib
from typing import Any

from .util import STRUCTS_ROOT

DEFAULT_CONFIG_FILE = STRUCTS_ROOT / "config.toml"


@dataclasses.dataclass(frozen=True)
class JsonConfig:
    skip_members: tuple[str, ...] = dataclasses.field(default_factory=tuple)
    skip_files: tuple[str, ...] = dataclasses.field(default_factory=tuple)

    @classmethod
    def from_data(cls, data: dict[str, Any]):
        return cls(
            skip_members=tuple(data.get("skip_members", [])),
            skip_files=tuple(data.get("skip_files", [])),
        )


@dataclasses.dataclass(frozen=True)
class SourceConfig:
    source_dir: pathlib.Path
    fortran_filename: pathlib.Path
    json_filename: str
    function_prefix: str
    skip_includes: tuple[str, ...] = dataclasses.field(default_factory=tuple)
    json_config: JsonConfig = dataclasses.field(default_factory=JsonConfig)
    skip_structs: tuple[str, ...] = dataclasses.field(default_factory=tuple)
    include_dirs: tuple[pathlib.Path, ...] = dataclasses.field(default_factory=tuple)

    @staticmethod
    def _validate_source_path(v: pathlib.Path | str) -> pathlib.Path:
        # Expand environment variables in the path
        expanded_path = pathlib.Path(os.path.expandvars(str(v)))

        if not expanded_path.exists():
            raise ValueError(f"Path does not exist: {expanded_path}")

        return expanded_path

    @staticmethod
    def _validate_fortran_filename(v: pathlib.Path | str) -> pathlib.Path:
        # Expand environment variables in the path
        expanded_path = pathlib.Path(os.path.expandvars(str(v)))

        if expanded_path.is_dir():
            raise ValueError(f"Path is a directory: {expanded_path}")

        expanded_path.parent.mkdir(exist_ok=True, parents=True)
        return expanded_path

    @staticmethod
    def _validate_include_dirs(values: list[pathlib.Path | str]) -> tuple[pathlib.Path, ...]:
        expanded_paths = [pathlib.Path(os.path.expandvars(str(v))) for v in values]
        for path in expanded_paths:
            if not path.is_dir():
                raise ValueError(f"Path is not a directory: {path}")

        return tuple(expanded_paths)

    @classmethod
    def from_data(cls, data: dict[str, Any]):
        try:
            source_dir = cls._validate_source_path(data["source_dir"])
            fortran_filename = cls._validate_fortran_filename(data["fortran_filename"])
            json_filename = str(data["json_filename"])
            function_prefix = str(data["function_prefix"])
            skip_includes = tuple(data["skip_includes"])
            json_config = JsonConfig.from_data(data.pop("json_config", {}))
            include_dirs = cls._validate_include_dirs(data.get("include_dirs", []))
            skip_structs = tuple(data.get("skip_structs", []))
        except KeyError as ex:
            raise ValueError(f"Missing required key: {ex} in source config data: {data}") from ex

        return cls(
            json_filename=json_filename,
            function_prefix=function_prefix,
            skip_includes=skip_includes,
            json_config=json_config,
            include_dirs=include_dirs,
            source_dir=source_dir,
            fortran_filename=fortran_filename,
            skip_structs=skip_structs,
        )


@dataclasses.dataclass
class ParserConfig:
    sources: list[SourceConfig]

    @classmethod
    def from_file(cls, filename: pathlib.Path | str) -> ParserConfig:
        with pathlib.Path(filename).open("rb") as fp:
            contents = tomllib.load(fp)

        return cls(sources=[SourceConfig.from_data(source_data) for source_data in contents["sources"]])
