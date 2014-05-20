#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d L-SMASH-Works-libav ]; then
    mkdir L-SMASH-Works-libav
fi
cd L-SMASH-Works-libav
if [ ! -d .git ]; then
    git config --global core.autocrlf false
    git clone -v --progress https://github.com/VFR-maniac/L-SMASH-Works.git ./
fi
git pull -v --progress
cd AviUtl
./configure --prefix="/mingw" --extra-ldflags="-static"
make clean
make

echo End of $0
ls
