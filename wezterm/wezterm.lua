local wezterm = require 'wezterm';

return {
	use_ime = true,
	font_size = 12.0,
	font = wezterm.font_with_fallback {
		{ family='Fira Code', weight='Regular' },
		{ family='Firge35Nerd', weight='Regular' },
	},
	--合字の設定
	--https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
 	harfbuzz_features = {
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
	},

	color_scheme = "Gruvbox Dark",
	window_background_opacity = 0.9,

	-- Enable the scrollbar
  	enable_scroll_bar = true,


	window_decorations = "RESIZE",
}
