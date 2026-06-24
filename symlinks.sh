#!/usr/bin/env zsh
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Helpers
info()    { print -P "%F{blue}---%f $1" }
success() { print -P "%F{green} ok%f $1" }
warning() { print -P "%F{yellow}bak%f $1 -> $1.bak" }

link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  # Back up existing file if it is not already a symlink
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    warning "$dst"
    mv "$dst" "$dst.bak"
  fi

  ln -sf "$src" "$dst"
  success "$src -> $dst"
}

# Zed
link "$DOTFILES/zed/settings.json" "$HOME/.config/zed/settings.json"

print -P "\n%F{green}Done.%f"
