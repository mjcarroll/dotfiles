#!/usr/bin/env bash

if [ -f /etc/bash_completion ] ; then
    . /etc/bash_completion
fi

if [ -f `command -v brew --prefix`/etc/bash_completion ]; then
    . `command -v brew --prefix`/etc/bash_completion
fi

: ${USER_BASH_COMPLETION_DIR:=~/.bash_profile.d/completion}

test -n "$USER_BASH_COMPLETION_DIR" && {
    # source completion directory definitions
    if [ -d $USER_BASH_COMPLETION_DIR -a -r $USER_BASH_COMPLETION_DIR -a \
            -x $USER_BASH_COMPLETION_DIR ]; then
        for i in $USER_BASH_COMPLETION_DIR/*; do
            [[ ${i##*/} != @(*~|*.bak|*.swp|\#*\#|*.dpkg*|.rpm*) ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
        done
    fi
    unset i
}
