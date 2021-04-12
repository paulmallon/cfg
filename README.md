# CFG - A bare Git repository for dot files


## Prerequisite

    sudo apt install git


## Setup

    git clone --bare git@github.com:paulmallon/cfg.git $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    config config status.showUntrackedFiles no
    config push -u origin main

    
## Backup existing files    

    mkdir -p .config-backup
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} mv {} .config-backup/{}
       
## Checkout    

    config checkout
    
## Commit and push 
    
    configcommit


## Links

https://www.atlassian.com/git/tutorials/dotfiles

https://news.ycombinator.com/item?id=11071754
