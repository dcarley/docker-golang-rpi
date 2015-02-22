FROM ubuntu:14.04

RUN sed -i "s/^deb /deb \[arch=$(dpkg --print-architecture)] /" /etc/apt/sources.list
RUN for SUFFIX in "" "-updates" "-security"; do \
  echo "deb [arch=armhf] http://ports.ubuntu.com/ubuntu-ports/ $(lsb_release -sc)${SUFFIX} main restricted universe multiverse" \
    >> /etc/apt/sources.list.d/armhf.list; \
  done

RUN dpkg --add-architecture armhf
RUN apt-get -y update
RUN apt-get -y install \
  pkg-config \
  gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf

RUN apt-get -y --no-install-recommends install \
  curl build-essential ca-certificates \
  git mercurial bzr

RUN mkdir /goroot /gopath
RUN curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz \
  | tar xvzf - -C /goroot --strip-components=1
RUN cd /goroot/src && GOARCH=arm GOARM=7 ./make.bash

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin
