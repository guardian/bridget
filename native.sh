#!/bin/sh -e

# Git setup
export ACCESS_TOKEN=$1
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

# Checkout thrift files
git clone https://github.com/guardian/mobile-apps-thrift.git

# Generate Swift Files (these will be output into gen-swift folder)
thrift --gen swift -r mobile-apps-thrift/thrift/webview.thrift

# Commit changes
git clone https://github.com/guardian/mobile-apps-thrift-swift.git
rm -rf mobile-apps-thrift-swift/Sources/WebviewThrift
mkdir -p mobile-apps-thrift-swift/Sources/WebviewThrift
cp -r gen-swift/*.swift mobile-apps-thrift-swift/Sources/WebviewThrift/
cd mobile-apps-thrift-swift
git add *.swift
git commit -m "Update Swift models"

# Tag the new version
CURRENT_FULL_VERSION="$(git describe --tags --abbrev=0)"
echo "Current full version is $CURRENT_FULL_VERSION"

CURRENT_MAJOR_VERSION="$(echo $CURRENT_FULL_VERSION | cut -d . -f1)"
CURRENT_MINOR_VERSION="$(echo $CURRENT_FULL_VERSION | cut -d . -f2)"
NEW_FULL_VERSION="$CURRENT_MAJOR_VERSION.$(expr $CURRENT_MINOR_VERSION + 1).0"
echo "New full version is $NEW_FULL_VERSION"

git tag $NEW_FULL_VERSION

# Push the changes (and tags)
git push -u origin master
git push --tags