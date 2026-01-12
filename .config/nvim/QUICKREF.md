# Neovim Quick Reference Card

> Essential commands and shortcuts for daily use

## 🎯 Most Used Commands

### File Operations
```vim
:w              Write (save) file
:q              Quit
:wq or :x       Write and quit
:q!             Quit without saving
:e <file>       Edit file
:wa             Write all buffers
```

### Plugin Management
```vim
:Lazy           Open Lazy plugin manager
:Lazy sync      Update all plugins
:Lazy clean     Remove unused plugins
:Mason          Open LSP/DAP installer
:checkhealth    Check configuration health
```

## ⌨️ Essential Keybindings

### Leader Keys
- **Space** - Leader key
- **\\** - Local leader

### File & Buffer Management
| Key | Action |
|-----|--------|
| `<C-s>` | Save current file |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>x` | Close buffer (smart) |
| `<leader>bd` | Force delete buffer |

### Window Navigation
| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to bottom window |
| `<C-k>` | Move to top window |
| `<C-l>` | Move to right window |

### Window Resizing
| Key | Action |
|-----|--------|
| `<C-Up>` | Decrease height |
| `<C-Down>` | Increase height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

### Text Editing
| Key | Action |
|-----|--------|
| `J` (visual) | Move selected block down |
| `K` (visual) | Move selected block up |
| `<` (visual) | Indent left (stays in visual) |
| `>` (visual) | Indent right (stays in visual) |

### LSP (Language Server Protocol)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<C-k>` | Signature help |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>f` | Format document |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Snippets (LuaSnip)
| Key | Action |
|-----|--------|
| `<C-j>` | Jump to next placeholder |
| `<C-k>` | Jump to previous placeholder |
| `<C-l>` | Cycle choice forward |
| `<C-h>` | Cycle choice backward |

### Terminal Mode
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate from terminal |
| `<C-Up/Down/Left/Right>` | Resize terminal window |
| `<C-\><C-n>` | Exit terminal mode |

## 🔍 Finding Things

### Telescope (Fuzzy Finder)
Likely mapped to leader key combinations. Check `:Telescope` for available pickers.

Common patterns:
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags

## 📝 Snippets Quick Reference

### JavaScript/TypeScript
| Prefix | Expands to |
|--------|-----------|
| `cl` | console.log() |
| `clv` | console.log('var:', var) |
| `af` | const name = () => {} |
| `aaf` | const name = async () => {} |
| `imp` | import module from 'path' |
| `impd` | import { } from 'path' |
| `int` | interface (TS) |
| `typ` | type (TS) |

### Lua
| Prefix | Expands to |
|--------|-----------|
| `req` | local x = require('x') |
| `lfn` | local function name() end |
| `lv` | local var = value |
| `for` | for i = 1, 10 do end |
| `forp` | for k, v in pairs() do end |

### Python
| Prefix | Expands to |
|--------|-----------|
| `pr` | print() |
| `prf` | print(f'{}') |
| `def` | def function_name(): |
| `class` | class ClassName: |
| `ifmain` | if __name__ == '__main__': |

See `~/.config/nvim/snippets/CHEATSHEET.md` for complete list.

## 🎨 Useful Vim Commands

### Search & Replace
```vim
/pattern        Search forward
?pattern        Search backward
n               Next match
N               Previous match
:%s/old/new/g   Replace all in file
:%s/old/new/gc  Replace all with confirmation
:noh            Clear search highlight
```

### Visual Mode
```vim
v               Visual character mode
V               Visual line mode
<C-v>           Visual block mode
o               Jump to other end of selection
```

### Copy/Paste (Yank/Put)
```vim
yy              Yank (copy) line
yw              Yank word
y$              Yank to end of line
p               Put (paste) after cursor
P               Put before cursor
"+y             Yank to system clipboard
"+p             Paste from system clipboard
```

### Undo/Redo
```vim
u               Undo
<C-r>           Redo
.               Repeat last command
```

## 🐛 Debugging

### Check Plugin Status
```vim
:Lazy           Plugin manager UI
:Lazy log       View plugin logs
:Lazy profile   Profile startup time
:LspInfo        Check LSP status
:Mason          Check installed servers
```

### Health Checks
```vim
:checkhealth            All health checks
:checkhealth lazy       Lazy.nvim health
:checkhealth lsp        LSP health
:checkhealth mason      Mason health
:checkhealth treesitter Treesitter health
```

### View Logs
```vim
:messages       View Neovim messages
:LspLog         View LSP log (if available)
```

## 🔧 Configuration Files

### Quick Access
```vim
:e ~/.config/nvim/init.lua           Edit main config
:e ~/.config/nvim/lua/config/opts.lua      Edit options
:e ~/.config/nvim/lua/config/keymaps.lua   Edit keymaps
:e ~/.config/nvim/lua/config/lazy.lua      Edit plugin loader

" Reload config
:source ~/.config/nvim/init.lua
" Or restart: :qa then reopen
```

### Add Custom Snippet
```bash
# Edit appropriate file
~/.config/nvim/snippets/javascript.json
~/.config/nvim/snippets/typescript.json
~/.config/nvim/snippets/lua.json
~/.config/nvim/snippets/python.json
```

## 💡 Tips & Tricks

### Productivity
1. **Learn one new keybinding per day**
2. **Use snippets for repetitive code**
3. **Customize keymaps to your workflow**
4. **Enable format-on-save for consistency**

### Performance
1. **Use lazy loading (already configured)**
2. **Profile startup occasionally: `:Lazy profile`**
3. **Update plugins regularly: `:Lazy sync`**
4. **Clean up unused plugins: `:Lazy clean`**

### Learning
1. **`:help <topic>` is your friend**
2. **`:Telescope help_tags` to search help**
3. **`:WhichKey` to discover keybindings**
4. **Check plugin README files**

## 🆘 Emergency Commands

```vim
:qa!            Quit all without saving
:wa             Save all files
:bufdo e!       Reload all buffers
:LspRestart     Restart language server
:e!             Reload current file (discard changes)
:earlier 1m     Undo all changes in last minute
```

## 📚 Documentation

- **Main docs:** `~/.config/nvim/README.md`
- **Optimization:** `~/.config/nvim/OPTIMIZATION.md`
- **Snippets:** `~/.config/nvim/snippets/README.md`
- **Built-in help:** `:help` or `:h <topic>`

---

**Pro Tip:** Print this file and keep it handy while learning!

```bash
# Generate a nice PDF (requires pandoc)
cd ~/.config/nvim
pandoc QUICKREF.md -o quickref.pdf
```
