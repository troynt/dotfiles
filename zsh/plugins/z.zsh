if [[ $(uname) == 'Linux' ]]; then
    . /usr/local/etc/profile.d/z.sh
elif [[ $(uname) == 'Darwin' ]]; then
    . `brew --prefix`/etc/profile.d/z.sh
fi

function precmd () {
  z --add "$(pwd -P)"
}
alias j=z
