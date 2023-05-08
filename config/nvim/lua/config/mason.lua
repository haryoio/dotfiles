local on_attach = function(client, bufnr)
	--client.server_capabilities.semanticTokensProvider = nil

	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 5000 })
			end,
			group = augroup,
			buffer = bufnr,
		})
	end
end

local disable_fmt_on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	on_attach(client, bufnr)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

local lspconfig = require("lspconfig")
local function get_server_opts(server_name)
	-- https://zenn.dev/kawarimidoll/articles/2b57745045b225

	local node_root_dir = lspconfig.util.root_pattern("package.json")
	local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

	local opts = {}

	if server == "denols" then
		if is_node_repo then
			return
		end
		opts.cmd = { "deno", "lsp", "--unstable" }
		opts.root_dir =
			lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json", "imports.json")
		opts.init_options = {
			lint = true,
			unstable = true,
		}
	elseif server_name == "tsserver" then
		if not is_node_repo then
			return
		end
		opts.root_dir = node_root_dir
		opts.on_attach = disable_fmt_on_attach
	elseif server_name == "jsonls" then
		opts.on_attach = disable_fmt_on_attach
	end

	return opts
end

vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "gx", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
vim.keymap.set("n", "g[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "g]", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")

require("mason").setup()
require("mason-lspconfig").setup({
	config = {
		ensure_installed = {
			"denols",
			"tsserver",
			"rust_analyzer",
			"jsonls",
			"cssls",
			"lua_ls",
			"eslint",
		},
	},
})
require("mason-lspconfig").setup_handlers({
	function(server_name)
		local opts = get_server_opts(server_name)
		if opts then
			lspconfig[server_name].setup(opts)
		end
	end,
})

-- mason auto configurate
local mason_package = require("mason-core.package")
local mason_registry = require("mason-registry")
local null_ls = require("null-ls")

local null_sources = {}

for _, package in ipairs(mason_registry.get_installed_packages()) do
	local package_categories = package.spec.categories[1]
	if package_categories == mason_package.Cat.Formatter then
		table.insert(null_sources, null_ls.builtins.formatting[package.name])
	end
	if package_categories == mason_package.Cat.Linter then
		table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
	end
end
null_ls.setup({
	sources = null_sources,
	diagnostics_format = "#{m} (#{s}: #{c})",
	on_attach = on_attach,
})
