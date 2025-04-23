#!/bin/bash

# Add oh-my-zsh as a submodule if it's not there yet
if [ ! -d home/oh-my-zsh ]; then
  git submodule add https://github.com/ohmyzsh/ohmyzsh home/oh-my-zsh
fi

# Get the latest oh-my-zsh
git submodule init
git submodule update --recursive --remote

root="$(pwd)"

for file in $(ls home)
do
  source="$root/home/$file"
  target="$HOME/.$file"

  echo "Copying $source => $target"
  cp -r $source $target
done
