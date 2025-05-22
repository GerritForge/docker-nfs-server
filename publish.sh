#!/bin/sh

VERSION=3.11.3
PLATFORMS="linux/amd64,linux/arm64"
BUILDER=gerritforge-multiplatform-image-builder

docker buildx create --name $BUILDER --platform "$PLATFORMS" --driver docker-container --use
docker buildx inspect --bootstrap

docker buildx build --no-cache --platform "linux/amd64,linux/arm64" -t gerritforge/docker-nfs-server:$VERSION . --push

echo y | docker buildx prune
docker buildx stop $BUILDER
docker buildx rm $BUILDER
