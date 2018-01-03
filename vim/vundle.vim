" required by Vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" plugin management
Plugin 'https://github.com/tpope/vim-pathogen'
" add support for multiple simultaneous key presses
Plugin 'https://github.com/kana/vim-arpeggio'
Plugin 'https://github.com/sirver/UltiSnips'
Plugin 'https://github.com/gerw/vim-latex-suite'
" git client
Plugin 'https://github.com/tpope/vim-fugitive'
" proper color scheme
Plugin 'https://github.com/altercation/vim-colors-solarized'
" brackets
Plugin 'https://github.com/tpope/vim-surround'
" add ]] SPC stuff
Plugin 'https://github.com/tpope/vim-unimpaired'
" comment out stuff
Plugin 'https://github.com/tpope/vim-commentary'
" add '.' capabilities to some plugins
Plugin 'https://github.com/tpope/vim-repeat'
" properly edit git stuff (commit messages etc.)
Plugin 'https://github.com/tpope/vim-git'
" end keywords for ruby, bash, vimscript and others
Plugin 'https://github.com/tpope/vim-endwise'
" making vim plugins
Plugin 'https://github.com/tpope/vim-scriptease'
" journalin'
Plugin 'https://github.com/ledger/vim-ledger'
" syntax error hints
Plugin 'https://github.com/vim-syntastic/syntastic'
" opening files more easily
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
" searching file content (but use ag instead of ack)
Plugin 'mileszs/ack.vim'
" nicer status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
