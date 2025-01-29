#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

desc "Time sync..."
sudo timedatectl set-local-rtc 1
sudo apt-get install -y ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc
