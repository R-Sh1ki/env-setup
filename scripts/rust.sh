#!/usr/bin/env bash
set -Eeuo pipefail

repodir="${repodir:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
source "$repodir/scripts/lib/common.sh"

# Find existing user or Homebrew toolchains.
brew_prefix="$(brew --prefix)"
export PATH="${CARGO_HOME:-$HOME/.cargo}/bin:$brew_prefix/opt/rustup/bin:$PATH"

# Install the toolchain manager if missing.
if command -v rustup >/dev/null 2>&1; then
    log 'rustup is already installed.'
else
    log 'Installing rustup...'
    brew install rustup
fi

# Download Rust toolchains through rsproxy.
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# Configure crate downloads without replacing existing Cargo settings.
cargo_home="${CARGO_HOME:-$HOME/.cargo}"
[[ -d "$cargo_home" ]] || mkdir -p "$cargo_home"
if [[ -e "$cargo_home/config.toml" || -L "$cargo_home/config.toml" || -e "$cargo_home/config" || -L "$cargo_home/config" ]]; then
    warn 'Keeping existing Cargo config; merge dotfiles/cargo.toml to enable the crate mirror.'
else
    install -m 0644 "$repodir/dotfiles/cargo.toml" "$cargo_home/config.toml"
fi

# Install stable Rust and select it as the default.
log 'Installing stable Rust...'
rustup toolchain install stable
rustup default stable

# Enable Rust commands in Zsh.
[[ -d "$configdir/zsh" ]] || mkdir -p "$configdir/zsh"
install -m 0644 "$repodir/dotfiles/zsh/rust.zsh" "$configdir/zsh/rust.zsh"

rustup --version
rustc --version
cargo --version
success 'Rust setup completed.'
log 'Start a new Zsh session or run: source ~/.zshrc'
