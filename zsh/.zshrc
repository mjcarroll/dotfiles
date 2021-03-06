#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [[ -e "${HOME}/.zshrc.local" ]]; then
  source "${HOME}/.zshrc.local" 
fi


alias open='xdg-open'
setopt nonomatch
setopt clobber
unsetopt SHARE_HISTORY
