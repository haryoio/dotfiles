local natives = {
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",

	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",

	"matchit",
	"matchparen",
	"logiPat",
	"rrhelper",

	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
}

for plugin, value in pairs(natives) do
	local fullname = "loaded_" .. plugin
	vim.g[fullname] = 1
end
vim.g["loaded_netrw"] = "break"

require("plugins")
require("base")
require("options")
require("theme")
require("keybind")
