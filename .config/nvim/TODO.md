# Immediate Action Items

> Quick wins you can implement right now

## 🎯 Priority 1: Clean Up (15 minutes)

### 1. Fix the `smartindent` Setting
**File:** `lua/config/opts.lua` line 20

**Current:**
```lua
vim.smartindent = true
```

**Fix:**
```lua
opt.smartindent = true  -- Consistent with other settings
```

### 2. Remove Unused Plugins
Check these files and delete if not using:

```bash
# Navigate to nvim config
cd ~/.config/nvim

# Remove if not using Supermaven
rm lua/plugins/autocomplete/supermaven.lua

# Remove if not using VectorCode
rm lua/plugins/autocomplete/vector-code.lua

# Remove bloat detection (marked as TODO in lazy.lua)
rm -rf lua/plugins/bloat-detection/
```

Then edit `lua/config/lazy.lua` and remove line 35:
```lua
{ import = "plugins.bloat-detection" },  -- DELETE THIS LINE
```

### 3. Disable Unused UI Plugins
Since you're using custom statusline, clean up disabled plugins:

**Option A:** Delete them entirely
```bash
rm lua/plugins/general/lualine.lua
rm lua/plugins/general/bufferline.lua
rm lua/plugins/editor/noice.lua
rm lua/plugins/editor/nvim-notify.lua
```

**Option B:** Add `enabled = false` at top of each file
```lua
return {
  "plugin/name",
  enabled = false,  -- Won't load at all
  -- rest of config...
}
```

## 🚀 Priority 2: Quick Improvements (10 minutes)

### 4. Improve Blink.cmp Loading
**File:** `lua/plugins/autocomplete/blink_cmp.lua` line 5

**Current:**
```lua
event = { "LspAttach" },
```

**Better:**
```lua
event = { "InsertEnter", "CmdlineEnter" },  -- Load when starting to type
```

### 5. Add Startup Profiling Command
**File:** `lua/config/keymaps.lua`

Add at the end:
```lua
-- Development helpers
vim.keymap.set("n", "<leader>lp", ":Lazy profile<CR>", { desc = "Lazy Profile" })
vim.keymap.set("n", "<leader>lc", ":Lazy clean<CR>", { desc = "Lazy Clean" })
vim.keymap.set("n", "<leader>ls", ":Lazy sync<CR>", { desc = "Lazy Sync" })
```

## 📊 Priority 3: Verify & Test (5 minutes)

### 6. Run Health Checks
```vim
:checkhealth
```

Look for:
- ❌ Any errors
- ⚠️  Any warnings about missing tools
- ✅ Verify all critical systems work

### 7. Profile Startup Time
```bash
nvim --startuptime startup.log +q && tail -1 startup.log
```

**Target:** Under 100ms  
**Good:** Under 200ms  
**Needs work:** Over 300ms

### 8. Test Core Functionality
Open Neovim and verify:
- [ ] LSP works (`gd` to jump to definition)
- [ ] Completion shows up in insert mode
- [ ] Snippets work (`cl<tab>` in JS file)
- [ ] File navigation works (Telescope/file explorer)
- [ ] Git signs appear
- [ ] Treesitter highlights correctly

## 🎨 Optional: Nice to Have (30 minutes)

### 9. Add Quick Reload Command
**File:** `lua/config/keymaps.lua`

```lua
-- Quick config reload
vim.keymap.set("n", "<leader>cr", function()
  vim.cmd("source ~/.config/nvim/init.lua")
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { desc = "Reload Config" })
```

### 10. Create Health Check Function
**Create:** `lua/config/health.lua`

```lua
local M = {}

M.check = function()
  vim.health.start("Custom Configuration")
  
  -- Check required tools
  local tools = { "rg", "fd", "git", "node", "npm" }
  for _, tool in ipairs(tools) do
    if vim.fn.executable(tool) == 1 then
      vim.health.ok(tool .. " is installed")
    else
      vim.health.error(tool .. " is not installed", {
        "Install with: brew install " .. tool
      })
    end
  end
  
  -- Check snippet directory
  local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
  if vim.fn.isdirectory(snippet_dir) == 1 then
    local files = vim.fn.glob(snippet_dir .. "/*.json", false, true)
    vim.health.ok("Found " .. #files .. " snippet files")
  else
    vim.health.error("Snippets directory missing")
  end
  
  -- Check for disabled plugins
  local disabled_count = 0
  for _, file in ipairs(vim.fn.glob("~/.config/nvim/lua/plugins/**/*.lua", false, true)) do
    local content = table.concat(vim.fn.readfile(file), "\n")
    if content:match("enabled%s*=%s*false") then
      disabled_count = disabled_count + 1
    end
  end
  if disabled_count > 0 then
    vim.health.warn(disabled_count .. " plugins are disabled")
  end
end

return M
```

Add to `init.lua`:
```lua
require("config.health")
```

Then run: `:checkhealth custom`

## 📝 After Making Changes

1. **Test Configuration**
   ```bash
   nvim
   # Check for errors
   :messages
   ```

2. **Clean Unused Plugins**
   ```vim
   :Lazy clean
   ```

3. **Sync Plugin State**
   ```vim
   :Lazy sync
   ```

4. **Commit Changes**
   ```bash
   cd ~/dotfiles
   git add .config/nvim
   git commit -m "chore: cleanup unused plugins and optimize config"
   git push
   ```

## 🎯 Expected Results

After completing these tasks:

- ✅ **Cleaner config** - Remove ~5-10 unused files
- ✅ **Faster startup** - Potential 10-20ms improvement
- ✅ **Less memory** - ~30-50MB reduction
- ✅ **Better organized** - Easier to maintain
- ✅ **Documented** - Know what everything does

## ⏭️ Next Steps

Once you've completed these, check out [OPTIMIZATION.md](OPTIMIZATION.md) for:
- Medium priority improvements
- Code organization tips
- Advanced optimizations
- Best practices for long-term maintenance

## 🆘 If Something Breaks

```bash
# Revert all changes
cd ~/dotfiles
git checkout .config/nvim

# Or revert specific file
git checkout lua/config/opts.lua

# Force clean Neovim state
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

# Restart Neovim (will reinstall plugins)
nvim
```

---

**Time estimate:** 30-60 minutes for all Priority 1-2 tasks  
**Recommended order:** Do items 1-8 in sequence, then test thoroughly before committing.
