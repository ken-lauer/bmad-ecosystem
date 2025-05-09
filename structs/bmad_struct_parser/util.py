from __future__ import annotations

import logging
import os
import pathlib
from collections.abc import Callable, Sequence
from pathlib import Path
from typing import NamedTuple

logger = logging.getLogger(__name__)
STRUCTS_ROOT = pathlib.Path(__file__).resolve().absolute().parent

if "ACC_ROOT_DIR" in os.environ:
    ACC_ROOT_DIR = pathlib.Path(os.environ["ACC_ROOT_DIR"]).resolve().absolute()
else:
    ACC_ROOT_DIR = STRUCTS_ROOT.parents[2]


def split_comment(line: str, comment_char: str = "!", escape_char: str = "\\") -> tuple[str, str]:
    in_single_quote = False
    in_double_quote = False
    escape_next = False

    for i, char in enumerate(line):
        if escape_next:
            escape_next = False
            continue

        if char == escape_char:
            escape_next = True
            continue

        if char == "'" and not in_double_quote:
            in_single_quote = not in_single_quote
        elif char == '"' and not in_single_quote:
            in_double_quote = not in_double_quote
        elif char == comment_char and not in_single_quote and not in_double_quote:
            # Found comment char outside of quotes
            return (line[:i].strip(), line[i + 1 :].strip())

    return line, ""


def join_ampersand_lines(lines: Sequence[FileLine]) -> list[FileLine]:
    res: list[FileLine] = []
    continuation = False
    # TODO: & could be in string, comment, etc.
    for line in lines:
        code = line.line.strip()
        pre_comment, _comment = split_comment(code)
        if pre_comment.strip().endswith("&"):
            pre_ampersand = pre_comment.split("&")[0]
        else:
            pre_ampersand = code

        if continuation:
            res[-1] = res[-1]._replace(line=res[-1].line + pre_ampersand)
        else:
            res.append(
                FileLine(
                    lineno=line.lineno,
                    line=pre_ampersand,
                    filename=line.filename,
                )
            )

        continuation = pre_comment.strip().endswith("&")

    return res


class FileLine(NamedTuple):
    filename: pathlib.Path
    lineno: int
    line: str

    def strip(self) -> FileLine:
        return self._replace(line=self.line.strip())

    @classmethod
    def from_file(
        cls, path: pathlib.Path, join_ampersands: bool = True, encoding: str = "latin-1"
    ) -> list[FileLine]:
        lines = [
            FileLine(lineno=lineno, line=line, filename=path)
            for lineno, line in enumerate(path.read_text(encoding=encoding).splitlines(), start=1)
        ]
        return join_ampersand_lines(lines) if join_ampersands else lines

    def split_comment(self, comment_char: str = "!") -> tuple[str, str]:
        return split_comment(self.line, comment_char=comment_char)

    def __str__(self):
        return f"{self.filename}:{self.lineno}"


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


def write_file_if_changed(
    filename: Path | str,
    content: str,
    logger: logging.Logger = logger,
    description: str = "File",
    transform_content: Callable[[str], str] | None = None,
) -> bool:
    """
    Write text content to `filename` only if it differs from what's on disk.

    Parameters
    ----------
    filename : Path or str
        Path to the file to be written
    content : str
        New content to write to the file
    logger : logging.Logger, optional
        Logger instance for recording actions. If None, use the module logger.
    description : str, default="File"
        Description of the file type for log messages (e.g., "JSON file", "Config file")
    transform_content : callable, optional
        Optional function to transform content before comparison (e.g., for normalization)
        Should take a string and return a string

    Returns
    -------
    bool
        True if file was written, False if unchanged
    """
    if not isinstance(filename, Path):
        filename = Path(filename)

    content_to_write = transform_content(content) if transform_content else content

    try:
        existing_content = filename.read_text()
    except FileNotFoundError:
        logger.info(f"Writing new {description}: %s (%d bytes)", filename, len(content_to_write))
    else:
        comparison_content = transform_content(existing_content) if transform_content else existing_content
        if comparison_content != content_to_write:
            filename.write_text(content_to_write)
            logger.info(
                f"Overwriting {description}: %s (%d -> %d bytes)",
                filename,
                len(existing_content),
                len(content_to_write),
            )
            return True
        logger.info(f"{description} unchanged, not writing: %s", filename)
        return False

    filename.parent.mkdir(parents=True, exist_ok=True)
    filename.write_text(content_to_write)
    return True
