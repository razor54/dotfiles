vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.loader.enable()

require("config.opts")
require("config.lazy")

require("config.keymaps")
require("config.autocmds")

-- Theme
--vim.cmd.colorscheme("catppuccin")

-- Format using conform
--vim.lsp.buf.format = function(opts)
--  opts = opts or {}
--  opts.bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
--  require("conform").format(opts)
--end
