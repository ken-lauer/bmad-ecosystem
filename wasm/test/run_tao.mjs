// Run Tao (WebAssembly) under node on a directory of input files and print the output.
//
// Usage: node wasm/test/run_tao.mjs <directory> "<tao startup arguments>" [command ...]
//
// The directory is copied into the in-memory file system of the WebAssembly module, Tao is
// started in it, and the commands are run one after the other. The number of bytes of plot
// display list produced by each command is reported. The exit status is 1 if Tao fails to start.

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const { default: createTaoModule } = await import(path.join(here, "..", "build", "tao.js"));

const [directory, args, ...commands] = process.argv.slice(2);
if (!directory || args === undefined) {
  console.error('Usage: node run_tao.mjs <directory> "<tao startup arguments>" [command ...]');
  process.exit(2);
}

let plotBytes = 0;
const tao = await createTaoModule({
  taoPlot: (list) => {
    plotBytes = list.length;
    if (process.env.TAO_PLOT_OUT) fs.writeFileSync(process.env.TAO_PLOT_OUT, list);
  },
});

function copyIn(from, to) {
  tao.FS.mkdirTree(to);
  for (const entry of fs.readdirSync(from, { withFileTypes: true })) {
    if (entry.isDirectory()) copyIn(path.join(from, entry.name), `${to}/${entry.name}`);
    else tao.FS.writeFile(`${to}/${entry.name}`, fs.readFileSync(path.join(from, entry.name)));
  }
}

copyIn(directory, "/work");
tao.FS.chdir("/work");

const init = tao.cwrap("tao_c_init_tao", "number", ["string"]);
const command = tao.cwrap("tao_c_command", "number", ["string"]);
const numLines = tao.cwrap("tao_c_out_io_buffer_num_lines", "number", []);
const getLine = tao.cwrap("tao_c_out_io_buffer_get_line", "string", ["number"]);
const reset = tao.cwrap("tao_c_out_io_buffer_reset", null, []);
const plotSync = tao.cwrap("tao_web_plot_sync", null, []);

function run(label, call) {
  const start = performance.now();
  plotBytes = 0;
  const err = call();
  const n = numLines();
  const lines = [];
  for (let i = 1; i <= n; i++) lines.push(getLine(i));
  reset();
  plotSync();
  const ms = (performance.now() - start).toFixed(0);
  console.log(`==== ${label}  [err=${err}, ${ms} ms, plot=${plotBytes} bytes]`);
  if (lines.length) console.log(lines.join("\n"));
  return err;
}

const err = run(`tao ${args}`, () => init(args));
for (const cmd of commands) run(cmd, () => command(cmd));
// Not process.exit(): that drops output still buffered when stdout is a pipe.
process.exitCode = err ? 1 : 0;
