# sudo
alias sudp='sudo'

# watch port(s)
alias watchport="watch -n 1 -d -t 'nc -v -z 127.0.0.1'"
alias watchports="watch -n 1 -d -t 'netstat -tulpn | grep LISTEN'"

# java version
alias javaversion='sudo update-alternatives --config java'

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
alias mcist='mvnrun clean install -Dmaven.test.skip=true'
alias mt='mvnrun test'
alias mc='mvnrun clean'
alias mct='mvnrun clean test'

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

# ec2
__instanceId="i-01831f648d04a2008"

function start-bokker() {
	aws ec2 start-instances --instance-id ${__instanceId} | jq .
	aws ec2 wait instance-running --instance-id ${__instanceId}
	aws ec2 describe-instance-status --instance-id ${__instanceId} | jq .
	local publicDnsName=$(aws ec2 describe-instances --instance-id ${__instanceId} | jq -r '.Reservations[].Instances[] | select(.InstanceId == "i-01831f648d04a2008") | .PublicDnsName')
	printf "\n\nPublic DNS:\n\n${publicDnsName}\n\n"

}

function stop-bokker() {
	aws ec2 stop-instances --instance-id i-01831f648d04a2008 | jq .
	aws ec2 wait instance-stopped --instance-id i-01831f648d04a2008
	aws ec2 describe-instance-status --instance-id ${__instanceId} | jq .
	printf "\n\nInstance stopped\n\n"
}

function ec2-connect() {
	ssh -i /home/pm/.ssh/ec2-2021.pem ubuntu@$1
}

# pretty 
function pretty () { pygmentize -f terminal "$1"; }

# list all colors available in 256 color mode (http://jafrog.com/2013/11/23/colors-in-terminal.html)
function _colors() {
    for code in {0..255}
        do echo -e "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m"
    done
}

# console color aliases
_ct_error="\e[0;31m"
_ct_success="\e[0;32m"
_ct_warning="\e[0;33m"
_ct_highlight="\e[0;34m"
_ct_primary="\e[0;36m"
_ct="\e[0;37m"
_ctb_subtle="\e[1;30m"
_ctb_error="\e[1;31m"
_ctb_success="\e[1;32m"
_ctb_warning="\e[1;33m"
_ctb_highlight="\e[1;34m"
_ctb_primary="\e[1;36m"
_ctb="\e[1;37m"
_c_reset="\e[0m"

# log functions
function _logTrace()   { printf "${_ct}[${_ctb_subtle}TRACE${_ct}] $*${_c_reset}\n"; }
function _logDebug()   { printf "${_ct}[${_ctb_primary}DEBUG${_ct}] $*${_c_reset}\n"; }
function _logInfo()    { printf "${_ct}[${_ctb_highlight}INFO${_ct}] $*${_c_reset}\n"; }
function _logSuccess() { printf "${_ct}[${_ctb_success}OK${_ct}] $*${_c_reset}\n"; }
function _logWarning() { printf "${_ct}[${_ctb_warning}WARN${_ct}] $*${_c_reset}\n"; }
function _logError()   { printf "${_ct}[${_ctb_error}ERROR${_ct}] $*${_c_reset}\n"; }
