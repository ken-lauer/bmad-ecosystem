// Page logic for Tao in the browser: starts the worker, runs commands, shows output and plots.

import { renderDisplayList } from "./qp_render.js";

const $ = (id) => document.getElementById(id);

const el = {
  example: $("example"), initArgs: $("init-args"), start: $("start"), upload: $("upload"),
  uploadInput: $("upload-input"), status: $("status"), canvas: $("plot"), plotHolder: $("plot-holder"),
  plotEmpty: $("plot-empty"), plotRegion: $("plot-region"), plotTemplate: $("plot-template"),
  plotPlace: $("plot-place"), plotScale: $("plot-scale"), plotXScale: $("plot-xscale"),
  output: $("output"), completions: $("completions"), form: $("command-form"), command: $("command"),
  fileList: $("file-list"), fileSave: $("file-save"), fileText: $("file-text"), fileNote: $("file-note"),
};

const MAX_OUTPUT_LINES = 5000;

let worker = null;
let nextId = 1;
const pending = new Map();
let queue = Promise.resolve();
let running = false;
let examples = {};
let workDir = "/work";
let plot = null;
const history = [];
let historyIndex = 0;

// ---------------------------------------------------------------------------
// Worker

function startWorker() {
  if (worker) worker.terminate();
  for (const { reject } of pending.values()) reject(new Error("Tao was restarted"));
  pending.clear();
  worker = new Worker("tao_worker.js", { type: "module" });
  worker.onmessage = (event) => {
    const msg = event.data;
    if (msg.type === "plot") return showPlot(msg);
    if (msg.type === "stdout") return print(msg.text);
    if (msg.type === "stderr") return print(msg.text, "error");
    const entry = pending.get(msg.id);
    if (!entry) return;
    pending.delete(msg.id);
    if (msg.ok) entry.resolve(msg);
    else entry.reject(new Error(msg.error));
  };
  worker.onerror = (event) => {
    setStatus("error", "Tao crashed");
    print(`Worker error: ${event.message}`, "error");
  };
}

function call(type, args = {}) {
  return new Promise((resolve, reject) => {
    const id = nextId++;
    pending.set(id, { resolve, reject });
    worker.postMessage({ id, type, ...args });
  });
}

// Requests are run one at a time, in order.
function enqueue(task) {
  const result = queue.then(task);
  queue = result.catch(() => {});
  return result;
}

// ---------------------------------------------------------------------------
// Console

function setStatus(kind, text) {
  el.status.className = kind;
  el.status.textContent = text;
}

function print(text, cls) {
  const atBottom = el.output.scrollHeight - el.output.scrollTop - el.output.clientHeight < 40;
  const line = document.createElement("span");
  if (cls) line.className = cls;
  line.textContent = `${text}\n`;
  el.output.append(line);
  while (el.output.childNodes.length > MAX_OUTPUT_LINES) el.output.firstChild.remove();
  if (atBottom) el.output.scrollTop = el.output.scrollHeight;
}

function printLines(lines) {
  for (const line of lines) print(line, /^\[(ERROR|FATAL|ABORT)/.test(line) ? "error" : undefined);
}

function runCommand(command, { echo = true } = {}) {
  return enqueue(async () => {
    if (!running) return null;
    if (echo) print(`Tao> ${command}`, "echo");
    setStatus("busy", "Running…");
    try {
      const result = await call("command", { command });
      printLines(result.lines);
      setStatus("ready", "Ready");
      return result;
    } catch (error) {
      print(String(error.message || error), "error");
      setStatus("error", "Tao stopped. Press Start Tao to restart.");
      setRunning(false);
      return null;
    }
  });
}

// Run a "pipe" command and return its output lines without showing them.
function pipe(command) {
  return enqueue(async () => {
    if (!running) return [];
    try {
      return (await call("command", { command: `pipe ${command}` })).lines;
    } catch {
      return [];
    }
  });
}

function setRunning(on) {
  running = on;
  for (const node of [el.command, el.plotPlace, el.plotScale, el.plotXScale]) node.disabled = !on;
  el.command.placeholder = on ? "Type a Tao command. Tab completes, up arrow recalls." : "Press Start Tao first.";
  if (on) el.command.focus();
}

// ---------------------------------------------------------------------------
// Plot

function showPlot(msg) {
  plot = msg;
  el.plotEmpty.hidden = true;
  drawPlot();
}

function drawPlot() {
  const rect = el.plotHolder.getBoundingClientRect();
  const ratio = window.devicePixelRatio || 1;
  const width = Math.max(1, Math.round(rect.width)), height = Math.max(1, Math.round(rect.height));
  if (el.canvas.width !== width * ratio || el.canvas.height !== height * ratio) {
    el.canvas.width = width * ratio;
    el.canvas.height = height * ratio;
  }
  const ctx = el.canvas.getContext("2d");
  ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
  ctx.fillStyle = "#fff";
  ctx.fillRect(0, 0, width, height);
  if (plot) renderDisplayList(ctx, plot.list, width, height);
}

async function refreshPlotLists() {
  const fill = (select, names) => {
    const previous = select.value;
    select.replaceChildren(...names.map((name) => new Option(name, name)));
    if (names.includes(previous)) select.value = previous;
  };
  // Lines are "index;name[;...]".
  const names = (lines) => lines.map((line) => line.split(";")[1]).filter(Boolean);
  fill(el.plotRegion, names(await pipe("plot_list r")));
  fill(el.plotTemplate, names(await pipe("plot_list t")));
}

// ---------------------------------------------------------------------------
// Files

async function refreshFiles(select) {
  if (!worker) return;
  const { files } = await enqueue(() => call("listFiles", { dir: workDir }));
  const names = files.map((path) => path.slice(workDir.length + 1)).sort();
  el.fileList.replaceChildren(...names.map((name) => new Option(name, name)));
  const wanted = select && names.includes(select) ? select : names.find((n) => /\.bmad$/.test(n)) || names[0];
  if (wanted) {
    el.fileList.value = wanted;
    await openFile(wanted);
  } else {
    el.fileText.value = "";
  }
  el.fileSave.disabled = !names.length;
}

async function openFile(name) {
  try {
    const { text } = await enqueue(() => call("readFile", { path: `${workDir}/${name}` }));
    el.fileText.value = text;
    el.fileNote.textContent = "";
  } catch (error) {
    el.fileText.value = "";
    el.fileNote.textContent = "Cannot show this file.";
  }
}

async function saveFile() {
  const name = el.fileList.value;
  if (!name) return;
  await enqueue(() => call("writeFiles", { files: { [`${workDir}/${name}`]: el.fileText.value } }));
  el.fileNote.textContent = `Saved ${name}. Press Start Tao to use it.`;
}

async function addFiles(fileList) {
  const files = {};
  for (const file of fileList) files[`${workDir}/${file.name}`] = new Uint8Array(await file.arrayBuffer());
  await enqueue(() => call("writeFiles", { files }));
  print(`Added ${Object.keys(files).length} file(s) to ${workDir}`, "note");
  await refreshFiles(fileList[0] && fileList[0].name);
}

// ---------------------------------------------------------------------------
// Starting Tao

// The Fortran side keeps global state, so every start uses a fresh WebAssembly instance.
// Files of the previous instance are carried over.
async function startTao() {
  const args = el.initArgs.value.trim();
  el.start.disabled = true;
  setRunning(false);
  setStatus("busy", "Starting Tao…");

  let files = {};
  if (worker) {
    try {
      const listed = await enqueue(() => call("listFiles", { dir: workDir }));
      for (const path of listed.files) {
        files[path] = (await enqueue(() => call("readFile", { path }))).text;
      }
    } catch {
      files = {};
    }
  } else {
    files = exampleFiles(el.example.value);
  }

  startWorker();
  queue = Promise.resolve();
  plot = null;
  try {
    await call("load");
    await call("writeFiles", { files });
    await call("chdir", { dir: workDir });
    print(`Tao> (start) ${args}`, "echo");
    const result = await call("init", { args });
    printLines(result.lines);
    if (result.err) {
      setStatus("error", "Tao failed to start: see the console");
    } else {
      setRunning(true);
      setStatus("ready", "Ready");
      await refreshPlotLists();
    }
  } catch (error) {
    print(String(error.message || error), "error");
    setStatus("error", "Tao failed to start");
  }
  el.start.disabled = false;
  await refreshFiles(el.fileList.value);
}

function exampleFiles(name) {
  const files = {};
  const example = examples[name];
  if (!example) return files;
  for (const [path, text] of Object.entries(example.files)) files[`${workDir}/${path}`] = text;
  return files;
}

async function selectExample() {
  const example = examples[el.example.value];
  if (!example) return;
  el.initArgs.value = example.args;
  if (worker) worker.terminate();
  worker = null;
  setRunning(false);
  setStatus("ready", "Press Start Tao");
}

// ---------------------------------------------------------------------------
// Command line: history and tab completion.

async function complete() {
  const line = el.command.value;
  const point = el.command.selectionStart;
  let result;
  try {
    result = await enqueue(() => call("complete", { line, point }));
  } catch {
    return;
  }
  const { start, prefix, candidates } = result;
  if (!candidates.length) {
    el.completions.hidden = true;
    return;
  }
  const insert = candidates.length === 1 ? `${candidates[0]} ` : prefix;
  if (insert.length > point - start) {
    el.command.value = line.slice(0, start) + insert + line.slice(point);
    el.command.selectionStart = el.command.selectionEnd = start + insert.length;
  }
  if (candidates.length > 1) {
    el.completions.replaceChildren(...candidates.map((c) => Object.assign(document.createElement("div"), { textContent: c })));
    el.completions.hidden = false;
  } else {
    el.completions.hidden = true;
  }
}

el.command.addEventListener("keydown", (event) => {
  if (event.key === "Tab") {
    event.preventDefault();
    if (running) complete();
  } else if (event.key === "ArrowUp" && historyIndex > 0) {
    event.preventDefault();
    el.command.value = history[--historyIndex];
  } else if (event.key === "ArrowDown" && historyIndex < history.length) {
    event.preventDefault();
    historyIndex++;
    el.command.value = historyIndex < history.length ? history[historyIndex] : "";
  } else if (event.key !== "Shift") {
    el.completions.hidden = true;
  }
});

el.form.addEventListener("submit", async (event) => {
  event.preventDefault();
  const command = el.command.value.trim();
  if (!command || !running) return;
  history.push(command);
  historyIndex = history.length;
  el.command.value = "";
  el.completions.hidden = true;
  if (/^(exit|quit)\b/i.test(command)) {
    print(`Tao> ${command}`, "echo");
    print("Tao cannot exit in the browser. Press Start Tao to restart it.", "note");
    return;
  }
  await runCommand(command);
  if (/^\s*(pl|place|cl|clear|re|read|ca|call)/i.test(command)) refreshPlotLists();
});

// ---------------------------------------------------------------------------
// Wiring

for (const button of document.querySelectorAll("#quick button")) {
  button.addEventListener("click", () => runCommand(button.dataset.cmd));
}

el.plotPlace.addEventListener("click", () => {
  if (el.plotRegion.value && el.plotTemplate.value) runCommand(`place ${el.plotRegion.value} ${el.plotTemplate.value}`);
});
el.plotScale.addEventListener("click", () => runCommand("scale all"));
el.plotXScale.addEventListener("click", () => runCommand("x_scale all"));

el.start.addEventListener("click", startTao);
el.example.addEventListener("change", selectExample);
el.upload.addEventListener("click", () => el.uploadInput.click());
el.uploadInput.addEventListener("change", async () => {
  if (!worker) {
    print("Start Tao (or pick an example) before adding files.", "note");
    return;
  }
  await addFiles(el.uploadInput.files);
  el.uploadInput.value = "";
});
el.fileList.addEventListener("change", () => openFile(el.fileList.value));
el.fileSave.addEventListener("click", saveFile);

for (const tab of document.querySelectorAll('[role="tab"]')) {
  tab.addEventListener("click", () => {
    for (const other of document.querySelectorAll('[role="tab"]')) {
      const selected = other === tab;
      other.setAttribute("aria-selected", String(selected));
      $(other.getAttribute("aria-controls")).hidden = !selected;
    }
  });
}

new ResizeObserver(drawPlot).observe(el.plotHolder);

async function main() {
  try {
    examples = await (await fetch("examples.json")).json();
  } catch {
    examples = {};
  }
  el.example.replaceChildren(...Object.keys(examples).map((name) => new Option(name, name)));

  // The page can be opened in a given state: ?example=fodo&start&cmd=show+lattice
  const params = new URLSearchParams(location.search);
  if (examples[params.get("example")]) el.example.value = params.get("example");
  else if (examples.fodo) el.example.value = "fodo";
  await selectExample();
  if (params.has("args")) el.initArgs.value = params.get("args");
  el.start.disabled = false;
  setStatus("ready", "Press Start Tao");
  if (params.has("start")) {
    await startTao();
    for (const command of params.getAll("cmd")) await runCommand(command);
  }
}

main();
