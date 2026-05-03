# Arch setup with Gnome and Hyprland

This is very minimal setup.

## Base Setup

```bash
sudo pacman -S firefox \
  telegram-desktop \
  zed \
  stow \
  git \
  github-cli \
  less \
  tmux \
  neovim \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  starship \
  alacritty \
  kitty \
  ghostty \
  fastfetch
  yazi \
  fzf \
  eza \
  fd \
  feh \
  htop \
  bat \
  brightnessctl \
  alsa-utils \
  android-tools \
  postgresql-libs \
  valkey \
  uv \
  tk \
  pyenv \
  rustup \
  zig \
  go \
  nvm \
  jdk17-openjdk \
  kubectl \
  vlc \
  vlc-plugin-ffmpeg \
  vlc-plugins-all \
  ttf-jetbrains-mono-nerd \
  ttf-meslo-nerd \
  ttf-hack-nerd \
  noto-fonts-emoji
```

### Yay

Some packages:

* zen-browser-bin
* visual-studio-code-bin
* visual-studio-code-insiders-bin
* sublime-text-4
* docker-credential-secretservice
* docker-credential-pass
* hyprsysteminfo
* waypaper
* wallust
* nautilus-open-any-terminal
* bombardier
* headlamp-bin
* zsh-theme-powerlevel10k
* postman-bin
* android-studio
* google-chrome

## Setting up Gnome

* [GNOME](https://wiki.archlinux.org/title/GNOME)
* [polkit](https://wiki.archlinux.org/title/Polkit)
* [GNOME/Files](https://wiki.archlinux.org/title/GNOME/Files)

```bash
sudo pacman -S gnome-shell \
  gdm \
  gnome-control-center \
  gnome-tweaks \
  gnome-shell-extensions \
  extension-manager \
  gnome-session \
  gnome-keyring seahorse \
  gnome-font-viewer \
  gnome-text-editor \
  gnome-disk-utility \
  gnome-multi-writer \
  gnome-system-monitor \
  nautilus evince eog

# https://wiki.archlinux.org/title/GNOME/Files#Thumbnails
sudo pacman -S ffmpegthumbnailer gst-libav gst-plugins-ugly

# https://wiki.archlinux.org/title/File_manager_functionality#Thumbnail_previews
# `tumbler` is the core backend for thumbnailing in many file managers.
# This must be installed to enable thumbnailing for various file types.
# It is not required for GNOME Files.
sudo pacman -S tumbler

# Image formats:
#   webp-pixbuf-loader — Thumbnails for .webp image files
sudo pacman -S webp-pixbuf-loader

# Video and audio:
#   `ffmpegthumbnailer` — Thumbnails for video files
#   `totem` — Thumbnails for video and tagged audio files (used by GNOME Files and caja)
sudo pacman -S ffmpegthumbnailer

# Documents and ebooks
#   `papers` or `atril` — Thumbnails for .pdf files (used in GNOME and MATE environments)
#   `poppler-glib` — Rendering library required by some thumbnailers (e.g. tumbler) to generate .pdf thumbnails
#   `gnome-epub-thumbnailer` — Thumbnails for .epub and .mobi ebook files
#   `libgsf` — Thumbnails for .odf (OpenDocument Format) files
#   `mcomixAUR` — Thumbnails for .cbr comic book archive files
sudo pacman -S papers

# Other
#   `f3d` — Thumbnails for 3D model files, including .glTF, .stl, .step, .ply, .obj, and .fbx

# Archive files
# To extract compressed files such as tarballs (.tar and .tar.gz) within a file manager,
# it will first be necessary to install a GUI archiver such as `file-roller`.
sudo pacman -S file-roller
```

Start gdm service:

```bash
sudo systemctl enable –now gdm.service
```

If you want to just start the gnome on demand:

```bash
sudo systemctl set-default multi-user.target
sudo systemctl start gdm
sudo systemctl stop gdm
```

## Setting up Hyprland

* [Hyprland Wiki](https://wiki.hypr.land/)

```bash
sudo pacman -S hyprland \
  qt5-wayland \
  qt5ct \
  qt6-wayland \
  qt6ct \
  swaync \
  swaybg \
```

### SOME PACKAGES

```bash
hyprgraphics
hypridle
hyprland
hyprland-guiutils
hyprland-protocols
hyprland-qt-support
hyprlauncher
hyprlock
hyprpaper
hyprpolkitagent
hyprshot
hyprutils
lxappearance
nwg-displays
nwg-look
nwg-panel
waybar
waypaper
wofi
xdg-desktop-portal-gtk
xdg-desktop-portal-hyprland
```

Hyprland can be executed by typing `start-hyprland` in your tty.

## Docker on Arch Linux

[Docker Arch Wiki](https://wiki.archlinux.org/title/Docker)

```bash
sudo pacman -S docker docker-compose docker-buildx
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER
newgrp docker
```

verify the status:

```bash
docker info
```

### Configure Docker to use the Helper

[GNOME/Keyring](https://wiki.archlinux.org/title/GNOME/Keyring)

```bash
sudo pacman -S gnome-keyring seahorse
yay -S docker-credential-secretservice
```

Initialize the Default Keyring

Because you need to generate setup credentials from scratch, gnome-keyring won't
work out-of-the-box until a default vault exists for it to store things in.

* Launch `seahorse` (usually appears as Passwords and Keys in your application launcher).
* Click the `+` button in the top left (or **File** > **New**) and select **Password Keyring**.
* Name the new keyring `login` (lowercase). This is the standard naming convention.
* **Important**: When prompted for a password, enter your **current Linux user password**.
  This ensures that if you are using a display manager (like SDDM, GDM, or greetd/tuigreet with PAM),
  the keyring will unlock automatically when you log into your system.
* Once created, right-click the new `login` keyring in the sidebar and select **Set as Default**.

#### Start the Keyring Daemon in Hyprland

If you boot directly from a TTY or your login manager doesn't initialize DBus
secret components automatically, you need to tell Hyprland to start the daemon
so the Secret Service API is available to Docker.

Add this line to your `~/.config/hyprland/hyprland.conf`:

```conf
exec-once = gnome-keyring-daemon --start --components=secrets
```

#### Configure Docker

Now you need to tell Docker to route its credential management to the
Secret Service API rather than defaulting to pass or a plain-text file.

Edit or create your Docker config file at `~/.docker/config.json`:

```json
{
  "credsStore": "secretservice"
}
```

*(Docker will automatically prefix this value with docker-credential- and execute
the docker-credential-secretservice binary under the hood).*

#### Verify the Setup

Test your configuration by authenticating with Docker:

```bash
docker login
```

## Yay setup

[Follow the instruction on Github$](https://github.com/jguer/yay)

```bash
sudo pacman -S --needed git base-devel && \
  git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
```

```bash
yay -S visual-studio-code-bin visual-studio-code-insiders-bin
```

## INSTALLS

```bash
yay -S aaa
sudo pacman -S aaa

```
