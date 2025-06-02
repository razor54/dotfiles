--return {
--"echasnovski/mini.tabline",
--version = "*",
--lazy = true,
--config = true,
--event = {
--  "BufReadPre",
--  "BufNewFile",
--},
--opts = {},
--}
--#region

return {
  "echasnovski/mini.tabline",
  version = false,
  cond = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    show_icons = false,
    format = function(buf_id, label)
      local MiniTabline = require("mini.tabline").default_format(buf_id, label)
      -- local suffix = vim.bo[buf_id].modified and "+ " or "  "
      -- return string.format("  %s%s", MiniTabline, suffix)
      return string.format(" %s ", MiniTabline)
    end,
  },
}
