#!/usr/bin/env bash

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

: ${HOSTFILE=~/.ssh/known_hosts}
: ${INPUTRC=~/.inputrc}

#----------------------
# PATH
#----------------------
PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"

test -d "$HOME/devel/bin" && PATH="$HOME/devel/bin:$PATH"
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"