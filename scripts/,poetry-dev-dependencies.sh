#!/bin/sh
# Install dev dependencies for a Poetry project
poetry add --dev --allow-prereleases \
    python-language-server \
    flake8 \
    mypy \
    black \
    isort \
    neovim \
    pynvim
