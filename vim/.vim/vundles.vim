set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/vundles/
call vundle#rc()

Bundle "gmarik/vundle"

runtime appearance.vundle
runtime git.vundle
runtime languages.vundle
runtime project.vundle
runtime search.vundle
runtime textobjects.vundle
runtime vim-improvements.vundle

filetype plugin indent on

