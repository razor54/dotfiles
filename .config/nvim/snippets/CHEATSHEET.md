# Quick Snippet Reference

## JavaScript/TypeScript Snippets

| Prefix | Description |
|--------|-------------|
| `cl` | console.log() |
| `clv` | console.log with variable label |
| `af` | Arrow function |
| `aaf` | Async arrow function |
| `prom` | New Promise |
| `tryc` | Try-catch block |
| `imp` | Import statement |
| `impd` | Import destructured |
| `int` | Interface (TS) |
| `typ` | Type alias (TS) |
| `eint` | Export interface (TS) |
| `etyp` | Export type (TS) |

## Lua Snippets

| Prefix | Description |
|--------|-------------|
| `fn` | Function |
| `lfn` | Local function |
| `req` | Require module |
| `lv` | Local variable |
| `for` | For loop |
| `forp` | For in pairs loop |
| `if` | If statement |

## Python Snippets

| Prefix | Description |
|--------|-------------|
| `pr` | print() |
| `prf` | print() f-string |
| `def` | Function definition |
| `class` | Class definition |
| `ifmain` | if __name__ == '__main__' |
| `try` | Try-except block |

## Go Snippets

| Prefix | Description |
|--------|-------------|
| `main` | main() function |
| `fn` | Function |
| `meth` | Method |
| `iferr` | if err != nil check |
| `struct` | Struct definition |

## Rust Snippets

| Prefix | Description |
|--------|-------------|
| `fn` | Function |
| `pl` | println! macro |
| `struct` | Struct |
| `impl` | Implementation block |
| `match` | Match expression |

## Usage Tips

1. **Trigger**: Type prefix and select from autocomplete
2. **Navigate**: Use `Ctrl+j` (forward) and `Ctrl+k` (backward) to jump between placeholders
3. **Expand**: Your completion plugin should trigger snippets automatically
4. **Custom**: Add your own in the respective `.json` files

## Friendly Snippets

You also have **friendly-snippets** installed which provides hundreds more snippets.
Your custom snippets will extend or override these.

To see all available snippets for a filetype, you can use `:LuaSnipListAvailable` 
(if you add this command to your config) or browse:
`~/.local/share/nvim/lazy/friendly-snippets/snippets/`
