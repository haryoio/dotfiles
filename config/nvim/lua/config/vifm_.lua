local vifm = require("vifm")

local function open_vifm_in_floaterm()
	local cmd, jobopts, config = vifm.floaterm_wrapper_vifm("vifm", {}, {})
	vim.fn["floaterm#new"](cmd, jobopts, config)
end

vim.api.nvim_command("command! VifmFloaterm lua open_vifm_in_floaterm()")

return {}
