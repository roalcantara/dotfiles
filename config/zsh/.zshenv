#!/usr/bin/env zsh

# ~/.zshenv
# Sourced on all invocations of the shell - unless the -f option is set
# Contains commands and set variables that should be available to other programs
# http://zsh.sourceforge.net/Intro/intro_3.html

setopt NO_GLOBAL_RCS   # Prevents loading of global rc files like /etc/zprofile
skip_global_compinit=1 # Skip sourcing global compinit

## INTERNATIONALISATION VARIABLES
# The values that the environment variables may be assigned are not restricted;
# Except that they are considered to end with a null byte and the total space used to store the environment and the arguments to the process is limited to {ARG_MAX} bytes.
# It is unwise to conflict with certain variables that are frequently exported by widely used command interpreters and applications.
# https://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html

# LANG, LC_ALL, LC_CTYPE & LC_COLLATE
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_COLLATE=C

# XDG DIRECTORIES {
# Determines where user-specific configurations should be written
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# Fix XDG_RUNTIME_DIR permissions and ownership
ensure_xdg_runtime_perm_and_owner() {
  if [[ -z "$XDG_RUNTIME_DIR" || "$XDG_RUNTIME_DIR" =~ ^[[:space:]]*$ ]]; then
    export XDG_RUNTIME_DIR="/tmp/runtime-$USER"
  fi

  if [[ ! -d $XDG_RUNTIME_DIR ]]; then
    mkdir -p $XDG_RUNTIME_DIR || {
      echo "Failed to create XDG_RUNTIME_DIR directory '$XDG_RUNTIME_DIR'"
      return 1
    }
  fi

  # Detect stat command type
  if stat --version >/dev/null 2>&1; then
    # GNU stat
    local perms=$(stat -c "%a" $XDG_RUNTIME_DIR)
    local owner=$(stat -c "%u" $XDG_RUNTIME_DIR)
  else
    # BSD stat
    local perms=$(stat -f "%Lp" $XDG_RUNTIME_DIR)
    local owner=$(stat -f "%u" $XDG_RUNTIME_DIR)
  fi

  if [[ $perms != "700" ]]; then
    echo "Fixing '$XDG_RUNTIME_DIR' permissions: must be '700' instead of '$perms'.."
    chmod 700 $XDG_RUNTIME_DIR || {
      echo "Failed to set permissions '700' to '$XDG_RUNTIME_DIR'.."
      return 1
    }
  fi

  if [[ $owner != $UID ]]; then
    echo "Fixing '$XDG_RUNTIME_DIR' ownership: must be '$UID' instead of '$owner'.."
    sudo chown $USER $XDG_RUNTIME_DIR || {
      echo "Failed to change ownership of '$XDG_RUNTIME_DIR'.."
      return 1
    }
  fi

  # Verify final state
  if [[ -d $XDG_RUNTIME_DIR ]]; then
    if stat --version >/dev/null 2>&1; then
      # GNU stat
      [[ $(stat -c "%a" $XDG_RUNTIME_DIR) == "700" ]] &&
        [[ $(stat -c "%u" $XDG_RUNTIME_DIR) == $UID ]] &&
        return 0
    else
      # BSD stat
      [[ $(stat -f "%Lp" $XDG_RUNTIME_DIR) == "700" ]] &&
        [[ $(stat -f "%u" $XDG_RUNTIME_DIR) == $UID ]] &&
        return 0
    fi
  fi

  echo "Failed to properly configure XDG_RUNTIME_DIR"
  return 1
}
# Setup XDG directories
setup_xdg_directories() {
  if [ -z "$XDG_CONFIG_HOME" ]; then
    if [ -f "$HOME/.config/user-dirs.dirs" ]; then
      # Source user-dirs.dirs to get XDG paths
      source "$HOME/.config/user-dirs.dirs"
    else
      # Fallback to default XDG paths
      export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
      export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
      export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
      export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
      export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/runtime-$USER}"
      if [[ -z "$XDG_RUNTIME_DIR" || "$XDG_RUNTIME_DIR" =~ ^[[:space:]]*$ ]]; then
        export XDG_RUNTIME_DIR="/tmp/runtime-$USER"
      fi

      # XDG User directories
      export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-$HOME/Desktop}"
      export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-$HOME/Downloads}"
      export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-$HOME/Documents}"
      export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-$HOME/Music}"
      export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-$HOME/Pictures}"
      export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-$HOME/Movies}"
      export XDG_PROJECTS_DIR="${XDG_PROJECTS_DIR:-$HOME/Projects}"
      export XDG_WORKSPACE_DIR="${XDG_WORKSPACE_DIR:-$HOME/Work}"

      # Create directories if they don't exist
      mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME" "$XDG_DESKTOP_DIR" "$XDG_DOWNLOAD_DIR" "$XDG_DOCUMENTS_DIR" "$XDG_MUSIC_DIR" "$XDG_PICTURES_DIR" "$XDG_VIDEOS_DIR" "$XDG_PROJECTS_DIR" "$XDG_WORKSPACE_DIR"
    fi
  fi
  ensure_xdg_runtime_perm_and_owner
}
# }
setup_xdg_directories

# ZSH DEFAULTS
export ZSH_VERSION="5.9" # zsh --version | cut -d ' ' -f2
export ZDOTDIR="${ZDOTDIR:="$HOME/.config/zsh"}"
export ZIM_HOME="${ZIM_HOME:="$HOME/.local/state/zim"}"
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:="$HOME/.cache/zsh"}"
export SHELL="$(which zsh)"

# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
  export MAILCHECK="30"
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
# Then load .zprofile for zsh-specific login settings
[[ -e "$ZDOTDIR/.zprofile" ]] && source "$ZDOTDIR/.zprofile"
