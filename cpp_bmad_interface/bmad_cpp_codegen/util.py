from __future__ import annotations

import logging
import pathlib
import subprocess
import tempfile
from collections.abc import Callable

from .paths import CLANG_FORMAT_PATH

logger = logging.getLogger(__name__)


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
            logger.warning(f"Clang-format failed for {target_path}")
        else:
            contents = formatted_content.stdout.decode()

    if not target_path.exists():
        target_path.parent.mkdir(parents=True, exist_ok=True)
        logger.info(
            f"* Writing to {target_path} (new file) {len(contents)} bytes",
        )
        target_path.write_text(contents)
        return True

    target_content = target_path.read_text()

    if contents != target_content:
        logger.info(
            f"* Writing to {target_path} (new contents) {len(target_content)} -> {len(contents)} bytes",
        )
        target_path.write_text(contents)
        return True

    logger.info(f"* Not writing {target_path} (contents same)")
    return False
