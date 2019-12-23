# generate TypeScript Native Thrift files 
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir mobile-apps-thrift-typescript ../thrift/native.thrift

# publish TypeScript package to npm
cd mobile-apps-thrift-typescript
npm init -y
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
npm version minor
npm version minor
npm version minor
npm publish --access public

# update git with latest version
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

git add package.json
git commit -m "increase version number"
git push origin master
