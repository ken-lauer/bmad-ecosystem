# Common settings for the WebAssembly build scripts. Source this file.
#
# BMAD_WASM_TOOLCHAIN: Directory holding everything that is built outside of the Bmad tree:
#   llvm-project/  Patched LLVM sources (flang with WebAssembly support).
#   build/         LLVM build tree. The Fortran compiler is build/bin/flang.
#   wasm/lib/      Fortran runtime library compiled to WebAssembly.
#   ext/           Clone of bmad-external-packages (sources of the libraries Bmad needs).
#   deps-build/    Build trees of those libraries.
#   prefix/        Where those libraries are installed (include/, lib/).

export BMAD_WASM_TOOLCHAIN=${BMAD_WASM_TOOLCHAIN:-$HOME/.cache/bmad-wasm-toolchain}
TC=$BMAD_WASM_TOOLCHAIN
FLANG=$TC/build/bin/flang
RTLIB=$TC/wasm/lib/libflang_rt.runtime.a
EXT=$TC/ext
DEPS_BUILD=$TC/deps-build
PREFIX=$TC/prefix
JOBS=${JOBS:-$(getconf _NPROCESSORS_ONLN)}
FFLAGS_WASM="--target=wasm32-unknown-emscripten -O2"

# Compiler settings of the environment (EG an activated conda environment) are for native builds.
unset CC CXX FC F77 F90 AR LD RANLIB NM STRIP CFLAGS CXXFLAGS CPPFLAGS FFLAGS FCFLAGS LDFLAGS
unset SDKROOT MACOSX_DEPLOYMENT_TARGET CMAKE_ARGS CMAKE_PREFIX_PATH CONDA_BUILD_SYSROOT

for tool in emcc emar emcmake emconfigure cmake ninja node; do
  if ! command -v $tool >/dev/null; then
    echo "ERROR: $tool not found. Install emscripten, cmake, ninja and node." >&2
    return 1 2>/dev/null || exit 1
  fi
done
