colorscheme solarized 
set background=dark
set t_Co=256

if has("gui_running")
  set t_Co=256
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set lines=60
  set columns=190
  
  if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  else
    set guifont=Ubuntu\ Mono:h17
  endif
else
  let g:CSApprox_loaded = 1
endif

