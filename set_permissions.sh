#!/usr/bin/env bash

# This script sets the necessary file permissions to allow each user
# to edit their own NixOS configuration file.

echo "Setting file permissions..."

sudo setfacl -m u:admin:rw /home/admin/dotfiles/admin.nix
sudo setfacl -m u:engineer:rw /home/admin/dotfiles/engineer.nix
sudo setfacl -m u:games:rw /home/admin/dotfiles/games.nix
sudo setfacl -m u:jesse:rw /home/admin/dotfiles/jesse.nix
sudo setfacl -m u:writer:rw /home/admin/dotfiles/writer.nix

echo "Permissions set successfully."
