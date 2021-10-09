ARG UBUNTU_VERSION=20.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        gnupg \
        software-properties-common \
        wget \
    && \
    add-apt-repository ppa:git-core/ppa && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends \
      git \
      git-lfs

USER root
