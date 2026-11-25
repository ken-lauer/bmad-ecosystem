// Smoke test of the Tao web page in headless Chrome.
//
// Usage: node wasm/test/browser_check.mjs <url> <screenshot.png> [width height]
//
// Opens the URL (EG http://127.0.0.1:8000/?example=fodo&start&cmd=show+lattice), waits until
// Tao is ready and the command queue is empty, saves a screenshot and prints the page status,
// the end of the console output and any JavaScript errors. Exit status 1 if Tao did not get ready.
//
// Needs Chrome: set CHROME to the executable if it is not in the standard place.

import { spawn } from "node:child_process";
import fs from "node:fs";
import os from "node:os";
import path from "node:path";

const [url, shot, width = "1400", height = "900"] = process.argv.slice(2);
if (!url || !shot) {
  console.error("Usage: node browser_check.mjs <url> <screenshot.png> [width height]");
  process.exit(2);
}

const chrome =
  process.env.CHROME ||
  ["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", "/usr/bin/google-chrome", "/usr/bin/chromium"].find(
    (candidate) => fs.existsSync(candidate),
  );
const profile = fs.mkdtempSync(path.join(os.tmpdir(), "tao-web-check-"));
const port = 9300 + Math.floor(Math.random() * 500);
const browser = spawn(
  chrome,
  [
    "--headless=new", "--no-first-run", `--user-data-dir=${profile}`, `--remote-debugging-port=${port}`,
    `--window-size=${width},${height}`, "about:blank",
  ],
  { stdio: "ignore" },
);

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function pageSocket() {
  for (let i = 0; i < 100; i++) {
    try {
      const targets = await (await fetch(`http://127.0.0.1:${port}/json`)).json();
      const page = targets.find((target) => target.type === "page");
      if (page) return page.webSocketDebuggerUrl;
    } catch {
      // Chrome is not listening yet.
    }
    await sleep(100);
  }
  throw new Error("Chrome did not start");
}

const socket = new WebSocket(await pageSocket());
await new Promise((resolve) => socket.addEventListener("open", resolve));
let nextId = 1;
const waiting = new Map();
const errors = [];
socket.addEventListener("message", (event) => {
  const message = JSON.parse(event.data);
  if (message.id && waiting.has(message.id)) {
    waiting.get(message.id)(message.result);
    waiting.delete(message.id);
  } else if (message.method === "Runtime.exceptionThrown") {
    errors.push(message.params.exceptionDetails.exception?.description || message.params.exceptionDetails.text);
  } else if (message.method === "Runtime.consoleAPICalled" && message.params.type === "error") {
    errors.push(message.params.args.map((arg) => arg.value ?? arg.description).join(" "));
  }
});
const send = (method, params = {}) =>
  new Promise((resolve) => {
    const id = nextId++;
    waiting.set(id, resolve);
    socket.send(JSON.stringify({ id, method, params }));
  });
const evaluate = async (expression) =>
  (await send("Runtime.evaluate", { expression, returnByValue: true, awaitPromise: true })).result?.value;

await send("Runtime.enable");
await send("Page.enable");
await send("Emulation.setDeviceMetricsOverride", {
  width: Number(width), height: Number(height), deviceScaleFactor: 2, mobile: false,
});
await send("Page.navigate", { url });

let status = "";
for (let i = 0; i < 1200; i++) {
  await sleep(100);
  status = (await evaluate("document.getElementById('status')?.textContent")) || "";
  if (/^(Ready|Tao failed|Tao stopped|Tao crashed)/.test(status)) {
    // Commands given in the URL may still be running or queued.
    await sleep(500);
    status = await evaluate("document.getElementById('status').textContent");
    if (status !== "Running…") break;
  }
}

const output = await evaluate("document.getElementById('output').textContent");
const png = await send("Page.captureScreenshot", { format: "png" });
fs.writeFileSync(shot, Buffer.from(png.data, "base64"));

console.log(`status: ${status}`);
console.log(output.split("\n").slice(-12).join("\n"));
for (const error of errors) console.log(`JS ERROR: ${error}`);

socket.close();
await new Promise((resolve) => {
  browser.once("exit", resolve);
  browser.kill();
});
fs.rmSync(profile, { recursive: true, force: true, maxRetries: 10, retryDelay: 200 });
process.exit(status === "Ready" && errors.length === 0 ? 0 : 1);
