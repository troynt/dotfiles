export ZSH=$HOME/.zsh
export PATH=$HOME/.bin:$HOME/Code/bin:$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/php/5.3.6/bin:/usr/local/share/python:$PATH
export GOPATH=~/Code:/usr/local/go
export EDITOR=vim

eval "$(rbenv init -)"

if [ -f $HOME/.sshkeys ]; then
    (ssh-add -l 2>&1) > /dev/null

    if [ $? = "1" ]; then
        cat $HOME/.sshkeys | xargs ssh-add 2> /dev/null
    fi
fi

for file ($ZSH/lib/**/*.zsh) source $file
for file ($ZSH/plugins/**/*.zsh) source $file

export TERM=screen-256color
