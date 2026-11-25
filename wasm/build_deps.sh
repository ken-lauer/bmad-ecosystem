#!/bin/bash
#
# Build the external libraries Bmad needs (LAPACK, LAPACK95, GSL, FGSL, FFTW, xraylib, HDF5)
# as WebAssembly static libraries. Needs the compiler made by build_toolchain.sh.
#
# Usage: wasm/build_deps.sh [library ...]     Default is to build all of them.

set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/env.sh"

mkdir -p "$DEPS_BUILD" "$PREFIX/include" "$PREFIX/lib"

if [ ! -d "$EXT" ]; then
  git clone --depth=1 https://github.com/bmad-sim/bmad-external-packages "$EXT"
fi

# Compile every listed Fortran file (in the order given) into the archive $1.
fortran_archive() {
  local archive=$1; shift
  local objs=()
  for src in "$@"; do
    local obj="$(basename "${src%.*}").o"
    objs+=("$obj")
    echo "$FLANG $FFLAGS_WASM ${EXTRA_FFLAGS:-} -c $src -o $obj"
  done > compile_commands.txt
  if [ "${SERIAL:-0}" = 1 ]; then
    bash -e compile_commands.txt
  else
    xargs -P "$JOBS" -I{} bash -c '{}' < compile_commands.txt
  fi
  rm -f "$archive"
  emar rcs "$archive" "${objs[@]}"
}

build_gsl() {
  mkdir -p "$DEPS_BUILD/gsl" && cd "$DEPS_BUILD/gsl"
  emconfigure "$EXT/gsl/configure" --prefix="$PREFIX" --host=wasm32-unknown-none \
    --disable-shared --enable-static CFLAGS=-O2
  emmake make -j"$JOBS"
  emmake make install
}

# src/fftw_wasm_cycle.h gives FFTW the timer it needs to plan transforms quickly.
build_fftw() {
  local here
  here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  mkdir -p "$DEPS_BUILD/fftw" && cd "$DEPS_BUILD/fftw"
  emconfigure "$EXT/fftw/configure" --prefix="$PREFIX" --host=wasm32-unknown-none \
    --disable-shared --enable-static --disable-fortran --disable-doc \
    CFLAGS="-O2 -include $here/src/fftw_wasm_cycle.h"
  # Only the library: the benchmark programs do not compile with the timer header.
  for dir in kernel simd-support dft rdft reodft api; do
    emmake make -C "$dir" -j"$JOBS"
  done
  emmake make libfftw3.la
  emmake make install-libLTLIBRARIES
  emmake make -C api install
}

# Reference BLAS and LAPACK: double precision real and complex routines only.
build_lapack() {
  mkdir -p "$DEPS_BUILD/blas" && cd "$DEPS_BUILD/blas"
  fortran_archive "$PREFIX/lib/libblas.a" "$EXT"/lapack/BLAS/SRC/{d,z,id,iz,dz,l,x}*.f "$EXT"/lapack/BLAS/SRC/{d,z}*.f90

  mkdir -p "$DEPS_BUILD/lapack" && cd "$DEPS_BUILD/lapack"
  local src=()
  for f in "$EXT"/lapack/SRC/*.f "$EXT"/lapack/SRC/*.f90 "$EXT"/lapack/SRC/*.F; do
    case "$(basename "$f")" in
      la_constants.f90|la_xisnan.F90) ;;                        # Modules: compiled first below.
      s*|c*|ds*|zc*|iparam2stage*|*_wrapper*|ilaenv2stage*) ;;  # Single precision, 2-stage (OpenMP)
      *) src+=("$f") ;;
    esac
  done
  src+=("$EXT"/lapack/INSTALL/dlamch.f "$EXT"/lapack/INSTALL/droundup_lwork.f)
  SERIAL=1 fortran_archive modules.a "$EXT"/lapack/SRC/la_constants.f90 "$EXT"/lapack/SRC/la_xisnan.F90
  fortran_archive "$PREFIX/lib/liblapack.a" "${src[@]}"
  emar rcs "$PREFIX/lib/liblapack.a" la_constants.o la_xisnan.o
}

build_lapack95() {
  mkdir -p "$DEPS_BUILD/lapack95" && cd "$DEPS_BUILD/lapack95"
  local code="$EXT/lapack95/code"
  SERIAL=1 fortran_archive modules.a "$code"/la_auxmod.f90 "$code"/f77_lapack_single_double_complex_dcomplex.f90 \
    "$code"/f95_lapack_single_double_complex_dcomplex.f90
  local src=()
  for f in "$code"/*.f90; do
    case "$(basename "$f")" in
      la_auxmod.f90|f77_lapack_*|f95_lapack_*) ;;
      *) src+=("$f") ;;
    esac
  done
  fortran_archive "$PREFIX/lib/liblapack95.a" "${src[@]}"
  emar rcs "$PREFIX/lib/liblapack95.a" la_auxmod.o f77_lapack_single_double_complex_dcomplex.o \
    f95_lapack_single_double_complex_dcomplex.o
  cp ./*.mod "$PREFIX/include/"
}

# FGSL has no pre-made configure script: compile its two source files directly.
build_fgsl() {
  mkdir -p "$DEPS_BUILD/fgsl" && cd "$DEPS_BUILD/fgsl"
  local gsl_version fgsl_version
  gsl_version=$(awk '{print $3}' "$EXT/gsl/VERSION")
  fgsl_version=$(awk '{print $3}' "$EXT/fgsl/VERSION")
  cat > config.h <<EOF
#define GSL_VERSION '$gsl_version'
#define PACKAGE_VERSION "$fgsl_version"
#define SIZEOF_SIZE_T 4
EOF
  $FLANG $FFLAGS_WASM -cpp -I. -I"$EXT/fgsl" -c "$EXT/fgsl/fgsl.F90" -o fgsl.o
  emcc -O2 -I. -I"$PREFIX/include" -c "$EXT/fgsl/fgsl_utils.c" -o fgsl_utils.o
  rm -f "$PREFIX/lib/libfgsl.a"
  emar rcs "$PREFIX/lib/libfgsl.a" fgsl.o fgsl_utils.o
  cp fgsl.mod "$PREFIX/include/"
}

# xraylib tabulates its data files into a C source with a program that has to run on this machine.
build_xraylib() {
  mkdir -p "$DEPS_BUILD/xraylib" && cd "$DEPS_BUILD/xraylib"
  local src="$EXT/xraylib/src" inc="-I. -I$EXT/xraylib/include -I$EXT/xraylib/src"
  echo '#define XRL_EXTERN extern' > config.h

  local gen_src=(xrayvars xrayglob xrayfiles fluor_yield coskron crystal_diffraction scattering fi fii
    splint atomicweight xraylib-error xrf_cross_sections_aux-private radrate auger_trans kissel_pe
    cross_sections xraylib-aux xrf_cross_sections_aux pr_data)
  /usr/bin/cc -O1 -w $inc $(printf "$src/%s.c " "${gen_src[@]}") -lm -o prdata
  ./prdata "$EXT/xraylib" xrayglob_inline.c

  local lib_src=(xrayvars cross_sections scattering atomicweight edges fluor_lines fluor_yield jump coskron
    radrate cs_line polarized splint cs_barns fi fii kissel_pe xrayfiles_inline xraylib-aux xraylib-parser
    cs_cp refractive_indices comptonprofiles atomiclevelwidth auger_trans xrf_cross_sections_aux
    crystal_diffraction xraylib-nist-compounds densities xraylib-radionuclides xraylib-error)
  local objs=()
  for name in "${lib_src[@]}"; do
    emcc -O2 -w $inc -c "$src/$name.c" -o "$name.o"
    objs+=("$name.o")
  done
  emcc -O2 -w $inc -I"$src" -c xrayglob_inline.c -o xrayglob_inline.o
  rm -f "$PREFIX/lib/libxrl.a" "$PREFIX/lib/libxrlf03.a"
  emar rcs "$PREFIX/lib/libxrl.a" "${objs[@]}" xrayglob_inline.o

  $FLANG $FFLAGS_WASM -cpp -I"$EXT/xraylib/fortran" -c "$EXT/xraylib/fortran/xraylib_wrap.F90" -o xraylib_wrap.o
  emar rcs "$PREFIX/lib/libxrlf03.a" xraylib_wrap.o
  cp xraylib.mod "$PREFIX/include/"
}

# The HDF5 build runs helper programs (through node) that generate sources, so executables are
# linked with direct access to the file system. Programs linked by the C compiler that contain
# Fortran code need the Fortran runtime library. FE_INVALID: WebAssembly has no floating point
# exception flags, so Emscripten's fenv.h does not define it.
build_hdf5() {
  local here configure
  here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  configure=(emcmake cmake -G Ninja -S "$EXT/hdf5" -B "$DEPS_BUILD/hdf5" -Wno-dev
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX="$PREFIX"
    -DCMAKE_Fortran_COMPILER="$here/emflang"
    -DCMAKE_C_FLAGS="-DFE_INVALID=0"
    -DCMAKE_EXE_LINKER_FLAGS="-sNODERAWFS=1 -sALLOW_MEMORY_GROWTH=1 $RTLIB"
    -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DBUILD_TESTING=OFF
    -DHDF5_BUILD_HL_LIB=ON -DHDF5_BUILD_FORTRAN=ON -DHDF5_BUILD_CPP_LIB=OFF
    -DHDF5_BUILD_TOOLS=OFF -DHDF5_BUILD_UTILS=OFF -DHDF5_BUILD_EXAMPLES=OFF
    -DHDF5_BUILD_GENERATORS=OFF
    -DHDF5_ENABLE_Z_LIB_SUPPORT=OFF -DHDF5_ENABLE_SZIP_SUPPORT=OFF)
  # The first configure stops at the Fortran name mangling detection, which cannot work for
  # WebAssembly (see cmake/seed_fortran_c_interface.cmake). Supply the answer and configure again.
  if [ ! -f "$DEPS_BUILD/hdf5/CMakeFiles/FortranCInterface/Output.cmake" ]; then
    "${configure[@]}" || true
    cmake -DBUILD_DIR="$DEPS_BUILD/hdf5" -P "$here/cmake/seed_fortran_c_interface.cmake"
    rm -rf "$DEPS_BUILD/hdf5/CMakeFiles/FortranCInterface/VerifyC"
    configure+=(-UFortranCInterface_VERIFIED_C)
  fi
  "${configure[@]}"
  cmake --build "$DEPS_BUILD/hdf5"
  cmake --install "$DEPS_BUILD/hdf5"
  cp "$PREFIX"/mod/static/*.mod "$PREFIX/include/" 2>/dev/null || true
}

if [ $# -eq 0 ]; then
  set -- gsl fftw lapack lapack95 fgsl xraylib hdf5
fi

for lib in "$@"; do
  echo "==== Building $lib"
  (build_"$lib")
done
