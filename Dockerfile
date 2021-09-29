ARG VARIANT=ubuntu-20.04
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get remove -y software-properties-common && apt-get autoremove -y

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y && \
    apt-get install -y ninja-build \
        libasound2-dev \
        libavcodec-dev \
        libavformat-dev \
        libavformat-dev \
        libavutil-dev \
        libboost-dev \
        libcurl4-openssl-dev \
        libgtk-3-dev \
        libgif-dev \
        libgl1-mesa-glx \
        libglu1-mesa-dev \
        libharfbuzz-dev \
        libmpg123-dev \
        libopencv-dev \
        libopus-dev \
        libopusfile-dev \
        libsoundtouch-dev \
        libswresample-dev \
        libtiff-dev \
        libturbojpeg0-dev \
        libvorbis-dev \
        libwebp-dev \
        libxft-dev \
        uuid-dev \
        mesa-utils \
        xorg-dev

WORKDIR /usr/home

RUN curl -So OpenSiv3D https://codeload.github.com/Siv3D/OpenSiv3D/zip/refs/heads/main && \
    unzip OpenSiv3D && \
    rm -rf OpenSiv3D \ 
    OpenSiv3D-main/macOS \
    OpenSiv3D-main/Siv3D/lib \
    OpenSiv3D-main/Siv3D/include/lib \
    OpenSiv3D-main/Siv3D/include/Siv3D/Windows \
    OpenSiv3D-main/Siv3D/src/Siv3D-Platform/macOS \
    OpenSiv3D-main/Siv3D/src/Siv3D-Platform/OpenGLES3 \
    OpenSiv3D-main/Siv3D/src/Siv3D-Platform/Web \
    OpenSiv3D-main/Siv3D/src/Siv3D-Platform/WindowsDesktop \
    OpenSiv3D-main/Web \
    OpenSiv3D-main/WindowsDesktop

WORKDIR /usr/home/OpenSiv3D-main/Linux/build

RUN cmake -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo ..

WORKDIR /usr/home/OpenSiv3D-main/Linux

RUN cmake --build build

RUN rm -rf \ 
    /usr/home/OpenSiv3D-main/Linux/build/CMakeFiles
    