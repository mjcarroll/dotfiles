shopt -u mailwarn
unset MAILCHECK

#HISTORY
# Ignore duplicate lines in history
export HISTCONTROL="ignoredups"
# Ignore same successive entries
export HISTCONTROL="ignoreboth"

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="[%D%T]"
export HISTIGNORE="fg*:bg*:history*:ls*"

shopt -s histappend
shopt -s cmdhist
shopt -s histreedit

#SPELLING AND AUTOCOMPLETE
shopt -s cdspell
shopt -s cdable_vars
shopt -s hostcomplete

alias df='df -H'
alias du='du -H'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'
alias la='ls -A'

export EDITOR='vim'
export VISUAL=$EDITOR

source ~/devel/lib/dotfiles/rosrc
source ~/.bash_aliases
source ~/.bash_profile
