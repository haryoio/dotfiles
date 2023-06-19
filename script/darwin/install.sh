#!/bin/bash

mkdir $HOME/.local
mkdir $HOME/.local/share
sudo ln -sfnv ~/dotfiles $HOME/.local/share

echo "-----------install brew---------------"
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
which brew >/dev/null 2>&1 && brew doctor
which brew >/dev/null 2>&1 && brew update

echo "-----------upgrade brew packages---------------"
brew upgrade

# asdf がインストールされていなければインストール
if [ ! -x "$(command -v asdf)" ]; then
	echo "-----------install asdf---------------"
    brew install asdf
    echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
fi

echo "-----------install asdf packages---------------"
./asdf-setup.sh

echo "-----------install or update zx---------------"
npm i -g zx

echo "-----------install brew packages---------------"
zx ./brew-setup.mjs

echo "-----------install some config---------------"
zx ./symlink-configfiles.mjs
