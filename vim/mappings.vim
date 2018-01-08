let mapleader = "\\"
map <space> \
let maplocalleader = ","
nnoremap <leader><space> :

" directory {{{
nnoremap <leader>dc :cd %:p:h<cr>:pwd<cr>
" }}}

" file {{{
nnoremap <leader>fs :w<cr>
nnoremap <leader>fw :w !sudo tee % > /dev/null<cr>
" nnoremap <leader>fe :e %<cr>
" nnoremap <leader>q :silent call ToggleQuickFix()<cr>

nnoremap <leader>ff :CtrlP<cr>
nnoremap <leader>fr :CtrlPMRU<cr>

" editing config files
map <leader>fed :e ~/.vimrc<enter>
map <leader>fem :e ~/.vim/mappings.vim<enter>
map <leader>fev :e ~/.vim/vundle.vim<enter>
" }}}

" search {{{
noremap / /\v
noremap ? ?\v
nnoremap <leader>s :%s/\v
vnoremap <leader>s :s/\v
nnoremap S :s/\v
" }}}

" windows {{{
nnoremap <leader>w/ :vsplit<cr>
nnoremap <leader>w- :split<cr>
" keep the buffer (thus “hide” and not “close”)
nnoremap <leader>wd :hide<cr>
nnoremap <leader>ww :wincmd w<cr>
" }}}

" buffers {{{
nnoremap <leader><tab> :b#<cr>
nnoremap <leader>bd :b#<bar>bd#<cr>
" }}}

" some spacemacs (and actually better) defaults
noremap <leader>p "*p
noremap <leader>P "*P
noremap H ^
noremap L $
nnoremap Y y$
xmap s <Plug>VSurround

map gh :noh<enter>
