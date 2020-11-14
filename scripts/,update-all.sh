#!/bin/zsh
# Update all system packages, python tools, and vim plugins

echo "Updating system packages..."
yay -Syu
echo

echo "Updating Python packages in tools environment..."
PYTHON_TOOLS_PIP="${XDG_DATA_HOME}/pyenv/versions/tools/bin/python -m pip"
PYTHON_TOOLS_OUTDATED=$($PYTHON_TOOLS_PIP list --outdated --format freeze | sed 's/==/>=/')
$PYTHON_TOOLS_PIP install --upgrade pip
if [ ! -z $PYTHON_TOOLS_OUTDATED ]; then
    $PYTHON_TOOLS_PIP install --upgrade $PYTHON_TOOLS_OUTDATED
fi
echo

echo "Updating nvim plugins..."
nvim -c 'PlugUpgrade' -c 'PlugUpdate' -c 'qa!'
echo

echo "Updating zsh plugins..."
source $HOME/.config/shells/zsh/.zshrc
omz update
antigen update
antigen cleanup --force

echo "Done!"
