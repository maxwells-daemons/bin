#!/bin/zsh
# Update all system packages, python tools, and vim plugins

echo "Updating system packages..."
yay -Syu
echo

echo "Updating Python packages in tools environment..."
pipupgrade --self -y
pipupgrade -y

echo "Updating nvim plugins..."
nvim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'qa!'
echo

echo "Updating zsh plugins..."
source $HOME/.config/shells/zsh/.zshrc
omz update
antigen update
antigen cleanup --force

echo "Done!"
