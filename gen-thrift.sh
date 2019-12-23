# generate TypeScript Native Thrift files 
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir mobile-apps-thrift-typescript ../native.thrift

# generate Swift Webview Thrift files 

# generate Kotlin Webview Thrift files 

# publish TypeScript package to npm
cd mobile-apps-thrift-typescript && npm init -y && npm publish --access public

# publish Swift cocoapod

# publish Kotlin package to Maven?



