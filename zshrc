ZSH=$HOME/.zsh
EDITOR=vim

PATH=/usr/local/bin:/usr/local/sbin:$PATH         # Machine
PATH=/usr/local/share/python:$PATH                # Python
PATH=/usr/local/Cellar/php/5.3.6/bin:$PATH        # PHP
PATH=$HOME/.rbenv/bin:$PATH                       # Ruby Gems
PATH=/opt/vagrant/bin:$PATH                       # Vagrant
PATH=/usr/local/heroku/bin:$PATH                  # Heroku
PATH=/usr/local/go/bin:$PATH                      # Go
PATH=$HOME/Code/bin:$PATH                         # My Go
PATH=$HOME/Code/work/virb/scripts/tools/bin:$PATH # Virb tools
PATH=$HOME/.bin:$PATH                             # My tools

TERM=screen-256color

for file ($ZSH/modules/**/*.zsh) source $file
