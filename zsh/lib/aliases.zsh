alias ..='cd ..'
alias ...='cd ../..'
alias l='ls -lah'
alias la='ls -AF'
alias ll='ls -lFh'
alias ld='ls -ld *(/)'

alias rmswp='find . -name "*.swp" -type f | xargs rm -f'

alias gst='git status'
alias gl='git log'
alias gf='git fetch'
alias gb='git branch'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit -am'
alias gcam='git commit --amend'
alias gri='git rebase --interactive'
alias gdc='git svn dcommit'

alias rs='rails server'
alias rc='rails console'

alias mysqlstart='cd /usr/local/Cellar/mysql/5.1.48 && /usr/local/Cellar/mysql/5.1.48/bin/mysqld_safe'
