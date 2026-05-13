return {
  "max397574/better-escape.nvim",
  event = "BufReadPre",
  opts = {
    mapping = { "jk", "kj", "JK", "KJ", "jK", "kJ", "Jk", "Kj" },
    timeout = 120,
    clear_empty_lines = false,
    keys = "<Esc>",
  },
  config = function()
    local function esc_with_blink_dismiss()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        blink.cancel()
        -- catch async completions triggered by the 'j' keystroke resolving late
        vim.schedule(function()
          if blink.is_visible() then
            blink.cancel()
          end
        end)
      end
      return "<Esc>"
    end

    require("better_escape").setup({
      timeout = vim.o.timeoutlen,
      default_mappings = true,
      mappings = {
        i = {
          j = {
            k = esc_with_blink_dismiss,
            j = esc_with_blink_dismiss,
          },
        },
        c = {
          j = {
            k = "<C-c>",
            j = "<C-c>",
          },
        },
        t = {
          j = {
            k = "<C-\\><C-n>",
          },
        },
        v = {
          j = {
            k = "<Esc>",
          },
        },
        s = {
          j = {
            k = "<Esc>",
          },
        },
      },
    })
  end,
}
