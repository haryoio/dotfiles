DOTFILES_DIR := $(HOME)/dotfiles

.PHONY: mac brew lima git nvim rust wezterm starship yabai skhd language

language: rust node deno
mac: brew git yabai skhd

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

yabai:

skhd:


