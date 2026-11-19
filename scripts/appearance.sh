#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

[[ ${XDG_CURRENT_DESKTOP:-} == *GNOME* ]] || warn 'GNOME is not the current desktop; theme settings may not apply.'

fonts_dir="$localshare/fonts"
icons_dir="$localshare/icons"
backgrounds_dir="$localshare/backgrounds"
mkdir -p "$fonts_dir" "$icons_dir" "$backgrounds_dir"

log 'Installing GNOME appearance tools...'
sudo apt-get install -y fontconfig gnome-tweaks gnome-shell-extensions gnome-shell-extension-manager

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

fonts=(FiraCode JetBrainsMono SourceCodePro)
for font in "${fonts[@]}"; do
    log "Installing Nerd Font: $font..."
    archive="$workdir/$font.zip"
    destination="$workdir/$font"
    curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" -o "$archive"
    mkdir -p "$destination"
    unzip -q "$archive" -d "$destination"
    find "$destination" -type f \( -name '*.ttf' -o -name '*.otf' \) -exec install -m 0644 {} "$fonts_dir/" \;
done
fc-cache -f

log 'Installing the Zafiro Nord icon theme...'
git clone --depth 1 https://github.com/zayronxio/Zafiro-Nord-Dark.git "$workdir/Zafiro-Nord-Dark"
rm -rf "$icons_dir/Zafiro-Nord-Dark"
cp -R "$workdir/Zafiro-Nord-Dark" "$icons_dir/Zafiro-Nord-Dark"
gsettings set org.gnome.desktop.interface icon-theme 'Zafiro-Nord-Dark'

log 'Installing the ArcMidnight cursor theme...'
git clone --depth 1 https://github.com/yeyushengfan258/ArcMidnight-Cursors.git "$workdir/ArcMidnight-Cursors"
rm -rf "$icons_dir/ArcMidnight-cursors"
cp -R "$workdir/ArcMidnight-Cursors/dist" "$icons_dir/ArcMidnight-cursors"
gsettings set org.gnome.desktop.interface cursor-theme 'ArcMidnight-cursors'

log 'Installing the Nord GNOME Terminal theme...'
git clone --depth 1 https://github.com/arcticicestudio/nord-gnome-terminal.git "$workdir/nord-gnome-terminal"
bash "$workdir/nord-gnome-terminal/src/nord.sh"

log 'Installing Nordic wallpapers...'
wallpaper="$backgrounds_dir/ign_outer_space.png"
curl -fsSL https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/refs/heads/master/wallpapers/ign_evening.png \
    -o "$backgrounds_dir/ign_evening.png"
curl -fsSL https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/refs/heads/master/wallpapers/ign_outer_space.png \
    -o "$wallpaper"
gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper"
gsettings set org.gnome.desktop.screensaver picture-uri "file://$wallpaper"

success 'GNOME appearance setup completed.'
