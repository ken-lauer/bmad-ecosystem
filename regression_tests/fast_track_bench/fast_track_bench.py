#!/usr/bin/env python3
"""
Benchmark and validate Bmad bunch tracking across two builds (via pytao).

Each `run` loads one libtao and tracks a set of cases built only from lattices shipped
with Bmad (`bmad-doc/tao_examples`, `regression_tests`). Every case runs in its own
subprocess, so the library and Bmad's global state (`bmad_com`, `space_charge_com`) are
fresh for each case. Results go to `DIR/LABEL.json` (timings, Twiss, moments) and
`DIR/LABEL.npz` (particles at the start and end element).

`compare` prints a per-case speed table and a correctness report for two runs, and exits
non-zero if any case fails the selected tolerance mode.

Usage
-----
::

    python fast_track_bench.py list
    python fast_track_bench.py run base --so-lib ~/Repos/bmad/production/lib/libtao.dylib --out results
    python fast_track_bench.py run fast --so-lib <worktree>/production/lib/libtao.dylib --out results
    python fast_track_bench.py compare results base fast
    python fast_track_bench.py compare results base fast --mode statistical --k 5
"""

from __future__ import annotations

import argparse
import json
import os
import platform
import subprocess
import sys
import tempfile
import time
import traceback
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Any

import numpy as np

BMAD_ROOT = Path(__file__).resolve().parents[2]
COORDS = ("x", "px", "y", "py", "z", "pz")
MOMENTS = ("emit_x", "emit_y", "sig_z", "sig_pz", "mean_pz")
TWISS_SHOWN = (
    "beta_a",
    "alpha_a",
    "phi_a",
    "beta_b",
    "alpha_b",
    "phi_b",
    "eta_x",
    "etap_x",
)
LARGE_N = 1_000_000
LARGE_MESH = (64, 64, 128)
LARGE_DS = 0.005
RANDOM_SEED = 1234


@dataclass(frozen=True)
class Case:
    """
    One tracking benchmark.

    Attributes
    ----------
    name : str
        Case identifier used on the command line and in result files.
    description : str
        What the case exercises.
    lattice : str
        Lattice file, relative to the Bmad root. Lattices under `lattices/` here only
        wrap lattices shipped with Bmad.
    setup : tuple of str
        Tao commands run after loading the lattice (before tracking), e.g. per-element
        `csr_method`/`space_charge_method`.
    beam_init : dict
        `beam_init` settings (`n_particle` and `random_engine` are set separately).
    space_charge_com : dict
        `space_charge_com` settings.
    collective : bool
        Value of `bmad_com%csr_and_space_charge_on`.
    n : int
        Default particle count.
    end : str
        Element at which Twiss, moments and particles are recorded.
    start : str
        Element at which the initial distribution is recorded.
    large : bool
        Large-N case intended for a cluster; skipped unless selected explicitly.
    """

    name: str
    description: str
    lattice: str
    setup: tuple[str, ...] = ()
    beam_init: dict[str, Any] = field(default_factory=dict)
    space_charge_com: dict[str, Any] = field(default_factory=dict)
    collective: bool = False
    n: int = 10_000
    end: str = "END"
    start: str = "BEGINNING"
    large: bool = False


CSR_BEAM_INIT = {
    "a_norm_emit": 1.0e-6,
    "b_norm_emit": 1.0e-6,
    "dpz_dz": 0.0,
    "n_bunch": 1,
    "bunch_charge": 77.0e-12,
    "sig_pz": 1e-4,
    "sig_z": 0.000899377,
}

CSR_SC_COM = {
    "beam_chamber_height": 0.0254,
    "n_shield_images": 0,
    "ds_track_step": 0.01,
    "n_bin": 40,
    "particle_bin_span": 2,
    "lsc_sigma_cutoff": 0.1,
}

SC_BEAM_INIT = {
    "a_emit": 1e-9,
    "b_emit": 1e-9,
    "dpz_dz": 0.0,
    "n_bunch": 1,
    "bunch_charge": 1e-9,
    "sig_pz": 1e-9,
    "sig_z": 1e-4,
    "random_sigma_cutoff": 4,
}

SC_COM = {"n_bin": 40, "ds_track_step": 0.01}

ERL_BEAM_INIT = {
    "a_norm_emit": 1.0e-6,
    "b_norm_emit": 1.0e-6,
    "dpz_dz": 0.0,
    "n_bunch": 1,
    "bunch_charge": 77.0e-12,
    "sig_pz": 1e-3,
    "sig_z": 0.000899377,
}

ERL_SC_SETUP = (
    "set ele * csr_method = off",
    "set ele * space_charge_method = off",
    "set ele lcavity::*,drift::* space_charge_method = fft_3d",
)

GENERIC_BEAM_INIT = {
    "a_norm_emit": 1.0e-6,
    "b_norm_emit": 1.0e-6,
    "n_bunch": 1,
    "bunch_charge": 77.0e-12,
    "sig_pz": 1e-4,
    "sig_z": 1e-3,
}


def _mesh(mesh: tuple[int, int, int]) -> dict[str, int]:
    return {f"space_charge_mesh_size({i + 1})": m for i, m in enumerate(mesh)}


CASES: dict[str, Case] = {
    c.name: c
    for c in (
        Case(
            "csr_chicane",
            "1D CSR (+shielding settings) through the combined-function bends of "
            "tao_examples/csr_beam_tracking",
            "bmad-doc/tao_examples/csr_beam_tracking/lat.bmad",
            setup=(
                "set ele * csr_method = 1_dim",
                "set ele * space_charge_method = off",
            ),
            beam_init=CSR_BEAM_INIT,
            space_charge_com=CSR_SC_COM,
            collective=True,
            n=10_000,
            end="Mar.END",
        ),
        Case(
            "csr_bend_regression",
            "1D CSR in the single bend of regression_tests/csr_and_space_charge_test "
            "(branch 0 only, via lattices/csr_bend.bmad)",
            "regression_tests/fast_track_bench/lattices/csr_bend.bmad",
            setup=("set ele * csr_method = off", "set ele ben01 csr_method = 1_dim"),
            beam_init=CSR_BEAM_INIT,
            space_charge_com={
                "ds_track_step": 0.005,
                "n_bin": 40,
                "particle_bin_span": 2,
            },
            collective=True,
            n=10_000,
        ),
        Case(
            "space_charge",
            "3D FFT space charge in a 1 m pipe (tao_examples/space_charge)",
            "bmad-doc/tao_examples/space_charge/lat.bmad",
            setup=(
                "set ele * csr_method = off",
                "set ele * space_charge_method = fft_3d",
            ),
            beam_init=SC_BEAM_INIT,
            space_charge_com=SC_COM,
            collective=True,
            n=10_000,
        ),
        Case(
            "space_charge_quad",
            "3D FFT space charge with a superimposed quadrupole "
            "(tao_examples/space_charge/lat2.bmad)",
            "bmad-doc/tao_examples/space_charge/lat2.bmad",
            setup=(
                "set ele * csr_method = off",
                "set ele * space_charge_method = fft_3d",
            ),
            beam_init=SC_BEAM_INIT,
            space_charge_com=SC_COM,
            collective=True,
            n=5_000,
        ),
        Case(
            "sc_drift_regression",
            "3D FFT space charge in a 4 m drift, offset beam, absolute time tracking "
            "(regression_tests/space_charge_test/grid.bmad)",
            "regression_tests/space_charge_test/grid.bmad",
            beam_init=SC_BEAM_INIT,
            space_charge_com={"n_bin": 40, "ds_track_step": 0.02},
            collective=True,
            n=5_000,
        ),
        Case(
            "erl",
            "Multipass ERL: two 9-cell lcavities passed twice (accelerate/decelerate), "
            "Taylor-map arc, 3D space charge in linac (tao_examples/erl)",
            "bmad-doc/tao_examples/erl/lat.bmad",
            setup=ERL_SC_SETUP,
            beam_init=ERL_BEAM_INIT,
            space_charge_com={"ds_track_step": 0.02, "n_bin": 40},
            collective=True,
            n=5_000,
        ),
        Case(
            "erl_nocoll",
            "Multipass ERL lcavity/Taylor tracking without collective effects",
            "bmad-doc/tao_examples/erl/lat.bmad",
            beam_init=ERL_BEAM_INIT,
            n=20_000,
        ),
        Case(
            "cbeta_cell",
            "CBETA FFAG cell: offset combined-function quads with soft-edge fringes and "
            "patches, no collective effects (tao_examples/cbeta_cell/cell1.lat)",
            "bmad-doc/tao_examples/cbeta_cell/cell1.lat",
            beam_init=GENERIC_BEAM_INIT,
            n=20_000,
        ),
        Case(
            "cbeta_cell_rk",
            "CBETA FFAG cell with Runge-Kutta tracking in the quadrupoles",
            "bmad-doc/tao_examples/cbeta_cell/cell1.lat",
            setup=("set ele quadrupole::* tracking_method = runge_kutta",),
            beam_init=GENERIC_BEAM_INIT,
            n=2_000,
        ),
        Case(
            "fodo",
            "Single FODO cell, plain single-particle tracking and optics "
            "(tao_examples/fodo)",
            "bmad-doc/tao_examples/fodo/fodo.bmad",
            beam_init=GENERIC_BEAM_INIT,
            n=50_000,
        ),
        Case(
            "cesr",
            "One pass through the CESR ring (~800 m, wigglers, solenoid), no collective "
            "effects (tao_examples/cesr)",
            "bmad-doc/tao_examples/cesr/bmad_L9A18A000-_MOVEREC.lat",
            beam_init={**GENERIC_BEAM_INIT, "a_norm_emit": 1e-4, "b_norm_emit": 1e-5},
            n=2_000,
        ),
        Case(
            "erl_1m",
            "Large-N ERL with 3D space charge (cluster only)",
            "bmad-doc/tao_examples/erl/lat.bmad",
            setup=ERL_SC_SETUP,
            beam_init=ERL_BEAM_INIT,
            space_charge_com={
                "ds_track_step": LARGE_DS,
                "n_bin": 40,
                **_mesh(LARGE_MESH),
            },
            collective=True,
            n=LARGE_N,
            large=True,
        ),
        Case(
            "space_charge_1m",
            "Large-N 3D space charge in a 1 m pipe (cluster only)",
            "bmad-doc/tao_examples/space_charge/lat.bmad",
            setup=(
                "set ele * csr_method = off",
                "set ele * space_charge_method = fft_3d",
            ),
            beam_init=SC_BEAM_INIT,
            space_charge_com={
                "ds_track_step": LARGE_DS,
                "n_bin": 40,
                **_mesh(LARGE_MESH),
            },
            collective=True,
            n=LARGE_N,
            large=True,
        ),
    )
}


def _fmt(value: Any) -> str:
    if isinstance(value, bool):
        return "T" if value else "F"
    return str(value)


def configure(tao: Any, case: Case, n: int) -> list[str]:
    """
    Apply all settings of `case` to a freshly loaded Tao, leaving `track_type = single`.

    Returns
    -------
    list of str
        The Tao commands issued, recorded in the results for reproducibility.
    """
    cmds = [
        "set global lattice_calc_on = F",
        "set global track_type = single",
        "set bmad_com radiation_damping_on = F",
        "set bmad_com radiation_fluctuations_on = F",
        f"set bmad_com csr_and_space_charge_on = {_fmt(case.collective)}",
        *case.setup,
        *(
            f"set space_charge_com {k} = {_fmt(v)}"
            for k, v in case.space_charge_com.items()
        ),
        *(f"set beam_init {k} = {_fmt(v)}" for k, v in case.beam_init.items()),
        "set beam_init random_engine = quasi",
        f"set beam_init n_particle = {n}",
        f"set beam saved_at = {case.start}, {case.end}",
        "set global lattice_calc_on = T",
    ]
    for cmd in cmds:
        tao.cmd(cmd)
    return cmds


def bunch_at(tao: Any, ele: str) -> dict[str, np.ndarray]:
    """Phase-space coordinates and state of bunch 1 at the exit of `ele`."""
    out = {c: np.asarray(tao.bunch1(ele, c), dtype=float) for c in COORDS}
    out["state"] = np.asarray(tao.bunch1(ele, "state"), dtype=int)
    return out


def moments(p: dict[str, np.ndarray]) -> dict[str, float]:
    """Bunch moments of the alive particles in `p` (keys as in `bunch_at`)."""
    alive = p["state"] == 1
    v = {c: p[c][alive] for c in COORDS}
    if alive.sum() < 2:
        return {"alive": int(alive.sum()), **dict.fromkeys(MOMENTS, float("nan"))}

    def emit(a: str, b: str) -> float:
        return float(np.sqrt(max(np.linalg.det(np.cov(v[a], v[b])), 0.0)))

    return {
        "alive": int(alive.sum()),
        "emit_x": emit("x", "px"),
        "emit_y": emit("y", "py"),
        "sig_z": float(v["z"].std()),
        "sig_pz": float(v["pz"].std()),
        "mean_pz": float(v["pz"].mean()),
    }


def run_case(case: Case, so_lib: str, n: int, repeats: int, out_prefix: Path) -> None:
    """
    Track `case` `repeats` times in `so_lib`, writing `out_prefix`.json/.npz.

    The lattice is loaded through a `no_digested` wrapper next to `out_prefix`, so no
    digested files are written into the Bmad tree or shared between builds.

    Each repeat resets the random state (which restarts the quasi-random sequence),
    re-initializes the beam, and times the switch to `track_type = beam`, which tracks
    the bunch through the whole lattice.
    """
    from pytao import Tao

    lattice = BMAD_ROOT / case.lattice
    wrapper = out_prefix.with_suffix(".bmad")
    wrapper.write_text(f"no_digested\ncall, file = {lattice}\n")
    t0 = time.perf_counter()
    tao = Tao(
        lattice_file=str(wrapper),
        so_lib=so_lib,
        noplot=True,
        nostartup=True,
        no_rad_int=True,
        quiet=True,
    )
    cmds = configure(tao, case, n)
    init_time = time.perf_counter() - t0

    times: list[float] = []
    first_end: dict[str, np.ndarray] | None = None
    repeat_max_diff = 0.0
    repeat_state_mismatch = 0
    for i in range(repeats):
        tao.cmd(f"set global random_seed = {RANDOM_SEED}")
        tao.cmd(f"set beam_init n_particle = {n}")
        t0 = time.perf_counter()
        tao.cmd("set global track_type = beam")
        times.append(time.perf_counter() - t0)
        print(f"  {case.name}: repeat {i + 1}/{repeats}: {times[-1]:.3f} s", flush=True)
        end = bunch_at(tao, case.end)
        if first_end is None:
            first_end = end
            begin = bunch_at(tao, case.start)
            twiss = {
                k: v for k, v in tao.ele_twiss(case.end).items() if isinstance(v, float)
            }
        else:
            repeat_state_mismatch = max(
                repeat_state_mismatch, int((end["state"] != first_end["state"]).sum())
            )
            for c in COORDS:
                d = np.abs(end[c] - first_end[c])
                repeat_max_diff = max(
                    repeat_max_diff, float(np.nanmax(d)) if d.size else 0.0
                )
        if i < repeats - 1:
            tao.cmd("set global track_type = single")

    assert first_end is not None
    np.savez(
        out_prefix.with_suffix(".npz"),
        **{f"begin_{k}": v for k, v in begin.items()},
        **{f"end_{k}": v for k, v in end.items()},
    )
    result = {
        "case": asdict(case),
        "n": n,
        "lattice": str(lattice),
        "commands": cmds,
        "init_time": init_time,
        "times": times,
        "twiss_end": twiss,
        "moments_begin": moments(begin),
        "moments_end": moments(end),
        "repeat_max_abs_diff": repeat_max_diff,
        "repeat_state_mismatches": repeat_state_mismatch,
    }
    out_prefix.with_suffix(".json").write_text(json.dumps(result, indent=2))


def cmd_case(args: argparse.Namespace) -> int:
    run_case(CASES[args.case], args.so_lib, args.n, args.repeats, Path(args.out_prefix))
    return 0


def select_cases(names: list[str] | None, include_large: bool = False) -> list[Case]:
    if not names:
        return [c for c in CASES.values() if include_large or not c.large]
    unknown = [n for n in names if n not in CASES]
    if unknown:
        raise SystemExit(f"unknown case(s): {', '.join(unknown)}; see `list`")
    return [CASES[n] for n in names]


def cmd_list(args: argparse.Namespace) -> int:
    print(f"Bmad root: {BMAD_ROOT}\n")
    print(f"{'case':<22} {'N':>9} {'coll':>4}  {'end':<10} description")
    for c in CASES.values():
        tag = " [large]" if c.large else ""
        print(
            f"{c.name:<22} {c.n:>9} {'yes' if c.collective else 'no':>4}  {c.end:<10} "
            f"{c.description}{tag}"
        )
        print(f"{'':<49}{c.lattice}")
    return 0


def cmd_run(args: argparse.Namespace) -> int:
    so_lib = os.path.realpath(os.path.expanduser(os.path.expandvars(args.so_lib)))
    if not os.path.exists(so_lib):
        raise SystemExit(f"library not found: {so_lib}")
    cases = select_cases(args.cases, args.include_large)
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ)
    if args.threads is not None:
        env["OMP_NUM_THREADS"] = str(args.threads)

    results: dict[str, Any] = {}
    arrays: dict[str, np.ndarray] = {}
    with tempfile.TemporaryDirectory(prefix=f".{args.label}_", dir=out) as tmp:
        for case in cases:
            n = args.n or max(round(case.n * args.scale), 2)
            prefix = Path(tmp) / case.name
            print(f"{args.label}: {case.name} (N={n})", flush=True)
            cmd = [
                sys.executable,
                str(Path(__file__).resolve()),
                "_case",
                case.name,
                "--so-lib",
                so_lib,
                "--n",
                str(n),
                "--repeats",
                str(args.repeats),
                "--out-prefix",
                str(prefix),
            ]
            t0 = time.perf_counter()
            proc = subprocess.run(
                cmd, check=False, env=env, cwd=tmp, timeout=args.timeout
            )
            wall = time.perf_counter() - t0
            if proc.returncode != 0 or not prefix.with_suffix(".json").exists():
                print(f"  {case.name}: FAILED (exit {proc.returncode})", flush=True)
                results[case.name] = {"error": f"exit code {proc.returncode}", "n": n}
                continue
            res = json.loads(prefix.with_suffix(".json").read_text())
            res["process_wall_time"] = wall
            results[case.name] = res
            with np.load(prefix.with_suffix(".npz")) as data:
                arrays.update({f"{case.name}__{k}": data[k] for k in data.files})

    np.savez(out / f"{args.label}.npz", **arrays)
    meta = {
        "label": args.label,
        "so_lib": so_lib,
        "bmad_root": str(BMAD_ROOT),
        "repeats": args.repeats,
        "omp_num_threads": env.get("OMP_NUM_THREADS", ""),
        "omp_places": env.get("OMP_PLACES", ""),
        "omp_proc_bind": env.get("OMP_PROC_BIND", ""),
        "slurm_job_id": env.get("SLURM_JOB_ID", ""),
        "host": platform.node(),
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "cases": results,
    }
    (out / f"{args.label}.json").write_text(json.dumps(meta, indent=2))
    print(f"saved -> {out / args.label}.{{json,npz}}")
    return 1 if any("error" in r for r in results.values()) else 0


@dataclass
class Tolerances:
    """
    Pass/fail thresholds for `compare`.

    Attributes
    ----------
    mode : str
        "rounding" (particle-by-particle agreement at rounding level) or "statistical"
        (bunch moments agree within sampling noise).
    particle_rel : float
        Rounding mode: max over coordinates of rms(B - A) / rms(beam A).
    moment_rel : float
        Rounding mode: max relative moment difference.
    k : float
        Statistical mode: moments must agree within `k / sqrt(N_alive)` (relative), and
        alive counts within `k * sqrt(N)`.
    twiss_rel : float
        Max relative difference of the END Twiss parameters (both modes).
    """

    mode: str = "rounding"
    particle_rel: float = 1e-6
    moment_rel: float = 1e-6
    k: float = 5.0
    twiss_rel: float = 1e-8


def _rel(a: float, b: float) -> float:
    if a == b:
        return 0.0
    return abs(b - a) / abs(a) if a else abs(b - a)


def _moment_rel(ma: dict[str, float], mb: dict[str, float], key: str) -> float:
    """
    Relative moment difference; `mean_pz` is normalized by `max(|mean_pz|, sig_pz)`.
    """
    a, b = ma[key], mb[key]
    if key == "mean_pz":
        scale = max(abs(a), ma["sig_pz"])
        return abs(b - a) / scale if scale else abs(b - a)
    return _rel(a, b)


def _particle_ratios(
    a: Any, b: Any, prefix: str, mask: np.ndarray
) -> dict[str, tuple[float, float, float, float]]:
    """Per coordinate: (max |B-A|, rms |B-A|, beam rms of A, rms diff / beam rms)."""
    out = {}
    for c in COORDS:
        va, vb = a[f"{prefix}_{c}"][mask], b[f"{prefix}_{c}"][mask]
        if va.size == 0:
            out[c] = (0.0, 0.0, 0.0, 0.0)
            continue
        d = vb - va
        mx, rms, beam = (
            float(np.max(np.abs(d))),
            float(np.sqrt(np.mean(d**2))),
            float(va.std()),
        )
        ratio = rms / beam if beam else (0.0 if rms == 0 else float("inf"))
        out[c] = (mx, rms, beam, ratio)
    return out


def compare_case(
    name: str, ra: dict[str, Any], rb: dict[str, Any], a: Any, b: Any, tol: Tolerances
) -> tuple[bool, list[str]]:
    """
    Compare one case between runs A and B.

    Returns
    -------
    passed : bool
        Whether the case meets `tol`.
    lines : list of str
        Human-readable report.
    """
    lines: list[str] = []
    failures: list[str] = []
    if ra["n"] != rb["n"]:
        return False, [f"  N differs: {ra['n']} vs {rb['n']}"]
    if ra["commands"] != rb["commands"]:
        lines.append("  WARNING: Tao setup commands differ")

    tw_a, tw_b = ra["twiss_end"], rb["twiss_end"]
    tw_rel = [
        (_rel(tw_a[k], tw_b[k]), k) for k in tw_a if k in tw_b and np.isfinite(tw_a[k])
    ]
    tw_max, tw_key = max(tw_rel) if tw_rel else (0.0, "-")
    lines.append(
        f"  Twiss at {ra['case']['end']}: max rel diff {tw_max:.2e} ({tw_key})"
    )
    for k in TWISS_SHOWN:
        if k in tw_a and k in tw_b and _rel(tw_a[k], tw_b[k]) > tol.twiss_rel:
            lines.append(f"    {k:<8} {tw_a[k]: .12e} {tw_b[k]: .12e}")
    if tw_max > tol.twiss_rel:
        failures.append(f"Twiss rel diff {tw_max:.2e} > {tol.twiss_rel:.0e}")

    pa, pb = f"{name}__begin", f"{name}__end"
    same_start = all(
        np.array_equal(a[f"{pa}_{c}"], b[f"{pa}_{c}"]) for c in (*COORDS, "state")
    )
    lines.append(f"  initial distribution identical: {same_start}")
    if not same_start:
        all_mask = np.ones_like(a[f"{pa}_state"], dtype=bool)
        worst = max(r[3] for r in _particle_ratios(a, b, pa, all_mask).values())
        lines.append(f"    max rms diff / beam rms at start: {worst:.2e}")
        if tol.mode == "rounding" and worst > tol.particle_rel:
            failures.append("initial distributions differ")

    sa, sb = a[f"{pb}_state"], b[f"{pb}_state"]
    alive_a, alive_b = sa == 1, sb == 1
    both = alive_a & alive_b
    n_state = int((sa != sb).sum())
    lines.append(
        f"  alive: A {alive_a.sum()}  B {alive_b.sum()}  both {both.sum()}  "
        f"state mismatches {n_state}"
    )
    ratios = _particle_ratios(a, b, pb, both)
    lines.append(
        f"    {'coord':<6} {'max |B-A|':>12} {'rms |B-A|':>12} {'beam rms (A)':>13} "
        f"{'rms diff/beam rms':>18}"
    )
    for c, (mx, rms, beam, ratio) in ratios.items():
        lines.append(f"    {c:<6} {mx:12.3e} {rms:12.3e} {beam:13.3e} {ratio:18.3e}")
    worst_particle = max(r[3] for r in ratios.values())

    ma, mb = ra["moments_end"], rb["moments_end"]
    n_alive = max(ma["alive"], 1)
    stat_tol = tol.k / np.sqrt(n_alive)
    moment_tol = tol.moment_rel if tol.mode == "rounding" else stat_tol
    lines.append(f"  moments at {ra['case']['end']} (tolerance {moment_tol:.1e}):")
    for k in MOMENTS:
        r = _moment_rel(ma, mb, k)
        flag = "" if r <= moment_tol or not np.isfinite(ma[k]) else "  <-- FAIL"
        lines.append(f"    {k:<8} {ma[k]: .10e} {mb[k]: .10e}  rel diff {r:.2e}{flag}")
        if flag:
            failures.append(f"{k} rel diff {r:.2e}")

    if tol.mode == "rounding":
        if n_state:
            failures.append(f"{n_state} state mismatches")
        if worst_particle > tol.particle_rel:
            failures.append(f"particle rms diff/beam rms {worst_particle:.2e}")
    else:
        if abs(int(alive_a.sum()) - int(alive_b.sum())) > tol.k * np.sqrt(ra["n"]):
            failures.append("alive counts differ beyond k*sqrt(N)")

    for label, r in (("A", ra), ("B", rb)):
        if r.get("repeat_max_abs_diff", 0.0) or r.get("repeat_state_mismatches", 0):
            lines.append(
                f"  NOTE: {label} not reproducible across repeats "
                f"(max |diff| {r['repeat_max_abs_diff']:.2e}, "
                f"state mismatches {r['repeat_state_mismatches']})"
            )
    lines.extend(f"  FAIL: {f}" for f in failures)
    return not failures, lines


def cmd_compare(args: argparse.Namespace) -> int:
    root = Path(args.dir)
    meta_a = json.loads((root / f"{args.a}.json").read_text())
    meta_b = json.loads((root / f"{args.b}.json").read_text())
    tol = Tolerances(
        mode=args.mode,
        particle_rel=args.particle_rel,
        moment_rel=args.moment_rel,
        k=args.k,
        twiss_rel=args.twiss_rel,
    )
    print(
        f"A = {args.a}: {meta_a['so_lib']} (threads {meta_a['omp_num_threads'] or '-'})"
    )
    print(
        f"B = {args.b}: {meta_b['so_lib']} (threads {meta_b['omp_num_threads'] or '-'})"
    )
    print(f"tolerances: {asdict(tol)}")

    cases = [c for c in meta_a["cases"] if c in meta_b["cases"]]
    missing = sorted(set(meta_a["cases"]) ^ set(meta_b["cases"]))
    if args.cases:
        cases = [c for c in cases if c in args.cases]

    verdicts: dict[str, str] = {}
    reports: dict[str, list[str]] = {}
    with np.load(root / f"{args.a}.npz") as a, np.load(root / f"{args.b}.npz") as b:
        for name in cases:
            ra, rb = meta_a["cases"][name], meta_b["cases"][name]
            if "error" in ra or "error" in rb:
                verdicts[name] = "ERROR"
                reports[name] = [
                    f"  A: {ra.get('error', 'ok')}  B: {rb.get('error', 'ok')}"
                ]
                continue
            passed, reports[name] = compare_case(name, ra, rb, a, b, tol)
            verdicts[name] = "PASS" if passed else "FAIL"

    print("\n== Speed (best of repeats, tracking only)")
    print(f"  {'case':<22} {'N':>9} {'A [s]':>10} {'B [s]':>10} {'A/B':>7}  result")
    for name in cases:
        ra, rb = meta_a["cases"][name], meta_b["cases"][name]
        if "times" in ra and "times" in rb:
            ta, tb = min(ra["times"]), min(rb["times"])
            speed = f"{ta / tb:7.2f}" if tb else "    inf"
            print(
                f"  {name:<22} {ra['n']:>9} {ta:10.3f} {tb:10.3f} {speed}  {verdicts[name]}"
            )
        else:
            print(
                f"  {name:<22} {ra['n']:>9} {'-':>10} {'-':>10} {'-':>7}  {verdicts[name]}"
            )
    if missing:
        print(f"  not in both runs: {', '.join(missing)}")

    for name in cases:
        if args.quiet and verdicts[name] == "PASS":
            continue
        print(f"\n== {name}: {verdicts[name]}")
        print("\n".join(reports[name]))

    ok = all(v == "PASS" for v in verdicts.values()) and bool(cases)
    print(f"\nOVERALL ({tol.mode}): {'PASS' if ok else 'FAIL'}")
    return 0 if ok else 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p_list = sub.add_parser("list", help="show the cases")
    p_list.set_defaults(func=cmd_list)

    p_run = sub.add_parser(
        "run", help="track the cases with one libtao and save results"
    )
    p_run.add_argument("label")
    p_run.add_argument(
        "--so-lib", required=True, help="path to the libtao shared library"
    )
    p_run.add_argument("--out", required=True, help="results directory")
    p_run.add_argument(
        "--cases", nargs="+", help="cases to run (default: all non-large)"
    )
    p_run.add_argument(
        "--include-large", action="store_true", help="also run large-N cases"
    )
    p_run.add_argument("--n", type=int, help="override every case's particle count")
    p_run.add_argument(
        "--scale", type=float, default=1.0, help="multiply each case's default N"
    )
    p_run.add_argument("--repeats", type=int, default=1)
    p_run.add_argument(
        "--threads", type=int, help="OMP_NUM_THREADS for the Tao processes"
    )
    p_run.add_argument("--timeout", type=float, help="per-case timeout [s]")
    p_run.set_defaults(func=cmd_run)

    p_cmp = sub.add_parser("compare", help="compare two saved runs")
    p_cmp.add_argument("dir")
    p_cmp.add_argument("a", help="baseline label")
    p_cmp.add_argument("b", help="candidate label")
    p_cmp.add_argument("--cases", nargs="+")
    p_cmp.add_argument(
        "--mode", choices=("rounding", "statistical"), default="rounding"
    )
    p_cmp.add_argument("--particle-rel", type=float, default=1e-6)
    p_cmp.add_argument("--moment-rel", type=float, default=1e-6)
    p_cmp.add_argument("--k", type=float, default=5.0, help="statistical mode: sigmas")
    p_cmp.add_argument("--twiss-rel", type=float, default=1e-8)
    p_cmp.add_argument(
        "-q", "--quiet", action="store_true", help="only detail non-passing cases"
    )
    p_cmp.set_defaults(func=cmd_compare)

    p_case = sub.add_parser("_case", help=argparse.SUPPRESS)
    p_case.add_argument("case", choices=CASES)
    p_case.add_argument("--so-lib", required=True)
    p_case.add_argument("--n", type=int, required=True)
    p_case.add_argument("--repeats", type=int, default=1)
    p_case.add_argument("--out-prefix", required=True)
    p_case.set_defaults(func=cmd_case)

    args = parser.parse_args(argv)
    try:
        return args.func(args)
    except Exception:
        if args.command != "_case":
            raise
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
