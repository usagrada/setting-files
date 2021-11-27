#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export CLICOLOR=1
export TERM=xterm-256color
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -s "$HOME/customize/enhancd/init.sh" ]]; then
  source "$HOME/customize/enhancd/init.sh"
fi
# Customize to your needs...
autoload -Uz promptinit
promptinit

function peco-history-selection() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"

# golang
export GOENV_DISABLE_GOPATH=1
export GOPATH="$HOME/go"
export PATH=$GOPATH/bin:$PATH

# flutter
export PATH="$HOME/development/flutter/bin:$PATH"
# export BROWSER="firefox developer edition"

# c++
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# export PATH="/opt/homebrew/bin:$PATH"
# alias brew="PATH=/opt/homebrew/bin:/opt/homebrew/sbin brew"

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# alias
alias vi=nvim
alias vim=nvim
alias insider='code-insiders'
if [[ $(command -v exa) ]]; then
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
  alias ea='exa -a --icons --git'
  alias la=ea
  alias ee='exa -aahl --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi
# eval
eval "$(anyenv init -)"
eval $(opam env)
eval "$(starship init zsh)"
