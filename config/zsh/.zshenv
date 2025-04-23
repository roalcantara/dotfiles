#!/usr/bin/env zsh

# shellcheck disable=SC1090,SC1091,SC2086,SC2155

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
