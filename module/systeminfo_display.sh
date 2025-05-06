#!/bin/bash

if [[ -z $format_output ]]; then
	source ./include/format_output.sh
fi

if [[ -z $system_info ]]; then
    source ./include/system_info.sh
fi

info "┌────────────────────────────────────────────────┐"
info "│                  SYSTEM INFO                   │"
info "├───────────────┬────────────────────────────────┤"
info "$(printf "│%-15s%-35s│\n" " User"           "│ $USER")"
info "$(printf "│%-15s%-35s│\n" " Hostname"       "│ $HOSTNAME")"
info "$(printf "│%-15s%-35s│\n" " OS"             "│ $os - $codename")"
info "$(printf "│%-15s%-35s│\n" " Kernel"         "│ $os_kernel")"
info "$(printf "│%-15s%-35s│\n" " Architecture"   "│ $os_architecture")"
info "└───────────────┴────────────────────────────────┘"