#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

cd ffmpeg
make install
cd ..

if [ ! -d L-SMASH-Works-ffmpeg ]; then
    mkdir L-SMASH-Works-ffmpeg
fi
cd L-SMASH-Works-ffmpeg
if [ ! -d .git ]; then
    git clone -v --progress --config core.autocrlf=false https://github.com/VFR-maniac/L-SMASH-Works.git ./
fi
git pull -v --progress
cd VapourSynth
./configure --prefix="/mingw" --extra-ldflags="-static"
make clean
make

echo End of $0
ls
