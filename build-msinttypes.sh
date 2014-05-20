#!/bin/bash -ux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d msinttypes ]; then
    mkdir msinttypes
fi
cd msinttypes
if [ ! -f msinttypes-r26.zip ]; then
    wget --no-check-certificate https://msinttypes.googlecode.com/files/msinttypes-r26.zip -O msinttypes-r26.zip
    unzip msinttypes-r26.zip
fi

echo End of $0
ls
