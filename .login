# shellcheck shell=bash disable=SC1094,SC2139,SC2046,SC1090,SC2154,SC2155,SC2206,SC2012,SC1083,SC1091
# ~/.login
#
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists
# https://linux.die.net/sag/shell-startup.html
#
# Contains login specific initialization

# CUSTOM DIRS {{
if [ -n "$XDG_USER_DIRS" ] && [ -r "$XDG_USER_DIRS" ]; then
  set -o allexport
  source "$XDG_USER_DIRS"
  set +o allexport
fi
# }}

# DIRCOLORS {
# enable color support of ls and also add handy aliases
if type dircolors >/dev/null; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  fi
fi
# }
