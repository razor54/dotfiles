# Neovim Configuration Optimization Guide

> Recommendations to improve your Neovim setup

## 🎯 Quick Wins (High Impact, Low Effort)

### 1. Clean Up Disabled/Commented Plugins

**Issue:** Multiple plugins are disabled but still loaded in config files.

**Current disabled plugins found:**
- `supermaven.lua` - Commented out entirely
- `copilot.lua` - Has panel disabled
- `bufferline.lua` - Likely disabled
- `lualine.lua` - Disabled (using custom statusline)
- `noice.nvim` - Disabled
- `nvim-notify` - Disabled

**Fix:**
```lua
-- Instead of commenting out in plugin file, add this to the plugin spec:
return {
  "plugin/name",
  enabled = false,  -- Lazy.nvim won't load it at all
}

-- Or remove the file entirely if not needed
```

**Action:**
```bash
# Remove or properly disable unused plugins
rm lua/plugins/autocomplete/supermaven.lua  # If not using
# OR add enabled = false to each disabled plugin
```

### 2. Consolidate AI Completion Tools

**Issue:** Multiple AI completion tools configured (Copilot, Supermaven, VectorCode).

**Recommendation:**
- Choose ONE AI assistant (you seem to use Copilot)
- Remove or disable others completely
- This reduces memory usage and conflicts

**Action:**
```lua
-- Keep only copilot.lua and copilot-chat.lua
-- Delete or disable:
-- - supermaven.lua
-- - vector-code.lua
```

### 3. Optimize Plugin Loading

**Issue:** Some plugins could lazy load better.

**Current:** `blink.cmp` loads on `LspAttach`  
**Better:** Load on `InsertEnter` for faster initial editing

```lua
-- lua/plugins/autocomplete/blink_cmp.lua
return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },  -- Load when starting to type
  -- Rest of config...
}
```

### 4. Remove Redundant Plugin Categories

**Issue:** `bloat-detection` folder in plugins (TODO noted in lazy.lua).

**Action:**
```bash
# If not using, remove:
rm -rf lua/plugins/bloat-detection/
# And remove from lua/config/lazy.lua line 35
```

### 5. Standardize Tab Width Setting

**Issue:** Mixed indent settings in `opts.lua`

**Current:**
```lua
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
vim.smartindent = true  -- Wrong: should be opt.smartindent
```

**Fix:**
```lua
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true  -- Consistent with other options
opt.autoindent = true   -- Also recommended
```

## 🔧 Medium Priority Optimizations

### 6. Organize Keymaps by Category

**Issue:** 97-line keymaps file could be better organized.

**Recommendation:** Split into logical groups:

```
lua/config/keymaps/
├── init.lua        # Loads all keymap modules
├── editor.lua      # Editing operations
├── navigation.lua  # Buffer/window navigation
├── lsp.lua        # LSP-specific
└── terminal.lua   # Terminal mode
```

**Example `init.lua`:**
```lua
require("config.keymaps.editor")
require("config.keymaps.navigation")
require("config.keymaps.lsp")
require("config.keymaps.terminal")
```

### 7. Consolidate Statusline Configuration

**Issue:** Both custom statusline AND lualine configured (lualine disabled).

**Options:**
1. **Stick with custom:** Delete `lua/plugins/general/lualine.lua`
2. **Switch to lualine:** Enable it and remove custom statusline

**Recommendation:** Use Lualine (well-maintained, performant, configurable)

### 8. Create a Utils Module

**Issue:** Utility functions scattered across config.

**Recommendation:** Create organized utils:

```
lua/utils/
├── init.lua       # Main utils loader
├── lsp.lua        # LSP utilities
├── buffer.lua     # Buffer operations
├── keymap.lua     # Keymap helpers
└── ui.lua         # UI helpers
```

### 9. Add Plugin Health Checks

**Create:** `lua/config/health.lua`

```lua
-- Custom health checks for your config
local M = {}

M.check = function()
  vim.health.start("Custom Config")
  
  -- Check if required tools are installed
  local required = { "rg", "fd", "git", "node" }
  for _, cmd in ipairs(required) do
    if vim.fn.executable(cmd) == 1 then
      vim.health.ok(cmd .. " is installed")
    else
      vim.health.error(cmd .. " is not installed")
    end
  end
  
  -- Check snippet directory
  local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
  if vim.fn.isdirectory(snippet_dir) == 1 then
    vim.health.ok("Snippets directory exists")
  else
    vim.health.error("Snippets directory not found")
  end
end

return M
```

Then add to `init.lua`:
```lua
require("config.health")
```

## 🚀 Advanced Optimizations

### 10. Profile and Optimize Startup Time

**Current status:** Unknown (likely good due to lazy loading)

**Measure:**
```bash
# Time startup
nvim --startuptime startup.log +q
cat startup.log | tail -1

# Or use built-in profiler
nvim -c "Lazy profile"
```

**Common culprits:**
- Treesitter parsers compiling on startup
- Large plugin configs in sync loading
- Autocommands running on VimEnter

### 11. Implement Lazy Loading Patterns

**Best practices:**

```lua
-- ❌ Bad: Always loads
return {
  "plugin/name",
  config = function()
    require("plugin").setup()
  end,
}

-- ✅ Good: Lazy loads on event
return {
  "plugin/name",
  event = "VeryLazy",
  config = function()
    require("plugin").setup()
  end,
}

-- ✅ Better: Lazy loads on specific trigger
return {
  "plugin/name",
  ft = "python",  -- Only for Python files
  cmd = "MyCommand",  -- Only when command is run
  keys = {
    { "<leader>x", "<cmd>MyCommand<cr>" }
  },
}
```

### 12. Use Plugin Dependencies Efficiently

**Issue:** Some plugins might share dependencies.

**Example:**
```lua
-- Instead of multiple plugins installing same dependency:
-- Plugin 1
return {
  "plugin/one",
  dependencies = { "shared/dependency" },
}

-- Plugin 2
return {
  "plugin/two",
  dependencies = { "shared/dependency" },  -- Duplicate
}

-- Better: Let Lazy.nvim handle it automatically
-- It will deduplicate dependencies
```

### 13. Create Project-Local Configs

**Use case:** Different settings per project.

**Create:** `.nvim.lua` in project root:
```lua
-- .nvim.lua in project directory
return {
  lsp = {
    ["lua_ls"] = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "project_specific_global" }
          }
        }
      }
    }
  },
  format_on_save = true,
}
```

**Load in** `init.lua`:
```lua
-- Auto-load project-local config
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local project_config = vim.fn.getcwd() .. "/.nvim.lua"
    if vim.fn.filereadable(project_config) == 1 then
      dofile(project_config)
    end
  end,
})
```

### 14. Add Automated Backup/Sync

**Create:** `lua/config/backup.lua`

```lua
-- Auto-commit config changes
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = vim.fn.stdpath("config") .. "/**/*.lua",
  callback = function()
    vim.notify("Config saved! Consider committing to git.", vim.log.levels.INFO)
  end,
})
```

### 15. Optimize LSP Configuration

**Current:** Individual LSP configs scattered.

**Better structure:**

```
lua/plugins/autocomplete/
├── lsp/
│   ├── init.lua           # Main LSP setup
│   ├── servers.lua        # Server configurations
│   ├── handlers.lua       # Custom handlers
│   └── languages/
│       ├── lua.lua        # Lua LSP config
│       ├── typescript.lua # TS LSP config
│       ├── python.lua     # Python LSP config
│       ├── java.lua       # Java (jdtls)
│       ├── csharp.lua     # C# (roslyn)
│       └── go.lua         # Go (rayxgo)
```

## 📋 Action Plan (Priority Order)

### Week 1: Cleanup
- [ ] Remove/disable unused plugins (supermaven, vector-code)
- [ ] Delete bloat-detection folder
- [ ] Fix `smartindent` setting in opts.lua
- [ ] Remove disabled lualine/bufferline/noice configs

### Week 2: Organization
- [ ] Split keymaps.lua into modules
- [ ] Consolidate LSP configs
- [ ] Create organized utils module

### Week 3: Enhancement
- [ ] Add health checks
- [ ] Profile startup time
- [ ] Optimize lazy loading
- [ ] Document custom functions

### Week 4: Polish
- [ ] Add project-local config support
- [ ] Create plugin templates
- [ ] Write contribution guide
- [ ] Test all features

## 🎓 Best Practices Going Forward

### 1. One Plugin, One Purpose
Avoid feature overlap. Choose the best tool for each job.

### 2. Lazy Load Everything
Default to lazy loading. Only load eagerly if absolutely necessary.

### 3. Document as You Go
Add comments explaining why, not what.

### 4. Profile Regularly
Monthly check of `:Lazy profile` to catch performance regressions.

### 5. Keep Config DRY
Extract common patterns into utility functions.

### 6. Version Control
Commit frequently with descriptive messages.

### 7. Review Unused Plugins
Quarterly audit: Remove plugins not used in 3 months.

## 📊 Expected Results

After these optimizations:
- ⚡ **Faster startup:** ~10-20ms improvement
- 🧹 **Cleaner config:** ~10 fewer files
- 💾 **Less memory:** ~50MB reduction
- 🎯 **Better organization:** Easier to maintain
- 📚 **Better documented:** Easier for others to understand

## 🆘 Need Help?

Check these resources:
- `:help lua-guide`
- `:help lazy.nvim`
- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim Docs](https://github.com/folke/lazy.nvim)
- [LazyVim](https://github.com/LazyVim/LazyVim) - Great reference config

---

**Next Steps:** Start with Quick Wins (#1-5), then move to medium priority items.
