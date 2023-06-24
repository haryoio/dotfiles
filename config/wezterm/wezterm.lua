local status, wezterm = pcall(require, "wezterm")

if not status then
	return
end

------------------------------------------------
-- KEY BINDINGS
------------------------------------------------
local keys = require("keybind")
require("status")

local function BaseName(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-window-title", function(tab)
	return BaseName(tab.active_pane.foreground_process_name)
end)

-- The filled in variant of the > symbol
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#504945"
	local background = "#3c3836"
	local foreground = "#808080"

	if tab.is_active then
		background = "#1d2021"
		foreground = "#bdae93"
	elseif hover then
		background = "#bdae93"
		foreground = "#909090"
	end

	local edge_foreground = background

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.

	local title = tab.active_pane.title
	local m_width = max_width
	if string.len(title) >= 2 then
		m_width = m_width - 2
	end

	title = wezterm.truncate_right(title, m_width)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
	}
end)

------------------------------------------------
-- KERNING OPTIONS
------------------------------------------------
local kerning_options = {
	"cv01", -- a
	"cv02", -- g
	"ss04", -- $
	"cv12", -- 0
	"cv18", -- %
	"ss03", -- &
	"ss05", -- @
	"ss06", -- \\
	-- "ss02", -- <= >=
	-- "ss09", -- >>= <<= ||= |=
	-- "cv23",
	-- "cv21",
	"cv24", -- !=
}

return {
	use_ime = true,
	font_size = 12.0,
	font = wezterm.font_with_fallback({
		{ family = "SauceCodePro Nerd Font Mono", weight = "Regular" },
	}),
	--合字の設定
	--https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
	harfbuzz_features = kerning_options,
	--color_scheme = "Gruvbox Dark",
	color_scheme = "Gruvbox dark, medium (base16)",
	window_background_opacity = 0.90,
	text_background_opacity = 0.7,
	hide_tab_bar_if_only_one_tab = true,
	-- Enable the scrollbar
	enable_scroll_bar = true,
	use_fancy_tab_bar = true,
	status_update_interval = 1000,
	window_decorations = "RESIZE",
	keys = keys,
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 },
	automatically_reload_config = true,
}
