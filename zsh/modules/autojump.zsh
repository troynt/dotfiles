if [[ $(uname) -eq "Linux" && -s /usr/share/autojump/autojump.sh ]]; then
    source /usr/share/autojump/autojump.sh
elif [[ $(uname) -eq "Darwin" && -s `brew --prefix`/etc/autojump.sh ]]; then
    source `brew --prefix`/etc/autojump.sh
fi
