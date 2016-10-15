# time-separates-us.zsh-theme
#
# Author: David Pätzel
# loosely based on the magic-af theme by Andy Fleming
# Direct Link: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme

# color vars
eval color_time='%{$fg[yellow]%}'
eval color_separator='%{$fg_bold[black]%}'
eval color_hostname='%{$fg_bold[black]%}'
eval color_cwd='%{$fg[green]%}'
eval color_prompt='%{$fg[white]%}'
eval color_git_prompt='%{$fg_bold[blue]%}'
eval color_git_clean_symbol='%{$fg_bold[green]%}'
eval color_git_dirty_symbol='%{$fg_bold[red]%}'

# different colors for different privileges
# if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi

# the return code
local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"

# calculates the separator line
precmd() {
    LINE=$(printf '―%.0s' {1..$(($COLUMNS - 20))})
}

# the left prompt
PROMPT='$color_time%D{%F} %* %{$reset_color%}\
$color_separator$LINE%{$reset_color%}
$color_cwd%~%{$reset_color%} \
$(git_prompt_info)%{$reset_color%}\
$color_prompt%(!.#.>)%{$reset_color%} '

# the right prompt
RPROMPT='$return_code $color_hostname%n@%m%{$reset_color%}%'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="${color_git_prompt}"
ZSH_THEME_GIT_PROMPT_CLEAN="$color_git_clean_symbol✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$color_git_dirty_symbol✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
