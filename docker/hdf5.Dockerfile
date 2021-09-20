ARG HDF5_VERSION=1_12_1
FROM algodynamic/build-utils:latest AS build
ARG HDF5_VERSION

RUN wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5-${HDF5_VERSION}.tar.gz -O /tmp/hdf5.tar.gz && \
    cd tmp && \
    tar -xf hdf5.tar.gz && \
    mkdir -p hdf5-hdf5-${HDF5_VERSION}/build && \
    cd hdf5-hdf5-${HDF5_VERSION}/build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -G Ninja && \
    ninja && \
    cpack -G DEB -B /tmp -D CPACK_PACKAGING_INSTALL_PREFIX=/usr/local . 

FROM ubuntu:20.04
ARG HDF5_VERSION=1.12.1
COPY --from=build /tmp/HDF5-${HDF5_VERSION}-Linux.deb /tmp/
RUN dpkg -i /tmp/HDF5-${HDF5_VERSION}-Linux.deb && \
    pip3 install --upgrade \
        h5py \
        numpy
