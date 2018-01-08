source ~/.vim/vundle.vim
source ~/.vim/mappings.vim


augroup VimStartup
    autocmd!
    autocmd VimEnter * sil! iunmap <c-k>
augroup end


augroup Vimrc
    autocmd!
    autocmd BufWritePost *.vimrc source ~/.vimrc
augroup end


function! Mkdir ()
    let dir = expand ('%:p:h')

    if !isdirectory (dir)
        call mkdir (dir, "p")
        echo "created directory: " . dir
    endif
endfunction
autocmd BufWritePre * call Mkdir ()


set sh=bash
set nocompatible


" interface {{{
" pls vim let me think about the keys I enter
set notimeout
set background=dark
colorscheme solarized
set history=1000
set relativenumber
set number
" always yank into the SELECTION register, too
set clipboard+=unnamed
filetype plugin indent on
syntax on
" nowrap: split line at 'textwidth' (changing the buffer!)
" wrap: only continue in the next line when reaching the windows end
set wrap
set noerrorbells
set novisualbell
set timeoutlen=500
set mousehide
set textwidth=80
set ruler
set cursorline
set nocursorcolumn
set scrolloff=8
set showcmd

" Every wrapped line will continue visually indented (same amount of
" space as the beginning of that line), thus preserving horizontal blocks
" of text.
if exists('+breakindent')
  set breakindent showbreak=\ +
endif

set display=lastline

set guioptions-=m " disable menubar
set guioptions-=T " disable toolbar
set guioptions-=r " disable scrollbar

" TODO make all gui options ifgui only
" set guifont=Inconsolata\ 14
"set guifont="InconsolataForPowerline Nerd Font Medium:h14"
" set guifont="InconsolataForPowerline Nerd Font Medium 14"
set guifont=InconsolataForPowerline\ Nerd\ Font\ Medium\ 14
" space between lines (also increases status line height)
set ambiwidth=double
set list listchars=tab:›\ ,trail:␣
set guicursor=a:blinkon0
set linespace=2

" not needed, statusline does it
set noshowmode

" indentation {{{
" be smart about indentation pls (proper deleting also)
set smarttab
" use spaces, not tabs
set expandtab
" tabstops should *look* like 2 spaces
set tabstop=2 
" always indent by 2 spaces
set softtabstop=0
" always indent by 2 spaces
set shiftwidth=2
" }}}
" statusline (unneeded since using airline) {{{
" set statusline=%f                                  " tail of the filename
" set statusline+=\ %{fugitive#statusline()}         " git status
" set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]    " file encoding
" set statusline+=\ [%{&ff}]                         " file format
" set statusline+=\ %y                               " filetype
" set statusline+=\ %m                               " modified flag
" set statusline+=\ %r                               " read only flag
" set statusline+=\ %h                               " help file flag
" set statusline+=\ %=                               " left/right separator
" set statusline+=\ [%c%V,\ %l]                      " cursor column, cursor line
" set statusline+=\ [%L]                             " total lines
" }}}
" folds {{{
set foldmethod=marker
set foldenable
" set foldmethod=syntax
set foldnestmax=3
set foldlevel=10
set foldlevelstart=0
let g:vimsyn_folding='a'
" }}}
" }}}


" search {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set nolazyredraw
set showmatch
" }}}


" filename completions {{{
set wildmode=list:longest
set wildmenu
set wildignore=*.o,*~,*.cfg,*.hi,*.pdf,*.bin,*.class,*.iso,*.aux
" }}}


" files {{{
set encoding=UTF-8
" if a file is changed from outside
set autoread
" autmatically save file when e.g. changing buffer
set autowrite
" }}}


" plugin configuration {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep' " --nogroup --nocolor --column'
endif

let g:airline_theme='zenburn'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" needed for lightline to properly work
" set laststatus=2
" let g:lightline = {
"       \ 'colorscheme': 'solarized',
      " \ }

let g:haskell_disable_TH = 1 " disable template Haskell highlighting for now
let g:haskell_classic_highlighting = 1

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
" }}}
