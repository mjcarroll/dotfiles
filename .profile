#!/bin/sh
#
#   Profie
#   Man page: profile
#   Useful reference: https://help.ubuntu.com/community/EnvironmentVariables

#set -x

# Prepend paths
ppath() {
 [ -d "${1}" ] && PATH="${1}:${PATH}"
}
ppath "/sbin"
ppath "/bin"
ppath "/usr/sbin"
ppath "/usr/bin"
# Add all ~/.bin and all ~/.bin-* directories to path
for D in $(find $HOME -maxdepth 1 -name ".bin-*" -o -name ".bin" | sort); do
    ppath ${D}
done
unset -f ppath
export PATH

# Locale settings (man page: locale)
unset LC_ALL
LANGUAGE="en_US:en" && export LANGUAGE
LANG="en_US.UTF-8" && export LANG
LC_CTYPE="en_US.utf8" && export LC_CTYPE
LC_NUMERIC="en_US.utf8" && export LC_NUMERIC
LC_TIME="en_US.utf8" && export LC_TIME
LC_COLLATE="en_US.utf8" && export LC_COLLATE
LC_MONETARY="en_US.utf8" && export LC_MONETARY
LC_MESSAGES="en_US.UTF-8" && export LC_MESSAGES
LC_PAPER="en_US.utf8" && export LC_PAPER
LC_NAME="en_US.utf8" && export LC_NAME
LC_ADDRESS="en_US.utf8" && export LC_ADDRESS
LC_TELEPHONE="en_US.utf8" && export LC_TELEPHONE
LC_MEASUREMENT="en_US.utf8" && export LC_MEASUREMENT
LC_IDENTIFICATION="en_US.utf8" && export LC_IDENTIFICATION
# Prohibit perl from complaining about missing locales
PERL_BADLANG=0 && export PERL_BADLANG

# iptyhon configuration directory
IPYTHONDIR="${HOME}/.config-base/ipython"
export IPYTHONDIR

# PRIVATE AND LOCAL
#
[ -e "${HOME}/.profile-private" ] && . "${HOME}/.profile-private"
[ -e "${HOME}/.profile-local" ] && . "${HOME}/.profile-local"

# Application configuration
EDITOR="editor" && export EDITOR
VISUAL="${EDITOR}" && export VISUAL
ALTERNATE_EDITOR="${EDITOR}" && export ALTERNATE_EDITOR
[ $(which less) ] && PAGER="$(which less)" && export PAGER
