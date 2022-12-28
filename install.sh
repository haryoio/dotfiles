#!/bin/bash
function judgement_os() {
  if [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
  elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
    OS='Cygwin'
  else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
}

# OSの種類を判別
judgement_os


## 必須パッケージのインストール
if [$OS == 'Mac']; then
  ./mac/install.sh
elif [$OS == 'Linux']; then
  ./linux/install.sh
elif [$OS == 'MINGW32_NT']; then
  ./windows/install.sh
fi