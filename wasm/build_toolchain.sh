#!/bin/bash
#
# Build a Fortran compiler that targets WebAssembly, and its runtime library.
#
# LLVM's flang cannot yet generate WebAssembly code out of the box. The R project (webR)
# maintains a patched LLVM that can: https://github.com/r-wasm/llvm-project (branch "wasm").
# This script builds flang from it (natively, takes about an hour and 15 GB of disk) and
# then compiles the Fortran runtime library to WebAssembly with Emscripten.
#
# Needs: a C++ compiler, cmake, ninja and Emscripten (emcc) on the PATH.
# LLVM_CMAKE_ARGS: extra cmake options for the LLVM build (EG to limit the memory used by linking).

set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$HERE/env.sh"

mkdir -p "$TC" && cd "$TC"

if [ ! -d llvm-project ]; then
  git clone --single-branch -b wasm --depth=1 https://github.com/r-wasm/llvm-project
fi

# Patches on top of the r-wasm sources (see wasm/patches/).
for patch in "$HERE"/patches/*.patch; do
  if git -C llvm-project apply --check "$patch" 2>/dev/null; then
    git -C llvm-project apply "$patch"
  fi
done

if [ ! -x "$FLANG" ]; then
  cmake -G Ninja -S llvm-project/llvm -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DEFAULT_TARGET_TRIPLE="wasm32-unknown-emscripten" \
    -DLLVM_TARGETS_TO_BUILD="WebAssembly" \
    -DLLVM_ENABLE_PROJECTS="clang;flang;mlir;lld" \
    -DFLANG_INCLUDE_TESTS=OFF -DFLANG_ENABLE_FLANG_RT=OFF \
    -DLLVM_INCLUDE_TESTS=OFF -DLLVM_INCLUDE_BENCHMARKS=OFF -DLLVM_INCLUDE_EXAMPLES=OFF \
    -DCLANG_INCLUDE_TESTS=OFF \
    -DLLVM_ENABLE_ZSTD=OFF -DLLVM_ENABLE_ZLIB=OFF -DLLVM_ENABLE_LIBXML2=OFF \
    ${LLVM_CMAKE_ARGS:-}
  TERM=dumb cmake --build build --target flang lld
fi

if [ ! -f "$RTLIB" ]; then
  emcmake cmake -G Ninja -S llvm-project/runtimes -B build-rt \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_BINARY_DIR="$TC/build" \
    -DLLVM_ENABLE_RUNTIMES=flang-rt \
    -DLLVM_DEFAULT_TARGET_TRIPLE=wasm32-unknown-emscripten \
    -DCMAKE_Fortran_COMPILER="$FLANG" \
    -DCMAKE_Fortran_COMPILER_WORKS=yes \
    -DFLANG_RT_INCLUDE_TESTS=OFF \
    -DFLANG_RT_FORTRAN_MODULES=ON
  TERM=dumb cmake --build build-rt
  mkdir -p wasm/lib
  cp build-rt/lib/clang/*/lib/wasm32-unknown-emscripten/libflang_rt.runtime.a "$RTLIB"
  # Intrinsic modules (iso_c_binding, ieee_arithmetic, ...) go where flang looks for them.
  mkdir -p build/include/flang
  cp build-rt/lib/clang/*/finclude/flang/wasm32-unknown-emscripten/*.mod build/include/flang/
fi

echo "Fortran compiler: $FLANG"
echo "Runtime library:  $RTLIB"
