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
setopt appendhistory

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

source ~/.zsh_aliases
source ~/.zshrc.local
