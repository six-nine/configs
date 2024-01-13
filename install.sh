#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "Script path is $SCRIPTPATH"

echo "===+ ZSH +=="
ln -nsf "$SCRIPTPATH/zsh/.zshrc" ~/.zshrc
touch ~/.zshaddons
echo "ZSH configured. Please write computer-specific configs to ~/.zshaddons, common configs - to ~/.zshrc"

echo "===+ NVIM +=="
rm -rf ~/.config/nvim
ln -nsf "$SCRIPTPATH/nvim" ~/.config/
echo "nvim configured."

echo "===+ TMUX +=="
ln -nsf "$SCRIPTPATH/tmux/.tmux.conf" ~/.tmux.conf
echo "tmux configured."
