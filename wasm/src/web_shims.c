/*
 * web_shims.c
 *
 * Replacements for the parts of sim_utils that need a terminal or a display
 * (sim_utils/io/read_line.c, readline_completion.c and plot/display_size_and_resolution.c)
 * when Bmad/Tao is built for WebAssembly. The web page drives Tao through tao_c_interface_mod,
 * so there is no interactive terminal: reading a line returns end-of-input.
 */

#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <fftw3.h>

typedef int (*sim_rl_complete_fn)(const char* line, int point, int start, int end,
                                  char* buf, int buf_size);

/* Tao's completion engine (tao/code/tao_completion_mod.f90). */
int tao_rl_complete_c(const char* line, int point, int start, int end, char* buf, int buf_size);

#define WEB_COMPLETE_BUF_SIZE 65536
static char complete_buf[WEB_COMPLETE_BUF_SIZE];

void read_line_(char* tag, char* str, char* hist_file, int tag_len, int str_len, int hist_len) {
  int ii;
  for (ii = 1; ii < str_len; ii++) str[ii] = ' ';
  str[0] = 24;   /* Same as cntl-D: end of input. */
}

void read_history_(char* file, int* stat, int file_len) {*stat = 0;}
void write_history_(char* file, int* stat, int file_len) {*stat = 0;}

void readline_set_completion_fn(sim_rl_complete_fn fn) {}
void readline_clear_completion_fn(void) {}
void readline_suppress_append(void) {}
void readline_set_app_name(const char* name) {}

/*
 * Tab completion for the web console. Returns newline separated lines: the common prefix to
 * insert followed by one candidate per line (the format of the readline completion callback).
 * An empty string means there is nothing to offer.
 * *start is set to the index in line where the word being completed starts.
 */

const char* tao_web_complete(const char* line, int point, int* start) {
  int s = point, n;
  complete_buf[0] = 0;
  while (s > 0 && line[s-1] != ' ' && line[s-1] != '\t') s--;
  *start = s;
  n = tao_rl_complete_c(line, point, s, point, complete_buf, WEB_COMPLETE_BUF_SIZE);
  if (n <= 0) complete_buf[0] = 0;
  return complete_buf;
}

/* The page size is set by the web page: report a nominal 96 dpi display. */

void display_size_and_res(int ix_screen, double* x_size, double* y_size, double* x_res, double* y_res,
                          int* x_pix, int* y_pix) {
  *x_pix = 1920;
  *y_pix = 1080;
  *x_res = 96.0 / 25.4;
  *y_res = 96.0 / 25.4;
  *x_size = *x_pix / *x_res;
  *y_size = *y_pix / *y_res;
}

/*
 * The stat function, a gfortran extension that flang does not have: ierr = stat(name, values)
 * with values an integer array of size 13. Bmad uses it to get the modification time of
 * lattice files.
 */

int stat_(const char* name, int* values, int name_len) {
  struct stat st;
  char* path;
  int err;

  while (name_len > 0 && name[name_len-1] == ' ') name_len--;
  path = (char*) malloc(name_len + 1);
  memcpy(path, name, name_len);
  path[name_len] = 0;
  err = stat(path, &st);
  free(path);
  if (err != 0) return err;

  values[0] = st.st_dev;
  values[1] = st.st_ino;
  values[2] = st.st_mode;
  values[3] = st.st_nlink;
  values[4] = st.st_uid;
  values[5] = st.st_gid;
  values[6] = st.st_rdev;
  values[7] = st.st_size;
  values[8] = st.st_atime;
  values[9] = st.st_mtime;
  values[10] = st.st_ctime;
  values[11] = st.st_blksize;
  values[12] = st.st_blocks;
  return 0;
}

/*
 * The legacy Fortran interface of FFTW used by sim_utils/math/fft_1d.f90. FFTW only builds it
 * when it is configured with a Fortran compiler.
 */

void dfftw_plan_dft_1d_(fftw_plan* plan, int* n, fftw_complex* in, fftw_complex* out, int* sign, int* flags) {
  *plan = fftw_plan_dft_1d(*n, in, out, *sign, (unsigned) *flags);
}

void dfftw_execute_dft_(fftw_plan* plan, fftw_complex* in, fftw_complex* out) {
  fftw_execute_dft(*plan, in, out);
}

void dfftw_destroy_plan_(fftw_plan* plan) {
  fftw_destroy_plan(*plan);
}
