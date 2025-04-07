# # ~/.zprofile
# Sourced in login shells - BEFORE `.zshrc`
# Contains commands that should be executed only in login shells
# http://zsh.sourceforge.net/Intro/intro_3.html
# shellcheck shell=bash disable=SC2155,SC1090

if [ -f ~/.profile ]; then
  . ~/.profile
fi
