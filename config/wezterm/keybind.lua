local status, wezterm = pcall(require, "wezterm")
if not status then
	return
end

local action = wezterm.action

local KEYBINDS = {
	{
		-- horizontal split
		key = 'h',
		mods = "LEADER",
		action = action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		-- vertical split
		key = "v",
		mods = "LEADER",
		action = action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{
		-- select pane 1 to 9
		key = "p",
		mods = "LEADER",
		action = action.PaneSelect({
			alphabet = "1234567890",
		}),
	},
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = action.ActivatePaneDirection 'Down',
  },
	{
		-- close pane
		key = "w",
		mods = "LEADER",
		action = action.CloseCurrentPane(),
	},
	{
		-- new tab
		key = "t",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		-- next tab
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},
	{
		-- previous tab
		key = "b",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{
		-- close current tab
		key = "q",
		mods = "LEADER",
		action = action.CloseCurrentTab({ confirm = true }),
	},
	{
		-- toggle fullscreen
		key = "f",
		mods = "LEADER",
		action = action.ToggleFullScreen,
	},
	{
		key = "l",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "d",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "u", mods = "LEADER", action = action.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "r",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
}

return KEYBINDS
