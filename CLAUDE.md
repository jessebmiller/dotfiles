# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for a Fedora Linux + Sway (Wayland) desktop setup. Configuration is managed via GNU Stow, which symlinks config files from `stow-packages/` into `$HOME`.

## Applying Configurations

To deploy a stow package (e.g., after editing configs):

```sh
stow --dotfiles -d stow-packages -t $HOME nvim
stow --dotfiles -d stow-packages -t $HOME alacritty
stow --dotfiles -d stow-packages -t $HOME sway
```

The `--dotfiles` flag causes stow to rename `dot-` prefixed files/directories with a `.` on deployment (e.g., `dot-config/` → `.config/`).

## Repository Structure

- `stow-packages/` — One subdirectory per tool, each mirroring the target `$HOME` structure
- `packages/` — Standalone installation scripts for individual tools
- `install.sh` — Full system provisioning script (Fedora-specific, DNF-based)
- `configure-snapper.sh` — Btrfs snapshot setup via snapper

## Stow Package Conventions

Each package under `stow-packages/<name>/` contains a directory tree using `dot-` prefixes for hidden files/dirs:
- `dot-config/<tool>/` → deploys to `~/.config/<tool>/`

When adding a new stow package, follow this naming convention and run stow to symlink it.

## System Context

- **OS**: Fedora Linux
- **Desktop**: Sway (Wayland WM)
- **Terminal**: Alacritty
- **Editor**: Neovim (Lua config at `stow-packages/nvim/dot-config/nvim/init.lua`)
- **Package manager**: DNF + Flatpak + Cargo (for Rust-based tools like Alacritty, mdbook)
- **Snapshots**: Btrfs + snapper with timeline cleanup

## Tool Selection Philosophy

From README.md — prefer tools that are: focused/single-purpose, reliable, composable, long-lived, low cognitive overhead, vendor-neutral, and degrade gracefully. See the full rubric in `README.md`.
