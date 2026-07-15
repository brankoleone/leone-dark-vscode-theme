const fs = require('fs');
const beautify = require('json-beautify');
const yargs = require('yargs');
const parse = require('json-templates');
const { hideBin } = require('yargs/helpers');

const paletteFileName = 'palette.json';
const templateFileName = 'template.json';
const syntaxDirName = 'syntax';
const outputThemesDir = 'themes';

// Neovim output: an optional per-theme `nvim/` config folder generates a Lua
// colorscheme (config/<theme>/nvim/template.lua, with {{colorName}} palette
// placeholders) plus static Treesitter query overrides (config/<theme>/nvim/
// queries/**). Only themes that ship an nvim/ folder produce Neovim output.
const nvimSrcDirName = 'nvim';
const nvimTemplateFileName = 'template.lua';
const nvimQueriesDirName = 'queries';
const outputNvimColorsDir = 'nvim/colors';
const outputNvimQueriesDir = 'nvim/after/queries';

// "Leone Dark" -> "leone-dark" (matches vim.g.colors_name in the template).
function themeSlug(themeName) {
  return themeName
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function copyDirRecursive(src, dest) {
  fs.mkdirSync(dest, { recursive: true });
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const from = `${src}/${entry.name}`;
    const to = `${dest}/${entry.name}`;
    if (entry.isDirectory()) copyDirRecursive(from, to);
    else fs.copyFileSync(from, to);
  }
}

// Generate the Neovim colorscheme + queries for a theme, if it has an nvim/
// source folder. Returns true when nvim output was produced.
function generateNvim(themeName, config) {
  const nvimDir = `config/${themeName}/${nvimSrcDirName}`;
  if (!fs.existsSync(nvimDir)) return false;
  const slug = themeSlug(themeName);

  // 1) Colorscheme: resolve {{palette}} placeholders in the Lua template.
  const templateLua = `${nvimDir}/${nvimTemplateFileName}`;
  if (fs.existsSync(templateLua)) {
    const raw = fs.readFileSync(templateLua, 'utf8');
    const resolved = raw.replace(/\{\{(\w+)\}\}/g, (match, key) => {
      if (Object.prototype.hasOwnProperty.call(config, key)) return config[key];
      console.warn(`[nvim] Unknown palette key {{${key}}} in ${templateLua}`);
      return match;
    });
    fs.mkdirSync(outputNvimColorsDir, { recursive: true });
    const outFile = `${outputNvimColorsDir}/${slug}.lua`;
    fs.writeFileSync(outFile, resolved);
    console.log(`[nvim] Colorscheme generated: ${outFile}`);
  }

  // 2) Treesitter queries: copied verbatim into after/queries (theme-agnostic).
  const queriesSrc = `${nvimDir}/${nvimQueriesDirName}`;
  if (fs.existsSync(queriesSrc)) {
    copyDirRecursive(queriesSrc, outputNvimQueriesDir);
    console.log(`[nvim] Treesitter queries copied into: ${outputNvimQueriesDir}/`);
  }
  return true;
}

// Build the full theme template object by merging the base template.json with
// any per-file-type rule files under config/<theme>/syntax/*.json. Each syntax
// file is a JSON array of tokenColors rules; they are appended (sorted by
// filename) onto the base tokenColors before placeholders are resolved.
function buildTemplate(themeDir) {
  const template = JSON.parse(fs.readFileSync(`${themeDir}/${templateFileName}`, 'utf8'));
  const syntaxDir = `${themeDir}/${syntaxDirName}`;
  if (fs.existsSync(syntaxDir)) {
    if (!Array.isArray(template.tokenColors)) template.tokenColors = [];
    const files = fs
      .readdirSync(syntaxDir)
      .filter((f) => f.endsWith('.json'))
      .sort();
    for (const file of files) {
      const rules = JSON.parse(fs.readFileSync(`${syntaxDir}/${file}`, 'utf8'));
      template.tokenColors = template.tokenColors.concat(rules);
    }
  }
  return template;
}

yargs
  .scriptName('vscode-theme')
  .usage('$0 <cmd> [args]')
  .command(
    'generate [themeName]',
    'generate VSCode theme from colors config file',
    (yargs) => {
      yargs.positional('themeName', {
        type: 'string',
        default: 'Leone Dark',
        describe: 'the theme name to be generated'
      });
    },
    function (argv) {
      const themeDir = `config/${argv.themeName}`;
      const paletteFile = `${themeDir}/${paletteFileName}`;
      const themeFile = `${outputThemesDir}/${argv.themeName}-color-theme.json`;

      let configFileData = null;

      try {
        configFileData = fs.readFileSync(paletteFile, 'utf-8');
      } catch (err) {
        // If the type is not what you want, then just throw the error again.
        if (err.code !== 'ENOENT') throw err;

        // Handle a file-not-found error
        console.log(`There's no such config file: ${paletteFile}`);
      }
      if (configFileData) {
        const config = JSON.parse(configFileData);

        // Neovim colorscheme + queries (no-op unless the theme has an nvim/ folder).
        generateNvim(argv.themeName, config);

        const template = parse(buildTemplate(themeDir));
        const output = beautify(template(config), null, 2, 80);

        fs.mkdirSync(outputThemesDir, { recursive: true });
        fs.writeFile(themeFile, output, (err) => {
          if (err) throw err;
          console.log(`Theme '${argv.themeName}' successfully generated into file: ${themeFile}`);

          // --- Update package.json contributes.themes ---
          const pkgPath = 'package.json';
          let pkgRaw;
          try {
            pkgRaw = fs.readFileSync(pkgPath, 'utf8');
          } catch (e) {
            console.error(`Could not read ${pkgPath}:`, e);
            return;
          }
          let pkg;
          try {
            pkg = JSON.parse(pkgRaw);
          } catch (e) {
            console.error(`Could not parse ${pkgPath}:`, e);
            return;
          }
          if (!pkg.contributes) pkg.contributes = {};
          if (!pkg.contributes.themes) pkg.contributes.themes = [];

          const themeLabel = argv.themeName;
          const themePath = `./themes/${argv.themeName}-color-theme.json`;
          const exists = pkg.contributes.themes.some(
            (t) => t.label === themeLabel && t.path === themePath
          );
          if (!exists) {
            pkg.contributes.themes.push({
              label: themeLabel,
              uiTheme: 'vs-dark',
              path: themePath
            });
            try {
              fs.writeFileSync(pkgPath, beautify(pkg, null, 2, 80));
              console.log(`Updated contributes.themes in ${pkgPath}`);
            } catch (e) {
              console.error(`Could not update ${pkgPath}:`, e);
            }
          }

          // --- Generate or update the .vsix file ---
          // Skip packaging when invoked from the standalone packaging script,
          // which handles vsce itself (avoids double-packaging).
          if (process.env.SKIP_VSIX === '1') {
            return;
          }
          const { exec } = require('child_process');
          exec('pnpm dlx @vscode/vsce package', (error, stdout, stderr) => {
            if (error) {
              console.error(`Error generating .vsix: ${error.message}`);
              return;
            }
            if (stderr) {
              console.error(`vsce stderr: ${stderr}`);
            }
            console.log(`.vsix package generated/updated:\n${stdout}`);
          });
        });
      }
    }
  )
  .command(
    'watch [themeName]',
    'watch palette/template files and regenerate theme on change',
    (yargs) => {
      yargs.positional('themeName', {
        type: 'string',
        default: 'Leone Dark',
        describe: 'the theme name to be watched'
      });
    },
    function (argv) {
      const themeDir = `config/${argv.themeName}`;
      const paletteFile = `${themeDir}/${paletteFileName}`;
      const templateFile = `${themeDir}/${templateFileName}`;
      const syntaxDir = `${themeDir}/${syntaxDirName}`;
      const themeFile = `${outputThemesDir}/${argv.themeName}-color-theme.json`;

      function generateTheme() {
        let configFileData = null;
        try {
          configFileData = fs.readFileSync(paletteFile, 'utf-8');
        } catch (err) {
          if (err.code !== 'ENOENT') throw err;
          console.log(`There's no such config file: ${err.path}`);
          return;
        }
        if (configFileData) {
          const config = JSON.parse(configFileData);
          generateNvim(argv.themeName, config);
          const template = parse(buildTemplate(themeDir));
          const output = beautify(template(config), null, 2, 80);
          fs.mkdirSync(outputThemesDir, { recursive: true });
          fs.writeFile(themeFile, output, (err) => {
            if (err) throw err;
            console.log(`[WATCH] Theme '${argv.themeName}' regenerated: ${themeFile}`);
          });
        }
      }

      console.log(`Watching for changes in ${paletteFile}, ${templateFile} and ${syntaxDir}/...`);
      generateTheme();

      fs.watch(paletteFile, { persistent: true }, (eventType) => {
        if (eventType === 'change') {
          generateTheme();
        }
      });
      fs.watch(templateFile, { persistent: true }, (eventType) => {
        if (eventType === 'change') {
          generateTheme();
        }
      });
      if (fs.existsSync(syntaxDir)) {
        fs.watch(syntaxDir, { persistent: true }, () => {
          generateTheme();
        });
      }
      const nvimDir = `${themeDir}/${nvimSrcDirName}`;
      if (fs.existsSync(nvimDir)) {
        fs.watch(nvimDir, { persistent: true, recursive: true }, () => {
          generateTheme();
        });
      }
    }
  )
  .help()
  .parse();
