#!/bin/sh
# Add an IPython kernel for a given Poetry virtualenv
poetry add --dev jupyter ipython ipykernel
poetry run ipython kernel install --user --name=$1
