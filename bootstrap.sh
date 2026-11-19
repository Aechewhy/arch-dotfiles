#!/usr/bin/env bash
# Ask for sudo once
sudo -v

# Keep sudo alive until script finishes
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &
set -euo pipefail

echo "==> Starting bootstrap..."

# Ensure git exists
if ! command -v git >/dev/null 2>&1; then
  echo "==> Installing git..."
  sudo pacman -Sy --needed git
fi

# Clone dotfiles
git clone https://github.com/Aechewhy/arch-dotfiles.git ~/.dotfiles || true
cd ~/.dotfiles

# Install packages
if [[ -f packages/pkglist.txt ]]; then
  sudo pacman -S --needed - <packages/pkglist.txt
fi

# Install AUR helper (optional)
if ! command -v paru >/dev/null 2>&1; then
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  (cd /tmp/paru && makepkg -si --noconfirm)
fi

if [[ -f packages/aur-pkglist.txt ]]; then
  paru -S --needed - <packages/aur-pkglist.txt
fi

# Apply dotfiles
sudo pacman -S --needed stow
stow */

# Enable services
if [[ -f services/system.txt ]]; then
  while read -r svc; do
    sudo systemctl enable --now "$svc"
  done <services/system.txt
fi

echo "==> Done. Reboot recommended."
