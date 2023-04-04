# VIM CONFIGS

## PackageManager

パッケージマネージャにはPackerを使用している.

Packerで使うコマンド
|command|description|
|:-|:-|
|PackerInstall|プラグインをインストール|
|PackerUpdate|追加されたプラグインをインストールし,既存のものは更新する|
|PackerClean|必要なくなったプラグインを削除する|
|PackerSync|PackerCleanのあとにPackerUpdateを行う|
|PackerCompile|設定ファイルをコンパイルする|

基本的には`PackerSync`するだけで良さそう.

## autocomplete

coc.nvim

### [coc.nvim] build/index.js not found, please install dependencies and compile coc.nvim by: yarn install

以下を呼ぶことで解決.
```vim
: call coc#util#install()
```
参考: coc.vimで'[coc.nvim] build/index.js not found, please install dependencies and compile coc.nvim by: yarn install'と言われた, "https://qiita.com/Taichi-yzrh/items/5868e618c82e328c89f6" (参照:2023-02-17)

## mason

まず,Packerでプラグインを読み込む.

```lua
use "williamboman/mason.nvim"
```

次に,masonの設定をする.

```plugins.lua
-- 1. LSP Sever management
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    -- -- Function executed when the LSP server startup
    -- on_attach = function(client, bufnr)
    --   local opts = { noremap=true, silent=true }
    --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
    -- end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })
```

これは,`plugin.lua`でpackerの設定を行ったああとや,`init.lua`に書き込んでも良い.

GitHubリポジトリを見るとmasonでできる設定値が書いてあったので,そちらも参考にするとアイコンなどもカスタマイズできるようだ.

```plugins.lua
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
```
こちらも設定した.


### Masonの使い方

`:Mason`
LSP管理画面が出てくる

参考:"Neovim+LSPをなるべく簡単な設定で構築する" https://zenn.dev/botamotch/articles/21073d78bc68bf (参照:2023-02-17)

## FizzyFinder
telescope.nvim

## Filer
fern.vim

## SyntaxHighlight
treesitter


<Leader> = <Space>

<Leader>e | 現在のフォルダをファイラーで表示.ファイラーが表示済みの場合は非表示
<Leader>f | フォーマットを実行



## Quickfix

Trouble

lspから渡されたエラーなどのクイックフィックスリストをVSCode Likeに表示する.

|default|custom|description
|:-|:-|:-|
|<leader>xx|mm|troubleの表示をトグル|
|<leader>xw|mw|trouble workspace|
|<leader>xd|md|trouble docvument|
|<leader>xq|mq|trouble quickfix|
|<leader>xl|xl|trouble loclist|
|gR|gR|trouble lsp references|
