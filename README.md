# CFG - A bare Git repository for dot files

## Setup

    git clone --bare git@github.com:paulmallon/cfg.git $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
    config checkout
    config config status.showUntrackedFiles no
    config config credential.helper cache

## Add files

    config status
    config add .vimrc
    config commit -m "Add vimrc"
    config add .bashrc
    config commit -m "Add bashrc"
    config push


## Links

https://www.atlassian.com/git/tutorials/dotfiles