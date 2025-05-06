#!/bin/bash

SYSTEM_INFO=1

# Distribute information
# - DISTRIB_ID
# - DISTRIB_RELEASE
# - DISTRIB_CODENAME
# - DISTRIB_DESCRIPTION
if [[ -f /etc/lsb-release ]]; then
  . /etc/lsb-release
fi

# Architecture information
os_architecture=$(uname -m)
os_kernel=$(uname -r)
if [[ -z DISTRIB_DESCRIPTION ]]; then
	os=$(uname -s)
    codename=$(uname -s)
else
	os="$DISTRIB_DESCRIPTION"
    codename="$DISTRIB_CODENAME"
fi