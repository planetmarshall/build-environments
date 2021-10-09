ARG UBUNTU_VERSION=18.04
ARG REGISTRY=docker.io
FROM ${REGISTRY}/algodynamic/hdf5:${UBUNTU_VERSION}

ARG BOOST_VERSION=1.77.0
ARG BOOST_VERSION_FILE=1_77_0
ARG CATCH_VERSION=2.13.7

ENV DEBIAN_FRONTEND="noninteractive" \
    TZ="Europe/London"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        cmake \
        python3 \
        python3-pip && \
    python3 -m pip install pip --upgrade
RUN wget https://boostorg.jfrog.io/artifactory/main/release/${BOOST_VERSION}/source/boost_${BOOST_VERSION_FILE}.tar.bz2 -O /tmp/boost.tar.bz2 && \
    cd /tmp && \
    tar -xf boost.tar.bz2 && \
    cd boost_${BOOST_VERSION_FILE} && \
    ./bootstrap.sh && \
    ./b2 install || true
RUN wget https://github.com/catchorg/Catch2/archive/refs/tags/v${CATCH_VERSION}.tar.gz -O /tmp/catch.tar.gz && \
    tar -xf /tmp/catch.tar.gz && \
    cd Catch2-${CATCH_VERSION} && \
    mkdir build && \
    cd build && \
    cmake .. -DCATCH_BUILD_TESTING=OFF && \
    cmake --build . --target install && \
    cd / && \
    rm -rf /tmp/* && \
    apt-get clean
