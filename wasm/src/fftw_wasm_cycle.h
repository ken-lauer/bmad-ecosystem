/*
 * Tick counter for FFTW in WebAssembly. Included in every FFTW source file (see build_deps.sh).
 *
 * FFTW picks the fastest of many algorithms by timing them (FFTW_MEASURE, used for the space
 * charge FFTs) with a CPU cycle counter (kernel/cycle.h). It knows none for WebAssembly and
 * falls back to a clock with which each timing takes 40 ms instead of microseconds, so that
 * making one plan takes minutes. Use the high resolution clock of the browser instead.
 */

#ifndef FFTW_WASM_CYCLE_H
#define FFTW_WASM_CYCLE_H

#include <emscripten.h>

typedef double ticks;

/* Nanoseconds. */
static inline ticks getticks(void) {return emscripten_get_now() * 1.0e6;}
static inline double elapsed(ticks t1, ticks t0) {return t1 - t0;}

#define HAVE_TICK_COUNTER

#endif
