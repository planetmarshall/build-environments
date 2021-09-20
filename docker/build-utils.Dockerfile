FROM ubuntu:20.04

ARG CMAKE_VERSION=3.21.2
ARG CMAKE_VERSION_SHORT=3.21

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London"

RUN add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        git \
        gnupg \
        software-properties-common \
        libbz2-dev \
        libffi-dev \
        liblzma-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxmlsec1-dev \
        ninja-build \
        python3 \
        python3-pip \
        wget \
        xz-utils \
        zlib1g-dev \
        && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends \
      git-lfs \
    && \
    wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz -O /tmp/cmake.tar.gz && \
    tar -xf /tmp/cmake.tar.gz -C /usr/local/ --strip-components=1 \
         --exclude=bin/cmake-gui \
         --exclude=doc \
         --exclude=share/cmake-${CMAKE_VERSION_SHORT}/Help && \
    rm -rf /tmp/*

USER root