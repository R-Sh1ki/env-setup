#!/usr/bin/env bash

# Shared entry point for installation-script helpers.
COMMON_LIB_DIR="$(dirname "${BASH_SOURCE[0]}")"

source "${COMMON_LIB_DIR}/fmt.sh"
source "${COMMON_LIB_DIR}/system.sh"
source "${COMMON_LIB_DIR}/paths.sh"
