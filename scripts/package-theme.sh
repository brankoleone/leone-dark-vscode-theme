#!/usr/bin/env bash
#
# Generate a selected theme and build its .vsix package — no global vsce required.
#
# Usage:
#   scripts/package-theme.sh                 # defaults to "Leone Dark"
#   scripts/package-theme.sh "<Theme Name>"  # any theme with a config/<name>/ folder
#
# vsce is resolved on demand via `pnpm dlx @vscode/vsce`, so nothing needs to be
# installed globally.

set -euo pipefail

THEME="${1:-Leone Dark}"

# Resolve repo root regardless of where the script is called from.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CONFIG_DIR="config/${THEME}"
if [ ! -d "$CONFIG_DIR" ]; then
  echo "Error: no config folder found at '${CONFIG_DIR}'." >&2
  echo "Available themes:" >&2
  find config -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sed 's/^/  - /' >&2
  exit 1
fi

echo "==> Generating theme JSON + updating package.json for '${THEME}'..."
# SKIP_VSIX stops config/index.js from packaging itself; we do it below.
SKIP_VSIX=1 node config/index.js generate "$THEME"

echo "==> Packaging .vsix (via pnpm dlx @vscode/vsce, no global install needed)..."
pnpm dlx @vscode/vsce package

echo "==> Done. Generated .vsix:"
ls -1t ./*.vsix 2>/dev/null | head -n 1
