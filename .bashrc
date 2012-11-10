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
        && echo "$1"
    return 0
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

if [ $UID != 0 ]; then
    # Pip download cache
    mkdir -p "${HOME}/.cache/pip_download" \
        && export PIP_DOWNLOAD_CACHE="${HOME}/.cache/pip_download"
fi

# -------------------------------------------------------------------------
# Connect to gpg agent if possible
#
log "gpg-agent"
agent_file="$HOME/.gnupg/gpg-agent-info-$(hostname)"
if [ -r "$agent_file" ] && kill -0 $(grep GPG_AGENT_INFO "$agent_file" | cut -d: -f 2) 2>/dev/null; then
    source "$agent_file"
    export GPG_AGENT_INFO;
    export SSH_AUTH_SOCK;
    export SSH_AGENT_PID
fi
GPG_TTY=$(tty)
export GPG_TTY

# System bashrc
log "system bashrc"
test -r /etc/bashrc && . /etc/bashrc

[ -z "$PS1" ] \
    && return

# Read all the interesting bits from sub-files.
shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*.sh; do
    log "$file"
    source "$file"
done
shopt -u nullglob

# Prompt
ps1_set --prompt ∫ --notime 'S\:\ '

# Private and Local
[ -e "${HOME}/.bashrc-private" ] \
    && . "${HOME}/.bashrc-private" \
    && log "loaded .bashrc-private"
[ -e "${HOME}/.bashrc-local" ] \
    && . "${HOME}/.bashrc-local" \
    && log "loaded .bashrc-local"

# clipboard paste
if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
    # Work around a bash bug: \C-@ does not work in a key binding
    bind '"\C-x\C-m": set-mark'
    # The '#' characters ensure that kill commands have text to work on; if
    # not, this binding would malfunction at the start or end of a line.
    bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -out -selection clipboard)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
fi

