#!/bin/bash

echo "In ~/.bash_profile"

[ -f "${HOME}/.profile" ] && source "${HOME}/.profile"  

[ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"
