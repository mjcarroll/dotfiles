#!/usr/bin/env bash

#
# Source this file in your ~/.bash_profile or interactive startup file.
# This is done like so:
#
#    [[ -s "$HOME/.rvm/contrib/ps1_functions" ]] &&
#      source "$HOME/.rvm/contrib/ps1_functions"
#
# Then in order to set your prompt you simply do the following for example
#
# Examples:
#
#   ps1_set --prompt ∫
#
#   or
#
#   ps1_set --prompt ∴
#
# This will yield a prompt like the following, for example,
#
# 00:00:50 wayneeseguin@GeniusAir:~/projects/db0/rvm/rvm  (git:master:156d0b4)  ruby-1.8.7-p334@rvm
# ∴
#

RED="\[\033[0;31m\]"
BROWN="\[\033[0;33m\]"
GREY="\[\033[0;97m\]"
BLUE="\[\033[0;34m\]"
PS_CLEAR="\[\033[0m\]"
SCREEN_ESC="\[\033k\033\134\]"

ps1_identity()
{
  if [[ $UID -eq 0 ]]  ; then
    COLOR1="${RED}"
    COLOR2="${BROWN}"
  else
    COLOR1="${BLUE}"
    COLOR2="${BROWN}"
  fi

  printf "${GREY}[${COLOR1}\\\u${GREY}@${COLOR2}\\h${GREY}:${COLOR1}\w${GREY}]${COLOR2}  "

  return 0
}

ps1_git()
{
  local branch="" line="" attr=""

  shopt -s extglob # Important, for our nice matchers :)

  if ! command -v git >/dev/null 2>&1 ; then
    printf " \033[1;37m\033[41m[git not found]\033[m "
    exit 0
  fi

  # First we determine the current git branch, if any.
  while read -r line
  do
    case "${line}" in
      [[=*=]][[:space:]]*) # on linux, man 7 regex
        branch="${line/[[=*=]][[:space:]]/}"
        ;;
    esac
  done < <(git branch 2>/dev/null)

  # Now we display the branch.
  sha1=($(git log --no-color -1 2>/dev/null))
  sha1=${sha1[1]}
  sha1=${sha1:0:7}

  case ${branch} in
   production|prod) attr="1;37m\033[" ; color=41 ;; # red
   master|deploy)   color=31                     ;; # red
   stage|staging)   color=33                     ;; # yellow
   dev|development) color=34                     ;; # blue
   next)            color=36                     ;; # gray
   *)
     if [[ -n "${branch}" ]] ; then # Feature Branch :)
       color=32 # green
     else
       color=0 # reset
     fi
     ;;
  esac

  if [[ $color -gt 0 ]] ; then
    if [[ -n $attr ]] ; then
      printf "\[\033[%s%sm\](git:${branch}:$sha1)\[\033[0m\]" "${attr}" "${color}"
    else
      printf "(git:${branch}:${sha1}) " 
    fi
  fi

  return 1
}

ps1_rvm()
{
  if command -v rvm-prompt >/dev/null 2>/dev/null ; then
    printf " $(rvm-prompt) "
  fi
}

ps1_set()
{
  local prompt_char='$'
  local separator="\n"
  local notime=0

  if [[ $UID -eq 0 ]] ; then
    prompt_char='#'
  fi

  while [[ $# -gt 0 ]] ; do
    local token="$1" ; shift

    case "$token" in
      --trace)
        export PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "
        set -o xtrace
        ;;
      --prompt)
        prompt_char="$1"
        shift
        ;;
      --noseparator)
        separator=""
        ;;
      --separator)
        separator="$1"
        shift
        ;;
      --notime)
        notime=1
        ;;
      *)
        true # Ignore everything else.
        ;;
    esac
  done

  if [[ $notime -gt 0 ]] ; then
    PS1="$(ps1_identity)\[\033[34m\]\$(ps1_git)\$(ps1_rvm)\[\033[0m\]${separator}${BLUE}${prompt_char} ${PS_CLEAR}"
  else
    PS1="\D{%H:%M:%S} $(ps1_identity)\[\033[34m\]\$(ps1_git)\$(ps1_rvm)\[\033[0m\]${separator}${BLUE}${prompt_char} ${PS_CLEAR}"
  fi
}

ps2_set()
{
  PS2="  \[\033[0;40m\]\[\033[0;33m\]> \[\033[1;37m\]\[\033[1m\]"
}
