#!/bin/bash
set -e 

git clone https://github.com/guardian/bridget.git

if thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift; then
    exit 1
else
    exit 0
fi