#!/bin/bash

# Use this script to generate local TS package files for use in local developement

# Final Step: 
# navigate to the the local project directory where you want to use 
# this snapshot and run: yarn link @guardian/bridget
# More info: https://classic.yarnpkg.com/lang/en/docs/cli/link/

# generate TypeScript Thrift files
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir dist/bridget --strictUnions ../thrift/native.thrift

cd dist/bridget

# create package.json
npm init -y
../../node_modules/.bin/json -I -f package.json -e 'this.types="index.d.ts"'
../../node_modules/.bin/json -I -f package.json -e 'this.name="@guardian/bridget"'
../../node_modules/.bin/json -I -f package.json -e 'this.version="SNAPSHOT"' 

# generate JavaScript files with type declarations
../../node_modules/.bin/tsc --init --declaration --target ES2016
../../node_modules/.bin/tsc

# remove TypeScript files
ls | grep "^[A-Za-z]*.ts" | xargs rm


# creates symlink here: cd ~/.config/yarn/link
# navigate to the the local project directory you want to use this snapshot in and run: yarn link @guardian/bridget
yarn link
 
