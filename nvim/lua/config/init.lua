local modules = {
	"cmp",
	"mason",
	"lspconfig",
	"treesitter",
	"formatter",
	"fern",
	"indent_blankline",
	"rust-tools",
	"autopairs",
	"lualine",
	"telescope",
	--	"copilot",
	"alpha",
	-- "tabs",
	"barbar",
	"trouble",
}

for mod in pairs(modules) do
	local mod_name = "config." .. modules[mod]
	local status, loaded = pcall(require, mod_name)
	if not status then
		--	print(mod_name .. " is not loaded")
	end
end

