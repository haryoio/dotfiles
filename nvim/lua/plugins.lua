vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
  -- 起動時に読み込むプラグインはuseするだけ
  -- use'hoge/vim-hoge'
  use {"ellisonleao/gruvbox.nvim" }
  -- opt オプションを付けると遅延読み込みになる｡
  -- 遅延読み込みを設定している場合､
  -- 'packadd'コマンドを叩かない限り読み込まれることはない｡

end)

