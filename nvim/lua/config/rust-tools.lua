local rt = require("rust-tools")

local opts = {
	inlay_hints = {
		auto = true,
	},
	server = {
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
			vim.keymap.set("n", "<Leader>.", rt.hover_actions.hover_actions, { buffer = bufnr })
			vim.keymap.set("n", "<Leader>o", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
		end,
	},
}
rt.setup(opts)
