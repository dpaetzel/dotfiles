# vim key bindings
bindkey -v

# actually print global aliases after hitting space
function globalias () {
    if [[ $LBUFFER =~ '^(|.* )[A-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias
bindkey -M viins ' ' globalias
bindkey -M viins '^ ' magic-space  # control-space to bypass completion
bindkey -M isearch ' ' magic-space # normal space during searches

# substring search keybindings
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
