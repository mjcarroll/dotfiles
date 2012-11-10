#!/bin/bash

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

: ${HOSTFILE=~/.ssh/known_hosts}
: ${INPUTRC=~/.inputrc}

# System bashrc
test -r /etc/bashrc && . /etc/bashrc

# Read all the interesting bits from sub-files.
shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*.sh; do
    source "$file"
done
shopt -u nullglob

#----------------------
# Prompt 
#----------------------

ps1_set --prompt ∫ --notime 'S\:\ '

# -------------------------
# Closing Notes/User Specific
# -------------------------

source ~/.rosrc

LD_LIBRARY_PATH=/usr/local/cuda:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH

export http_proxy=''
export https_proxy=''

# Tell me something nifty at login
test -n "$INTERACTIVE" -a -n "$LOGIN" && {
    source ~/.sshrc
    uname -npsr
    uptime
}
