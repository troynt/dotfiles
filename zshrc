export ZSH=$HOME/.zsh
export EDITOR=vim

export PATH=/usr/local/bin:/usr/local/sbin:$PATH         # Machine
export PATH=/usr/local/share/python:$PATH                # Python
export PATH=/usr/local/Cellar/php/5.3.6/bin:$PATH        # PHP
export PATH=$HOME/.rbenv/bin:$PATH                       # Ruby Gems
export PATH=/usr/local/heroku/bin:$PATH                  # Heroku
export PATH=/usr/local/go/bin:$PATH                      # Go
export PATH=$HOME/Code/bin:$PATH                         # My Go
export PATH=$HOME/Code/work/virb/scripts/tools/bin:$PATH # Virb tools
export PATH=$HOME/.bin:$PATH                             # My tools

export TERM=screen-256color

for file ($ZSH/modules/**/*.zsh) source $file
