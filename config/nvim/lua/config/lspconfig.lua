-- -- symbols-outline.nvim
vim.g.symbols_outline = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = true, -- experimental
	position = "right",
	keymaps = {
		close = "<Esc>",
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		rename_symbol = "r",
		code_actions = "a",
	},
	lsp_blacklist = {},
}

---
-- Diagnostics
---
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
	})
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	underline = true,
	signs = true,
	update_in_insert = true,
	border = true,
	float = {
		border = "rounded",
	},
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

require("lspsaga").setup({
	code_action = {
		num_shortcut = true,
		show_server_name = true,
		extend_gitsigns = true,
		keys = {
			quit = "q",
			exec = "<CR>",
		},
	},
})

require("dressing").setup({})
require("lsp_signature").setup({})
require("lspkind").init({
	mode = "symbol_text",
	preset = "codicons",
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})

-- https://xbgneb0083.hatenablog.com/entry/2022_6_12_avoid_conflict_lsp_hover
local function on_cursor_hold()
	if vim.lsp.buf.server_ready() then
		vim.diagnostic.open_float()
	end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"
vim.api.nvim_set_option("updatetime", 500)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
