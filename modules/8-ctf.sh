#!/bin/bash

if [[ -z $format_sourced ]]; then
	source ./libs/format-output.sh
fi

desc "Install hex editors..."
sudo apt-get install -y hexyl hexedit
