#!/bin/bash

mkdir -p ~/devel/lib
mkdir -p ~/devel/bin
mkdir -p ~/devel/src

ln -s "$HOME/devel/lib/dotfiles/bash_aliases" "$HOME/.bash_aliases"
ln -s "$HOME/devel/lib/dotfiles/vim/vim" "$HOME/.vim"
ln -s "$HOME/devel/lib/dotfiles/vim/vimrc" "$HOME/.vimrc"
ln -s "$HOME/devel/lib/dotfiles/bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/devel/lib/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/devel/lib/dotfiles/screenrc" "$HOME/.screenrc"
