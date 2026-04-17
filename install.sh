

# desktop uuid 5a94f7f3-d3e4-82df-11ee-04421ae78b7b /sys/class/dmi/id/product_uuid
# laptop uuid  6a1a3f4f-3c9a-5870-9c54-93faea5bbc64 /sys/class/dmi/id/product_uuid

set -e

# Btrfs snapshot before making any changes (requires snapper with a "root" config)
if command -v snapper &>/dev/null && sudo snapper -c root list &>/dev/null 2>&1; then
    echo "Taking pre-install Btrfs snapshot..."
    SNAP_NUM=$(sudo snapper -c root create \
        --type pre \
        --cleanup-algorithm number \
        --print-number \
        --description "pre install.sh $(date -Iseconds)")
    echo "Snapshot #$SNAP_NUM created."
    echo "Cleaning up old snapshots..."
    sudo snapper -c root cleanup number
    echo "Snapshot cleanup done."
else
    echo "Snapper not configured — skipping pre-install snapshot (safe to ignore on first run)."
fi

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
  snapper \
  neovim python3-neovim \
  git \
  rofi \
  xclip \
  brightnessctl \
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

# Snapper config — create-config sets up the .snapshots subvolume, then we
# overwrite the generated config with our customized version
if ! sudo snapper list-configs | grep -q '^root'; then
    echo "Creating snapper root config..."
    sudo snapper -c root create-config /
fi
echo "Installing snapper config..."
sudo cp "$DOTFILES_DIR/config/snapper-root" /etc/snapper/configs/root

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
        while ! ls /var/cache/akmods/nvidia/kmod-nvidia-*.rpm &>/dev/null; do
            sleep 10
        done
        echo "NVIDIA module ready. Reboot to load the driver: sudo reboot"
        echo ""
    fi

    # Satisfactory Mod Manager — always fetches latest release from GitHub
    mkdir -p "$HOME/.local/bin"
    SMM_URL=$(curl -s https://api.github.com/repos/satisfactorymodding/SatisfactoryModManager/releases/latest \
        | python3 -c "import sys,json; assets=json.load(sys.stdin)['assets']; \
          print(next(a['browser_download_url'] for a in assets if a['name'].endswith('linux_amd64.AppImage')))")
    curl -L "$SMM_URL" -o "$HOME/.local/bin/SatisfactoryModManager"
    chmod +x "$HOME/.local/bin/SatisfactoryModManager"
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
        read -rp "WiFi SSID: " WIFI_SSID < /dev/tty
        read -rsp "WiFi password: " WIFI_PASS < /dev/tty
        echo ""
        nmcli connection add type wifi con-name "$WIFI_SSID" ifname "*" ssid "$WIFI_SSID" \
            wifi-sec.key-mgmt wpa-psk wifi-sec.psk "$WIFI_PASS"
        echo "WiFi profile saved."
        echo ""
        echo "Broadcom: waiting for module to compile..."
        while ! ls /var/cache/akmods/wl/kmod-wl-*.rpm &>/dev/null; do
            sleep 10
        done
        echo "Broadcom module ready. Reboot when ready: sudo reboot"
        echo ""
    fi

    # Lid close → suspend
    sudo mkdir -p /etc/systemd/logind.conf.d
    echo -e "[Login]\nHandleLidSwitch=suspend\nHandleLidSwitchExternalPower=suspend" \
        | sudo tee /etc/systemd/logind.conf.d/lid.conf > /dev/null
    sudo systemctl restart systemd-logind

    # brightnessctl needs video group for backlight writes without sudo
    sudo usermod -aG video "$USER"
fi

cat << 'EOF'

        *         .           *        .          *
   .         *        .               .      *
          .       ____                    .
    *           /|_||_\`.__          *           .
           .   (   _    _ _\              .
         .     =`-(_)--(_)-'   MACHINE CONFIGURED
    .                                          *
             .        *            .
EOF
