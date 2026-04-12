# Post-Install Validation & Troubleshooting

---

## i3: Apps launching on wrong workspace

Workspace `assign` rules use X11 class names. Verify the actual class name with:

```sh
xprop | grep WM_CLASS
# then click the window
```

Expected assignments (class → workspace):
- `Brave-browser` → 1
- `discord` → 2
- `Alacritty` → 3

Update `~/.config/i3/config` (and the stow source) if any class name differs.

---

## i3: Broken config recovery

**If i3 starts but keybindings are broken** (can't open a terminal):
- Switch to a TTY: `Ctrl+Alt+F2`
- Edit the config: `nvim ~/.config/i3/config`
- Switch back to the graphical session: `Ctrl+Alt+F1`
- Reload i3 from the TTY if needed: `DISPLAY=:0 i3-msg reload`

**If i3 won't start at all** (login loops or drops to TTY):
- Switch to a TTY: `Ctrl+Alt+F2`
- Edit the config: `nvim ~/.config/i3/config`
- Restart the display manager: `sudo systemctl restart display-manager`

**To temporarily fall back to the system default i3 config**:
```sh
mv ~/.config/i3/config ~/.config/i3/config.bak
sudo systemctl restart display-manager
```
Restore with `mv ~/.config/i3/config.bak ~/.config/i3/config` once fixed.

---

## Laptop: Brave freezes under heavy memory pressure

**Root cause**: MacBook Air A1466 has 4GB soldered RAM. Brave + YouTube/Docs exhausts physical RAM and pushes ~3GB into zram swap. btrfs CoW amplifies I/O during swap storms but is not the root cause — ext4 would not fix this.

**Mitigations (not yet applied, in order of impact)**:

1. **Brave Memory Saver** (zero config) — `brave://settings/performance` → enable Memory Saver. Discards inactive tabs from RAM automatically.

2. **`~/.config/brave-flags.conf`** — limit renderer processes:
   ```
   --renderer-process-limit=3
   --process-per-site
   ```

3. **earlyoom** — kills the biggest process before the system becomes unresponsive:
   ```sh
   sudo dnf install earlyoom
   sudo systemctl enable --now earlyoom
   ```

4. **systemd memory cap** — soft ceiling isolates Brave from system-wide OOM:
   ```sh
   systemd-run --scope --user -p MemoryHigh=2G -p MemoryMax=2.5G brave-browser %U
   ```
   Wire into Brave's `.desktop` file or a wrapper script for persistence.

---

## i3: Lid-close locking not working

`xss-lock` may not be included in the Fedora i3 Spin. Check:

```sh
which xss-lock
```

If missing:

```sh
sudo dnf install -y xss-lock
```

Then reload i3 (`$mod+Shift+c`) or reboot. `xss-lock` hooks into systemd's suspend signal, which is what lid-close triggers.
