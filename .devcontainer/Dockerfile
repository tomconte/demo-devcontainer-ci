# [Choice] dotnet version (use -bullseye variants on local arm64/Apple Silicon): 6.0, 6.0-bullseye
ARG VARIANT=6.0-bullseye
FROM mcr.microsoft.com/devcontainers/dotnet:${VARIANT}

# Install some basic packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y sudo git curl wget make unzip

COPY install-func.sh /tmp

RUN /bin/bash -x /tmp/install-func.sh && rm /tmp/install-func.sh
