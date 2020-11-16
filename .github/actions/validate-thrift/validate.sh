#!/bin/bash
set -e 

git clone https://github.com/guardian/bridget.git

if thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift; then
    printf 'Validated thrift ✅ Proceed to generating packages'
    exit 1
else
    printf 'Invalid thrift in native.thrift ❌'
    exit 0
fi