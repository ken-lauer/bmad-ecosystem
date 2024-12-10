export FPM_CXX=$PWD/clang++_no_openmp.sh
export FPM_CC=$PWD/clang_no_openmp.sh
export FPM_FFLAGS="$FFLAGS -I$CONDA_PREFIX/include -I$CONDA_PREFIX/include/xraylib -I$CONDA_PREFIX/include/fgsl -cpp -fno-range-check -fdollar-ok -fbacktrace -Bstatic -ffree-line-length-none --verbose"
export FPM_CFLAGS="$CFLAGS -Df2cFortran -O0 -D_POSIX -D_REENTRANT -Wall -fPIC -Wno-trigraphs -Wno-unused -std=gnu99"

fpm build
