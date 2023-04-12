local opts = { noremap = true, silent = true }

-- <Space>を<Leader>に設定
vim.keymap.set("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>", opts)

vim.keymap.set("n", "<Leader>T", "<cmd>FloatermNew<CR>", opts)
--vim.keymap.set("n", "<Leader>F", "<cmd>FloatermNew vifm .<CR>", opts)
vim.keymap.set("n", "<Leader>F", "<cmd>TabVifm<CR>", opts) -- 新規タブで開く
vim.keymap.set("n", "[b", ":tabnext<CR>", opts)
vim.keymap.set("n", "]b", ":tabprevious<CR>", opts)
vim.keymap.set("n", "<Leader>tc", ":tabclose<CR>", opts)
vim.keymap.set("n", "<Leader>f", function()
	vim.lsp.buf.format()
end, opts)

-- Move focus
vim.keymap.set("n", "<Space>j", "<C-w>w")
vim.keymap.set("n", "<Space>k", "<C-w>W")

-- Pane
-- PWDより新たなPaneを開く
vim.keymap.set("n", "vs", "<cmd>vnew .<CR>")
vim.keymap.set("n", "vn", "<cmd>vnew <CR>")

-- Split
vim.keymap.set("n", "hs", "<cmd>split <CR>")
vim.keymap.set("n", "hn", "<cmd>split . <CR>")

-- TerminalMode
vim.keymap.set("n", "@t", "<CR>:T<CR>")
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:q<CR>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope frecency<CR>")
-- -全文検索 ripgrep使用
vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>")
-- -Packerでインストールされているプラグインを一覧表示
vim.keymap.set("n", "<Leader>f;", "<cmd>Telescope packer<CR>")

vim.keymap.set("n", "cm", "<CMD>CommentToggle<CR>")
vim.keymap.set("v", "cm", "<CMD>'<,'>CommentToggle<CR>")

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

vim.keymap.set("n", "<Leader>lk", on_hover, opts)

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
vim.keymap.set("n", "lg", _lazygit_toggle, opts)
