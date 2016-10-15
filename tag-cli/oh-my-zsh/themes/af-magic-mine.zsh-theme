# af-magic-mine.zsh-theme
#
# Author: Andy Fleming
# URL: http://andyfleming.com/
# Repo: https://github.com/andyfleming/oh-my-zsh
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
# modified by: David Pätzel

# color vars
eval my_blue='%{$fg[blue]%}'
eval my_blue_bold='%{$fg_bold[blue]%}'
eval my_gray='$FG[244]'
eval my_orange='$FG[214]'
# eval my_yellow='%{$fg_bold[cyan]%}'

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"

# primary prompt
precmd() {
    LINE=$my_gray$(printf ―%.0s {1..$COLUMNS})%{$reset_color%}
}

PROMPT='$LINE
$my_blue%~\
$(git_prompt_info) \
$my_blue%(!.#.>)%{$reset_color%} '
# $my_yellow%(!.#.»)%{$reset_color%} '

# PROMPT2=PROMPT
# RPS1='${return_code}'


# right prompt
RPROMPT='${return_code} $my_gray%n@%m%{$reset_color%}%'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX=" $my_blue_bold"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" $my_orange*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
