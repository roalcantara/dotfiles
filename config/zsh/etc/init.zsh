# ZSH directories
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
export ZSH_DATA_DIR="${ZSH_DATA_DIR:-$XDG_DATA_HOME/zsh}"
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$XDG_CACHE_HOME/zsh}"
export ZSH_COMPCACHE="${ZSH_COMPCACHE:-$ZSH_CACHE_DIR/compcache}"

# ZSH custom directories
export ZDOTDIR_OPT="${ZDOTDIR_OPT:-$ZDOTDIR/opt}"
export ZDOTDIR_ETC="${ZDOTDIR_ETC:-$ZDOTDIR/etc}"

# ZSH state files
export ZSH_COMPDUMP="${ZSH_COMPDUMP:-$ZSH_COMPCACHE/.zcompdump}"
export HISTFILE="${HISTFILE:-$ZSH_DATA_DIR/.zsh_history}"

# ZIM variables
# Set where the directory used by Zim will be located (https://zimfw.sh/docs/install)
export ZIM_HOME="${ZIM_HOME:-$XDG_CACHE_HOME/zim}"
# Remove path separator from WORDCHARS.
export WORDCHARS="${WORDCHARS//[\/]/}"

# Create directories if they don't exist
mkdir -p "$ZDOTDIR" "$ZSH_DATA_DIR" "$ZSH_CACHE_DIR" "$ZSH_COMPCACHE" "$ZIM_HOME"

# vi: set ft=sh:
