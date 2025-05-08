---@type vim.lsp.Config

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end
  end,
  --capabilities = require("blink.cmp").get_lsp_capabilities(),
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT", -- Use LuaJIT
        path = vim.split(package.path, ";"), -- Inherit Neovim's Lua paths
      },
      hint = { enable = true },
      diagnostics = {
        globals = { "vim" }, -- Recognize Neovim global vars like `vim.api`
      },
      workspace = {
        library = {
          -- Make Neovim runtime accessible to Lua LSP
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim")] = true,

          -- Add path to blink.cmp (adjust based on your package manager)
          [vim.fn.stdpath("data") .. "/lazy/blink.cmp/lua"] = true,
        },
        checkThirdParty = false, -- Disable "third party library" warnings
      },
      telemetry = { enable = false },
    },
  },
}
