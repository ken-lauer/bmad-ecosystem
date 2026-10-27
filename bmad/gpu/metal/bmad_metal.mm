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
                                    int32_t *state, int32_t *loc, int32_t *lost_tag, char *reason, int reason_len);
int    bmad_backend_track_slice (const bmad_dev_slice_par *par, char *reason, int reason_len);
int    bmad_backend_bunch_sums (double mass, double out[3], char *reason, int reason_len);
int    bmad_backend_bunch_bounds (double mass, double dct, double out[6], char *reason, int reason_len);
int    bmad_backend_sc_step_resident (const bmad_dev_sc_par *par, char *reason, int reason_len);
int    bmad_backend_csr_kick (const bmad_dev_csr_par *par, const float *kick, char *reason, int reason_len);
int    bmad_backend_bunch_stats (double mass, double dct, double out[9], char *reason, int reason_len);
int    bmad_backend_csr_bins_both (const bmad_dev_csr_par *par1, const bmad_dev_csr_par *par2, double *out1, double *out2, char *reason, int reason_len);
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
constant int KIND_DRIFT = 1, KIND_QUAD = 2, KIND_THICK = 3, KIND_BEND = 4;

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
};

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

kernel void track_slice (device float* X [[buffer(0)]], device float* PX [[buffer(1)]],
                         device float* Y [[buffer(2)]], device float* PY [[buffer(3)]],
                         device float* Z [[buffer(4)]], device float* PZ [[buffer(5)]],
                         device int* STATE [[buffer(6)]], device int* LOC [[buffer(7)]],
                         device int* LOST_TAG [[buffer(8)]], const device float* P0C [[buffer(9)]],
                         constant SlicePar& P [[buffer(10)]], constant uint& n [[buffer(11)]],
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
      for (int istep = 1; istep <= P.n_step; istep++) {
        if (!bend_step_f(o, P, mass, p0c)) { lost = true; break; }
      }
      if (!lost) too_large(o, P.max_ap);
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
  uint b0, nb_win, n_group, pad4;      // bin window [b0, b0 + nb_win) and the threadgroup count of a pass
};

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
                    constant CsrPar& C [[buffer(3)]], uint ib [[thread_position_in_grid]]) {
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
                         constant CsrPar& C [[buffer(8)]], device atomic_uint* fault [[buffer(9)]],
                         threadgroup atomic_uint* sh [[threadgroup(0)]],
                         uint gid [[thread_position_in_grid]], uint tid [[thread_index_in_threadgroup]],
                         uint tg [[threadgroup_position_in_grid]], uint tgs [[threads_per_threadgroup]]) {
  uint nw = 8u * C.nb_win;
  for (uint w = tid; w < nw; w += tgs) atomic_store_explicit(&sh[w], 0u, memory_order_relaxed);
  threadgroup_barrier(mem_flags::mem_threadgroup);
  if (gid < C.n && STATE[gid] == ALIVE) {
    float zp_center = Z[gid];
    float zp0 = zp_center - C.dz_particle / 2.0f;
    float zp1 = zp_center + C.dz_particle / 2.0f;
    int ix0 = nint_f((zp0 - C.z_min) / C.dz_slice);
    float x = X[gid], y = Y[gid], q = Q[gid];
    for (uint j = 0; j <= C.pbs + 1u; j++) {
      int ib = (int) j + ix0;                                 // 1-based bin
      if (ib < 1 || ib > (int) C.n_bin) { atomic_fetch_or_explicit(fault, 2u, memory_order_relaxed); continue; }
      uint ibl = (uint) (ib - 1);
      if (ibl < C.b0 || ibl >= C.b0 + C.nb_win) continue;
      float zb0 = C.z_min + (float) (ib - 1) * C.dz_slice;
      float zb1 = zb0 + C.dz_slice;
      float z1_over = max(zp0, zb0), z2_over = min(zp_center, zb1);
      float overlap = (z2_over > z1_over) ? 2.0f * ((z2_over - zp0) * (z2_over - zp0) - (z1_over - zp0) * (z1_over - zp0)) * C.inv_dz2 : 0.0f;
      z1_over = max(zp_center, zb0);  z2_over = min(zp1, zb1);
      if (z2_over > z1_over) overlap += 2.0f * ((z1_over - zp1) * (z1_over - zp1) - (z2_over - zp1) * (z2_over - zp1)) * C.inv_dz2;
      float charge = overlap * q;
      uint base = 4u * (ibl - C.b0);
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
                             constant CsrPar& C [[buffer(2)]], uint c [[thread_position_in_grid]]) {
  uint ncell = 4u * C.nb_win;
  if (c >= ncell) return;
  uint nw = 2u * ncell;
  ulong acc = 0;
  for (uint g = 0; g < C.n_group; g++) {
    const device uint* p = PART + (ulong) g * nw + 2u * c;
    acc += ((ulong) p[1] << 32) | (ulong) p[0];
  }
  uint w = 2u * (4u * C.b0 + c);
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
struct CsrParH {
  uint32_t n, n_bin, pbs, pass;
  float z_min, dz_slice, dz_particle, inv_dz2;
  float scale0, scale1, scale2, scale3;
  float zc1, pad1, pad2, pad3;
  uint32_t b0, nb_win, n_group, pad4;
};
static const uint32_t kRedGroups = 512;

struct FftParH {
  uint32_t n, stride, bs1, count1, bs2, nl, l1_off, l2_off, tfast, woff;
  int32_t sign;
  uint32_t pad;
};

static const MTLResourceOptions kShared = MTLResourceStorageModeShared;

struct Impl {
  id<MTLDevice> dev = nil;
  id<MTLCommandQueue> queue = nil;
  id<MTLLibrary> lib = nil;
  id<MTLComputePipelineState> psoZero = nil, psoDeposit = nil, psoRho = nil, psoR2C = nil, psoFft = nil;
  id<MTLComputePipelineState> psoCmul = nil, psoExtract = nil, psoKick = nil;
  id<MTLCommandBuffer> cb = nil;
  id<MTLComputeCommandEncoder> enc = nil;
  id<MTLBuffer> bX = nil, bY = nil, bZ = nil, bQ = nil, bF = nil, bPX = nil, bPY = nil, bPZ = nil;
  id<MTLBuffer> bRho = nil, bA = nil, bB = nil, bG[3] = {nil, nil, nil}, bE[3] = {nil, nil, nil}, bFault = nil;
  id<MTLBuffer> bW = nil;          // twiddle tables, one per padded dimension length
  id<MTLBuffer> bState = nil, bLoc = nil, bLost = nil, bP0c = nil, bRed = nil;   // resident bunch
  id<MTLBuffer> bCsrAcc = nil, bCsrX0 = nil, bCsrY0 = nil, bCsrK = nil;           // 1D CSR bins
  uint32_t n_bin_max = 0;
  id<MTLComputePipelineState> psoCsrBinsTG = nil, psoCsrReduce = nil, psoCsrKick = nil, psoCsrX0 = nil, psoRedAll = nil;
  id<MTLBuffer> bCsrAcc2 = nil, bCsrPart = nil;   // per-threadgroup partial bin sums
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
  double busy = 0;
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
    p->psoKick = pso(@"interp_kick");
    p->psoTrack = pso(@"track_slice");
    p->psoRedSums = pso(@"reduce_sums");
    p->psoRedBounds = pso(@"reduce_bounds");
    p->psoDepositR = pso(@"deposit_r");
    p->psoKickR = pso(@"interp_kick_r");
    p->psoCsrBinsTG = pso(@"csr_bins_tg");
    p->psoCsrReduce = pso(@"csr_bins_reduce");
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
    p->bRed = p->alloc((size_t) kRedGroups * 9 * 4);
    p->bRho = p->alloc(nm * 8);
    p->bA = p->alloc(nm2 * 8);
    p->bB = p->alloc(nm2 * 8);
    for (int c = 0; c < 3; c++) { p->bG[c] = p->alloc(nm2 * 8); p->bE[c] = p->alloc(nm * 4); }
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
    const float *g[3] = {gx, gy, gz};
    uint32_t nm2 = p->nx2 * p->ny2 * p->nz2;
    for (int c = 0; c < 3; c++) {
      p->sync();
      memcpy(p->bA.contents, g[c], (size_t) nm2 * 4);    // bA holds 2*nm2 floats, enough for the real array
      id<MTLComputeCommandEncoder> e = p->encoder();
      [e setComputePipelineState:p->psoR2C];
      [e setBuffer:p->bA offset:0 atIndex:0];
      [e setBuffer:p->bG[c] offset:0 atIndex:1];
      [e setBytes:&nm2 length:4 atIndex:2];
      [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      p->fft3d_forward_full(p->bG[c]);
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

    for (int c = 0; c < 3; c++) {
      e = p->encoder();
      [e setComputePipelineState:p->psoCmul];
      [e setBuffer:p->bA offset:0 atIndex:0];
      [e setBuffer:p->bG[c] offset:0 atIndex:1];
      [e setBuffer:p->bB offset:0 atIndex:2];
      [e setBytes:&nm2 length:4 atIndex:3];
      [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      p->fft3d_backward_octant(p->bB);
      e = p->encoder();
      [e setComputePipelineState:p->psoExtract];
      [e setBuffer:p->bB offset:0 atIndex:0];
      [e setBuffer:p->bE[c] offset:0 atIndex:1];
      [e setBytes:&P length:sizeof(P) atIndex:2];
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

int bmad_backend_bunch_download (int n, float *x, float *px, float *y, float *py, float *z, float *pz,
                                 int32_t *state, int32_t *loc, int32_t *lost_tag, char *reason, int reason_len)
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
    memset(p->bLoc.contents, 0, nb);     // the next download reports only particles touched after this one
    return 0;
  }
}

int bmad_backend_track_slice (const bmad_dev_slice_par *par, char *reason, int reason_len)
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

    for (int c = 0; c < 3; c++) {
      e = p->encoder();
      [e setComputePipelineState:p->psoCmul];
      [e setBuffer:p->bA offset:0 atIndex:0];
      [e setBuffer:p->bG[c] offset:0 atIndex:1];
      [e setBuffer:p->bB offset:0 atIndex:2];
      [e setBytes:&nm2 length:4 atIndex:3];
      [e dispatchThreads:MTLSizeMake(nm2, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      p->fft3d_backward_octant(p->bB);
      e = p->encoder();
      [e setComputePipelineState:p->psoExtract];
      [e setBuffer:p->bB offset:0 atIndex:0];
      [e setBuffer:p->bE[c] offset:0 atIndex:1];
      [e setBytes:&P length:sizeof(P) atIndex:2];
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
static void csr_encode_pass (Impl *p, id<MTLComputeCommandEncoder> e, CsrParH C, id<MTLBuffer> acc)
{
  uint32_t n = C.n, nbin = C.n_bin;
  NSUInteger tgs = p->psoCsrBinsTG.maxTotalThreadsPerThreadgroup;
  if (tgs > 1024) tgs = 1024;
  uint32_t ngroup = (n + (uint32_t) tgs - 1) / (uint32_t) tgs;
  uint32_t win_max = (uint32_t) (p->dev.maxThreadgroupMemoryLength / 32);
  if (win_max < 1) win_max = 1;
  uint32_t win = nbin < win_max ? nbin : win_max;
  size_t part_bytes = (size_t) ngroup * 8 * win * 4;
  if (part_bytes > p->csr_part_bytes) { p->bCsrPart = p->alloc(part_bytes); p->csr_part_bytes = part_bytes; }
  for (uint32_t b0 = 0; b0 < nbin; b0 += win) {
    C.b0 = b0;  C.nb_win = (nbin - b0 < win) ? nbin - b0 : win;  C.n_group = ngroup;
    [e setComputePipelineState:p->psoCsrBinsTG];
    [e setBuffer:p->bX offset:0 atIndex:0]; [e setBuffer:p->bY offset:0 atIndex:1];
    [e setBuffer:p->bZ offset:0 atIndex:2]; [e setBuffer:p->bQ offset:0 atIndex:3];
    [e setBuffer:p->bState offset:0 atIndex:4]; [e setBuffer:p->bCsrPart offset:0 atIndex:5];
    [e setBuffer:p->bCsrX0 offset:0 atIndex:6]; [e setBuffer:p->bCsrY0 offset:0 atIndex:7];
    [e setBytes:&C length:sizeof(C) atIndex:8];
    [e setBuffer:p->bFault offset:0 atIndex:9];
    [e setThreadgroupMemoryLength:(NSUInteger) C.nb_win * 32 atIndex:0];
    [e dispatchThreadgroups:MTLSizeMake(ngroup, 1, 1) threadsPerThreadgroup:MTLSizeMake(tgs, 1, 1)];
    [e setComputePipelineState:p->psoCsrReduce];
    [e setBuffer:p->bCsrPart offset:0 atIndex:0]; [e setBuffer:acc offset:0 atIndex:1];
    [e setBytes:&C length:sizeof(C) atIndex:2];
    [e dispatchThreads:MTLSizeMake(4 * C.nb_win, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
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
int bmad_backend_csr_bins_both (const bmad_dev_csr_par *par1, const bmad_dev_csr_par *par2, double *out1, double *out2, char *reason, int reason_len)
{
  @autoreleasepool {
    Impl *p = gImpl;
    if (p == NULL) { put_reason(reason, reason_len, "device not initialized"); return 1; }
    uint32_t n = (uint32_t) p->n_res, nbin = (uint32_t) par1->n_bin;
    p->ensure_bins(nbin);
    CsrParH C1, C2;
    csr_par_fill(&C1, par1, n);
    csr_par_fill(&C2, par2, n);
    id<MTLComputeCommandEncoder> e = p->encoder();
    if (n == 0) {
      uint32_t nwords = 8 * nbin;
      [e setComputePipelineState:p->psoZero];
      [e setBuffer:p->bCsrAcc offset:0 atIndex:0];
      [e setBytes:&nwords length:4 atIndex:1];
      [e dispatchThreads:MTLSizeMake(nwords, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      [e setBuffer:p->bCsrAcc2 offset:0 atIndex:0];
      [e dispatchThreads:MTLSizeMake(nwords, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
    } else {
      csr_encode_pass(p, e, C1, p->bCsrAcc);
      [e setComputePipelineState:p->psoCsrX0];
      [e setBuffer:p->bCsrAcc offset:0 atIndex:0];
      [e setBuffer:p->bCsrX0 offset:0 atIndex:1]; [e setBuffer:p->bCsrY0 offset:0 atIndex:2];
      [e setBytes:&C1 length:sizeof(C1) atIndex:3];
      [e dispatchThreads:MTLSizeMake(nbin, 1, 1) threadsPerThreadgroup:MTLSizeMake(256, 1, 1)];
      csr_encode_pass(p, e, C2, p->bCsrAcc2);
    }
    p->sync();
    if (p->err[0]) { put_reason(reason, reason_len, p->err); return 1; }
    const uint32_t *S1 = (const uint32_t *) p->bCsrAcc.contents;
    const uint32_t *S2 = (const uint32_t *) p->bCsrAcc2.contents;
    double sinv1[4] = {1.0 / par1->scale[0], 1.0 / par1->scale[1], 1.0 / par1->scale[2], 1.0 / par1->scale[3]};
    double sinv2[2] = {1.0 / par2->scale[0], 1.0 / par2->scale[1]};
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
