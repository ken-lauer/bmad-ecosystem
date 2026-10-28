//
// bmad_metal.mm: Metal backend for bmad_device.h (macOS, Apple GPUs).
//
// Built as libbmad_metal.dylib and loaded at run time by bmad_device.c. All arithmetic on the device is
// float32; parameters arrive as doubles and are rounded once here. The design follows Lucifer's device
// layer: shaders compiled from source at init with safe math, one lazily opened command buffer, sync()
// as the only committer, shared-memory buffers filled by memcpy, deterministic scatter through fixed
// point atomics (two 32-bit words with carry, since Apple GPUs have no 64-bit atomics).
//
// The 3D space-charge step reproduces open_spacecharge_mod's free-space solver: trilinear deposit on an
// nx*ny*nz mesh, zero padding to 2x in each dimension, forward FFT, product with the FFT of the
// integrated Green function of each field component (computed in double precision on the host and
// transformed here), backward FFT, extraction of the physical octant, trilinear interpolation and the
// kick of apply_fft_3d_kicks. The FFTs are radix-2 Stockham transforms of one line per threadgroup, so
// every padded dimension must be a power of two of at most 1024.
//

#import <Foundation/Foundation.h>
#import <Metal/Metal.h>

#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

#include "bmad_device.h"

extern "C" {
int    bmad_backend_available (char *reason, int reason_len);
int    bmad_backend_init (int n_particle_max, const int32_t mesh_n[3], char *reason, int reason_len);
void   bmad_backend_close (void);
int    bmad_backend_set_green (const float *gx, const float *gy, const float *gz, char *reason, int reason_len);
int    bmad_backend_sc_step (const bmad_dev_sc_par *par, const float *x, const float *y, const float *z, const float *q,
                             const float *factor, float *px, float *py, float *pz, char *reason, int reason_len);
int    bmad_backend_get_field (int comp, float *E, char *reason, int reason_len);
int    bmad_backend_bunch_upload (int n, const float *x, const float *px, const float *y, const float *py,
                                  const float *z, const float *pz, const int32_t *state, const float *q,
                                  const float *p0c, char *reason, int reason_len);
int    bmad_backend_bunch_download (int n, float *x, float *px, float *y, float *py, float *z, float *pz,
                                    int32_t *state, int32_t *loc, int32_t *lost_tag, float *p0c, char *reason, int reason_len);
int    bmad_backend_track_slice (const bmad_dev_slice_par *par, const bmad_dev_rf_step *rf, char *reason, int reason_len);
int    bmad_backend_bunch_set_tz0 (int n, const float *tz0, char *reason, int reason_len);
int    bmad_backend_bunch_sums (double mass, double out[3], char *reason, int reason_len);
int    bmad_backend_bunch_bounds (double mass, double dct, double out[6], char *reason, int reason_len);
int    bmad_backend_sc_step_resident (const bmad_dev_sc_par *par, char *reason, int reason_len);
int    bmad_backend_csr_kick (const bmad_dev_csr_par *par, const float *kick, char *reason, int reason_len);
int    bmad_backend_bunch_stats (double mass, double dct, double out[9], char *reason, int reason_len);
int    bmad_backend_moments_enqueue (double mass, double qs, int slot, char *reason, int reason_len);
int    bmad_backend_moments_read (int n_slot, double *out, char *reason, int reason_len);
int    bmad_backend_csr_step (double mass, int n_bin, int pbs, int n_bin_eff, double out_stats[9], double out_layout[4],
                              double *out1, double *out2, char *reason, int reason_len);
double bmad_backend_seconds (void);
void   bmad_backend_timing (double *t);
int    bmad_backend_fault (void);
}

//------------------------------------------------------------------------------------------------
// Shader source. The ScPar / FftPar layouts are mirrored by the host structs below.

static const char *kMSL = R"MSL(
#include <metal_stdlib>
using namespace metal;

struct ScPar {
  float xmin, ymin, zmin;
  float dxi, dyi, dzi;
  float dx, dy, dz;
  float kick_scale;
  float dscale, dsinv;
  float grn_scale;
  uint nx, ny, nz;
  uint nx2, ny2, nz2;
  uint n;
  uint pad;
  float dct, track_step, mass;
  uint pad2;
};

struct FftPar {
  uint n;        // line length (power of two, at most 1024)
  uint stride;   // element stride along the line
  uint bs1;      // line (l1, l2) starts at (l1 + l1_off)*bs1 + (l2 + l2_off)*bs2
  uint count1;   // number of l1 values; a multiple of nl
  uint bs2;
  uint nl;       // lines per threadgroup, consecutive in l1
  uint l1_off;
  uint l2_off;
  uint tfast;    // 1: thread index runs fastest along the line (contiguous lines); 0: along l1 (bs1 == 1)
  uint woff;     // offset of this length's twiddles in W
  int sign;      // -1 forward, +1 backward
  uint pad;
};

// Fixed-point accumulate of v (already scaled) into the 64-bit cell held in S[2c], S[2c+1].
inline void acc_fixed (device atomic_uint* S, uint cell, float v) {
  long q = (long) v;
  uint lo = (uint) q;
  uint hi = (uint) (q >> 32);
  uint prev = atomic_fetch_add_explicit(&S[2u*cell], lo, memory_order_relaxed);
  uint carry = (prev + lo < prev) ? 1u : 0u;
  uint add_hi = hi + carry;
  if (add_hi != 0u) atomic_fetch_add_explicit(&S[2u*cell + 1u], add_hi, memory_order_relaxed);
}

kernel void zero_u32 (device uint* S [[buffer(0)]], constant uint& n [[buffer(1)]],
                      uint gid [[thread_position_in_grid]]) {
  if (gid < n) S[gid] = 0u;
}

kernel void deposit (device atomic_uint* S [[buffer(0)]],
                     const device float* X [[buffer(1)]], const device float* Y [[buffer(2)]],
                     const device float* Z [[buffer(3)]], const device float* Q [[buffer(4)]],
                     constant ScPar& P [[buffer(5)]], device atomic_uint* fault [[buffer(6)]],
                     uint gid [[thread_position_in_grid]]) {
  if (gid >= P.n) return;
  float x = X[gid], y = Y[gid], z = Z[gid];
  int ip = (int) floor((x - P.xmin) * P.dxi + 1.0f);
  int jp = (int) floor((y - P.ymin) * P.dyi + 1.0f);
  int kp = (int) floor((z - P.zmin) * P.dzi + 1.0f);
  // Particles on the mesh boundary land one cell outside after rounding; the CPU drops that
  // sliver of charge, here it is clamped. Anything further out is a fault.
  if (ip < 0 || jp < 0 || kp < 0 || ip > (int) P.nx || jp > (int) P.ny || kp > (int) P.nz)
    atomic_fetch_or_explicit(fault, 1u, memory_order_relaxed);
  ip = clamp(ip, 1, (int) P.nx - 1);
  jp = clamp(jp, 1, (int) P.ny - 1);
  kp = clamp(kp, 1, (int) P.nz - 1);
  float ab = ((P.xmin - x) + (float) ip * P.dx) * P.dxi;
  float de = ((P.ymin - y) + (float) jp * P.dy) * P.dyi;
  float gh = ((P.zmin - z) + (float) kp * P.dz) * P.dzi;
  float oab = 1.0f - ab, ode = 1.0f - de, ogh = 1.0f - gh;
  float q = Q[gid] * P.dscale;
  uint c = (uint) (ip - 1) + P.nx * ((uint) (jp - 1) + P.ny * (uint) (kp - 1));
  uint sx = 1u, sy = P.nx, sz = P.nx * P.ny;
  acc_fixed(S, c,                ab  * de  * gh  * q);
  acc_fixed(S, c + sy,           ab  * ode * gh  * q);
  acc_fixed(S, c + sy + sz,      ab  * ode * ogh * q);
  acc_fixed(S, c + sz,           ab  * de  * ogh * q);
  acc_fixed(S, c + sx + sz,      oab * de  * ogh * q);
  acc_fixed(S, c + sx + sy + sz, oab * ode * ogh * q);
  acc_fixed(S, c + sx + sy,      oab * ode * gh  * q);
  acc_fixed(S, c + sx,           oab * de  * gh  * q);
}

// Fixed-point mesh -> zero padded complex array (x fastest).
kernel void rho_to_complex (const device uint* S [[buffer(0)]], device float2* A [[buffer(1)]],
                            constant ScPar& P [[buffer(2)]], uint gid [[thread_position_in_grid]]) {
  uint ntot = P.nx2 * P.ny2 * P.nz2;
  if (gid >= ntot) return;
  uint i = gid % P.nx2;
  uint t = gid / P.nx2;
  uint j = t % P.ny2;
  uint k = t / P.ny2;
  float v = 0.0f;
  if (i < P.nx && j < P.ny && k < P.nz) {
    uint c = i + P.nx * (j + P.ny * k);
    long q = ((long) S[2u*c + 1u] << 32) | (long) S[2u*c];
    v = (float) q * P.dsinv;
  }
  A[gid] = float2(v, 0.0f);
}

kernel void real_to_complex (const device float* R [[buffer(0)]], device float2* A [[buffer(1)]],
                             constant uint& n [[buffer(2)]], uint gid [[thread_position_in_grid]]) {
  if (gid < n) A[gid] = float2(R[gid], 0.0f);
}

// Radix-2 Stockham FFT of nl lines per threadgroup (nl*n/2 threads) in threadgroup memory, with the
// twiddles W[woff + m] = exp(-2 pi i m / n), m < n/2, from a table. Lines consecutive in l1 with
// bs1 == 1 are adjacent in memory, so with tfast == 0 the group's loads of one element across its
// lines are contiguous.
kernel void fft_lines (device float2* d [[buffer(0)]], constant FftPar& F [[buffer(1)]],
                       const device float2* W [[buffer(2)]],
                       uint tg [[threadgroup_position_in_grid]], uint tid [[thread_index_in_threadgroup]]) {
  threadgroup float2 s0[2048];
  threadgroup float2 s1[2048];
  uint n = F.n;
  uint hn = n / 2u;
  uint l, t;
  if (F.tfast) { l = tid / hn; t = tid - l * hn; } else { l = tid % F.nl; t = tid / F.nl; }
  uint ng1 = F.count1 / F.nl;
  uint g1 = tg % ng1;
  uint g2 = tg / ng1;
  uint base = (g1 * F.nl + l + F.l1_off) * F.bs1 + (g2 + F.l2_off) * F.bs2;
  threadgroup float2* in = s0 + l * n;
  threadgroup float2* out = s1 + l * n;
  in[t] = d[base + t * F.stride];
  in[t + hn] = d[base + (t + hn) * F.stride];
  threadgroup_barrier(mem_flags::mem_threadgroup);
  uint wstep = hn;
  for (uint Ns = 1u; Ns < n; Ns <<= 1u) {
    uint k = t & (Ns - 1u);
    float2 a0 = in[t];
    float2 a1 = in[t + hn];
    float2 w = W[F.woff + k * wstep];
    if (F.sign > 0) w.y = -w.y;
    float2 b = float2(a1.x * w.x - a1.y * w.y, a1.x * w.y + a1.y * w.x);
    uint o = (t - k) * 2u + k;
    out[o] = a0 + b;
    out[o + Ns] = a0 - b;
    threadgroup_barrier(mem_flags::mem_threadgroup);
    threadgroup float2* tmp = in; in = out; out = tmp;
    wstep >>= 1u;
  }
  d[base + t * F.stride] = in[t];
  d[base + (t + hn) * F.stride] = in[t + hn];
}

kernel void cmul (const device float2* A [[buffer(0)]], const device float2* G [[buffer(1)]],
                  device float2* B [[buffer(2)]], constant uint& n [[buffer(3)]],
                  uint gid [[thread_position_in_grid]]) {
  if (gid >= n) return;
  float2 a = A[gid], g = G[gid];
  B[gid] = float2(a.x * g.x - a.y * g.y, a.x * g.y + a.y * g.x);
}

// Physical octant of the padded backward transform, scaled.
// Two real fields from one complex transform: real part to E0, imaginary part to E1.
kernel void extract2 (const device float2* B [[buffer(0)]], device float* E0 [[buffer(1)]], device float* E1 [[buffer(2)]],
                      constant ScPar& P [[buffer(3)]], uint gid [[thread_position_in_grid]]) {
  uint ntot = P.nx * P.ny * P.nz;
  if (gid >= ntot) return;
  uint i = gid % P.nx;
  uint t = gid / P.nx;
  uint j = t % P.ny;
  uint k = t / P.ny;
  uint src = (i + P.nx - 1u) + P.nx2 * ((j + P.ny - 1u) + P.ny2 * (k + P.nz - 1u));
  float2 b = B[src];
  E0[gid] = P.grn_scale * b.x;
  E1[gid] = P.grn_scale * b.y;
}


// Padded Green functions from their octants (osc_get_rgrn_freespace, octant_only). Cell (i, j, k), 1-based
// in [1, 2n]: the last plane in each dimension is zero (undifferenced integral, see device_mesh_setup);
// otherwise the mirror cell in the upper octant with a sign flip for each mirrored odd dimension.
// pair = 1: real part from the Ex octant (odd in x), imaginary part from Ey (odd in y). pair = 0: Ez (odd in z).
struct GreenPar { uint nx, ny, nz, pair; };
kernel void expand_green (const device float* OX [[buffer(0)]], const device float* OY [[buffer(1)]],
                          const device float* OZ [[buffer(2)]], device float2* G [[buffer(3)]],
                          constant GreenPar& Q [[buffer(4)]], uint gid [[thread_position_in_grid]]) {
  uint nx2 = 2u * Q.nx, ny2 = 2u * Q.ny, nz2 = 2u * Q.nz;
  if (gid >= nx2 * ny2 * nz2) return;
  uint i = gid % nx2 + 1u;
  uint t = gid / nx2;
  uint j = t % ny2 + 1u;
  uint k = t / ny2 + 1u;
  if (i == nx2 || j == ny2 || k == nz2) { G[gid] = float2(0.0f, 0.0f); return; }
  bool lx = (i < Q.nx), ly = (j < Q.ny), lz = (k < Q.nz);
  uint a = lx ? Q.nx - i : i - Q.nx;
  uint b = ly ? Q.ny - j : j - Q.ny;
  uint c = lz ? Q.nz - k : k - Q.nz;
  uint o = a + Q.nx * (b + Q.ny * c);
  if (Q.pair) {
    float gx = OX[o], gy = OY[o];
    if (lx) gx = -gx;
    if (ly) gy = -gy;
    G[gid] = float2(gx, gy);
  } else {
    float gz = OZ[o];
    if (lz) gz = -gz;
    G[gid] = float2(gz, 0.0f);
  }
}

// Two real arrays (R[0:n), R[n:2n)) as the real and imaginary parts of one complex array.
kernel void reals_to_complex (const device float* R [[buffer(0)]], device float2* A [[buffer(1)]],
                              constant uint& n [[buffer(2)]], uint gid [[thread_position_in_grid]]) {
  if (gid < n) A[gid] = float2(R[gid], R[n + gid]);
}

kernel void extract (const device float2* B [[buffer(0)]], device float* E [[buffer(1)]],
                     constant ScPar& P [[buffer(2)]], uint gid [[thread_position_in_grid]]) {
  uint ntot = P.nx * P.ny * P.nz;
  if (gid >= ntot) return;
  uint i = gid % P.nx;
  uint t = gid / P.nx;
  uint j = t % P.ny;
  uint k = t / P.ny;
  uint src = (i + P.nx - 1u) + P.nx2 * ((j + P.ny - 1u) + P.ny2 * (k + P.nz - 1u));
  E[gid] = P.grn_scale * B[src].x;
}

kernel void interp_kick (const device float* Ex [[buffer(0)]], const device float* Ey [[buffer(1)]],
                         const device float* Ez [[buffer(2)]],
                         const device float* X [[buffer(3)]], const device float* Y [[buffer(4)]],
                         const device float* Z [[buffer(5)]], const device float* F [[buffer(6)]],
                         device float* PX [[buffer(7)]], device float* PY [[buffer(8)]],
                         device float* PZ [[buffer(9)]], constant ScPar& P [[buffer(10)]],
                         uint gid [[thread_position_in_grid]]) {
  if (gid >= P.n) return;
  float x = X[gid], y = Y[gid], z = Z[gid];
  int ip = (int) floor((x - P.xmin) * P.dxi + 1.0f);
  int jp = (int) floor((y - P.ymin) * P.dyi + 1.0f);
  int kp = (int) floor((z - P.zmin) * P.dzi + 1.0f);
  ip = clamp(ip, 1, (int) P.nx - 1);
  jp = clamp(jp, 1, (int) P.ny - 1);
  kp = clamp(kp, 1, (int) P.nz - 1);
  float ab = ((P.xmin - x) + (float) ip * P.dx) * P.dxi;
  float de = ((P.ymin - y) + (float) jp * P.dy) * P.dyi;
  float gh = ((P.zmin - z) + (float) kp * P.dz) * P.dzi;
  float oab = 1.0f - ab, ode = 1.0f - de, ogh = 1.0f - gh;
  float w000 = ab  * de  * gh,  w010 = ab  * ode * gh;
  float w011 = ab  * ode * ogh, w001 = ab  * de  * ogh;
  float w101 = oab * de  * ogh, w111 = oab * ode * ogh;
  float w110 = oab * ode * gh,  w100 = oab * de  * gh;
  uint c = (uint) (ip - 1) + P.nx * ((uint) (jp - 1) + P.ny * (uint) (kp - 1));
  uint sx = 1u, sy = P.nx, sz = P.nx * P.ny;
  float ex = Ex[c]*w000 + Ex[c+sy]*w010 + Ex[c+sy+sz]*w011 + Ex[c+sz]*w001
           + Ex[c+sx+sz]*w101 + Ex[c+sx+sy+sz]*w111 + Ex[c+sx+sy]*w110 + Ex[c+sx]*w100;
  float ey = Ey[c]*w000 + Ey[c+sy]*w010 + Ey[c+sy+sz]*w011 + Ey[c+sz]*w001
           + Ey[c+sx+sz]*w101 + Ey[c+sx+sy+sz]*w111 + Ey[c+sx+sy]*w110 + Ey[c+sx]*w100;
  float ez = Ez[c]*w000 + Ez[c+sy]*w010 + Ez[c+sy+sz]*w011 + Ez[c+sz]*w001
           + Ez[c+sx+sz]*w101 + Ez[c+sx+sy+sz]*w111 + Ez[c+sx+sy]*w110 + Ez[c+sx]*w100;
  float factor = F[gid];
  float px = PX[gid], py = PY[gid], pz = PZ[gid];
  float pz0 = sqrt((1.0f + pz) * (1.0f + pz) - px * px - py * py);
  px += ex * factor * P.kick_scale;
  py += ey * factor * P.kick_scale;
  float ef = ez * factor;
  float a = ef * ef + 2.0f * ef * pz0;
  float alpha = 1.0f + pz;
  pz += a / (sqrt(alpha * alpha + a) + alpha);
  PX[gid] = px;
  PY[gid] = py;
  PZ[gid] = pz;
}

// ------------------------------------------------------------------------------------------------
// Particle tracking on the resident bunch: the fast kernels of bunch_soa_mod (track1 for drifts,
// quadrupoles, thick multipoles and fringe-free bend slices), one thread per particle, in float32.
// Time is not tracked here: the host reconstructs it from z when it downloads the bunch.

constant int ALIVE = 1, LOST = 2, LOST_NEG_X = 3, LOST_POS_X = 4, LOST_NEG_Y = 5, LOST_POS_Y = 6, LOST_PZ = 8;
constant int UPSTREAM_END = 1, DOWNSTREAM_END = 2, INSIDE = 3;
constant int AP_AUTO = 1, AP_RECT = 2, AP_ELLIPSE = 3;
constant int KIND_DRIFT = 1, KIND_QUAD = 2, KIND_THICK = 3, KIND_BEND = 4, KIND_LCAV = 5, KIND_LCAV_STD = 6;
constant float C_LIGHT = 299792458.0f;

// Mirrored by bmad_dev_slice_par (C) and bmad_dev_slice_par_struct (Fortran). All members are 4 bytes.
struct SlicePar {
  int kind, n_step, ix_mag_max, offset_on, do_tilt, is_misaligned;
  int n_ap0, n_ap1;
  int rad_damp0, rad_damp1, rad_fluct0, rad_fluct1, rad_damp_vec;
  int ele_tag;
  uint rng_seed, rng_ctr;
  float length, s_start, s_end, p0c_ele, e_tot_ele, mass, max_ap;
  float charge_dir, b1, r_step, step_len, ab_f;
  float an[22], bn[22], cm[484];
  float tilt_tot, cos_t, sin_t, cos_mt, sin_mt;
  float x_off, y_off, z_off, zc_set, l_half, ds_center_unset, s_target_set, s_target_unset;
  float w_inv[9], w_mat[9];
  int ap_type[8];
  float ap_lim[64];
  float g, dg, g_tot, angle, beta_ref, sinc_a, cos_a, sin_a, cosc_a, sincc_a;
  float rad_scale;
  float rad_ref[12], rad_dmat[72], rad_dvec[12], rad_smat[72];
  int lc_abs_time, lc_long_mode, lc_travel, lc_ap_cont, lc_max_steps, lc_kick;   // lc_kick bit 0: entrance edge kick, bit 1: exit
  float lc_grad, lc_k, lc_omega, lc_phase, lc_s_off, lc_l_active, lc_time0, lc_inv_cb0, lc_ib0m1, lc_edge1;
  float lc_edge2, lc_zk, lc_rel_tol, lc_abs_tol, lc_init_ds, lc_min_ds, lc_fatal_ds, lc_ds_tiny, lc_charge, lc_rel_floor;
  int fr_type, fr_on;                      // bend fringe: 1 exact, 2 hwang; fr_on bit 0 entrance, bit 1 exit
  float fr_e[2], fr_fg[2], fr_g, fr_g_dir, fr_beta0, fr_pad;
  int rf_n, rf_abs;
  float rf_grad, rf_omega_e, rf_omega_t, rf_ff, rf_p0c_end, rf_pad;
};
struct RfStep { float ds, cphase, damp, rr, dd, cpond, p0c; int flags; };

struct Lane { float x, px, y, py, z, pz; int state; };

inline float sqrt_one_f (float x) { return x / (sqrt(1.0f + x) + 1.0f); }     // sqrt(1+x) - 1
inline float sinc_f (float x) { return (fabs(x) < 1.0e-3f) ? 1.0f - x * x / 6.0f : sin(x) / x; }
// sinc(x) - 1 without cancellation.
inline float sinc_m1_f (float x) {
  float x2 = x * x;
  if (fabs(x) < 0.3f) return -x2 / 6.0f * (1.0f - x2 / 20.0f * (1.0f - x2 / 42.0f * (1.0f - x2 / 72.0f)));
  return sin(x) / x - 1.0f;
}

// x**m with the square-and-multiply order of __powidf2.
inline float powi_f (float x, int m) {
  if (m < 0) return 0.0f;
  if (m == 0) return 1.0f;
  float xx = x, y = (m & 1) ? x : 1.0f;
  int n = m;
  while (true) {
    n /= 2;
    if (n == 0) break;
    xx *= xx;
    if (n & 1) y *= xx;
  }
  return y;
}

// Philox4x32-10 counter based random numbers, six standard normals per (particle, slice, edge).
inline uint4 philox4 (uint4 c, uint2 k) {
  for (int i = 0; i < 10; i++) {
    ulong p0 = (ulong) 0xD2511F53u * (ulong) c.x;
    ulong p1 = (ulong) 0xCD9E8D57u * (ulong) c.z;
    uint hi0 = (uint) (p0 >> 32), lo0 = (uint) p0, hi1 = (uint) (p1 >> 32), lo1 = (uint) p1;
    c = uint4(hi1 ^ c.y ^ k.x, lo1, hi0 ^ c.w ^ k.y, lo0);
    k.x += 0x9E3779B9u;
    k.y += 0xBB67AE85u;
  }
  return c;
}
inline float u01_f (uint v) { return ((float) v + 1.0f) * 2.3283064365386963e-10f; }    // (0, 1]
inline void box_muller (uint a, uint b, thread float& g0, thread float& g1) {
  float r = sqrt(-2.0f * log(u01_f(a)));
  float t = 6.283185307179586f * u01_f(b);
  g0 = r * cos(t);
  g1 = r * sin(t);
}
inline void gauss6 (uint pid, uint ctr, uint seed, int ie, thread float* g) {
  uint4 r1 = philox4(uint4(pid, ctr, (uint) ie, 0u), uint2(seed, 0x6A09E667u));
  uint4 r2 = philox4(uint4(pid, ctr, (uint) ie, 1u), uint2(seed, 0x6A09E667u));
  box_muller(r1.x, r1.y, g[0], g[1]);
  box_muller(r1.z, r1.w, g[2], g[3]);
  box_muller(r2.x, r2.y, g[4], g[5]);
}

// orbit_too_large (check_momentum = True). Returns true (and sets the state) if lost.
inline bool too_large (thread Lane& o, float max_ap) {
  if (o.x > max_ap)  { o.state = LOST_POS_X; return true; }
  if (-o.x > max_ap) { o.state = LOST_NEG_X; return true; }
  if (o.y > max_ap)  { o.state = LOST_POS_Y; return true; }
  if (-o.y > max_ap) { o.state = LOST_NEG_Y; return true; }
  float rel_p = 1.0f + o.pz;
  if (rel_p < 0.0f)  { o.state = LOST_PZ; return true; }
  float f = o.px * o.px + o.py * o.py - rel_p * rel_p;
  if (f > 0.0f) {
    if (fabs(o.px) > fabs(o.py)) o.state = (o.px > 0.0f) ? LOST_POS_X : LOST_NEG_X;
    else                         o.state = (o.py > 0.0f) ? LOST_POS_Y : LOST_NEG_Y;
    return true;
  }
  return false;
}

inline void aperture_one (thread Lane& o, int type, const constant float* L) {
  // L: x1_lim, x2_lim, y1_lim, y2_lim, ex_w2, ex_c, ey_w2, ey_c
  if (type == AP_ELLIPSE) {
    float xp = o.x - L[5], yp = o.y - L[7];
    float r = (xp / L[4]) * (xp / L[4]) + (yp / L[6]) * (yp / L[6]);
    if (r < 1.0f) return;
    if (fabs(xp / L[4]) > fabs(yp / L[6])) o.state = (xp > 0.0f) ? LOST_POS_X : LOST_NEG_X;
    else                                   o.state = (yp > 0.0f) ? LOST_POS_Y : LOST_NEG_Y;
  } else if (type == AP_RECT || type == AP_AUTO) {
    float unstable = 0.0f, f;
    if (L[0] != 0.0f && o.x < L[0]) { f = fabs((o.x - L[0]) / (L[1] - L[0])); if (f > unstable) { o.state = LOST_NEG_X; unstable = f; } }
    if (L[1] != 0.0f && o.x > L[1]) { f = fabs((o.x - L[1]) / (L[1] - L[0])); if (f > unstable) { o.state = LOST_POS_X; unstable = f; } }
    if (L[2] != 0.0f && o.y < L[2]) { f = fabs((o.y - L[2]) / (L[3] - L[2])); if (f > unstable) { o.state = LOST_NEG_Y; unstable = f; } }
    if (L[3] != 0.0f && o.y > L[3]) { f = fabs((o.y - L[3]) / (L[3] - L[2])); if (f > unstable) { o.state = LOST_POS_Y; unstable = f; } }
  }
}

inline void apertures (thread Lane& o, constant SlicePar& P, int ie) {
  int nap = (ie == 0) ? P.n_ap0 : P.n_ap1;
  for (int k = 0; k < nap; k++) {
    int idx = k + 4 * ie;
    aperture_one(o, P.ap_type[idx], &P.ap_lim[8 * idx]);
    if (o.state != ALIVE) return;
  }
}

// track1_radiation at edge ie (0 entrance, 1 exit); matrices stored Fortran order (j,k,ie).
inline void radiation (thread Lane& o, constant SlicePar& P, int ie, uint pid) {
  float v[6] = {o.x, o.px, o.y, o.py, o.z, o.pz};
  float dv[6];
  int damp = (ie == 0) ? P.rad_damp0 : P.rad_damp1;
  int fluct = (ie == 0) ? P.rad_fluct0 : P.rad_fluct1;
  if (damp) {
    float w[6];
    for (int j = 0; j < 6; j++) w[j] = v[j] - P.rad_ref[j + 6 * ie];
    for (int j = 0; j < 6; j++) {
      dv[j] = 0.0f;
      for (int k = 0; k < 6; k++) dv[j] += P.rad_dmat[j + 6 * k + 36 * ie] * w[k];
    }
    for (int j = 0; j < 6; j++) v[j] += P.rad_scale * dv[j];
    if (P.rad_damp_vec) for (int j = 0; j < 6; j++) v[j] += P.rad_scale * P.rad_dvec[j + 6 * ie];
  }
  if (fluct) {
    float g[6];
    gauss6(pid, P.rng_ctr, P.rng_seed, ie, g);
    for (int j = 0; j < 6; j++) {
      dv[j] = 0.0f;
      for (int k = 0; k < 6; k++) dv[j] += P.rad_smat[j + 6 * k + 36 * ie] * g[k];
    }
    for (int j = 0; j < 6; j++) v[j] += P.rad_scale * dv[j];
  }
  o.x = v[0]; o.px = v[1]; o.y = v[2]; o.py = v[3]; o.z = v[4]; o.pz = v[5];
  if (v[5] < -1.0f) o.state = LOST_PZ;
}

// track_a_drift (include_ref_motion = True), no time update.
inline void drift_f (thread Lane& o, float length, float mass, float p0c) {
  if (length == 0.0f) return;
  float rel_pc = 1.0f + o.pz;
  float px_rel = o.px / rel_pc, py_rel = o.py / rel_pc;
  float pxy2 = px_rel * px_rel + py_rel * py_rel;
  if (pxy2 >= 1.0f) { o.state = LOST_PZ; return; }
  float ps = sqrt(1.0f - pxy2);
  o.x += length * px_rel / ps;
  o.y += length * py_rel / ps;
  float pc = p0c * rel_pc;
  float A = mass * mass * (2.0f * o.pz + o.pz * o.pz) / (pc * pc + mass * mass);   // beta/beta_ref = sqrt(1 + A)
  o.z += length * (sqrt_one_f(A) + sqrt_one_f(-pxy2) / ps);
}

// track_a_drift (include_ref_motion = False): offset drifts.
inline void offset_drift_f (thread Lane& o, float length) {
  if (length == 0.0f) return;
  float rel_pc = 1.0f + o.pz;
  float px_rel = o.px / rel_pc, py_rel = o.py / rel_pc;
  float pxy2 = px_rel * px_rel + py_rel * py_rel;
  if (pxy2 >= 1.0f) { o.state = LOST_PZ; return; }
  float ps = sqrt(1.0f - pxy2);
  o.x += length * px_rel / ps;
  o.y += length * py_rel / ps;
  o.z += -length / ps;
}

inline void tilt_f (thread Lane& o, float c, float s) {
  float a = o.x, b = o.y;
  o.x = c * a + s * b;  o.y = -s * a + c * b;
  a = o.px;  b = o.py;
  o.px = c * a + s * b;  o.py = -s * a + c * b;
}

inline void mat3_vec_f (const constant float* w, const thread float* v, thread float* r) {
  r[0] = r[1] = r[2] = 0.0f;
  for (int k = 0; k < 3; k++) for (int i = 0; i < 3; i++) r[i] += w[i + 3 * k] * v[k];
}

inline void offset_set_f (thread Lane& o, constant SlicePar& P) {
  float rel_p = 1.0f + o.pz, s_body;
  if (P.is_misaligned) {
    float r[3] = {o.x - P.x_off, o.y - P.y_off, -P.zc_set}, r2[3];
    mat3_vec_f(P.w_inv, r, r2);
    r2[2] += P.l_half;
    s_body = r2[2];
    float pz2 = rel_p * rel_p - o.px * o.px - o.py * o.py;
    if (pz2 <= 0.0f) o.state = LOST_PZ;
    else {
      float p0[3] = {o.px, o.py, sqrt(pz2)}, p[3];
      mat3_vec_f(P.w_inv, p0, p);
      o.px = p[0]; o.py = p[1]; o.x = r2[0]; o.y = r2[1];
    }
  } else s_body = 0.0f;
  float ds = P.s_target_set - s_body;
  if (fabs(ds) > 1.0e-14f && o.state == ALIVE) offset_drift_f(o, ds);
  if (P.do_tilt && P.tilt_tot != 0.0f) tilt_f(o, P.cos_t, P.sin_t);
}

inline void offset_unset_f (thread Lane& o, constant SlicePar& P) {
  float rel_p = 1.0f + o.pz, s_lab;
  if (P.do_tilt && -P.tilt_tot != 0.0f) tilt_f(o, P.cos_mt, P.sin_mt);
  if (P.is_misaligned) {
    float r[3] = {o.x, o.y, -P.ds_center_unset}, r2[3];
    mat3_vec_f(P.w_mat, r, r2);
    r2[0] += P.x_off; r2[1] += P.y_off; r2[2] += P.z_off + P.l_half;
    s_lab = r2[2];
    float pz2 = rel_p * rel_p - o.px * o.px - o.py * o.py;
    if (pz2 <= 0.0f) o.state = LOST_PZ;
    else {
      float p0[3] = {o.px, o.py, sqrt(pz2)}, p[3];
      mat3_vec_f(P.w_mat, p0, p);
      o.px = p[0]; o.py = p[1]; o.x = r2[0]; o.y = r2[1];
    }
  } else s_lab = P.length;
  float ds = P.s_target_unset - s_lab;
  if (fabs(ds) > 1.0e-14f && o.state == ALIVE) offset_drift_f(o, ds);
}

// ab_multipole_kicks, magnetic.
inline void ab_kick_f (thread Lane& o, constant SlicePar& P, float scale, float p0c) {
  float kx_tot = 0.0f, ky_tot = 0.0f;
  float r = P.p0c_ele / p0c;
  for (int n = 0; n <= P.ix_mag_max; n++) {
    float a = r * P.an[n], b = r * P.bn[n], kx = 0.0f, ky = 0.0f;
    if (a != 0.0f || b != 0.0f) {
      float a2 = scale * (a * P.ab_f), b2 = scale * (b * P.ab_f);
      for (int m = 0; m <= n; m += 2) {
        float f = P.cm[n + 22 * m] * powi_f(o.x, n - m) * powi_f(o.y, m);
        kx += b2 * f;  ky -= a2 * f;
      }
      for (int m = 1; m <= n; m += 2) {
        float f = P.cm[n + 22 * m] * powi_f(o.x, n - m) * powi_f(o.y, m);
        kx += a2 * f;  ky += b2 * f;
      }
    }
    kx_tot += kx;  ky_tot += ky;
  }
  o.px += kx_tot;
  o.py += ky_tot;
}

inline void quad_z_coef_f (float k1, float length, float rel_p, thread float* m, thread float* zc) {
  float sqrt_k = sqrt(fabs(k1)), sk_l = sqrt_k * length, cx, sx;
  if (fabs(sk_l) < 1.0e-10f) {
    float k_l2 = k1 * length * length;
    cx = 1.0f + k_l2 / 2.0f;
    sx = (1.0f + k_l2 / 6.0f) * length;
  } else if (k1 < 0.0f) { cx = cos(sk_l); sx = sin(sk_l) / sqrt_k; }
  else { cx = cosh(sk_l); sx = sinh(sk_l) / sqrt_k; }
  m[0] = cx;  m[1] = sx / rel_p;  m[2] = k1 * sx * rel_p;  m[3] = cx;
  zc[0] = k1 * (-cx * sx + length) / 4.0f;
  zc[1] = -k1 * sx * sx / (2.0f * rel_p);
  zc[2] = -(cx * sx + length) / (4.0f * rel_p * rel_p);
}

// low_energy_z_correction; the large-pz branch (beta - beta0)/beta0 in a form without cancellation.
inline float low_e_dz_f (float pz, float p0c, float mass, float e_tot, float ds) {
  float beta0 = p0c / e_tot;
  if (mass * (beta0 * pz) * (beta0 * pz) < 3.0e-7f * e_tot) {
    float f = beta0 * beta0 * (2.0f * beta0 * beta0 - (mass / e_tot) * (mass / e_tot) / 2.0f);
    return ds * pz * (1.0f - 3.0f * (pz * beta0 * beta0) / 2.0f + pz * pz * f) * (mass / e_tot) * (mass / e_tot);
  }
  float a = 1.0f + pz;
  float E = sqrt((p0c * a) * (p0c * a) + mass * mass);
  return ds * mass * mass * (2.0f * pz + pz * pz) / (E * (a * e_tot + E));
}

// One step of the track_a_bend body. Returns false if the particle is lost inside.

// ------------------------------------------------------------------------------------------------
// Bend fringe kicks (bend_edge_kick with k1 = 0): exact_bend_edge_kick = wedge, dipole fringe, wedge
// back (fringe_type full); hwang_bend_edge_kick (basic_bend, hard_edge_only).

// bmad_wedger (bmad_rot_xz when g_tot = 0). False if the particle cannot be propagated.
inline bool wedger_f (float a, float g_tot, thread float* v) {
  float x = v[0], px = v[1], py = v[3], pp = 1.0f + v[5];
  float ps = pp * pp - px * px - py * py;
  if (ps <= 0.0f) return false;
  ps = sqrt(ps);
  float ca = cos(a), sa = sin(a);
  if (g_tot == 0.0f) {
    float den = ps * ca - px * sa;
    float L = x * sa / den;
    v[0] = x * ps / den;
    v[1] = px * ca + ps * sa;
    v[2] += py * L;
    v[4] -= pp * L;
    return true;
  }
  float pt = pp * pp - py * py;
  if (pt < 1.0e-10f) return false;
  pt = sqrt(pt);
  float s2a = sin(2.0f * a), s2 = sa * sa;
  // pxn = px cos a + (ps - g x) sin a. The path length L = (a + asin(px/pt) - asin(pxn/pt)) / g is the
  // difference of the edge angle and a nearly equal angle (x = 0 is the pure rotation by a); in float32
  // it is formed from the small deviation d = g x sin a: with w = sin(theta2 - theta1) = sin a - eps,
  // a - asin(w) = asin(cos a (eps + sin a (sqrt(1 + u) - 1))), u = (2 eps sin a - eps^2) / cos^2 a.
  float pxn0 = px * ca + ps * sa;
  float d = g_tot * x * sa;
  float pxn = pxn0 - d;
  float psn2 = pt * pt - pxn * pxn;
  if (psn2 < 1.0e-10f) return false;
  float psn = sqrt(psn2);
  float psn0 = sqrt(max(pt * pt - pxn0 * pxn0, 0.0f));
  float eps = d * (ps + px * (pxn0 + pxn) / (psn + psn0)) / (pt * pt);
  float u = (2.0f * eps * sa - eps * eps) / (ca * ca);
  float L = asin(ca * (eps + sa * sqrt_one_f(u))) / g_tot;
  float den = psn + ps * ca - px * sa;
  float num = x * px * s2a + s2 * (2.0f * x * ps - g_tot * x * x);
  v[0] = x * ca + num / den;
  v[1] = pxn;
  v[2] += py * L;
  v[4] -= pp * L;
  return true;
}

// bmad_fringe_dipoler. first: first track edge (b = g_tot), else second (b = -g_tot).
inline bool dipoler_f (float g_tot, float beta0, float fint_hgap, bool first, thread float* v) {
  float b = first ? g_tot : -g_tot;
  float x = v[0], px = v[1], y = v[2], py = v[3], z = v[4], pp = 1.0f + v[5];
  float ps = pp * pp - px * px - py * py;
  if (ps <= 0.0f) return false;
  ps = sqrt(ps);
  float ee = sqrt(pp * pp + 1.0f / (beta0 * beta0) - 1.0f);
  float beta = pp / ee;
  float xp = px / ps, yp = py / ps;
  float kap = b * fint_hgap;
  float fac2 = 1.0f + yp * yp;
  float d11 = (1.0f + xp * xp) / ps, d21 = xp * yp / ps, d31 = -xp;
  float d12 = xp * yp / ps, d22 = fac2 / ps, d32 = -yp;
  float d13 = -ee * xp / (ps * ps), d23 = -ee * yp / (ps * ps), d33 = ee / ps;
  float g2 = 1.0f + xp * xp * (2.0f + yp * yp);
  float fi0 = atan(xp / fac2) - 2.0f * kap * g2 * ps;
  float cf = cos(fi0);
  float co2 = b / (cf * cf);
  float co1 = co2 / (1.0f + (xp / fac2) * (xp / fac2));
  float fi1 = co1 / fac2 - 4.0f * kap * co2 * xp * (2.0f + yp * yp) * ps;
  float fi2 = -2.0f * co1 * xp * yp / (fac2 * fac2) - 4.0f * kap * co2 * xp * xp * yp * ps;
  float fi3 = -2.0f * kap * co2 * g2;
  float fi0t = b * tan(fi0);
  float bb2 = fi1 * d12 + fi2 * d22 + fi3 * d32;
  float sq = 1.0f - 2.0f * bb2 * y;
  if (sq < 0.0f) return false;
  sq = sqrt(sq);
  float ynew = 2.0f * y / (1.0f + sq);
  float bb1 = fi1 * d11 + fi2 * d21 + fi3 * d31;
  float bb3 = fi1 * d13 + fi2 * d23 + fi3 * d33;
  v[0] = x + 0.5f * bb1 * ynew * ynew;
  v[2] = ynew;
  v[3] = py - fi0t * ynew;
  v[4] = z + 0.5f * beta * bb3 * ynew * ynew;
  return true;
}

// bend_edge_kick at edge ie (0 entrance, 1 exit). False (state set) if the particle is lost.
inline bool bend_fringe_f (thread Lane& o, constant SlicePar& P, int ie) {
  float v[6] = {o.x, o.px, o.y, o.py, o.z, o.pz};
  float e = P.fr_e[ie], fg = P.fr_fg[ie];
  if (P.fr_type == 1) {
    float g = P.fr_g;
    bool ok;
    if (ie == 0) ok = wedger_f(e, 0.0f, v) && dipoler_f(g, P.fr_beta0, fg, true, v) && wedger_f(-e, g, v);
    else         ok = wedger_f(-e, g, v) && dipoler_f(g, P.fr_beta0, fg, false, v) && wedger_f(e, 0.0f, v);
    if (!ok) { o.state = LOST_PZ; return false; }
  } else if (P.fr_type == 2) {
    float g = P.fr_g_dir;
    float b_sign = (ie == 0) ? 1.0f : -1.0f;
    float cos_e = cos(e), sin_e = sin(e), tan_e = sin_e / cos_e, sec_e = 1.0f / cos_e;
    float f = g * tan_e;
    float c_y2 = fg * g * g * sec_e * sec_e * sec_e * (1.0f + sin_e * sin_e);
    float c_x3 = -g * g * tan_e * tan_e * tan_e / 12.0f;
    float c_xy2 = g * g * tan_e * sec_e * sec_e / 4.0f;
    float c_b = b_sign * g / 2.0f;
    float rel_p = 1.0f + v[5];
    // k_kick(0.5)
    {
      float x = v[0], y = v[2];
      float q = c_y2 * y * y + c_x3 * x * x * x + c_xy2 * x * y * y;
      float qx = 3.0f * c_x3 * x * x + c_xy2 * y * y;
      float qy = 2.0f * c_y2 * y + 2.0f * c_xy2 * x * y;
      v[1] += 0.5f * (f * x + qx / rel_p);
      v[3] += 0.5f * (-f * y + qy / rel_p);
      v[4] += 0.5f * q / (rel_p * rel_p);
    }
    // b1_flow(c_b tan^2)
    {
      float bb = c_b * tan_e * tan_e / rel_p;
      float x = v[0], px = v[1];
      float u = 1.0f + bb * x;
      if (u <= 0.0f) { o.state = LOST; return false; }
      v[0] = x / u;
      v[1] = px * u * u;
      v[4] += bb * x * x * px / rel_p;
    }
    // b2_flow(-c_b sec^2)
    {
      float bb = -c_b * sec_e * sec_e / rel_p;
      float y = v[2], px = v[1];
      v[0] -= bb * y * y;
      v[3] += 2.0f * bb * y * px;
      v[4] += bb * y * y * px / rel_p;
    }
    // b3_flow(-2 c_b tan^2)
    {
      float bb = -2.0f * c_b * tan_e * tan_e / rel_p;
      float x = v[0], y = v[2], py = v[3];
      float ex = exp(-bb * x);
      v[1] += bb * y * py;
      v[2] = y * ex;
      v[3] = py / ex;
      v[4] += bb * x * y * py / rel_p;
    }
    // k_kick(0.5)
    {
      float x = v[0], y = v[2];
      float q = c_y2 * y * y + c_x3 * x * x * x + c_xy2 * x * y * y;
      float qx = 3.0f * c_x3 * x * x + c_xy2 * y * y;
      float qy = 2.0f * c_y2 * y + 2.0f * c_xy2 * x * y;
      v[1] += 0.5f * (f * x + qx / rel_p);
      v[3] += 0.5f * (-f * y + qy / rel_p);
      v[4] += 0.5f * q / (rel_p * rel_p);
    }
  }
  o.x = v[0]; o.px = v[1]; o.y = v[2]; o.py = v[3]; o.z = v[4]; o.pz = v[5];
  return true;
}

inline bool bend_step_f (thread Lane& o, constant SlicePar& P, float mass, float p0c) {
  float g = P.g, angle = P.angle, step_len = P.step_len;
  float x = o.x, px = o.px, y = o.y, py = o.py, z = o.z, pz = o.pz;
  float rel_p = 1.0f + pz, rel_p2 = rel_p * rel_p;
  if (P.dg == 0.0f && fabs(x * g) < 1.0e-9f && fabs(px) < 1.0e-9f && fabs(py) < 1.0e-9f && fabs(pz) < 1.0e-9f) {
    float ll = step_len;
    float pc = rel_p * p0c;
    float gam2 = mass * mass / (pc * pc + mass * mass);
    float m56 = ll * (gam2 - (g * ll) * (g * ll) * P.sincc_a);
    o.x = P.cos_a * x + ll * P.sinc_a * px + g * ll * ll * P.cosc_a * pz;
    o.px = -g * P.sin_a * x + P.cos_a * px + g * ll * P.sinc_a * pz;
    o.y = y + ll * py;
    o.z = -g * ll * P.sinc_a * x - g * ll * ll * P.cosc_a * px + z + m56 * pz;
    return true;
  }
  float pt = sqrt(rel_p2 - py * py);
  if (fabs(px) > pt) { o.state = LOST_PZ; return false; }
  float g_p = P.g_tot / pt;
  float phi_1 = asin(px / pt);
  float cos_plus = cos(angle + phi_1), sin_plus = sin(angle + phi_1);
  float alpha = 2.0f * (1.0f + g * x) * sin_plus * step_len * P.sinc_a - g_p * ((1.0f + g * x) * step_len * P.sinc_a) * ((1.0f + g * x) * step_len * P.sinc_a);
  float r = cos_plus * cos_plus + g_p * alpha;
  if (r < 0.0f || (fabs(g_p) < 1.0e-5f && fabs(cos_plus) < 1.0e-5f)) { o.state = LOST; o.x = 2.0f * P.max_ap; return false; }
  float rad = sqrt(r), xi;
  if (cos_plus > 0.0f) xi = alpha / (rad + cos_plus);
  else xi = (rad - cos_plus) / g_p;
  o.x = x * P.cos_a - step_len * step_len * g * P.cosc_a + xi;
  if (fabs(o.x) > P.max_ap) { o.state = LOST; return false; }
  // Path length L_p = L_c / sinc(angle_p/2) with L_c = sqrt(u^2 + v^2), u = xi, v = step_len*sinc_a + x*sin_a.
  // L_p/step_len = (1 + g x) * S * T with S = sqrt(1 + (u/v)^2) and T = sinc(angle)/sinc(theta),
  // theta = angle_p/2. The z update needs step_len - rel_p*L_p/pt, a difference of nearly equal
  // numbers whose float32 rounding would repeat with the same sign step after step; so lambda =
  // L_p/step_len - 1 and rho - 1 = rel_p/pt - 1 are formed from small quantities only.
  float u = xi;
  float v = step_len * P.sinc_a + x * P.sin_a;
  float beta_a = atan2(u, v);
  float theta = angle + phi_1 - beta_a;
  float s1 = sqrt_one_f((u / v) * (u / v));                                  // S - 1
  float sm_t = sinc_m1_f(theta);
  float t1 = (sinc_m1_f(angle) - sm_t) / (1.0f + sm_t);                      // T - 1
  float gx = g * x;
  float lambda = gx + s1 + t1 + gx * s1 + gx * t1 + s1 * t1 + gx * s1 * t1;   // (1+gx)(1+s1)(1+t1) - 1
  float w = py / rel_p;
  float sq = sqrt(1.0f - w * w);
  float rho_m1 = (w * w / (1.0f + sq)) / sq;                                 // rel_p/pt - 1
  float L_p = step_len * (1.0f + lambda);
  o.px = pt * sin(2.0f * beta_a - angle - phi_1);                            // phi_1 + angle - angle_p
  o.y = y + py * L_p / pt;
  float pc = p0c * rel_p;
  float A = mass * mass * (2.0f * pz + pz * pz) / (pc * pc + mass * mass);
  o.z = z + step_len * sqrt_one_f(A) - step_len * (rho_m1 + lambda + rho_m1 * lambda);
  return true;
}


// ------------------------------------------------------------------------------------------------
// Runge-Kutta lcavity: track1_runge_kutta / odeint_bmad / rk_adaptive_step / rk_step1 / kick_vector_calc
// with the bmad_standard standing or traveling wave cavity field, one particle per thread. The time
// t is relative to the slice's reference time at its start (float32), the RF phase constant comes
// from the host. Differences of nearly equal numbers (beta/beta0 - 1, dt/ds - dt_ref/ds) are formed
// from small quantities so float32 does not lose them.

struct LcState { float x, px, y, py, z, pz, t; };

inline float lcav_beta (float pz, float p0c, float mass) {
  float pc = p0c * (1.0f + pz);
  return pc / sqrt(pc * pc + mass * mass);
}

// inside: the point is in the active region. The integrator knows this from the edges it has passed,
// which is more reliable than comparing float32 positions right at an edge.
inline void lcav_field (constant SlicePar& P, float x, float y, float s_eff, float time, bool inside, thread float* E, thread float* B) {
  E[0] = 0.0f; E[1] = 0.0f; E[2] = 0.0f; B[0] = 0.0f; B[1] = 0.0f; B[2] = 0.0f;
  if (!inside) return;
  float G = P.lc_grad, k = P.lc_k;
  float wt = P.lc_omega * time + P.lc_phase;
  float Ez, Er, Bp;
  if (P.lc_travel) {
    float phi = wt - k * s_eff, sp = sin(phi), cp = cos(phi);
    Ez = G * cp;  Er = -G * k * sp * 0.5f;  Bp = -G * k * sp / (2.0f * C_LIGHT);
  } else {
    float ks = k * s_eff, sks = sin(ks), cks = cos(ks), swt = sin(wt), cwt = cos(wt);
    if (P.lc_long_mode == 0) { Ez = 2.0f * G * sks * swt;  Er = -G * k * cks * swt;  Bp =  G * k * sks * cwt / C_LIGHT; }
    else                     { Ez = 2.0f * G * cks * cwt;  Er =  G * k * sks * cwt;  Bp = -G * k * cks * swt / C_LIGHT; }
  }
  E[0] = Er * x;  E[1] = Er * y;  E[2] = Ez;
  B[0] = -Bp * y;  B[1] = Bp * x;
}

// particle_rf_time for the state at s_body.
inline float lcav_time (constant SlicePar& P, float s_body, float z, float beta, float t) {
  if (P.lc_abs_time) return P.lc_time0 + t;
  return P.lc_time0 + s_body * P.lc_inv_cb0 - z / (beta * C_LIGHT);
}

// kick_vector_calc: d = d(x, px, y, py, z, pz, t)/ds; dtd = dt/ds - dt_ref/ds. False if the particle
// moves (nearly) transversely.
inline bool lcav_kick (constant SlicePar& P, float mass, float s_body, bool inside, thread const LcState& r, thread float* d, thread float& dtd) {
  float rel_pc = 1.0f + r.pz;
  float pc = P.p0c_ele * rel_pc;
  float u = (mass / pc) * (mass / pc);
  float e = sqrt_one_f(u);                                   // 1/beta - 1
  float beta = 1.0f / (1.0f + e);
  float vx = r.px / rel_pc, vy = r.py / rel_pc;
  float v2 = vx * vx + vy * vy;
  if (v2 > 0.99999999f) return false;
  float s1 = sqrt_one_f(-v2);                                // sqrt(1 - v2) - 1
  float sq = 1.0f + s1;
  float w = -s1 / sq;                                        // 1/sqrt(1 - v2) - 1
  float E[3], B[3];
  float time = lcav_time(P, s_body, r.z, beta, r.t);
  lcav_field(P, r.x, r.y, s_body + P.lc_s_off, time, inside, E, B);
  float q = P.lc_charge;
  float bc = beta * C_LIGHT;
  float vel0 = bc * vx, vel1 = bc * vy, vel2 = bc * sq;
  float Ef0 = q * E[0], Ef1 = q * E[1], Ef2 = q * E[2];
  float Bf0 = q * (vel1 * B[2] - vel2 * B[1]);
  float Bf1 = q * (vel2 * B[0] - vel0 * B[2]);
  float dt_ds = 1.0f / vel2;
  float dp_ds = (Ef0 * vel0 + Ef1 * vel1 + Ef2 * vel2) * dt_ds / bc;
  float e_tot = pc / beta;
  float dbeta_ds = mass * mass * dp_ds * C_LIGHT / (e_tot * e_tot * e_tot);
  float p0 = P.p0c_ele / C_LIGHT;
  d[0] = vel0 * dt_ds;
  d[1] = (Ef0 + Bf0) * dt_ds / p0;
  d[2] = vel1 * dt_ds;
  d[3] = (Ef1 + Bf1) * dt_ds / p0;
  d[4] = (P.lc_ib0m1 - e) / (1.0f + e) + s1 / sq + dbeta_ds * r.z / beta;   // beta/beta0 - 1 + sqrt_one(-v2)/sqrt(1-v2)
  d[5] = dp_ds / p0;
  d[6] = dt_ds;
  dtd = (e + w + e * w - P.lc_ib0m1) / C_LIGHT;              // (1/beta)(1/vz) - 1/beta0, over c
  return true;
}

// transfer_this_orbit: the state advanced by dvec from the step start, z from the time advance.
inline void lcav_transfer (constant SlicePar& P, float mass, thread const LcState& r, float beta_r,
                           thread const float* dv, float dz_t, thread LcState& out, thread float& beta_out) {
  out.x = r.x + dv[0];  out.px = r.px + dv[1];  out.y = r.y + dv[2];  out.py = r.py + dv[3];
  out.pz = r.pz + dv[5];  out.t = r.t + dv[6];
  beta_out = (dv[5] != 0.0f) ? lcav_beta(out.pz, P.p0c_ele, mass) : beta_r;
  out.z = r.z * (beta_out / beta_r) - C_LIGHT * beta_out * dz_t;   // c beta (dt_ref - dt), dz_t = sum w (dt/ds - dt_ref/ds) ds
}

// rk_step1: one fifth order Cash-Karp step with the embedded error estimate.
inline bool lcav_rk_step1 (constant SlicePar& P, float mass, float s, float ds, bool inside, thread const LcState& r, float beta_r,
                           thread LcState& rn, thread float& beta_n, thread float* r_err, thread float* d1) {
  const float a2 = 0.2f, a3 = 0.3f, a4 = 0.6f, a5 = 1.0f, a6 = 0.875f;
  const float b21 = 0.2f, b31 = 3.0f/40.0f, b32 = 9.0f/40.0f, b41 = 0.3f, b42 = -0.9f, b43 = 1.2f;
  const float b51 = -11.0f/54.0f, b52 = 2.5f, b53 = -70.0f/27.0f, b54 = 35.0f/27.0f;
  const float b61 = 1631.0f/55296.0f, b62 = 175.0f/512.0f, b63 = 575.0f/13824.0f, b64 = 44275.0f/110592.0f, b65 = 253.0f/4096.0f;
  const float c1 = 37.0f/378.0f, c3 = 250.0f/621.0f, c4 = 125.0f/594.0f, c6 = 512.0f/1771.0f;
  const float dc1 = c1 - 2825.0f/27648.0f, dc3 = c3 - 18575.0f/48384.0f, dc4 = c4 - 13525.0f/55296.0f;
  const float dc5 = -277.0f/14336.0f, dc6 = c6 - 0.25f;
  float d2[7], d3[7], d4[7], d5[7], d6[7], dv[7];
  float td1, td2, td3, td4, td5, td6, bt;
  LcState rt;
  if (!lcav_kick(P, mass, s, inside, r, d1, td1)) return false;
  for (int k = 0; k < 7; k++) dv[k] = ds * b21 * d1[k];
  lcav_transfer(P, mass, r, beta_r, dv, ds * b21 * td1, rt, bt);
  if (!lcav_kick(P, mass, s + a2 * ds, inside, rt, d2, td2)) return false;
  for (int k = 0; k < 7; k++) dv[k] = ds * (b31 * d1[k] + b32 * d2[k]);
  lcav_transfer(P, mass, r, beta_r, dv, ds * (b31 * td1 + b32 * td2), rt, bt);
  if (!lcav_kick(P, mass, s + a3 * ds, inside, rt, d3, td3)) return false;
  for (int k = 0; k < 7; k++) dv[k] = ds * (b41 * d1[k] + b42 * d2[k] + b43 * d3[k]);
  lcav_transfer(P, mass, r, beta_r, dv, ds * (b41 * td1 + b42 * td2 + b43 * td3), rt, bt);
  if (!lcav_kick(P, mass, s + a4 * ds, inside, rt, d4, td4)) return false;
  for (int k = 0; k < 7; k++) dv[k] = ds * (b51 * d1[k] + b52 * d2[k] + b53 * d3[k] + b54 * d4[k]);
  lcav_transfer(P, mass, r, beta_r, dv, ds * (b51 * td1 + b52 * td2 + b53 * td3 + b54 * td4), rt, bt);
  if (!lcav_kick(P, mass, s + a5 * ds, inside, rt, d5, td5)) return false;
  for (int k = 0; k < 7; k++) dv[k] = ds * (b61 * d1[k] + b62 * d2[k] + b63 * d3[k] + b64 * d4[k] + b65 * d5[k]);
  lcav_transfer(P, mass, r, beta_r, dv, ds * (b61 * td1 + b62 * td2 + b63 * td3 + b64 * td4 + b65 * td5), rt, bt);
  if (!lcav_kick(P, mass, s + a6 * ds, inside, rt, d6, td6)) return false;
  for (int k = 0; k < 7; k++) dv[k] = ds * (c1 * d1[k] + c3 * d3[k] + c4 * d4[k] + c6 * d6[k]);
  lcav_transfer(P, mass, r, beta_r, dv, ds * (c1 * td1 + c3 * td3 + c4 * td4 + c6 * td6), rn, beta_n);
  for (int k = 0; k < 6; k++) r_err[k] = ds * (dc1 * d1[k] + dc3 * d3[k] + dc4 * d4[k] + dc5 * d5[k] + dc6 * d6[k]);
  r_err[6] = ds * (dc1 * td1 + dc3 * td3 + dc4 * td4 + dc5 * td5 + dc6 * td6);
  return true;
}

// rk_adaptive_step. Returns false if the particle is lost (field error or step size underflow).
inline bool lcav_adaptive (constant SlicePar& P, float mass, bool inside, thread LcState& r, thread float& beta_r, thread float& s,
                           float ds_try, float ds12, thread float& ds_did, thread float& ds_next) {
  float ds = ds_try, ds_temp, err_max = 0.0f;
  float r_err[7], d1[7], bn;
  LcState rn;
  while (true) {
    if (!lcav_rk_step1(P, mass, s, ds, inside, r, beta_r, rn, bn, r_err, d1)) {
      if (ds < 1.0e-3f) return false;
      ds_temp = ds / 10.0f;
    } else {
      float sqrt_N = sqrt(fabs(ds12 / ds));
      float rel_tol = max(P.lc_rel_tol / sqrt_N, P.lc_rel_floor), abs_tol = P.lc_abs_tol / sqrt_N;
      float st[7] = {r.x, r.px, r.y, r.py, r.z, r.pz, 1.0e-9f};
      err_max = 0.0f;
      for (int k = 0; k < 7; k++) {
        float scal = fabs(st[k]) + fabs(ds * d1[k]) + 1.0e-30f;
        err_max = max(err_max, fabs(r_err[k]) / (scal * rel_tol + abs_tol));
      }
      if (err_max <= 1.0f) break;
      ds_temp = 0.9f * ds * pow(err_max, -0.25f);
    }
    ds = max(fabs(ds_temp), 0.1f * fabs(ds));
    if (s + ds == s) return false;
  }
  ds_next = (err_max > 1.89e-4f) ? 0.9f * ds * pow(err_max, -0.2f) : 5.0f * ds;
  ds_did = ds;
  s += ds;
  r = rn;
  beta_r = bn;
  return true;
}

// apply_element_edge_kick for an lcavity hard edge at s_edge (slice coordinate): the transverse kick
// of the longitudinal field just inside the active region. at_sign = +1 entrance, -1 exit.
inline void lcav_edge_kick (constant SlicePar& P, float mass, thread LcState& r, float at_sign, float s_edge) {
  float rel_pc = 1.0f + r.pz;
  float beta = lcav_beta(r.pz, P.p0c_ele, mass);
  float z_eff = P.lc_abs_time ? r.z : r.z - C_LIGHT * beta * P.lc_zk;
  float time = lcav_time(P, s_edge, z_eff, beta, r.t);
  float delta = max(1.0e-11f, 4.77e-7f * P.lc_l_active);
  float s_eff = s_edge + P.lc_s_off + at_sign * delta;
  float E[3], B[3];
  lcav_field(P, r.x, r.y, s_eff, time, s_eff >= 0.0f && s_eff <= P.lc_l_active, E, B);
  float ff = at_sign * P.lc_charge / (2.0f * P.p0c_ele);
  r.px = r.px - E[2] * r.x * ff + C_LIGHT * B[2] * r.y * ff;
  r.py = r.py - E[2] * r.y * ff - C_LIGHT * B[2] * r.x * ff;
  (void) rel_pc;
}

// odeint_bmad through the slice. p0c is the particle's reference momentum (updated to the slice's).
inline bool lcav_rk_f (thread Lane& o, constant SlicePar& P, float mass, thread float& p0c, float tz0) {
  // ele_reference_energy_correction at the first track edge.
  float p_rel = p0c / P.p0c_ele;
  o.px *= p_rel;  o.py *= p_rel;
  o.pz = (o.pz * p0c - (P.p0c_ele - p0c)) / P.p0c_ele;
  p0c = P.p0c_ele;
  LcState r = {o.x, o.px, o.y, o.py, o.z, o.pz, 0.0f};
  float beta = lcav_beta(r.pz, p0c, mass);
  r.t = tz0 - r.z / (beta * C_LIGHT);
  float L = P.length;
  float tol_s = max(P.lc_ds_tiny, 4.77e-7f * L);
  float s = 0.0f, ds_next = P.lc_init_ds, ds_try = 0.0f, ds_saved = 0.0f, ds_did = 0.0f;
  int stage = 0;                       // 0: entrance edge ahead, 1: exit edge ahead, 2: none
  float s_edge = P.lc_edge1;
  bool done = false, at_hard_edge = false;
  for (int n_step = 1; n_step <= P.lc_max_steps; n_step++) {
    while (stage < 2 && s - s_edge >= -tol_s) {
      if (P.lc_kick & (1 << stage)) lcav_edge_kick(P, mass, r, (stage == 0) ? 1.0f : -1.0f, s_edge);
      if (stage == 0) { stage = 1; s_edge = P.lc_edge2; } else { stage = 2; s_edge = L; }
      if (fabs(s - L) > tol_s) s += P.lc_ds_tiny;
    }
    if (s - L > -tol_s) { done = true; break; }
    ds_try = ds_next;
    at_hard_edge = false;
    if (stage < 2 && s + ds_try - s_edge > 0.0f) { at_hard_edge = true; ds_saved = ds_try; ds_try = s_edge - s - 0.5f * P.lc_ds_tiny; }
    if (!lcav_adaptive(P, mass, stage == 1, r, beta, s, ds_try, L, ds_did, ds_next)) {
      o.x = r.x; o.px = r.px; o.y = r.y; o.py = r.py; o.z = r.z; o.pz = r.pz;
      o.state = LOST;
      return false;
    }
    o.x = r.x; o.px = r.px; o.y = r.y; o.py = r.py; o.z = r.z; o.pz = r.pz;
    if (P.lc_ap_cont) { apertures(o, P, 0); if (o.state != ALIVE) return false; }
    if (too_large(o, P.max_ap)) return false;
    if (at_hard_edge && ds_next >= ds_try) ds_next = max(ds_saved, ds_next);
    if (s + ds_next - L > 0.0f) { ds_next = L - s; at_hard_edge = true; }
    if (ds_next < P.lc_min_ds) ds_next = P.lc_min_ds;
    if (!at_hard_edge && ds_try < P.lc_fatal_ds) break;
  }
  o.x = r.x; o.px = r.px; o.y = r.y; o.py = r.py; o.z = r.z; o.pz = r.pz;
  if (!done) {
    float rel_p = 1.0f + o.pz;
    o.state = (sqrt(o.px * o.px + o.py * o.py) > 0.9f * rel_p || o.pz < -0.99f) ? LOST_PZ : LOST;
    return false;
  }
  return true;
}


// ------------------------------------------------------------------------------------------------
// bmad_standard lcavity (track_a_lcavity, forward, no multipoles, solenoid field or coupler kick).
// The time of a particle at step k is t_ref(k) + tz0 - z/(beta c) (the drift, kicks and offsets keep
// t + z/(beta c) - t_ref fixed), so its RF phase is cphase(k) + omega_t (tz0 - z/(beta c)) with the
// large part cphase(k) formed on the host. dpc uses the cancellation-free form of dpc_given_dE.

inline float std_beta (float pz, float p0c, float mass) {
  float pc = p0c * (1.0f + pz);
  return pc / sqrt(pc * pc + mass * mass);
}

inline float std_phase (constant SlicePar& P, float cphase, float tz0, thread Lane& o, float beta) {
  float tt = (P.rf_abs ? tz0 : 0.0f) - o.z / (beta * C_LIGHT);
  return cphase + P.rf_omega_t * tt;
}

// Energy change dE at fixed position: pz, and z scaled so that z/beta is kept. False if lost.
inline bool std_energy_change (thread Lane& o, float dE, float p0c, float mass) {
  float pc = p0c * (1.0f + o.pz);
  float E = sqrt(pc * pc + mass * mass);
  if (E + dE <= mass) { o.state = LOST_PZ; return false; }
  float del2 = dE * (dE + 2.0f * E);
  float dpc = del2 / (sqrt(pc * pc + del2) + pc);
  float b_old = pc / E;
  float pc_new = pc + dpc;
  float b_new = pc_new / (E + dE);
  o.pz += dpc / p0c;
  o.z *= b_new / b_old;
  return true;
}

inline bool lcav_std_f (thread Lane& o, constant SlicePar& P, constant RfStep* T, float mass, thread float& p0c, float tz0) {
  for (int k = 0; k < P.rf_n; k++) {
    p0c = T[k].p0c;
    drift_f(o, T[k].ds, mass, p0c);
    if (o.state != ALIVE) return false;
    int fl = T[k].flags;
    for (int a = 0; a < 5; a++) {
      // Actions in track_a_lcavity order: entrance fringe, pondermotive, energy kick, pondermotive, exit fringe.
      int bit = (a == 0) ? 0 : (a == 1) ? 3 : (a == 2) ? 1 : (a == 3) ? 4 : 2;
      if (!(fl & (1 << bit))) continue;
      if (bit == 3 || bit == 4) {
        // The kick after the energy kick sees the new reference momentum: cpond scales as 1/p0c^2.
        float rel_p = 1.0f + o.pz;
        float coef = ((bit == 4) ? T[k].cpond * T[k].rr * T[k].rr : T[k].cpond) / rel_p;
        o.px -= coef * o.x;
        o.py -= coef * o.y;
        o.z += -0.5f * coef * (o.x * o.x + o.y * o.y) / rel_p;
        continue;
      }
      float beta = std_beta(o.pz, p0c, mass);
      float phase = std_phase(P, T[k].cphase, tz0, o, beta);
      if (bit == 1) {
        if (!std_energy_change(o, T[k].damp * cos(phase), p0c, mass)) return false;
        o.px *= T[k].rr;
        o.py *= T[k].rr;
        o.pz = o.pz * T[k].rr - T[k].dd;
        p0c = (k + 1 < P.rf_n) ? T[k + 1].p0c : P.rf_p0c_end;
      } else {
        float ff = ((bit == 0) ? 1.0f : -1.0f) * P.rf_ff;
        float ez = P.rf_grad * cos(phase);
        float dez = P.rf_grad * sin(phase) * P.rf_omega_e;
        float dE = -ff * 0.5f * dez * (o.x * o.x + o.y * o.y);
        float x = o.x, y = o.y;
        if (!std_energy_change(o, dE, p0c, mass)) return false;
        o.px -= ff / p0c * ez * x;
        o.py -= ff / p0c * ez * y;
      }
    }
  }
  p0c = P.rf_p0c_end;
  return true;
}

kernel void track_slice (device float* X [[buffer(0)]], device float* PX [[buffer(1)]],
                         device float* Y [[buffer(2)]], device float* PY [[buffer(3)]],
                         device float* Z [[buffer(4)]], device float* PZ [[buffer(5)]],
                         device int* STATE [[buffer(6)]], device int* LOC [[buffer(7)]],
                         device int* LOST_TAG [[buffer(8)]], device float* P0C [[buffer(9)]],
                         constant SlicePar& P [[buffer(10)]], constant uint& n [[buffer(11)]],
                         const device float* TZ0 [[buffer(12)]], constant RfStep* RF [[buffer(13)]],
                         uint gid [[thread_position_in_grid]]) {
  if (gid >= n) return;
  if (STATE[gid] != ALIVE) return;
  Lane o;
  o.x = X[gid]; o.px = PX[gid]; o.y = Y[gid]; o.py = PY[gid]; o.z = Z[gid]; o.pz = PZ[gid]; o.state = ALIVE;
  float p0c = P0C[gid];
  float mass = P.mass;
  int loc = UPSTREAM_END;

  // Entrance: orbit_too_large, apertures, radiation (track1 order).
  bool big = too_large(o, P.max_ap);
  if (!big) apertures(o, P, 0);
  if (P.rad_damp0 || P.rad_fluct0) radiation(o, P, 0, gid);
  bool go = (o.state == ALIVE);

  if (go) {
    if (P.kind == KIND_DRIFT) {
      drift_f(o, P.length, mass, p0c);
    } else if (P.kind == KIND_QUAD) {
      if (P.offset_on) offset_set_f(o, P);
      if (P.ix_mag_max > -1) ab_kick_f(o, P, P.r_step / 2.0f, p0c);
      float rel_p = 1.0f + o.pz;
      float k1 = P.charge_dir * P.b1 / (P.length * rel_p);
      float mx[4], my[4], zx[3], zy[3];
      quad_z_coef_f(-k1, P.step_len, rel_p, mx, zx);
      quad_z_coef_f(k1, P.step_len, rel_p, my, zy);
      float dz_low_e = low_e_dz_f(o.pz, p0c, mass, P.e_tot_ele, P.step_len);
      for (int istep = 1; istep <= P.n_step; istep++) {
        float x = o.x, px = o.px, y = o.y, py = o.py;
        o.z += (zx[0] * x * x + zx[1] * x * px + zx[2] * px * px + zy[0] * y * y + zy[1] * y * py + zy[2] * py * py);
        o.x = mx[0] * x + mx[1] * px;  o.px = mx[2] * x + mx[3] * px;
        o.y = my[0] * y + my[1] * py;  o.py = my[2] * y + my[3] * py;
        o.z += dz_low_e;
        if (P.ix_mag_max > -1) ab_kick_f(o, P, (istep == P.n_step) ? P.r_step / 2.0f : P.r_step, p0c);
      }
      if (P.offset_on) offset_unset_f(o, P);
    } else if (P.kind == KIND_THICK) {
      if (P.offset_on) offset_set_f(o, P);
      if (P.ix_mag_max > -1) ab_kick_f(o, P, P.r_step / 2.0f, p0c);
      for (int istep = 1; istep <= P.n_step; istep++) {
        drift_f(o, P.step_len, mass, p0c);
        if (P.ix_mag_max > -1) ab_kick_f(o, P, (istep == P.n_step) ? P.r_step / 2.0f : P.r_step, p0c);
      }
      if (P.offset_on) offset_unset_f(o, P);
    } else if (P.kind == KIND_BEND) {
      bool lost = false;
      if (P.fr_on & 1) lost = !bend_fringe_f(o, P, 0) || too_large(o, P.max_ap);
      for (int istep = 1; istep <= P.n_step && !lost; istep++) {
        if (!bend_step_f(o, P, mass, p0c)) lost = true;
      }
      if (!lost) lost = too_large(o, P.max_ap);
      if (!lost && (P.fr_on & 2)) bend_fringe_f(o, P, 1);
    } else if (P.kind == KIND_LCAV) {
      if (P.offset_on) offset_set_f(o, P);
      bool ok = lcav_rk_f(o, P, mass, p0c, TZ0[gid]);
      P0C[gid] = p0c;
      if (ok && P.offset_on) offset_unset_f(o, P);
    } else if (P.kind == KIND_LCAV_STD) {
      if (P.offset_on) offset_set_f(o, P);
      bool ok = (o.state == ALIVE) && lcav_std_f(o, P, RF, mass, p0c, TZ0[gid]);
      P0C[gid] = p0c;
      if (ok && P.offset_on) offset_unset_f(o, P);
    }

    // Exit block.
    if (!too_large(o, P.max_ap)) {
      if (o.state != ALIVE) loc = INSIDE;
      else {
        loc = DOWNSTREAM_END;
        bool bad = false;
        if (P.rad_damp1 || P.rad_fluct1) {
          radiation(o, P, 1, gid);
          bad = too_large(o, P.max_ap);
        }
        if (!bad) apertures(o, P, 1);
      }
    } else if (loc == UPSTREAM_END) loc = INSIDE;
  }

  X[gid] = o.x; PX[gid] = o.px; Y[gid] = o.y; PY[gid] = o.py; Z[gid] = o.z; PZ[gid] = o.pz;
  if (o.state != ALIVE) { STATE[gid] = o.state; LOST_TAG[gid] = P.ele_tag; }
  LOC[gid] = loc;
}

// ------------------------------------------------------------------------------------------------
// Reductions over the resident bunch: fixed threadgroup assignment, per-thread Kahan sums, a tree
// over the threadgroup, partials per threadgroup; the host adds the partials in double, in order.

struct RedPar { uint n; float dct; float mass; uint pad; };
// qs: charge weight scale (1/mean |q|), ts: time unit scale (1e12, ps): keeps q (dt)^2 above float underflow.
struct MomPar { uint n; float inv_c; float mass; uint pad; float qs; float ts; float avg[5]; float pad2; };

inline float beta_of (float pz, float p0c, float mass) {
  float pc = p0c * (1.0f + pz);
  return pc / sqrt(pc * pc + mass * mass);
}

kernel void reduce_sums (const device float* Z [[buffer(0)]], const device float* PZ [[buffer(1)]],
                         const device float* Q [[buffer(2)]], const device float* P0C [[buffer(3)]],
                         const device int* STATE [[buffer(4)]], device float* out [[buffer(5)]],
                         constant RedPar& R [[buffer(6)]],
                         uint tid [[thread_index_in_threadgroup]], uint tg [[threadgroup_position_in_grid]],
                         uint ntg [[threadgroups_per_grid]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float sh[3][256];
  float cnt = 0.0f, s1 = 0.0f, c1 = 0.0f, s2 = 0.0f, c2 = 0.0f;
  for (uint i = tg * tgs + tid; i < R.n; i += ntg * tgs) {
    if (STATE[i] != ALIVE) continue;
    cnt += 1.0f;
    float v = Z[i] / beta_of(PZ[i], P0C[i], R.mass);
    float y = v - c1; float t = s1 + y; c1 = (t - s1) - y; s1 = t;
    v = fabs(Q[i]);
    y = v - c2; t = s2 + y; c2 = (t - s2) - y; s2 = t;
  }
  sh[0][tid] = cnt; sh[1][tid] = s1; sh[2][tid] = s2;
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = tgs / 2; s > 0; s >>= 1) {
    if (tid < s) { sh[0][tid] += sh[0][tid + s]; sh[1][tid] += sh[1][tid + s]; sh[2][tid] += sh[2][tid + s]; }
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid == 0) { out[3 * tg] = sh[0][0]; out[3 * tg + 1] = sh[1][0]; out[3 * tg + 2] = sh[2][0]; }
}

// All of reduce_sums and reduce_bounds in one pass (bounds on z - dct*beta).
kernel void reduce_all (const device float* X [[buffer(0)]], const device float* Y [[buffer(1)]],
                        const device float* Z [[buffer(2)]], const device float* PZ [[buffer(3)]],
                        const device float* P0C [[buffer(4)]], const device int* STATE [[buffer(5)]],
                        const device float* Q [[buffer(6)]], device float* out [[buffer(7)]],
                        constant RedPar& R [[buffer(8)]],
                        uint tid [[thread_index_in_threadgroup]], uint tg [[threadgroup_position_in_grid]],
                        uint ntg [[threadgroups_per_grid]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float sh[9][256];
  float cnt = 0.0f, s1 = 0.0f, c1 = 0.0f, s2 = 0.0f, c2 = 0.0f;
  float lo[3] = {3.0e38f, 3.0e38f, 3.0e38f}, hi[3] = {-3.0e38f, -3.0e38f, -3.0e38f};
  for (uint i = tg * tgs + tid; i < R.n; i += ntg * tgs) {
    if (STATE[i] != ALIVE) continue;
    float beta = beta_of(PZ[i], P0C[i], R.mass);
    cnt += 1.0f;
    float v = Z[i] / beta;
    float y = v - c1; float t = s1 + y; c1 = (t - s1) - y; s1 = t;
    v = fabs(Q[i]);
    y = v - c2; t = s2 + y; c2 = (t - s2) - y; s2 = t;
    float p[3] = {X[i], Y[i], Z[i] - R.dct * beta};
    for (int k = 0; k < 3; k++) { lo[k] = min(lo[k], p[k]); hi[k] = max(hi[k], p[k]); }
  }
  sh[0][tid] = cnt; sh[1][tid] = s1; sh[2][tid] = s2;
  for (int k = 0; k < 3; k++) { sh[3 + k][tid] = lo[k]; sh[6 + k][tid] = hi[k]; }
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = tgs / 2; s > 0; s >>= 1) {
    if (tid < s) {
      sh[0][tid] += sh[0][tid + s]; sh[1][tid] += sh[1][tid + s]; sh[2][tid] += sh[2][tid + s];
      for (int k = 0; k < 3; k++) { sh[3 + k][tid] = min(sh[3 + k][tid], sh[3 + k][tid + s]); sh[6 + k][tid] = max(sh[6 + k][tid], sh[6 + k][tid + s]); }
    }
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid == 0) for (int k = 0; k < 9; k++) out[9 * tg + k] = sh[k][0];
}


// Bunch moments of the live particles for calc_bunch_params, per threadgroup in fixed order (host sums
// the partials in double). v = (x, px, y, py, z, pz, t - t0) with t - t0 = tz0 - z/(beta c).
// Pass 1 (25 per group): n_live, sum q (all), sum q (live), sum q v[7], sum q p0c, min v[7], max v[7].
kernel void moments1 (const device float* X [[buffer(0)]], const device float* PX [[buffer(1)]],
                      const device float* Y [[buffer(2)]], const device float* PY [[buffer(3)]],
                      const device float* Z [[buffer(4)]], const device float* PZ [[buffer(5)]],
                      const device float* P0C [[buffer(6)]], const device int* STATE [[buffer(7)]],
                      const device float* Q [[buffer(8)]], const device float* TZ0 [[buffer(9)]],
                      device float* out [[buffer(10)]], constant MomPar& M [[buffer(11)]],
                      uint tid [[thread_index_in_threadgroup]], uint tg [[threadgroup_position_in_grid]],
                      uint ntg [[threadgroups_per_grid]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float sh[25][256];
  float a[25];
  for (int k = 0; k < 11; k++) a[k] = 0.0f;
  for (int k = 11; k < 18; k++) a[k] = 3.0e38f;
  for (int k = 18; k < 25; k++) a[k] = -3.0e38f;
  for (uint i = tg * tgs + tid; i < M.n; i += ntg * tgs) {
    float q = Q[i] * M.qs;
    a[1] += q;
    if (STATE[i] != ALIVE) continue;
    float pc = P0C[i] * (1.0f + PZ[i]);
    float beta = pc / sqrt(pc * pc + M.mass * M.mass);
    float v[7] = {X[i], PX[i], Y[i], PY[i], Z[i], PZ[i], (TZ0[i] - Z[i] * M.inv_c / beta) * M.ts};
    a[0] += 1.0f;  a[2] += q;  a[10] += q * P0C[i];
    for (int k = 0; k < 7; k++) { a[3 + k] += q * v[k]; a[11 + k] = min(a[11 + k], v[k]); a[18 + k] = max(a[18 + k], v[k]); }
  }
  for (int k = 0; k < 25; k++) sh[k][tid] = a[k];
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = tgs / 2; s > 0; s >>= 1) {
    if (tid < s) {
      for (int k = 0; k < 11; k++) sh[k][tid] += sh[k][tid + s];
      for (int k = 11; k < 18; k++) sh[k][tid] = min(sh[k][tid], sh[k][tid + s]);
      for (int k = 18; k < 25; k++) sh[k][tid] = max(sh[k][tid], sh[k][tid + s]);
    }
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid == 0) for (int k = 0; k < 25; k++) out[25 * tg + k] = sh[k][0];
}

// Pass 2 (22 per group, centred on AVG, the slot means written by mom_avg): sum q (v - avg)_i (v - avg)_j, i <= j, over the first six coordinates, and sum q (v6 - avg6)^2.
kernel void moments2 (const device float* X [[buffer(0)]], const device float* PX [[buffer(1)]],
                      const device float* Y [[buffer(2)]], const device float* PY [[buffer(3)]],
                      const device float* Z [[buffer(4)]], const device float* PZ [[buffer(5)]],
                      const device float* P0C [[buffer(6)]], const device int* STATE [[buffer(7)]],
                      const device float* Q [[buffer(8)]], const device float* TZ0 [[buffer(9)]],
                      device float* out [[buffer(10)]], constant MomPar& M [[buffer(11)]],
                      const device float* AVG [[buffer(12)]],
                      uint tid [[thread_index_in_threadgroup]], uint tg [[threadgroup_position_in_grid]],
                      uint ntg [[threadgroups_per_grid]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float sh[22][256];
  float a[22];
  for (int k = 0; k < 22; k++) a[k] = 0.0f;
  for (uint i = tg * tgs + tid; i < M.n; i += ntg * tgs) {
    if (STATE[i] != ALIVE) continue;
    float q = Q[i] * M.qs;
    float d[6] = {X[i] - AVG[0], PX[i] - AVG[1], Y[i] - AVG[2], PY[i] - AVG[3], Z[i] - AVG[4], PZ[i] - AVG[5]};
    int idx = 0;
    for (int r = 0; r < 6; r++) for (int c = r; c < 6; c++) a[idx++] += q * d[r] * d[c];
    float pc = P0C[i] * (1.0f + PZ[i]);
    float beta = pc / sqrt(pc * pc + M.mass * M.mass);
    float dt = (TZ0[i] - Z[i] * M.inv_c / beta) * M.ts - AVG[6];
    a[21] += q * dt * dt;
  }
  for (int k = 0; k < 22; k++) sh[k][tid] = a[k];
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = tgs / 2; s > 0; s >>= 1) {
    if (tid < s) for (int k = 0; k < 22; k++) sh[k][tid] += sh[k][tid + s];
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid == 0) for (int k = 0; k < 22; k++) out[22 * tg + k] = sh[k][0];
}

// Partials of moments1/moments2 (ng groups x nk columns) reduced in group order into a save slot: columns
// [0, n_sum) are sums kept as hi + lo float pairs (two-sum compensation, about double precision), the next
// n_min columns minima and then n_max columns maxima (stored with lo = 0).
struct MomRed { uint ng, nk, n_sum, n_min, off, pad0, pad1, pad2; };
// One threadgroup (256 threads) per column k. Sums: each thread adds its groups g = tid, tid + 256, ...
// with two-sum compensation, then a fixed-shape tree adds the (hi, lo) pairs; the order is fixed, so the
// result is deterministic.
inline float2 two_sum (float a, float b) {
  float s = a + b;
  float bb = s - a;
  return float2(s, (a - (s - bb)) + (b - bb));
}
kernel void mom_reduce (const device float* P [[buffer(0)]], device float* SLOT [[buffer(1)]],
                        constant MomRed& R [[buffer(2)]], uint k [[threadgroup_position_in_grid]],
                        uint tid [[thread_index_in_threadgroup]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float shh[256];
  threadgroup float shl[256];
  if (k >= R.nk) return;
  bool is_sum = (k < R.n_sum), is_min = (!is_sum && k < R.n_sum + R.n_min);
  float hi = is_sum ? 0.0f : (is_min ? 3.0e38f : -3.0e38f), lo = 0.0f;
  for (uint g = tid; g < R.ng; g += tgs) {
    float b = P[R.nk * g + k];
    if (is_sum) { float2 t = two_sum(hi, b); hi = t.x; lo += t.y; }
    else if (is_min) hi = min(hi, b);
    else hi = max(hi, b);
  }
  shh[tid] = hi;  shl[tid] = lo;
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint st = tgs / 2u; st > 0u; st >>= 1u) {
    if (tid < st) {
      if (is_sum) {
        float2 t = two_sum(shh[tid], shh[tid + st]);
        shh[tid] = t.x;  shl[tid] = shl[tid] + shl[tid + st] + t.y;
      } else if (is_min) shh[tid] = min(shh[tid], shh[tid + st]);
      else shh[tid] = max(shh[tid], shh[tid + st]);
    }
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid == 0u) {
    SLOT[R.off + 2u * k] = shh[0];
    SLOT[R.off + 2u * k + 1u] = is_sum ? shl[0] : 0.0f;
  }
}

// The charge weighted means of the seven coordinates for the centred second pass (slot floats 50..56).
kernel void mom_avg (device float* SLOT [[buffer(0)]], uint k [[thread_position_in_grid]]) {
  if (k >= 7u) return;
  float q = SLOT[4] + SLOT[5];
  SLOT[50u + k] = (q == 0.0f) ? 0.0f : (SLOT[2u * (3u + k)] + SLOT[2u * (3u + k) + 1u]) / q;
}

kernel void reduce_bounds (const device float* X [[buffer(0)]], const device float* Y [[buffer(1)]],
                           const device float* Z [[buffer(2)]], const device float* PZ [[buffer(3)]],
                           const device float* P0C [[buffer(4)]], const device int* STATE [[buffer(5)]],
                           device float* out [[buffer(6)]], constant RedPar& R [[buffer(7)]],
                           uint tid [[thread_index_in_threadgroup]], uint tg [[threadgroup_position_in_grid]],
                           uint ntg [[threadgroups_per_grid]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float sh[6][256];
  float lo[3] = {3.0e38f, 3.0e38f, 3.0e38f}, hi[3] = {-3.0e38f, -3.0e38f, -3.0e38f};
  for (uint i = tg * tgs + tid; i < R.n; i += ntg * tgs) {
    if (STATE[i] != ALIVE) continue;
    float zs = Z[i] - R.dct * beta_of(PZ[i], P0C[i], R.mass);
    float v[3] = {X[i], Y[i], zs};
    for (int k = 0; k < 3; k++) { lo[k] = min(lo[k], v[k]); hi[k] = max(hi[k], v[k]); }
  }
  for (int k = 0; k < 3; k++) { sh[k][tid] = lo[k]; sh[3 + k][tid] = hi[k]; }
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = tgs / 2; s > 0; s >>= 1) {
    if (tid < s) for (int k = 0; k < 3; k++) { sh[k][tid] = min(sh[k][tid], sh[k][tid + s]); sh[3 + k][tid] = max(sh[3 + k][tid], sh[3 + k][tid + s]); }
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid == 0) for (int k = 0; k < 6; k++) out[6 * tg + k] = sh[k][0];
}

// ------------------------------------------------------------------------------------------------
// Space charge step on the resident bunch: deposit and kick read the shift and the kick factor from
// the particle itself (z - dct*beta, track_step/(p0c*beta)), skip dead particles, and rescale z by
// beta_new/beta_old without cancellation.

kernel void deposit_r (device atomic_uint* S [[buffer(0)]],
                       const device float* X [[buffer(1)]], const device float* Y [[buffer(2)]],
                       const device float* Z [[buffer(3)]], const device float* Q [[buffer(4)]],
                       const device float* PZ [[buffer(5)]], const device float* P0C [[buffer(6)]],
                       const device int* STATE [[buffer(7)]],
                       constant ScPar& P [[buffer(8)]], device atomic_uint* fault [[buffer(9)]],
                       uint gid [[thread_position_in_grid]]) {
  if (gid >= P.n) return;
  if (STATE[gid] != ALIVE) return;
  float x = X[gid], y = Y[gid];
  float z = Z[gid] - P.dct * beta_of(PZ[gid], P0C[gid], P.mass);
  int ip = (int) floor((x - P.xmin) * P.dxi + 1.0f);
  int jp = (int) floor((y - P.ymin) * P.dyi + 1.0f);
  int kp = (int) floor((z - P.zmin) * P.dzi + 1.0f);
  if (ip < 0 || jp < 0 || kp < 0 || ip > (int) P.nx || jp > (int) P.ny || kp > (int) P.nz)
    atomic_fetch_or_explicit(fault, 1u, memory_order_relaxed);
  ip = clamp(ip, 1, (int) P.nx - 1);
  jp = clamp(jp, 1, (int) P.ny - 1);
  kp = clamp(kp, 1, (int) P.nz - 1);
  float ab = ((P.xmin - x) + (float) ip * P.dx) * P.dxi;
  float de = ((P.ymin - y) + (float) jp * P.dy) * P.dyi;
  float gh = ((P.zmin - z) + (float) kp * P.dz) * P.dzi;
  float oab = 1.0f - ab, ode = 1.0f - de, ogh = 1.0f - gh;
  float q = Q[gid] * P.dscale;
  uint c = (uint) (ip - 1) + P.nx * ((uint) (jp - 1) + P.ny * (uint) (kp - 1));
  uint sx = 1u, sy = P.nx, sz = P.nx * P.ny;
  acc_fixed(S, c,                ab  * de  * gh  * q);
  acc_fixed(S, c + sy,           ab  * ode * gh  * q);
  acc_fixed(S, c + sy + sz,      ab  * ode * ogh * q);
  acc_fixed(S, c + sz,           ab  * de  * ogh * q);
  acc_fixed(S, c + sx + sz,      oab * de  * ogh * q);
  acc_fixed(S, c + sx + sy + sz, oab * ode * ogh * q);
  acc_fixed(S, c + sx + sy,      oab * ode * gh  * q);
  acc_fixed(S, c + sx,           oab * de  * gh  * q);
}

kernel void interp_kick_r (const device float* Ex [[buffer(0)]], const device float* Ey [[buffer(1)]],
                           const device float* Ez [[buffer(2)]],
                           const device float* X [[buffer(3)]], const device float* Y [[buffer(4)]],
                           device float* Z [[buffer(5)]], const device float* P0C [[buffer(6)]],
                           device float* PX [[buffer(7)]], device float* PY [[buffer(8)]],
                           device float* PZ [[buffer(9)]], const device int* STATE [[buffer(10)]],
                           constant ScPar& P [[buffer(11)]], uint gid [[thread_position_in_grid]]) {
  if (gid >= P.n) return;
  if (STATE[gid] != ALIVE) return;
  float p0c = P0C[gid], pz = PZ[gid], px = PX[gid], py = PY[gid];
  float beta = beta_of(pz, p0c, P.mass);
  float x = X[gid], y = Y[gid];
  float z = Z[gid] - P.dct * beta;
  int ip = (int) floor((x - P.xmin) * P.dxi + 1.0f);
  int jp = (int) floor((y - P.ymin) * P.dyi + 1.0f);
  int kp = (int) floor((z - P.zmin) * P.dzi + 1.0f);
  ip = clamp(ip, 1, (int) P.nx - 1);
  jp = clamp(jp, 1, (int) P.ny - 1);
  kp = clamp(kp, 1, (int) P.nz - 1);
  float ab = ((P.xmin - x) + (float) ip * P.dx) * P.dxi;
  float de = ((P.ymin - y) + (float) jp * P.dy) * P.dyi;
  float gh = ((P.zmin - z) + (float) kp * P.dz) * P.dzi;
  float oab = 1.0f - ab, ode = 1.0f - de, ogh = 1.0f - gh;
  float w000 = ab  * de  * gh,  w010 = ab  * ode * gh;
  float w011 = ab  * ode * ogh, w001 = ab  * de  * ogh;
  float w101 = oab * de  * ogh, w111 = oab * ode * ogh;
  float w110 = oab * ode * gh,  w100 = oab * de  * gh;
  uint c = (uint) (ip - 1) + P.nx * ((uint) (jp - 1) + P.ny * (uint) (kp - 1));
  uint sx = 1u, sy = P.nx, sz = P.nx * P.ny;
  float ex = Ex[c]*w000 + Ex[c+sy]*w010 + Ex[c+sy+sz]*w011 + Ex[c+sz]*w001
           + Ex[c+sx+sz]*w101 + Ex[c+sx+sy+sz]*w111 + Ex[c+sx+sy]*w110 + Ex[c+sx]*w100;
  float ey = Ey[c]*w000 + Ey[c+sy]*w010 + Ey[c+sy+sz]*w011 + Ey[c+sz]*w001
           + Ey[c+sx+sz]*w101 + Ey[c+sx+sy+sz]*w111 + Ey[c+sx+sy]*w110 + Ey[c+sx]*w100;
  float ez = Ez[c]*w000 + Ez[c+sy]*w010 + Ez[c+sy+sz]*w011 + Ez[c+sz]*w001
           + Ez[c+sx+sz]*w101 + Ez[c+sx+sy+sz]*w111 + Ez[c+sx+sy]*w110 + Ez[c+sx]*w100;
  float factor = P.track_step / (p0c * beta);
  float pz0 = sqrt((1.0f + pz) * (1.0f + pz) - px * px - py * py);
  px += ex * factor * P.kick_scale;
  py += ey * factor * P.kick_scale;
  float ef = ez * factor;
  float a = ef * ef + 2.0f * ef * pz0;
  float alpha = 1.0f + pz;
  float pz_new = pz + a / (sqrt(alpha * alpha + a) + alpha);
  // z *= beta_new/beta_old:  ratio - 1 = mu2 (b-a)(b+a) / (b sqrt(a2+mu2) + a sqrt(b2+mu2))
  float aa = 1.0f + pz, bb = 1.0f + pz_new;
  float mu2 = (P.mass / p0c) * (P.mass / p0c);
  float ea = sqrt(aa * aa + mu2), eb = sqrt(bb * bb + mu2);
  float ratio_m1 = mu2 * (bb - aa) * (bb + aa) / ((bb * ea + aa * eb) * (aa * eb));
  Z[gid] = Z[gid] + Z[gid] * ratio_m1;
  PX[gid] = px;
  PY[gid] = py;
  PZ[gid] = pz_new;
}

// ------------------------------------------------------------------------------------------------
// 1D CSR binning (csr_bin_view) and the CSR kick on the resident bunch. Bin sums are fixed point
// (two uint32 words per sum, carry by hand) so the result is deterministic.

struct CsrPar {
  uint n, n_bin, pbs, pass;
  float z_min, dz_slice, dz_particle, inv_dz2;
  float scale0, scale1, scale2, scale3;
  float zc1, pad1, pad2, pad3;
};
struct WinPar { uint b0, nb_win, n_group, chunk, ns, pad0, pad1, pad2; };   // chunk: particles per threadgroup, ns: sums per bin          // bin window [b0, b0 + nb_win) of one dispatch
struct CsrSetup { uint n, n_bin, pbs, n_bin_eff; float mass, pad1, pad2, pad3; };

// 2^(61 - exponent(big)): the fixed-point scale that keeps a sum bounded by big below 2^61.
inline float pow2_scale (float big) {
  if (!(big > 0.0f)) big = 1.0f;
  int e;
  frexp(big, e);
  int k = 61 - e;
  if (k > 120) k = 120;
  if (k < -120) k = -120;
  return ldexp(1.0f, k);
}

// Reduce the reduce_all partials (one threadgroup) and lay the CSR bins out as csr_bin_view does
// (z range, dz_slice, z_min, dz_particle) with the fixed-point scales of both passes, so statistics,
// layout and bin sums need one submission. CP[0] is the pass-1 parameter block, CP[1] pass 2.
kernel void csr_layout (const device float* R [[buffer(0)]], device float* STATS [[buffer(1)]],
                        device CsrPar* CP [[buffer(2)]], constant CsrSetup& S [[buffer(3)]],
                        constant uint& n_group [[buffer(4)]],
                        uint tid [[thread_index_in_threadgroup]], uint tgs [[threads_per_threadgroup]]) {
  threadgroup float sh[9][256];
  float cnt = 0.0f, s1 = 0.0f, s2 = 0.0f;
  float lo[3] = {3.0e38f, 3.0e38f, 3.0e38f}, hi[3] = {-3.0e38f, -3.0e38f, -3.0e38f};
  for (uint g = tid; g < n_group; g += tgs) {
    cnt += R[9 * g]; s1 += R[9 * g + 1]; s2 += R[9 * g + 2];
    for (int k = 0; k < 3; k++) { lo[k] = min(lo[k], R[9 * g + 3 + k]); hi[k] = max(hi[k], R[9 * g + 6 + k]); }
  }
  sh[0][tid] = cnt; sh[1][tid] = s1; sh[2][tid] = s2;
  for (int k = 0; k < 3; k++) { sh[3 + k][tid] = lo[k]; sh[6 + k][tid] = hi[k]; }
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = tgs / 2; s > 0; s >>= 1) {
    if (tid < s) {
      sh[0][tid] += sh[0][tid + s]; sh[1][tid] += sh[1][tid + s]; sh[2][tid] += sh[2][tid + s];
      for (int k = 0; k < 3; k++) { sh[3 + k][tid] = min(sh[3 + k][tid], sh[3 + k][tid + s]); sh[6 + k][tid] = max(sh[6 + k][tid], sh[6 + k][tid + s]); }
    }
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
  if (tid != 0) return;
  for (int k = 0; k < 9; k++) STATS[k] = sh[k][0];
  float n_live = sh[0][0], q_abs = sh[2][0];
  float x_abs = max(fabs(sh[3][0]), fabs(sh[6][0])), y_abs = max(fabs(sh[4][0]), fabs(sh[7][0]));
  float z_lo = sh[5][0], z_hi = sh[8][0];
  float dz_slice = 1.0000001f * (z_hi - z_lo) / (float) S.n_bin_eff;
  if (!(dz_slice > 0.0f)) dz_slice = 1.0f;                 // empty or zero-length bunch: the host reports it
  float z_center = 0.5f * (z_hi + z_lo);
  float z_min = z_center - (float) S.n_bin * dz_slice * 0.5f;
  float dz_particle = (float) S.pbs * dz_slice;
  CsrPar P;
  P.n = S.n; P.n_bin = S.n_bin; P.pbs = S.pbs; P.pass = 1u;
  P.z_min = z_min; P.dz_slice = dz_slice; P.dz_particle = dz_particle; P.inv_dz2 = 1.0f / (dz_particle * dz_particle);
  P.scale0 = pow2_scale(max(n_live, 1.0f)); P.scale1 = pow2_scale(q_abs);
  P.scale2 = pow2_scale(q_abs * x_abs);     P.scale3 = pow2_scale(q_abs * y_abs);
  P.zc1 = z_min + 0.5f * dz_slice; P.pad1 = 0.0f; P.pad2 = 0.0f; P.pad3 = 0.0f;
  CP[0] = P;
  P.pass = 2u;
  P.scale0 = pow2_scale(2.0f * q_abs * x_abs); P.scale1 = pow2_scale(2.0f * q_abs * y_abs);
  P.scale2 = pow2_scale(1.0f);                 P.scale3 = pow2_scale(1.0f);
  CP[1] = P;
}

inline void acc_fixed_tg (threadgroup atomic_uint* S, uint cell, float v) {
  long q = (long) v;
  uint lo = (uint) q;
  uint hi = (uint) (q >> 32);
  uint prev = atomic_fetch_add_explicit(&S[2u*cell], lo, memory_order_relaxed);
  uint carry = (prev + lo < prev) ? 1u : 0u;
  uint add_hi = hi + carry;
  if (add_hi != 0u) atomic_fetch_add_explicit(&S[2u*cell + 1u], add_hi, memory_order_relaxed);
}

inline int nint_f (float x) { return (x >= 0.0f) ? (int) floor(x + 0.5f) : -((int) floor(-x + 0.5f)); }

// Per-bin centroids from the pass-1 fixed-point sums (x0 = sum x q / sum q), for the width pass.
kernel void csr_x0 (const device uint* S [[buffer(0)]], device float* X0 [[buffer(1)]], device float* Y0 [[buffer(2)]],
                    const device CsrPar& C [[buffer(3)]], uint ib [[thread_position_in_grid]]) {
  if (ib >= C.n_bin) return;
  uint w = 4u * ib;
  long qc = ((long) S[2u*(w+1u) + 1u] << 32) | (long) S[2u*(w+1u)];
  long qx = ((long) S[2u*(w+2u) + 1u] << 32) | (long) S[2u*(w+2u)];
  long qy = ((long) S[2u*(w+3u) + 1u] << 32) | (long) S[2u*(w+3u)];
  float charge = (float) qc / C.scale1;
  if (charge == 0.0f) { X0[ib] = 0.0f; Y0[ib] = 0.0f; return; }
  X0[ib] = ((float) qx / C.scale2) / charge;
  Y0[ib] = ((float) qy / C.scale3) / charge;
}


// One threadgroup's partial bin sums for the window [b0, b0 + nb_win), accumulated in threadgroup
// memory (32 bytes per bin) and written to PART[tg][8 nb_win] for csr_bins_reduce. Global atomics on a
// few hundred bins serialize 1e5-1e6 particles; this keeps the contention inside a threadgroup.
kernel void csr_bins_tg (const device float* X [[buffer(0)]], const device float* Y [[buffer(1)]],
                         const device float* Z [[buffer(2)]], const device float* Q [[buffer(3)]],
                         const device int* STATE [[buffer(4)]], device uint* PART [[buffer(5)]],
                         const device float* X0 [[buffer(6)]], const device float* Y0 [[buffer(7)]],
                         const device CsrPar& C [[buffer(8)]], device atomic_uint* fault [[buffer(9)]],
                         constant WinPar& W [[buffer(10)]], threadgroup atomic_uint* sh [[threadgroup(0)]],
                         uint tid [[thread_index_in_threadgroup]],
                         uint tg [[threadgroup_position_in_grid]], uint tgs [[threads_per_threadgroup]]) {
  uint nw = 2u * W.ns * W.nb_win;
  for (uint w = tid; w < nw; w += tgs) atomic_store_explicit(&sh[w], 0u, memory_order_relaxed);
  threadgroup_barrier(mem_flags::mem_threadgroup);
  // Each threadgroup bins a chunk of particles (fewer, larger groups: less partial-sum traffic). The sums are
  // integers, so the result does not depend on the grouping.
  uint i_end = min(C.n, (tg + 1u) * W.chunk);
  for (uint gid = tg * W.chunk + tid; gid < i_end; gid += tgs) {
    if (STATE[gid] != ALIVE) continue;
    float zp_center = Z[gid];
    float zp0 = zp_center - C.dz_particle / 2.0f;
    float zp1 = zp_center + C.dz_particle / 2.0f;
    int ix0 = nint_f((zp0 - C.z_min) / C.dz_slice);
    float x = X[gid], y = Y[gid], q = Q[gid];
    for (uint j = 0; j <= C.pbs + 1u; j++) {
      int ib = (int) j + ix0;                                 // 1-based bin
      if (ib < 1 || ib > (int) C.n_bin) { atomic_fetch_or_explicit(fault, 2u, memory_order_relaxed); continue; }
      uint ibl = (uint) (ib - 1);
      if (ibl < W.b0 || ibl >= W.b0 + W.nb_win) continue;
      float zb0 = C.z_min + (float) (ib - 1) * C.dz_slice;
      float zb1 = zb0 + C.dz_slice;
      float z1_over = max(zp0, zb0), z2_over = min(zp_center, zb1);
      float overlap = (z2_over > z1_over) ? 2.0f * ((z2_over - zp0) * (z2_over - zp0) - (z1_over - zp0) * (z1_over - zp0)) * C.inv_dz2 : 0.0f;
      z1_over = max(zp_center, zb0);  z2_over = min(zp1, zb1);
      if (z2_over > z1_over) overlap += 2.0f * ((z1_over - zp1) * (z1_over - zp1) - (z2_over - zp1) * (z2_over - zp1)) * C.inv_dz2;
      float charge = overlap * q;
      uint base = W.ns * (ibl - W.b0);
      if (C.pass == 1u) {
        acc_fixed_tg(sh, base,      overlap * C.scale0);
        acc_fixed_tg(sh, base + 1u, charge * C.scale1);
        acc_fixed_tg(sh, base + 2u, x * charge * C.scale2);
        acc_fixed_tg(sh, base + 3u, y * charge * C.scale3);
      } else {
        acc_fixed_tg(sh, base,      fabs(x - X0[ibl]) * charge * C.scale0);
        acc_fixed_tg(sh, base + 1u, fabs(y - Y0[ibl]) * charge * C.scale1);
      }
    }
  }
  threadgroup_barrier(mem_flags::mem_threadgroup);
  device uint* out = PART + (ulong) tg * nw;
  for (uint w = tid; w < nw; w += tgs) out[w] = atomic_load_explicit(&sh[w], memory_order_relaxed);
}

// Sum the threadgroup partials of a window in index order (64-bit modular, so the result is the same
// as a single fixed-point accumulator) into the bin sums S[8 n_bin].
kernel void csr_bins_reduce (const device uint* PART [[buffer(0)]], device uint* S [[buffer(1)]],
                             constant WinPar& W [[buffer(2)]], uint c [[thread_position_in_grid]]) {
  uint ncell = W.ns * W.nb_win;
  if (c >= ncell) return;
  uint nw = 2u * ncell;
  ulong acc = 0;
  for (uint g = 0; g < W.n_group; g++) {
    const device uint* p = PART + (ulong) g * nw + 2u * c;
    acc += ((ulong) p[1] << 32) | (ulong) p[0];
  }
  uint w = 2u * (4u * (W.b0 + c / W.ns) + c % W.ns);     // the bin sums keep 4 slots per bin
  S[w] = (uint) acc;
  S[w + 1u] = (uint) (acc >> 32);
}

kernel void csr_kick (device float* PZ [[buffer(0)]], const device float* Z [[buffer(1)]],
                      const device int* STATE [[buffer(2)]], const device float* K [[buffer(3)]],
                      constant CsrPar& C [[buffer(4)]], device atomic_uint* fault [[buffer(5)]],
                      uint gid [[thread_position_in_grid]]) {
  if (gid >= C.n) return;
  if (STATE[gid] != ALIVE) return;
  float zp = Z[gid];
  int i0 = (int) ((zp - C.zc1) / C.dz_slice) + 1;
  float r1 = (zp - (C.zc1 + (float) (i0 - 1) * C.dz_slice)) / C.dz_slice;
  if (r1 < -0.01f || r1 > 1.01f || i0 < 1 || i0 >= (int) C.n_bin) { atomic_fetch_or_explicit(fault, 4u, memory_order_relaxed); return; }
  PZ[gid] += (1.0f - r1) * K[i0 - 1] + r1 * K[i0];
}
)MSL";

//------------------------------------------------------------------------------------------------
// Host side.

struct ScParH {
  float xmin, ymin, zmin;
  float dxi, dyi, dzi;
  float dx, dy, dz;
  float kick_scale;
  float dscale, dsinv;
  float grn_scale;
  uint32_t nx, ny, nz;
  uint32_t nx2, ny2, nz2;
  uint32_t n;
  uint32_t pad;
  float dct, track_step, mass;
  uint32_t pad2;
};

struct RedParH { uint32_t n; float dct; float mass; uint32_t pad; };
struct MomParH { uint32_t n; float inv_c; float mass; uint32_t pad; float qs; float ts; float avg[5]; float pad2; };
struct CsrParH {
  uint32_t n, n_bin, pbs, pass;
  float z_min, dz_slice, dz_particle, inv_dz2;
  float scale0, scale1, scale2, scale3;
  float zc1, pad1, pad2, pad3;
};
struct WinParH { uint32_t b0, nb_win, n_group, chunk, ns, pad0, pad1, pad2; };
struct CsrSetupH { uint32_t n, n_bin, pbs, n_bin_eff; float mass, pad1, pad2, pad3; };
static const uint32_t kRedGroups = 512;

struct FftParH {
  uint32_t n, stride, bs1, count1, bs2, nl, l1_off, l2_off, tfast, woff;
  int32_t sign;
  uint32_t pad;
};

static const MTLResourceOptions kShared = MTLResourceStorageModeShared;

// Monotonic wall clock (bmad_backend_seconds reports accumulated GPU busy time instead).
static double wall_seconds (void)
{
  struct timespec ts;
  clock_gettime(CLOCK_MONOTONIC, &ts);
  return (double) ts.tv_sec + 1.0e-9 * (double) ts.tv_nsec;
}

struct Impl {
  id<MTLDevice> dev = nil;
  id<MTLCommandQueue> queue = nil;
  id<MTLLibrary> lib = nil;
  id<MTLComputePipelineState> psoZero = nil, psoDeposit = nil, psoRho = nil, psoR2C = nil, psoFft = nil;
  id<MTLComputePipelineState> psoCmul = nil, psoExtract = nil, psoKick = nil;
  id<MTLCommandBuffer> cb = nil;
  id<MTLComputeCommandEncoder> enc = nil;
  id<MTLBuffer> bX = nil, bY = nil, bZ = nil, bQ = nil, bF = nil, bPX = nil, bPY = nil, bPZ = nil;
  // bG[0]: spectrum of gx + i gy (Ex and Ey from one inverse transform), bG[1]: spectrum of gz.
  id<MTLBuffer> bRho = nil, bA = nil, bB = nil, bG[3] = {nil, nil, nil}, bE[3] = {nil, nil, nil}, bFault = nil;
  id<MTLComputePipelineState> psoExtract2 = nil, psoR2C2 = nil, psoGreen = nil;
  id<MTLBuffer> bW = nil;          // twiddle tables, one per padded dimension length
  id<MTLBuffer> bState = nil, bLoc = nil, bLost = nil, bP0c = nil, bRed = nil, bTZ0 = nil;   // resident bunch
  id<MTLBuffer> bCsrAcc = nil, bCsrX0 = nil, bCsrY0 = nil, bCsrK = nil;           // 1D CSR bins
  uint32_t n_bin_max = 0;
  id<MTLComputePipelineState> psoCsrBinsTG = nil, psoCsrReduce = nil, psoCsrKick = nil, psoCsrX0 = nil, psoRedAll = nil;
  id<MTLComputePipelineState> psoCsrLayout = nil, psoMom1 = nil, psoMom2 = nil, psoMomRed = nil, psoMomAvg = nil;
  id<MTLBuffer> bMom = nil, bMom2 = nil, bSlots = nil;   // moments partials (pass 1, pass 2) and save slots
  id<MTLBuffer> bCsrAcc2 = nil, bCsrPart = nil;   // per-threadgroup partial bin sums
  id<MTLBuffer> bCsrPar = nil, bStats = nil;      // device-written bin layout (2 passes) and statistics
  size_t csr_part_bytes = 0;

  void ensure_bins (uint32_t n_bin) {
    if (n_bin <= n_bin_max) return;
    uint32_t nb = n_bin < 1024 ? 1024 : n_bin;
    bCsrAcc = alloc((size_t) nb * 8 * 4);
    bCsrAcc2 = alloc((size_t) nb * 8 * 4);
    bCsrX0 = alloc((size_t) nb * 4);
    bCsrY0 = alloc((size_t) nb * 4);
    bCsrK = alloc((size_t) nb * 4);
    n_bin_max = nb;
  }
  id<MTLComputePipelineState> psoTrack = nil, psoRedSums = nil, psoRedBounds = nil, psoDepositR = nil, psoKickR = nil;
  int n_res = 0;                   // particles in the resident bunch
  uint32_t woff[3] = {0, 0, 0};
  uint32_t nx = 0, ny = 0, nz = 0, nx2 = 0, ny2 = 0, nz2 = 0;
  int nmax = 0;
  bool green_set = false;
  bool timing = false;
  double csr_wall = 0, csr_busy = 0;  long csr_calls = 0;   // BMAD_DEVICE_TIMING: CSR step waits
  double busy = 0;
  long n_sync = 0;
  double phase[4] = {0, 0, 0, 0};

  // With timing on, commit here and charge the busy time since the last mark to phase i.
  void mark (int i) {
    if (!timing) return;
    double before = busy;
    sync();
    phase[i] += busy - before;
  }
  size_t bytes = 0;
  char err[512];

  id<MTLBuffer> alloc (size_t n) {
    id<MTLBuffer> b = [dev newBufferWithLength:(n ? n : 16) options:kShared];
    bytes += n;
    return b;
  }

  id<MTLComputeCommandEncoder> encoder () {
    if (cb == nil) {
      cb = [queue commandBuffer];
      enc = [cb computeCommandEncoder];
    }
    return enc;
  }

  // The only place that commits. Every upload or download goes through here first.
  void sync () {
    if (cb == nil) return;
    [enc endEncoding];
    [cb commit];
    [cb waitUntilCompleted];
    busy += [cb GPUEndTime] - [cb GPUStartTime];
    n_sync++;
    if (cb.error != nil) snprintf(err, sizeof(err), "command buffer failed: %s", cb.error.localizedDescription.UTF8String);
    cb = nil;
    enc = nil;
  }

  void dispatch1d (id<MTLComputePipelineState> pso, uint32_t n) {
    id<MTLComputeCommandEncoder> e = encoder();
    [e setComputePipelineState:pso];
    NSUInteger w = pso.maxTotalThreadsPerThreadgroup < 256 ? pso.maxTotalThreadsPerThreadgroup : 256;
    [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(w, 1, 1)];
  }

  static uint32_t lines_per_group (uint32_t n) {
    uint32_t nl = 2048 / n;            // 2 * nl * n float2 of threadgroup memory = 32 KB
    if (nl * n / 2 > 1024) nl = 1024 / (n / 2);
    if (nl < 1) nl = 1;
    return nl;
  }

  // One pass of line transforms along `axis`, over l1 in [l1_off, l1_off + count1) and
  // l2 in [l2_off, l2_off + count2).
  void fft_pass (id<MTLBuffer> buf, int axis, int sign, uint32_t l1_off, uint32_t count1, uint32_t l2_off, uint32_t count2) {
    id<MTLComputeCommandEncoder> e = encoder();
    uint32_t axes_n[3] = {nx2, ny2, nz2};
    FftParH F;
    memset(&F, 0, sizeof(F));
    F.n = axes_n[axis];
    F.sign = sign;
    F.woff = woff[axis];
    if (axis == 0)      { F.stride = 1;         F.bs1 = nx2; F.bs2 = nx2 * ny2; F.tfast = 1; }
    else if (axis == 1) { F.stride = nx2;       F.bs1 = 1;   F.bs2 = nx2 * ny2; F.tfast = 0; }
    else                { F.stride = nx2 * ny2; F.bs1 = 1;   F.bs2 = nx2;       F.tfast = 0; }
    uint32_t nl = lines_per_group(F.n);
    while (count1 % nl != 0) nl /= 2;
    while (nl > 1 && nl * F.n / 2 > psoFft.maxTotalThreadsPerThreadgroup) nl /= 2;
    F.nl = nl;
    F.count1 = count1;
    F.l1_off = l1_off;
    F.l2_off = l2_off;
    [e setComputePipelineState:psoFft];
    [e setBuffer:buf offset:0 atIndex:0];
    [e setBytes:&F length:sizeof(F) atIndex:1];
    [e setBuffer:bW offset:0 atIndex:2];
    [e dispatchThreadgroups:MTLSizeMake((count1 / nl) * count2, 1, 1) threadsPerThreadgroup:MTLSizeMake(nl * F.n / 2, 1, 1)];
  }

  // Forward 3D FFT of a padded array whose data occupy the first nx*ny*nz octant: lines that are
  // entirely zero are skipped (x pass: 1/4 of the lines, y pass: 1/2).
  void fft3d_forward_padded (id<MTLBuffer> buf) {
    fft_pass(buf, 0, -1, 0, ny, 0, nz);
    fft_pass(buf, 1, -1, 0, nx2, 0, nz);
    fft_pass(buf, 2, -1, 0, nx2, 0, ny2);
  }

  // Full forward 3D FFT (Green functions).
  void fft3d_forward_full (id<MTLBuffer> buf) {
    fft_pass(buf, 0, -1, 0, ny2, 0, nz2);
    fft_pass(buf, 1, -1, 0, nx2, 0, nz2);
    fft_pass(buf, 2, -1, 0, nx2, 0, ny2);
  }

  // Backward 3D FFT of which only the octant [nx-1, 2nx-1) x [ny-1, 2ny-1) x [nz-1, 2nz-1) is read:
  // the y pass needs only the k of that octant and the x pass only its (j, k).
  void fft3d_backward_octant (id<MTLBuffer> buf) {
    fft_pass(buf, 2, +1, 0, nx2, 0, ny2);
    fft_pass(buf, 1, +1, 0, nx2, nz - 1, nz);
    fft_pass(buf, 0, +1, ny - 1, ny, nz - 1, nz);
  }
};

static Impl *gImpl = NULL;

static void put_reason (char *reason, int reason_len, const char *text)
{
  if (reason == NULL || reason_len <= 0) return;
  snprintf(reason, (size_t) reason_len, "%s", text);
}

static bool is_pow2 (uint32_t n) { return n != 0 && (n & (n - 1)) == 0; }

extern "C" {

int bmad_backend_available (char *reason, int reason_len)
{
  @autoreleasepool {
    id<MTLDevice> dev = MTLCreateSystemDefaultDevice();
    if (dev == nil) { put_reason(reason, reason_len, "no Metal device"); return 1; }
    if (!dev.hasUnifiedMemory) { put_reason(reason, reason_len, "Metal device without unified memory is not supported"); return 1; }
    return 0;
  }
}

int bmad_backend_init (int n_particle_max, const int32_t mesh_n[3], char *reason, int reason_len)
{
  @autoreleasepool {
    if (gImpl != NULL) bmad_backend_close();
    Impl *p = new Impl();
    p->err[0] = '\0';
    p->dev = MTLCreateSystemDefaultDevice();
    if (p->dev == nil) { put_reason(reason, reason_len, "no Metal device"); delete p; return 1; }
    p->queue = [p->dev newCommandQueue];

    p->nx = (uint32_t) mesh_n[0]; p->ny = (uint32_t) mesh_n[1]; p->nz = (uint32_t) mesh_n[2];
    p->nx2 = 2 * p->nx; p->ny2 = 2 * p->ny; p->nz2 = 2 * p->nz;
    if (!is_pow2(p->nx2) || !is_pow2(p->ny2) || !is_pow2(p->nz2) || p->nx2 > 1024 || p->ny2 > 1024 || p->nz2 > 1024) {
      put_reason(reason, reason_len, "space charge mesh sizes must be powers of two of at most 512");
      delete p; return 1;
    }

    MTLCompileOptions *opt = [MTLCompileOptions new];
    opt.fastMathEnabled = NO;
    NSError *nserr = nil;
    p->lib = [p->dev newLibraryWithSource:[NSString stringWithUTF8String:kMSL] options:opt error:&nserr];
    if (p->lib == nil) {
      snprintf(p->err, sizeof(p->err), "shader compile failed: %s", nserr ? nserr.localizedDescription.UTF8String : "?");
      put_reason(reason, reason_len, p->err); delete p; return 1;
    }
    bool ok = true;
    auto pso = [&](NSString *name) -> id<MTLComputePipelineState> {
      id<MTLFunction> f = [p->lib newFunctionWithName:name];
      if (f == nil) { ok = false; snprintf(p->err, sizeof(p->err), "missing kernel %s", name.UTF8String); return nil; }
      NSError *e = nil;
      id<MTLComputePipelineState> s = [p->dev newComputePipelineStateWithFunction:f error:&e];
      if (s == nil) { ok = false; snprintf(p->err, sizeof(p->err), "pipeline %s: %s", name.UTF8String, e ? e.localizedDescription.UTF8String : "?"); }
      return s;
    };
    p->psoZero = pso(@"zero_u32");
    p->psoDeposit = pso(@"deposit");
    p->psoRho = pso(@"rho_to_complex");
    p->psoR2C = pso(@"real_to_complex");
    p->psoFft = pso(@"fft_lines");
    p->psoCmul = pso(@"cmul");
    p->psoExtract = pso(@"extract");
    p->psoExtract2 = pso(@"extract2");
    p->psoR2C2 = pso(@"reals_to_complex");
    p->psoGreen = pso(@"expand_green");
    p->psoKick = pso(@"interp_kick");
    p->psoTrack = pso(@"track_slice");
    p->psoRedSums = pso(@"reduce_sums");
    p->psoRedBounds = pso(@"reduce_bounds");
    p->psoDepositR = pso(@"deposit_r");
    p->psoKickR = pso(@"interp_kick_r");
    p->psoCsrBinsTG = pso(@"csr_bins_tg");
    p->psoCsrReduce = pso(@"csr_bins_reduce");
    p->psoCsrLayout = pso(@"csr_layout");
    p->psoMom1 = pso(@"moments1");
    p->psoMomRed = pso(@"mom_reduce");
    p->psoMomAvg = pso(@"mom_avg");
    p->psoMom2 = pso(@"moments2");
    p->psoCsrKick = pso(@"csr_kick");
    p->psoCsrX0 = pso(@"csr_x0");
    p->psoRedAll = pso(@"reduce_all");
    if (!ok) { put_reason(reason, reason_len, p->err); delete p; return 1; }

    size_t np = (size_t) (n_particle_max > 0 ? n_particle_max : 1);
    size_t nm = (size_t) p->nx * p->ny * p->nz;
    size_t nm2 = (size_t) p->nx2 * p->ny2 * p->nz2;
    p->nmax = (int) np;
    p->bX = p->alloc(np * 4);  p->bY = p->alloc(np * 4);  p->bZ = p->alloc(np * 4);  p->bQ = p->alloc(np * 4);
    p->bF = p->alloc(np * 4);  p->bPX = p->alloc(np * 4); p->bPY = p->alloc(np * 4); p->bPZ = p->alloc(np * 4);
    p->bState = p->alloc(np * 4); p->bLoc = p->alloc(np * 4); p->bLost = p->alloc(np * 4); p->bP0c = p->alloc(np * 4);
    p->bTZ0 = p->alloc(np * 4);
    p->bRed = p->alloc((size_t) kRedGroups * 9 * 4);
    p->bCsrPar = p->alloc(2 * sizeof(CsrParH));
    p->bStats = p->alloc(16 * 4);
    p->bMom = p->alloc((size_t) kRedGroups * 25 * 4);
    p->bMom2 = p->alloc((size_t) kRedGroups * 22 * 4);
    p->bSlots = p->alloc((size_t) BMAD_DEV_MOM_SLOTS * BMAD_DEV_MOM_STRIDE * 4);
    p->bRho = p->alloc(nm * 8);
    p->bA = p->alloc(nm2 * 8);
    p->bB = p->alloc(nm2 * 8);
    for (int c = 0; c < 2; c++) p->bG[c] = p->alloc(nm2 * 8);
    for (int c = 0; c < 3; c++) p->bE[c] = p->alloc(nm * 4);
    p->bFault = p->alloc(4);
    memset(p->bFault.contents, 0, 4);
    {
      uint32_t lens[3] = {p->nx2, p->ny2, p->nz2};
      uint32_t total = 0;
      for (int a = 0; a < 3; a++) { p->woff[a] = total; total += lens[a] / 2; }
      p->bW = p->alloc((size_t) total * 8);
      float *w = (float *) p->bW.contents;
      for (int a = 0; a < 3; a++)
        for (uint32_t m = 0; m < lens[a] / 2; m++) {
          double ang = -2.0 * M_PI * (double) m / (double) lens[a];
          w[2 * (p->woff[a] + m)] = (float) cos(ang);
          w[2 * (p->woff[a] + m) + 1] = (float) sin(ang);
        }
    }
    p->timing = (getenv("BMAD_DEVICE_TIMING") != NULL);
    gImpl = p;
    return 0;
  }
}

void bmad_backend_close (void)
{
  if (gImpl != NULL && gImpl->timing && gImpl->csr_calls > 0)
    fprintf(stderr, "bmad_metal timing: csr_step calls %ld, wait %.3f s (%.3f ms/call), GPU busy %.3f s (%.3f ms/call)\n",
            gImpl->csr_calls, gImpl->csr_wall, 1e3 * gImpl->csr_wall / gImpl->csr_calls, gImpl->csr_busy, 1e3 * gImpl->csr_busy / gImpl->csr_calls);
  @autoreleasepool {
    if (gImpl == NULL) return;
    gImpl->sync();
    delete gImpl;
    gImpl = NULL;
  }
}

int bmad_backend_set_green (const float *gx, const float *gy, const float *gz, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    uint32_t nm = p->nx * p->ny * p->nz, nm2 = p->nx2 * p->ny2 * p->nz2;
    // The three octants go side by side into bA (2*nm2 floats = 16 nm >= 3 nm).
    p->sync();
    size_t nb = (size_t) nm * 4;
    memcpy(p->bA.contents, gx, nb);
    memcpy((char *) p->bA.contents + nb, gy, nb);
    memcpy((char *) p->bA.contents + 2 * nb, gz, nb);
    for (uint32_t pair = 1; ; pair = 0) {
      struct { uint32_t nx, ny, nz, pair; } Q = {p->nx, p->ny, p->nz, pair};
      id<MTLBuffer> dst = pair ? p->bG[0] : p->bG[1];
      id<MTLComputeCommandEncoder> e = p->encoder();
      [e setComputePipelineState:p->psoGreen];
      [e setBuffer:p->bA offset:0 atIndex:0];
      [e setBuffer:p->bA offset:nb atIndex:1];
      [e setBuffer:p->bA offset:2 * nb atIndex:2];
      [e setBuffer:dst offset:0 atIndex:3];
      [e setBytes:&Q length:sizeof(Q) atIndex:4];
      [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      p->fft3d_forward_full(dst);
      if (pair == 0) break;
    }
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    p->green_set = true;
    return 0;
  }
}

int bmad_backend_sc_step (const bmad_dev_sc_par *par, const float *x, const float *y, const float *z, const float *q,
                          const float *factor, float *px, float *py, float *pz, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (!p->green_set) { put_reason(reason, reason_len, "Green function not set"); return 1; }
    int n = par->n;
    if (n < 0 || n > p->nmax) { put_reason(reason, reason_len, "particle count exceeds the device allocation"); return 1; }

    // Fixed-point scale: the largest cell charge cannot exceed the total, keep it below 2^62.
    double qabs = par->q_total_abs > 0 ? par->q_total_abs : 1.0;
    double dscale = ldexp(1.0, 62 - (int) ceil(log2(qabs)) - 1);

    ScParH P;
    memset(&P, 0, sizeof(P));
    P.xmin = (float) par->mesh_min[0]; P.ymin = (float) par->mesh_min[1]; P.zmin = (float) par->mesh_min[2];
    P.dx = (float) par->delta[0]; P.dy = (float) par->delta[1]; P.dz = (float) par->delta[2];
    P.dxi = (float) (1.0 / par->delta[0]); P.dyi = (float) (1.0 / par->delta[1]); P.dzi = (float) (1.0 / par->delta[2]);
    P.kick_scale = (float) par->kick_scale;
    P.dscale = (float) dscale;
    P.dsinv = (float) (1.0 / dscale);
    P.grn_scale = (float) par->grn_scale;
    P.nx = p->nx; P.ny = p->ny; P.nz = p->nz;
    P.nx2 = p->nx2; P.ny2 = p->ny2; P.nz2 = p->nz2;
    P.n = (uint32_t) n;

    p->sync();
    if (n > 0) {
      memcpy(p->bX.contents, x, (size_t) n * 4);  memcpy(p->bY.contents, y, (size_t) n * 4);
      memcpy(p->bZ.contents, z, (size_t) n * 4);  memcpy(p->bQ.contents, q, (size_t) n * 4);
      memcpy(p->bF.contents, factor, (size_t) n * 4);
      memcpy(p->bPX.contents, px, (size_t) n * 4); memcpy(p->bPY.contents, py, (size_t) n * 4);
      memcpy(p->bPZ.contents, pz, (size_t) n * 4);
    }

    uint32_t nm = p->nx * p->ny * p->nz;
    uint32_t nm2 = p->nx2 * p->ny2 * p->nz2;
    uint32_t nwords = 2 * nm;

    id<MTLComputeCommandEncoder> e = p->encoder();
    [e setComputePipelineState:p->psoZero];
    [e setBuffer:p->bRho offset:0 atIndex:0];
    [e setBytes:&nwords length:4 atIndex:1];
    [e dispatchThreads:MTLSizeMake(nwords, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];

    if (n > 0) {
      [e setComputePipelineState:p->psoDeposit];
      [e setBuffer:p->bRho offset:0 atIndex:0];
      [e setBuffer:p->bX offset:0 atIndex:1]; [e setBuffer:p->bY offset:0 atIndex:2];
      [e setBuffer:p->bZ offset:0 atIndex:3]; [e setBuffer:p->bQ offset:0 atIndex:4];
      [e setBytes:&P length:sizeof(P) atIndex:5];
      [e setBuffer:p->bFault offset:0 atIndex:6];
      [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    }

    [e setComputePipelineState:p->psoRho];
    [e setBuffer:p->bRho offset:0 atIndex:0];
    [e setBuffer:p->bA offset:0 atIndex:1];
    [e setBytes:&P length:sizeof(P) atIndex:2];
    [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    p->mark(0);

    p->fft3d_forward_padded(p->bA);
    p->mark(1);

    for (int c = 0; c < 2; c++) {
      e = p->encoder();
      [e setComputePipelineState:p->psoCmul];
      [e setBuffer:p->bA offset:0 atIndex:0];
      [e setBuffer:p->bG[c] offset:0 atIndex:1];
      [e setBuffer:p->bB offset:0 atIndex:2];
      [e setBytes:&nm2 length:4 atIndex:3];
      [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      p->fft3d_backward_octant(p->bB);
      e = p->encoder();
      if (c == 0) {
        [e setComputePipelineState:p->psoExtract2];
        [e setBuffer:p->bB offset:0 atIndex:0];
        [e setBuffer:p->bE[0] offset:0 atIndex:1];
        [e setBuffer:p->bE[1] offset:0 atIndex:2];
        [e setBytes:&P length:sizeof(P) atIndex:3];
      } else {
        [e setComputePipelineState:p->psoExtract];
        [e setBuffer:p->bB offset:0 atIndex:0];
        [e setBuffer:p->bE[2] offset:0 atIndex:1];
        [e setBytes:&P length:sizeof(P) atIndex:2];
      }
      [e dispatchThreads:MTLSizeMake(nm, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    }
    p->mark(2);

    if (n > 0) {
      e = p->encoder();
      [e setComputePipelineState:p->psoKick];
      [e setBuffer:p->bE[0] offset:0 atIndex:0]; [e setBuffer:p->bE[1] offset:0 atIndex:1]; [e setBuffer:p->bE[2] offset:0 atIndex:2];
      [e setBuffer:p->bX offset:0 atIndex:3]; [e setBuffer:p->bY offset:0 atIndex:4]; [e setBuffer:p->bZ offset:0 atIndex:5];
      [e setBuffer:p->bF offset:0 atIndex:6];
      [e setBuffer:p->bPX offset:0 atIndex:7]; [e setBuffer:p->bPY offset:0 atIndex:8]; [e setBuffer:p->bPZ offset:0 atIndex:9];
      [e setBytes:&P length:sizeof(P) atIndex:10];
      [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    }

    p->mark(3);
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    if (n > 0) {
      memcpy(px, p->bPX.contents, (size_t) n * 4);
      memcpy(py, p->bPY.contents, (size_t) n * 4);
      memcpy(pz, p->bPZ.contents, (size_t) n * 4);
    }
    return 0;
  }
}

int bmad_backend_get_field (int comp, float *E, char *reason, int reason_len)
{
  Impl *p = gImpl;
  if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
  if (comp < 1 || comp > 3) { put_reason(reason, reason_len, "comp must be 1..3"); return 1; }
  p->sync();
  memcpy(E, p->bE[comp - 1].contents, (size_t) p->nx * p->ny * p->nz * 4);
  return 0;
}

double bmad_backend_seconds (void)
{
  return gImpl ? gImpl->busy : 0.0;
}

void bmad_backend_timing (double *t)
{
  for (int i = 0; i < 4; i++) t[i] = gImpl ? gImpl->phase[i] : 0;
}

int bmad_backend_fault (void)
{
  if (gImpl == NULL) return 0;
  gImpl->sync();
  uint32_t *f = (uint32_t *) gImpl->bFault.contents;
  int v = (int) *f;
  *f = 0;
  return v;
}


// ------------------------------------------------------------------------------------------------ resident bunch

int bmad_backend_bunch_upload (int n, const float *x, const float *px, const float *y, const float *py,
                               const float *z, const float *pz, const int32_t *state, const float *q,
                               const float *p0c, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (n < 0 || n > p->nmax) { put_reason(reason, reason_len, "particle count exceeds the device allocation"); return 1; }
    p->sync();
    size_t nb = (size_t) n * 4;
    memcpy(p->bX.contents, x, nb);   memcpy(p->bPX.contents, px, nb);
    memcpy(p->bY.contents, y, nb);   memcpy(p->bPY.contents, py, nb);
    memcpy(p->bZ.contents, z, nb);   memcpy(p->bPZ.contents, pz, nb);
    memcpy(p->bState.contents, state, nb);
    memcpy(p->bQ.contents, q, nb);   memcpy(p->bP0c.contents, p0c, nb);
    memset(p->bLoc.contents, 0, nb); memset(p->bLost.contents, 0, nb);
    p->n_res = n;
    return 0;
  }
}

int bmad_backend_bunch_set_tz0 (int n, const float *tz0, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (n != p->n_res) { put_reason(reason, reason_len, "tz0 size differs from the resident bunch"); return 1; }
    p->sync();
    memcpy(p->bTZ0.contents, tz0, (size_t) n * 4);
    return 0;
  }
}

int bmad_backend_bunch_download (int n, float *x, float *px, float *y, float *py, float *z, float *pz,
                                 int32_t *state, int32_t *loc, int32_t *lost_tag, float *p0c, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (n != p->n_res) { put_reason(reason, reason_len, "download size differs from the resident bunch"); return 1; }
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    size_t nb = (size_t) n * 4;
    memcpy(x, p->bX.contents, nb);   memcpy(px, p->bPX.contents, nb);
    memcpy(y, p->bY.contents, nb);   memcpy(py, p->bPY.contents, nb);
    memcpy(z, p->bZ.contents, nb);   memcpy(pz, p->bPZ.contents, nb);
    memcpy(state, p->bState.contents, nb);
    memcpy(loc, p->bLoc.contents, nb);
    memcpy(lost_tag, p->bLost.contents, nb);
    memcpy(p0c, p->bP0c.contents, nb);
    memset(p->bLoc.contents, 0, nb);     // the next download reports only particles touched after this one
    return 0;
  }
}

int bmad_backend_track_slice (const bmad_dev_slice_par *par, const bmad_dev_rf_step *rf, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    uint32_t n = (uint32_t) p->n_res;
    if (n == 0) return 0;
    id<MTLComputeCommandEncoder> e = p->encoder();
    [e setComputePipelineState:p->psoTrack];
    [e setBuffer:p->bX offset:0 atIndex:0];  [e setBuffer:p->bPX offset:0 atIndex:1];
    [e setBuffer:p->bY offset:0 atIndex:2];  [e setBuffer:p->bPY offset:0 atIndex:3];
    [e setBuffer:p->bZ offset:0 atIndex:4];  [e setBuffer:p->bPZ offset:0 atIndex:5];
    [e setBuffer:p->bState offset:0 atIndex:6]; [e setBuffer:p->bLoc offset:0 atIndex:7];
    [e setBuffer:p->bLost offset:0 atIndex:8]; [e setBuffer:p->bP0c offset:0 atIndex:9];
    [e setBytes:par length:sizeof(bmad_dev_slice_par) atIndex:10];
    [e setBytes:&n length:4 atIndex:11];
    [e setBuffer:p->bTZ0 offset:0 atIndex:12];
    {
      static const bmad_dev_rf_step dummy = {0, 0, 0, 0, 0, 0, 0, 0};
      int nrf = (par->kind == 6 && rf != NULL) ? par->rf_n : 0;
      if (nrf > BMAD_DEV_MAX_RF) { put_reason(reason, reason_len, "too many RF steps"); return 1; }
      if (nrf > 0) [e setBytes:rf length:(NSUInteger) nrf * sizeof(bmad_dev_rf_step) atIndex:13];
      else         [e setBytes:&dummy length:sizeof(dummy) atIndex:13];
    }
    [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    return 0;
  }
}

static void reduce_dispatch (Impl *p, id<MTLComputePipelineState> pso, const RedParH *R, bool bounds)
{
  id<MTLComputeCommandEncoder> e = p->encoder();
  [e setComputePipelineState:pso];
  if (!bounds) {
    [e setBuffer:p->bZ offset:0 atIndex:0]; [e setBuffer:p->bPZ offset:0 atIndex:1];
    [e setBuffer:p->bQ offset:0 atIndex:2]; [e setBuffer:p->bP0c offset:0 atIndex:3];
    [e setBuffer:p->bState offset:0 atIndex:4]; [e setBuffer:p->bRed offset:0 atIndex:5];
    [e setBytes:R length:sizeof(*R) atIndex:6];
  } else {
    [e setBuffer:p->bX offset:0 atIndex:0]; [e setBuffer:p->bY offset:0 atIndex:1];
    [e setBuffer:p->bZ offset:0 atIndex:2]; [e setBuffer:p->bPZ offset:0 atIndex:3];
    [e setBuffer:p->bP0c offset:0 atIndex:4]; [e setBuffer:p->bState offset:0 atIndex:5];
    [e setBuffer:p->bRed offset:0 atIndex:6]; [e setBytes:R length:sizeof(*R) atIndex:7];
  }
  [e dispatchThreadgroups:MTLSizeMake(kRedGroups, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
}

int bmad_backend_bunch_sums (double mass, double out[3], char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    RedParH R = {(uint32_t) p->n_res, 0.0f, (float) mass, 0};
    reduce_dispatch(p, p->psoRedSums, &R, false);
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    const float *r = (const float *) p->bRed.contents;
    out[0] = out[1] = out[2] = 0;
    for (uint32_t g = 0; g < kRedGroups; g++) { out[0] += r[3 * g]; out[1] += r[3 * g + 1]; out[2] += r[3 * g + 2]; }
    return 0;
  }
}

int bmad_backend_bunch_bounds (double mass, double dct, double out[6], char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    RedParH R = {(uint32_t) p->n_res, (float) dct, (float) mass, 0};
    reduce_dispatch(p, p->psoRedBounds, &R, true);
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    const float *r = (const float *) p->bRed.contents;
    for (int k = 0; k < 3; k++) { out[k] = 3.0e38; out[3 + k] = -3.0e38; }
    for (uint32_t g = 0; g < kRedGroups; g++)
      for (int k = 0; k < 3; k++) {
        if (r[6 * g + k] < out[k]) out[k] = r[6 * g + k];
        if (r[6 * g + 3 + k] > out[3 + k]) out[3 + k] = r[6 * g + 3 + k];
      }
    return 0;
  }
}

int bmad_backend_sc_step_resident (const bmad_dev_sc_par *par, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    {
      static int busy_on = -1;  static long n_calls = 0;  static double t_start = 0;
      if (busy_on < 0) { busy_on = (getenv("BMAD_DEVICE_BUSY") != NULL); t_start = wall_seconds(); }
      if (busy_on && p != NULL && (++n_calls % 500) == 0)
        fprintf(stderr, "bmad_metal busy: sc steps %ld, wall since the first %.3f s, GPU busy %.3f s, command buffers %ld\n",
                n_calls, wall_seconds() - t_start, p->busy, p->n_sync);
    }
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (!p->green_set) { put_reason(reason, reason_len, "Green function not set"); return 1; }
    uint32_t n = (uint32_t) p->n_res;

    double qabs = par->q_total_abs > 0 ? par->q_total_abs : 1.0;
    double dscale = ldexp(1.0, 62 - (int) ceil(log2(qabs)) - 1);
    ScParH P;
    memset(&P, 0, sizeof(P));
    P.xmin = (float) par->mesh_min[0]; P.ymin = (float) par->mesh_min[1]; P.zmin = (float) par->mesh_min[2];
    P.dx = (float) par->delta[0]; P.dy = (float) par->delta[1]; P.dz = (float) par->delta[2];
    P.dxi = (float) (1.0 / par->delta[0]); P.dyi = (float) (1.0 / par->delta[1]); P.dzi = (float) (1.0 / par->delta[2]);
    P.kick_scale = (float) par->kick_scale;
    P.dscale = (float) dscale;
    P.dsinv = (float) (1.0 / dscale);
    P.grn_scale = (float) par->grn_scale;
    P.nx = p->nx; P.ny = p->ny; P.nz = p->nz;
    P.nx2 = p->nx2; P.ny2 = p->ny2; P.nz2 = p->nz2;
    P.n = n;
    P.dct = (float) par->dct_ave;
    P.track_step = (float) par->track_step;
    P.mass = (float) par->mass;

    uint32_t nm = p->nx * p->ny * p->nz;
    uint32_t nm2 = p->nx2 * p->ny2 * p->nz2;
    uint32_t nwords = 2 * nm;

    id<MTLComputeCommandEncoder> e = p->encoder();
    [e setComputePipelineState:p->psoZero];
    [e setBuffer:p->bRho offset:0 atIndex:0];
    [e setBytes:&nwords length:4 atIndex:1];
    [e dispatchThreads:MTLSizeMake(nwords, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];

    if (n > 0) {
      [e setComputePipelineState:p->psoDepositR];
      [e setBuffer:p->bRho offset:0 atIndex:0];
      [e setBuffer:p->bX offset:0 atIndex:1]; [e setBuffer:p->bY offset:0 atIndex:2];
      [e setBuffer:p->bZ offset:0 atIndex:3]; [e setBuffer:p->bQ offset:0 atIndex:4];
      [e setBuffer:p->bPZ offset:0 atIndex:5]; [e setBuffer:p->bP0c offset:0 atIndex:6];
      [e setBuffer:p->bState offset:0 atIndex:7];
      [e setBytes:&P length:sizeof(P) atIndex:8];
      [e setBuffer:p->bFault offset:0 atIndex:9];
      [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    }

    [e setComputePipelineState:p->psoRho];
    [e setBuffer:p->bRho offset:0 atIndex:0];
    [e setBuffer:p->bA offset:0 atIndex:1];
    [e setBytes:&P length:sizeof(P) atIndex:2];
    [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    p->mark(0);

    p->fft3d_forward_padded(p->bA);
    p->mark(1);

    for (int c = 0; c < 2; c++) {
      e = p->encoder();
      [e setComputePipelineState:p->psoCmul];
      [e setBuffer:p->bA offset:0 atIndex:0];
      [e setBuffer:p->bG[c] offset:0 atIndex:1];
      [e setBuffer:p->bB offset:0 atIndex:2];
      [e setBytes:&nm2 length:4 atIndex:3];
      [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      p->fft3d_backward_octant(p->bB);
      e = p->encoder();
      if (c == 0) {
        [e setComputePipelineState:p->psoExtract2];
        [e setBuffer:p->bB offset:0 atIndex:0];
        [e setBuffer:p->bE[0] offset:0 atIndex:1];
        [e setBuffer:p->bE[1] offset:0 atIndex:2];
        [e setBytes:&P length:sizeof(P) atIndex:3];
      } else {
        [e setComputePipelineState:p->psoExtract];
        [e setBuffer:p->bB offset:0 atIndex:0];
        [e setBuffer:p->bE[2] offset:0 atIndex:1];
        [e setBytes:&P length:sizeof(P) atIndex:2];
      }
      [e dispatchThreads:MTLSizeMake(nm, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    }
    p->mark(2);

    if (n > 0) {
      e = p->encoder();
      [e setComputePipelineState:p->psoKickR];
      [e setBuffer:p->bE[0] offset:0 atIndex:0]; [e setBuffer:p->bE[1] offset:0 atIndex:1]; [e setBuffer:p->bE[2] offset:0 atIndex:2];
      [e setBuffer:p->bX offset:0 atIndex:3]; [e setBuffer:p->bY offset:0 atIndex:4]; [e setBuffer:p->bZ offset:0 atIndex:5];
      [e setBuffer:p->bP0c offset:0 atIndex:6];
      [e setBuffer:p->bPX offset:0 atIndex:7]; [e setBuffer:p->bPY offset:0 atIndex:8]; [e setBuffer:p->bPZ offset:0 atIndex:9];
      [e setBuffer:p->bState offset:0 atIndex:10];
      [e setBytes:&P length:sizeof(P) atIndex:11];
      [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    }
    p->mark(3);
    return 0;
  }
}


// ------------------------------------------------------------------------------------------------ 1D CSR

static void csr_par_fill (CsrParH *C, const bmad_dev_csr_par *par, uint32_t n)
{
  memset(C, 0, sizeof(*C));
  C->n = n; C->n_bin = (uint32_t) par->n_bin; C->pbs = (uint32_t) par->pbs; C->pass = (uint32_t) par->pass;
  C->z_min = (float) par->z_min; C->dz_slice = (float) par->dz_slice; C->dz_particle = (float) par->dz_particle;
  C->inv_dz2 = (float) (1.0 / (par->dz_particle * par->dz_particle));
  C->scale0 = (float) par->scale[0]; C->scale1 = (float) par->scale[1]; C->scale2 = (float) par->scale[2]; C->scale3 = (float) par->scale[3];
  C->zc1 = (float) par->zc1;
}

// One binning pass over the resident bunch into acc[8 n_bin] (fixed point, two words per sum), by bin
// windows that fit the threadgroup memory (32 bytes per bin).
static void csr_encode_pass (Impl *p, id<MTLComputeCommandEncoder> e, uint32_t n, uint32_t nbin, uint32_t pass, id<MTLBuffer> acc)
{
  NSUInteger par_off = (NSUInteger) (pass - 1) * sizeof(CsrParH);
  WinParH W = {0, 0, 0, 0, 0, 0, 0, 0};
  W.ns = (pass == 1) ? 4u : 2u;                 // sums per bin: pass 2 needs only two, so its windows are twice as wide
  NSUInteger tgs = p->psoCsrBinsTG.maxTotalThreadsPerThreadgroup;
  if (tgs > 1024) tgs = 1024;
  // About 256 threadgroups, each looping over a chunk of particles.
  uint32_t per = (uint32_t) tgs * ((n + (uint32_t) tgs * 256u - 1u) / ((uint32_t) tgs * 256u));
  if (per < (uint32_t) tgs) per = (uint32_t) tgs;
  uint32_t ngroup = (n + per - 1) / per;
  W.chunk = per;
  uint32_t win_max = (uint32_t) (p->dev.maxThreadgroupMemoryLength / (8u * W.ns));
  static int win_env = -1;                      // BMAD_DEVICE_CSR_WIN: smaller windows, for testing the window path
  if (win_env < 0) { const char *ev = getenv("BMAD_DEVICE_CSR_WIN"); win_env = ev ? atoi(ev) : 0; }
  if (win_env > 0 && win_max > (uint32_t) win_env) win_max = (uint32_t) win_env;
  if (win_max < 1) win_max = 1;
  uint32_t win = nbin < win_max ? nbin : win_max;
  size_t part_bytes = (size_t) ngroup * 2 * W.ns * win * 4;
  if (part_bytes > p->csr_part_bytes) { p->bCsrPart = p->alloc(part_bytes); p->csr_part_bytes = part_bytes; }
  for (uint32_t b0 = 0; b0 < nbin; b0 += win) {
    W.b0 = b0;  W.nb_win = (nbin - b0 < win) ? nbin - b0 : win;  W.n_group = ngroup;
    [e setComputePipelineState:p->psoCsrBinsTG];
    [e setBuffer:p->bX offset:0 atIndex:0]; [e setBuffer:p->bY offset:0 atIndex:1];
    [e setBuffer:p->bZ offset:0 atIndex:2]; [e setBuffer:p->bQ offset:0 atIndex:3];
    [e setBuffer:p->bState offset:0 atIndex:4]; [e setBuffer:p->bCsrPart offset:0 atIndex:5];
    [e setBuffer:p->bCsrX0 offset:0 atIndex:6]; [e setBuffer:p->bCsrY0 offset:0 atIndex:7];
    [e setBuffer:p->bCsrPar offset:par_off atIndex:8];
    [e setBuffer:p->bFault offset:0 atIndex:9];
    [e setBytes:&W length:sizeof(W) atIndex:10];
    [e setThreadgroupMemoryLength:(NSUInteger) W.nb_win * 8 * W.ns atIndex:0];
    [e dispatchThreadgroups:MTLSizeMake(ngroup, 1, 1) threadsPerThreadgroup:MTLSizeMake(tgs, 1, 1)];
    [e setComputePipelineState:p->psoCsrReduce];
    [e setBuffer:p->bCsrPart offset:0 atIndex:0]; [e setBuffer:acc offset:0 atIndex:1];
    [e setBytes:&W length:sizeof(W) atIndex:2];
    [e dispatchThreads:MTLSizeMake(W.ns * W.nb_win, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
  }
}

int bmad_backend_moments_enqueue (double mass, double qs, int slot, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (slot < 0 || slot >= BMAD_DEV_MOM_SLOTS) { put_reason(reason, reason_len, "moments slot out of range"); return 1; }
    MomParH M;
    memset(&M, 0, sizeof(M));
    M.n = (uint32_t) p->n_res;  M.inv_c = (float) (1.0 / 299792458.0);  M.mass = (float) mass;
    M.qs = (float) qs;  M.ts = (float) BMAD_DEV_MOM_TSCALE;
    NSUInteger soff = (NSUInteger) slot * BMAD_DEV_MOM_STRIDE * 4;
    id<MTLComputeCommandEncoder> e = p->encoder();
    for (int pass = 1; pass <= 2; pass++) {
      id<MTLBuffer> part = (pass == 1) ? p->bMom : p->bMom2;
      [e setComputePipelineState:(pass == 1) ? p->psoMom1 : p->psoMom2];
      [e setBuffer:p->bX offset:0 atIndex:0]; [e setBuffer:p->bPX offset:0 atIndex:1];
      [e setBuffer:p->bY offset:0 atIndex:2]; [e setBuffer:p->bPY offset:0 atIndex:3];
      [e setBuffer:p->bZ offset:0 atIndex:4]; [e setBuffer:p->bPZ offset:0 atIndex:5];
      [e setBuffer:p->bP0c offset:0 atIndex:6]; [e setBuffer:p->bState offset:0 atIndex:7];
      [e setBuffer:p->bQ offset:0 atIndex:8]; [e setBuffer:p->bTZ0 offset:0 atIndex:9];
      [e setBuffer:part offset:0 atIndex:10];
      [e setBytes:&M length:sizeof(M) atIndex:11];
      [e setBuffer:p->bSlots offset:soff + 50 * 4 atIndex:12];
      [e dispatchThreadgroups:MTLSizeMake(kRedGroups, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      struct { uint32_t ng, nk, n_sum, n_min, off, pad0, pad1, pad2; } R =
        {kRedGroups, (pass == 1) ? 25u : 22u, (pass == 1) ? 11u : 22u, (pass == 1) ? 7u : 0u, (pass == 1) ? 0u : 64u, 0, 0, 0};
      [e setComputePipelineState:p->psoMomRed];
      [e setBuffer:part offset:0 atIndex:0];
      [e setBuffer:p->bSlots offset:soff atIndex:1];
      [e setBytes:&R length:sizeof(R) atIndex:2];
      [e dispatchThreadgroups:MTLSizeMake(R.nk, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      if (pass == 1) {
        [e setComputePipelineState:p->psoMomAvg];
        [e setBuffer:p->bSlots offset:soff atIndex:0];
        [e dispatchThreads:MTLSizeMake(7, 1, 1) threadsPerThreadgroup:MTLSizeMake(32, 1, 1)];
      }
    }
    return 0;
  }
}

int bmad_backend_moments_read (int n_slot, double *out, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    if (n_slot < 0 || n_slot > BMAD_DEV_MOM_SLOTS) { put_reason(reason, reason_len, "moments slot count out of range"); return 1; }
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    const float *sl = (const float *) p->bSlots.contents;
    for (int s = 0; s < n_slot; s++) {
      const float *q = sl + (size_t) s * BMAD_DEV_MOM_STRIDE;
      double *o = out + (size_t) s * 47;
      for (int k = 0; k < 25; k++) o[k] = (double) q[2 * k] + (double) q[2 * k + 1];
      for (int k = 0; k < 22; k++) o[25 + k] = (double) q[64 + 2 * k] + (double) q[64 + 2 * k + 1];
    }
    return 0;
  }
}

int bmad_backend_bunch_stats (double mass, double dct, double out[9], char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    RedParH R = {(uint32_t) p->n_res, (float) dct, (float) mass, 0};
    id<MTLComputeCommandEncoder> e = p->encoder();
    [e setComputePipelineState:p->psoRedAll];
    [e setBuffer:p->bX offset:0 atIndex:0]; [e setBuffer:p->bY offset:0 atIndex:1];
    [e setBuffer:p->bZ offset:0 atIndex:2]; [e setBuffer:p->bPZ offset:0 atIndex:3];
    [e setBuffer:p->bP0c offset:0 atIndex:4]; [e setBuffer:p->bState offset:0 atIndex:5];
    [e setBuffer:p->bQ offset:0 atIndex:6]; [e setBuffer:p->bRed offset:0 atIndex:7];
    [e setBytes:&R length:sizeof(R) atIndex:8];
    [e dispatchThreadgroups:MTLSizeMake(kRedGroups, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    const float *r = (const float *) p->bRed.contents;
    out[0] = out[1] = out[2] = 0;
    for (int k = 0; k < 3; k++) { out[3 + k] = 3.0e38; out[6 + k] = -3.0e38; }
    for (uint32_t g = 0; g < kRedGroups; g++) {
      out[0] += r[9 * g]; out[1] += r[9 * g + 1]; out[2] += r[9 * g + 2];
      for (int k = 0; k < 3; k++) {
        if (r[9 * g + 3 + k] < out[3 + k]) out[3 + k] = r[9 * g + 3 + k];
        if (r[9 * g + 6 + k] > out[6 + k]) out[6 + k] = r[9 * g + 6 + k];
      }
    }
    return 0;
  }
}

// Both binning passes in one command buffer: pass 1 sums, per-bin centroids on the device, pass 2 widths.
int bmad_backend_csr_step (double mass, int n_bin, int pbs, int n_bin_eff, double out_stats[9], double out_layout[4],
                           double *out1, double *out2, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    uint32_t n = (uint32_t) p->n_res, nbin = (uint32_t) n_bin;
    p->ensure_bins(nbin);
    RedParH R = {n, 0.0f, (float) mass, 0};
    CsrSetupH S = {n, nbin, (uint32_t) pbs, (uint32_t) n_bin_eff, (float) mass, 0.0f, 0.0f, 0.0f};
    uint32_t ng = kRedGroups;
    id<MTLComputeCommandEncoder> e = p->encoder();
    [e setComputePipelineState:p->psoRedAll];
    [e setBuffer:p->bX offset:0 atIndex:0]; [e setBuffer:p->bY offset:0 atIndex:1];
    [e setBuffer:p->bZ offset:0 atIndex:2]; [e setBuffer:p->bPZ offset:0 atIndex:3];
    [e setBuffer:p->bP0c offset:0 atIndex:4]; [e setBuffer:p->bState offset:0 atIndex:5];
    [e setBuffer:p->bQ offset:0 atIndex:6]; [e setBuffer:p->bRed offset:0 atIndex:7];
    [e setBytes:&R length:sizeof(R) atIndex:8];
    [e dispatchThreadgroups:MTLSizeMake(kRedGroups, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    [e setComputePipelineState:p->psoCsrLayout];
    [e setBuffer:p->bRed offset:0 atIndex:0]; [e setBuffer:p->bStats offset:0 atIndex:1];
    [e setBuffer:p->bCsrPar offset:0 atIndex:2];
    [e setBytes:&S length:sizeof(S) atIndex:3];
    [e setBytes:&ng length:4 atIndex:4];
    [e dispatchThreadgroups:MTLSizeMake(1, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    if (n == 0) {
      uint32_t nwords = 8 * nbin;
      [e setComputePipelineState:p->psoZero];
      [e setBuffer:p->bCsrAcc offset:0 atIndex:0];
      [e setBytes:&nwords length:4 atIndex:1];
      [e dispatchThreads:MTLSizeMake(nwords, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      [e setBuffer:p->bCsrAcc2 offset:0 atIndex:0];
      [e dispatchThreads:MTLSizeMake(nwords, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    } else {
      csr_encode_pass(p, e, n, nbin, 1, p->bCsrAcc);
      [e setComputePipelineState:p->psoCsrX0];
      [e setBuffer:p->bCsrAcc offset:0 atIndex:0];
      [e setBuffer:p->bCsrX0 offset:0 atIndex:1]; [e setBuffer:p->bCsrY0 offset:0 atIndex:2];
      [e setBuffer:p->bCsrPar offset:0 atIndex:3];
      [e dispatchThreads:MTLSizeMake(nbin, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      csr_encode_pass(p, e, n, nbin, 2, p->bCsrAcc2);
    }
    double t0 = p->timing ? wall_seconds() : 0.0, b0 = p->busy;
    p->sync();
    if (p->timing) {
      p->csr_wall += wall_seconds() - t0; p->csr_busy += p->busy - b0; p->csr_calls++;
      if (p->csr_calls % 500 == 0)
        fprintf(stderr, "bmad_metal timing: csr_step calls %ld, wait %.3f s (%.3f ms/call), GPU busy %.3f s (%.3f ms/call)\n",
                p->csr_calls, p->csr_wall, 1e3 * p->csr_wall / p->csr_calls, p->csr_busy, 1e3 * p->csr_busy / p->csr_calls);
    }
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    const float *st = (const float *) p->bStats.contents;
    for (int k = 0; k < 9; k++) out_stats[k] = st[k];
    const CsrParH *CP = (const CsrParH *) p->bCsrPar.contents;
    out_layout[0] = CP[0].z_min; out_layout[1] = CP[0].dz_slice; out_layout[2] = CP[0].dz_particle; out_layout[3] = CP[0].zc1;
    const uint32_t *S1 = (const uint32_t *) p->bCsrAcc.contents;
    const uint32_t *S2 = (const uint32_t *) p->bCsrAcc2.contents;
    double sinv1[4] = {1.0 / CP[0].scale0, 1.0 / CP[0].scale1, 1.0 / CP[0].scale2, 1.0 / CP[0].scale3};
    double sinv2[2] = {1.0 / CP[1].scale0, 1.0 / CP[1].scale1};
    for (uint32_t ib = 0; ib < nbin; ib++) {
      for (int k = 0; k < 4; k++) {
        uint32_t w = 4 * ib + (uint32_t) k;
        int64_t q = (int64_t) (((uint64_t) S1[2 * w + 1] << 32) | (uint64_t) S1[2 * w]);
        out1[k + 4 * ib] = (double) q * sinv1[k];
      }
      for (int k = 0; k < 2; k++) {
        uint32_t w = 4 * ib + (uint32_t) k;
        int64_t q = (int64_t) (((uint64_t) S2[2 * w + 1] << 32) | (uint64_t) S2[2 * w]);
        out2[k + 2 * ib] = (double) q * sinv2[k];
      }
    }
    return 0;
  }
}

int bmad_backend_csr_kick (const bmad_dev_csr_par *par, const float *kick, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    uint32_t n = (uint32_t) p->n_res, nbin = (uint32_t) par->n_bin;
    if (n == 0) return 0;
    p->sync();
    p->ensure_bins(nbin);
    memcpy(p->bCsrK.contents, kick, (size_t) nbin * 4);
    CsrParH C;
    csr_par_fill(&C, par, n);
    id<MTLComputeCommandEncoder> e = p->encoder();
    [e setComputePipelineState:p->psoCsrKick];
    [e setBuffer:p->bPZ offset:0 atIndex:0]; [e setBuffer:p->bZ offset:0 atIndex:1];
    [e setBuffer:p->bState offset:0 atIndex:2]; [e setBuffer:p->bCsrK offset:0 atIndex:3];
    [e setBytes:&C length:sizeof(C) atIndex:4];
    [e setBuffer:p->bFault offset:0 atIndex:5];
    [e dispatchThreads:MTLSizeMake(n, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    return 0;
  }
}

} // extern "C"
