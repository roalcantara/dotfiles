#!/usr/bin/env zsh

# shellcheck disable=SC1090,SC1091,SC2086,SC2155

# ~/.zshenv
# Sourced on all invocations of the shell - unless the -f option is set
# Contains commands and set variables that should be available to other programs
# http://zsh.sourceforge.net/Intro/intro_3.html

setopt NO_GLOBAL_RCS   # Prevents loading of global rc files like /etc/zprofile
skip_global_compinit=1 # Skip sourcing global compinit

# profilling:
#   z_prof=1 "$SHELL" -ilc exit
#   z_prof=1; for _ in $(seq 1 10); do /usr/bin/time "${SHELL}" -ilc exit; done
# tracing
#   z_prof=1 z_trace=1 "$SHELL" -ilc exit
#   z_prof=1 z_trace=1 "$SHELL" -ilc exit
[ -n "$z_prof" ] && zmodload zsh/zprof
if [[ -n "$z_trace" ]]; then
  # Set a timestamp and script location in PS4 for better trace readability
  PS4=$'%D{%H:%M:%S} ${(%):-%N:%i}> ' # Adds timestamp, filename, and line number
  # Set logging output to a dedicated log file with a unique session ID
  exec 3>&2 2>>$HOME/.config/zsh/tmp/benchmark.$$.start.log
  setopt xtrace prompt_subst
fi

## INTERNATIONALISATION VARIABLES
# The values that the environment variables may be assigned are not restricted; 
# Except that they are considered to end with a null byte and the total space used to store the environment and the arguments to the process is limited to {ARG_MAX} bytes.
# It is unwise to conflict with certain variables that are frequently exported by widely used command interpreters and applications.
# https://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html

# LC_ALL | DEFAULT LOCALE FOR THE SHELL
# Determines the values for all locale categories. 
# Has precedence over of some environment variable such as LANG, and any of the others starting with LC_*
export LC_ALL=en_US.UTF-8

# LANG | DEFAULT LANGUAGE FOR THE SHELL
# Determines the locale category for native language, local customs and coded character set in the absence of the LC_ALL or any other LC_* environment variables. 
# Can be used by applications to determine the language to use for error messages and instructions, collating sequences, date formats, and so forth.
export LANG=en_US.UTF-8

# LC_CTYPE | DEFAULT LOCALE FOR CHARACTER CLASSIFICATION AND CASE CONVERSION
# Determines the locale category for character classification and case conversion, handling functions such as tolower(), toupper() and isalpha(). 
# Determines the interpretation of: 
#  - the sequences of bytes of text data as characters (for example, single- as opposed to multi-byte characters)
#  - the classification of characters (for example, alpha, digit, graph)
#  - the behaviour of character classes
# Additional semantics of this variable, if any, are implementation-dependent.
# Also prevents problems on some Unix systems' (neo)vim instances with characters with values above 128 (https://neovim.io/doc/user/digraph.html#digraphs-use)
export LC_CTYPE=en_US.UTF-8

# LC_COLLATE | DEFAULT LOCALE FOR CHARACTER COLLATION
# Determines collation information for regular expressions, sorting, equivalence classes, multi-character collating elements in various utilities and some functions - such as strcoll() and strxfrm().
# Additional semantics of this variable, if any, are implementation-dependent.
# Most technical people probably want C collation for sane results (https://wezfurlong.org/wezterm/faq.html#lang-and-locale)
export LC_COLLATE=C

# Directory stack size
export DIRSTACKSIZE=100

# Pager settings
export PAGER='less -FREXi'
export BROWSER='open'
export MANROFFOPT='-c'

ensure_xdg_runtime_perm_and_owner() {
  if [[ ! -d $XDG_RUNTIME_DIR ]]; then
    mkdir -p $XDG_RUNTIME_DIR || {
      echo "Failed to create directory '$XDG_RUNTIME_DIR'"
      return 1
    }
  fi

  local perms=$(stat -f "%Lp" $XDG_RUNTIME_DIR)
  if [[ $perms != "700" ]]; then
    echo "Fixing '$XDG_RUNTIME_DIR' permissions: must be '700' instead of '$perms'.."
    chmod 700 $XDG_RUNTIME_DIR || {
      echo "Failed to set permissions '700' to '$XDG_RUNTIME_DIR'.."
      return 1
    }
  fi

  local owner=$(stat -f "%u" $XDG_RUNTIME_DIR)
  if [[ $owner != $UID ]]; then
    echo "Fixing '$XDG_RUNTIME_DIR' ownership: must be '$UID' instead of '$owner'.."
    sudo chown $USER $XDG_RUNTIME_DIR || {
      echo "Failed to change ownership of '$XDG_RUNTIME_DIR'.."
      return 1
    }
  fi

  if [[ -d $XDG_RUNTIME_DIR ]] &&
    [[ $(stat -f "%Lp" $XDG_RUNTIME_DIR) == "700" ]] &&
    [[ $(stat -f "%u" $XDG_RUNTIME_DIR) == $UID ]]; then
    return 0
  else
    echo "Failed to properly configure XDG_RUNTIME_DIR"
    return 1
  fi
}

# XDG DIRECTORIES {
# Determines where user-specific configurations should be written
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
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
# }

# ZSH defaults
export ZSH_VERSION="5.9" # zsh --version | cut -d ' ' -f2
if [[ -f "$XDG_CONFIG_HOME/zsh/etc/init.zsh" ]]; then
  source "$XDG_CONFIG_HOME/zsh/etc/init.zsh"
fi

# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
  export MAILCHECK="30"
fi
