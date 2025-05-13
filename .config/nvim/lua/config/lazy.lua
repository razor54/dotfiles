local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  defaults = { lazy = true },
  -- automatically check for plugin updates
  checker = { enabled = false },
  install = { colorscheme = { "catppuccin" } },
  spec = {
    { import = "plugins.autocomplete" },
    { import = "plugins.filetree" },
    { import = "plugins.mini-plugins" },
    { import = "plugins.treesitter" },
    { import = "plugins.general" },
    { import = "plugins.whichkey" },
    { import = "plugins.themes" },
    { import = "plugins.editor" },
    { import = "plugins.dap" },
    -- TODO: Clean up this next part
    { import = "plugins.bloat-detection" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "tar",
        "tarPlugin",
        "tutor",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
      },
    },
  },
})
