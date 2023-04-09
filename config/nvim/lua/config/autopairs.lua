local status, apairs = pcall(require, "nvim-autopairs")
if not status then
	return
end
apairs.setup({})
