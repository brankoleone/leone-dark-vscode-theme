#!/usr/bin/env bash
# Copy the generated Neovim theme (colorscheme + Treesitter query overrides)
# into your Neovim config so :colorscheme leone-forest works.
#
# Destination: $NVIM_CONFIG_DIR, else $XDG_CONFIG_HOME/nvim, else ~/.config/nvim
#
# This overwrites any existing leone-* colorscheme / query files at the
# destination (including symlinks) with real copies. Run it again after every
# `pnpm generate` to refresh the installed copy.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/nvim"

DEST="${NVIM_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/nvim}"

if [ ! -d "$SRC/colors" ]; then
  echo "No generated Neovim theme found at $SRC/colors."
  echo "Run: pnpm generate -- --themeName \"Leone Forest\""
  exit 1
fi

echo "Installing Neovim theme:"
echo "  from: $SRC"
echo "  to:   $DEST"

# 1) Colorscheme(s)
mkdir -p "$DEST/colors"
for f in "$SRC"/colors/*.lua; do
  [ -e "$f" ] || continue
  target="$DEST/colors/$(basename "$f")"
  rm -f "$target"           # drop any existing file/symlink first
  cp "$f" "$target"
  echo "  + colors/$(basename "$f")"
done

# 2) Treesitter query overrides (after/queries/**)
if [ -d "$SRC/after/queries" ]; then
  while IFS= read -r -d '' f; do
    rel="${f#"$SRC"/}"       # e.g. after/queries/tsx/highlights.scm
    target="$DEST/$rel"
    mkdir -p "$(dirname "$target")"
    rm -f "$target"
    cp "$f" "$target"
    echo "  + $rel"
  done < <(find "$SRC/after/queries" -type f -print0)
fi

echo "Done. Restart Neovim, then :colorscheme leone-forest"
