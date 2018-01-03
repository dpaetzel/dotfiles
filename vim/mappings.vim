let mapleader = "\\"
map <space> \
let maplocalleader = ","

nnoremap <leader><space> :
nnoremap <leader>w <ESC>:w<CR>
nnoremap <leader>sw <ESC>:w !sudo tee % > /dev/null<CR>
nnoremap <leader>c <ESC>:cd %:p:h<CR>:pwd<CR>
nnoremap <leader>q <ESC>:silent call ToggleQuickFix()<CR>
nnoremap <leader>e <ESC>:e %<CR>

" editing config files
map <leader>fed :e ~/.vimrc<enter>
map <leader>fem :e ~/.vim/mappings.vim<enter>
map <leader>fev :e ~/.vim/vundle.vim<enter>

map gh :noh<enter>

noremap / /\v
noremap ? ?\v
nnoremap <leader>s :%s/\v
vnoremap <leader>s :s/\v
nnoremap S :s/\v

nnoremap Y y$

noremap <leader>p "*p
noremap <leader>P "*P

noremap H ^
noremap L $

" ctrl-p
nnoremap <Enter> :CtrlPMRUFiles<CR>
nnoremap <C-Enter> :CtrlP<CR>
