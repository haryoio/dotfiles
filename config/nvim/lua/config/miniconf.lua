require("helper")
----------------
-- status line
----------------
local MiniStatusline = import("mini.statusline")
if MiniStatusline == nil then
	return
end

local function diagnostics_table(args)
	local info = vim.b.coc_diagnostic_info
	if MiniStatusline.is_truncated(args.trunc_width) or info == nil then
		return {}
	end
	local table = {}
	table.e = (info["error"] or 0) > 0 and "E" .. info["error"] or ""
	table.w = (info["warning"] or 0) > 0 and "W" .. info["warning"] or ""
	table.h = (info["hint"] or 0) > 0 and "H" .. info["hint"] or ""
	table.i = (info["information"] or 0) > 0 and "I" .. info["information"] or ""
	table.s = vim.g.coc_status
	return table
end

local function status_config()
	local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 999 })
	local git = MiniStatusline.section_git({ trunc_width = 75 })
	local diagnostics = diagnostics_table({ trunc_width = 75 })
	local filename = MiniStatusline.section_filename({ trunc_width = 140 })
	local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
	local location = MiniStatusline.section_location({ trunc_width = 999 })
	return MiniStatusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics["s"] } },
		{ hl = "MiniStatuslineError", strings = { diagnostics["e"] } },
		{ hl = "MiniStatuslineWarning", strings = { diagnostics["w"] } },
		{ hl = "MiniStatuslineInfo", strings = { diagnostics["i"] } },
		{ hl = "MiniStatuslineHint", strings = { diagnostics["h"] } },
		"%<",
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=",
		{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
		{ hl = mode_hl, strings = { location } },
	})
end

require("mini.statusline").setup({
	content = {
		active = status_config,
	},
})

----------------
-- autopairs
----------------

require("mini.pairs").setup({})
require("mini.tabline").setup({})
require("mini.test").setup({})
require("mini.trailspace").setup({})
require("mini.indentscope").setup({})
require("mini.comment").setup({})

local mini_statusline_colors = {
	MiniStatuslineModeNormal = { bg = "#ebdbb2", fg = "#1d2021" },
	MiniStatuslineModeInsert = { bg = "#d79921", fg = "#1d2021" },
	MiniStatuslineModeVisual = { bg = "#d65d0e", fg = "#1d2021" },
	MiniStatuslineModeReplace = { bg = "#d65d0e", fg = "#1d2021" },
	MiniStatuslineModeCommand = { bg = "#689d6a", fg = "#1d2021" },
	MiniStatuslineModeOther = { bg = "#1d2021", fg = "#665c54" },
	MiniStatuslineDevinfo = { bg = "#282828", fg = "#928374" },
	MiniStatuslineFileinfo = { bg = "#282828", fg = "#928374" },
	MiniStatuslineInactive = { link = "StatusLineNC" },
}

for group, conf in pairs(mini_statusline_colors) do
	vim.api.nvim_set_hl(0, group, conf)
end
