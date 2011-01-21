# Allow the user to provide some stuff 
# before everything else is loaded
source $HOME/.profile 2&> /dev/null

export ZSH=$HOME/.zsh
export ZSH_THEME="simple"
export EDITOR=vim

source $ZSH/zshrc

bindkey '\e[1~' beginning-of-line #home
bindkey '\e[4~' end-of-line #end
bindkey '\e[3~' delete-char #delete
bindkey '\e[6~' end-of-history #pgdn
bindkey '\e[2~' redisplay #insert
bindkey '\e[5~' insert-last-word #pgup

case $TERM in (xterm*)
  bindkey '\eOH' beginning-of-line
  bindkey '\eOF' end-of-line
esac

alias up="cd .."
alias ~="cd ~"
