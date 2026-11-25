#!/usr/bin/env python3
"""
Generate a Ninja build file that compiles sim_utils, forest, bmad and tao to WebAssembly.

The regular Bmad build system (util/Master.cmake) is not used: it is tied to native compilers
and to libraries (X11, readline, MPI, ...) that do not exist in the browser. This script scans
the Fortran sources for module dependencies and writes `wasm/build/build.ninja`.

Usage: `python3 wasm/gen_ninja.py && ninja -C wasm/build`
"""

from __future__ import annotations

import argparse
import os
import re
import shlex
from dataclasses import dataclass, field
from pathlib import Path
from typing import Self

ROOT = Path(__file__).resolve().parent.parent
WASM = ROOT / "wasm"

FORTRAN_SUFFIXES = {".f90", ".f"}
C_SUFFIXES = {".c"}
CXX_SUFFIXES = {".cpp", ".cc"}

MODULE_RE = re.compile(r"^\s*module\s+(\w+)\s*(?:!.*)?$", re.IGNORECASE | re.MULTILINE)
SUBMODULE_RE = re.compile(
    r"^\s*submodule\s*\(\s*(\w+)(?:\s*:\s*\w+)?\s*\)\s*(\w+)",
    re.IGNORECASE | re.MULTILINE,
)
USE_RE = re.compile(
    r"^\s*use\s*(?:,\s*(?:non_)?intrinsic\s*)?(?:::)?\s*(\w+)",
    re.IGNORECASE | re.MULTILINE,
)
INCLUDE_RE = re.compile(
    r"^\s*#?\s*include\s+['\"<]([^'\">]+)['\">]", re.IGNORECASE | re.MULTILINE
)


@dataclass
class Library:
    """
    One static library built from a directory of the Bmad source tree.

    Attributes
    ----------
    name : str
        Library name. Also the top level source directory.
    src_dirs : list[str]
        Sub-directories searched recursively for sources.
    inc_dirs : list[str]
        Sub-directories holding include files.
    exclude : list[str]
        Glob patterns (relative to the library directory) of sources to skip.
    extra : list[Path]
        Additional source files from outside the library directory.
    """

    name: str
    src_dirs: list[str]
    inc_dirs: list[str] = field(default_factory=list)
    exclude: list[str] = field(default_factory=list)
    extra: list[Path] = field(default_factory=list)

    def sources(self) -> list[Path]:
        found: list[Path] = []
        base = ROOT / self.name
        for sub in self.src_dirs:
            for path in sorted((base / sub).rglob("*")):
                if path.suffix not in FORTRAN_SUFFIXES | C_SUFFIXES | CXX_SUFFIXES:
                    continue
                rel = path.relative_to(base)
                if any(rel.match(pattern) for pattern in self.exclude):
                    continue
                found.append(path)
        return found + self.extra


LIBRARIES = [
    Library(
        name="sim_utils",
        src_dirs=[
            "file",
            "interfaces",
            "io",
            "math",
            "matrix",
            "misc",
            "optimizers",
            "plot",
            "string",
            "geodesic_lm",
            "special_functions",
        ],
        exclude=[
            # Terminal and display code: replaced by wasm/src/web_shims.c and qp_web.c.
            "io/read_line.c",
            "io/readline_completion.c",
            "plot/qp_cairo.c",
            "plot/qp_cairo_render.c",
            "plot/qp_gtk_window.c",
            "plot/display_size_and_resolution.c",
            "plot/gtk_window/*",
        ],
        extra=[WASM / "src" / "web_shims.c", WASM / "src" / "qp_web.c"],
    ),
    Library(name="forest", src_dirs=["code"], inc_dirs=["include"]),
    Library(
        name="bmad",
        src_dirs=[
            "code",
            "geometry",
            "interface",
            "modules",
            "multiparticle",
            "output",
            "ptc",
            "photon",
            "parsing",
            "low_level",
            "hdf5",
            "space_charge",
            "spin",
        ],
    ),
    Library(name="tao", src_dirs=["code"]),
]


@dataclass
class Source:
    """
    A source file and what it provides to, and needs from, other Fortran files.

    Attributes
    ----------
    path : Path
        Source file.
    lib : str
        Name of the library the object goes into.
    provides : set[str]
        Modules (lower case) defined by the file.
    uses : set[str]
        Modules (lower case) used by the file, including submodule parents.
    includes : set[str]
        Names of included files.
    """

    path: Path
    lib: str
    provides: set[str] = field(default_factory=set)
    uses: set[str] = field(default_factory=set)
    includes: set[str] = field(default_factory=set)

    @classmethod
    def from_file(cls, path: Path, lib: str) -> Self:
        src = cls(path=path, lib=lib)
        if path.suffix not in FORTRAN_SUFFIXES:
            return src
        text = path.read_text(errors="replace")
        src.provides = {m.group(1).lower() for m in MODULE_RE.finditer(text)}
        src.uses = {m.group(1).lower() for m in USE_RE.finditer(text)}
        for match in SUBMODULE_RE.finditer(text):
            src.uses.add(match.group(1).lower())
        src.uses -= src.provides
        src.includes = {m.group(1) for m in INCLUDE_RE.finditer(text)}
        return src

    @property
    def obj(self) -> str:
        rel = os.path.relpath(self.path, ROOT).replace("..", "_").replace(os.sep, "__")
        return f"obj/{self.lib}/{rel}.o"


def ninja_escape(path: str | Path) -> str:
    return str(path).replace("$", "$$").replace(" ", "$ ").replace(":", "$:")


def generate(toolchain: Path, build_dir: Path, opt: str) -> str:
    """
    Build the text of the Ninja file.

    Parameters
    ----------
    toolchain : Path
        Directory made by `wasm/build_toolchain.sh` and `wasm/build_deps.sh`.
    build_dir : Path
        Directory the Ninja file is written to.
    opt : str
        Optimization flag for all compilers.

    Returns
    -------
    str
    """
    flang = toolchain / "build" / "bin" / "flang"
    prefix = toolchain / "prefix"

    sources = [
        Source.from_file(p, lib.name) for lib in LIBRARIES for p in lib.sources()
    ]
    provider: dict[str, Source] = {}
    for src in sources:
        for mod in src.provides:
            provider[mod] = src

    include_files: dict[str, Path] = {}
    inc_flags = [f"-I{prefix / 'include'}"]
    for lib in LIBRARIES:
        for sub in lib.inc_dirs:
            inc_dir = ROOT / lib.name / sub
            inc_flags.append(f"-I{inc_dir}")
            for path in inc_dir.iterdir():
                include_files[path.name] = path

    defines = "-DCESR_UNIX -DCESR_LINUX -DCESR_CAIRO -DACC_NO_QUAD_PRECISION"
    out: list[str] = [
        "# Generated by wasm/gen_ninja.py. Do not edit.",
        "ninja_required_version = 1.10",
        f"flang = {flang}",
        (
            f"fflags = --target=wasm32-unknown-emscripten -cpp {opt} {defines} "
            f"-module-dir mod -Imod {' '.join(inc_flags)}"
        ),
        f"cflags = {opt} {defines} -Wno-everything -I{prefix / 'include'}",
        f"prefix = {prefix}",
        f"rtlib = {toolchain / 'wasm' / 'lib' / 'libflang_rt.runtime.a'}",
        "",
        "rule fc",
        "  command = $flang $fflags -c $in -o $out",
        "  description = FC $in",
        "rule cc",
        "  command = emcc $cflags -c $in -o $out",
        "  description = CC $in",
        "rule cxx",
        "  command = em++ $cflags -c $in -o $out",
        "  description = CXX $in",
        "rule ar",
        "  command = rm -f $out && emar rcs $out @$out.rsp",
        "  rspfile = $out.rsp",
        "  rspfile_content = $in",
        "  description = AR $out",
        "rule link",
        "  command = em++ $opt_link $in $libs $rtlib $ldflags -o $out",
        "  description = LINK $out",
        "rule copy",
        "  command = cp $in $out",
        "  description = COPY $out",
        "",
    ]

    objects: dict[str, list[str]] = {lib.name: [] for lib in LIBRARIES}
    for src in sources:
        rule = (
            "fc"
            if src.path.suffix in FORTRAN_SUFFIXES
            else "cc"
            if src.path.suffix in C_SUFFIXES
            else "cxx"
        )
        deps = sorted(
            {
                provider[m].obj
                for m in src.uses
                if m in provider and provider[m] is not src
            }
        )
        deps += sorted(
            str(include_files[i]) for i in src.includes if i in include_files
        )
        line = f"build {ninja_escape(src.obj)}: {rule} {ninja_escape(src.path)}"
        if deps:
            line += " | " + " ".join(ninja_escape(d) for d in deps)
        out.append(line)
        objects[src.lib].append(src.obj)

    archives = []
    for lib in LIBRARIES:
        archive = f"lib/lib{lib.name}.a"
        archives.append(archive)
        out.append(
            f"build {archive}: ar {' '.join(ninja_escape(o) for o in objects[lib.name])}"
        )

    exported = [
        "_tao_c_init_tao",
        "_tao_c_command",
        "_tao_c_out_io_buffer_num_lines",
        "_tao_c_out_io_buffer_get_line",
        "_tao_c_out_io_buffer_reset",
        "_tao_c_real_array_size",
        "_tao_c_get_real_array",
        "_tao_c_integer_array_size",
        "_tao_c_get_integer_array",
        "_tao_web_plot_sync",
        "_tao_web_complete",
        "_malloc",
        "_free",
    ]
    runtime_methods = [
        "ccall",
        "cwrap",
        "FS",
        "UTF8ToString",
        "stringToUTF8",
        "lengthBytesUTF8",
        "HEAPF64",
        "HEAP32",
    ]
    ldflags = [
        "-sMODULARIZE=1",
        "-sEXPORT_ES6=1",
        "-sEXPORT_NAME=createTaoModule",
        "-sENVIRONMENT=web,worker,node",
        "-sALLOW_MEMORY_GROWTH=1",
        "-sINITIAL_MEMORY=268435456",
        "-sMAXIMUM_MEMORY=4294967296",
        "-sSTACK_SIZE=67108864",
        "-sFORCE_FILESYSTEM=1",
        "-sEXIT_RUNTIME=0",
        "-sERROR_ON_UNDEFINED_SYMBOLS=1",
        "--no-entry",
        # Keep function names so that stack traces of a crash are readable.
        "--profiling-funcs",
        f"-sEXPORTED_FUNCTIONS={','.join(exported)}",
        f"-sEXPORTED_RUNTIME_METHODS={','.join(runtime_methods)}",
    ]
    dep_libs = [
        "libxrlf03.a",
        "libxrl.a",
        "libfgsl.a",
        "libgsl.a",
        "libgslcblas.a",
        "liblapack95.a",
        "liblapack.a",
        "libblas.a",
        "libfftw3.a",
        "libhdf5_hl_fortran.a",
        "libhdf5_hl_f90cstub.a",
        "libhdf5_fortran.a",
        "libhdf5_f90cstub.a",
        "libhdf5_hl.a",
        "libhdf5.a",
    ]
    # tao -> bmad -> forest -> sim_utils. Listed twice since sim_utils and bmad refer to each other.
    link_archives = list(reversed(archives)) * 2
    out += [
        "",
        f"build tao.js | tao.wasm: link {' '.join(link_archives)}",
        f"  libs = {' '.join(str(prefix / 'lib' / name) for name in dep_libs)}",
        f"  ldflags = {shlex.join(ldflags)}",
        f"  opt_link = {opt}",
        "",
        "default tao.js",
        "",
    ]
    return "\n".join(out)


def main() -> None:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--toolchain",
        type=Path,
        default=Path(
            os.environ.get(
                "BMAD_WASM_TOOLCHAIN", Path.home() / ".cache" / "bmad-wasm-toolchain"
            )
        ),
        help="Toolchain directory (default: $BMAD_WASM_TOOLCHAIN or ~/.cache/bmad-wasm-toolchain)",
    )
    parser.add_argument("--build-dir", type=Path, default=WASM / "build")
    parser.add_argument("--opt", default="-O2", help="Optimization flag (default: -O2)")
    args = parser.parse_args()

    args.build_dir.mkdir(parents=True, exist_ok=True)
    (args.build_dir / "mod").mkdir(exist_ok=True)
    (args.build_dir / "build.ninja").write_text(
        generate(args.toolchain.resolve(), args.build_dir, args.opt)
    )
    print(f"Wrote {args.build_dir / 'build.ninja'}")


if __name__ == "__main__":
    main()
