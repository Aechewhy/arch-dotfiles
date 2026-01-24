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
git clone https://github.com/you/dotfiles ~/.dotfiles || true
cd ~/.dotfiles

# Install packages
sudo pacman -S --needed - <packages/pacman.txt

# Install AUR helper (optional)
if ! command -v paru >/dev/null 2>&1; then
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  (cd /tmp/paru && makepkg -si --noconfirm)
fi

paru -S --needed - <packages/aur.txt

# Apply dotfiles
sudo pacman -S --needed stow
stow */

# Enable services
while read -r svc; do
  sudo systemctl enable --now "$svc"
done <services/system.txt

echo "==> Done. Reboot recommended."
