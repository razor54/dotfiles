local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

M.keys = {
  {
    key = "W",
    mods = "CMD|SHIFT",
    action = act.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "|",
    mods = "CTRL|SHIFT",
    action = act.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },
  {
    key = "Tab",
    mods = "ALT",
    action = wezterm.action.ActivateLastTab,
  },
  {
    key = "t",
    mods = "CMD|SHIFT",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "?",
    mods = "CTRL|SHIFT",
    action = act.SplitPane({
      direction = "Down",
      size = { Percent = 50 },
    }),
  },
  {
    key = "<",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      local newPane = pane:mux_pane()
      newPane:split({ direction = "Left", size = 0.30 })
      win:perform_action(act.ActivatePaneDirection("Right"), pane)
    end),
  },
  {
    key = ">",
    mods = "CTRL|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      local newPane = pane:mux_pane()
      newPane:split({ direction = "Right", size = 0.28 })
      win:perform_action(act.ActivatePaneDirection("Left"), pane)
    end),
  },
  {
    key = "+",
    mods = "CTRL|SHIFT",
    action = act.SplitPane({
      direction = "Down",
      size = { Percent = 30 },
    }),
  },
  {
    key = "H",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "K",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "J",
    mods = "CTRL|SHIFT",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "RightArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Right", 1 }),
  },
  {
    key = "LeftArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Left", 1 }),
  },
  {
    key = "DownArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Down", 1 }),
  },
  {
    key = "UpArrow",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Up", 1 }),
  },
  {
    key = "P",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuickSelectArgs({
      label = "open url",
      patterns = {
        "https?://[^ )>]+",
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info("opening: " .. url)
        wezterm.open_with(url)
      end),
    }),
  },
  -- Tmux bindings
  { key = "j", mods = "CMD", action = act.SendString("\x01\x2f") },
  { key = "n", mods = "CMD", action = act.SendString("\x01\x3b") },
  { key = "k", mods = "CMD", action = act.SendString("\x01\x53") },
  { key = "S", mods = "CMD|SHIFT", action = act.SendString("\x01\x73") },
  { key = "J", mods = "CMD|SHIFT", action = act.SendString("\x01\x54") },
  { key = "t", mods = "CMD", action = act.SendString("\x01\x63") },
  { key = "Tab", mods = "CTRL", action = act.SendString("\x01\x09") },
  { key = "}", mods = "CTRL|SHIFT", action = act.SendString("\x01\x6e") },
  { key = "{", mods = "CTRL|SHIFT", action = act.SendString("\x01\x4e") },
  { key = "w", mods = "CMD", action = act.SendString("\x01\x78") },
  { key = "x", mods = "CMD", action = act.SendString("\x01\x26") },
  { key = "l", mods = "CMD", action = act.SendString("\x01\x5e") },
  { key = "z", mods = "CMD", action = act.SendString("\x01\x7a") },
  { key = "p", mods = "CMD", action = act.SendString("\x01\x50") },
  -- select window 1-9
  { key = "1", mods = "CMD", action = act.SendString("\x01\x31") },
  { key = "2", mods = "CMD", action = act.SendString("\x01\x32") },
  { key = "3", mods = "CMD", action = act.SendString("\x01\x33") },
  { key = "4", mods = "CMD", action = act.SendString("\x01\x34") },
  { key = "5", mods = "CMD", action = act.SendString("\x01\x35") },
  { key = "6", mods = "CMD", action = act.SendString("\x01\x36") },
  { key = "7", mods = "CMD", action = act.SendString("\x01\x37") },
  { key = "8", mods = "CMD", action = act.SendString("\x01\x38") },
  { key = "9", mods = "CMD", action = act.SendString("\x01\x39") },
}

-- tabKeys
for i = 1, 8 do
  -- CTRL + number to activate that tab
  table.insert(M.keys, {
    key = tostring(i),
    mods = "CTRL",
    action = act.ActivateTab(i - 1),
  })
end

table.insert(M.keys, {
  key = "/",
  mods = "CMD",
  action = wezterm.action_callback(function(window, _)
    -- args = { os.getenv("SHELL"), "-c", "cd $(zoxide query -l | fzf)" },
    -- args = { os.getenv("SHELL"), "-c", os.getenv("HOME") .. "/bin/nvim" },
    local _, pane, _ = window:mux_window():spawn_tab({})
    pane:send_text("zi && clear\n")
  end),
})

table.insert(M.keys, {
  key = "'",
  mods = "CMD",
  action = act.SpawnCommandInNewWindow({}),
})

return M
