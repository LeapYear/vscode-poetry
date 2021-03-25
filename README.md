# vscode-poetry

Base image for poetry devcontainer in vscode.

Updates are intended to be rolling. Pushes will overwrite previous tags and downstream breakages can
occur at any time. Tags are versioned to match the underlying python version, e.g.:

* python 3.7 -> leapyear1/vscode-poetry:3.7.10
* python 3.9 -> leapyear1/vscode-poetry:3.9.2

Python versions will be supported on an as-needed basis.

## Usage

Login to docker hub and build/push new images. This action will overwrite previous tags.
```
docker login
./build_image.sh
```

## Contents

* Poetry
* Nodejs for pyright/pylance extenstion
* Code climate test reporter (amd64 only)
* CircleCI CLI (requires docker)
* `build-essential` for building wheels
* git, curl, vim
* Supports vscode liveshare extension
* Python 3.7.10 or 3.9.2
* Supports amd64 + arm64
