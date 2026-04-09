-- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration for more guide.
local dap = require("dap")
local java_mason = require("utils.java_mason")
local java_runtime = java_mason.resolve_java_executable()

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

if java_runtime.java_executable then
  table.insert(dap.configurations.java, 1, {
    name = "Launch Java",
    javaExec = java_runtime.java_executable,
    request = "launch",
    type = "java",
  })
end
