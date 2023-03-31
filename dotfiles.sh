#!/usr/bin/env bash

DOTFILES_DIR="$HOME/dotfiles"
TARGET_DIR="$HOME"

# Install or uninstall dotfiles
case "$1" in
  install)
    echo "Installing dotfiles...."
    ls -d -- */ | xargs -I {} stow -d "$DOTFILES_DIR" -vt "$TARGET_DIR" {}
    ;;
  uninstall)
    echo "Uninstalling dotfiles...."
    ls -d -- */ | xargs -I {} stow -d "$DOTFILES_DIR" -Dvt "$TARGET_DIR" {}
    ;;
  *)
    echo "Wrong argument, install or uninstall expected"
    exit 1
    ;;
esac