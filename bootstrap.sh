#!/bin/bash
# Bootstrap a fresh Fedora install.
# Usage: curl -fsSL <raw URL of this file> | sh

set -e

DOTFILES="$HOME/work/dotfiles"
REPO="https://github.com/jessebmiller/dotfiles.git"

# git
if ! command -v git &>/dev/null; then
    sudo dnf install -y git
fi

# clone
if [ ! -d "$DOTFILES" ]; then
    mkdir -p "$HOME/work"
    git clone "$REPO" "$DOTFILES"
fi

bash "$DOTFILES/install.sh"
