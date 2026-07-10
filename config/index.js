const fs = require('fs');
const beautify = require('json-beautify');
const yargs = require('yargs');
const parse = require('json-templates');
const { hideBin } = require('yargs/helpers');

const paletteFileName = 'palette.json';
const templateFileName = 'template.json';
const syntaxDirName = 'syntax';
const outputThemesDir = 'themes/';

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
        default: 'Leone Craft',
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

        const template = parse(buildTemplate(themeDir));
        const output = beautify(template(config), null, 2, 80);

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
          exec('npx --yes @vscode/vsce package', (error, stdout, stderr) => {
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
        default: 'Leone Craft',
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
          const template = parse(buildTemplate(themeDir));
          const output = beautify(template(config), null, 2, 80);
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
    }
  )
  .help()
  .parse();
