# NOW

Immediate work — blocking daily productivity. Complete in order.

---

## 1. WM Reevaluation (blocks everything desktop)

Choose an X11 tiling WM to replace Sway on the NVIDIA desktop.

**Requirements** (non-negotiable):
- X11 (Wayland incompatible with NVIDIA)
- Tiling
- Chromeless — no persistent bar, clock, tray
- System dashboard on keybinding (rofi handles this)
- Full-screen apps on virtual desktops, keyboard-driven

**Decision**: i3. Explicit layout control, low cognitive overhead, self-contained config, massive ecosystem.

---

## 2. Software Audit

Before modifying install.sh, verify the software list reflects actual current needs.

- [x] Confirm browser: Brave (stays)
- [x] Confirm terminal: Alacritty (stays)
- [x] Confirm editor: Neovim (stays)
- [x] Confirm WM: i3 (Fedora i3 Spin — WM + display manager handled by spin)
- [x] Confirm display manager: handled by Fedora i3 Spin
- [x] Language toolchains: Rust only (for alacritty, mdbook)
- [x] Filesystem: ext4 on both machines — no Btrfs, no Snapper
- [x] Review install.sh for anything obsolete or missing beyond what's already known
- [x] Note any tools added manually since last install (nothing critical — handle in LATER)

**Known changes for install.sh**:
- Remove: Sway stow, snapper, configure-snapper.sh
- Add: rofi
- Replace: `stow sway` → `stow i3` (once i3 config exists)

---

## 3. Clean Up install.sh

Revise install.sh to reflect decisions from steps 1 and 2.

- [x] Remove snapper and configure-snapper.sh call
- [x] Remove Sway stow, add i3 stow (commented out — uncomment once i3 config exists)
- [x] Add rofi to DNF packages
- [x] Add SSH key generation + print public key for GitHub
- [x] Add `pull.rebase` to git config
- [x] Remove anything else no longer needed
- [x] Make it idempotent enough to re-run safely

---

## 4. Desktop Reinstall

Fresh Fedora install on desktop. Base: **Fedora i3 Spin ISO**.

**Pre-install decisions**:
- Filesystem: ext4
- WM: i3 (included in spin)

**Steps**:
- [x] Install from Fedora i3 Spin ISO
- [x] Run install.sh
- [x] Stow dotfiles: nvim, alacritty, i3
- [x] Verify NVIDIA drivers installed and X11 working (akmod-nvidia, RTX 3060 Ti confirmed)
- [ ] **Manual**: Install 1Password browser extension in Brave
- [ ] **Manual**: Set Brave default search engine
- [ ] **Manual**: Log in to cloud services (GitHub, Google, etc.)
- [ ] **Manual**: Add SSH key to GitHub

---

## 5. Laptop Reinstall

Fresh Fedora install on MacBook Air A1466. Base: **Fedora i3 Spin ISO**.

**Pre-install decisions**:
- Filesystem: ext4
- WM: i3 (included in spin)
- WiFi: need USB tether or USB ethernet for initial setup (no ethernet port)

**Steps**:
- [ ] Get internet via USB tethering to phone
- [ ] Install from Fedora i3 Spin ISO
- [ ] Run install.sh
- [ ] Install Broadcom WiFi driver (see REFERENCE.md → Broadcom BCM4360 WiFi)
- [ ] Document working kernel version (pin if needed)
- [ ] Stow dotfiles: nvim, alacritty, i3
- [ ] **Manual**: Install 1Password browser extension in Brave
- [ ] **Manual**: Set Brave default search engine
- [ ] **Manual**: Log in to cloud services
- [ ] **Manual**: Add SSH key to GitHub

---

## 6. Post-Reinstall Verification

- [ ] Both machines: WiFi stable, WM working, editor working
- [ ] Desktop: NVIDIA GPU performing normally under load
- [ ] Laptop: No swap thrashing during normal use
- [ ] SSH access working
