# Second Machine Readiness

## Ownership

| Scope | Owner | Checks |
| --- | --- | --- |
| Shared macOS runtime/tooling | `~/configs/mac-devops-setup` | `nvim`, `java`, `mvn`, `node` |
| Neovim editor assets | this repo + Mason | `jdtls`, `java-debug-adapter`, `java-test`, `lombok-nightly` |
| Markdown parser state | this repo + Treesitter | `markdown`, `markdown_inline`, `html` |
| Optional markdown rendering | shared macOS + terminal | `mmdc`, `magick`, Kitty or WezTerm-compatible UI |

## Preflight, before upgrading to Neovim 0.12

### Shared macOS prerequisites

Run these first. If one fails, stop here and fix `mac-devops-setup`.

```sh
command -v nvim && nvim --version
command -v java && java -version
command -v mvn && mvn -version
command -v node && node --version
```

Optional mermaid/image prerequisites:

```sh
command -v mmdc
command -v magick
printf 'TERM_PROGRAM=%s\nTERM=%s\nKITTY_WINDOW_ID=%s\n' "$TERM_PROGRAM" "$TERM" "$KITTY_WINDOW_ID"
```

### Neovim and Mason prerequisites

Run these after the shared checks pass.

```sh
nvim --headless "+qall"
nvim --headless "+checkhealth mason" "+qall"
nvim --headless "+lua print(vim.inspect(require('utils.java_mason').readiness_summary()))" "+qall"
```

Pass conditions:

- `jdtls_ready = true`
- `bundles_ready = true`
- `missing_packages = {}`
- `broken_packages = {}`

## Postflight, after upgrading to Neovim 0.12

Run the full set again, then run the 0.12 smoke tests below.

```sh
nvim --headless "+qall"
nvim --headless "+e README.md" "+sleep 200m" "+qall"
nvim --headless "+e README.md" "+lua pcall(vim.cmd, 'Markview enable')" "+qall"
```

Pass conditions:

- headless startup exits cleanly
- `README.md` opens without Treesitter runtime errors
- `Markview enable` does not crash
- no `noice.nvim` markdown override regression appears during markdown open/use

## Java verification, separate from markdown

Use a real Java project, not this repo.

Interactive check:

```sh
nvim /path/to/project/src/main/java/.../Main.java
```

Inside Neovim:

```vim
:JdtHealth
```

Pass conditions:

- `jdtls_ready = true`
- `bundles_ready = true`
- `missing_packages` is empty
- `broken_packages` is empty

If `bundles_ready = false`, JDTLS may still start, but Java debug/test is not ready yet.

## Markdown sanity, separate from Java

Mandatory smoke tests:

```sh
nvim --headless "+e README.md" "+sleep 200m" "+qall"
nvim --headless "+e README.md" "+lua pcall(vim.cmd, 'Markview enable')" "+qall"
```

Optional mermaid/image smoke test, only if `mmdc`, `magick`, and a compatible terminal are present:

1. Open any markdown file containing a fenced `mermaid` block.
2. Move the cursor into and out of the block.
3. Confirm plain markdown editing still works and the renderer only activates when the backend is ready.

## Failure classification

| Failure | Classify as | Notes |
| --- | --- | --- |
| `nvim`, `java`, `mvn`, or `node` missing | shared macOS issue | Fix via `mac-devops-setup` |
| `mmdc` or `magick` missing | shared macOS issue | Only affects optional mermaid/image rendering |
| Unsupported terminal backend for image rendering | shared macOS issue | Kitty protocol support is environment-dependent |
| `jdtls_ready = false` because launcher/config/lombok is missing | Neovim/Mason issue | Mason package contents are incomplete or broken |
| `missing_packages` or `broken_packages` in `:JdtHealth` | Neovim/Mason issue | Reinstall or let Mason finish install |
| `bundles_ready = false` with JDTLS otherwise up | Neovim/Mason issue | Java debug/test bundles are not ready |
| `README.md` open or `Markview enable` fails with parser/runtime errors | Neovim/Mason issue | Check Treesitter parser state and plugin sync |
| Markdown works, mermaid rendering is skipped cleanly | not a blocker | Optional renderer path is allowed to degrade cleanly |

## Ready / not ready rule

- **Ready**: shared macOS checks pass, Java passes `:JdtHealth`, markdown smoke tests pass.
- **Not ready**: any mandatory shared macOS, Java, or markdown check fails.
- **Not a blocker**: optional mermaid/image rendering is unavailable but markdown editing and Markview remain stable.
