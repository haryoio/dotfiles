require("helper").keybind()

local opts = { noremap = true, silent = true }
local silent = { silent = true }
local noremap = { noremap = true }

-- <Space>を<Leader>に設定
map("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "

imap("jj", "<ESC>", opts)

-- ターミナルを開く
nmap("<Leader>t", "<cmd>FloatermNew<CR>", opts)
nmap("[b", ":tabnext<CR>", opts)
nmap("]b", ":tabprevious<CR>", opts)
nmap("<Leader>tc", ":tabclose<CR>", opts)
-- manual formatting
nmap("<Leader>f", ":lua vim.lsp.buf.format()<cr>", opts)

-- Move focus
nmap("<Leader>j", "<C-w>w")
nmap("<Leader>k", "<C-w>W")

-- Pane
nmap("vs", "<cmd>vnew .<CR>")
nmap("vn", "<cmd>vnew <CR>")

-- Split
nmap("hs", "<cmd>split <CR>")
nmap("hn", "<cmd>split . <CR>")

-- TerminalMode
nmap("@t", "<CR>:T<CR>")
tmap("<C-q>", "<C-\\><C-n>:q<CR>")
tmap("<ESC>", "<C-\\><C-n>")

nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
nmap("gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

nmap("<Leader>ff", "<cmd>Telescope frecency<CR>") -- -全文検索 ripgrep使用
nmap("<Leader>fg", "<cmd>Telescope live_grep<CR>") -- -Packerでインストールされているプラグインを一覧表示
nmap("<Leader>f;", "<cmd>Telescope packer<CR>")

--nmap("cm", "<CMD>CommentToggle<CR>")
--vmap("cm", "<CMD>'<,'>CommentToggle<CR>")

-- LSP Mapping
nmap("K", vim.lsp.buf.hover)
nmap("gi", vim.lsp.buf.implementation, noremap)
nmap("gr", vim.lsp.buf.references, noremap)
nmap("gds", vim.lsp.buf.document_symbol, noremap)
nmap("gd", vim.lsp.buf.definition, noremap) -- 使用されている場所にジャンプ
nmap("gws", vim.lsp.buf.workspace_symbol)
nmap("gD", vim.lsp.buf.declaration, opts)
nmap("<C-k>", vim.lsp.buf.signature_help, opts)
nmap("<Leader>D", vim.lsp.buf.type_definition, opts)
nmap("<leader>cl", vim.lsp.codelens.run)
nmap("<Leader>sh", vim.lsp.buf.signature_help)
nmap("<Leader>rn", vim.lsp.buf.rename, opts)
nmap("<Leader>ca", vim.lsp.buf.code_action)
nmap("<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
nmap("<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
nmap("<Leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workLeader_folders()))
end, opts)
nmap("<Leader>f", function()
	vim.lsp.buf.format({ async = true })
end, opts)

nmap("<Leader>ws", function()
	require("metals").hover_worksheet()
end)
nmap("<Leader>aa", vim.diagnostic.setqflist)

nmap("<leader>ae", function()
	vim.diagnostic.setqflist({ severity = "E" })
end)

-- all workspace warnings
nmap("<leader>aw", function()
	vim.diagnostic.setqflist({ severity = "W" })
end)

-- buffer diagnostics only
nmap("<leader>d", vim.diagnostic.setloclist)

nmap("[c", function()
	vim.diagnostic.goto_prev({ wrap = false })
end)

nmap("]c", function()
	vim.diagnostic.goto_next({ wrap = false })
end)

local function on_cursor_hold()
	if vim.lsp.buf.server_ready() then
		vim.diagnostic.open_float()
	end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"

local function enable_diagnostics_hover()
	vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
	vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
end

local function disable_diagnostics_hover()
	vim.api.nvim_clear_autocmds({ group = diagnostic_hover_augroup_name })
end

vim.api.nvim_set_option("updatetime", 500)
enable_diagnostics_hover()

local function on_hover()
	disable_diagnostics_hover()

	vim.lsp.buf.hover()

	vim.api.nvim_create_augroup("lspconfig-enable-diagnostics-hover", { clear = true })
	-- ウィンドウの切り替えなどのイベントが絡んでくるとおかしくなるかもしれない
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = "lspconfig-enable-diagnostics-hover",
		callback = function()
			vim.api.nvim_clear_autocmds({ group = "lspconfig-enable-diagnostics-hover" })
			enable_diagnostics_hover()
		end,
	})
end

nmap("<Leader>lk", on_hover, opts)

----- LazyGit
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	hidden = true,
})

local function _lazygit_toggle()
	lazygit:toggle()
end
nmap("lg", _lazygit_toggle, opts)
