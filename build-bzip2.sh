#!/bin/bash -ux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d bzip2 ]; then
    mkdir bzip2
fi
cd bzip2
if [ ! -f bzip2-1.0.6.tar.gz ]; then
    wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz -O bzip2-1.0.6.tar.gz
    tar zxvf bzip2-1.0.6.tar.gz --strip-components=1
fi
make clean
make

echo End of $0
ls
