from __future__ import annotations

import logging
import os
import pathlib
from collections.abc import Callable
from pathlib import Path

logger = logging.getLogger(__name__)
STRUCTS_ROOT = pathlib.Path(__file__).resolve().absolute().parent

if "ACC_ROOT_DIR" in os.environ:
    ACC_ROOT_DIR = pathlib.Path(os.environ["ACC_ROOT_DIR"]).resolve().absolute()
else:
    ACC_ROOT_DIR = STRUCTS_ROOT.parents[2]


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
