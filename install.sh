#!/bin/bash

set -e

sudo dnf install -y \
  snapper \
  stow \
  neovim \
  python3-neovim\
  git

git config --global user.email "jesse@jessebmiller.com"
git config --global user.name "Jesse B. Miller"

sudo ./configure-snapper.sh

stow --dotfiles -d stow-packages -t $HOME nvim

