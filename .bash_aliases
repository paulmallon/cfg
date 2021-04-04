# sudo
alias sudp='sudo'

# cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' 
alias configcommit='config add ~/.bashrc && config add ~/.bash_aliases && config commit -m "Updated .bashrc and .bash_aliases" && config push'



# alert alias
#  Example:   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# ls aliases
alias ll='ls -alF --color'
alias la='ls -A --color'
alias l='ls -CF --color'
alias ls='ls -alF --color'

# git aliases
alias gl='git log --oneline -25'
alias glg="git log --graph --color --pretty=format:'%s  - %cr by %an - %h'"
alias gcl='git config --list --show-scope'

# cpu govenor aliases
alias cpuavail='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors'
alias cpushow='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor && lscpu |egrep "Model name|MHz"'
alias cpuhigh='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias cpulow='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

# system monitor aliases
alias cpuwatch='sudo watch -t -n ,5 s-tui -j'
alias cpuwatch2='watch grep \"cpu MHz\" /proc/cpuinfo'

# mvn
alias mciit='mvn clean install -P it'
alias mci='mvn clean install'
alias mcist='mvnrun clean install -Dmaven.test.skip=true $@'
alias mt='mvnrun test $@'
alias mc='mvnrun clean $@'
alias mct='mvnrun clean test $@'

# ansible-play
alias ap='ansible-playbook local.yml --ask-become-pass $@'

# docker-compose
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcps='docker-compose ps'


