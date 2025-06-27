return {
  -- cmd = { "roslyn-lsp" },
  -- filetypes = { "cs", "vb" },
  -- root_dir = function(fname)
  --   return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
  -- end,
  cmd = { "roslyn" },
  filetypes = { "cs" },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
}
