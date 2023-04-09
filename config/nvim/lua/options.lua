local options = {
  -- encoding
  encoding = "utf-8",
  fileencoding = "utf-8",
  termencoding = "utf-8",
  -- Shell
  shell = "zsh",
  -- Font
  guifont = "FiraCode:h17",
  -- -マウス有効化
  mouse = "a",
  title = true,
  -- -行番号表示
  number = true,
  compatible = false,
  -- -行番号の幅
  numberwidth = 2,
  -- -行番号を相対番号
  relativenumber = false,
  hidden = true,
  ruler = true,
  -- -文字がウィンドウ幅を超えると折り返される
  wrap = true,
  -- -折返しが設定された文字数から始まる
  wrapmargin = 0,
  -- -検索がファイル末尾まで進んだら先頭から再度検索
  wrapscan = false,
  -- UI
  clipboard = "unnamedplus",
  cmdheight = 1,
  hlsearch = true,
  showtabline = 2,
  cursorline = true,
  -- modeを表示するか否か
  showmode = false,
  colorcolumn = "79",
  ambiwidth = "single",
  -- tab
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  expandtab = true,
  -- Bell
  visualbell = true,
  errorbells = false,
  -- Backup
  backup = false,
  writebackup = false,
  backupskip = { "/tmp/*", "/private/tmp/*" },
  undofile = true,
  undodir = { "/tmp" },
  backupdir = { "./.backup", "~/.backup", ".", "/tmp" },
  history = 500,
  swapfile = false,
  completeopt = { "menuone", "noselect" },
  -- -conceal構文属性テキストの表示方法
  conceallevel = 0,
  -- -ダイアログを開いてファイルを保存するかどうかを尋ねる.
  -- -意図的に廃棄したいなら!を伝える.
  confirm = true,
  -- -補間ポップアップメニューで使用する項目の最大数
  pumheight = 10,
  -- -補間ポップアップメニューで使用する幅の最小値
  pumwidth = 15,
  ignorecase = true,
  smartcase = true,
  smartindent = true,
  smarttab = true,
  termguicolors = true,
  timeoutlen = 300,
  updatetime = 300,
  signcolumn = "yes",
  winblend = 0,
  wildoptions = "pum",
  pumblend = 5,
  scrolloff = 8,
  sidescrolloff = 8,
  splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
  splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
  nrformats = "bin,hex",
}

vim.scriptenconfig = "utf-8"
vim.opt.shortmess:append("c")

vim.g.editorconfig = true;

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[set whichwrap+=<,>,[,],h,l]])
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])

-- terminalをVSCのように下に開く
vim.cmd("autocmd!")
vim.cmd([[
    command! -nargs=* T split | wincmd j | resize 10 | terminal <args>
]])


-- terminalモードを常に挿入モードで開く
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  command = "startinsert",
})
