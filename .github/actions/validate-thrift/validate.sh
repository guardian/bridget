#!/bin/bash

if thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift; then
    printf 'Validated Thrift ✅ proceeding to generate packages'
    exit 0
else
    printf 'Invalid Thrift in native.thrift ❌'
    exit 1
fi