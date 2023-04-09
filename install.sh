#!/bin/bash

# 現在のプラットフォームを取得する
platform=$(uname | tr '[:upper:]' '[:lower:]')

case "$platform" in
    #"linux")
    #    ;;
    "darwin")
      echo "darwin"
        ;;
    #"windows")
    #    ;;
    *)
        echo "Unsupported platform: $platform"
        exit 1
        ;;
esac

