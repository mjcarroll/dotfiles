#!/bin/bash

mkdir -p ~/devel/lib
mkdir -p ~/devel/bin
mkdir -p ~/devel/src

rm -r ~/devel/lib/dotfiles
git clone git://github.com/mjcarroll/dotfiles.git ~/devel/lib/dotfiles

rm "$HOME/.vim"
rm "$HOME/.vimrc"
rm "$HOME/.bash_profile"
rm "$HOME/.gitconfig"
rm "$HOME/.screenrc"

ln -s "$HOME/devel/lib/dotfiles/vim/vim" "$HOME/.vim"
ln -s "$HOME/devel/lib/dotfiles/vim/vimrc" "$HOME/.vimrc"
ln -s "$HOME/devel/lib/dotfiles/bash_profile" "$HOME/.bash_profile"
ln -s "$HOME/devel/lib/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -s "$HOME/devel/lib/dotfiles/screenrc" "$HOME/.screenrc"
