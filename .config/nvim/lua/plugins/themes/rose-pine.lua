return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- or "moon" for a slightly darker look
        dark_variant = "main", -- or "moon"
        disable_italics = true,
        disable_float_background = true,
        highlight_groups = {
          -- Optional: make floats and popups transparent
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          -- Optional: make comments less colorful
          Comment = { fg = "muted" },
        },
        groups = {
          -- Optional: reduce color on UI elements
          border = "muted",
          panel = "surface",
        },
      })
      --vim.cmd.colorscheme("rose-pine")
    end,
  },
}
