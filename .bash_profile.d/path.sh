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
PATH="~/devel/scala/sbt/bin:/usr/local/bin:$PATH"

test -d "$HOME/devel/bin" && PATH="$HOME/devel/bin:$PATH"
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

test -d "/usr/local/cuda" && LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/lib:$LD_LIBRARY_PATH"
