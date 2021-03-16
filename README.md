# CFG - A bare Git repository for dot files


## Prerequisite

    sudo apt install git


## Setup

    git clone --bare git@github.com:paulmallon/cfg.git $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
    config config status.showUntrackedFiles no
    config config credential.helper cache
    
## Backup existing files    

    mkdir -p .config-backup && \
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} mv {} .config-backup/{}
    
## Checkout    

    config checkout
    
## Add files

    config status
    config add .somefile
    config commit -m "Add .somefile"
    config push


## Links

https://www.atlassian.com/git/tutorials/dotfiles