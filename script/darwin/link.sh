#!/bin/zsh

DOTDIR=$HOME/.local/share/dotfiles
CONFDIR=$DOTDIR/config

#zsh
ln -sf $CONFDIR/zsh/.zshrc $HOME
#sheldon
ln -sf $CONFDIR/sheldon $HOME/.config
#gitconfig
ln -sf $CONFDIR/git/.gitconfig $HOME
#nvim
ln -sf $CONFDIR/nvim $HOME/.config
#wezterm
ln -sf $CNOFDIR/wezterm $HOME/.config
#vifm
ln -sf $CONFDIR/vifm $HOME/.config
#yabai
ln -sf $CONFDIR/yabai/.yabairc $HOME
#skhd
ln -sf $CONFDIR/skhd/.skhdrc $HOME
#starship
ln -sf $CONFDIR/starship/starship.toml $HOME/.config
#wezterm
ln -sf $CONFDIR/wezterm $HOME/.config

