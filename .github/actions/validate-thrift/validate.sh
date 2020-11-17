#!/bin/bash

set -e

git clone https://github.com/guardian/bridget.git

thrift --gen swift:async_servers -r -out ./ bridget/thrift/native.thrift