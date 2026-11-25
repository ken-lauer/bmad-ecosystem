#!/usr/bin/env python3
"""
Compare the WebAssembly build of Tao with a native build.

Each example of `bmad-doc/tao_examples` is run with both builds, with the same commands, and
the numbers in the output are compared.

Usage: `python3 wasm/test/compare_native.py --native-tao production/bin/tao`
"""

from __future__ import annotations

import argparse
import difflib
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
EXAMPLES = ROOT / "bmad-doc" / "tao_examples"
RUN_TAO = Path(__file__).resolve().parent / "run_tao.mjs"

COMMANDS = [
    "show universe",
    "show lattice -all",
    "show variable",
    "show data",
    "show element 1",
]
NUMBER = re.compile(r"[-+]?(?:\d+\.\d*|\.\d+|\d+)(?:[eE][-+]?\d+)?")
ANSI_ESCAPE = re.compile(r"\x1b\[[0-9;]*m")
# Lines that are expected to differ: time stamps, timing, prompts and echoed commands.
PROMPT = re.compile(r"^\S*> ?")
SKIP = re.compile(r"^\[|parse time|dTime|OpenMP|^====|^Tao>|^\s*$|Stopping\.")


@dataclass
class Comparison:
    """
    Result of comparing the output of the two builds for one example.

    Attributes
    ----------
    name : str
        Example name.
    n_lines : int
        Number of lines compared.
    n_identical : int
        Number of lines that are the same.
    n_structural : int
        Number of lines that differ in more than their numbers.
    max_rel_diff : float
        Largest relative difference between numbers.
    worst : tuple[str, str] | None
        The (WebAssembly, native) pair of lines with the largest difference.
    """

    name: str
    n_lines: int
    n_identical: int
    n_structural: int
    max_rel_diff: float
    worst: tuple[str, str] | None

    @property
    def ok(self) -> bool:
        return self.n_lines > 0 and self.n_structural == 0


def clean(text: str) -> list[str]:
    lines = []
    for line in ANSI_ESCAPE.sub("", text).splitlines():
        line = line.rstrip()
        if SKIP.search(line) or PROMPT.sub("", line).strip() in [*COMMANDS, "exit"]:
            continue
        lines.append(line)
    return lines


def run_wasm(directory: Path, args: str) -> list[str]:
    result = subprocess.run(
        ["node", str(RUN_TAO), str(directory), args, *COMMANDS],
        capture_output=True,
        text=True,
        check=False,
    )
    return clean(result.stdout)


def run_native(tao: Path, directory: Path, args: str) -> list[str]:
    stdin = "\n".join([*COMMANDS, "exit"]) + "\n"
    result = subprocess.run(
        [str(tao), *args.split(), "-noplot"],
        input=stdin,
        capture_output=True,
        text=True,
        cwd=directory,
        check=False,
    )
    return clean(result.stdout)


def compare(name: str, wasm: list[str], native: list[str]) -> Comparison:
    matcher = difflib.SequenceMatcher(None, wasm, native, autojunk=False)
    n_identical = sum(block.size for block in matcher.get_matching_blocks())
    n_structural = 0
    max_rel_diff = 0.0
    worst = None
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag == "equal":
            continue
        if tag != "replace" or i2 - i1 != j2 - j1:
            n_structural += max(i2 - i1, j2 - j1)
            continue
        for a, b in zip(wasm[i1:i2], native[j1:j2]):
            if NUMBER.sub("#", a).split() != NUMBER.sub("#", b).split():
                n_structural += 1
                continue
            for x, y in zip(
                map(float, NUMBER.findall(a)), map(float, NUMBER.findall(b))
            ):
                if x == y:
                    continue
                rel = abs(x - y) / max(abs(x), abs(y))
                if rel > max_rel_diff:
                    max_rel_diff = rel
                    worst = (a, b)
    return Comparison(
        name,
        max(len(wasm), len(native)),
        n_identical,
        n_structural,
        max_rel_diff,
        worst,
    )


def main() -> int:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--native-tao", type=Path, required=True, help="Native tao executable"
    )
    parser.add_argument(
        "examples", nargs="*", help="Example names (default: all with a tao.init file)"
    )
    args = parser.parse_args()

    names = args.examples or sorted(
        d.name for d in EXAMPLES.iterdir() if (d / "tao.init").exists()
    )
    failed = False
    for name in names:
        directory = EXAMPLES / name
        result = compare(
            name,
            run_wasm(directory, "-init tao.init -noplot"),
            run_native(args.native_tao.resolve(), directory, "-init tao.init"),
        )
        failed |= not result.ok
        print(
            f"{'ok  ' if result.ok else 'FAIL'} {name:32s} lines={result.n_lines:5d} identical={result.n_identical:5d} "
            f"structural_diffs={result.n_structural:4d} max_rel_diff={result.max_rel_diff:.1e}"
        )
        if result.worst and result.max_rel_diff > 1e-6:
            print(f"       wasm:   {result.worst[0][:140]}")
            print(f"       native: {result.worst[1][:140]}")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
