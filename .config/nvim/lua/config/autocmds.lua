local nvim_create = vim.api.nvim_create_autocmd
nvim_create("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({})
  end,
  desc = "highlights yank",
})

-- TODO: Check
--nvim_create("FileType", {
--  pattern = "go",
--  callback = function(args)
--    -- Ensure treesitter is active for buffer
--    if not vim.treesitter.highlighter.active[args.buf] then
--      vim.treesitter.start(args.buf, "go")
--    end
--  end,
--})
