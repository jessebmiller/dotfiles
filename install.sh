#!/bin/bash

set -e

# RPM Fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

# for brave
sudo dnf install dnf-plugins-core
sudo dnf config-manager addrepo --overwrite --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# For alacritty
sudo dnf install -y cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++

# Directly installed packages
sudo dnf install -y \
  snapper \
  stow \
  neovim python3-neovim\
  git \
  brave-browser

git config --global user.email "jesse@jessebmiller.com"
git config --global user.name "Jesse B. Miller"

sudo ./configure-snapper.sh


# Install or update rustup
if ! command -v rustup &> /dev/null; then
  echo "Installing Rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "Updating Rustup"
  rustup update
fi

. "$HOME/.cargo/env"

# Install Alacritty
cargo install alacritty


# Stow dotfiles
stow --dotfiles -d stow-packages -t $HOME nvim
stow --dotfiles -d stow-packages -t $HOME alacritty
stow --dotfiles -d stow-packages -t $HOME sway
