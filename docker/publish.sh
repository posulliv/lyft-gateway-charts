#!/bin/sh

set -eux

VERSION=$1
NAME=posulliv/gateway
IMAGE=gateway:$VERSION
TARGET=$NAME:$VERSION

./build.sh

docker tag $IMAGE-amd64 $TARGET-amd64
docker tag $IMAGE-arm64 $TARGET-arm64
docker push $TARGET-amd64
docker push $TARGET-arm64

docker manifest create $TARGET $TARGET-amd64 $TARGET-arm64
docker manifest push --purge $TARGET

docker manifest create $NAME:latest $TARGET-amd64 $TARGET-arm64
docker manifest push --purge $NAME:latest
