#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

sudo chmod u+x ./modules/*.sh

desc "[0] Checking system info..."
./modules/0-system-info.sh

confirm ./modules/1-system-update.sh "[1] Update softwares?"

confirm ./modules/2-common-utils.sh "[2] Install common utils?"

confirm ./modules/3-zsh.sh "[3] Install zsh?"

confirm ./modules/4-tweaks.sh "[4] Install gnome?"

confirm ./modules/5-settings.sh "[5] Time synchronization?"

confirm ./modules/6-tmux.sh "[6] Install tmux?"

confirm ./modules/7-refind.sh "[7] Install refind?"

confirm ./modules/8-ctf.sh "[8] Install CTF tools?"
