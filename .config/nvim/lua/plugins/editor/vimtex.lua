return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  ft = "tex",
  config = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      options = { "-pdf", "-shell-escape", "-verbose", "-pvc" },
    }
  end,
}
