/*
 * bmad_device.c: run-time loader for the device backend behind bmad_device.h.
 *
 * The backend is a shared library next to the library holding this file (libbmad_<backend>.dylib or
 * .so), or the file named by the BMAD_DEVICE_LIB environment variable. It is loaded on the first
 * bmad_dev_available call. Keeping the backend out of libbmad means no Metal or CUDA link flags
 * reach the many executables that link libbmad statically.
 */

#include "bmad_device.h"

#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void *handle = NULL;
static int   load_tried = 0;
static char  load_reason[512] = "";

static bmad_backend_available_fn p_available = NULL;
static bmad_backend_init_fn      p_init = NULL;
static bmad_backend_close_fn     p_close = NULL;
static bmad_backend_set_green_fn p_set_green = NULL;
static bmad_backend_sc_step_fn   p_sc_step = NULL;
static bmad_backend_get_field_fn p_get_field = NULL;
static bmad_backend_seconds_fn   p_seconds = NULL;
static bmad_backend_timing_fn    p_timing = NULL;
static bmad_backend_fault_fn     p_fault = NULL;

static void put_reason (char *reason, int reason_len, const char *text)
{
  if (reason == NULL || reason_len <= 0) return;
  snprintf(reason, (size_t) reason_len, "%s", text);
}

static void *must_sym (const char *name)
{
  void *p = dlsym(handle, name);
  if (p == NULL) snprintf(load_reason, sizeof(load_reason), "backend library lacks %s", name);
  return p;
}

static int load_backend (const char *backend, char *reason, int reason_len)
{
  char path[1024];
  const char *env;

  if (handle != NULL) return 0;
  if (load_tried) {
    put_reason(reason, reason_len, load_reason);
    return 1;
  }
  load_tried = 1;

  env = getenv("BMAD_DEVICE_LIB");
  if (env != NULL && env[0] != '\0') {
    snprintf(path, sizeof(path), "%s", env);
  } else {
    Dl_info info;
    const char *slash;
    size_t dirlen = 0;
    if (dladdr((void *) &bmad_dev_available, &info) != 0 && info.dli_fname != NULL) {
      slash = strrchr(info.dli_fname, '/');
      if (slash != NULL) dirlen = (size_t) (slash - info.dli_fname) + 1;
    }
#ifdef __APPLE__
    snprintf(path, sizeof(path), "%.*slibbmad_%s.dylib", (int) dirlen, dirlen ? info.dli_fname : "", backend);
#else
    snprintf(path, sizeof(path), "%.*slibbmad_%s.so", (int) dirlen, dirlen ? info.dli_fname : "", backend);
#endif
  }

  handle = dlopen(path, RTLD_NOW | RTLD_LOCAL);
  if (handle == NULL) {
    snprintf(load_reason, sizeof(load_reason), "cannot load device backend %s: %s", path, dlerror());
    put_reason(reason, reason_len, load_reason);
    return 1;
  }

  p_available = (bmad_backend_available_fn) must_sym("bmad_backend_available");
  p_init      = (bmad_backend_init_fn)      must_sym("bmad_backend_init");
  p_close     = (bmad_backend_close_fn)     must_sym("bmad_backend_close");
  p_set_green = (bmad_backend_set_green_fn) must_sym("bmad_backend_set_green");
  p_sc_step   = (bmad_backend_sc_step_fn)   must_sym("bmad_backend_sc_step");
  p_get_field = (bmad_backend_get_field_fn) must_sym("bmad_backend_get_field");
  p_seconds   = (bmad_backend_seconds_fn)   must_sym("bmad_backend_seconds");
  p_timing    = (bmad_backend_timing_fn)    must_sym("bmad_backend_timing");
  p_fault     = (bmad_backend_fault_fn)     must_sym("bmad_backend_fault");

  if (!p_available || !p_init || !p_close || !p_set_green || !p_sc_step || !p_get_field || !p_seconds || !p_timing || !p_fault) {
    dlclose(handle);
    handle = NULL;
    put_reason(reason, reason_len, load_reason);
    return 1;
  }
  return 0;
}

int bmad_dev_available (const char *backend, char *reason, int reason_len)
{
  if (load_backend(backend, reason, reason_len) != 0) return 1;
  return p_available(reason, reason_len);
}

int bmad_dev_init (int n_particle_max, const int32_t mesh_n[3], char *reason, int reason_len)
{
  if (handle == NULL) { put_reason(reason, reason_len, "no device backend loaded"); return 1; }
  return p_init(n_particle_max, mesh_n, reason, reason_len);
}

void bmad_dev_close (void)
{
  if (handle != NULL) p_close();
}

int bmad_dev_set_green (const float *gx, const float *gy, const float *gz, char *reason, int reason_len)
{
  if (handle == NULL) { put_reason(reason, reason_len, "no device backend loaded"); return 1; }
  return p_set_green(gx, gy, gz, reason, reason_len);
}

int bmad_dev_sc_step (const bmad_dev_sc_par *par, const float *x, const float *y, const float *z, const float *q,
                      const float *factor, float *px, float *py, float *pz, char *reason, int reason_len)
{
  if (handle == NULL) { put_reason(reason, reason_len, "no device backend loaded"); return 1; }
  return p_sc_step(par, x, y, z, q, factor, px, py, pz, reason, reason_len);
}

int bmad_dev_get_field (int comp, float *E, char *reason, int reason_len)
{
  if (handle == NULL) { put_reason(reason, reason_len, "no device backend loaded"); return 1; }
  return p_get_field(comp, E, reason, reason_len);
}

double bmad_dev_seconds (void)
{
  return handle ? p_seconds() : 0.0;
}

void bmad_dev_timing (double t[4])
{
  if (handle != NULL) p_timing(t); else t[0] = t[1] = t[2] = t[3] = 0;
}

int bmad_dev_fault (void)
{
  return handle ? p_fault() : 0;
}
