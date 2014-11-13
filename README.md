# Clay Mobile

### Getting Started
`npm install`
`npm run dev`

### Install pre-commit hook
`ln -s ../../pre-commit.sh .git/hooks/pre-commit`

### Commands
##### `npm run dev` - Start the debug server, watching files
##### `npm test` - Run the test suite (opens Chrome and Firefox)

##### `npm start` - Start the debug server, serving from ./build

##### `NODE_ENV=production npm start` - Start the debug server, serving from ./dist

##### `npm run build` - Compiles + Minifies assets -> ./distf

### HTML
  - Most HTML is in the form of CoffeeScript/"ZML" in the components folder
  - The primary HTML for the page (<head> stuff, etc...) is in index.dust

### Components
  - All component class names should be prefixed with component name

### Stylus
  - Stylus typically coupled with CoffeeScript inside component folders (/src/componets/*component_name*)
  - Base styles are set in /src/stylus
  - Stylus variables located in /src/stylus/vars.json
    - Set if the variable will be used in multiple places
    - All colors should be variables

### Dev Environment
##### Editor: Atom.io
> Plugins
  - Stylus
  - editorconfig
  - linter
  - linter-coffeelint
