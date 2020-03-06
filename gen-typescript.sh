# generate TypeScript Native Thrift files 
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir bridget-typescript ../thrift/native.thrift
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir bridget-typescript ../thrift/webview.thrift

# publish TypeScript package to npm
cd bridget-typescript
npm init -y
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc

git fetch --all
CURRENT_FULL_VERSION="$(git describe --tags --abbrev=0)"

npm version ${CURRENT_FULL_VERSION}
npm publish --access public
