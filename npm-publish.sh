RELEASE_TYPE=$1
VERSION=$2

if [ -z "$RELEASE_TYPE" ] || ! [[ "$RELEASE_TYPE" =~ ^(pre)?release$ ]];
then
    echo "Please specify a release type as the 1st argument: prerelease or release";
    exit 1
fi

if [ -z "$VERSION" ];
then
    echo "Please specify a version as the 2nd argument"
    exit 1
fi

# generate TypeScript Thrift files
node_modules/.bin/thrift-typescript --target thrift-server --rootDir . --sourceDir thrift --outDir bridget --strictUnions ../thrift/native.thrift

cd bridget

# create package.json
npm init -y
../node_modules/.bin/json -I -f package.json -e 'this.types="index.d.ts"'
../node_modules/.bin/json -I -f package.json -e 'this.name="@guardian/bridget"'

# generate JavaScript files with type declarations
../node_modules/.bin/tsc --init --declaration --target ES2016
../node_modules/.bin/tsc

# remove TypeScript files
ls | grep "^[A-Za-z]*.ts" | xargs rm

# publish to npm
npm version ${VERSION}

if [ "$RELEASE_TYPE" = "prerelease" ];
then
    echo "Publishing prerelease with version $VERSION"
    npm publish --tag snapshot
else
    echo "Publishing full release with version $VERSION"
    npm publish --access public
fi
