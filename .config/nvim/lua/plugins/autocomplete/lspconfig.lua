return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
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
