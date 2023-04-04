-- ref: https://homaju.hatenablog.com/entry/2022/06/12/092136
-- ref: https://zenn.dev/takuya/articles/4472285edbc132

local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local _theme = "gruvbox-material"

lualine.setup({
	options = {
		icons_enabled = true,
		theme = _theme,
		disabled_filetype = {},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			"filename",
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			"encoding",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			"filename",
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},

	tabline = {},
	extensions = {},
})
