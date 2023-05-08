#!/usr/bin/env zx
const { execSync } = require("child_process");
const { readdirSync, statSync } = require("fs");
const path = require("path");

const formulas = [
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

function isDirectory(path) {
  try {
    return statSync(path).isDirectory();
  } catch (error) {
    return false;
  }
}

function linkingConfigFiles() {
  const configFiles = readdirSync(dotfilesDir);
  for (const pkg of configFiles) {
    const path = `${dotfilesDir}/${pkg}`;
    if (isDirectory(path)) {
      console.log(`${path} -> ${dotconfigDir}`);
      execSync(`ln -sf ${path} ${dotconfigDir}`);
    } else {
      console.log(`${path} -> $HOME`);
      execSync(`ln -sf ${path} $HOME`);
    }
  }
}

installBrewPackages();
linkingConfigFiles();
