return {
  "xemptuous/sqlua.nvim",
  lazy = true,
  cmd = "SQLua",
  config = function()
    require("sqlua").setup()
  end,
  -- Open SQLua with the command :SQLua
  -- Edit connections with :SQLuaEdit
  -- <leader>r (normal mode): Runs the entire buffer as a query.
  -- <leader>r (visual mode): Runs the selected lines as a query. (visual, visual block, and/or visual line)
}
