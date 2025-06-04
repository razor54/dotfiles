return {
  "akinsho/bufferline.nvim",
  -- cond = false,
  event = { "BufReadPost", "BufNewFile" },
  -- event = "VimEnter",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  opts = function()
    local bufferline = require("bufferline")
    local fill_hl = "StatusLine"
    local custom_bg = { attribute = "bg", highlight = fill_hl }
    return {
      highlights = {
        -- fill = { bg = custom_bg },
        -- background = { bg = custom_bg },
        -- close_button = { bg = custom_bg },
        -- offset_separator = { bg = custom_bg },
        -- trunc_marker = { bg = custom_bg },
        -- duplicate = { bg = custom_bg },
        -- close_button_selected = { fg = "#B55A67" }, -- *
        -- separator = { fg = custom_bg, bg = custom_bg },
        -- modified = { fg = "#B55A67", bg = custom_bg },
        -- hint = { bg = custom_bg },
        -- hint_diagnostic = { bg = custom_bg },
        -- info = { bg = custom_bg },
        -- info_diagnostic = { bg = custom_bg },
        -- warning = { bg = custom_bg },
        -- warning_diagnostic = { bg = custom_bg },
        -- error = { bg = custom_bg },
        -- error_diagnostic = { bg = custom_bg },
      },
      options = {
        color_icons = false,
        show_buffer_close_icons = false,
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_close_icon = true,
        show_tab_indicators = true,
        buffer_close_icon = "",
        modified_icon = "",
        diagnostics = "nvim_lsp",
        -- diagnostics = false,
        always_show_bufferline = true,
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          -- style = "none", -- "icon" | "underline" | "none",
        },
        separator_style = { " ", " " },
        diagnostics_indicator = function(_, _, diag)
          local icons = require("utils").diagnostic_icons
          local ret = (diag.error and icons.Error .. diag.error .. "" or "")
            .. (diag.warning and icons.Warn .. diag.warning .. "" or "")
            .. (diag.info and icons.Info .. diag.info .. "" or "")
            .. (diag.hint and icons.Hint .. diag.hint or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            -- highlight = "BufferLineBackground",
            highlight = "NeoTreeNormal",
            text_align = "center",
          },
          {
            filetype = "NvimTree",
            highlight = "NvimTreeNormal",
            separator = false,
          },
        },
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
        },
        -- get_element_icon = function(element)
        --   -- element consists of {filetype: string, path: string, extension: string, directory: string}
        --   -- This can be used to change how bufferline fetches the icon
        --   -- for an element e.g. a buffer or a tab.
        --   -- e.g.
        --   -- local icon, hl = require("nvim-web-devicons").get_icon_by_filetype(element.filetype, { default = false })
        --   -- return icon, hl
        --   local icons = require("mini.icons").file or {}
        --   local icon = icons[element.extension] or icons.default or "󰈚"
        --   local hl = "MiniIconsFile"
        --   return icon, hl
        -- end,
      },
    }
  end,
}
