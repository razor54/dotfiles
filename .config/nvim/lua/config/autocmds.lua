local nvim_create = vim.api.nvim_create_autocmd

nvim_create("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({})
  end,
  desc = "highlights yank",
})

nvim_create("User", {
  pattern = "GitConflictDetected",
  callback = function()
    vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
    vim.keymap.set("n", "cww", function()
      engage.conflict_buster()
      create_buffer_local_mappings()
    end)
  end,
})

-- TODO: Find out why we need this to fix the filetype detection
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local name = vim.api.nvim_buf_get_name(args.buf)
    if ft == "" and name ~= "" then
      vim.api.nvim_buf_call(args.buf, function()
        vim.cmd("filetype detect")
      end)
    end
  end,
  desc = "Force filetype detection for Snacks explorer buffers",
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
