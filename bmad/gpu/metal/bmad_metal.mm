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
};

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
    if (!ok) { put_reason(reason, reason_len, p->err); delete p; return 1; }

    size_t np = (size_t) (n_particle_max > 0 ? n_particle_max : 1);
    size_t nm = (size_t) p->nx * p->ny * p->nz;
    size_t nm2 = (size_t) p->nx2 * p->ny2 * p->nz2;
    p->nmax = (int) np;
    p->bX = p->alloc(np * 4);  p->bY = p->alloc(np * 4);  p->bZ = p->alloc(np * 4);  p->bQ = p->alloc(np * 4);
    p->bF = p->alloc(np * 4);  p->bPX = p->alloc(np * 4); p->bPY = p->alloc(np * 4); p->bPZ = p->alloc(np * 4);
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

} // extern "C"
