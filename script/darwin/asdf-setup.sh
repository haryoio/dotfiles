
function configure_dot_asdf {
    ASDF_PATH="$HOME/.asdfrc"

    # Check if the .asdf directory exists
    if [ ! -d "$ASDF_PATH" ]; then
        echo "Creating the $ASDF_DIR directory"
        touch $ASDF_PATH
    fi

    if ! grep -qxF 'java_macos_integration_enable = yes' ~/.asdfrc ; then
        echo 'java_macos_integration_enable = yes' >> ~/.asdfrc
    fi
}

# awscli
asdf plugin add awscli
asdf install awscli laest:2
asdf global awscli latest

# deno
asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
asdf install deno latest
asdf global deno latest

# jq
asdf plugin add jq https://github.com/AZMCode/asdf-jq.git
asdf install jq latest
asdf global jq latest

# flutter
asdf plugin add flutter
asdf install flutter latest
asdf global flutter latest

# nodejs
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

corepack enable
asdf reshim nodejs

# java
asdf plugin add java https://github.com/halcyon/asdf-java.git
asdf install java corretto-11.0.17.8.1
asdf global java corretto-11.0.17.8.1

# sbt
asdf plugin add sbt
asdf install sbt 1.8.2
asdf global sbt 1.8.2

# python
asdf plugin add python
asdf install python 3.9.1
asdf global python 3.9.1

