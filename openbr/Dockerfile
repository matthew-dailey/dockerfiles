# starting from Ubuntu, as per build instructions, but could probably use Debian
FROM ubuntu:14.04

# install build tools and Qt5, then clean up after apt-get
RUN apt-get update -y && apt-get install -y --no-install-recommends\
    ca-certificates \
    cmake \
    curl \
    g++ \
    git \
    libqt5svg5-dev \
    make \
    qt5-default \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV OPENCV_VERSION=2.4.5
ENV OPENCV_DIR=/usr/opencv-${OPENCV_VERSION}

# must install our own OpenCV 2.4.5
RUN mkdir -p /usr/opencv && \
    curl -sSL https://github.com/Itseez/opencv/archive/${OPENCV_VERSION}.tar.gz \
      | tar -v -C /usr -xz && \
    mkdir -p ${OPENCV_DIR}/build && \
    cd ${OPENCV_DIR}/build && \
    cmake -DCMAKE_BUILD_TYPE=Release ${OPENCV_DIR} && \
    make -j 4 && make install && \
    rm -rf ${OPENCV_DIR}

# Could pull down the source tarball rather than use Git, but the submodules contain
# models needed by the software, so we'll use OpenBR's install instructions
RUN git clone https://github.com/biometrics/openbr.git /usr/openbr && \
    cd /usr/openbr && \
    git checkout 0.5 && \
    git submodule init && \
    git submodule update && \
    mkdir -p /usr/openbr/build && \
    cd /usr/openbr/build && \
    cmake -DCMAKE_BUILD_TYPE=Release /usr/openbr && \
    make -j 4 && make install && \
    rm -rf /usr/openbr

# Running the builtin tests takes too long for the build (30-60 minutes to download
# the sample data), so we'll leave that as an exercise for the reader.
# RUN cd /usr/openbr/scripts && \
#    ./downloadDatasets.sh && \
#    cd /usr/openbr/build && \
#    make test

### Setup runtime
ENV WORKING_DIR=/usr/openbr
RUN mkdir -p ${WORKING_DIR}
WORKDIR ${WORKING_DIR}

# run this container like the 'br' command,
# and 'br -help' as no-parameter invocation
ENTRYPOINT ["br"]
CMD ["-help"]
