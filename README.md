# Arch Setup

This is very minimal setup.

<!-- markdownlint-disable MD033 -->
<table>
  <tr>
    <td width="50%"><img alt="img" width="100%" src="static/images/2026-05-16-114028_hyprshot.png"/></td>
    <td width="50%"><img alt="img" width="100%" src="static/images/2026-05-16-113831_hyprshot.png"/></td>
  </tr>
  <tr>
    <td width="33%"><img alt="img" width="100%" src="static/images/2026-05-16-114304_hyprshot.png"/></td>
    <td width="33%"><img alt="img" width="100%" src="static/images/2026-05-16-114328_hyprshot.png"/></td>
    <td width="33%"><img alt="img" width="100%" src="static/images/2026-05-16-114350_hyprshot.png"/></td>
  </tr>
</table>
<!-- markdownlint-enable MD033 -->

## Base Setup

```bash
sudo pacman -S --needed firefox \
  telegram-desktop \
  zed \
  stow \
  git \
  github-cli \
  less \
  tmux \
  zellij \
  tree-sitter-cli \
  neovim \
  neovide \
  man \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  starship \
  alacritty \
  kitty \
  ghostty \
  fastfetch \
  ripgrep \
  yazi \
  fzf \
  eza \
  bat \
  fd \
  feh \
  zip \
  unzip \
  htop \
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

## Yay Setup

[Follow the instruction on Github$](https://github.com/jguer/yay)

```bash
sudo pacman -S --needed --needed git base-devel && \
  git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
```

```bash
yay -S visual-studio-code-bin \
  visual-studio-code-insiders-bin \
  docker-credential-secretservice
```

Some packages:

- sublime-text-4
- zen-browser-bin
- visual-studio-code-bin
- visual-studio-code-insiders-bin
- docker-credential-secretservice
- docker-credential-pass
- bombardier
- headlamp-bin
- zsh-theme-powerlevel10k
- postman-bin
- android-studio
- google-chrome

## Gnome Setup

- [GNOME](https://wiki.archlinux.org/title/GNOME)
- [polkit](https://wiki.archlinux.org/title/Polkit)
- [GNOME/Files](https://wiki.archlinux.org/title/GNOME/Files)

```bash
sudo pacman -S --needed gnome-shell \
  gdm \
  gnome-control-center \
  gnome-tweaks \
  gnome-shell-extensions \
  extension-manager \
  gnome-themes-extra \
  gnome-session \
  gnome-keyring seahorse \
  gnome-font-viewer \
  gnome-text-editor \
  gnome-disk-utility \
  gnome-multi-writer \
  gnome-system-monitor \
  nautilus evince eog

# https://wiki.archlinux.org/title/GNOME/Files#Thumbnails
sudo pacman -S --needed ffmpegthumbnailer gst-libav gst-plugins-ugly

# https://wiki.archlinux.org/title/File_manager_functionality#Thumbnail_previews
# `tumbler` is the core backend for thumbnailing in many file managers.
# This must be installed to enable thumbnailing for various file types.
# It is not required for GNOME Files.
sudo pacman -S --needed tumbler

# Image formats:
#   webp-pixbuf-loader — Thumbnails for .webp image files
sudo pacman -S --needed webp-pixbuf-loader

# Video and audio:
#   `ffmpegthumbnailer` — Thumbnails for video files
#   `totem` — Thumbnails for video and tagged audio files (used by GNOME Files and caja)
sudo pacman -S --needed ffmpegthumbnailer

# Documents and ebooks
#   `papers` or `atril` — Thumbnails for .pdf files (used in GNOME and MATE environments)
#   `poppler-glib` — Rendering library required by some thumbnailers (e.g. tumbler) to generate .pdf thumbnails
#   `gnome-epub-thumbnailer` — Thumbnails for .epub and .mobi ebook files
#   `libgsf` — Thumbnails for .odf (OpenDocument Format) files
#   `mcomixAUR` — Thumbnails for .cbr comic book archive files
sudo pacman -S --needed papers

# Other
#   `f3d` — Thumbnails for 3D model files, including .glTF, .stl, .step, .ply, .obj, and .fbx

# Archive files
# To extract compressed files such as tarballs (.tar and .tar.gz) within a file manager,
# it will first be necessary to install a GUI archiver such as `file-roller`.
sudo pacman -S --needed file-roller
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

## Hyprland Setup

- [Hyprland Wiki](https://wiki.hypr.land/)
- [Getting Started](https://wiki.hypr.land/Getting-Started/)
  - [Installation](https://wiki.hypr.land/Getting-Started/Installation/)
  - [Master tutorial](https://wiki.hypr.land/Getting-Started/Master-Tutorial/)
  - [Preconfigured setups](https://wiki.hypr.land/Getting-Started/Preconfigured-setups/)
- [Configuring](https://wiki.hypr.land/Configuring/)
  - [Start](<[ccc](https://wiki.hypr.land/Configuring/Start/)>)
  - [Basics](https://wiki.hypr.land/Configuring/Basics/)
    - [Variables](https://wiki.hypr.land/Configuring/Basics/Variables/)
    - [Monitors](https://wiki.hypr.land/Configuring/Basics/Monitors/)
    - [Binds](https://wiki.hypr.land/Configuring/Basics/Binds/)
    - [Dispatchers](https://wiki.hypr.land/Configuring/Basics/Dispatchers/)
    - [Window Rules](https://wiki.hypr.land/Configuring/Basics/Window-Rules/)
    - [Workspace Rules](https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/)
    - [Autostart](https://wiki.hypr.land/Configuring/Basics/Autostart/)
  - [Layouts](https://wiki.hypr.land/Configuring/Layouts/)
  - [Advanced and Cool](https://wiki.hypr.land/Configuring/Advanced-and-Cool/)
  - [Example configurations](https://wiki.hypr.land/Configuring/Example-configurations/)
- [Hypr Ecosystem](https://wiki.hypr.land/Hypr-Ecosystem/)
  - [hyprpaper](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper) | [GitHub](https://github.com/hyprwm/hyprpaper)
  - [hyprpicker](https://wiki.hypr.land/Hypr-Ecosystem/hyprpicker) | [GitHub](https://github.com/hyprwm/hyprpicker)
  - [hyprlauncher](https://wiki.hypr.land/Hypr-Ecosystem/hyprlauncher) | [GitHub](https://github.com/hyprwm/hyprlauncher)
  - [hypridle](https://wiki.hypr.land/Hypr-Ecosystem/hypridle) | [GitHub](<(https://github.com/hyprwm/hypridle)>)
  - [hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock) | [GitHub](https://github.com/hyprwm/hyprlock)
  - [xdg-desktop-portal-hyprland](https://wiki.hypr.land/Hypr-Ecosystem/xdg-desktop-portal-hyprland) | [GitHub](https://github.com/hyprwm/xdg-desktop-portal-hyprland)
  - [hyprsysteminfo](https://wiki.hypr.land/Hypr-Ecosystem/hyprsysteminfo) | [GitHub](https://github.com/hyprwm/hyprsysteminfo)
  - [hyprsunset](https://wiki.hypr.land/Hypr-Ecosystem/hyprsunset) | [GitHub](https://github.com/hyprwm/hyprsunset)
  - [hyprpolkitagent](https://wiki.hypr.land/Hypr-Ecosystem/hyprpolkitagent) | [GitHub](https://github.com/hyprwm/hyprpolkitagent)
  - [hyprland-qt-support](https://wiki.hypr.land/Hypr-Ecosystem/hyprland-qt-support) | [GitHub](https://github.com/hyprwm/hyprland-qt-support)
  - [hyprqt6engine](https://wiki.hypr.land/Hypr-Ecosystem/hyprqt6engine) | [GitHub](https://github.com/hyprwm/hyprqt6engine)
  - [hyprpwcenter](https://wiki.hypr.land/Hypr-Ecosystem/hyprpwcenter) | [GitHub](https://github.com/hyprwm/hyprpwcenter)
  - [hyprshutdown](https://wiki.hypr.land/Hypr-Ecosystem/hyprshutdown) | [GitHub](https://github.com/hyprwm/hyprshutdown)
- [Useful Utilities](https://wiki.hypr.land/Useful-Utilities/)
  - [Must-Have](https://wiki.hypr.land/Useful-Utilities/Must-have)
  - [Status Bars](https://wiki.hypr.land/Useful-Utilities/Status-Bars)
  - [App Launchers](https://wiki.hypr.land/Useful-Utilities/App-Launchers)
  - [Wallpapers](https://wiki.hypr.land/Useful-Utilities/Wallpapers)
  - [Screen Sharing](https://wiki.hypr.land/Useful-Utilities/Screen-Sharing)
  - [App Clients](https://wiki.hypr.land/Useful-Utilities/App-Clients)
  - [Color Pickers](https://wiki.hypr.land/Useful-Utilities/Color-Pickers)
  - [Clipboard Managers](https://wiki.hypr.land/Useful-Utilities/Clipboard-Managers)
  - [Hyprland Desktop Portal](https://wiki.hypr.land/Hypr-Ecosystem/xdg-desktop-portal-hyprland)
  - [File Managers](https://wiki.hypr.land/Useful-Utilities/File-Managers)
  - [Other](https://wiki.hypr.land/Useful-Utilities/Other)
  - [Systemd startup](https://wiki.hypr.land/Useful-Utilities/Systemd-start)

### Pacman packages

```bash
sudo pacman -S --needed hyprland \
  pipewire \
  wireplumber \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  hyprpolkitagent \
  qt5-wayland \
  qt6-wayland \
  # lxappearance \
  nwg-look \
  qt5ct \
  qt6ct \
  matugen \
  swaync \
  waybar \
  wofi \
  # rofi \
  swaybg \
  hyprpaper \
  hypridle \
  hyprlock \
  hyprlauncher \
  hyprshot \
  flameshot \
  wl-clip-persist
```

- hyprsunset

### Yay packages

```bash
yay -S hyprqt6engine \
  waypaper \
  # wallust \
  # ashell \
  cursor-clip-git
```

- hyprsysteminfo
- nautilus-open-any-terminal

## Docker Setup

[Docker Arch Wiki](https://wiki.archlinux.org/title/Docker)

```bash
sudo pacman -S --needed docker docker-compose docker-buildx
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER
newgrp docker
```

verify the status:

```bash
docker info
```
