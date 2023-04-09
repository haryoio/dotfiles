-- Configure ddc
vim.fn['ddc#custom#patch_global']("completionMenu", "pum.vim")
vim.fn['ddc#custom#patch_global']("sources", {
  "around",
  "vim-lsp",
  "file"
})

vim.fn['ddc#custom#patch_global']("sourceOptions", {
  ["_"] = {
    matchers = {"matcher_head"},
    sorters = {"sorter_rank"},
    converters = {"converter_remove_overlap"},
  },
  around = {mark = "Around"},
  ["vim-lsp"] = {
    mark = "LSP",
    matchers = {"matcher_head"},
    forceCompletionPattern = "\\.|:|->|\"\\w+/*"
  },
  file = {
    mark = "file",
    isVolatile = true,
    forceCompletionPattern = "\\S/\\S*"
  }
})

vim.fn["ddc#enable"]()

-- Define keymaps
vim.api.nvim_set_keymap("i", "<Tab>", "<Cmd>call pum#map#insert_relative(+1)<CR>", {})
vim.api.nvim_set_keymap("i", "<S-Tab>", "<Cmd>call pum#map#insert_relative(-1)<CR>", {})
