#!/bin/bash

# install.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles/files

# dotfiles directory
dir=~/dotfiles/files

# old dotfiles backup directory
olddir=~/.dotbackups

# list of files/folders to symlink in homedir
files=".zshrc .oh-my-zsh .emacs.d"

# create olddir in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks
for file in $files; do

    if [ -f ~/.$file ]
    then
        echo "Moving .$file from ~ to $olddir"
        mv ~/.$file $olddir
    fi

    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
