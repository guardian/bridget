#!/bin/sh -e

# Git setup
export ACCESS_TOKEN=$1
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

# Checkout thrift files
git clone https://github.com/guardian/mobile-apps-thrift.git

# Generate Swift Files (these will be output into gen-swift folder)
thrift --gen swift -r mobile-apps-thrift/thrift/webview.thrift

# Set tag from mobile-apps-thrift 
CURRENT_FULL_VERSION="$(git describe --tags --abbrev=0)"

# Commit changes
git clone https://github.com/guardian/mobile-apps-thrift-swift.git
rm -rf mobile-apps-thrift-swift/Sources/MobileAppsThriftSwift
mkdir -p mobile-apps-thrift-swift/Sources/MobileAppsThriftSwift
cp -r gen-swift/*.swift mobile-apps-thrift-swift/Sources/MobileAppsThriftSwift/
cd mobile-apps-thrift-swift
git add *.swift
git commit -m "Update Swift models"

# Tag the new version
git tag $CURRENT_FULL_VERSION

# Push the changes (and tags)
git push -u origin master
git push --tags