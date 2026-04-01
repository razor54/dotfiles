local g = vim.g
local opt = vim.opt

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.mapleader = " "
g.autoformat = true

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes:1"

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.textwidth = 200
opt.expandtab = true

opt.smartindent = true
opt.autoindent = true

opt.wrap = false

-- Searching Behaviors
opt.hlsearch = true -- highlight all matches in search
opt.ignorecase = true -- ignore case in search
opt.smartcase = true -- match case if explicitly stated
opt.incsearch = true
opt.inccommand = "split"

opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.modifiable = true
opt.undodir = os.getenv("HOME") .. "/.neovim/undodir"

-- Set nvim clipboard and system clipboard
opt.clipboard = "unnamedplus"

opt.scrolloff = 5
opt.updatetime = 100

opt.termguicolors = true

opt.sessionoptions = {
  "buffers",
  "globals",
  "resize",
}

if not vim.g._ts_markdown_guard then
  vim.g._ts_markdown_guard = true
  local ts_start = vim.treesitter.start
  vim.treesitter.start = function(bufnr, lang)
    local target_buf = bufnr or 0
    local ok, ft = pcall(function()
      return vim.bo[target_buf].filetype
    end)

    local target_lang = lang or (ok and ft) or ""
    if target_lang == "markdown"
      or target_lang == "markdown_inline"
      or ft == "markdown"
      or ft == "md"
      or ft == "rmd"
      or ft == "quarto"
    then
      return
    end

    return ts_start(bufnr, lang)
  end
end
