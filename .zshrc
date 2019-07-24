bindkey -v

# Change color of % when in vim NORMAL mode
function zle-line-init zle-keymap-select {
    color=10
    case ${KEYMAP} in
        (vicmd)
            color=11;;
    esac
    PROMPT="%~ %F{$color}%#%f "
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
KEYTIMEOUT=1

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

setopt append_history hist_find_no_dups
setopt auto_cd
setopt menu_complete

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

zmodload zsh/complist
bindkey -M menuselect '^M' .accept-line
bindkey -M menuselect '^[[Z' reverse-menu-complete

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
