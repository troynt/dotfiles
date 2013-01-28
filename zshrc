export ZSH=$HOME/.zsh
export PATH=$HOME/.bin:$HOME/Code/bin:$HOME/.rbenv/bin:$HOME/Code/work/virb/scripts/tools/bin:/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/opt/vagrant/bin:/usr/local/Cellar/php/5.3.6/bin:/usr/local/share/python:$PATH
export GOPATH=~/Code:/usr/local/go
export EDITOR=vim

export TERM=screen-256color

for file ($ZSH/modules/**/*.zsh) source $file

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
