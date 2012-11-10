#!/usr/bin/env bash

: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}

: ${HOSTFILE=~/.ssh/known_hosts}
: ${INPUTRC=~/.inputrc}

if [ "$UNAME" = "Darwin" ]; then
    LS_COMMON="-hBG"
else
    LS_COMMON="-hB --color=auto"
fi

dircolors="$(type -P gdircolors dircolors | head -1)"
test -n "$dircolors" && {
    COLORS=/etc/DIR_COLORS
    test -e "/etc/DIR_COLORS.$TERM"         && COLORS="/etc/DIR_COLORS.$TERM"
    test -e "$HOME/.dircolors"              && COLORS="$HOME/.dircolors"
    test ! -e "$COLORS"                     && COLORS=
    eval `$dircolors --sh $COLORS`
}
unset dircolors

test -n "$LS_COMMON" && alias ls="command ls $LS_COMMON"

# Notify immedetely
set -o notify
set -o vi

# Shell options
shopt -s cdspell                    # Check cd spelling
shopt -s checkjobs
shopt -s dirspell
shopt -s extglob                    # Extended pattern matching
shopt -s hostcomplete               # Attempt to complete '@'
shopt -s interactive_comments       # Allow comments in interactive
shopt -u mailwarn                   # Don't tell me about mail, please.
shopt -s no_empty_cmd_completion    # Don't complete on an empty line.
shopt -s cdable_vars
shopt -s checkwinsize

unset MAILCHECK                     # Don't tell me about mail, please.

case "$-" in
    *i*) INTERACTIVE=yes ;;
    *) unset INTERACTIVE ;;
esac

case "$0" in
    -*) LOGIN=yes ;;
    *) unset LOGIN ;;
esac

# Always use passive FTP
: ${FTP_PASSIVE:=1}
export FTP_PASSIVE

# Some filetypes to ignore
FIGNORE="~:CVS:#:.pyc:.swp:.swa"

#HISTORY
export HISTCONTROL="ignoreboth"                 # Ignore space and duplicates 
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="[%D %T]"
export HISTIGNORE="fg*:bg*:history*:ls*"
shopt -s cmdhist                                # Save multiline in one line
shopt -s histreedit 
shopt -s histappend
set +o histexpand

if [ $UID != 0 ]; then
    export HISTFILE=~/.bash_history
else
    export HISTFILE=~/.bash_history_root
fi

#--------------------
# Pager and editor
#--------------------

HAVE_VIM=$(command -v vim)
HAVE_GVIM=$(command -v gvim)

test -n "$HAVE_VIM" && EDITOR=vim || EDITOR=vi
export EDITOR

# PAGER
if test -n "$(command -v less)" ; then
    PAGER="less -FirSwX"
    MANPAGER="less -FiRswX"
else
    PAGER=more
    MANPAGER="$PAGER"
fi
export PAGER MANPAGER

# Ack
ACK_PAGER="$PAGER"
ACK_PAGER_COLOR="$PAGER"

export CLICOLOR="yes"
