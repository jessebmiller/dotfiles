#! /bin/bash

# author: Jesse B Miller <jesse@jessebmiller.com>

# will install all dot files in dotfiles/files. existing versions will be moved
# to _files.backup
#
# the dotfiles folder should be placed in the users home folder


cd ~/dotfiles/files
shopt -s nullglob
for f in *
do
    echo "procesing $f"

    # if this file exists in ~/
    echo "  checking to see if ~/.$f exists"
    if [ -f ~/.$f ]
    then
        # move it to the backup folder
        echo "  moving ~/.$f to backup"
        mv ~/.$f ~/dotfiles/_files.backup
    fi

    echo "  ** linking ~/dotfiles/files/$f to ~/.$f"

    # link this file to ~/
    ln -s ~/dotfiles/files/$f ~/.$f
done
