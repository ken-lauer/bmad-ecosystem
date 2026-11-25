# Bmad and Tao in WebAssembly

Tao compiled to WebAssembly, with a small web page to run it in a browser: lattice files are
edited and parsed, tracked and plotted entirely on the user's machine, with nothing to install.

Status: experimental. All examples of `bmad-doc/tao_examples` run and agree with a native build.

## Building

Needs Emscripten (`emcc`), cmake, ninja, node, python3 and a C++ compiler. Tested on macOS (arm64)
with Emscripten 7.0.1.

```bash
wasm/build_toolchain.sh        # Fortran compiler for WebAssembly. About an hour, 15 GB. Once.
wasm/build_deps.sh             # LAPACK, LAPACK95, GSL, FGSL, FFTW, xraylib, HDF5. Minutes. Once.
python3 wasm/gen_ninja.py      # Writes wasm/build/build.ninja
ninja -C wasm/build            # sim_utils, forest, bmad, tao -> wasm/build/tao.js, tao.wasm. ~10 min.
python3 wasm/build_web.py      # Assembles the web page in wasm/build/web
python3 -m http.server -d wasm/build/web     # Then open http://localhost:8000
```

The compiler and the libraries go to `$BMAD_WASM_TOOLCHAIN` (default `~/.cache/bmad-wasm-toolchain`).
Nothing of the regular Bmad build system (`util/`) is used.

`wasm/publish_pages.sh <remote>` builds the page and pushes it to the `gh-pages` branch of a remote,
replacing that branch, to serve it with GitHub Pages.

## How it works

- **Compiler.** LLVM flang cannot generate WebAssembly out of the box. The R project maintains a
  patched LLVM that can (https://github.com/r-wasm/llvm-project). Three more patches were needed for
  Bmad and its libraries: see `patches/README.md`. Linking is done by Emscripten. `emflang` wraps
  both as one "Fortran compiler" for CMake based packages (HDF5).
- **Build.** `gen_ninja.py` scans the Fortran sources for module dependencies and writes a Ninja file.
- **Tao interface.** The page drives Tao through `tao_c_interface_mod` (as PyTao does): commands in,
  output lines out. Tao runs in a web worker (`web/tao_worker.js`), with its files in memory.
- **Plots.** The quick_plot Cairo backend (`sim_utils/plot/cairo_interface.f90`) is used unchanged.
  It encodes drawing as a display list. `src/qp_web.c` takes the place of `qp_cairo.c` and hands the
  list to JavaScript, where `web/qp_render.js` (a port of `qp_cairo_render.c`) draws it on a canvas.
- **Shims.** `src/web_shims.c` replaces readline (tab completion still works, through Tao's own
  completion engine), the display size query, and two things flang or the FFTW build lack.

## Changes to the Bmad sources

- `ACC_NO_QUAD_PRECISION` (set for this build): `quadp = rp`, since there is no quad precision in
  WebAssembly. The absolute time of a particle (`coord_struct%t`) is then double precision.
- Three small fixes that any compiler benefits from: a missing explicit interface for `err_exit`,
  `use omp_lib` without the OpenMP sentinel, and a `size_t` argument declared as `hsize_t`.

## Testing

```bash
node wasm/test/run_tao.mjs bmad-doc/tao_examples/fodo "-init tao.init" "show lattice"
python3 wasm/test/compare_native.py --native-tao <path to native tao>
node wasm/test/browser_check.mjs "http://localhost:8000/?example=cesr&start&cmd=show+universe" shot.png
```

The page takes `?example=<name>&start&cmd=<command>&cmd=...` to open in a given state.

## Limitations

- One thread (no OpenMP, no MPI) and 32 bit memory (4 GB at most).
- No quad precision (see above).
- Plot files (`write ps`, ...) cannot be made. HDF5 is built without zlib (no compressed data sets).
- Tao cannot be restarted in place: the page starts a new WebAssembly instance each time.
- Some old code calls `err_exit` without an explicit interface. In WebAssembly such a call traps
  instead of printing its message. Either way Tao stops.
- `help` needs the Tao documentation files, which are not bundled.
