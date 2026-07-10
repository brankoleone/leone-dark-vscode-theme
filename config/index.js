const fs = require('fs');
const beautify = require('json-beautify');
const yargs = require('yargs');
const parse = require('json-templates');
const { hideBin } = require('yargs/helpers');

const paletteFileName = 'palette.json';
const templateFileName = 'template.json';
const outputThemesDir = 'themes/';

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
      const paletteFile = `config/${argv.themeName}/${paletteFileName}`;
      const templateFile = `config/${argv.themeName}/${templateFileName}`;
      const themeFile = `${outputThemesDir}/${argv.themeName}-color-theme.json`;

      const templateRawData = fs.readFileSync(templateFile, 'utf8');

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

        const template = parse(JSON.parse(templateRawData));
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
      const paletteFile = `config/${argv.themeName}/${paletteFileName}`;
      const templateFile = `config/${argv.themeName}/${templateFileName}`;
      const themeFile = `${outputThemesDir}/${argv.themeName}-color-theme.json`;

      function generateTheme() {
        let configFileData = null;
        let templateRawData = null;
        try {
          configFileData = fs.readFileSync(paletteFile, 'utf-8');
          templateRawData = fs.readFileSync(templateFile, 'utf8');
        } catch (err) {
          if (err.code !== 'ENOENT') throw err;
          console.log(`There's no such config file: ${err.path}`);
          return;
        }
        if (configFileData && templateRawData) {
          const config = JSON.parse(configFileData);
          const template = parse(JSON.parse(templateRawData));
          const output = beautify(template(config), null, 2, 80);
          fs.writeFile(themeFile, output, (err) => {
            if (err) throw err;
            console.log(`[WATCH] Theme '${argv.themeName}' regenerated: ${themeFile}`);
          });
        }
      }

      console.log(`Watching for changes in ${paletteFile} and ${templateFile}...`);
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
    }
  )
  .help()
  .parse();
