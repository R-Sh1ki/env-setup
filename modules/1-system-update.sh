#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

desc "Backup and use USTC mirror sources..."

if [[ ! -f /etc/apt/sources.list.bak ]]; then
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
else
	echo "backup file has existed"
fi

sudo sed -i 's/cn.archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

desc "Update sources and upgrade softwares..."

sudo apt-get update
sudo apt-get -y upgrade
