#!/bin/bash

# Installation script, early version
# Should be able to do OS discovery, selective installation etc.
# For now it just links things around

# Backup a file by appending a .bak suffix to it
function backup {
    echo "Backing up $1"
    if [ -e "${1}.bak" ]; then      # Make sure not to overwrite anything
        echo "Backup of $1 already exists: $(pwd)/${1}.bak"
        echo "Check it manually"
        echo "Aborting"
        exit 1
    else
        mv -T "${1}" "${1}.bak"     # Change file name
        echo "Backup of $1 completed as: $(pwd)/${1}.bak"
    fi

    return
}

dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # Get dotfiles path
# BASH_SOURCE[0] returns relative path to this script (works well as long as
# it's not a link). Dirname strips the file name from the path. Then we cd into
# it, print and assign.
echo "Dotfiles repo set to $dotfiles_dir"
echo

cd "$HOME" # Will be working on home directory

##### Vim section
# .vim directory
if [ -d .vim ]; then
    backup .vim
fi

ln -s ${dotfiles_dir}/vim .vim
if [ $? = 0 ]; then     # Make sure ln was successful
    echo "Linked .vim to ${dotfiles_dir}/vim"
    echo
else
    echo "Error while linking .vim to ${dotfiles_dir}/vim"
    exit 1
fi

# .vimrc config file
if [ -f .vimrc ]; then
    backup .vimrc
fi

echo "runtime vimrc" > .vimrc       # Just run vimrc version from dotfiles
if [ $? = 0 ]; then                 # Make sure .vimrc was created
    echo "Set up the .vimrc file"
    echo
else
    echo "Error while setting up .vimrc"
    exit 1
fi

##### Fish section
# config.fish
if [ -f .config/fish/config.fish ]; then
    backup .config/fish/config.fish
fi

mkdir -p .config/fish               # Make sure parent directories exist
ln -s ${dotfiles_dir}/fish/config.fish .config/fish/config.fish
if [ $? = 0 ]; then                 # Make sure ln was successful
    echo "Linked .config/fish/config.fish to ${dotfiles_dir}/fish/config.fish"
    echo
else
    echo "Error while linking .config/fish/config.fish to ${dotfiles_dir}/fish/config.fish"
    exit 1
fi
