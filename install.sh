#!/usr/bin/env bash
# Symlink these dotfiles into $HOME.
# Existing files are backed up to ~/.config/dotfiles-backup/<timestamp>/
set -euo pipefail

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.config/dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

FILES=(zsh/zshenv zsh/zprofile zsh/zshrc)

for f in "${FILES[@]}"; do
  target="$HOME/.${f#zsh/}"
  if [ -e "$target" ] || [ -L "$target" ]; then
    if [ "$(readlink "$target" 2>/dev/null)" = "$DOTDIR/$f" ]; then
      echo "ok   $target -> already linked"
      continue
    fi
    mkdir -p "$BACKUP"
    mv "$target" "$BACKUP/"
    echo "backed up $target -> $BACKUP"
  fi
  ln -s "$DOTDIR/$f" "$target"
  echo "linked $target -> $DOTDIR/$f"
done

# Create the private secrets file if it doesn't exist yet.
if [ ! -f "$HOME/.zshrc.private" ]; then
  cp "$DOTDIR/zsh/zshrc.private.example" "$HOME/.zshrc.private"
  chmod 600 "$HOME/.zshrc.private"
  echo "created ~/.zshrc.private (chmod 600) — put your secrets there"
fi

echo
echo "Done. Restart your shell or run: source ~/.zshrc"
