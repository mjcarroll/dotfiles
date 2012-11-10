filetype off
filetype plugin indent on

set nocompatible

" Prevent modeline security exploits
set modelines=0

" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Basic options
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set hidden
set wildmenu
set wildmode=list:longest
set wildignore+=*.o,*.obj,.git,*.pyc
set visualbell
set cursorline
set ttyfast
set backspace=indent,eol,start
set notitle

set mouse=a

if exists("&relativenumber")
    set relativenumber
else
    set number
endif

set ls=2
set vb t_vb=
set confirm
set showcmd
set report=0
set shortmess+=a
set ruler
set laststatus=2
set statusline=%<%f\ (%{&ft})%=%-19(%3l,%02c%03V%)%{fugitive#statusline()}

set matchpairs+=<:>
set foldmethod=indent
set foldlevel=99
set virtualedit=onemore

" Undo File Stuff
if exists("&undofile")
    set undodir=~/.vim/tmp/undodir
    set undofile
endif

" Backups
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set backup

" Leader
let mapleader = ","

" Searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Make shifts keep selection
vnoremap < <gv
vnoremap > >gv

" Color scheme (terminal)
syntax on
set background=dark
colorscheme delek

" Use Pathogen to load bundles
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Taglist
let Tlist_Ctags_Cmd='/usr/bin/ctags'

au FileType python set omnifunc=pythoncomplete#Complete

set pumheight=6
set completeopt=menuone,longest,preview

" NERD Tree
map <leader>n :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$']
let g:NERDTreeHijackNetrw=1

" Yankring
let g:yankring_history_dir = '~/.vim/tmp/'
nmap <leader>y :YRShow<cr>

let g:pep8map='<leader>8'

" Quickfix:
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>

" MiniBufExplorer
map <leader>b :MiniBufExplorer<CR>
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapwindowNavVim = 1
let g:miniBufExplModSelTarget = 1

" Supertab
let g:SuperTabDefaultCompletionType = "context"

" Snipmate
let g:snips_author = 'Michael Carroll'
let g:snippets_dir = '~/.vim/snippets/'

set completeopt=menuone,longest,preview
set pumheight=6

nnoremap j gj
nnoremap k gk

" Easy buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Might as well make capital W do the same thing.
command! W :w
command! Q :q
command! Wq :wq
" Vimrc stuff ,v opens ,V reloads
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" For when I forget sudo
cmap w!! w !sudo tee % >/dev/null

" Text wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
if exists("&colorcolumn")
    set colorcolumn=85
endif

nnoremap ; :

" Faster ESC
inoremap jj <ESC>

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" Some fixes for ROS Files
au BufNewFile,BufRead *.launch setfiletype xml
au BufNewFile,BufRead *.urdf setfiletype xml

if has('gui_running')
    if has('mac')
        set guifont=Menlo:h12
        set fuoptions=maxvert,maxhorz
    endif
    colorscheme molokai
    set background=dark

    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    highlight SpellBad term=underline gui=undercurl guisp=Orange
endif
