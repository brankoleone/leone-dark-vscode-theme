# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Generate a theme from its config files (palette + template)
npm run generate -- --themeName "Leone Forest"
npm run generate -- --themeName "Leone Orca"

# Watch palette/template files and auto-regenerate on change
npm run watch -- --themeName "Leone Forest"

# Package the extension as a .vsix file
npm run vsix

# Publish to VS Code Marketplace
npm run publish:patch   # bump patch version
npm run publish:minor   # bump minor version
npm run publish:major   # bump major version
```

## Architecture

This extension provides 4 VS Code dark themes: **Leone Dark**, **Leone Craft**, **Leone Orca**, and **Leone Forest**.

### Two kinds of themes

**Leone Dark** and **Leone Craft** — theme files in `themes/` are edited directly (no config folder).

**Leone Orca** and **Leone Forest** — use a code-generated workflow:
- `config/<ThemeName>/palette.json` — named color values (e.g. `"malibu": "#61AFEF"`)
- `config/<ThemeName>/template.json` — VS Code theme JSON with `{{colorName}}` placeholders (from `json-templates`)
- `themes/<ThemeName>-color-theme.json` — **generated output; do not edit manually**

The generator (`config/index.js`) reads the palette and template, resolves placeholders, writes the theme file, updates `package.json`'s `contributes.themes`, and re-packages the `.vsix`.

### Workflow for template-based themes

To change a color: edit `palette.json` or `template.json` in the relevant `config/<ThemeName>/` folder, then run `npm run generate -- --themeName "<ThemeName>"`. The file in `themes/` will be overwritten.
