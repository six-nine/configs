#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "Script path is $SCRIPTPATH"

echo "===+ Installing zsh and plugins +==="
sudo apt install zsh-autosuggestions zsh-syntax-highlighting zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

echo "===+ Installing powerlevel theme +==="
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/mafredri/zsh-async.git ${ZSH_CUSTOM}/plugins/zsh-async


sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "===+ Oh my zsh installed! +==="

echo "===+ ZSH +=="
ln -nsf "$SCRIPTPATH/zsh/.zshrc" ~/.zshrc
touch ~/.zshaddons
echo "ZSH configured. Please write computer-specific configs to ~/.zshaddons, common configs - to ~/.zshrc"

echo "===+ NVIM +=="
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim # packer
rm -rf ~/.config/nvim
ln -nsf "$SCRIPTPATH/nvim" ~/.config/
echo "nvim configured."

echo "===+ TMUX +=="
ln -nsf "$SCRIPTPATH/tmux/.tmux.conf" ~/.tmux.conf
echo "tmux configured."
