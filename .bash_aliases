
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# some more ls aliases
alias ll='ls -alF --color'
alias la='ls -A --color'
alias l='ls -CF --color'
alias ls='ls -alF --color'
alias gl='git log --oneline -25'
alias gll="git log --graph --color --pretty=format:'%s  - %cr by %an - %h'"


#
# CPU 
#

alias cpuavail='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors'
alias cpushow='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor && lscpu |egrep "Model name|MHz"'
alias cpuhigh='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias cpulow='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias cpuwatch='sudo watch -t -n ,5 s-tui -j'
#alias cpuwatch1='watch grep \"cpu MHz\" /proc/cpuinfo'
