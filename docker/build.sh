#!/usr/bin/env bash

set -euo pipefail

GATEWAY_VERSION=1.9.5

# git clone
git clone -q git@github.com:lyft/presto-gateway.git
# build
pushd presto-gateway
mvn --quiet clean install -DskipTests
# get JAR file
cp gateway-ha/target/gateway-ha-$GATEWAY_VERSION-jar-with-dependencies.jar ..
popd
# build docker image
CONTAINER="gateway:${GATEWAY_VERSION}"
docker build . --pull --platform linux/amd64 -f Dockerfile -t ${CONTAINER}-amd64 --build-arg="GATEWAY_VERSION=${GATEWAY_VERSION}"
docker build . --pull --platform linux/arm64 -f Dockerfile -t ${CONTAINER}-arm64 --build-arg="GATEWAY_VERSION=${GATEWAY_VERSION}"
docker image inspect -f '🚀 Built {{.Id}}' ${CONTAINER}-amd64
docker image inspect -f '🚀 Built {{.Id}}' ${CONTAINER}-arm64
# cleanup
rm -rf presto-gateway
rm gateway-ha-$GATEWAY_VERSION-jar-with-dependencies.jar
