local nvim_create = vim.api.nvim_create_autocmd
nvim_create("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({})
  end,
  desc = "highlights yank",
})

-- TODO: Check
nvim_create("FileType", {
  pattern = "go",
  callback = function(args)
    -- Ensure treesitter is active for buffer
    if not vim.treesitter.highlighter.active[args.buf] then
      vim.treesitter.start(args.buf, "go")
    end
  end,
})

-- Monochrome theme
--vim.api.nvim_create_autocmd("ColorScheme", {
--  pattern = "monochrome",
--  callback = function()
--    -- Set functions to a neutral grey
--    vim.api.nvim_set_hl(0, "Function", { fg = "#bbbbbb", bold = false, italic = false })
--    vim.api.nvim_set_hl(0, "@function", { fg = "#bbbbbb", bold = false, italic = false })
--    vim.api.nvim_set_hl(0, "@function.call", { fg = "#bbbbbb", bold = false, italic = false })
--
--    -- Set indent lines to a dark grey
--    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#555555", nocombine = true })
--    vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#888888", nocombine = true })
--    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#555555", nocombine = true })
--    -- Snacks.nvim indent line (if used)
--    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#555555", nocombine = true })
--  end,
--})
--
--vim.api.nvim_create_autocmd("User", {
--  pattern = "SnacksLoaded", -- this event is fired by snacks.nvim after setup
--  callback = function()
--    -- Fix indent color from snacks.nvim
--    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#555555", nocombine = true })
--    -- If you use mini.indentscope too
--    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#555555", nocombine = true })
--  end,
--})
--
--vim.api.nvim_create_autocmd("ColorScheme", {
--  pattern = "monochrome",
--  callback = function()
--    -- Neutralize function highlights
--    vim.api.nvim_set_hl(0, "Function", { fg = "#bbbbbb", bold = false, italic = false })
--    vim.api.nvim_set_hl(0, "@function", { fg = "#bbbbbb", bold = false, italic = false })
--    vim.api.nvim_set_hl(0, "@function.call", { fg = "#bbbbbb", bold = false, italic = false })
--  end,
--})

--vim.api.nvim_create_autocmd("ColorScheme", {
--  callback = function()
--    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#555555", nocombine = true })
--    vim.api.nvim_set_hl(0, "IblScope", { fg = "#888888", nocombine = true })
--    vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#555555", nocombine = true })
--    vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#555555", nocombine = true })
--    vim.api.nvim_set_hl(0, "Label", { fg = "#bbbbbb" })
--    vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = "#888888", italic = true, nocombine = true })
--    vim.api.nvim_set_hl(0, "CmpGhostText", { fg = "#888888", italic = true, nocombine = true })
--    vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#888888", italic = true, nocombine = true })
--  end,
--})
