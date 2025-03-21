export PATH="$PATH:$HOME/.local/bin:$HOME/bin"
export EDITOR=$(which vim)
export VISUAL="$EDITOR"
export LANG="en_US.UTF-8"

# Local Overrides
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
