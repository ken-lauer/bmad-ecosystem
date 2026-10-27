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
  double dct_ave;         /* resident step: mean of z/beta over the live particles (z is shifted by dct_ave*beta) */
  double track_step;      /* resident step: csr%actual_track_step */
  double mass;            /* resident step: particle mass [eV] */
  int32_t n;              /* number of particles in the arrays (staged step) */
  int32_t pad[3];
} bmad_dev_sc_par;

/* One tracking slice for the resident bunch (the fast_slice_struct of bunch_soa_mod). All members are
   4 bytes; mirrored by the SlicePar shader struct and bmad_dev_slice_par_struct in Fortran. Array
   layouts are Fortran column-major: cm[n + 22*m], w[i + 3*k], rad_dmat[j + 6*k + 36*ie],
   ap_type[k + 4*ie], ap_lim[8*(k + 4*ie) + {x1, x2, y1, y2, ex_w2, ex_c, ey_w2, ey_c}]. */
typedef struct {
  int32_t kind, n_step, ix_mag_max, offset_on, do_tilt, is_misaligned;
  int32_t n_ap0, n_ap1;
  int32_t rad_damp0, rad_damp1, rad_fluct0, rad_fluct1, rad_damp_vec;
  int32_t ele_tag;
  uint32_t rng_seed, rng_ctr;
  float length, s_start, s_end, p0c_ele, e_tot_ele, mass, max_ap;
  float charge_dir, b1, r_step, step_len, ab_f;
  float an[22], bn[22], cm[484];
  float tilt_tot, cos_t, sin_t, cos_mt, sin_mt;
  float x_off, y_off, z_off, zc_set, l_half, ds_center_unset, s_target_set, s_target_unset;
  float w_inv[9], w_mat[9];
  int32_t ap_type[8];
  float ap_lim[64];
  float g, dg, g_tot, angle, beta_ref, sinc_a, cos_a, sin_a, cosc_a, sincc_a;
  float rad_scale;
  float rad_ref[12], rad_dmat[72], rad_dvec[12], rad_smat[72];
} bmad_dev_slice_par;

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

/* Parameters of the CSR kick on the resident bunch (zc1 = z_center of bin 1). */
typedef struct {
  double z_min, dz_slice, dz_particle, scale[4], zc1;
  int32_t n_bin, pbs, pass, pad;
} bmad_dev_csr_par;
/* One CSR step of csr_bin_view on the resident bunch, in one submission: the statistics of
   bmad_dev_bunch_stats (dct = 0) in out_stats, the bin layout laid out on the device as csr_bin_view
   does it in out_layout = {z_min, dz_slice, dz_particle, zc1}, and the bin sums: out1[4*n_bin] =
   overlap, charge, x*charge, y*charge per bin; out2[2*n_bin] = |x - x0|*charge, |y - y0|*charge per bin
   with the centroids x0, y0 formed on the device. The sums are deterministic (fixed point). */
int bmad_dev_csr_step (double mass, int n_bin, int pbs, int n_bin_eff, double out_stats[9], double out_layout[4],
                       double *out1, double *out2, char *reason, int reason_len);
/* All statistics of the live resident particles in one pass:
   out = {n_live, sum z/beta, sum |q|, min x, min y, min zs, max x, max y, max zs}, zs = z - dct*beta. */
int bmad_dev_bunch_stats (double mass, double dct, double out[9], char *reason, int reason_len);
/* CSR kick: pz += interpolation of kick[n_bin] at z (zc1 = z_center of bin 1). */
int bmad_dev_csr_kick (const bmad_dev_csr_par *par, const float *kick, char *reason, int reason_len);

/* Resident bunch: upload the particles once, track slices and apply space charge on the device,
   download at the end. state/loc/lost_tag are int32; loc uses Bmad's upstream_end$/inside$/downstream_end$
   codes and lost_tag the slice's ele_tag at the moment the particle was lost. */
int bmad_dev_bunch_upload (int n, const float *x, const float *px, const float *y, const float *py,
                           const float *z, const float *pz, const int32_t *state, const float *q,
                           const float *p0c, char *reason, int reason_len);
int bmad_dev_bunch_download (int n, float *x, float *px, float *y, float *py, float *z, float *pz,
                             int32_t *state, int32_t *loc, int32_t *lost_tag, char *reason, int reason_len);
int bmad_dev_track_slice (const bmad_dev_slice_par *par, char *reason, int reason_len);
/* Sums over the live resident particles: out = {n_live, sum z/beta, sum |q|}. */
int bmad_dev_bunch_sums (double mass, double out[3], char *reason, int reason_len);
/* Bounds of the live resident particles: out = {min x, min y, min zs, max x, max y, max zs}, zs = z - dct*beta. */
int bmad_dev_bunch_bounds (double mass, double dct, double out[6], char *reason, int reason_len);
/* The space charge step on the resident bunch (par->dct_ave, track_step, mass used; par->n ignored). */
int bmad_dev_sc_step_resident (const bmad_dev_sc_par *par, char *reason, int reason_len);

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
typedef int    (*bmad_backend_bunch_upload_fn) (int, const float *, const float *, const float *, const float *,
                                                const float *, const float *, const int32_t *, const float *,
                                                const float *, char *, int);
typedef int    (*bmad_backend_bunch_download_fn) (int, float *, float *, float *, float *, float *, float *,
                                                  int32_t *, int32_t *, int32_t *, char *, int);
typedef int    (*bmad_backend_track_slice_fn) (const bmad_dev_slice_par *, char *, int);
typedef int    (*bmad_backend_bunch_sums_fn) (double, double *, char *, int);
typedef int    (*bmad_backend_bunch_bounds_fn) (double, double, double *, char *, int);
typedef int    (*bmad_backend_sc_step_resident_fn) (const bmad_dev_sc_par *, char *, int);
typedef int    (*bmad_backend_csr_kick_fn) (const bmad_dev_csr_par *, const float *, char *, int);
typedef int    (*bmad_backend_csr_step_fn) (double, int, int, int, double *, double *, double *, double *, char *, int);
typedef int    (*bmad_backend_bunch_stats_fn) (double, double, double *, char *, int);
typedef double (*bmad_backend_seconds_fn) (void);
typedef void   (*bmad_backend_timing_fn) (double *);
typedef int    (*bmad_backend_fault_fn) (void);

#ifdef __cplusplus
}
#endif

#endif
