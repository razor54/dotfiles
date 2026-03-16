local dap = require("dap")
dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = false,
    program = "${file}",
    dlvToolPath = vim.fn.stdpath("data") .. "/mason/bin/dlv",
  },
  {
    type = "go",
    name = "Debug Test",
    request = "launch",
    mode = "test",
    cwd = function()
      return vim.fn.getcwd()
    end,
    program = function()
      local file_dir = vim.fn.expand("%:p:h")
      local cwd = vim.fn.getcwd()
      local rel = file_dir:gsub("^" .. vim.pesc(cwd) .. "/", "")
      return "./" .. rel
    end,
    dlvToolPath = vim.fn.stdpath("data") .. "/mason/bin/dlv",
  },
}
