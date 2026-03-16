#!/bin/bash
set -e

# $1 is the argument passed by systemd (e.g., "games", "obsidian", or "isac")
TARGET="$1"

case "$TARGET" in
"games")
  REPO_DIR="/home/aechewhy/Games/backups"
  ;;
"obsidian")
  # Replace with your actual vault path
  REPO_DIR="/home/aechewhy/Documents/Obsidian Vaults/Brain"
  ;;
"dotfiles")
  # Just point this to the exact folder you ran that 'ls' command in
  REPO_DIR="/home/aechewhy/.dotfiles"
  ;;
*)
  echo "Error: Unknown backup target '$TARGET'"
  exit 1
  ;;
esac

cd "$REPO_DIR" || exit 1

git add .

if ! git diff --cached --quiet; then
  git commit -m "Auto backup: $(date '+%Y-%m-%d %H:%M:%S')"
  git push
fi
