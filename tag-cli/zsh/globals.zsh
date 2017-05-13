# global aliases
alias -g B='&!'

alias -g H='| head'
alias -g F="| head -$(($(tput lines) - 3))" # “full screen”
alias -g T='| tail'
alias -g G='| grep --color -i -E'
alias -g S='| sed -r'
alias -g L='| less'
alias -g W='| wc -l'

alias -g HH='|& head'
alias -g FF="|& head -$(($(tput lines) - 3))" # “full screen”
alias -g TT='|& tail'
alias -g GG='|& grep --color -i -E'
alias -g SS='|& sed -r'
alias -g LL='|& less'
alias -g WW='|& wc -l'

alias -g NF='*(.om[1])'
alias -g NFF='*(/om[1])'
alias -g ND='~/Temporary/*(.om[1])'
