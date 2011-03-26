if [[ $- != *i* ]]; then
  return
fi

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='mac'
    export CPATH=/opt/local/include
    export LIBRARY_PATH=/opt/local/lib
    export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:/opt/local/lib
fi

shopt -u mailwarn
unset MAILCHECK

# Without Clock
export PS1="[\u@\[\e[32;1m\]\H \[\e[0m\]\w]\$ "

# With Clock
# PS1="\[\033[36m\][\t] \[\033[1;33m\]\u\[\033[0m\]@\h:\[\033[36m\][\w]:\[\033[0m\] "

export EDITOR='vim'
export VISUAL=$EDITOR

# Shell options
shopt -s histappend
set +o histexpand
set -o vi
shopt -s cdspell
shopt -s cmdhist
shopt -s histreedit
shopt -s hostcomplete
shopt -s cdable_vars
shopt -s no_empty_cmd_completion
shopt -s extglob

# ENV VARIABLES
export HISTSIZE=10000
export HISTFILESIZE=409600
export HISTIGNORE="cd:ls:[bf]g:clear:exit:gp:gs:ll"
export HISTCONTROL="ignoredups:ignoreboth"
export HISTTIMEFORMAT="[%D%T]"
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export CLICOLOR="yes"

# Bash Completion
if [[ $platform == 'linux' ]]; then
    source /etc/bash_completion    
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

shopt -s extglob
complete -cf sudo

complete -A hostname rsh rcp telnet rlogin r ftp ping disk
complete -A variable export local readonly unset
complete -A alias alias unalias
complete -A function function
complete -A user su mail finger

complete -A helptopic help
complete -A shopt shopt
complete -A directory mkdir rmdir
complete -A directory -o default cd

export PATH="/opt/local/bin:/usr/local/bin:$PATH"

# Functions
extract () 
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
} 

