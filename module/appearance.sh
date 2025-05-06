#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

# check and create fonts, icons, themes folders.
fonts_dir="$HOME/.local/share/fonts"
icons_dir="$HOME/.local/share/icons"
themes_dir="$HOME/.local/share/themes"
backgrounds_dir="$HOME/.local/share/backgrounds"

if [[ ! -d $fonts_dir ]]; then
	mkdir -p $fonts_dir
fi

if [[ ! -d $icons_dir ]]; then
	mkdir -p $icons_dir
fi

if [[ ! -d $themes_dir ]]; then
	mkdir -p $themes_dir
fi

if [[ ! -d $background_dir ]]; then
	mkdir -p $background_dir
fi

# Install gnome-tweaks.
info "Installing gnome-tweaks..."
sudo apt install -y gnome-tweaks gnome-shell-extensions chrome-gnome-shell gnome-shell-extension-manager

# Install Nerd fonts, you can add fontname in the fonts list.
info "Installing nerd fonts..."
declare -a fonts=(
    FiraCode
    JetBrainsMono
    SourceCodePro
)

for font in "${fonts[@]}"; do
	info "Installing $font..."

    wget -O $font.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip
	
	# Check that the font's zip file has been downloaded successfully.
	if [ $? -eq 0 ]; then
    	unzip "$font.zip" -d ./$font/ && mv ./$font/*.ttf "$fonts_dir"
		rm "$font.zip" && rm -rf ./$font/
	fi
done

find $fonts_dir -name 'Windows Compatible' -delete

fc-cache -fv

# Install application icons.
info "Installing icons..."

git clone https://github.com/zayronxio/Zafiro-Nord-Dark.git

if [[ $? -eq 0 ]]; then
	if [[ ! -d "$icons_dir/Zafiro-Nord-Dark" ]]; then
		mv ./Zafiro-Nord-Dark $icons_dir
	fi
	
	gsettings set org.gnome.desktop.interface icon-theme 'Zafiro-Nord-Dark'

	rm -rf ./Zafiro-Nord-Dark
fi

# Install cursor icons.
info "Installing cursor icons..."

git clone https://github.com/yeyushengfan258/ArcMidnight-Cursors.git

if [[ $? -eq 0 ]]; then
	if [[ ! -d "$icons_dir/ArcMidnight-cursors" ]]; then
		cp -r ./ArcMidnight-Cursors/dist/ $icons_dir/ArcMidnight-cursors/
	fi
	
	gsettings set org.gnome.desktop.interface cursor-theme 'ArcMidnight-cursors'

	rm -rf ./ArcMidnight-Cursors
fi

# Install terminal theme.
info "Installing terminal theme..."
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git

if [[ $? -eq 0 ]]; then
	cd nord-gnome-terminal/src && ./nord.sh
	cd ../../ && rm -rf nord-gnome-terminal
fi

# https://github.com/linuxdotexe/nordic-wallpapers/tree/master
info "Installing nordic wallpapers..."

wget -O ign_evening.png https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/refs/heads/master/wallpapers/ign_evening.png
wget -O ign_outer_space.png https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/refs/heads/master/wallpapers/ign_outer_space.png

if [[ $? -eq 0 ]]; then
	mv ign_evening.png $backgrounds_dir
	mv ign_outer_space.png $backgrounds_dir
	gsettings set org.gnome.desktop.background picture-uri file://$backgrounds_dir/ign_outer_space.png
	gsettings set org.gnome.desktop.background picture-uri-dark file://$backgrounds_dir/ign_outer_space.png
	gsettings set org.gnome.desktop.screensaver picture-uri file://$backgrounds_dir/ign_outer_space.png
fi