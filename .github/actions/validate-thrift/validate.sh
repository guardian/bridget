#!/bin/bash

# Read arguments
export ACCESS_TOKEN=$1
export BRANCH=$2

# Git setup
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

git clone https://github.com/guardian/bridget.git
git fetch
git checkout origin/${BRANCH}
git pull origin ${BRANCH}

cat bridget/thrift/native.thrift

# Validate Thrift
if thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift; then
    printf 'Validated Thrift ✅ proceeding to generate packages'
    exit 0
else
    printf 'Invalid Thrift in native.thrift ❌'
    exit 1
fi