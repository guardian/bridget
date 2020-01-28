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
    
    # Check out the Swift repo and delete all existing source files
    git clone https://github.com/guardian/mobile-apps-thrift-swift.git
    rm -rf mobile-apps-thrift-swift/Sources/mobile-apps-thrift-swift
    mkdir -p mobile-apps-thrift-swift/Sources/mobile-apps-thrift-swift

    # Generate new Swift source files
    thrift --gen swift -r -out mobile-apps-thrift-swift/Sources/mobile-apps-thrift-swift mobile-apps-thrift/thrift/webview.thrift
    thrift --gen swift:async_clients -r -out mobile-apps-thrift-swift/Sources/mobile-apps-thrift-swift mobile-apps-thrift/thrift/native.thrift

    # Commit changes
    cd mobile-apps-thrift-swift
    
    if [[ -n `git diff` ]]; then
        git add Sources/mobile-apps-thrift-swift/*.swift
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
