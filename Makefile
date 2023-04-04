DOTFILES_DIR := $(HOME)/dotfiles

.PHONY: mac wm brew lima git nvim rust wezterm starship language zsh 

language: rust node deno
mac: zsh brew git wm starship wezterm language

zsh:
	ln -sfnv ./.zshrc ~/.zshrc

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

lima:
	limactl start
	echo "LIMA_INSTANCE=docker lima" >> ~/.zshrc
	ln -sfnv ./lima/docker.yaml ~.lima/_config/
	echo "\n" | limactl start ~/.lima/_config/docker.yaml
	docker context create lima --docker "host=unix:///Users/user/.lima/docker/sock/docker.sock"
	docker context use lima

git:
	mkdir ~/dev
	git config --global ghq.root "~/dev"

nvim:
	echo "alias vim=nvim" >> ~/.zshrc
	rm -rf ~/.config/nvim
	mkdir ~/.config/nvim
	ln -sfnv ./nvim

rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

deno:

wezterm:
	brew tap wez/wezterm
	brew install --cask wez/wezterm/wezterm
	rm -rf ~/.config/wezterm
	ln -sfnv ./wezterm ~/.config

starship:
	curl -sS https://starship.rs/install.sh | sh -s -- -y
	ln -sfnv ./starship.toml ~/.config

wm:
	brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd
	brew services start skhd
	brew services start yabai
	ln -sfnv ./.yabairc ~/.yabairc
	ln -sfnv ./.skhdrc ~/.skhdrc

