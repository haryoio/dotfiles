#!/bin/bash

ASDF_PATH="$HOME/.asdfrc"
ZSHRC_PATH="${ZDOTDIR:-~}/.zshrc"

# .asdfrc ファイルをセットアップする関数
configure_dot_asdf() {
    # .asdfrc ファイルが存在するか確認
    if [ ! -f "$ASDF_PATH" ]; then
        echo "$ASDF_PATH ファイルを作成します"
        touch $ASDF_PATH
    fi

    # java_macos_integration_enable が設定されているか確認
    if ! grep -qxF 'java_macos_integration_enable = yes' $ASDF_PATH ; then
        echo 'java_macos_integration_enable = yes' >> $ASDF_PATH
    fi
}

# asdfのプラグインをインストールするユーティリティ関数
install_asdf_plugin() {
    local plugin_name=$1
    local plugin_url=$2
    local version=$3

    asdf plugin add $plugin_name $plugin_url
    asdf install $plugin_name $version
    asdf global $plugin_name $version
}

# .asdfrc を設定する
configure_dot_asdf

# awscli
install_asdf_plugin "awscli" "" "latest:2"

# deno
install_asdf_plugin "deno" "https://github.com/asdf-community/asdf-deno.git" "latest"

# jq
install_asdf_plugin "jq" "https://github.com/AZMCode/asdf-jq.git" "latest"

# flutter
install_asdf_plugin "flutter" "" "latest"

# nodejs
install_asdf_plugin "nodejs" "" "latest"

# asdf のパスを .zshrc に追加
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> $ZSHRC_PATH
source $ZSHRC_PATH

corepack enable
asdf reshim nodejs

# java
install_asdf_plugin "java" "https://github.com/halcyon/asdf-java.git" "corretto-11.0.17.8.1"

# sbt
install_asdf_plugin "sbt" "" "1.8.2"

# kotlin
install_asdf_plugin "kotlin" "" "latest"

# python
install_asdf_plugin "python" "" "3.9.1"
