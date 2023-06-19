#!/usr/bin/env zx

const { execSync } = require("child_process");
const { readdirSync, statSync } = require("fs");
const path = require("path");

const dotfilesDir = path.join(
  process.env.HOME,
  ".local",
  "share",
  "dotfiles",
  "config"
);

function isDirectory(path) {
  try {
    return statSync(path).isDirectory();
  } catch (error) {
    console.error(error);
    return false;
  }
}

function linkingConfigFiles() {
  const configFileList = readdirSync(dotfilesDir);
  for (const pkg of configFileList) {
    try {
      const path = `${dotfilesDir}/${pkg}`;
      if (isDirectory(path)) {
        console.log(`${path} -> $HOME/.config`);
        // s シンボリックリンクを作成
        // b 指定したリンクファイルがある場合,ファイルのバックアップを作成
        // f リンク先に同名のリンクファイルがあるときも警告なく上書き
        execSync(`sudo ln -sfnv ${path} $HOME/.config`);
      } else {
        console.log(`${path} -> $HOME`);
        execSync(`sudo ln -sfnv ${path} $HOME`);
      }
    } catch (e) {
      console.error(e);
    }
  }
}

linkingConfigFiles();
