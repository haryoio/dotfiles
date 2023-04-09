require("helper")
local ls = import("luasnip")
local ls_loaders  = import("luasnip/loader/from_vscode")

if ls == nil then return end
ls.config.setup({
    ext_opts = {
        ["frendly-snippets"] = {
            snippet_folter = "snippets"
        }
    }
})

if ls_loaders == nil then return end
ls_loaders.load({
    path = {
        "frendly-snippets",
        vim.fn.stdpath("config") .. "/snippets"
    }
})
