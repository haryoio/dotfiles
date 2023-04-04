-- indent-blankline.nvim
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- インデントを見やすくするプラグイン
-- 現在のブロックに色をつけたりもできる.
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]

require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
})

vim.o.list = true
vim.opt.listchars:append("tab:>--")
vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")
