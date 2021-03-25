#!/usr/bin/env bash
set -uex -o pipefail

if docker buildx inspect multiarch
then docker buildx use multiarch
else docker buildx create --name multiarch --use
fi

DOCKER_CMD="docker buildx build --platform linux/amd64,linux/arm64 --push --progress=plain"
IMAGE_NAME=leapyear1/vscode-poetry

for PYTHON_VERSION in 3.7.10 3.9.2
do
    ${DOCKER_CMD} --build-arg PYTHON_VERSION="${PYTHON_VERSION}" . -t "${IMAGE_NAME}:$PYTHON_VERSION"
done

# Tag latest
${DOCKER_CMD} --build-arg PYTHON_VERSION=3.9.2 . -t "${IMAGE_NAME}"
