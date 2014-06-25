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

# Customize to your needs...
#
if [[ -e /opt/ros/groovy/setup.zsh ]]; then
  cd / && source /opt/ros/groovy/setup.zsh && cd -
fi

if [[ -e /opt/ros/hydro/setup.zsh ]]; then
  cd / && source /opt/ros/hydro/setup.zsh && cd -
fi

if [[ -e /opt/ros/indigo/setup.zsh ]]; then
  cd / && source /opt/ros/indigo/setup.zsh && cd -
fi


