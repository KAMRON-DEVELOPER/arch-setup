# GNOME Keybindings

This directory contains GNOME keyboard shortcut configurations
for quick restoration across systems.

## What's Included

- **Media keys** and custom shortcuts
- **Window manager** (Mutter) keybindings

> **Note:** Themes, extensions, app layouts, and other GNOME state are intentionally excluded to keep restores clean and portable.

---

## Export Keybindings

Media Keys & Custom Shortcuts

```bash
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > gnome/media-keys.txt
dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > ~/Documents/arch-setup/gnome/media-keys.txt
```

Window Manager Shortcuts

```bash
dconf dump /org/gnome/desktop/wm/keybindings/ > gnome/keybindings.txt
dconf dump /org/gnome/desktop/wm/keybindings/ > ~/Documents/arch-setup/gnome/keybindings.txt
```

---

## Restore Keybindings

Media Keys & Custom Shortcuts

```bash
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < gnome/media-keys.txt
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/Documents/dotfiles/gnome/media-keys.txt
```

Window Manager Shortcuts

```bash
dconf load /org/gnome/desktop/wm/keybindings/ < gnome/keybindings.txt
dconf load /org/gnome/desktop/wm/keybindings/ < ~/Documents/dotfiles/gnome/keybindings.txt
```

> **Important:** Log out and log back in after restoring for changes to take effect.

---

## Quick Restore (Both)

```bash
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < gnome/media-keys.txt
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < ~/Documents/dotfiles/gnome/media-keys.txt

dconf load /org/gnome/desktop/wm/keybindings/ < gnome/keybindings.txt
dconf load /org/gnome/desktop/wm/keybindings/ < ~/Documents/dotfiles/gnome/keybindings.txt
```
