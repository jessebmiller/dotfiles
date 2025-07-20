# NixOS Improvement Ideas

This file tracks potential future enhancements for the NixOS setup.

*   Create a "self-service" model where users can modify their own environment (e.g., add packages, update Neovim settings) and rebuild the system without switching to an admin account. This would involve decoupling `home-manager` configs into user-owned files and granting limited `sudo` access for `nixos-rebuild`.
