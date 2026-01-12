# Plugin Reference Guide

> Complete list of plugins with usage examples

## 📦 Plugin Categories

### Core Infrastructure

#### lazy.nvim - Plugin Manager
**Location:** Bootstrap in `lua/config/lazy.lua`  
**Commands:**
```vim
:Lazy           " Open UI
:Lazy sync      " Install missing, update, and clean
:Lazy update    " Update plugins
:Lazy clean     " Clean unused plugins
:Lazy profile   " Profile startup time
:Lazy log       " View update logs
```

### Completion & LSP

#### blink.cmp - Completion Engine
**Location:** `lua/plugins/autocomplete/blink_cmp.lua`  
**Features:**
- Fast completion
- LSP integration
- Snippet integration
- Copilot integration

**Usage:**
- Auto-triggers in insert mode
- `<CR>` to accept
- `<C-n>`/`<C-p>` to navigate (default)
- `<C-e>` to close

#### nvim-lspconfig - LSP Configuration
**Location:** `lua/plugins/autocomplete/lspconfig.lua`  
**Keybindings:**
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - References
- `gi` - Implementation
- `K` - Hover docs
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `[d` / `]d` - Navigate diagnostics

#### mason.nvim - LSP/DAP Installer
**Location:** `lua/plugins/autocomplete/mason.lua`  
**Commands:**
```vim
:Mason                  " Open UI
:MasonInstall <server>  " Install server
:MasonUninstall <name>  " Remove server
:MasonUpdate            " Update all
```

**Common servers:**
- `lua_ls` - Lua
- `ts_ls` - TypeScript
- `pyright` - Python
- `rust_analyzer` - Rust
- `gopls` - Go

#### LuaSnip - Snippet Engine
**Location:** `lua/plugins/autocomplete/luasnip.lua`  
**Keybindings:**
- `<C-j>` - Jump forward
- `<C-k>` - Jump backward
- `<C-l>` - Cycle choices
- `<C-h>` - Cycle choices back

**Custom snippets:** `~/.config/nvim/snippets/`

#### friendly-snippets - Snippet Collection
**Auto-loaded** - Provides hundreds of pre-made snippets

### AI Assistants

#### copilot.lua - GitHub Copilot
**Location:** `lua/plugins/autocomplete/copilot.lua`  
**Features:**
- Inline AI suggestions
- Integrated with blink.cmp

**Commands:**
```vim
:Copilot status    " Check status
:Copilot setup     " Initial setup
:Copilot auth      " Authenticate
```

#### copilot-chat - Copilot Chat Interface
**Location:** `lua/plugins/autocomplete/copilot-chat.lua`  
**Usage:**
- Open chat interface
- Ask questions about code
- Get explanations
- Request refactors

### Syntax & Parsing

#### nvim-treesitter - Advanced Parsing
**Location:** `lua/plugins/treesitter/treesitter.lua`  
**Features:**
- Syntax highlighting
- Code folding
- Smart selections
- Text objects

**Commands:**
```vim
:TSInstall <language>   " Install parser
:TSUpdate              " Update parsers
:TSInstallInfo         " Show installed
```

**Motions (if configured):**
- `]f` / `[f` - Next/prev function
- `]c` / `[c` - Next/prev class
- `af` - Around function
- `if` - Inside function

### File Navigation

#### telescope.nvim - Fuzzy Finder
**Location:** Likely in `lua/plugins/general/` or `lua/plugins/editor/`  
**Common keybindings:**
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags
- `<leader>fo` - Old files
- `<leader>fw` - Grep word under cursor

**In Telescope:**
- `<C-n>`/`<C-p>` - Navigate
- `<CR>` - Select
- `<C-x>` - Open in split
- `<C-v>` - Open in vsplit
- `<C-t>` - Open in tab
- `<C-u>`/`<C-d>` - Scroll preview

#### harpoon - Quick File Navigation
**Location:** `lua/plugins/autocomplete/harpoon.lua`  
**Concept:** Mark important files for instant access

**Usage:**
- Mark current file
- Navigate between marks
- View all marks

### File Explorer

#### neo-tree / oil.nvim
**Location:** `lua/plugins/filetree/`  
**Commands:**
```vim
:Neotree         " Toggle file tree
:Neotree reveal  " Show current file
:Oil             " Open directory as buffer
```

**In tree:**
- `a` - Create file/folder
- `d` - Delete
- `r` - Rename
- `x` - Cut
- `c` - Copy
- `p` - Paste

### Git Integration

#### gitsigns.nvim - Git Decorations
**Location:** `lua/plugins/filetree/gitsigns.lua`  
**Features:**
- Show git changes in sign column
- Inline blame
- Hunk navigation

**Keybindings (common):**
- `]c` - Next hunk
- `[c` - Previous hunk
- `<leader>hs` - Stage hunk
- `<leader>hu` - Undo stage
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line

#### octo.nvim - GitHub Integration
**Location:** `lua/plugins/general/octo.lua`  
**Commands:**
```vim
:Octo issue list          " List issues
:Octo pr list            " List PRs
:Octo pr create          " Create PR
:Octo issue create       " Create issue
:Octo pr checkout <num>  " Checkout PR
```

### UI Enhancements

#### lualine.nvim - Statusline
**Location:** `lua/plugins/general/lualine.lua`  
**Status:** Currently disabled (using custom)  
**Features:**
- Show mode, file, git status
- LSP status
- Diagnostics
- Custom components

#### bufferline.nvim - Buffer Tabs
**Location:** `lua/plugins/general/bufferline.lua`  
**Status:** Likely disabled  
**Features:**
- Visual buffer tabs
- Mouse support
- Buffer groups

#### noice.nvim - Command UI
**Location:** `lua/plugins/editor/noice.lua`  
**Status:** Disabled  
**Features:**
- Improved command line
- Notification system
- LSP progress

#### smear-cursor - Animated Cursor
**Location:** `lua/plugins/general/smear-cursor.lua`  
**Features:**
- Smooth cursor movement
- Visual feedback

#### neoscroll.nvim - Smooth Scrolling
**Location:** `lua/plugins/general/neoscroll.lua`  
**Features:**
- Animated scrolling
- Better visual feedback

### Editor Enhancements

#### mini.nvim - Mini Modules
**Location:** `lua/plugins/mini-plugins/`  
**Modules available:**
- mini.ai - Better text objects
- mini.surround - Surround text
- mini.pairs - Auto pairs
- mini.comment - Fast commenting
- mini.indentscope - Indent guides
- And many more...

**Check:** `:h mini.nvim`

#### which-key.nvim - Keybinding Help
**Location:** `lua/plugins/whichkey/`  
**Usage:**
- Press `<leader>` and wait
- Shows available keybindings
- Press key to execute or continue

**Commands:**
```vim
:WhichKey          " Show all keybindings
:WhichKey <leader> " Show leader bindings
```

#### comment.nvim - Smart Commenting
**Location:** Likely `lua/plugins/editor/comment.lua`  
**Keybindings (common):**
- `gcc` - Toggle line comment
- `gbc` - Toggle block comment
- `gc` (visual) - Comment selection
- `gcap` - Comment paragraph

#### blankline - Indent Guides
**Location:** `lua/plugins/editor/blankline.lua`  
**Features:**
- Show indent levels
- Rainbow indents
- Scope highlighting

### Debugging (DAP)

#### nvim-dap - Debug Adapter Protocol
**Location:** `lua/plugins/dap/`  
**Commands:**
```vim
:DapContinue       " Start/continue
:DapToggleBreakpoint " Toggle breakpoint
:DapStepOver       " Step over
:DapStepInto       " Step into
:DapStepOut        " Step out
:DapTerminate      " Stop debugging
```

#### nvim-dap-ui - Debug UI
**Features:**
- Variable inspection
- Watch expressions
- Call stack
- Breakpoint management

### Language-Specific

#### jdtls - Java LSP
**Location:** `lua/plugins/autocomplete/jdtls.lua`  
**Features:**
- Java completion
- Maven/Gradle support
- Test runner

#### roslyn - C# LSP
**Location:** `lua/plugins/autocomplete/roslyn.lua`  
**Features:**
- C# completion
- .NET support

#### rayxgo - Go Tools
**Location:** `lua/plugins/autocomplete/rayxgo.lua`  
**Features:**
- Go-specific tools
- Test runner

#### springboot-nvim - Spring Boot
**Location:** `lua/plugins/autocomplete/springboot-nvim.lua`  
**Features:**
- Spring Boot integration
- Property file support

### SQL

#### vim-dadbod - SQL Client
**Location:** `lua/plugins/sql/`  
**Commands:**
```vim
:DB <connection>       " Execute query
:DBUIToggle           " Toggle UI
:DBUIAddConnection    " Add connection
```

### Themes

**Location:** `lua/plugins/themes/`  
**Available themes:**
- Catppuccin (likely default)
- Others...

**Change theme:**
```vim
:colorscheme <name>
```

**Make permanent:** Edit `lua/config/lazy.lua`

### Utilities

#### floaterm - Floating Terminal
**Location:** `lua/plugins/general/floaterm.lua`  
**Commands:**
```vim
:FloatermNew       " New terminal
:FloatermToggle    " Toggle terminal
:FloatermNext      " Next terminal
:FloatermPrev      " Previous terminal
```

#### nvim-web-devicons - File Icons
**Location:** `lua/plugins/general/nvim-web-devicons.lua`  
**Features:**
- File type icons
- Used by other plugins

## 🔍 Finding Plugin Info

### Check if Plugin is Loaded
```vim
:Lazy check <plugin-name>
```

### View Plugin Config
```bash
# Find the config file
find ~/.config/nvim/lua/plugins -name "*plugin-name*"

# Or view in Neovim
:e ~/.config/nvim/lua/plugins/general/plugin-name.lua
```

### Plugin Documentation
```vim
:help <plugin-name>
```

### Plugin Repository
Most plugins follow: `github.com/<author>/<plugin-name>`

## 📝 Adding New Plugins

1. Create file: `~/.config/nvim/lua/plugins/<category>/<name>.lua`
2. Add plugin spec:
```lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- lazy load
  dependencies = {},   -- if needed
  opts = {},          -- plugin options
  config = function() -- or custom config
    require("plugin-name").setup({})
  end,
}
```
3. Restart Neovim or `:Lazy sync`

## 🗑️ Removing Plugins

1. Delete the config file or add `enabled = false`
2. Run `:Lazy clean`

---

**Note:** Some plugin keybindings and features may differ from this reference. Check the actual config files in `~/.config/nvim/lua/plugins/` for exact configuration.
