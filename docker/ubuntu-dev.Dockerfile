ARG UBUNTU_VERSION=18.04
ARG REGISTRY=docker.io
FROM ${REGISTRY}/algodynamic/hdf5:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        cmake \
        python3 \
        python3-pip && \
    python3 -m pip install pip --upgrade \
    pip install conan
