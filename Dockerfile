FROM fedora:21

ENV SOURCE_URL=http://files.byuu.org/download/higan_v094-source.tar.xz
ENV SOURCE_DIR=/usr/higan_v094-source

RUN yum install -y \
    alsa-lib-devel \
    ca-certificates \
    curl \
    gcc-c++ \
    gtk2-devel \
    libao-devel \
    libX11-devel \
    libXv-devel \
    make \
    openal-soft-devel \
    pulseaudio-libs-devel \
    SDL-devel \
    sudo \
    systemd-devel \
    tar

RUN curl -sSL ${SOURCE_URL} | tar -vxJ -C /usr && \
    cd ${SOURCE_DIR} && make -j4 && make install && \
    rm ${SOURCE_DIR} -rf

WORKDIR /
ENTRYPOINT ["higan"]
