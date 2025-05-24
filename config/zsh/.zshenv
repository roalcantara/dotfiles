#!/usr/bin/env zsh

# ~/.zshenv
# Sourced on all invocations of the shell - unless the -f option is set
# Contains commands and set variables that should be available to other programs
# http://zsh.sourceforge.net/Intro/intro_3.html
# https://github.com/jimeh/dotfiles/blob/main/zshenv

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

# Ensure compinit is NOT loaded before Zinit loads in ~/zshrc.
skip_global_compinit=1

# ==============================================================================
# PATH Setup
# ==============================================================================

# Ensure values in path variable are unique
typeset -U path

# Prevent loading ZSH startup from files /etc on macOS. The /etc/zprofile file
# screws around with PATH, so we want to avoid it, and instead manually load the
# files we care about.
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Disable loading startup files from /etc
  unsetopt GLOBAL_RCS

  # Setup default PATH just like /etc/zprofile does
  if [ -x "/usr/libexec/path_helper" ]; then
    eval $(/usr/libexec/path_helper -s)
  fi

  # Load /etc/zshenv if it exists
  if [ -f "/etc/zshenv" ]; then
    source "/etc/zshenv"
  fi
fi

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
# }

# Load system utilities helper
source ~/.config/zsh/etc/functions/zsys

# Setup XDG variables, directories and permissions
zsys xdg setup

# ZSH DEFAULTS
export ZSH_VERSION="5.9" # zsh --version | cut -d ' ' -f2
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZIM_HOME="$XDG_STATE_HOME/zim"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export SHELL="$(which zsh)"

# Only source this once
if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
  export MAILCHECK="30"
fi

# Load .zprofile for zsh-specific login settings
zsys file source "$ZDOTDIR/.zprofile"
