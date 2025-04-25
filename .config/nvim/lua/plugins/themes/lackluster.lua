return {
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optional: tweak colors BEFORE setting the colorscheme
      -- require("lackluster").setup({
      --   tweak_color = {
      --     lack = "#aaaa77",
      --     -- customize as desired
      --   },
      -- })
      --vim.cmd.colorscheme("lackluster") -- or "lackluster-hack" or "lackluster-mint"
      --vim.cmd.colorscheme("lackluster")
    end,
  },
}
