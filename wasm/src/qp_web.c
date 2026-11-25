/*
 * qp_web.c
 *
 * Browser page handling for the quick_plot Cairo backend (sim_utils/plot/cairo_interface.f90).
 * Takes the place of sim_utils/plot/qp_cairo.c in the WebAssembly build.
 *
 * Drawing calls are encoded into the display list format of qp_cairo_render.h. Nothing is drawn
 * here: the list of the screen page is handed to JavaScript (Module.taoPlot) which draws it on a
 * canvas (wasm/web/qp_render.js) and can redraw it at any size. Hardcopy pages are not supported.
 */

#include <emscripten.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

enum {
  OP_PAGE = 1, OP_CLEAR = 2, OP_STATE = 3, OP_PUSH = 4, OP_POP = 5, OP_COLOR = 6, OP_LINE_WIDTH = 7,
  OP_LINE_PATTERN = 8, OP_CLIP = 9, OP_GRAPH_POS = 10, OP_CHAR_SIZE = 11, OP_SYM_SIZE = 12,
  OP_POLYLINE = 15, OP_RECT = 16, OP_SYMBOL = 17, OP_TEXT = 18, OP_ARROW = 19
};

/* Must match qpr_state in qp_cairo_render.h: it is the payload of OP_STATE. */

typedef struct {
  double rgb[3];
  double line_width;
  int32_t line_pattern;
  int32_t clip;
  double graph[4];
  double char_size;
  double sym_size;
} qp_state;

#define MAX_DEPTH 64
#define MAX_DEV 16

typedef struct {
  int screen;
  double w_in, h_in;
  int depth;
  qp_state st[MAX_DEPTH];
  uint8_t *buf;
  size_t len, cap;
  int dirty;
} qp_dev;

static qp_dev *devs[MAX_DEV];
static int ndev = 0;

static qp_dev *cur_dev (void) {return ndev > 0 ? devs[ndev-1] : NULL;}

EM_JS(void, tao_web_plot_js, (const uint8_t *buf, int len, double w_in, double h_in), {
  if (Module.taoPlot) Module.taoPlot(HEAPU8.slice(buf, buf + len), w_in, h_in);
});

/*-------------------------------------------------------------------------*/

static void put (qp_dev *d, const void *p, size_t n) {
  if (!d->screen) return;
  if (d->len + n > d->cap) {
    size_t nc = d->cap ? d->cap : 4096;
    while (nc < d->len + n) nc *= 2;
    d->buf = (uint8_t *)realloc(d->buf, nc);
    if (!d->buf) {fprintf(stderr, "qp_web: out of memory\n"); exit(1);}
    d->cap = nc;
  }
  memcpy(d->buf + d->len, p, n);
  d->len += n;
  d->dirty = 1;
}

static void op (qp_dev *d, uint8_t code, const void *payload, uint32_t plen) {
  put(d, &code, 1);
  put(d, &plen, 4);
  if (plen) put(d, payload, plen);
}

static void op_d (uint8_t code, const double *v, int nd, const int32_t *iv) {
  qp_dev *d = cur_dev();
  uint8_t b[8*8 + 4];
  uint32_t n = nd * sizeof(double);
  if (!d) return;
  memcpy(b, v, n);
  if (iv) {memcpy(b + n, iv, 4); n += 4;}
  op(d, code, b, n);
}

static void op_i (uint8_t code, int32_t v) {
  qp_dev *d = cur_dev();
  if (d) op(d, code, &v, 4);
}

static void default_state (qp_state *s) {
  memset(s, 0, sizeof(*s));
  s->line_pattern = 1;
  s->char_size = 12;
  s->sym_size = 10;
}

static qp_state *cur (qp_dev *d) {return &d->st[d->depth];}

/*-------------------------------------------------------------------------*/
/* Page management. */

int qpc_open (int kind, const char *file, int nfile, double w_in, double h_in, double dpi) {
  qp_dev *d;
  double wh[2] = {w_in, h_in};

  if (ndev >= MAX_DEV) return -1;
  d = (qp_dev *)calloc(1, sizeof(qp_dev));
  d->screen = (kind == 0);
  d->w_in = w_in;
  d->h_in = h_in;
  default_state(&d->st[0]);
  devs[ndev++] = d;

  if (!d->screen) fprintf(stderr, "quick_plot: Plot files cannot be made in the browser: %.*s\n", nfile, file);
  op_d(OP_PAGE, wh, 2, NULL);
  op(d, OP_CLEAR, NULL, 0);
  return ndev - 1;
}

void qpc_close (void) {
  qp_dev *d = cur_dev();
  if (!d) return;
  free(d->buf);
  free(d);
  devs[--ndev] = NULL;
}

void qpc_end (void) {
  while (ndev > 0) qpc_close();
}

/* Hand the display list to the web page if it has changed since the last time.
 * Called from JavaScript after each Tao command. */

EMSCRIPTEN_KEEPALIVE void tao_web_plot_sync (void) {
  qp_dev *d = cur_dev();
  if (!d || !d->screen || !d->dirty) return;
  tao_web_plot_js(d->buf, (int)d->len, d->w_in, d->h_in);
  d->dirty = 0;
}

void qpc_flush (int force) {
  if (force) tao_web_plot_sync();
}

/* Clear the page: restart the display list and replay the state stack into it. */

void qpc_clear (void) {
  qp_dev *d = cur_dev();
  double wh[2];
  int i;
  if (!d) return;
  wh[0] = d->w_in; wh[1] = d->h_in;
  d->len = 0;
  op(d, OP_PAGE, wh, sizeof wh);
  op(d, OP_CLEAR, NULL, 0);
  for (i = 0; i <= d->depth; i++) {
    op(d, OP_STATE, &d->st[i], sizeof(qp_state));
    if (i < d->depth) op(d, OP_PUSH, NULL, 0);
  }
}

/*-------------------------------------------------------------------------*/
/* State and drawing. */

void qpc_push (void) {
  qp_dev *d = cur_dev();
  if (!d) return;
  if (d->depth < MAX_DEPTH - 1) {d->st[d->depth+1] = d->st[d->depth]; d->depth++;}
  op(d, OP_PUSH, NULL, 0);
}

void qpc_pop (void) {
  qp_dev *d = cur_dev();
  if (!d) return;
  if (d->depth > 0) d->depth--;
  op(d, OP_POP, NULL, 0);
}

void qpc_color (double r, double g, double b) {
  qp_dev *d = cur_dev();
  double v[3] = {r, g, b};
  if (!d) return;
  memcpy(cur(d)->rgb, v, sizeof v);
  op_d(OP_COLOR, v, 3, NULL);
}

void qpc_line_width (double w) {
  qp_dev *d = cur_dev();
  if (!d) return;
  cur(d)->line_width = w;
  op_d(OP_LINE_WIDTH, &w, 1, NULL);
}

void qpc_line_pattern (int p) {
  qp_dev *d = cur_dev();
  if (!d) return;
  cur(d)->line_pattern = p;
  op_i(OP_LINE_PATTERN, p);
}

void qpc_clip (int on) {
  qp_dev *d = cur_dev();
  if (!d) return;
  cur(d)->clip = on;
  op_i(OP_CLIP, on);
}

void qpc_char_size (double h) {
  qp_dev *d = cur_dev();
  if (!d) return;
  cur(d)->char_size = h;
  op_d(OP_CHAR_SIZE, &h, 1, NULL);
}

void qpc_sym_size (double h) {
  qp_dev *d = cur_dev();
  if (!d) return;
  cur(d)->sym_size = h;
  op_d(OP_SYM_SIZE, &h, 1, NULL);
}

void qpc_graph_pos (double x1, double x2, double y1, double y2) {
  qp_dev *d = cur_dev();
  double v[4] = {x1, x2, y1, y2};
  if (!d) return;
  memcpy(cur(d)->graph, v, sizeof v);
  op_d(OP_GRAPH_POS, v, 4, NULL);
}

void qpc_polyline (int n, const double *x, const double *y) {
  qp_dev *d = cur_dev();
  uint8_t code = OP_POLYLINE;
  int32_t n32 = n;
  uint32_t plen = 4 + 2 * n * sizeof(double);
  if (!d || n < 0) return;
  put(d, &code, 1);
  put(d, &plen, 4);
  put(d, &n32, 4);
  put(d, x, n * sizeof(double));
  put(d, y, n * sizeof(double));
}

void qpc_rect (double x1, double x2, double y1, double y2, int fill) {
  double v[4] = {x1, x2, y1, y2};
  int32_t f = fill;
  op_d(OP_RECT, v, 4, &f);
}

void qpc_symbol (double x, double y, int type) {
  double v[2] = {x, y};
  int32_t t = type;
  op_d(OP_SYMBOL, v, 2, &t);
}

void qpc_text (double x, double y, double angle, double justify, const char *text, int n) {
  qp_dev *d = cur_dev();
  uint8_t code = OP_TEXT;
  double v[4] = {x, y, angle, justify};
  int32_t n32 = n;
  uint32_t plen = sizeof v + 4 + n;
  if (!d || n < 0) return;
  put(d, &code, 1);
  put(d, &plen, 4);
  put(d, v, sizeof v);
  put(d, &n32, 4);
  put(d, text, n);
}

void qpc_arrow (double x1, double y1, double x2, double y2, double head_angle,
                double head_barb, double head_size, int filled) {
  double v[7] = {x1, y1, x2, y2, head_angle, head_barb, head_size};
  int32_t f = filled;
  op_d(OP_ARROW, v, 7, &f);
}

/* Approximate length of text in inches: the same estimate as qpr_text_len in qp_cairo_render.c. */

double qpc_text_len (const char *text, int n) {
  qp_dev *d = cur_dev();
  int i, n_text;
  if (!d) return 0;
  while (n > 0 && text[n-1] == ' ') n--;
  n_text = n;
  for (i = 0; i < n; i++) if (text[i] == '\\') n_text--;
  return 0.8 * n_text * cur(d)->char_size * 0.25 / 25.4;
}
