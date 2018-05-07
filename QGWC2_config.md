# QGIS WEB CLIENT 2 CONFIGURATION

Clone the demo repository from GitHub and modify it locally

> git clone --recursive https://github.com/qgis/qwc2-demo-app.git
> cd qwc2-demo-app
> yarn install
> yarn start

If demo applications fails to start due to dependency errors, resolve errors by installing missing packages

Run Python on Windows for NodeJS dependencies
> npm install --global -production windows-build-tools
node-gyp is a cross-platform command-line tool written in Node.js for compiling native addon modules for Node.js
> npm install -g node-gyp
> npm install node-fqdn --save
> npm install libxmljs
> npm install deepmerge
> npm install axios
> npm install xml2js
> npm install lodash.isempty

Install webpack-dev-server that serves a webpack app.
> npm install webpack --save-dev
> npm install webpack-dev-server --save-dev
> npm install --save lodash
> npm install --save-dev lodash-webpack-plugin babel-core babel-loader babel-plugin-lodash babel-preset-env webpack
> npm install -D uglifyjs-webpack-plugin

Uninstall fsevents on Windows
> npm uninstall fsevents

Run local development environment
> yarn start