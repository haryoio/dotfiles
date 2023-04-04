#!/bin/bash

. ./utils/judgement_os
judgement_os

DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/haryoio/dotconfig.git $(DOTFILES_DIR)
fi

cd $(DOTFILES_DIR)
## 必須パッケージのインストール
if [$OS == 'Mac']; then
  make mac
elif [$OS == 'Linux']; then
elif [$OS == 'MINGW32_NT']; then
fi



