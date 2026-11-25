# Patches for the WebAssembly Fortran compiler

Applied by `wasm/build_toolchain.sh` on top of https://github.com/r-wasm/llvm-project (branch `wasm`).

- `flang-iso_c_binding-wasm32.patch`: `c_long` and `c_size_t` (and so `c_intptr_t`, `c_ptrdiff_t`)
  are 32 bit on wasm32. Without this, calls to C functions taking these types have the wrong signature.
- `flang-wasm32-bind-c-struct.patch`: passing and returning `BIND(C)` derived types by value
  (needed by FGSL), following the C ABI used by Emscripten.
- `flang-wasm32-bind-c-character.patch`: flang passes the hidden length of a `CHARACTER` argument
  also to `BIND(C)` procedures. That is harmless elsewhere, but in WebAssembly a call whose signature
  differs from the callee does not link (it traps at run time). The length is left out for wasm.
