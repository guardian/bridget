#!/bin/bash

if thrift --gen swift:async_servers -r -out ./ thrift/native.thrift; then
    printf 'Validated Thrift ✅'
    exit 0
else
    printf 'Invalid Thrift in native.thrift ❌'
    exit 1
fi