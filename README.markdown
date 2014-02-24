# Dotfiles

## Install
To install:

    git clone git://github.com/troynt/dotfiles.git ~/.dotfiles
    $ ~/.dotfiles/scripts/install.sh
The installer will **never** delete a file from your $HOME directory. If it encounters a file that isn't a symlink, it lets you handle the situation.

## Uninstall

To uninstall:

    $ ~/.dotfiles/scripts/uninstall.sh

This will only remove files of interest from $HOME that are symlinks.
