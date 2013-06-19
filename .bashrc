#!/bin/bash

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

: ${HOSTFILE=~/.ssh/known_hosts}
: ${INPUTRC=~/.inputrc}

bash_start_time=$(date +%s)

bash_uptime() {
    echo "$(($(date +%s)-${bash_start_time})) seconds"
}
log() {
    [ ! -z "$PS1" ] \
        && echo -n ""
    return 0
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

if [ $UID != 0 ]; then
    # Pip download cache
    mkdir -p "${HOME}/.cache/pip_download" \
        && export PIP_DOWNLOAD_CACHE="${HOME}/.cache/pip_download"
fi

[ -z "$PS1" ] \
    && return

[ $(which stty) ] \
    && stty -ixon

# Read all the interesting bits from sub-files.
shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*.sh; do
    log "$file"
    source "$file"
done
shopt -u nullglob

# Prompt
ps1_set --prompt ∫ --notime 'S\:\ '

# And Title Bar
case "$TERM" in
    rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;urxvt:${PWD/$HOME/~}\007"'
        ;;
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
        ;;
    *)
        ;;
esac

[ -e "${HOME}/.bash_profile.d/z.sh" ] \
    && . "${HOME}/.bash_profile.d/z.sh"

[ -e "${HOME}/.profile" ] \
    && . "${HOME}/.profile"

# Private and Local
[ -e "${HOME}/.bashrc-private" ] \
    && . "${HOME}/.bashrc-private" \
    && log "loaded .bashrc-private"

[ -e "${HOME}/.bashrc-local" ] \
    && . "${HOME}/.bashrc-local" \
    && log "loaded .bashrc-local"

# ROS
[ -e "${HOME}/.rosrc" ] \
    && . "${HOME}/.rosrc" \
    && log "loaded .rosrc"
