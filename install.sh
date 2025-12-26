#!/bin/bash

# desktop uuid 5a94f7f3-d3e4-82df-11ee-04421ae78b7b /sys/class/dmi/id/product_serial

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
  brave-browser \
  discord \
  steam \
  flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install spotify

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

# Install cargo tools
cargo install alacritty
cargo install mdbook


# Stow dotfiles
stow --dotfiles -d stow-packages -t $HOME nvim
stow --dotfiles -d stow-packages -t $HOME alacritty
stow --dotfiles -d stow-packages -t $HOME sway
