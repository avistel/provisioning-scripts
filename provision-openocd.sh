#!/bin/bash
apt-get update
apt-get install -y git gcc make libtool pkg-config autoconf automake libusb-1.0.0-dev
cd /vagrant
if ! [ $(openocd --version) ]; then
    if ! [ -e "openocd" ] && [ -d "openocd" ]; then
        git clone https://github.com/ntfreak/openocd.git
    fi

    if [ -e "openocd" ] && [ -d "openocd" ]; then
        cd ./openocd
        ./bootstrap
        ./configure
        make
        make install
    else
        echo "Failed to get openocd repo."
        exit 1
    fi
fi

if [ $(openocd --version) ]; then
    echo "Failed to compile/install openocd."
    exit 1
fi
