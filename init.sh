#!/bin/sh

# Using pure sh for greatest compatibility
# A script meant to be run right after cloning the repository
# It initializes the submodules in vim/bundle
# It's an early version, just to set up a foothold

# I don't know enough about git submodule. Need to read up on it, right now it's
# sort of a magic keyword to init the submodules.
echo "Initializing the repository and populating submodules..."
git submodule update --init --recursive

echo "Done!"
echo "Now you can run install.sh"
