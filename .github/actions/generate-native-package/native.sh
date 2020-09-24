#!/bin/bash

# Read arguments
export ACCESS_TOKEN=$1
export PLATFORM=$2

# Git setup
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

# Checkout thrift files
git clone https://github.com/guardian/bridget.git

# Set tag from mobile-apps-thrift
cd bridget
CURRENT_VERSION="$(git describe --tags --abbrev=0)"
cd ../

# Add version const to thrift file
echo "" >> bridget/thrift/native.thrift
echo "const string BRIDGET_VERSION = \"$CURRENT_VERSION\"" >>  bridget/thrift/native.thrift

# Platform tasks
if [ "$PLATFORM" == "ios" ]; then

    # Check out the Swift repo and delete all existing source files
    git clone https://github.com/guardian/bridget-swift.git
    rm -rf bridget-swift/Sources/Bridget
    mkdir -p bridget-swift/Sources/Bridget

    thrift --gen swift:async_servers -r -out bridget-swift/Sources/Bridget bridget/thrift/native.thrift

    # Commit changes
    cd bridget-swift
    if [[ -n `git diff` ]]; then
        git add Sources/Bridget/*.swift
        git commit -m "Update Swift models $CURRENT_VERSION"
        git tag $CURRENT_VERSION
        git push origin main
        git push --tags
    fi
elif [ "$PLATFORM" == "android" ]; then
    ls gen-java
else
    echo "Unrecognised platform. Please specify \"ios\" or \"android\" as the second argument"
fi
