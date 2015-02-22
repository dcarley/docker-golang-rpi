# docker-golang-rpi

[Docker][] container for cross-compiling [Go][] applications with [cgo][] to
run on a [Raspberry Pi][] (`linux/arm`).

[docker]: https://www.docker.com/
[Go]: http://golang.org/
[cgo]: http://golang.org/cmd/cgo/
[Raspberry Pi]: http://www.raspberrypi.org/

I'm not using `CC_FOR_TARGET` because [it currently][golang#8161] prevents
you from building `linux/amd64` applications on the same container. So you
should build using:

    GOARCH=arm GOARM=7 \
    CGO_ENABLED=1 \
    CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ \
    go build

[golang#8161]: https://github.com/golang/go/issues/8161

You can include other cgo dependencies like so:

    RUN apt-get -y install libusb-1.0-0-dev libusb-1.0-0-dev:armhf
