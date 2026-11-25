// Canvas renderer for the quick_plot display list made by wasm/src/qp_web.c.
//
// This is a port of sim_utils/plot/qp_cairo_render.c: same op stream, same units, same rules
// for text (PGPLOT escapes, super/subscripts), symbols, dashes and fills, drawn with the
// Canvas 2D API instead of Cairo and Pango.

import { HERSHEY } from "./hershey.js";

const OP = {
  PAGE: 1, CLEAR: 2, STATE: 3, PUSH: 4, POP: 5, COLOR: 6, LINE_WIDTH: 7, LINE_PATTERN: 8,
  CLIP: 9, GRAPH_POS: 10, CHAR_SIZE: 11, SYM_SIZE: 12, POLYLINE: 15, RECT: 16, SYMBOL: 17,
  TEXT: 18, ARROW: 19,
};

const TEXT_FONT_SCALE = (0.25 * 72.0) / 25.4;   // Font size [pt] per quick_plot text height [pt].
const SYM_FONT_SCALE = 72.0 / 152.4;            // Font size [pt] per quick_plot symbol height [pt].
const LINE_WIDTH_UNIT = 0.005;                  // inch
const MM = 72.0 / 25.4;                         // One mm in points.
const ARROW_HEAD_LEN = 0.12;                    // inch, for head_size = 1.

const NO_FILL = 2, HATCHED = 3, CROSS_HATCHED = 4;

// Dash patterns [mm] (mark, space, ...) by quick_plot line pattern number - 1.
const DASHES = [[], [1, 1], [2, 2], [2, 1], [2.5, 1, 1, 1]];

// Unicode glyph for each quick_plot symbol number. 0 => drawn from Hershey strokes.
const SYMBOL_GLYPH = [
  0x25a1, 0x22c5, 0x002b, 0x2217, 0x25cb, 0x00d7, 0x25a1, 0x25b3, 0x2295, 0x2299,
  0, 0x2662, 0x2729, 0x25b2, 0, 0x2721, 0x25a0, 0x2022, 0x22c6,
];

// Hershey strokes for the symbols with no glyph. Pen up is marked by 64. y is up.
const HERSHEY_SQUARE_CONCAVE = [
  -9, 9, -8, 7, -7, 3, -7, -3, -8, -7, -9, -9, 64, 0, 9, 9, 8, 7, 7, 3, 7, -3, 8, -7, 9, -9, 64, 0,
  -9, 9, -7, 8, -3, 7, 3, 7, 7, 8, 9, 9, 64, 0, -9, -9, -7, -8, -3, -7, 3, -7, 7, -8, 9, -9, 64, 64,
];
const HERSHEY_RED_CROSS = [
  -2, 6, -2, 2, -6, 2, -6, -2, -2, -2, -2, -6, 2, -6, 2, -2, 6, -2, 6, 2, 2, 2, 2, 6, -2, 6, 64, 64,
];

const FAMILY = ["sans-serif", "serif", "monospace", "cursive"];
const GREEK_MNEMONIC = "ABGDEZYHIKLMNCOPRSTUFXQWabgdezyhiklmncoprstufxqw";

function defaultState() {
  return { rgb: [0, 0, 0], lineWidth: 0, linePattern: 1, clip: 0, graph: [0, 0, 0, 0], charSize: 12, symSize: 10 };
}

function greekUnicode(c) {
  let ig = GREEK_MNEMONIC.indexOf(c);
  if (ig < 0) return 0;
  if (ig >= 24) ig = ig + 100 - 24;
  ig += 527;
  if (ig === 631) ig = 684;
  else if (ig === 634) ig = 685;
  else if (ig === 647) ig = 686;
  return HERSHEY[ig] || 0;
}

function isNumber(text) {
  return /^ *[-+]?(\d+\.?\d*|\.\d+)([eEdD][-+]?\d+)? *$/.test(text);
}

// PLplot's plP_script_scale: size and offset of the next super/subscript level.
function scriptScale(up, s) {
  const oldScale = s.level === 0 ? 1 : s.scale;
  const oldOffset = s.level === 0 ? 0 : s.offset;
  if ((s.level >= 0 && up) || (s.level <= 0 && !up)) {
    s.scale = 0.75 * oldScale;
    s.offset = oldOffset + oldScale;
  } else {
    s.scale = oldScale / 0.75;
    s.offset = oldOffset - s.scale;
  }
  s.level += up ? 1 : -1;
}

// Convert quick_plot text (PGPLOT escapes) to runs of {text, family, italic, mult, rise}.
// mult scales the font size and rise [in units of the font size] lifts the baseline.
function textToRuns(textIn) {
  let text = textIn.replace(/ +$/, "");
  if (isNumber(text)) text = text.replace(/-/g, "−");
  text = text.replace(/\\\./g, "\\u.\\d").replace(/\\x/g, "x");

  const runs = [];
  const script = { level: 0, scale: 1, offset: 0 };
  const stack = [];           // Open super/subscript spans.
  let family = 0, italic = false, upDown = 0, buf = "";

  const flush = () => {
    if (!buf) return;
    const top = stack.length ? stack[stack.length - 1] : { mult: 1, rise: 0 };
    runs.push({ text: buf, family, italic, mult: top.mult, rise: top.rise });
    buf = "";
  };
  const open = (up) => {
    scriptScale(up, script);
    const off = 0.5 * (1 - script.scale);
    const rise = up ? 0.8 * script.offset + off : -(0.8 * script.offset - off);
    stack.push({ mult: script.scale, rise });
  };

  for (let i = 0; i < text.length; ) {
    const ch = text[i];
    if (ch !== "\\" || i + 1 >= text.length) {
      buf += ch;
      i++;
      continue;
    }
    const e = text[i + 1];
    i += 2;
    switch (e) {
      case "u":
        flush();
        if (upDown < 0) { stack.pop(); script.level++; } else open(true);
        upDown++;
        break;
      case "d":
        flush();
        if (upDown > 0) { stack.pop(); script.level--; } else open(false);
        upDown--;
        break;
      case "f": case "F": {
        const k = text[i];
        if (!"nris".includes(k) || k === undefined) break;
        flush();
        family = k === "n" ? 0 : k === "s" ? 3 : 1;
        italic = k === "i";
        i++;
        break;
      }
      case "g": case "G": {
        const u = greekUnicode(text[i] || "");
        if (u) buf += String.fromCodePoint(u);
        i++;
        break;
      }
      case "(": {
        let code = 0;
        while (i < text.length && text[i] >= "0" && text[i] <= "9") code = 10 * code + Number(text[i++]);
        if (text[i] === ")") i++;
        if (HERSHEY[code]) buf += String.fromCodePoint(HERSHEY[code]);
        break;
      }
      case "A":
        buf += "Å";
        break;
      case "\\":
        buf += "\\";
        break;
      default:      // Unknown escape: dropped.
        break;
    }
  }
  flush();
  return runs;
}

/**
 * Draw a display list.
 *
 * @param {CanvasRenderingContext2D} ctx - Context to draw on.
 * @param {Uint8Array} list - Display list (op stream).
 * @param {number} width - Drawing width in ctx units.
 * @param {number} height - Drawing height in ctx units.
 * @param {object} [options]
 * @param {boolean} [options.stretch=true] - Stretch the page to fill width x height (positions are
 *   scaled separately in x and y; text, symbols and line widths keep their shape).
 */
export function renderDisplayList(ctx, list, width, height, options = {}) {
  const view = new DataView(list.buffer, list.byteOffset, list.byteLength);
  const decoder = new TextDecoder("utf-8");
  const stretch = options.stretch !== false;

  let pageW = 8.5, pageH = 11;
  let scale = 72, scaleX = 72, scaleY = 72, ox = 0, oy = 0;
  let depth = 0;
  const st = [defaultState()];

  const setView = () => {
    const sx = width / pageW, sy = height / pageH;
    scale = Math.min(sx, sy);
    if (stretch) {
      scaleX = sx; scaleY = sy; ox = 0; oy = 0;
    } else {
      scaleX = scaleY = scale;
      ox = 0.5 * (width - pageW * scale);
      oy = 0.5 * (height - pageH * scale);
    }
  };
  setView();

  const devX = (x) => ox + x * scaleX;
  const devY = (y) => oy + (pageH - y) * scaleY;
  const ptToDev = (pt) => (pt * scale) / 72.0;
  const cur = () => st[depth];
  const css = (rgb) => `rgb(${Math.round(255 * rgb[0])},${Math.round(255 * rgb[1])},${Math.round(255 * rgb[2])})`;

  const lineWidthDev = () => {
    const s = cur();
    return s.lineWidth <= 0 ? ptToDev(1) : s.lineWidth * LINE_WIDTH_UNIT * scale;
  };

  const solidLineStyle = () => {
    const color = css(cur().rgb);
    ctx.strokeStyle = color;
    ctx.fillStyle = color;
    ctx.lineWidth = lineWidthDev();
    ctx.lineJoin = "bevel";
    ctx.lineCap = "butt";
    ctx.setLineDash([]);
  };

  const lineStyle = () => {
    solidLineStyle();
    const p = cur().linePattern - 1;
    if (p < 1 || p > 4) return;
    ctx.setLineDash(DASHES[p].map((mm) => ptToDev(mm * MM)));
    ctx.lineCap = "round";
  };

  const beginClipped = () => {
    const s = cur();
    ctx.save();
    ctx.beginPath();
    if (s.clip) {
      const x1 = devX(s.graph[0]), x2 = devX(s.graph[1]);
      const y1 = devY(s.graph[2]), y2 = devY(s.graph[3]);
      ctx.rect(Math.min(x1, x2), Math.min(y1, y2), Math.abs(x2 - x1), Math.abs(y2 - y1));
      ctx.clip();
      ctx.beginPath();
    }
  };

  const fontOf = (run, fontSize) =>
    `${run.italic ? "italic " : ""}${fontSize * run.mult}px ${FAMILY[run.family]}`;

  const drawText = (x0, y0, angle, justify, text) => {
    const fontSize = TEXT_FONT_SCALE * cur().charSize;
    const runs = textToRuns(text);
    if (!runs.length) return;

    beginClipped();
    ctx.translate(devX(x0), devY(y0));
    ctx.rotate((-angle * Math.PI) / 180);
    ctx.scale(scale / 72, scale / 72);
    ctx.fillStyle = css(cur().rgb);
    ctx.textBaseline = "alphabetic";
    let total = 0;
    for (const run of runs) {
      ctx.font = fontOf(run, fontSize);
      run.width = ctx.measureText(run.text).width;
      total += run.width;
    }
    let x = -justify * total;
    for (const run of runs) {
      ctx.font = fontOf(run, fontSize);
      ctx.fillText(run.text, x, -run.rise * fontSize);
      x += run.width;
    }
    ctx.restore();
  };

  const drawHershey = (xd, yd, fontSize, v) => {
    const u = ptToDev(0.05 * fontSize);
    let penUp = true;
    solidLineStyle();
    ctx.beginPath();
    for (let k = 0; ; k += 2) {
      const cx = v[k], cy = v[k + 1];
      if (cx === 64 && cy === 64) break;
      if (cx === 64) { penUp = true; continue; }
      if (penUp) ctx.moveTo(xd + u * cx, yd - u * cy);
      else ctx.lineTo(xd + u * cx, yd - u * cy);
      penUp = false;
    }
    ctx.stroke();
  };

  const drawSymbol = (xi, yi, type) => {
    if (type < 0 || type > 18) return;
    const fontSize = SYM_FONT_SCALE * cur().symSize;
    const xd = devX(xi), yd = devY(yi);

    beginClipped();
    if (type === 10 || type === 14) {
      drawHershey(xd, yd, fontSize, type === 10 ? HERSHEY_SQUARE_CONCAVE : HERSHEY_RED_CROSS);
      ctx.restore();
      return;
    }
    ctx.translate(xd, yd);
    ctx.scale(scale / 72, scale / 72);
    ctx.fillStyle = css(cur().rgb);
    ctx.font = `${fontSize}px sans-serif`;
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(String.fromCodePoint(SYMBOL_GLYPH[type]), 0, 0);
    ctx.restore();
  };

  const hatch = (x1, y1, x2, y2, angleDeg) => {
    const sp = ptToDev(2.0 * MM);
    const a = (angleDeg * Math.PI) / 180, ca = Math.cos(a), sa = Math.sin(a);
    const cx = 0.5 * (x1 + x2), cy = 0.5 * (y1 + y2);
    const rad = 0.5 * Math.hypot(x2 - x1, y2 - y1);
    for (let t = -rad; t <= rad; t += sp) {
      const px = cx + t * sa, py = cy + t * ca;
      ctx.moveTo(px - rad * ca, py + rad * sa);
      ctx.lineTo(px + rad * ca, py - rad * sa);
    }
  };

  const drawRect = (xa, xb, ya, yb, fill) => {
    const x1 = Math.min(devX(xa), devX(xb)), x2 = Math.max(devX(xa), devX(xb));
    const y1 = Math.min(devY(ya), devY(yb)), y2 = Math.max(devY(ya), devY(yb));

    beginClipped();
    solidLineStyle();
    ctx.beginPath();
    ctx.rect(x1, y1, x2 - x1, y2 - y1);
    if (fill === NO_FILL) {
      ctx.stroke();
    } else if (fill === HATCHED || fill === CROSS_HATCHED) {
      ctx.clip();
      ctx.beginPath();
      hatch(x1, y1, x2, y2, 45);
      if (fill === CROSS_HATCHED) hatch(x1, y1, x2, y2, -45);
      ctx.stroke();
    } else {
      ctx.fill();
      ctx.stroke();
    }
    ctx.restore();
  };

  const drawPolyline = (n, off) => {
    if (n < 2) return;
    beginClipped();
    lineStyle();
    if (n === 2) ctx.lineCap = "round";
    ctx.beginPath();
    for (let i = 0; i < n; i++) {
      const x = devX(view.getFloat64(off + 8 * i, true));
      const y = devY(view.getFloat64(off + 8 * (n + i), true));
      if (i === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    }
    ctx.stroke();
    ctx.restore();
  };

  const drawArrow = (a, filled) => {
    const x1 = devX(a[0]), y1 = devY(a[1]), x2 = devX(a[2]), y2 = devY(a[3]);
    const half = (0.5 * a[4] * Math.PI) / 180, barb = a[5];
    const len = a[6] * ARROW_HEAD_LEN * scale;
    const dx = x2 - x1, dy = y2 - y1, d = Math.hypot(dx, dy);
    if (d === 0) return;
    const ux = dx / d, uy = dy / d, nx = -uy, ny = ux;
    const w = len * Math.tan(half);

    beginClipped();
    lineStyle();
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2 - ux * len * (1 - barb), y2 - uy * len * (1 - barb));
    ctx.stroke();

    solidLineStyle();
    ctx.beginPath();
    ctx.moveTo(x2, y2);
    ctx.lineTo(x2 - ux * len + nx * w, y2 - uy * len + ny * w);
    ctx.lineTo(x2 - ux * len * (1 - barb), y2 - uy * len * (1 - barb));
    ctx.lineTo(x2 - ux * len - nx * w, y2 - uy * len - ny * w);
    ctx.closePath();
    if (filled) ctx.fill();
    else ctx.stroke();
    ctx.restore();
  };

  const readState = (off) => ({
    rgb: [view.getFloat64(off, true), view.getFloat64(off + 8, true), view.getFloat64(off + 16, true)],
    lineWidth: view.getFloat64(off + 24, true),
    linePattern: view.getInt32(off + 32, true),
    clip: view.getInt32(off + 36, true),
    graph: [0, 1, 2, 3].map((i) => view.getFloat64(off + 40 + 8 * i, true)),
    charSize: view.getFloat64(off + 72, true),
    symSize: view.getFloat64(off + 80, true),
  });

  const d = (off, i) => view.getFloat64(off + 8 * i, true);

  for (let off = 0; off + 5 <= list.length; ) {
    const op = list[off];
    const plen = view.getUint32(off + 1, true);
    const p = off + 5;
    if (p + plen > list.length) break;
    off = p + plen;
    const s = cur();

    switch (op) {
      case OP.PAGE:
        pageW = d(p, 0);
        pageH = d(p, 1);
        setView();
        break;
      case OP.CLEAR:
        ctx.save();
        ctx.fillStyle = "#fff";
        ctx.fillRect(ox, oy, pageW * scaleX, pageH * scaleY);
        ctx.restore();
        break;
      case OP.STATE:
        if (plen >= 88) st[depth] = readState(p);
        break;
      case OP.PUSH:
        st[depth + 1] = { ...s, rgb: [...s.rgb], graph: [...s.graph] };
        depth++;
        break;
      case OP.POP:
        if (depth > 0) depth--;
        break;
      case OP.COLOR:
        s.rgb = [d(p, 0), d(p, 1), d(p, 2)];
        break;
      case OP.LINE_WIDTH:
        s.lineWidth = d(p, 0);
        break;
      case OP.LINE_PATTERN:
        s.linePattern = view.getInt32(p, true);
        break;
      case OP.CLIP:
        s.clip = view.getInt32(p, true);
        break;
      case OP.GRAPH_POS:
        s.graph = [d(p, 0), d(p, 1), d(p, 2), d(p, 3)];
        break;
      case OP.CHAR_SIZE:
        s.charSize = d(p, 0);
        break;
      case OP.SYM_SIZE:
        s.symSize = d(p, 0);
        break;
      case OP.POLYLINE:
        drawPolyline(view.getInt32(p, true), p + 4);
        break;
      case OP.RECT:
        drawRect(d(p, 0), d(p, 1), d(p, 2), d(p, 3), view.getInt32(p + 32, true));
        break;
      case OP.SYMBOL:
        drawSymbol(d(p, 0), d(p, 1), view.getInt32(p + 16, true));
        break;
      case OP.TEXT: {
        const n = view.getInt32(p + 32, true);
        const text = decoder.decode(list.subarray(p + 36, p + 36 + n));
        drawText(d(p, 0), d(p, 1), d(p, 2), d(p, 3), text);
        break;
      }
      case OP.ARROW:
        drawArrow([0, 1, 2, 3, 4, 5, 6].map((i) => d(p, i)), view.getInt32(p + 56, true));
        break;
      default:
        break;
    }
  }
}
