#!/bin/bash

# Read arguments
export ACCESS_TOKEN=$1
export PLATFORM=$2

# Git setup
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

# Checkout thrift files
git clone https://github.com/guardian/mobile-apps-thrift.git

# Set tag from mobile-apps-thrift
cd mobile-apps-thrift
CURRENT_VERSION="$(git describe --tags --abbrev=0)"
cd ../

# Platform tasks
if [ "$PLATFORM" == "ios" ]; then
    # Generate Swift Files (these will be output into gen-swift folder)
    thrift --gen swift -r mobile-apps-thrift/thrift/webview.thrift
    thrift --gen swift -r mobile-apps-thrift/thrift/native.thrift

    # Commit changes
    git clone https://github.com/guardian/bridget-swift.git
    rm -rf mobile-apps-thrift-swift/Sources/Bridget
    mkdir -p mobile-apps-thrift-swift/Sources/Bridget
    cp -r gen-swift/*.swift mobile-apps-thrift-swift/Sources/Bridget/
    cd Bridget

    if [[ -n `git diff` ]]; then
        git add Sources/Bridget/*.swift
        git commit -m "Update Swift models $CURRENT_VERSION"
        git tag $CURRENT_VERSION
        git push origin master
        git push --tags
    fi
elif [ "$PLATFORM" == "android" ]; then
    thrift --gen java -r mobile-apps-thrift/thrift/webview.thrift
    ls gen-java
else
    echo "Unrecognised platform. Please specify \"ios\" or \"android\" as the second argument"
fi
