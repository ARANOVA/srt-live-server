FROM alpine:3 as builder
LABEL org.opencontainers.image.source https://github.com/ARANOVA/srt-live-server

# For latest build deps, see https://github.com/nginxinc/docker-nginx/blob/master/mainline/alpine/Dockerfile
RUN apk update && apk add --no-cache --virtual .build-deps \
  gcc \
  libc-dev \
  make \
  openssl-dev \
  pcre-dev \
  zlib-dev \
  linux-headers \
  alpine-sdk \
  cmake \
  tcl \
  curl \
  gnupg \
  libxslt-dev \
  gd-dev \
  python3 \
  py-pip \
  py-setuptools \
  git \
  ca-certificates \
  geoip-dev bash patch nodejs npm \
  py3-dateutil-pyc py3-magic

ENV XCFLAGS="-march=x86-64 -O3 -pipe"
ENV CFLAGS="-march=x86-64 -O3 -pipe"
ENV XCXXFLAGS="-march=x86-64 -O3 -pipe"
ENV CXXFLAGS="-march=x86-64 -O3 -pipe"

# SLS
RUN git clone https://github.com/Haivision/srt.git /tmp/srt
RUN cd /tmp/srt \
  && git checkout v1.5.3 \
  && ./configure && make && make install
RUN cd /tmp/srt-live-server \
  && make

ENTRYPOINT ["/bin/sh"]