# 📚 Documentation Index

Welcome to your Neovim configuration documentation!

## 🚀 Getting Started

**New to this config?** Start here:
1. **[README.md](README.md)** - Complete overview of your setup
2. **[QUICKREF.md](QUICKREF.md)** - Essential commands you'll use daily
3. **[TODO.md](TODO.md)** - Quick wins to improve your config now

## 📖 Reference Guides

### Daily Use
- **[QUICKREF.md](QUICKREF.md)** (6.6 KB)
  - Essential keybindings
  - Common commands
  - LSP shortcuts
  - Snippet triggers
  - Emergency commands

### Plugin Reference
- **[PLUGINS.md](PLUGINS.md)** (9.3 KB)
  - Complete plugin list with descriptions
  - Usage examples for each plugin
  - Commands and keybindings
  - How to add/remove plugins

### Snippets
- **[snippets/README.md](snippets/README.md)**
  - How to use snippets
  - How to add custom snippets
  - VSCode snippet format guide
  
- **[snippets/CHEATSHEET.md](snippets/CHEATSHEET.md)**
  - Quick snippet reference by language
  - All available snippet prefixes

## 🔧 Maintenance & Development

### Optimization
- **[OPTIMIZATION.md](OPTIMIZATION.md)** (9.3 KB)
  - Performance improvements
  - Cleanup suggestions
  - Best practices
  - Code organization tips
  - Action plan with priorities

### Immediate Actions
- **[TODO.md](TODO.md)** (5.5 KB)
  - Quick fixes you can do now (15 min)
  - Priority 1 & 2 improvements
  - Testing checklist
  - Expected results

### Contributing
- **[CONTRIBUTING.md](CONTRIBUTING.md)** (8.9 KB)
  - How to add plugins
  - How to add keybindings
  - How to add snippets
  - Code style guide
  - Testing workflow
  - Commit message format

## 📂 Configuration Structure

```
~/.config/nvim/
├── 📄 init.lua                    # Entry point
├── 📄 lazy-lock.json             # Plugin versions
│
├── 📁 lua/
│   ├── 📁 config/                # Core configuration
│   │   ├── lazy.lua              # Plugin manager
│   │   ├── opts.lua              # Vim options
│   │   ├── keymaps.lua           # Keybindings
│   │   ├── autocmds.lua          # Autocommands
│   │   └── statusline/           # Custom statusline
│   │
│   ├── 📁 plugins/               # Plugin configs (70 files)
│   │   ├── autocomplete/         # LSP, completion, AI
│   │   ├── filetree/             # File explorer, git
│   │   ├── treesitter/           # Syntax parsing
│   │   ├── general/              # UI, navigation
│   │   ├── editor/               # Editing tools
│   │   ├── dap/                  # Debugging
│   │   └── themes/               # Color schemes
│   │
│   └── 📁 utils/                 # Utility functions
│
├── 📁 snippets/                  # Custom snippets
│   ├── package.json
│   ├── javascript.json
│   ├── typescript.json
│   ├── lua.json
│   ├── python.json
│   ├── go.json
│   └── rust.json
│
└── 📁 docs/                      # You are here!
    ├── INDEX.md                  # This file
    ├── README.md                 # Complete guide
    ├── QUICKREF.md               # Quick reference
    ├── PLUGINS.md                # Plugin reference
    ├── OPTIMIZATION.md           # Optimization tips
    ├── TODO.md                   # Immediate actions
    └── CONTRIBUTING.md           # Development guide
```

## 🎯 Common Tasks

### "I want to..."

#### Learn the basics
→ Read [README.md](README.md) + [QUICKREF.md](QUICKREF.md)

#### Find a keybinding
→ Check [QUICKREF.md](QUICKREF.md) or press `<Space>` in Neovim (WhichKey)

#### Understand a plugin
→ Check [PLUGINS.md](PLUGINS.md) or run `:help plugin-name`

#### Use snippets
→ See [snippets/CHEATSHEET.md](snippets/CHEATSHEET.md)

#### Add a new plugin
→ Follow [CONTRIBUTING.md](CONTRIBUTING.md#adding-a-new-plugin)

#### Make config faster
→ Read [OPTIMIZATION.md](OPTIMIZATION.md) or [TODO.md](TODO.md)

#### Add custom keybinding
→ Follow [CONTRIBUTING.md](CONTRIBUTING.md#adding-a-keybinding)

#### Fix something broken
→ Check [CONTRIBUTING.md](CONTRIBUTING.md#debugging-issues)

#### Update everything
→ Run `:Lazy sync` and `:Mason` in Neovim

## 🔥 Quick Commands Reference

### In Neovim
```vim
:Lazy           " Manage plugins
:Mason          " Manage LSP servers
:checkhealth    " Check configuration
:help           " Built-in help system
:Telescope      " Fuzzy finder
```

### In Terminal
```bash
# Profile startup time
nvim --startuptime startup.log +q && tail -1 startup.log

# Clean state (if broken)
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Update config from git
cd ~/dotfiles && git pull

# Commit config changes
cd ~/dotfiles && git add .config/nvim && git commit -m "Update nvim config"
```

## 📊 Documentation Stats

- **Total documentation:** ~50 KB
- **Main guides:** 6 files
- **Snippet docs:** 2 files
- **Total config files:** 70+ Lua files
- **Total plugins:** ~50-60 active plugins

## 🎓 Learning Path

### Week 1: Basics
1. Read README.md overview
2. Memorize 5 keybindings from QUICKREF.md
3. Try 3 different snippets
4. Explore plugins with `:Lazy`

### Week 2: Customization  
1. Read CONTRIBUTING.md
2. Add one custom snippet
3. Add one custom keybinding
4. Install one new plugin

### Week 3: Optimization
1. Read OPTIMIZATION.md
2. Complete TODO.md action items
3. Profile your startup time
4. Clean up unused plugins

### Week 4: Mastery
1. Teach someone else
2. Contribute to documentation
3. Share your config
4. Keep iterating!

## 🆘 Getting Help

### Built-in Help
```vim
:help               " Neovim help
:help lua-guide     " Lua in Neovim
:help lazy.nvim     " Plugin manager
:help lsp           " LSP features
```

### External Resources
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim GitHub](https://github.com/folke/lazy.nvim)
- [LazyVim Reference](https://github.com/LazyVim/LazyVim)

### Your Config Files
All documentation is version-controlled in your dotfiles repo!

```bash
cd ~/dotfiles/.config/nvim
ls -l *.md          # List all docs
git log -- *.md     # See doc history
```

## 📝 Quick Tips

- 💡 Press `<Space>` in Neovim to see available keybindings (WhichKey)
- 💡 Use `:Telescope help_tags` to search all help documentation
- 💡 Run `:checkhealth` regularly to catch issues early
- 💡 Keep documentation updated when you change config
- 💡 Commit your changes frequently to git

## 🎉 You're Ready!

Start with [README.md](README.md) for the complete overview, or jump straight to [QUICKREF.md](QUICKREF.md) if you want to start coding!

---

**Last Updated:** $(date)  
**Neovim Version:** 0.11.4  
**Config Location:** ~/.config/nvim
