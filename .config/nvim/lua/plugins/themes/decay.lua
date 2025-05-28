return {
  "decaycs/decay.nvim",
  name = "decay",
  --lazy = false,
  priority = 1000,
  config = function()
    -- SNIP
    local decay = require("decay")

    local opt = vim.opt
    local cmd = vim.cmd

    --opt.background = "light"
    opt.background = "dark"

    decay.setup({
      style = "default",

      -- enables italics in code keywords & comments.
      italics = {
        code = true,
        comments = true,
      },

      -- enables contrast when using nvim tree.
      nvim_tree = {
        contrast = true,
      },
    })

    cmd.colorscheme("decay")
  end,
}
