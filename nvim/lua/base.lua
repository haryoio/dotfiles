-- ./configのモジュール群を読み込む
--require("config")
-- モード表記を英語にするため,VIM内でのみ英語へ
vim.cmd([[let $LANG='en_US.UTF-8']])
vim.cmd("set runtimepath+=~/.config/nvim/lua/config/")
