#!/bin/bash

cd ~/dotfiles/

if [ $# -ne 1 ]
  then
    echo "1 argument expected"
    exit 22
  elif [ $1 = "install" ] ; then
    echo "Installing dotfiles...."
    ls -d -- */ | xargs -I {} stow -vt ~ {}
    stow -v --dir=/home/asaday/dotfiles --target=/home/asaday/
    exit 0
  elif [ $1 = "uninstall" ] ; then
    echo "Uninstalling dotfiles...."
    ls -d -- */ | xargs -I {} stow -Dvt ~ {}
    stow -Dv --dir=/home/asaday/dotfiles --target=/home/asaday/
    exit 0
  else
    echo "Wrong argument, install or uninstall expected"
    exit 22
fi


