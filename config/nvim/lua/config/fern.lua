-- FileIconなどでNerdFontを使用する
vim.g["fern#renderer"] = "nerdfont"
-- 隠しファイルを表示
vim.g["fern#default_hidden"] = 1

local init_fern = function()
	vim.opt.number = false
end

local fern_id = vim.api.nvim_create_augroup("fern-custom", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "fern",
	group = fern_id,
	callback = init_fern,
})
