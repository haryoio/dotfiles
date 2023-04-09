local function import(module)
	local status, mod = pcall(require, module)
	if not status then
		return function() end
	end
	return mod
end

local trouble = import("trouble")
local opts = { noremap = true, silent = true }

trouble.setup({})

vim.keymap.set("n", "mm", "<cmd>TroubleToggle<cr>", opts)
vim.keymap.set("n", "mw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
vim.keymap.set("n", "md", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.keymap.set("n", "ml", "<cmd>TroubleToggle loclist<cr>", opts)
vim.keymap.set("n", "mq", "<cmd>TroubleToggle quickfix<cr>", opts)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)

local trouble_tele = import("trouble.providers.telescope")
local telescope = import("telescope")

telescope.setup({
	defaults = {
		mappings = {
			i = { ["<C-t>"] = trouble_tele.open_with_trouble },
			n = { ["<C-t>"] = trouble_tele.open_with_trouble },
		},
	},
})
