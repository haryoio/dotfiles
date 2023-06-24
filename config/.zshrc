export PATH=$PATH
export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' ignore-parents parent pwd .. # ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin # sudo の後ろでコマンド名を補完する
zstyle ':completion:*:processes' command 'ps x -o pid,s,args' # ps コマンドのプロセス名補完
setopt print_eight_bit  # 日本語ファイル名を表示可能にする
setopt no_beep # beep を無効にする
setopt no_flow_control # フローコントロールを無効にする
setopt ignore_eof  # Ctrl+Dでzshを終了しない
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt auto_cd # ディレクトリ名だけでcdする
setopt share_history # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_ignore_space # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks # ヒストリに保存するときに余分なスペースを削除する

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
alias ghcd='cd $(ghq list -p | peco)'
alias vim=nvim
alias vi=nvim
alias rust=evcxr
alias tf='terraform'
alias tfmt='terraform fmt -recursive'

alias ll="ls -alF"
alias la="ls -a"
alias l="ls -CF"

alias rm="trash"
export DOTDIR="$HOME/.local/share/dotfiles"

eval "$(starship init zsh)"
eval "$(sheldon source)"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
. ~/.asdf/plugins/java/set-java-home.zsh

export PATH=$PATH:"/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
export PATH=$PATH:"/Applications/IntelliJ IDEA.app/Contents/MacOS"
export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"

export PATH="$HOME/.cargo/bin:$PATH"
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
# serverpod
export PATH="$PATH":"$HOME/.pub-cache/bin"

export STARSHIP_CONFIG=~/.config/starship/starship.toml



# プライベートなスクリプト
private_file="$HOME/.priv.zsh"

if [[ -f "$private_file" ]]; then
    source "$private_file"
fi
