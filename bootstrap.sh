#!/bin/bash

mkdir -p ~/devel/lib
mkdir -p ~/devel/bin
mkdir -p ~/devel/src

git clone git://github.com/mjcarroll/dotfiles.git ~/devel/lib/dotfiles

ln -s "$HOME/devel/lib/dotfiles/vim/.vim" "$HOME/.vim"
ln -s "$HOME/devel/lib/dotfiles/vim/.vimrc" "$HOME/.vimrc"
