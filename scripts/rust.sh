#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

cargo_home="${CARGO_HOME:-$HOME/.cargo}"
export PATH="$cargo_home/bin:$PATH"

if command -v rustup >/dev/null 2>&1; then
    log 'rustup is already installed.'
else
    log 'Installing rustup...'
    curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

export RUSTUP_DIST_SERVER='https://rsproxy.cn'
export RUSTUP_UPDATE_ROOT='https://rsproxy.cn/rustup'

mkdir -p "$cargo_home"
if [[ -e "$cargo_home/config.toml" || -L "$cargo_home/config.toml" || -e "$cargo_home/config" || -L "$cargo_home/config" ]]; then
    warn 'Keeping existing Cargo config; merge dotfiles/cargo.toml to enable the crate mirror.'
else
    install -m 0644 "$repodir/dotfiles/cargo.toml" "$cargo_home/config.toml"
fi

rustup toolchain install stable
rustup default stable

mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/rust.zsh" "$configdir/zsh/rust.zsh"

rustup --version
rustc --version
cargo --version
success 'Rust setup completed.'
