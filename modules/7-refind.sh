#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

sudo apt-add-repository ppa:rodsmith/refind
sudo apt-get update
sudo apt-get install -y refind
