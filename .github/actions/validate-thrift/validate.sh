#!/bin/bash
set -e

# Read arguments
export ACCESS_TOKEN=$1
export PLATFORM=$2

# Git setup
git config --global credential.helper "/bin/bash /credential-helper.sh"
git config --global user.email '<>'

git clone https://github.com/guardian/bridget.git

# Validate Thrift
if thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift; then
    printf 'Validated Thrift ✅ proceeding to generate packages'
    exit 1
else
    printf 'Invalid Thrift in native.thrift ❌'
    exit 0
fi