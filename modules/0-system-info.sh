#!/bin/bash

if [[ -f /etc/lsb-release ]]; then
	. /etc/lsb-release
fi

os_architecture=$(uname -m)
os_kernel=$(uname -r)
if [[ -z DISTRIB_DESCRIPTION ]]; then
	os=$(uname -s)
else
	os="$DISTRIB_DESCRIPTION - $DISTRIB_CODENAME"
fi


tput setaf 10; tput bold

echo "----------------------------------------------------"
echo "|                   SYSTEM INFO                    |"
echo "----------------------------------------------------"
printf "|%-20s%-30s|\n" " - User" ":$USER"
printf "|%-20s%-30s|\n" " - Hostname" ":$HOSTNAME"
printf "|%-20s%-30s|\n" " - OS" ":$os"
printf "|%-20s%-30s|\n" " - Kernel" ":$os_kernel"
printf "|%-20s%-30s|\n" " - Architecture" ":$os_architecture"
echo "----------------------------------------------------"

tput sgr0

