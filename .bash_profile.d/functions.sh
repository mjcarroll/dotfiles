#!/usr/bin/env bash

extract () {
  if [ $# -ne 1 ]
  then
    echo "Error: No file specified."
    return 1
  fi
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via extract" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function ips {
	ifconfig | grep "inet " | awk '{ print $2 }'
}

function down4me() {
  curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

function myip {
  res=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
  echo "Your public IP is: ${bold_green} $res ${normal}"
}

function mkcd() {
  mkdir -p "$*"
  cd "$*"
}

function lsgrep(){
  ls | grep "$*"
}
