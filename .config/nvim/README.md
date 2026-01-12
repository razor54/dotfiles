# Neovim Configuration Documentation

> A comprehensive guide to your Neovim setup

## 📖 Documentation Index

- **[README.md](README.md)** ← You are here - Complete overview
- **[QUICKREF.md](QUICKREF.md)** - Quick reference card with essential commands
- **[PLUGINS.md](PLUGINS.md)** - Complete plugin reference with examples
- **[OPTIMIZATION.md](OPTIMIZATION.md)** - Performance tips and cleanup suggestions
- **[snippets/README.md](snippets/README.md)** - Snippet system guide
- **[snippets/CHEATSHEET.md](snippets/CHEATSHEET.md)** - Quick snippet reference

**🎯 Start here if you're new:** Read this file, then check [QUICKREF.md](QUICKREF.md)

## 📁 Directory Structure

```
~/.config/nvim/
├── init.lua                  # Main entry point
├── lazy-lock.json           # Plugin version lock file
├── lua/
│   ├── config/              # Core configuration
│   │   ├── lazy.lua        # Lazy.nvim plugin manager setup
│   │   ├── opts.lua        # Vim options and settings
│   │   ├── keymaps.lua     # Global keybindings
│   │   ├── autocmds.lua    # Autocommands
│   │   ├── statusline/     # Custom statusline components
│   │   └── lualine/        # Lualine themes
│   ├── plugins/            # Plugin configurations (70 files)
│   │   ├── autocomplete/   # LSP, completion, snippets
│   │   ├── filetree/       # File explorer, git signs
│   │   ├── treesitter/     # Treesitter parsers
│   │   ├── general/        # UI, navigation, utilities
│   │   ├── mini-plugins/   # Mini.nvim modules
│   │   ├── whichkey/       # Keybinding help
│   │   ├── themes/         # Color schemes
│   │   ├── editor/         # Editing enhancements
│   │   ├── dap/           # Debug Adapter Protocol
│   │   └── sql/           # SQL tools
│   └── utils/             # Utility functions
├── after/                 # After plugins load
├── ftplugin/             # Filetype-specific settings
└── snippets/             # Custom VSCode-style snippets
    ├── javascript.json
    ├── typescript.json
    ├── lua.json
    ├── python.json
    ├── go.json
    └── rust.json
```

## 🚀 Quick Start

### First Time Setup

1. **Prerequisites:**
   ```bash
   # Neovim 0.10+ required (you have 0.11.4 ✓)
   brew install neovim
   
   # Install required tools
   brew install ripgrep fd fzf git node
   ```

2. **Initial Launch:**
   ```bash
   nvim
   # Lazy.nvim will auto-install and sync plugins
   ```

3. **Post-Install:**
   - Run `:checkhealth` to verify setup
   - Run `:Mason` to install LSP servers
   - Run `:Lazy` to manage plugins

## ⌨️ Key Mappings

### Leader Keys
- **Leader:** `<Space>`
- **Local Leader:** `\`

### Essential Keybindings

#### File Operations
| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<leader>x` | Close buffer (smart) |
| `<leader>bd` | Force close buffer |

#### Window Management
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<C-Up/Down/Left/Right>` | Resize windows |

#### Buffer Navigation
| Key | Action |
|-----|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `gt` | Go to next buffer |
| `tg` | Go to previous buffer |

#### Text Editing
| Key | Action |
|-----|--------|
| `J` (visual) | Move block down |
| `K` (visual) | Move block up |
| `</>` (visual) | Indent left/right |

#### LSP (Language Server)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |

#### Snippets (LuaSnip)
| Key | Action |
|-----|--------|
| `<C-j>` | Jump to next placeholder |
| `<C-k>` | Jump to previous placeholder |
| `<C-l>` | Cycle choices forward |
| `<C-h>` | Cycle choices backward |

See `lua/config/keymaps.lua` for full list.

## 🔌 Plugins Overview

### Core Plugins (~70 total)

#### Plugin Manager
- **lazy.nvim** - Modern plugin manager with lazy loading

#### Completion & LSP
- **blink.cmp** - Fast completion engine (active)
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP/DAP/Linter installer
- **LuaSnip** - Snippet engine
- **friendly-snippets** - Pre-made snippets collection

#### AI Assistants
- **copilot.lua** - GitHub Copilot integration (configured)
- **copilot-chat** - Chat interface for Copilot
- **supermaven** - Alternative AI completion (currently disabled)

#### Treesitter
- **nvim-treesitter** - Syntax highlighting and parsing
- **treesitter-textobjects** - Smart text objects

#### File Navigation
- **telescope.nvim** - Fuzzy finder
- **oil.nvim** / **neo-tree** - File explorers
- **harpoon** - Quick file navigation

#### UI Enhancements
- **lualine.nvim** - Statusline (currently disabled, using custom)
- **bufferline.nvim** - Buffer tabs (disabled)
- **noice.nvim** - Command line UI (disabled)
- **smear-cursor** - Animated cursor

#### Git Integration
- **gitsigns.nvim** - Git decorations
- **octo.nvim** - GitHub issues/PRs in Neovim

#### Debugging
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - Debug UI

#### Language-Specific
- **jdtls** - Java LSP
- **roslyn** - C# LSP
- **rayxgo** - Go tools
- **springboot-nvim** - Spring Boot support

## ⚙️ Configuration Files

### `init.lua`
Main entry point that loads:
1. Leader key setup
2. Core options (`config.opts`)
3. Plugin manager (`config.lazy`)
4. Keymaps (`config.keymaps`)
5. Autocommands (`config.autocmds`)
6. Statusline (`config.statusline`)

### `lua/config/opts.lua`
Core Vim options:
- **Line numbers:** Relative + absolute
- **Indentation:** 2 spaces (tabs converted)
- **Search:** Smart case, incremental, highlighted
- **Undo:** Persistent undo history
- **Clipboard:** Synced with system
- **Performance:** Swap disabled, fast updatetime (100ms)

### `lua/config/lazy.lua`
Plugin manager configuration:
- Imports all plugin specs from `plugins/*`
- Disables unused built-in plugins
- Auto-lazy loads plugins by default

## 📝 Snippets

Custom snippets are stored in `~/.config/nvim/snippets/`

See detailed documentation:
- `snippets/README.md` - Full usage guide
- `snippets/CHEATSHEET.md` - Quick reference

## 🎨 Themes

Available themes in `lua/plugins/themes/`:
- Catppuccin (default)
- Others...

Change theme: Edit `lua/config/lazy.lua` install colorscheme.

## 🔧 Customization

### Adding a New Plugin

1. Create a file in appropriate `lua/plugins/` subdirectory:
   ```lua
   -- lua/plugins/general/my-plugin.lua
   return {
     "author/plugin-name",
     event = "VeryLazy",  -- lazy load
     opts = {
       -- plugin options
     },
   }
   ```

2. Restart Neovim or run `:Lazy sync`

### Adding a New Keymap

Edit `lua/config/keymaps.lua`:
```lua
vim.keymap.set("n", "<leader>mp", ":MyCommand<CR>", { desc = "My Plugin" })
```

### Adding a New Autocommand

Edit `lua/config/autocmds.lua`:
```lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
  end,
})
```

## 🐛 Troubleshooting

### Common Issues

1. **Plugins not loading:**
   ```vim
   :Lazy sync
   :Lazy health
   ```

2. **LSP not working:**
   ```vim
   :LspInfo
   :Mason
   :checkhealth lsp
   ```

3. **Slow startup:**
   ```vim
   :Lazy profile
   ```

4. **Snippets not appearing:**
   - Check `:LuaSnipListAvailable` (if configured)
   - Verify file in `~/.config/nvim/snippets/`
   - Restart Neovim

### Health Checks
```vim
:checkhealth
:checkhealth lazy
:checkhealth mason
:checkhealth lsp
```

## 📚 Learning Resources

- **Neovim docs:** `:help`
- **Plugin docs:** `:help <plugin-name>`
- **Lazy.nvim:** `:help lazy.nvim`
- **LSP:** `:help lsp`
- **Treesitter:** `:help treesitter`

## 🔄 Maintenance

### Update Plugins
```vim
:Lazy sync        " Update all plugins
:Lazy update      " Update specific plugin
:Lazy clean       " Remove unused plugins
```

### Update LSP Servers
```vim
:Mason            " Open Mason UI
:MasonUpdate      " Update Mason itself
:MasonInstall <server>  " Install new server
```

### Backup Configuration
Your dotfiles are already in a git repo! Just commit changes:
```bash
cd ~/dotfiles
git add .config/nvim
git commit -m "Update nvim config"
git push
```

## 📊 Performance

Current configuration has:
- 70+ plugin files
- Lazy loading enabled
- Built-in plugins disabled
- Fast startup expected due to lazy loading

Profile startup time:
```bash
nvim --startuptime startup.log
```

---

**Version:** Neovim 0.11.4  
**Plugin Manager:** lazy.nvim  
**Config Location:** `~/.config/nvim`
