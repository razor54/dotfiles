return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "-" },
      topdelete = { text = "↑" },
      changedelete = { text = "·" },
    },
    signs_staged = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "-" },
      topdelete = { text = "↑" },
      changedelete = { text = "·" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next Git hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Previous Git hunk" })

      -- Actions
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage visual hunk" })

      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset visual hunk" })

      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Inline preview hunk" })

      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame line" })

      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })

      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { desc = "Diff this (base)" })

      map("n", "<leader>hQ", function()
        gitsigns.setqflist("all")
      end, { desc = "Git QF list (all)" })

      map("n", "<leader>hq", gitsigns.setqflist, { desc = "Git QF list" })

      -- Toggles
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
      map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
      map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git hunk text object" })
    end,
  },
}
