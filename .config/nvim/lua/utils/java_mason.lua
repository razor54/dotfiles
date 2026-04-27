local M = {}

local FALLBACK_INSTALL_INTENT = {
  lsp = { "jdtls" },
  runtime = { "java-debug-adapter", "java-test", "lombok-nightly" },
}

local JAVA_MISSING_REMEDIATION = table.concat({
  "Java executable was not found.",
  "GUI-launched macOS Neovim may not inherit your shell PATH.",
  "Set vim.g.java_executable to a valid Java binary or configure JAVA_HOME/PATH for GUI apps.",
}, " ")

local function notify_once(message, level)
  vim.schedule(function()
    vim.notify_once(message, level or vim.log.levels.INFO, { title = "Java Mason" })
  end)
end

local function list_contains(list, value)
  for _, item in ipairs(list) do
    if item == value then
      return true
    end
  end

  return false
end

local function unique(list)
  local seen = {}
  local result = {}

  for _, item in ipairs(list) do
    if item ~= "" and not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end

  return result
end

local function glob_list(pattern)
  local matches = vim.fn.glob(pattern, false, true)

  if type(matches) == "string" then
    return matches ~= "" and { matches } or {}
  end

  return unique(matches)
end

local function is_directory(path)
  return vim.fn.isdirectory(path) == 1
end

local function is_file(path)
  return vim.fn.filereadable(path) == 1
end

local function is_executable(path)
  return type(path) == "string" and path ~= "" and vim.fn.executable(path) == 1
end

local function get_install_intent()
  local install_intent = vim.g.java_mason_install_intent

  if type(install_intent) ~= "table" then
    return vim.deepcopy(FALLBACK_INSTALL_INTENT)
  end

  return {
    lsp = vim.deepcopy(install_intent.lsp or FALLBACK_INSTALL_INTENT.lsp),
    runtime = vim.deepcopy(install_intent.runtime or FALLBACK_INSTALL_INTENT.runtime),
  }
end

local function flatten_install_intent(install_intent)
  local packages = {}

  vim.list_extend(packages, install_intent.lsp)
  vim.list_extend(packages, install_intent.runtime)

  return unique(packages)
end

local function detect_system()
  if vim.fn.has("mac") == 1 then
    return "mac"
  end

  if vim.fn.has("win32") == 1 then
    return "win"
  end

  return "linux"
end

local function package_path(package_name)
  return ("%s/mason/packages/%s"):format(vim.fn.stdpath("data"), package_name)
end

local function new_state()
  local install_intent = get_install_intent()
  local system = detect_system()
  local java_home = vim.env.JAVA_HOME
  local paths = {
    packages = {},
    java_home_executable = java_home and java_home ~= "" and (java_home .. "/bin/java") or nil,
  }

  for _, package_name in ipairs(flatten_install_intent(install_intent)) do
    paths.packages[package_name] = package_path(package_name)
  end

  paths.system = system
  paths.jdtls_config = paths.packages.jdtls .. "/config_" .. system
  paths.jdtls_launcher_glob = paths.packages.jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar"
  paths.java_debug_bundle_glob = paths.packages["java-debug-adapter"] .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
  paths.java_test_bundle_glob = paths.packages["java-test"] .. "/extension/server/*.jar"
  paths.lombok_nightly_jar = paths.packages["lombok-nightly"] .. "/lombok.jar"
  paths.jdtls_lombok_jar = paths.packages.jdtls .. "/lombok.jar"

  return {
    install_intent = install_intent,
    paths = paths,
    missing_packages = {},
    broken_packages = {},
    problems = {},
    bundles = nil,
    bundles_ready = false,
    jdtls_ready = false,
    java_executable = nil,
    java_executable_source = nil,
    equinox_launcher = nil,
    lombok_jar = nil,
  }
end

local function add_problem(state, package_name, message)
  table.insert(state.problems, message)

  if package_name and not list_contains(state.broken_packages, package_name) then
    table.insert(state.broken_packages, package_name)
  end
end

local function add_missing_package(state, package_name)
  if not list_contains(state.missing_packages, package_name) then
    table.insert(state.missing_packages, package_name)
  end
end

local function report_java_missing(state)
  add_problem(state, nil, JAVA_MISSING_REMEDIATION)
end

local function validate_java_executable(state)
  local configured_executable = vim.g.java_executable
  if configured_executable ~= nil then
    if is_executable(configured_executable) then
      state.java_executable = configured_executable
      state.java_executable_source = "vim.g.java_executable"
      return
    end

    add_problem(
      state,
      nil,
      ("vim.g.java_executable is set but is not executable: %s. %s"):format(configured_executable, JAVA_MISSING_REMEDIATION)
    )
    return
  end

  local java_home_executable = state.paths.java_home_executable
  if java_home_executable and is_executable(java_home_executable) then
    state.java_executable = java_home_executable
    state.java_executable_source = "JAVA_HOME"
    return
  end

  local java_on_path = vim.fn.exepath("java")
  if is_executable(java_on_path) then
    state.java_executable = java_on_path
    state.java_executable_source = "PATH"
    return
  end

  report_java_missing(state)
end

local function validate_jdtls(state)
  local jdtls_path = state.paths.packages.jdtls

  if not is_directory(jdtls_path) then
    add_missing_package(state, "jdtls")
    return
  end

  if not is_directory(state.paths.jdtls_config) then
    add_problem(state, "jdtls", ("Mason package 'jdtls' is installed but missing config directory: %s"):format(state.paths.jdtls_config))
  end

  local launchers = glob_list(state.paths.jdtls_launcher_glob)
  if #launchers == 0 then
    add_problem(state, "jdtls", ("Mason package 'jdtls' is installed but missing Equinox launcher jars: %s"):format(state.paths.jdtls_launcher_glob))
  else
    state.equinox_launcher = launchers[1]
  end

  if is_file(state.paths.lombok_nightly_jar) then
    state.lombok_jar = state.paths.lombok_nightly_jar
  elseif is_file(state.paths.jdtls_lombok_jar) then
    state.lombok_jar = state.paths.jdtls_lombok_jar
  else
    add_problem(state, "jdtls", "No readable Lombok jar was found in either mason/packages/lombok-nightly or mason/packages/jdtls.")
  end

  state.jdtls_ready = state.equinox_launcher ~= nil
    and state.java_executable ~= nil
    and is_directory(state.paths.jdtls_config)
    and state.lombok_jar ~= nil
    and not list_contains(state.missing_packages, "jdtls")
    and not list_contains(state.broken_packages, "jdtls")
end

local function validate_bundle_package(state, package_name, glob_pattern, empty_message)
  local package_dir = state.paths.packages[package_name]

  if not is_directory(package_dir) then
    add_missing_package(state, package_name)
    return {}
  end

  local jars = glob_list(glob_pattern)
  if #jars == 0 then
    add_problem(state, package_name, empty_message)
  end

  return jars
end

local function validate_runtime_package(state, package_name, required_file, missing_message)
  local package_dir = state.paths.packages[package_name]

  if not is_directory(package_dir) then
    add_missing_package(state, package_name)
    return false
  end

  if not is_file(required_file) then
    add_problem(state, package_name, missing_message)
    return false
  end

  return true
end

local function validate_bundles(state)
  local debug_bundles = validate_bundle_package(
    state,
    "java-debug-adapter",
    state.paths.java_debug_bundle_glob,
    ("Mason package 'java-debug-adapter' is installed but missing debug jars: %s"):format(state.paths.java_debug_bundle_glob)
  )

  local test_bundles = validate_bundle_package(
    state,
    "java-test",
    state.paths.java_test_bundle_glob,
    ("Mason package 'java-test' is installed but missing test jars: %s"):format(state.paths.java_test_bundle_glob)
  )

  local lombok_ready = validate_runtime_package(
    state,
    "lombok-nightly",
    state.paths.lombok_nightly_jar,
    ("Mason package 'lombok-nightly' is installed but missing lombok.jar: %s"):format(state.paths.lombok_nightly_jar)
  )

  if #debug_bundles == 0 or #test_bundles == 0 or not lombok_ready then
    state.bundles = nil
    state.bundles_ready = false
    return
  end

  state.bundles = unique(vim.list_extend(vim.deepcopy(debug_bundles), test_bundles))
  state.bundles_ready = #state.bundles > 0
end

local function ensure_missing_packages(state)
  if #state.missing_packages == 0 then
    return
  end

  local ok, registry = pcall(require, "mason-registry")
  if not ok then
    notify_once("mason-registry is unavailable, so missing Java Mason packages cannot be installed automatically.", vim.log.levels.ERROR)
    return
  end

  pcall(registry.refresh)

  for _, package_name in ipairs(state.missing_packages) do
    local ok_package, package = pcall(registry.get_package, package_name)

    if not ok_package then
      notify_once(("Mason registry does not know about Java package '%s'."):format(package_name), vim.log.levels.ERROR)
    elseif package:is_installed() or package:is_installing() then
      notify_once(("Waiting for Mason package '%s' to finish installing."):format(package_name), vim.log.levels.WARN)
    else
      package:install({}, function(success)
        if success then
          vim.schedule(function()
            vim.notify(("Installed missing Mason package '%s'. Reopen the Java buffer to enable debug/test bundles."):format(package_name), vim.log.levels.INFO, { title = "Java Mason" })
          end)
        else
          vim.schedule(function()
            vim.notify(("Failed to install missing Mason package '%s'. Run :Mason and inspect the install logs."):format(package_name), vim.log.levels.ERROR, { title = "Java Mason" })
          end)
        end
      end)

      notify_once(("Installing missing Mason package '%s' for Java support."):format(package_name), vim.log.levels.WARN)
    end
  end
end

local function report_problems(state)
  if #state.missing_packages > 0 then
    notify_once(
      ("Java Mason packages missing: %s. Installation has been requested; reopen the Java buffer after Mason finishes."):format(table.concat(state.missing_packages, ", ")),
      vim.log.levels.WARN
    )
  end

  if #state.broken_packages > 0 then
    notify_once(
      ("Java Mason packages need remediation: %s. Reinstall them with :MasonInstall after removing the broken package contents."):format(table.concat(state.broken_packages, ", ")),
      vim.log.levels.ERROR
    )
  end

  for _, problem in ipairs(state.problems) do
    notify_once(problem, vim.log.levels.ERROR)
  end

  if state.jdtls_ready and not state.bundles_ready then
    notify_once("Java debug/test bundles are disabled until Mason has complete java-debug-adapter, java-test, and lombok-nightly package contents.", vim.log.levels.WARN)
  end
end

function M.inspect_runtime()
  local state = new_state()

  validate_java_executable(state)
  validate_jdtls(state)
  validate_bundles(state)
  ensure_missing_packages(state)
  report_problems(state)

  return state
end

function M.resolve_java_executable()
  local state = new_state()

  validate_java_executable(state)
  report_problems(state)

  return {
    java_executable = state.java_executable,
    java_executable_source = state.java_executable_source,
    problems = vim.deepcopy(state.problems),
  }
end

function M.readiness_summary()
  local state = M.inspect_runtime()

  return {
    java_executable = state.java_executable,
    java_executable_source = state.java_executable_source,
    jdtls_ready = state.jdtls_ready,
    bundles_ready = state.bundles_ready,
    missing_packages = vim.deepcopy(state.missing_packages),
    broken_packages = vim.deepcopy(state.broken_packages),
    has_launcher = state.equinox_launcher ~= nil,
    has_jdtls_config = is_directory(state.paths.jdtls_config),
    has_lombok = state.lombok_jar ~= nil,
    has_java_debug_adapter = is_directory(state.paths.packages["java-debug-adapter"]),
    has_java_test = is_directory(state.paths.packages["java-test"]),
    problems = vim.deepcopy(state.problems),
  }
end

return M
