# Bash tab-completion for homebrew (https://github.com/mxcl/homebrew)

###############
# Installation:

# mkdir ~/.bash_completion.d
# curl https://gist.github.com/raw/774554/brew_completer.sh > ~/.bash_completion.d/brew_completer.sh
# echo 'source ~/.bash_completion.d/brew_completer.sh' >> ~/.bashrc
# source ~/.bashrc

########
# Usage:

# Complete brew commands
# $ brew ins[tab] # => brew install
# $ brew li[tab][tab] # => link list

# Search for forumala to complete
# $ brew install mys[tab] # => brew install mysql
# $ brew install mysql[tab][tab] # => mysql mysql-connector-c mysql-proxy mysqlreport

# Search for installed formula to complete
# $ brew uninstall gi[tab][tab] # => gist git (in my case)

# Created by Aaron Suggs http://github.com/ktheory
# Based on http://www.debian-administration.org/article/An_introduction_to_bash_completion_part_2

_brew_completer()
{
  local cur prev words
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"

  case "${prev}" in
    brew)
      # Complete brew commands
      words="install list search uninstall update info options deps uses home cleanup link unlink outdated missing prune doctor --version --config --prefix --cache create edit audit log install"
      ;;
    install|search|info|options|deps|uses|home)
      # Complete all formula
      words=$(brew search ${cur})
      ;;
    list|uninstall|cleanup|link|unlink)
      # Complete installed formula
      words=$(brew list)
      ;;
    *)
      ;;
  esac

  COMPREPLY=($(compgen -W "${words}" -- ${cur}))  
  return 0
}
complete -F _brew_completer brew
