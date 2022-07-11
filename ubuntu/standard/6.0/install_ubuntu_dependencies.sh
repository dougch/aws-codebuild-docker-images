#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License is located at
#
#  http://aws.amazon.com/apache2.0
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.
#

# Shim code to get local docker/ec2 instances bootstraped like a CodeBuild instance.
# Not actually used by CodeBuild.

set -ex
if [ -f "codebuild/bin/s2n_setup_env.sh" ]; then
	source codebuild/bin/s2n_setup_env.sh
fi

add-apt-repository ppa:ubuntu-toolchain-r/test -y
add-apt-repository ppa:longsleep/golang-backports -y
apt-get update -o Acquire::CompressionTypes::Order::=gz
apt-get update -y

GCC_VERSIONS="6 9 10"
for GCC_VERSION in "$GCC_VERIONS"; do
    DEPENDENCIES+=" gcc-$GCC_VERSION g++-$GCC_VERSION";
done

DEPENDENCIES="build-essential gcc g++ unzip make indent kwstyle libssl-dev tcpdump valgrind lcov m4 nettle-dev nettle-bin pkg-config"
DEPENDENCIES2="zlib1g zlib1g-dev python3-pip python3-testresources llvm curl git tox cmake libtool ninja-build golang-go quilt util-linux"


apt-get -y install --no-install-recommends ${DEPENDENCIES}
apt-get -y install --no-install-recommends ${DEPENDENCIES2}

