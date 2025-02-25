# dotfiles

The configurations for Jesse B. Miller's systems

# Usage

1. Install NixOS (or maybe it'll work with just the package manager?)
2. Set the hostname to the system you want (see ./flake.nix)
3. `sudo nixos-rebuild switch --impure --flake .`
