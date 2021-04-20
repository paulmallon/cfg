start=`date +%s.%N`

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# git prompt settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
#GIT_PS1_SHOWSTASHSTATE=1
#GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=verbose

# nomad settings
export NOMAD_ADDR=http://nomad.service.consul:4646
complete -C /usr/bin/nomad nomad

# confluent hub
export PATH=$PATH:/usr/local/bin/confluent-hub/bin

# ~/.local/bin
export PATH=$PATH:/home/pm/.local/bin

# gihub url
export GITHUB=git@github.com:paulmallon

# ec2
__instanceId="i-01831f648d04a2008"

function ec2-connect() {
	local instanceId=$1
        [[ -z $instanceId ]] && instanceId=${__instanceId}
	local ip=$(aws ec2 describe-instances --instance-id ${instanceId} | jq -r ".Reservations[].Instances[] | select(.InstanceId == \"${instanceId}\") | .PublicDnsName" )
        ssh -oStrictHostKeyChecking=no -i /home/pm/.ssh/ec2-2021.pem ubuntu@${ip}
}

function ec2-status() {
	local instanceId=$1
	[[ -z $instanceId ]] && instanceId=${__instanceId}
	aws ec2 describe-instance-status --instance-id ${instanceId} | jq .
}

function ec2-start() {
	local instanceId=$1
        [[ -z $instanceId ]] && instanceId=${__instanceId}
	aws ec2 start-instances --instance-id ${instanceId} | jq .
	aws ec2 wait instance-running --instance-id ${instanceId}
	ec2-status ${instanceId}
	printf "\n\nPress enter to connect (ctrl-c to abort)...\n\n"
	ec2-connect ${instanceId}
}

function ec2-stop() {
	local instanceId=$1
        [[ -z $instanceId ]] && instanceId=${__instanceId}
	aws ec2 stop-instances --instance-id ${instanceId} | jq .
	aws ec2 wait instance-stopped --instance-id ${instanceId}
	ec2-status ${instanceId}
	printf "\n\nInstance stopped\n\n"
}

# pretty 
function pretty () { pygmentize -f terminal "$1"; }
export -f pretty

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
export -f _logTrace _logDebug _logInfo _logSuccess _logWarning _logError

# Print commands and their arguments as they are executed
function debug-command() {  trap '{ set +xv; }' return; set -xv && eval $@; }
export -f debug-command

# calc 
function calc(){ awk "BEGIN { print "$*" }"; }
export -f calc

# zenburn colors
function zen() {
	echo -ne '\e]12;#BFBFBF\a'
	echo -ne '\e]10;#DCDCCC\a'
	echo -ne '\e]11;#3F3F3F\a'
	echo -ne '\e]4;0;#3F3F3F\a'
	echo -ne '\e]4;1;#705050\a'
	echo -ne '\e]4;2;#60B48A\a'
	echo -ne '\e]4;3;#DFAF8F\a'
	echo -ne '\e]4;4;#506070\a'
	echo -ne '\e]4;5;#DC8CC3\a'
	echo -ne '\e]4;6;#8CD0D3\a'
	echo -ne '\e]4;7;#DCDCCC\a'
	echo -ne '\e]4;8;#709080\a'
	echo -ne '\e]4;9;#DCA3A3\a'
	echo -ne '\e]4;10;#C3BF9F\a'
	echo -ne '\e]4;11;#F0DFAF\a'
	echo -ne '\e]4;12;#94BFF3\a'
	echo -ne '\e]4;13;#EC93D3\a'
	echo -ne '\e]4;14;#93E0E3\a'
}

# Show the divergence from upstream
function git_show_upstream() { 
	count=$(git rev-list --left-right --count @{upstream}...HEAD)

	case "$count" in "") # no upstream
                p="no upstream" ;;
        "0	0")
                p="is equal to upstream" ;;
        "0	"*)
                p="is ahead of upstream (${count#0})" ;;
        *"	0")
                p="is behind upstream" ;;
        *)
                p="have diverged from upstream" ;;
        esac
        echo "Current branch ${p}."
}
export -f git_show_upstream

# Java config
# Should be set by /etc/profile.d/jdk.sh
JAVA_HOME=/usr/java/openjdk/jdk-16
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
export JAVA_HOME
export PATH

# Print java info
_logInfo "Java version: $(java --version | head -1 | cut -d " " -f 1,2)"
_logInfo "JAVA_HOME: $JAVA_HOME"

# check dot files status
/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME diff --no-ext-diff --quiet ||  _logWarning "Local dot files are dirty!"

# Load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
    while trap '' 2  && inotifywait -q -q -e modify ~/.bash_aliases; do source ~/.bash_aliases; done &
    trap - 2
    _logSuccess "Aliases loaded"
else
    _logWarning ".bash_aliases not found"
fi

# Print end status
_logSuccess "All run commands executed in $( echo "$(date +%s.%N) - $start" | bc -l )"
