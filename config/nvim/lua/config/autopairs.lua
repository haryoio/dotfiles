local status, apairs = pcall(require, "nvim-autopairs")
if not status then
	return
end

apairs.setup({
	disable_filetype = { "TelescopePrompt", "vim" },
	check_ts = true,
	ts_config = {
		lua = { "string" }, -- it will not add a pair on that treesitter node
		javascript = { "template_string" },
		java = false, -- don't check treesitter on java
	},
})
apairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
