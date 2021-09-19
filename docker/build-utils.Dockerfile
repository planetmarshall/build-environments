FROM ubuntu:20.04

ARG CMAKE_VERSION=3.21.2
ARG CMAKE_VERSION_SHORT=3.21
ARG CLANG_VERSION=13

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        gnupg \
        software-properties-common \
        libbz2-dev \
        libffi-dev \
        liblzma-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxmlsec1-dev \
        ninja-build \
        wget \
        xz-utils \
        zlib1g-dev \
        && \
    wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz -O /tmp/cmake.tar.gz && \
    tar -xf /tmp/cmake.tar.gz -C /usr/local/ --strip-components=1 \
         --exclude=bin/cmake-gui \
         --exclude=doc \
         --exclude=share/cmake-${CMAKE_VERSION_SHORT}/Help && \
    rm -rf /tmp/*

USER root