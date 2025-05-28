return {
  "ggandor/leap.nvim",
  enabled = true,
  keys = {
    { "s", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
    { "S", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
  },
  opts = {},
  config = function(_, opts)
    local leap = require("leap")
    for k, v in pairs(opts or {}) do
      leap.opts[k] = v
    end
    leap.add_default_mappings(true)
    -- Optional: remove conflicting mappings if you use mini.surround or similar
    vim.keymap.del({ "x", "o" }, "x")
    vim.keymap.del({ "x", "o" }, "X")
  end, -- You can add leap options here if desired
}
