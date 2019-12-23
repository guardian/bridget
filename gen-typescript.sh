# generate TypeScript Native Thrift files 
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir mobile-apps-thrift-typescript ../thrift/native.thrift

# publish TypeScript package to npm
cd mobile-apps-thrift-typescript
npm init -y
echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
npm version minor
npm version minor
npm version minor
npm version minor
npm version minor
npm version minor
npm publish --access public

# update git with latest version
git config --global user.email "GuardianAndroid"
git config --global user.name "GuardianAndroid"

git clone https://github.com/guardian/mobile-apps-thrift.git
cd mobile-apps-thrift
git add package.json
git commit -m "increase version number"
git push origin master
