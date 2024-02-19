#!/bin/bash

# Read arguments
export ACCESS_TOKEN=$1
export PLATFORM=$2
export RELEASE_TYPE=$3

if [ -z "$RELEASE_TYPE" ] || ! [[ "$RELEASE_TYPE" =~ ^(pre)?release$ ]];
then
    echo "Missing release type as the 3rd argument. Possible values:";
    echo "prerelease"
    echo "release"
    exit 1
fi

# Git setup
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

# Checkout thrift files
git clone https://github.com/guardian/bridget.git

cd bridget
git checkout $GITHUB_REF
CURRENT_VERSION="$(git describe --tags --abbrev=0)"
# Add a -branch suffix so the prerelease tag and branch do not have the same name
PRERELEASE_BRANCH_NAME="$CURRENT_VERSION-branch"
cd ../

# Add version const to thrift file
echo "" >> bridget/thrift/native.thrift
echo "const string BRIDGET_VERSION = \"$CURRENT_VERSION\"" >>  bridget/thrift/native.thrift

echo "Publishing $RELEASE_TYPE to platform $PLATFORM with version $CURRENT_VERSION"
# Platform tasks
if [ "$PLATFORM" == "ios" ]; then

    # Check out the Swift repo and delete all existing source files
    git clone https://github.com/guardian/bridget-swift.git


    if [ "$RELEASE_TYPE" = "prerelease" ];
    then
        cd bridget-swift
        git checkout -b $PRERELEASE_BRANCH_NAME
        cd ..
    fi
    rm -rf bridget-swift/Sources/Bridget
    mkdir -p bridget-swift/Sources/Bridget

    thrift --gen swift:async_servers -r -out bridget-swift/Sources/Bridget bridget/thrift/native.thrift

    # Commit changes
    cd bridget-swift
    if [[ -n `git diff` ]]; then
        git add Sources/Bridget/*.swift
        git commit -m "Update Swift models $CURRENT_VERSION"
        if [ "$RELEASE_TYPE" = "prerelease" ];
        then
            git push -u origin $PRERELEASE_BRANCH_NAME
        else
            git push origin main
        fi
        git tag $CURRENT_VERSION
        git push --tags
    fi
elif [ "$PLATFORM" == "android" ]; then

    # Check out the bridget-android repo and delete all existing source files
    git clone https://github.com/guardian/bridget-android.git

    if [ "$RELEASE_TYPE" = "prerelease" ];
    then
        cd bridget-android
        git checkout -b $PRERELEASE_BRANCH_NAME
        cd ..
    fi

    rm -rf bridget-android/library/src/main
    
    # Create fresh directories
    mkdir -p bridget-android/library/src/main/thrift
    mkdir -p bridget-android/library/src/main/java


    # Prefix package name in thrift file and copy it to the bridget-android repo
    cat <(echo -e "namespace java com.theguardian.bridget.thrift\n") bridget/thrift/native.thrift > bridget/thrift/native_temp.thrift && mv bridget/thrift/native_temp.thrift bridget/thrift/native.thrift
    cp bridget/thrift/native.thrift bridget-android/library/src/main/thrift
    
    # Generate thrift classes
    thrift -gen java:generated_annotations=undated -out bridget-android/library/src/main/java/ bridget-android/library/src/main/thrift/native.thrift

    # Commit changes and tag the current version
    cd bridget-android
    if [[ -n `git diff` ]]; then
        git add library/src/main/*
        git commit -m "Update Thrift generated classes $CURRENT_VERSION"
        if [ "$RELEASE_TYPE" = "prerelease" ];
        then
            git push -u origin $PRERELEASE_BRANCH_NAME
        else
            git push origin main
        fi
        git tag $CURRENT_VERSION
        git push --tags
    fi
else
    echo "Unrecognised platform. Please specify \"ios\" or \"android\" as the second argument"
fi
