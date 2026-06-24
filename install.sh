#!/usr/bin/env zsh
set -euo pipefail

# Helpers
info()    { print -P "%F{blue}---%f $1" }
success() { print -P "%F{green} ok%f $1" }
warning() { print -P "%F{yellow}skip%f $1 (already installed)" }
abort()   { print -P "%F{red}fail%f $1"; exit 1 }

installed() { command -v "$1" &>/dev/null }

# Homebrew
if ! installed brew; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    || abort "Failed to install Homebrew"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  warning "Homebrew"
  brew update --quiet
fi
success "brew $(brew --version | head -1)"

# Zed
if installed zed; then
  warning "Zed"
else
  info "Installing Zed..."
  brew install --cask zed || abort "Failed to install Zed"
fi
success "zed $(zed --version 2>/dev/null | head -1)"

print -P "\n%F{green}Done.%f Run ./symlinks.sh to link configs."
