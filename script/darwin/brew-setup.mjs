#!/usr/bin/env zx
const { execSync } = require("child_process");
const { readdirSync, statSync } = require("fs");
const path = require("path");

const formulas = [
  "trash",
  "bat",
  "exa",
  "starship",
  "peco",
  "ripgrep",
  "tldr",
  "delta",
  "tig",
  "lazygit",
  "wezterm",
  "neovim",
  "efm-langserver",
  "vifm",
  "gh",
  "ghq",
  "slack",
  "visual-studio-code",
  "koekeishiya/formulae/skhd",
  "koekeishiya/formulae/yabai",
  "sheldon",
  "asdf",
  "mas",
  "font-sauce-code-pro-nerd-font",
];

const dotfilesDir = path.join(
  process.env.HOME,
  ".local",
  "share",
  "dotfiles",
  "config"
);

const dotconfigDir = path.join(process.env.HOME, ".config");

await $`brew tap homebrew/cask-fonts`;

function installBrewPackages() {
  for (const pkg of formulas) {
    try {
      execSync(`brew install ${pkg}`);
    } catch (error) {
      console.log(
        `${pkg}のインストールに失敗しました。アップデートを試みます。`
      );
      continue;
    }
  }
}

installBrewPackages();
