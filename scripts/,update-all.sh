#!/bin/zsh
# Update all system packages, python tools, and vim plugins

echo "Updating system packages..."
yay -Syu
echo

echo "Updating Python packages in tools environment..."
TOOLS_PYTHON="${XDG_DATA_HOME}/pyenv/versions/tools/bin/python"
PYTHON_TOOLS_OUTDATED=$($TOOLS_PYTHON -m pip list --outdated --format freeze | sed 's/==/>=/')
$TOOLS_PYTHON -m pip install --upgrade pip
if [ ! -z $PYTHON_TOOLS_OUTDATED ]; then
    $TOOLS_PYTHON -m pip install --upgrade $PYTHON_TOOLS_OUTDATED
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
