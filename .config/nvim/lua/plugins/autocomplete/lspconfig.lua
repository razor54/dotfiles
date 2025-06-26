return {
  {
    "neovim/nvim-lspconfig",
    opts = { inlay_hints = { enabled = true } },
    event = "BufReadPost",
    config = function()
      --require("nvim-highlight-colors").turnOn()
      local lspconfig = require("lspconfig")

      -- Common LSP setup
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- OmniSharp setup
      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = {
          "/usr/local/share/dotnet/dotnet",
          vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll",
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
        },
        enable_import_completion = true,
        organize_imports_on_format = true,
        enable_roslyn_analyzers = true,
        root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
        -- Add environment settings
        cmd_env = {
          DOTNET_ROOT = "/usr/local/share/dotnet",
          MSBuildSDKsPath = "/usr/local/share/dotnet/sdk/9.0.301/Sdks",
          PATH = "/usr/local/share/dotnet:" .. vim.env.PATH,
        },
      })
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
}
