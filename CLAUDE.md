# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

This project uses **pnpm** (see `packageManager` in `package.json`). Install deps with `pnpm install`.

```bash
# Generate a theme from its config files (palette + template).
# For themes with a config/<name>/nvim/ folder (e.g. Leone Forest), this also
# emits the Neovim colorscheme + Treesitter queries under nvim/.
# (Theme name is a positional arg — pnpm forwards `--` literally, so prefer this form.)
pnpm generate "Leone Forest"
pnpm generate "Leone Orca"

# Watch palette/template/syntax/nvim files and auto-regenerate on change
pnpm watch "Leone Forest"

# Package the extension as a .vsix file
pnpm vsix

# Copy the generated Neovim theme into your Neovim config
pnpm nvim:install

# Publish to VS Code Marketplace
pnpm publish:patch   # bump patch version
pnpm publish:minor   # bump minor version
pnpm publish:major   # bump major version
```

## Architecture

This extension provides 4 VS Code dark themes: **Leone Dark**, **Leone Craft**, **Leone Orca**, and **Leone Forest**.

### Two kinds of themes

**Leone Dark** and **Leone Craft** — theme files in `themes/` are edited directly (no config folder).

**Leone Orca** and **Leone Forest** — use a code-generated workflow:
- `config/<ThemeName>/palette.json` — named color values (e.g. `"malibu": "#61AFEF"`)
- `config/<ThemeName>/template.json` — base VS Code theme JSON (UI `colors`, semantic tokens, and language-agnostic `tokenColors`) with `{{colorName}}` placeholders (from `json-templates`)
- `config/<ThemeName>/syntax/<fileType>.json` — per-file-type syntax rules, each a JSON **array** of `tokenColors` entries (e.g. `makefile.json`, `sql.json`, `markdown.json`, `python.json`, `ini.json`). Also use `{{colorName}}` placeholders.
- `themes/<ThemeName>-color-theme.json` — **generated output; do not edit manually**

The generator (`config/index.js`) reads the palette and template, appends every `syntax/*.json` array (sorted by filename) onto the base `tokenColors`, resolves placeholders, writes the theme file, updates `package.json`'s `contributes.themes`, and re-packages the `.vsix`. Because each syntax file targets a distinct language (disjoint scopes), their append order does not affect the result.

### Workflow for template-based themes

To change a color: edit `palette.json`, `template.json`, or the relevant `syntax/<fileType>.json` in the `config/<ThemeName>/` folder, then run `pnpm generate "<ThemeName>"`. The file in `themes/` will be overwritten. Add syntax coloring for a new file type by creating a new `syntax/<fileType>.json` array.
