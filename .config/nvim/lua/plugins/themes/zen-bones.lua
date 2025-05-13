return {
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    --lazy = false,
    lazy = true, -- the theme is disabled so we don't want to load it
    priority = 1000,
    config = function()
      --vim.cmd.colorscheme("zenwritten") -- or "zenbones"
    end,
  },
}
