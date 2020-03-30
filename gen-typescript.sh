# generate TypeScript Thrift files
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir bridget-typescript ../thrift/native.thrift
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir bridget-typescript ../thrift/webview.thrift

cd bridget-typescript

# create package.json
npm init -y
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
npx json -I -f package.json -e 'this.types="index.d.ts"'

# generate JavaScript files with type declarations
npm i typescript -g
npx tsc --init --declaration --target ES2016
npx tsc

# remove TypeScript files
ls | grep "^[A-Za-z]*.ts" | xargs rm

# use repo tag for version
git fetch --all
CURRENT_FULL_VERSION="$(git describe --tags --abbrev=0)"

# publish to npm
npm version ${CURRENT_FULL_VERSION}
npm publish --access public
