# NixOS Dotfiles

Configuration files for Jesse B. Miller's NixOS systems.

## Keyboard Shortcuts

### XMonad

- **Super + P** - Launch Ulauncher
- **Super + U** - Switch to login greeter
- **Super + Shift + Enter** - Launch terminal (Alacritty)
- **Super + Shift + C** - Close window
- **Super + Space** - Change layout
- **Super + J/K** - Navigate between windows
- **Super + H/L** - Resize master area
- **Super + Tab** - Focus next window
- **Super + Shift + J/K** - Swap windows
- **Super + [1-9]** - Switch to workspace
- **Super + Shift + [1-9]** - Move window to workspace

### Alacritty + tmux + neovim

#### tmux

- **Ctrl + B, C** - Create new window
- **Ctrl + B, ,** - Rename window
- **Ctrl + B, W** - List windows
- **Ctrl + B, N/P** - Next/previous window
- **Ctrl + B, %** - Split pane vertically
- **Ctrl + B, "** - Split pane horizontally
- **Ctrl + B, arrow keys** - Navigate panes
- **Ctrl + B, D** - Detach session
- **Ctrl + B, [** - Enter copy mode (vim navigation)

#### neovim

- **i** - Enter insert mode
- **Esc** - Return to normal mode
- **:w** - Save file
- **:q** - Quit
- **:wq** - Save and quit
- **h/j/k/l** - Move cursor left/down/up/right
- **dd** - Delete line
- **yy** - Yank (copy) line
- **p** - Paste
- **/pattern** - Search for pattern
- **n** - Next search result

## Writer-specific settings (neovim)

- **:Goyo** - Distraction-free writing mode
- **:Limelight** - Focus on current paragraph

## Overview

This repository contains NixOS and Home Manager configurations with:

- Multiple user profiles (jesse, writer, engineer, admin)
- XMonad window manager setup
- Common development tools and applications
- Consistent fonts and theming

## Quick Start

```bash
# Clone the repository
git clone https://github.com/jessebmiller/dotfiles.git
cd dotfiles

# Apply configuration (replace existing one)
sudo nixos-rebuild switch --impure --flake .
```

## Common Commands

### System Management

```bash
# Apply configuration changes
sudo nixos-rebuild switch --impure --flake .

# Update all packages to latest versions
nix flake update

# Clean up old generations
sudo nix-collect-garbage -d

# List boot generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Boot to a specific generation (e.g., 123)
sudo nix-env --profile /nix/var/nix/profiles/system --switch-generation 123
```

### User Management

```bash
# Set/change password for a user
passwd username

# Generate a password hash for user configuration
mkpasswd -m sha-512

# Add a new user (manually edit configuration)
# 1. Create a new file youruser.nix based on an existing user file
# 2. Import it in configuration.nix
# 3. Run nixos-rebuild

# Switch to another user
su - username
```

### Packages

```bash
# Search for packages
nix search nixpkgs package-name

# Install package temporarily (for current user)
nix shell nixpkgs#package-name

# List installed packages
nix-env -q
```

### Troubleshooting

```bash
# Check NixOS and Nixpkgs version
nixos-version

# View system logs
journalctl -xef

# Check memory usage
free -h

# Check disk usage
df -h

# Test configuration before applying
sudo nixos-rebuild test --impure --flake .
```

## Custom Configuration

### Adding a New User

1. Create a new user file (e.g., `newuser.nix`) using an existing one as a template:

```nix
{ config, pkgs, ... }: {
  users.users.newuser = {
    isNormalUser = true;
    description = "New User";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    hashedPassword = "$6$...your-hashed-password-here...";
  };

  home-manager.users.newuser = {pkgs, ... }: {
    home.packages = with pkgs; [
      # Add user-specific packages here
    ];
    
    home.stateVersion = "24.11";
  };
}
```

2. Import the new file in `configuration.nix`:

```nix
imports = [
  ./hardware-configuration.nix
  ./jesse.nix
  ./engineer.nix
  ./admin.nix
  ./newuser.nix  # Add this line
];
```

### Setting a Shared Password

1. Generate a password hash:

```bash
mkpasswd -m sha-512
```

2. Add the hash to each user definition file:

```nix
users.users.username = {
  # ...other config
  hashedPassword = "$6$...your-hashed-password-here...";
};
```

### Add a New System

To add a new system configuration:

1. Edit `flake.nix` to add a new system configuration:

```nix
nixosConfigurations = {
  laptop = lib.nixosSystem { /* existing config */ };
  
  desktop = lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./configuration.nix
      ./common.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
};
```

2. Create a new `configuration.nix` if needed or use hostname-specific settings.

## Useful Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Package Search](https://search.nixos.org/packages)
- [NixOS Options Search](https://search.nixos.org/options)

