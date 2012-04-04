#!/usr/bin/env bash

alias df='df -H'
alias du1='du -ch --max-depth=1'
alias duh='du -chs ./*'
alias hi='history | tail -20'
alias vimdiff='vim -g -d'


alias sl=ls
alias ls='ls -G'        # Compact view, show colors
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

alias _="sudo"

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up two directories
alias -- -="cd -"        # Go back

# Directory
alias	md='mkdir -p'
alias	rd=rmdir
#}}}

# Git {{{
alias g='git'
alias gcl='git clone'
alias ga='git add'
alias gaa='git add .'
alias gst='git status'
alias gss='git status -s'
alias gp='git push'
alias gpo='git push origin'
alias gpu='git push upstream'
alias gca='git commit -v -a -m'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'