# generate TypeScript Native Thrift files 
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir mobile-apps-thrift-typescript ../thrift/native.thrift

# publish TypeScript package to npm
cd mobile-apps-thrift-typescript
npm init -y
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc

git fetch --all
CURRENT_FULL_VERSION="$(git describe --tags --abbrev=0)"

if [ grep "$CURRENT_FULL_VERSION" ../../thrift/native.thrift ] && [ grep "$CURRENT_FULL_VERSION" ../../thrift/webview.thrift ]
then
    npm version ${CURRENT_FULL_VERSION}
    npm publish --access public
else
    echo "THRIFT_PACKAGE_VERSION needs to be bumped to correct version: $CURRENT_FULL_VERSION"
    exit 1
fi
