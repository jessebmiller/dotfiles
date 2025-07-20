# NixOS Improvement Ideas

This file tracks potential future enhancements for the NixOS setup.

*   Create a "self-service" model where users can modify their own environment (e.g., add packages, update Neovim settings) and rebuild the system without switching to an admin account. This would involve decoupling `home-manager` configs into user-owned files and granting limited `sudo` access for `nixos-rebuild`.

---

### In-Mode Config Updates
*   **Hot config editing:** Add a keybinding (e.g., Super+Shift+E) that opens the current user's specific Nix configuration file in their editor.
*   **Quick-add file:** Maintain a running `needs.txt` in each home directory to quickly append needed packages or tools (`echo "package-name" >> ~/needs.txt`), which can be processed by a script later.

### Rapid Rebuild Strategies
*   **Faster feedback loops:** Use `nixos-rebuild test` instead of `switch` during experimentation for faster rollbacks and no bootloader changes.
*   **Pre-build packages:** Use `nix build nixpkgs#package-name` to build common or large packages in the background before officially adding them to the configuration.
*   **Quick-add function:** Create a shell function like `qa() { ... }` that both adds a package to a temporary config list and immediately launches it in a `nix shell`.

### Context Preservation
*   **Persistent sessions:** Use `tmux` with a session-saving plugin to ensure work persists across rebuilds.
*   **Editor state:** Configure Neovim to automatically save and restore sessions (`:mksession`).
*   **Focus notes:** Use a simple `~/current-focus.txt` file to quickly jot down the current task before a rebuild or mode switch.

### Distraction Blockers
*   **Network-level blocking:** Use `/etc/hosts` (managed by Nix) or router settings to block distracting websites during focus modes.
*   **Tool removal:** Completely remove the web browser from the `writer` mode to create high friction for web access.
*   **Minimalist aesthetics:** Use blank wallpapers, hidden UI panels, and minimal visual noise to reduce visual distraction.
*   **Audio cues:** Implement mode-specific notification sounds, or complete silence in focus modes.

### Efficiency Multipliers
*   **Transition rituals:** Create scripts or aliases that perform a sequence of setup tasks when switching modes (e.g., `start-writing` alias).
*   **Pre-configured layouts:** Define mode-specific `tmux` layouts that are launched automatically.
