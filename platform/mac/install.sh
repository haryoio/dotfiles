#!/bin/bash

xcode-select --install


#------ brew ---------

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
packages=(
"cask"
"ca-certificates"
"docker"
"lima"
"docker-compose"
"git"
"neovim"
"ghq"
"zsh-completions"
"zsh-autosuggestions"
"zsh-syntax-highlighting"
"peco"
)

for package in "${packages[@]}" ; do
  brew install $package
done


#------ LIMA ---------

limactl start
echo "LIMA_INSTANCE=docker lima" >> ~/.zshrc

ln -sfnv ../../lima/docker.yaml ~/.lima/_config/
echo "\n" | limactl start ~/.lima/_config/docker.yaml
docker context create lima --docker "host=unix:///Users/user/.lima/docker/sock/docker.sock"
docker context use lima
docker run hello-world

#------ git ---------

mkdir ~/dev
git config --global ghq.root '~/dev'

#------ nvim ---------

echo "alias vim=nvim" >> ~/.zshrc
rm -rf ~/.config/nvim
mkdir ~/.config/nvim
ln -sfnv ../../nvim ~/.config

#------ Rust ---------

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

#------ WezTerm ---------

brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm

rm -rf ~/.config/wezterm
ln -sfnv ../../wezterm ~/.config

#------ Starship ---------

curl -sS https://starship.rs/install.sh | sh -s -- -y
ln -sfnv ../../starship.toml ~/.config
