FROM ubuntu:20.04

COPY . /brave

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -yq \
    build-essential \
    cmake \
    gcc \
    git \ 
    libffi7 libffi-dev \
    gobject-introspection \
    gstreamer1.0-libav \
    gstreamer1.0-nice \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-tools \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gir1.2-gst-plugins-bad-1.0 \ 
    libcairo2-dev \
    libgirepository1.0-dev \
    pkg-config \
    python3-dev \
    python3-wheel \
    python3-gst-1.0 \
    python3-pip \
    python3-gi \
    python3-websockets \
    python3-psutil \
    python3-uvloop \
    libtiff5-dev \
    libjpeg8-dev \
    libopenjp2-7-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    tcl8.6-dev \
    tk8.6-dev \
    python3-tk \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    libnss3-dev \
    libnspr4-dev \
    libatk1.0-dev

RUN cd brave/gst-WebRenderSrc && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make && make install

RUN cd brave && \
    pip3 install pipenv sanic && \
    pipenv install --ignore-pipfile && \
    mkdir -p /usr/local/share/brave/output_images/

EXPOSE 5000
WORKDIR /brave
CMD ["pipenv", "run", "/brave/brave.py"]
