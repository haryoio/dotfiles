local status, wezterm = pcall(require, "wezterm")
if not status then
	return
end

local action = wezterm.action

local KEYBINDS = {
	{ -- horizontal split
		key = '"',
		mods = "LEADER",
		action = action.SplitHorizontal({
			domain = "CurrentPaneDomain",
		}),
	},
	{ -- vertical split
		key = "%",
		mods = "LEADER",
		action = action.SplitVertical({
			domain = "CurrentPaneDomain",
		}),
	},
	{ -- select pane 1 to 9
		key = "p",
		mods = "LEADER",
		action = action.PaneSelect({
			alphabet = "1234567890",
		}),
	},
	{ -- close pane
		key = "w",
		mods = "LEADER",
		action = action.CloseCurrentPane({ confirm = true }),
	},
	{ -- new tab
		key = "t",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{ -- next tab
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},
	{ -- previous tab
		key = "b",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{ -- close current tab
		key = "q",
		mods = "LEADER",
		action = action.CloseCurrentTab({ confirm = true }),
	},
	{ -- toggle fullscreen
		key = "f",
		mods = "LEADER",
		action = action.ToggleFullScreen,
	},
	{
		key = "h",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Down", 5 }),
	},
	{ key = "k", mods = "LEADER", action = action.AdjustPaneSize({ "Up", 5 }) },
	{
		key = "l",
		mods = "LEADER",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
}

return KEYBINDS
