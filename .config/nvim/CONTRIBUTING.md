# Contributing to Your Neovim Config

> Guidelines for maintaining and extending your configuration

## 🎯 Philosophy

1. **Keep it simple** - Only add what you need
2. **Lazy load everything** - Performance first
3. **Document changes** - Future you will thank present you
4. **One plugin, one purpose** - Avoid feature overlap
5. **Test before committing** - Ensure config works

## 📝 Making Changes

### Adding a New Plugin

1. **Research the plugin**
   - Check GitHub stars/activity
   - Read documentation
   - Check if it duplicates existing functionality

2. **Choose the right category**
   ```
   lua/plugins/
   ├── autocomplete/   # LSP, completion, snippets
   ├── editor/         # Editing enhancements
   ├── filetree/       # File explorers, git
   ├── general/        # UI, navigation, utilities
   ├── mini-plugins/   # Mini.nvim modules
   ├── treesitter/     # Syntax parsing
   ├── themes/         # Color schemes
   ├── dap/           # Debugging
   └── sql/           # Database tools
   ```

3. **Create the config file**
   ```lua
   -- lua/plugins/general/my-plugin.lua
   return {
     "author/plugin-name",
     
     -- Lazy loading (choose one or more)
     event = "VeryLazy",           -- Load after startup
     -- event = "BufReadPre",      -- Before reading buffer
     -- cmd = "MyCommand",         -- On command
     -- ft = "python",             -- For specific filetype
     -- keys = { "<leader>x" },    -- On key press
     
     -- Dependencies
     dependencies = {
       "other/plugin",
     },
     
     -- Simple config
     opts = {
       option1 = true,
       option2 = "value",
     },
     
     -- OR complex config
     config = function()
       require("plugin-name").setup({
         -- options here
       })
       
       -- Add keybindings
       vim.keymap.set("n", "<leader>mp", ":MyPlugin<CR>", {
         desc = "My Plugin",
       })
     end,
   }
   ```

4. **Test the plugin**
   ```bash
   nvim  # Restart Neovim
   :Lazy sync  # Install plugin
   :checkhealth plugin-name  # Check health
   ```

5. **Document it**
   - Add to [PLUGINS.md](PLUGINS.md)
   - Add keybindings to [QUICKREF.md](QUICKREF.md)
   - Update README if major addition

### Adding a Keybinding

1. **Check for conflicts**
   ```vim
   :verbose map <your-key>
   ```

2. **Choose the right file**
   - Global keymaps: `lua/config/keymaps.lua`
   - Plugin-specific: In the plugin config file
   - Mode-specific: Consider splitting keymaps.lua

3. **Add with description**
   ```lua
   vim.keymap.set("n", "<leader>mp", ":MyCommand<CR>", {
     desc = "My Plugin - Do something",  -- WhichKey shows this
     silent = true,                      -- Don't show in cmdline
     noremap = true,                     -- Don't allow remapping
   })
   ```

4. **Update documentation**
   Add to [QUICKREF.md](QUICKREF.md) under appropriate section.

### Adding an Autocommand

1. **Edit** `lua/config/autocmds.lua`

2. **Use the modern API**
   ```lua
   -- ❌ Old way
   vim.cmd([[
     autocmd FileType python setlocal tabstop=4
   ]])
   
   -- ✅ New way
   vim.api.nvim_create_autocmd("FileType", {
     pattern = "python",
     callback = function()
       vim.opt_local.tabstop = 4
     end,
     desc = "Set Python indent to 4 spaces",
   })
   ```

3. **Group related autocommands**
   ```lua
   local augroup = vim.api.nvim_create_augroup("MyGroup", { clear = true })
   
   vim.api.nvim_create_autocmd("BufWritePre", {
     group = augroup,
     pattern = "*.py",
     callback = function()
       -- Do something before saving Python files
     end,
   })
   ```

### Adding a Custom Snippet

1. **Choose the language file**
   ```
   snippets/
   ├── javascript.json
   ├── typescript.json
   ├── lua.json
   ├── python.json
   └── ...
   ```

2. **Add the snippet**
   ```json
   {
     "Snippet Name": {
       "prefix": "trigger",
       "body": [
         "line 1 with $1 placeholder",
         "line 2 with ${2:default text}",
         "$0"
       ],
       "description": "What this snippet does"
     }
   }
   ```

3. **Test it**
   - Restart Neovim
   - Type the prefix in a file of that type
   - Should appear in completion menu

4. **Document it**
   Add to `snippets/CHEATSHEET.md`

### Modifying Options

1. **Edit** `lua/config/opts.lua`

2. **Use the modern API**
   ```lua
   -- ❌ Old way
   vim.cmd("set number")
   
   -- ✅ New way
   vim.opt.number = true
   ```

3. **Group related options**
   ```lua
   -- Indentation
   vim.opt.tabstop = 2
   vim.opt.softtabstop = 2
   vim.opt.shiftwidth = 2
   vim.opt.expandtab = true
   ```

## 🧪 Testing Changes

### Before Committing

1. **Clean start test**
   ```bash
   nvim --noplugin  # Start without plugins
   # Check for errors
   ```

2. **Profile startup**
   ```vim
   :Lazy profile
   # Check if new plugin slows down startup
   ```

3. **Health check**
   ```vim
   :checkhealth
   ```

4. **Test key functionality**
   - Open different file types
   - Test LSP features
   - Test new plugin/feature
   - Test existing workflows still work

### Rollback if Needed

```bash
# Revert last commit
git revert HEAD

# Or checkout specific file
git checkout HEAD~1 lua/plugins/general/broken-plugin.lua

# Or remove plugin and clean
rm lua/plugins/general/broken-plugin.lua
nvim -c "Lazy clean"
```

## 📊 Code Style

### Lua Style

```lua
-- Use descriptive names
local function setup_keymaps()  -- ✅ Good
  -- code
end

local function skm()  -- ❌ Bad
  -- code
end

-- Consistent indentation (2 spaces)
return {
  "plugin/name",
  opts = {
    option1 = true,
    option2 = {
      nested = "value",
    },
  },
}

-- Add comments for non-obvious things
vim.opt.updatetime = 100  -- Faster CursorHold events for better UX

-- Group related settings
-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
```

### Plugin Config Style

```lua
return {
  "author/plugin-name",
  
  -- Metadata first
  version = "1.*",
  enabled = true,
  
  -- Loading strategy
  event = "VeryLazy",
  
  -- Dependencies
  dependencies = {
    "other/plugin",
  },
  
  -- Keys before config
  keys = {
    { "<leader>x", "<cmd>Command<cr>", desc = "Description" },
  },
  
  -- Config last
  opts = {},
  -- OR
  config = function()
    -- Setup code
  end,
}
```

## 🔄 Update Workflow

### Weekly Maintenance

```bash
# 1. Update plugins
nvim -c "Lazy sync"

# 2. Update LSP servers
nvim -c "Mason" -c "MasonUpdateAll"

# 3. Check for issues
nvim -c "checkhealth"

# 4. Commit if all good
cd ~/dotfiles
git add .config/nvim
git commit -m "chore: update plugins $(date +%Y-%m-%d)"
git push
```

### Monthly Review

1. Run `:Lazy profile` - Remove slow plugins
2. Review `lazy-lock.json` - Check for outdated plugins
3. Review unused plugins - Remove if not used in 3 months
4. Update documentation - Keep docs in sync with config

## 🐛 Debugging Issues

### Plugin Not Working

1. **Check if loaded**
   ```vim
   :Lazy
   " Look for plugin in list
   ```

2. **Check for errors**
   ```vim
   :messages
   :Lazy log
   ```

3. **Isolate the problem**
   ```lua
   -- Add to top of plugin file
   vim.notify("Plugin loading", vim.log.levels.INFO)
   ```

4. **Check plugin docs**
   ```vim
   :help plugin-name
   ```

### LSP Not Working

1. **Check LSP status**
   ```vim
   :LspInfo
   ```

2. **Check Mason**
   ```vim
   :Mason
   " Verify server is installed
   ```

3. **Check logs**
   ```vim
   :LspLog
   " Or check: ~/.local/state/nvim/lsp.log
   ```

### Keybinding Not Working

1. **Check what it's mapped to**
   ```vim
   :verbose map <your-key>
   ```

2. **Check mode**
   ```vim
   :nmap <key>  " Normal mode
   :imap <key>  " Insert mode
   :vmap <key>  " Visual mode
   ```

## 📚 Learning Resources

- **Neovim Docs:** `:help lua-guide`
- **Lazy.nvim:** `:help lazy.nvim`
- **Plugin Docs:** `:help <plugin-name>`
- **Online:** 
  - [Neovim Docs](https://neovim.io/doc/)
  - [Lazy.nvim](https://github.com/folke/lazy.nvim)
  - [LazyVim](https://github.com/LazyVim/LazyVim) (reference config)

## ✅ Checklist for New Plugins

- [ ] Research plugin (stars, activity, alternatives)
- [ ] Add to appropriate category
- [ ] Configure lazy loading
- [ ] Add keybindings with descriptions
- [ ] Test thoroughly
- [ ] Update PLUGINS.md
- [ ] Update QUICKREF.md if adding keybindings
- [ ] Commit with descriptive message
- [ ] Monitor performance (`:Lazy profile`)

## 💬 Commit Message Format

```
type(scope): description

feat(snippets): add Python testing snippets
fix(lsp): resolve Java LSP initialization issue
chore(plugins): update all plugins
docs(readme): add troubleshooting section
refactor(keymaps): organize by category
perf(startup): lazy load telescope
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Formatting
- `refactor` - Code restructuring
- `perf` - Performance improvement
- `test` - Testing
- `chore` - Maintenance

---

**Remember:** This is your config. Adapt these guidelines to your workflow!
