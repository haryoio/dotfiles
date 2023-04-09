-- Tree-sitter
require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
		disable = {},
	},
	indent = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			node_decremental = "grm",
		},
	},
	ensure_installed = {
		"bash",
		"c",
		"clojure",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"jsonc",
		"lua",
		"make",
		"nix",
		"ocaml",
		"ocaml_interface",
		"prisma",
		"rust",
		"scheme",
		"toml",
		"typescript",
		"vue",
		"yaml",
		"vim",
	},
})

require("nvim-ts-autotag").setup({})
--vim.wo.foldmethod = "expr"
--vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
