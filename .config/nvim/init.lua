vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.loader.enable()

require("config.opts")
require("config.lazy")

require("config.keymaps")
require("config.autocmds")

-- Theme
vim.cmd.colorscheme "catppuccin"

-- TODO: Remove
--vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--  pattern = '*.go',
--  callback = function() vim.bo.filetype = 'go' end
--})
