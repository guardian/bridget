# generate TypeScript Native Thrift files 
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir mobile-apps-thrift-typescript ../thrift/native.thrift

# publish TypeScript package to npm
cd mobile-apps-thrift-typescript
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
npm init -y
npm publish --access public



