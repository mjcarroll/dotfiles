if [[ $- != *i* ]]; then
  return
fi

# Aliases
alias df='df -H'
alias du='du -H'
alias ls='ls -hF'
alias dir='ls'
alias vdir='ls'
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

# Shell options
shopt -s histappend
set +o histexpand
shopt -s cdspell
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

export PATH="/usr/local/bin:$PATH"

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
