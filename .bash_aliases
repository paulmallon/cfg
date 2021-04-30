# sudo
alias sudp='sudo'

# watch port(s)
alias watchport="watch -n 1 -d -t 'nc -v -z 127.0.0.1'"
alias watchports="watch -n 1 -d -t 'netstat -tulpn | grep LISTEN'"

# java version
alias javaversion='sudo update-alternatives --config java && sudo update-alternatives --config javac && java --version && javac --version'

# cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' 
alias configcommit='config add ~/.bashrc && config add ~/.bash_aliases && config commit -q -m "Updated .bashrc and .bash_aliases" && config push -q'

# alert alias
#  Example:   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ls aliases
alias ll='ls -alF --color'
alias la='ls -A --color'
alias l='ls -CF --color'
alias ls='ls -alF --color'

# git aliases
alias g='git'

alias gs='git status -b -s'
alias gd='git diff'

alias gl='git log --oneline --max-count=10'
alias glg="git log --graph --oneline --max-count=10"
alias glgg='git log --graph --oneline --decorate'
alias glgga='git log --graph --decorate --all --stat'

alias gcl='git config --list --show-scope'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'

alias gpoat='git push origin --all && git push origin --tags'

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
alias mcist='mvn clean install -Dmaven.test.skip=true'
alias mt='mvn test'
alias mc='mvn clean'
alias mct='mvn clean test'
alias mvnintegrationtest='mvn clean install && mvn clean install -P it'

# ansible-play
alias ap='ansible-playbook local.yml --ask-become-pass'
alias aptags='ansible-playbook local.yml --ask-become-pass --tags'

# docker-compose
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcps='docker-compose ps'

# random strings
alias randomstrings='head -c 5000 /dev/urandom  | tr -dc 'a-zA-Z0-9' | fold -w 30'

# ksql db
alias ksql='docker exec -it ksqldb ksql http://localhost:8088'

# loggers
alias _logOk='_logSuccess'
alias _logWarn='_logWarning'

# nomad
alias nl='nomad logs'

