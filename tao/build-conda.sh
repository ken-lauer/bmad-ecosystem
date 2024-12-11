export FPM_FFLAGS="$FFLAGS -I$CONDA_PREFIX/include -I$CONDA_PREFIX/include/xraylib -I$CONDA_PREFIX/include/fgsl -I$CONDA_PREFIX/lib/fortran/modules/plplot -cpp -fno-range-check -fdollar-ok -fbacktrace -Bstatic -ffree-line-length-none --verbose -fimplicit-none"
export FPM_CFLAGS="$CFLAGS -Df2cFortran -O0 -D_POSIX -D_REENTRANT -Wall -fPIC -Wno-trigraphs -Wno-unused -std=gnu99 -Wno-unknown-warning-option"
# -DCESR_PGPLOT"
fpm build
