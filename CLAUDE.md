# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

This project uses **pnpm** (see `packageManager` in `package.json`). Install deps with `pnpm install`.

```bash
# Generate the theme from its config files (palette + template). Also emits
# the Neovim colorscheme + Treesitter queries under nvim/, since Leone Dark
# ships a config/Leone Dark/nvim/ folder.
# (Theme name is a positional arg — pnpm forwards `--` literally, so prefer this form.)
pnpm generate "Leone Dark"

# Watch palette/template/syntax/nvim files and auto-regenerate on change
pnpm watch "Leone Dark"

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

This extension provides a single VS Code dark theme: **Leone Dark**. It uses a code-generated workflow:
- `config/Leone Dark/palette.json` — named color values (e.g. `"malibu": "#61AFEF"`)
- `config/Leone Dark/template.json` — base VS Code theme JSON (UI `colors`, semantic tokens, and language-agnostic `tokenColors`) with `{{colorName}}` placeholders (from `json-templates`)
- `config/Leone Dark/syntax/<fileType>.json` — per-file-type syntax rules, each a JSON **array** of `tokenColors` entries (e.g. `makefile.json`, `sql.json`, `markdown.json`, `python.json`, `ini.json`). Also use `{{colorName}}` placeholders.
- `config/Leone Dark/nvim/` — Neovim output: `template.lua` (colorscheme, with `{{colorName}}` placeholders) and `queries/` (static Treesitter query overrides, copied verbatim).
- `themes/Leone Dark-color-theme.json` — **generated output; do not edit manually**. This one is tracked in git since it's the extension's actual shipped/versioned deliverable.

The generator (`config/index.js`) reads the palette and template, appends every `syntax/*.json` array (sorted by filename) onto the base `tokenColors`, resolves placeholders, writes the theme file, emits the Neovim colorscheme + Treesitter queries under `nvim/`, updates `package.json`'s `contributes.themes`, and re-packages the `.vsix`. Because each syntax file targets a distinct language (disjoint scopes), their append order does not affect the result.

The root-level `nvim/` output (unlike `themes/`) is git-ignored — it's a local convenience artifact for `pnpm nvim:install`, regenerated on demand by `generate`/`watch`, not something the repo ships or versions. Run `pnpm generate "Leone Dark"` at least once before `pnpm nvim:install` if `nvim/` doesn't exist yet.

### Workflow

To change a color: edit `palette.json`, `template.json`, or the relevant `syntax/<fileType>.json` in `config/Leone Dark/`, then run `pnpm generate "Leone Dark"`. The file in `themes/` (and `nvim/`) will be overwritten. Add syntax coloring for a new file type by creating a new `syntax/<fileType>.json` array.

Adding a new theme (e.g. a future light variant) means creating a new `config/<ThemeName>/` folder with the same `palette.json`/`template.json`/`syntax/` structure, then running `pnpm generate "<ThemeName>"` — the generator adds it to `package.json`'s `contributes.themes` automatically (it only appends missing entries; removing a theme requires deleting its `config/`/`themes/` files and its `contributes.themes` entry by hand).
