#!/bin/bash

# Installation script, early version
# TODO: Add a minimal installation switch (omit some heavy-weight components)

# Backup a file by appending a .bak suffix to it
function backup {
    echo "Backing up $1"
    if [ -e "${1}.bak" -a $force = false ]; then      # Don't overwrite, unless F is set
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

function usage {
    echo "Usage: install.sh [OPTIONS]"
    echo "OPTIONS:
            -a: install everything
            -v: install vim files
            -f: install fish files
            -d DEST: install in DEST
            -F: force installation, overwrite backups"
    return
}

vim=false
fish=false
destination="$HOME" # Leave it at that to perform user-wide installation
force=false
dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # Get dotfiles path
# BASH_SOURCE[0] returns relative path to this script (works well as long as
# it's not a link). Dirname strips the file name from the path. Then we cd into
# it, print and assign.

# Command line arguments parsing
while getopts ":vfFad:" opt; do            # Use getopts parser
    case $opt in
        a)  vim=true
            fish=true
            ;;
        v)  vim=true
            ;;
        f)  fish=true
            ;;
        F)  force=true
            ;;
        d)  destination="$OPTARG"
            ;;
        \?) echo "Invalid option: -$OPTARG"
            usage
            exit 1
            ;;
        :)  echo "Option -$OPTARG requires an argument"
            usage
            exit 1
            ;;
    esac
done

cd "$destination"   # Installation directory

echo "Dotfiles repo set to $dotfiles_dir"
echo "Installation directory set to $destination"
echo

if $vim; then
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

    echo "You need to install dotfiles/vim/bundle/YouCompleteMe manually"
    echo "Act according to http://valloric.github.io/YouCompleteMe/"
fi

if $fish; then
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
fi
