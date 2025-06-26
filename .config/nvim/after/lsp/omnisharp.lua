---@type vim.lsp.Config
return {
  cmd = { "omnisharp" },
  filetypes = { "cs", "vb" },
  root_dir = function(fname)
    return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
  end,
}
