return {
  "NMAC427/guess-indent.nvim",
  event = { "BufReadPost", "BufNewFile" }, -- Proper LazyVim lazy-loading trigger
  opts = {
    auto_cmd = true,
    override_editorconfig = false,
    filetype_exclude = {
      "netrw",
      "tutor",
      "help", -- Added common exclusions
      "lazy", -- LazyVim UI
      "mason", -- Mason UI
      "neo-tree", -- File explorer
      "TelescopePrompt",
      "snacks-picker-list", -- the explorer list
    },
    buftype_exclude = {
      "help",
      "nofile",
      "terminal",
      "prompt",
      "quickfix", -- Added common exclusions
      "nofile",
    },
    on_tab_options = {
      expandtab = false, -- Use tabs when tab indentation detected
    },
    on_space_options = {
      expandtab = true, -- Use spaces when space indentation detected
      tabstop = "detected",
      softtabstop = "detected",
      shiftwidth = "detected",
    },
  },
  config = function(_, opts)
    local guess_indent = require("guess-indent")
    guess_indent.setup(opts)

    -- Optional: Add user commands for manual triggering
    --vim.api.nvim_create_user_command("GuessIndent", function()
    --  guess_indent.guess()
    --end, {})
  end,
}
