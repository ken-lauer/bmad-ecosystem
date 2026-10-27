/*
 * bmad_device.h: the device seam for GPU accelerated bunch tracking.
 *
 * Everything above this header is Fortran (bunch_device_mod) and knows nothing about Metal or CUDA.
 * Everything below it is one backend library (libbmad_metal.dylib today, libbmad_cuda.so later) that
 * exports the bmad_backend_* functions with the signatures given here. bmad_device.c, which is part
 * of libbmad, loads the backend named by the caller at run time and forwards the bmad_dev_* calls to
 * it; without a backend every call refuses with a reason.
 *
 * Conventions (from Lucifer's device layer):
 *   - Functions return 0 on success. On refusal they return nonzero and write a NUL terminated
 *     reason into reason[reason_len].
 *   - Parameters cross the seam as doubles; the backend rounds them once to its own precision.
 *   - Particle and mesh arrays cross as float32, x fastest for meshes. Uploads and downloads are
 *     explicit even on unified memory, so a backend with separate device memory fits unchanged.
 *   - bmad_dev_sc_par is mirrored by a bind(c) type in bunch_device_mod: change both together.
 */

#ifndef BMAD_DEVICE_H
#define BMAD_DEVICE_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* One 3D free-space space-charge step on a mesh of nx*ny*nz cells (padded to 2x for the FFT). */
typedef struct {
  double mesh_min[3];     /* lower corner of the mesh [m] */
  double delta[3];        /* cell size [m] */
  double gamma;           /* relativistic gamma of the bunch */
  double kick_scale;      /* factor applied to the transverse kicks (1/gamma^2) */
  double grn_scale;       /* field = grn_scale * ifft(fft(rho) * fft(green)); includes the FFT normalization */
  double q_total_abs;     /* sum of |charge| over the particles, for the fixed-point deposit scale */
  int32_t n;              /* number of particles in the arrays */
  int32_t pad[3];
} bmad_dev_sc_par;

/* Load the backend named `backend` ("metal", "cuda") if not yet loaded and ask whether a device is usable. */
int bmad_dev_available (const char *backend, char *reason, int reason_len);

/* Allocate device storage for up to n_particle_max particles and a mesh of mesh_n[3] cells (each a power of two). */
int bmad_dev_init (int n_particle_max, const int32_t mesh_n[3], char *reason, int reason_len);

void bmad_dev_close (void);

/* Upload the padded real Green functions for Ex, Ey, Ez ((2nx)*(2ny)*(2nz) floats each) and transform them. */
int bmad_dev_set_green (const float *gx, const float *gy, const float *gz, char *reason, int reason_len);

/* Deposit the n particles, solve, interpolate and kick. factor(i) = track_step / (p0c * beta) of particle i.
   px, py, pz are read and written in place. */
int bmad_dev_sc_step (const bmad_dev_sc_par *par, const float *x, const float *y, const float *z, const float *q,
                      const float *factor, float *px, float *py, float *pz, char *reason, int reason_len);

/* Debug: copy field component comp (1..3) of the last step, nx*ny*nz floats x fastest, into E. */
int bmad_dev_get_field (int comp, float *E, char *reason, int reason_len);

/* Accumulated device busy time [s] since init. */
double bmad_dev_seconds (void);

/* With BMAD_DEVICE_TIMING set in the environment: accumulated device busy time [s] per phase of the
   space charge step: t[0] deposit, t[1] forward FFT, t[2] product + backward FFT + extract (3 components),
   t[3] interpolate + kick. Zero otherwise. */
void bmad_dev_timing (double t[4]);

/* Sticky fault word set by the kernels (nonzero = a kernel saw an out-of-range index); cleared on read. */
int bmad_dev_fault (void);

/* The backend library exports these; same signatures without the backend name. */
typedef int    (*bmad_backend_available_fn) (char *, int);
typedef int    (*bmad_backend_init_fn) (int, const int32_t *, char *, int);
typedef void   (*bmad_backend_close_fn) (void);
typedef int    (*bmad_backend_set_green_fn) (const float *, const float *, const float *, char *, int);
typedef int    (*bmad_backend_sc_step_fn) (const bmad_dev_sc_par *, const float *, const float *, const float *,
                                           const float *, const float *, float *, float *, float *, char *, int);
typedef int    (*bmad_backend_get_field_fn) (int, float *, char *, int);
typedef double (*bmad_backend_seconds_fn) (void);
typedef void   (*bmad_backend_timing_fn) (double *);
typedef int    (*bmad_backend_fault_fn) (void);

#ifdef __cplusplus
}
#endif

#endif
