#!/usr/bin/env bash

if docker buildx inspect multiarch
then docker buildx use multiarch
else docker buildx create --name multiarch --use
fi

docker buildx build --platform linux/amd64,linux/arm64 --push --progress=plain . -t leapyear1/vscode-poetry
