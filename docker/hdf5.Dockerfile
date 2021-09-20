ARG HDF5_VERSION=1_12_1
ARG BASE_TAG=latest
ARG REGISTRY=docker.io
FROM ${REGISTRY}/algodynamic/build-utils:${BASE_TAG} AS build
ARG HDF5_VERSION

RUN wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-${HDF5_VERSION}.tar.gz -O /tmp/hdf5.tar.gz && \
    cd tmp && \
    tar -xf hdf5.tar.gz && \
    mkdir -p hdf5-hdf5-${HDF5_VERSION}/build && \
    cd hdf5-hdf5-${HDF5_VERSION}/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -G Ninja && \
    ninja && \
    cpack -G DEB -B /tmp -D CPACK_PACKAGING_INSTALL_PREFIX=/usr/local . 

FROM ${REGISTRY}/algodynamic/ci-base:${BASE_TAG}
ARG HDF5_VERSION=1.12.1
COPY --from=build /tmp/HDF5-${HDF5_VERSION}-Linux.deb /tmp/
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
    && \
    dpkg -i /tmp/HDF5-${HDF5_VERSION}-Linux.deb && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 100 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 100 && \
    pip3 install --upgrade \
        h5py \
        numpy \
    && \
    rm -rf /tmp/*
