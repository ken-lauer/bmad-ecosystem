// Web worker that owns the Tao WebAssembly instance.
//
// Tao runs synchronously, so it lives in a worker to keep the page responsive. The page talks to
// it with messages: {id, type, ...} in, {id, ok, ...} out. Plots are pushed as {type: "plot"}.

import createTaoModule from "./tao.js";

let tao = null;
let api = null;

function post(message, transfer) {
  self.postMessage(message, transfer || []);
}

async function load() {
  tao = await createTaoModule({
    print: (text) => post({ type: "stdout", text }),
    printErr: (text) => post({ type: "stderr", text }),
    taoPlot: (list, widthIn, heightIn) => post({ type: "plot", list, widthIn, heightIn }, [list.buffer]),
  });
  api = {
    init: tao.cwrap("tao_c_init_tao", "number", ["string"]),
    command: tao.cwrap("tao_c_command", "number", ["string"]),
    numLines: tao.cwrap("tao_c_out_io_buffer_num_lines", "number", []),
    getLine: tao.cwrap("tao_c_out_io_buffer_get_line", "string", ["number"]),
    reset: tao.cwrap("tao_c_out_io_buffer_reset", null, []),
    plotSync: tao.cwrap("tao_web_plot_sync", null, []),
    complete: tao.cwrap("tao_web_complete", "string", ["string", "number", "number"]),
  };
  tao.FS.mkdirTree("/work");
  tao.FS.chdir("/work");
}

function takeOutput() {
  const lines = [];
  const n = api.numLines();
  for (let i = 1; i <= n; i++) lines.push(api.getLine(i));
  api.reset();
  return lines;
}

function writeFiles(files) {
  for (const [name, data] of Object.entries(files)) {
    const path = name.startsWith("/") ? name : `/work/${name}`;
    tao.FS.mkdirTree(path.slice(0, path.lastIndexOf("/")) || "/");
    tao.FS.writeFile(path, data);
  }
}

function listFiles(dir) {
  const found = [];
  for (const name of tao.FS.readdir(dir)) {
    if (name === "." || name === "..") continue;
    const path = `${dir}/${name}`;
    if (tao.FS.isDir(tao.FS.stat(path).mode)) found.push(...listFiles(path));
    else found.push(path);
  }
  return found;
}

const handlers = {
  async load() {
    await load();
    return {};
  },
  writeFiles({ files }) {
    writeFiles(files);
    return {};
  },
  readFile({ path }) {
    return { text: tao.FS.readFile(path, { encoding: "utf8" }) };
  },
  listFiles({ dir }) {
    return { files: listFiles(dir || "/work") };
  },
  chdir({ dir }) {
    tao.FS.chdir(dir);
    return {};
  },
  init({ args }) {
    const err = api.init(args);
    const lines = takeOutput();
    api.plotSync();
    return { err, lines };
  },
  command({ command }) {
    const err = api.command(command);
    const lines = takeOutput();
    api.plotSync();
    return { err, lines };
  },
  complete({ line, point }) {
    const startPtr = tao._malloc(4);
    const text = api.complete(line, point, startPtr);
    const start = tao.HEAP32[startPtr >> 2];
    tao._free(startPtr);
    const [prefix, ...candidates] = text ? text.split("\n").filter((s, i) => i === 0 || s) : [""];
    return { start, prefix, candidates };
  },
};

self.onmessage = async (event) => {
  const { id, type, ...args } = event.data;
  try {
    const result = await handlers[type](args);
    post({ id, ok: true, ...result });
  } catch (error) {
    post({ id, ok: false, error: String(error && error.stack ? error.stack : error) });
  }
};
