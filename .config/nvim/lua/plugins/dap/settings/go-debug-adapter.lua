local uv = vim.uv or vim.loop

local M = {}

local function get_dap()
  return require("dap")
end

local function is_executable(path)
  return path and path ~= "" and vim.fn.executable(path) == 1
end

local function resolve_dlv_command()
  local mason_dlv = vim.fn.stdpath("data") .. "/mason/bin/dlv"
  if is_executable(mason_dlv) then
    return mason_dlv
  end

  local system_dlv = vim.fn.exepath("dlv")
  if is_executable(system_dlv) then
    return system_dlv
  end

  return mason_dlv
end

local function current_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return nil
  end
  return vim.fn.fnamemodify(file, ":p")
end

local function current_dir()
  local file = current_file()
  if file then
    return vim.fn.fnamemodify(file, ":h")
  end

  return uv.cwd() or vim.fn.getcwd()
end

local function resolve_go_root(start_dir)
  local dir = start_dir

  while dir and dir ~= "" do
    if vim.fn.filereadable(dir .. "/go.work") == 1 or vim.fn.filereadable(dir .. "/go.mod") == 1 then
      return dir
    end

    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  return nil
end

local function resolve_cwd()
  local dir = current_dir()
  local root = resolve_go_root(dir)
  if root then
    return root
  end

  error("Go module root not found from " .. dir .. ". Open a file inside a go.mod/go.work workspace.")
end

local function resolve_program_dir()
  return current_dir()
end

local function resolve_env()
  return {
    PWD = resolve_cwd(),
  }
end

local function has_main_function(dir)
  local files = vim.fn.globpath(dir, "*.go", false, true)
  for _, file in ipairs(files) do
    local lines = vim.fn.readfile(file)
    for _, line in ipairs(lines) do
      if line:match("^%s*func%s+main%s*%(") then
        return true
      end
    end
  end

  return false
end

local function file_contains_main(file)
  if not file or file == "" or vim.fn.filereadable(file) ~= 1 then
    return false
  end

  local lines = vim.fn.readfile(file)
  for _, line in ipairs(lines) do
    if line:match("^%s*func%s+main%s*%(") then
      return true
    end
  end

  return false
end

local function resolve_main_file()
  local file = current_file()
  if file_contains_main(file) then
    return file
  end
  error("Debug (current file main): current file does not contain main()")
end

local function has_test_files(dir)
  local files = vim.fn.globpath(dir, "*_test.go", false, true)
  return files and #files > 0
end

local function go_config(name)
  local dap = get_dap()
  local configs = dap.configurations.go or {}
  for _, cfg in ipairs(configs) do
    if cfg.name == name then
      return cfg
    end
  end
  return nil
end

local function run_go_config(name, overrides)
  local cfg = go_config(name)
  if not cfg then
    vim.notify("Go DAP configuration not found: " .. name, vim.log.levels.ERROR)
    return false
  end

  local run_cfg = vim.deepcopy(cfg)
  if overrides then
    run_cfg = vim.tbl_deep_extend("force", run_cfg, overrides)
  end

  get_dap().run(run_cfg)
  return true
end

local function resolve_main_program()
  local dir = resolve_program_dir()
  if not has_main_function(dir) then
    error("Debug (requires main): no main() function found in " .. dir)
  end
  return dir
end

local function extract_test_name(line)
  return line:match("^%s*func%s+([Tt]est[%w_]+)%s*%(")
    or line:match("^%s*func%s*%b()%s*([Tt]est[%w_]+)%s*%(")
end

local function nearest_test_name()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_line, false)

  for idx = #lines, 1, -1 do
    local name = extract_test_name(lines[idx])
    if name then
      return name
    end
  end

  return nil
end

function M.setup()
  local dap = get_dap()

  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = resolve_dlv_command(),
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug (current file main)",
      request = "launch",
      mode = "debug",
      program = resolve_main_file,
      cwd = resolve_cwd,
      env = resolve_env,
      outputMode = "remote",
      console = "integratedTerminal",
    },
    {
      type = "go",
      name = "Debug (requires main)",
      request = "launch",
      mode = "debug",
      program = resolve_main_program,
      cwd = resolve_cwd,
      env = resolve_env,
      outputMode = "remote",
      console = "integratedTerminal",
    },
    {
      type = "go",
      name = "Debug Test",
      request = "launch",
      mode = "test",
      program = resolve_program_dir,
      cwd = resolve_cwd,
      env = resolve_env,
      args = { "-test.v" },
      outputMode = "remote",
      console = "integratedTerminal",
    },
  }
end

function M.select_go_launch()
  local dap = get_dap()

  if not dap.configurations.go or vim.tbl_isempty(dap.configurations.go) then
    M.setup()
    dap = get_dap()
  end

  if vim.bo.filetype ~= "go" then
    return false
  end

  if dap.session and dap.session() then
    dap.continue()
    return true
  end

  local file = current_file() or ""
  local dir = resolve_program_dir()
  local choices = {}

  if file:match("_test%.go$") then
    local test_name = nearest_test_name()
    if test_name then
      table.insert(choices, {
        label = "Debug nearest test",
        run = function()
          dap.run({
            type = "go",
            name = "Debug Test (Nearest)",
            request = "launch",
            mode = "test",
            program = resolve_program_dir,
            cwd = resolve_cwd,
            env = resolve_env,
            args = { "-test.v", "-test.run", "^" .. test_name .. "$" },
            outputMode = "remote",
            console = "integratedTerminal",
          })
        end,
      })
    end

    if has_test_files(dir) then
      table.insert(choices, {
        label = "Debug package tests",
        run = function()
          run_go_config("Debug Test")
        end,
      })
    end
  else
    if file_contains_main(file) then
      table.insert(choices, {
        label = "Debug current file main",
        run = function()
          run_go_config("Debug (current file main)")
        end,
      })
    end

    if has_main_function(dir) then
      table.insert(choices, {
        label = "Debug package main",
        run = function()
          run_go_config("Debug (requires main)")
        end,
      })
    end

    if has_test_files(dir) then
      table.insert(choices, {
        label = "Debug package tests",
        run = function()
          run_go_config("Debug Test")
        end,
      })
    end
  end

  table.insert(choices, {
    label = "Show default DAP config picker",
    run = function()
      dap.continue()
    end,
  })

  local labels = {}
  for _, choice in ipairs(choices) do
    table.insert(labels, choice.label)
  end

  vim.ui.select(labels, { prompt = "Go DAP launch:" }, function(selected)
    if not selected then
      return
    end

    for _, choice in ipairs(choices) do
      if choice.label == selected then
        choice.run()
        return
      end
    end
  end)

  return true
end

function M.continue_with_go_defaults()
  return M.select_go_launch()
end

return M
