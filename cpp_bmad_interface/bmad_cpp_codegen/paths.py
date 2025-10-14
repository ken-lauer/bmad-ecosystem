from __future__ import annotations

import os
import pathlib
import shutil

CODEGEN_ROOT = pathlib.Path(__file__).resolve().absolute().parent

if "ACC_ROOT_DIR" in os.environ:
    ACC_ROOT_DIR = pathlib.Path(os.environ["ACC_ROOT_DIR"]).resolve().absolute()
else:
    ACC_ROOT_DIR = CODEGEN_ROOT.parents[2]

CPP_INTERFACE_ROOT = ACC_ROOT_DIR / "cpp_bmad_interface"
STRUCT_PARSER_ROOT = ACC_ROOT_DIR / "structs"

CLANG_FORMAT_PATH = os.environ.get("CLANG_FORMAT_PATH", shutil.which("clang-format"))
