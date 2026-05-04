# Walker

* [Walker](https://walkerlauncher.com/)
* [Installation](https://walkerlauncher.com/docs/installation)
* [Getting Started](https://walkerlauncher.com/docs/getting-started)
* [Configuration](https://walkerlauncher.com/docs/configuration)
* [Keybindings](https://walkerlauncher.com/docs/keybindings)
* [Theming](https://walkerlauncher.com/docs/theming)
* [Providers](https://walkerlauncher.com/docs/providers)

Walker is an extensible Wayland-native runner with various built-in
modules (applications, runner, hyprland windows, websearch).
It can be run as a service for faster startups.

```bash
yay -S walker elephant 
```

## Start Elephant Service

Walker requires Elephant to be running:

```bash
# Start Elephant as a user service
elephant service enable
systemctl --user start elephant.service

# Or start manually
elephant
```

## Install Elephant Providers

You need to install at least some providers for Elephant:

```bash
# Essential providers
yay -S elephant-providerlist        # Provider switcher
yay -S elephant-desktopapplications  # Desktop applications

# Optional providers
yay -S elephant-files               # File browser
yay -S elephant-runner              # Command runner
yay -S elephant-calc                # Calculator
yay -S elephant-websearch           # Web search
yay -S elephant-clipboard           # Clipboard history
yay -S elephant-symbols             # Symbol picker
```

## First Run

```bash
walker
```

This will:

* Create default configuration at `~/.config/walker/config.toml`
* Create default theme files in `~/.config/walker/themes/`

## Running as a Service

For faster startup, run Walker as a background service:

```bash
walker --gapplication-service
```

Then open Walker anytime with:

```bash
walker
```

## For systemd

Create `~/.config/systemd/user/walker.service`:

```bash
[Unit]
Description=Walker Launcher Service
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/walker --gapplication-service
Restart=on-failure

[Install]
WantedBy=default.target
```

Then enable it:

```bash
systemctl --user enable --now walker.service
```

### For Hyprland/Window Managers

Add to your config:

```bash
# Hyprland
exec-once=walker --gapplication-service

# i3/sway
exec walker --gapplication-service
```

## Troubleshooting

### Missing dependencies

If you get errors about missing libraries:

```bash
# Arch Linux
sudo pacman -S --needed gtk4 gtk4-layer-shell cairo poppler-glib protobuf

# Fedora
sudo dnf install gtk4 gtk4-layer-shell cairo poppler-glib protobuf-compiler

# Ubuntu/Debian (may need PPA for GTK4)
sudo apt install libgtk-4-dev libgtk4-layer-shell-dev libcairo2-dev libpoppler-glib-dev protobuf-compiler
```
