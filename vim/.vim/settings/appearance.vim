colorscheme ir_black
set background=dark

if has("gui_running")
  set t_Co=256
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M

  set lines=60
  set columns=190
else
  let g:CSApprox_loaded = 1
endif

