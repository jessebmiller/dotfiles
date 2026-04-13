#!/bin/bash

# desktop uuid 5a94f7f3-d3e4-82df-11ee-04421ae78b7b /sys/class/dmi/id/product_uuid
# laptop uuid  6a1a3f4f-3c9a-5870-9c54-93faea5bbc64 /sys/class/dmi/id/product_uuid

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
  xclip \
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
  echo ""
  echo "SSH public key — opening GitHub and copying key to clipboard..."
  xclip -selection clipboard < "$HOME/.ssh/id_ed25519.pub" && echo "Key copied to clipboard." || echo "xclip failed — copy the key below manually:"
  cat "$HOME/.ssh/id_ed25519.pub"
  xdg-open "https://github.com/settings/ssh/new" 2>/dev/null || echo "Open https://github.com/settings/ssh/new in your browser."
  echo ""
  read -rp "Press Enter once the key is added to GitHub..." < /dev/tty
  git -C "$HOME/work/dotfiles" remote set-url origin git@github.com:jessebmiller/dotfiles.git
  echo "Remote switched to SSH."
  echo ""
fi

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

npm config set prefix "$HOME/.local"
if ! command -v claude &>/dev/null; then
  npm install -g @anthropic-ai/claude-code
fi

# Stow dotfiles
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
cd "$DOTFILES_DIR"

# Remove default configs installed by the spin that would block stow
rm -f "$HOME/.config/i3/config"

echo "Stowing nvim..."
stow --dotfiles --restow -d stow-packages -t "$HOME" nvim
echo "Stowing alacritty..."
stow --dotfiles --restow -d stow-packages -t "$HOME" alacritty
echo "Stowing i3..."
stow --dotfiles --restow -d stow-packages -t "$HOME" i3
echo "Dotfiles stowed."

# Machine-specific config
DESKTOP_UUID="5a94f7f3-d3e4-82df-11ee-04421ae78b7b"
LAPTOP_UUID="6a1a3f4f-3c9a-5870-9c54-93faea5bbc64"

THIS_UUID="$(sudo cat /sys/class/dmi/id/product_uuid 2>/dev/null || true)"

echo "Machine UUID: $THIS_UUID"

if [ "$THIS_UUID" = "$DESKTOP_UUID" ]; then
    echo "Detected: desktop — installing NVIDIA drivers..."
    # NVIDIA drivers for RTX 3060 Ti
    # RPM Fusion non-free must be configured (done above)
    # Requires Secure Boot disabled — driver module won't load if SB is on
    sudo dnf update -y  # avoid kernel/driver version mismatch
    if ! rpm -q akmod-nvidia &>/dev/null; then
        sudo dnf install -y akmod-nvidia
    fi
    if ! modinfo -F version nvidia &>/dev/null; then
        echo ""
        echo "NVIDIA: waiting for module to compile..."
        while ! ls /var/cache/akmods/nvidia/kmod-nvidia-"$(uname -r)"-*.rpm &>/dev/null; do
            sleep 10
        done
        echo "NVIDIA module ready. Reboot to load the driver: sudo reboot"
        echo ""
    fi
fi

if [ "$THIS_UUID" = "$LAPTOP_UUID" ]; then
    echo "Detected: laptop — installing Broadcom drivers..."
    # Broadcom wireless — requires RPM Fusion non-free (configured above)
    sudo dnf update -y  # avoid kernel/driver version mismatch
    if ! rpm -q akmod-wl &>/dev/null; then
        sudo dnf install -y akmod-wl
    fi
    if ! modinfo -F version wl &>/dev/null; then
        echo ""
        echo "Broadcom: waiting for module to compile..."
        while ! ls /var/cache/akmods/wl/kmod-wl-"$(uname -r)"-*.rpm &>/dev/null; do
            sleep 10
        done
        echo "Broadcom module ready. Reboot to load the driver: sudo reboot"
        echo ""
    fi
fi
