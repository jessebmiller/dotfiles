#!/bin/bash

# desktop uuid 5a94f7f3-d3e4-82df-11ee-04421ae78b7b /sys/class/dmi/id/product_serial

set -e

# RPM Fusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Brave browser repo
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --overwrite --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Build deps for alacritty (installed via cargo)
sudo dnf install -y cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++

# Packages
sudo dnf install -y \
  stow \
  neovim python3-neovim \
  git \
  rofi \
  brave-browser \
  discord \
  steam \
  nodejs npm

# Git global config
git config --global user.email "jesse@jessebmiller.com"
git config --global user.name "Jesse B. Miller"
git config --global pull.rebase true

# SSH key
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  ssh-keygen -t ed25519 -C "jesse@jessebmiller.com" -f "$HOME/.ssh/id_ed25519" -N ""
fi
echo "SSH public key (add to GitHub if not already done):"
cat "$HOME/.ssh/id_ed25519.pub"

# Rust toolchain
if ! command -v rustup &> /dev/null; then
  echo "Installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "Updating rustup"
  rustup update
fi

. "$HOME/.cargo/env"

cargo install alacritty
cargo install mdbook

npm install -g @anthropic-ai/claude-code

# Stow dotfiles
stow --dotfiles --restow -d stow-packages -t "$HOME" nvim
stow --dotfiles --restow -d stow-packages -t "$HOME" alacritty
stow --dotfiles --restow -d stow-packages -t "$HOME" i3
