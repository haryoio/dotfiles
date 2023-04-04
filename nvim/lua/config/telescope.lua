local function find_files()
	print("findfiiles")
	return require("telescope.builtin").find_files
end

return function()
	vim.keymap.set("n", "<Leader>fv", find_files(), { noremap = true, silent = true })
	-- 省略
end
