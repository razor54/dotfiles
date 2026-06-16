# Go DAP Workflow (Neovim 0.12)

This document describes the current Go debugging behavior in this Neovim config.

## Scope and Guardrails

- Go DAP is configured in `lua/plugins/dap/settings/go-debug-adapter.lua`.
- Active DAP loader is `lua/plugins/dap/nvim-dap.lua`.
- Python debug adapter (`debugpy`) is **not** actively loaded in the DAP chain.
- No `Documents/documents` hardcoded path rewrites are used.
- No `substitutePath` mapping hacks are used.

## Keymaps

- `<leader>db` — toggle breakpoint
- `<leader>dc` — continue / start debug
- `<leader>dl` — run last
- `<leader>dd` — toggle DAP UI

## Go Debug Behavior

### 1) Adapter resolution

`dap.adapters.go` resolves Delve in this order:

1. Mason binary: `~/.local/share/nvim/mason/bin/dlv`
2. System `dlv` from `$PATH`

If no executable is available, adapter startup fails and DAP reports connection failure.

### 2) Deterministic root/cwd policy

- Program directory = current buffer directory
- CWD = nearest ancestor containing `go.mod` or `go.work`
- If no module/workspace marker is found, launch is blocked with explicit guidance

For `~/Documents/go-leetcode/challenges/...`, this resolves CWD to `.../challenges` and program to the challenge directory.

### 3) Launch configurations

- **Debug (requires main)**
  - `mode = "debug"`
  - Requires `func main()` in current program directory
  - If no `main()` exists, launch is blocked with an explicit error

- **Debug Test**
  - `mode = "test"`
  - Runs package tests in current program directory
  - Uses `-test.v` for verbose test output

### 4) Go launch selection (`<leader>dc`)

When `<leader>dc` is used in a Go buffer and no session is running, it opens a **Go DAP launch selector**.

Typical options include:

- `Debug current file main`
- `Debug package main`
- `Debug package tests`
- `Debug nearest test` (only when cursor is inside a test function in `*_test.go`)
- `Show default DAP config picker`

When a session is already running, `<leader>dc` behaves as normal continue.

### 5) Output routing

Go launch configs set:

- `console = "integratedTerminal"`
- `outputMode = "remote"`

This gives practical visibility in DAP UI for Go runs:

- runtime output appears in the DAP UI terminal/console area
- Delve stdout/stderr output events (for example `fmt.Printf` output) are also emitted remotely

You can keep DAP UI open with `<leader>dd` while launching.

## Troubleshooting

### DAP starts but exits immediately

- In `mode=debug`, this usually means program ended normally (no breakpoint hit).
- Set a breakpoint earlier in execution (`<leader>db`) and rerun.

### No main function error

- You are using `Debug (requires main)` in a package without `func main()`.
- Use `<leader>dc` from a `*_test.go` file (nearest-test flow) or choose `Debug Test`.

### Build error: main redeclared in this block

- This is a Go package compile error, not a DAP wiring error.
- It happens when multiple files in the same package each declare `func main()` (for example `foo.go` and `foo_optimized.go`).
- To debug tests in that directory, keep only one `main()` or move one variant to a different package/file set.

### Module root not found

- You launched from a directory outside any `go.mod` / `go.work` workspace.
- Move the file into a Go module/workspace or open Neovim from a valid module tree.

### Missing Delve adapter

- Ensure one of these exists:
  - `~/.local/share/nvim/mason/bin/dlv`
  - `dlv` in `$PATH`

### Verify launch payload quickly

Check DAP log:

- `~/.cache/nvim/dap.log`

Look for launch fields:

- `mode`
- `program`
- `cwd`
- `args`
- `console = "integratedTerminal"`
