export PATH="$PATH:$HOME/bin"
export EDITOR=$(which vim)
export VISUAL="$EDITOR"

# Local Overrides
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
