return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      -- Add floating window configuration
      -- window = {
      --   completion = {
      --     border = "rounded",
      --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      --     zindex = 1001,
      --     scrolloff = 0,
      --     col_offset = 0,
      --     side_padding = 1,
      --   },
      --   documentation = {
      --     border = "rounded",
      --     winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      --     zindex = 1002,
      --     max_width = 80,
      --     min_width = 60,
      --     max_height = math.floor(vim.o.lines * 0.3),
      --   },
      -- },
      -- -- Configure floating preview behavior
      -- hover = {
      --   enabled = true,
      --   silent = true,
      --   view = nil, -- when nil, use defaults from documentation
      --   opts = {
      --     border = "rounded",
      --     max_width = 80,
      --     position = "auto",
      --   },
      -- },
      --
      -- -- Add completion formatting configuration
      -- formatting = {
      --   format = function(entry, vim_item)
      --     -- Customize how completion items are displayed
      --     vim_item.kind = string.format("%s %s", vim_item.kind, vim_item.abbr)
      --     vim_item.menu = ({
      --       buffer = "[Buffer]",
      --       nvim_lsp = "[LSP]",
      --       luasnip = "[Snippet]",
      --       path = "[Path]",
      --     })[entry.source.name]
      --     return vim_item
      --   end,
      -- },

      -- servers = {
      --   csharp_ls = {
      --     cmd = { "csharp-ls" },
      --     filetypes = { "cs", "vb" },
      --     root_dir = function(fname)
      --       print("csharp_ls root_dir called for", fname)
      --       return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
      --     end,
      --   },
      -- },
    },
    event = "BufReadPost",
    config = function()
      --require("nvim-highlight-colors").turnOn()
    end,
    dependencies = {
      "mason-org/mason-lspconfig.nvim",

      {
        "linrongbin16/lsp-progress.nvim",
        opts = {
          max_size = 50,
          spinner = { "", "󰪞", "󰪟", "󰪠", "󰪢", "󰪣", "󰪤", "󰪥" },
          -- client_format = function(client_name, spinner, series_messages)
          client_format = function(_, spinner, series_messages)
            return #series_messages > 0
                -- and (spinner .. " [" .. client_name .. "] " .. table.concat(series_messages, ", "))
                -- and (spinner .. " (LSP) " .. table.concat(series_messages, ", "))
                and (spinner .. " LSP")
              or nil
          end,
          format = function(client_messages)
            if #client_messages > 0 then
              return table.concat(client_messages, " ")
            end
            return ""
          end,
        },
      },
    },
  },
  -- Lsp notifications
  {
    "j-hui/fidget.nvim",
    event = "BufReadPre",
    opts = {},
  },
  -- LuaLS configuration for vim
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  -- {
  --   "Decodetalkers/csharpls-extended-lsp.nvim",
  --   ft = { "cs" },
  -- },
}
