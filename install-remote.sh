#!/bin/bash

# 現在のプラットフォームを取得する
platform=$(uname | tr '[:upper:]' '[:lower:]')

case "$platform" in
    #"linux")
    #    ;;
    "darwin")
    	git clone https://github.com/haryoio/dotfiles.git
		ln -s "$(pwd)/dotfiles" "$HOME/.local/share/dotfiles"
		cd ./dotfiles/script/darwin
		chmod +x ./install.sh
		./install.sh
	;;
    #"windows")
    #    ;;
    *)
        echo "Unsupported platform: $platform"
        exit 1
        ;;
esac

