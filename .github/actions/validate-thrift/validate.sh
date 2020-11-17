#!/bin/bash

git clone https://github.com/guardian/bridget.git

cat bridget/native/native.thrift

thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift

exit 1