# fast_track_bench

Benchmark and validation suite for fast large-N bunch tracking work in Bmad.

Every change that speeds up bunch tracking (CSR, space charge, lcavity / Runge-Kutta
tracking, OpenMP) is checked here against a **baseline build**: the same cases are
tracked with two `libtao` shared libraries, and `compare` reports the speedup together
with a particle-by-particle and bunch-moment correctness report and an overall PASS/FAIL.

Only lattices shipped with Bmad are used (`bmad-doc/tao_examples`,
`regression_tests`). Never add proprietary or facility lattices to this suite. The
files under `lattices/` only wrap shipped lattices (e.g. selecting one branch).

## Requirements

- Python 3.10+ with `numpy` and `pytao`.
- Two Bmad builds, each providing `production/lib/libtao.dylib` (macOS) or
  `libtao.so` (Linux).

Always pass `--so-lib` explicitly. Without it pytao may pick up a different (e.g. debug)
library through `ACC_ROOT_DIR`. Each case runs in its own Python subprocess, so a library
is only ever loaded once per process and Bmad's global state is fresh for each case.

## Cases

```
python fast_track_bench.py list
```

| case | lattice | covers |
| --- | --- | --- |
| `csr_chicane` | `tao_examples/csr_beam_tracking` | 1D CSR through combined-function bends (settings from `CSR.tao`) |
| `csr_bend_regression` | `csr_and_space_charge_test` (branch 0, via `lattices/csr_bend.bmad`) | 1D CSR in a single bend |
| `space_charge` | `tao_examples/space_charge/lat.bmad` | 3D FFT space charge, 1 m pipe (IPAC2018 benchmark setup) |
| `space_charge_quad` | `tao_examples/space_charge/lat2.bmad` | 3D FFT space charge with a superimposed quad |
| `sc_drift_regression` | `space_charge_test/grid.bmad` | 3D FFT space charge, 4 m drift, absolute-time tracking |
| `erl` | `tao_examples/erl` | multipass lcavities (accelerate/decelerate), Taylor arc, 3D space charge |
| `erl_nocoll` | `tao_examples/erl` | same, collective effects off |
| `cbeta_cell` | `tao_examples/cbeta_cell/cell1.lat` | FFAG cell: offset combined-function quads, soft-edge fringes, patches |
| `cbeta_cell_rk` | `tao_examples/cbeta_cell/cell1.lat` | same, Runge-Kutta tracking in the quads |
| `fodo` | `tao_examples/fodo` | plain single-particle tracking and optics |
| `cesr` | `tao_examples/cesr` | one pass through the CESR ring (wigglers, solenoid) |
| `erl_1m` | `tao_examples/erl` | **large**: N = 1e6, mesh 64x64x128, `ds_track_step` = 0.005 |
| `space_charge_1m` | `tao_examples/space_charge` | **large**: N = 1e6, mesh 64x64x128, `ds_track_step` = 0.005 |

Large cases are skipped unless named with `--cases` (or `--include-large`); they are
meant for a cluster node.

Each case is a `Case` entry in `fast_track_bench.py`: the lattice file, extra Tao setup
commands (per-element `csr_method` / `space_charge_method`), `beam_init` and
`space_charge_com` settings, whether `bmad_com%csr_and_space_charge_on` is set, the
default N, and the element where results are recorded. Lattices are loaded with
`-lat ... -nostartup -noplot`; the example's own `tao.init`/startup files are not used,
so all beam settings are explicit in the case definition. Each lattice is loaded through
a temporary `no_digested` wrapper, so no `.digested` files are written into the Bmad tree
(a digested file written by one build must not be read by the other). Radiation damping and
fluctuations are always off.

## What a run records

For each case, `run` tracks the bunch `--repeats` times. Before every repeat the random
state is reset (`set global random_seed`) and the beam is re-initialized with
`beam_init%random_engine = quasi`, so every repeat and every build starts from the same
distribution. Only the switch to `track_type = beam` is timed.

- `DIR/LABEL.json`: library path, host, OpenMP environment, and per case: the Tao
  commands issued, init time, per-repeat tracking times, Twiss at the end element, bunch
  moments (alive count, `emit_x`, `emit_y`, `sig_z`, `sig_pz`, `mean_pz`) at the start
  and end element, and the max particle difference between repeats (a determinism check).
- `DIR/LABEL.npz`: `x, px, y, py, z, pz, state` of every particle at the start
  (`<case>__begin_*`) and end (`<case>__end_*`) element.

At N = 1e6 the NPZ is ~110 MB per large case.

## A/B comparison

```bash
BASE=~/Repos/bmad/production/lib/libtao.dylib
FAST=~/Repos/bmad/.claude/worktrees/fast-bunch-tracking/production/lib/libtao.dylib

python fast_track_bench.py run base --so-lib $BASE --out results --repeats 3 --threads 1
python fast_track_bench.py run fast --so-lib $FAST --out results --repeats 3 --threads 1
python fast_track_bench.py compare results base fast
```

Useful options:

- `run --cases csr_chicane erl` to select cases; `--n N` overrides every case's N;
  `--scale 10` multiplies each case's default N (the defaults are small, so tracking
  times are short and noisy; scale up for meaningful timings).
- `run --threads T` sets `OMP_NUM_THREADS` for the Tao processes.
- `compare -q` details only non-passing cases. The exit status is 0 on overall PASS.

Run both labels from the same checkout of this script so that both builds track the
same lattice files (the lattices are resolved relative to this script's Bmad tree).

## Tolerance modes

`compare --mode rounding` (default) is the tier-1 check: the candidate must reproduce the
baseline to rounding level.

- per coordinate, `rms(B - A) / rms(beam A)` over particles alive in both runs
  `< --particle-rel` (1e-6);
- bunch moments relative difference `< --moment-rel` (1e-6); `mean_pz` is normalized by
  `max(|mean_pz|, sig_pz)`;
- identical alive counts and identical particle state codes;
- identical (to `--particle-rel`) initial distributions.

`compare --mode statistical` is for changes that legitimately change the particle-level
result (e.g. a different deposition scheme or summation order at large N): bunch moments
must agree within `k / sqrt(N_alive)` relative (`--k`, default 5) and alive counts within
`k * sqrt(N)`. Particle differences are still reported but not checked.

In both modes the Twiss parameters at the end element must agree to `--twiss-rel`
(1e-8).

Notes from validating the suite (same build vs. itself, `--threads 2`):

- All cases were bit-identical between runs in one smoke test; in another,
  `space_charge_quad` differed at ~1e-13 relative (OpenMP summation order). Use `--threads 1` for both builds when you want
  bit-identical baselines.
- On the closed lattices (`cbeta_cell`, `cesr`) the first repeat differs from later ones
  at ~1e-15; `compare` prints this as a NOTE, not a failure.

## Slurm

Pin one process per core and avoid hyperthreads, and use the same thread count for both
builds:

```bash
#!/bin/bash
#SBATCH --job-name=fast_track_bench
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --hint=nomultithread
#SBATCH --exclusive
#SBATCH --time=04:00:00

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
export OMP_PROC_BIND=close

BENCH=$BMAD_WORKTREE/regression_tests/fast_track_bench/fast_track_bench.py
CASES="erl_1m space_charge_1m"

srun --cpu-bind=cores python $BENCH run base --so-lib $BASE_BMAD/production/lib/libtao.so \
    --out results --cases $CASES --repeats 3
srun --cpu-bind=cores python $BENCH run fast --so-lib $BMAD_WORKTREE/production/lib/libtao.so \
    --out results --cases $CASES --repeats 3
python $BENCH compare results base fast --mode statistical
```

`run` records `OMP_NUM_THREADS`, `OMP_PLACES`, `OMP_PROC_BIND` and `SLURM_JOB_ID` in
the JSON. For thread-scaling studies, repeat `run` with `--threads 1`, `--threads 2`, ... under
different labels and compare each against the same baseline.
