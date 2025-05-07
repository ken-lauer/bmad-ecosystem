from __future__ import annotations

import os
import pathlib


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
