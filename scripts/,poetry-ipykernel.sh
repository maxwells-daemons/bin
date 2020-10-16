#!/bin/sh
# Add an IPython kernel for a given Poetry virtualenv
if [ -z $1 ]; then
	echo "Provide a kernel name"
else
	poetry add --dev jupyter ipython ipykernel
	poetry run ipython kernel install --user --name=$1
fi
