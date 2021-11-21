const fs = require('fs');
const beautify = require('json-beautify');
const yargs = require('yargs');
const parse = require('json-templates');
const { hideBin } = require('yargs/helpers');

const configFileName = 'config.json';
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
        describe: 'the theme name to be generated',
      });
    },
    function (argv) {
      const configFile = `config/${argv.themeName}/${configFileName}`;
      const templateFile = `config/${argv.themeName}/${templateFileName}`;
      const themeFile = `${outputThemesDir}/${argv.themeName}-color-theme.json`;

      const templateRawData = fs.readFileSync(templateFile, 'utf8');

      let configFileData = null;

      try {
        configFileData = fs.readFileSync(configFile, 'utf-8');
      } catch (err) {
        // If the type is not what you want, then just throw the error again.
        if (err.code !== 'ENOENT') throw err;

        // Handle a file-not-found error
        console.log(`There's no such config file: ${configFile}`);
      }
      if (configFileData) {
        const config = JSON.parse(configFileData);

        const template = parse(JSON.parse(templateRawData));
        const output = beautify(template(config), null, 2, 80);

        fs.writeFile(themeFile, output, (err) => {
          if (err) throw err;
          console.log(`Theme '${argv.themeName}' successfully generated into file: ${themeFile}`);
        });
      }
    }
  )
  .help().argv;
