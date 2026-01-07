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
  --[[
    VimTeX basic keybinds:
      \ll   : Compile the LaTeX document
      \lv   : View the compiled PDF
      \lk   : Stop compilation
      \le   : Show compilation errors
      \lc   : Clean auxiliary files
      ]]
}
