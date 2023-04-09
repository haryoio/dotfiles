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
local bufmap = function(mode, lhs, rhs)
    local opts = { buffer = true }
    vim.keymap.set(mode, lhs, rhs, opts)
end
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function()
        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
        bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
        bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
        bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
        bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
        bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
        bufmap("n", "<Leader>re", "<cmd>lua vim.lsp.buf.rename()<cr>")
        bufmap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
        bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
        bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
        bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
        bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
    end,
})

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
--
-- vim.diagnostic.config({
-- 	virtual_text = true,
-- 	signs = true,
-- 	update_in_insert = true,
-- 	underline = false,
-- 	severity_sort = false,
-- 	float = {
-- 		border = "rounded",
-- 	},
-- })

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

local completion_callback = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gd",
        "<cmd>lua vim.lsp.buf.definition()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "gi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        { noremap = true, silent = true }
    )
    --require("completion").on_attach(client)
end
local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup({ on_attach = completion_callback })

local status, saga = pcall(require, "lspsaga")
if not status then
    return
end

saga.setup({
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
vim.api.nvim_set_option('updatetime', 500)
vim.api.nvim_create_augroup(diagnostic_hover_augroup_name, { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold" }, { group = diagnostic_hover_augroup_name, callback = on_cursor_hold })
