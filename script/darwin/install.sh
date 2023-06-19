#!/bin/bash

# ------------ Variables ------------
ZSHRC_PATH="${ZDOTDIR:-~}/.zshrc"
BREW_PREFIX=$(brew --prefix asdf)

# ------------ Functions ------------
print_section() {
    echo "----------- $1 ---------------"
}

create_dirs() {
    mkdir -p $HOME/.local/share
    sudo ln -sfnv ~/dotfiles $HOME/.local/share
}

install_brew() {
    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        brew doctor
        brew update
    fi
}

upgrade_brew() {
    brew upgrade
}

install_asdf() {
    if ! command -v asdf &>/dev/null; then
        brew install asdf
        echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZSHRC_PATH}
    fi
}

install_asdf_packages() {
    ./asdf-setup.sh
}

install_zx() {
    npm i -g zx
}

install_brew_packages() {
    zx ./brew-setup.mjs
}

install_configs() {
    zx ./symlink-configfiles.mjs
}

# ------------ Main ------------
print_section "Create directories"
create_dirs

print_section "Install brew"
install_brew

print_section "Upgrade brew packages"
upgrade_brew

print_section "Install asdf"
install_asdf

print_section "Install asdf packages"
install_asdf_packages

print_section "Install or update zx"
install_zx

print_section "Install brew packages"
install_brew_packages

print_section "Install some config"
install_configs
