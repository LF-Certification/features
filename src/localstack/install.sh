#!/bin/bash -i

set -e

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations, 
# and if missing - will download a temporary copy that automatically get deleted at the end 
# of the script
ensure_nanolayer nanolayer_location "v0.4.39"


$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-contrib/features/apt-get-packages:1.0.4" \
    --option packages='build-essential,libsasl2-dev,g++'


$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers/features/docker-in-docker:2.1.0" \
    --option installDockerBuildx='false'


$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers/features/python:1.1.0" \
    --option installTools='false' --option OVERRIDEDEFAULTVERSION='false' --option version='3.10.8'


$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-contrib/features/pipx-package:1.1.5" \
    --option package='localstack[runtime]' --option version="$VERSION" --option includeDeps='true' --option interpreter='/usr/local/python/3.10.8/bin/python3'


$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-contrib/features/bash-command:1.0.0" \
    --option command='mkdir -p /var/lib/localstack && chown -R $_REMOTE_USER /var/lib/localstack && chgrp -R docker /var/lib/localstack && chmod -R 775 /var/lib/localstack'


echo 'Done!'

