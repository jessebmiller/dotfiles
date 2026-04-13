# REFERENCE

Stable reference material for use during the reinstall process.

---

## Hardware

### Desktop
- **GPU**: RTX 3060 Ti (GeForce GA104 LHR)
- **Storage**: 1TB
- **Use cases**: Gaming, AI inference (hobby), video production (TTRPG actual plays)

### Laptop — MacBook Air A1466
- **Wireless**: Broadcom BCM4360 802.11ac
- **RAM**: ~4GB or 8GB (verify: `free -h`)
- **Storage**: ~128GB or 256GB SSD (verify: `df -h`)
- **Known issues**: Broadcom driver breaks on kernel upgrades; no ethernet port

---

## NVIDIA Drivers (Desktop)

Driver installation is automated in `install.sh` for the desktop machine (detected by product UUID). Manual steps are not needed on reinstall.

### How it works
- RPM Fusion non-free is enabled by install.sh
- `akmod-nvidia` is installed; the kernel module compiles in the background
- install.sh polls until the module RPM appears, then prompts for reboot
- **Secure Boot must be disabled** — the proprietary module won't load with SB on

### Verify drivers are loaded after install/reboot
```sh
nvidia-smi           # should show GPU and driver version
modinfo -F version nvidia  # should print driver version
```

### If the module didn't compile
```sh
sudo akmods --force
sudo reboot
```

---

## Broadcom BCM4360 WiFi (Laptop)

### Why it's hard
The BCM4360 requires the proprietary `wl` driver from RPM Fusion non-free. It:
- Is a closed-source binary, compiled for specific kernel versions
- Conflicts with the in-kernel `bcma` driver which loads first
- Frequently breaks on kernel updates (akmod rebuilds help but aren't guaranteed)

### Installation (run after RPM Fusion is enabled by install.sh)
```sh
# Requires internet via USB tethering or USB ethernet adapter first
sudo dnf install -y akmod-wl "kernel-devel-uname-r == $(uname -r)"
echo "blacklist bcma" | sudo tee /etc/modprobe.d/blacklist-bcma.conf
echo "blacklist ssb" | sudo tee -a /etc/modprobe.d/blacklist-bcma.conf
sudo dracut --force
sudo reboot
```

### Connecting after reboot

install.sh prompts for SSID and password before rebooting and saves a NetworkManager profile. WiFi connects automatically on boot.

If you need to connect manually:
```sh
nmcli device wifi list                                     # scan for networks
nmcli device wifi connect "YourSSID" password "yourpass"  # connect
```

### Known limitations
- Driver can drop connection periodically; workaround if needed: `sudo modprobe -r wl && sudo modprobe wl`
- akmod rebuild after kernel update may take time or fail silently — WiFi may be broken until it succeeds
- Some Fedora versions have reported compatibility issues

### Operational strategy
- After install, document the working kernel version
- Pin to known-good kernel if stability requires it (accept as technical debt until hardware refresh)
- Budget for USB WiFi dongle as backup (~$15–30)
- This is a ticking time bomb until hardware refresh — don't invest heavily in making it perfect
