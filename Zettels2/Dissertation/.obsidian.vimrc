" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk
nmap <Down> gj
nmap <Up> gk

" Don't know why this isn't the default.
nmap Y y$

" Quickly remove search highlights
" nmap <F9> :nohl<CR>

" Yank to system clipboard
set clipboard=unnamed

" Make it similar to surround.
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_english_quotes surround “ ”
exmap surround_english_single_quotes surround ‘ ’
exmap surround_german_quotes surround „ “
exmap surround_german_single_quotes surround ‚ ‘
exmap surround_dollar surround $ $

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki<CR>
nunmap s
vunmap s
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s` :surround_backticks<CR>
map sb :surround_brackets<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>
map s“ :surround_english_quotes<CR>
map s‘ :surround_english_single_quotes<CR>
map s„ :surround_german_quotes<CR>
map s‚ :surround_german_single_quotes<CR>
map s$ :surround_dollar<CR>
