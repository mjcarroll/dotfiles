
nnoremap Y y$
function! YRRunAfterMaps()
  nnoremap Y  :<C-U>YRYankCount 'y$'<CR>
endfunction

" map ," ysiw word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ Srround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ Srround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

map ,` ysiw`

" Go to last edit location with ,.
nnoremap ,. '.

imap <C-a> <esc>wa

" Move back and forth through buffers
nnoremap <silent> ,z :bp<CR>
nnoremap <silent> ,x :bn<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-j> <C-w>j

map <silent> ,gz <C-w>o

nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

nmap <silent> // :nohlsearch<CR>
noremap ,hl :set hlsearch! hlsearch?<CR>

nnoremap ' `
nnoremap ` '


