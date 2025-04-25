vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.loader.enable()

require("config.opts")
require("config.lazy")

require("config.keymaps")
require("config.autocmds")
