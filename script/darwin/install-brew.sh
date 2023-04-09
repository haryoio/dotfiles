#!/bin/zsh
#
# dotfiles
#
# すべてのコンフィグファイルはdotfiles/configに格納されている。
# 単体の.ファイルはパッケージ名のディレクトリを作成し、パッケージ名/.file
# ex.
# 対象：.yabairc
# 格納場所：dotfiles/config/yabai/.yabairc


# dotfilesを置くディレクトリ
DOTDIR=$HOME/.local/share/dotfiles
# すべてのコンフィグファイルが入っている。
CONFDIR=$DOTDIR/config

echo "cloning dotfiles"
git clone https://github.com/haryoio/dotfiles.git $DOTDIR
cd $DOTDIR
git checkout dev

#
# brew
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
which brew >/dev/null 2>&1 && brew doctor
which brew >/dev/null 2>&1 && brew update
brew upgrade

brew tap homebrew/cask-fonts

formulas=(
  bat
  exa
  peco
  tldr
  tig

  wezterm
  neovim 
  lazygit
  vifm 
  ghq
  starship
  efm-langserver

  slack
  visual-studio-code
  
  # window manager
  koekeishiya/formulae/skhd
  koekeishiya/formulae/yabai

  # package manager
  sheldon
  asdf
  mas

  font-sauce-code-pro-nerd-font
)

echo "brew tap"
brew tap homebrew/cask-fonts
for formula in "${formulas[@]}"; do 
  brew install $formula || brew upgrade $formula
done

