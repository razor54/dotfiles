vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.loader.enable()

require("config.opts")
require("config.lazy")

require("config.keymaps")
require("config.autocmds")

-- Require status line
require("config.statusline")

vim.lsp.set_log_level("WARN")
