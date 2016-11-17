#!/bin/sh

# Using pure sh for greatest compatibility
# A script meant to be run right after cloning the repository
# It initializes the submodules in vim/bundle
# It's an early version, just to set up a foothold

echo "Initializing the repository..."
git submodule init

echo -e "\nPopulating submodules..."
git submodule update

echo "Done!"
