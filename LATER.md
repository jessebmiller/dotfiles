# LATER

Real work, not urgent. Pick up after both machines are stable and running.

---

## Dotfiles Completeness

- [x] i3 config stow package (done)
- [ ] Alacritty config — clean up dirty alacritty.toml, remove .bak file
- [ ] Key mappings — document and automate

## System Inventory

- [ ] RPM package manifest — explicit list of what's installed and why
- [ ] DNF repos config tracked in dotfiles (currently manual)
- [ ] Custom toolchains (Go, Rust, etc.) fully automated in install.sh

## Setup Automation

- [ ] Clone active repos — script to set up dev environment after fresh install
- [ ] Backup home folder — identify what needs backing up, set up process

## Tools

- [ ] 1Password local install — add RPM repo + install to install.sh; enables SSH agent integration, biometric unlock, and `op` CLI for secret access

## Maintenance

- [ ] Laptop kernel pinning — document known-good kernel version, set up workflow for testing upgrades
- [ ] Health monitoring — disk space, services, performance
