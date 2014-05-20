#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d yasm ]; then
    mkdir yasm
fi
cd yasm
if [ ! -f yasm-1.2.0.tar.gz ]; then
    wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz -O yasm-1.2.0.tar.gz
    tar zxvf yasm-1.2.0.tar.gz --strip-components=1
fi
./configure --prefix="/mingw"
make clean
make && make install

echo End of $0
ls
