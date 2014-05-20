#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d ffmpeg ]; then
    mkdir ffmpeg
fi
cd ffmpeg
if [ ! -d .git ]; then
    git config --global core.autocrlf false
    git clone -v --progress https://github.com/FFmpeg/FFmpeg.git ./
fi
git pull -v --progress
./configure --prefix="/mingw" --extra-cflags="-fexcess-precision=fast" --enable-avresample --enable-memalign-hack --disable-doc --disable-debug --disable-network --disable-programs
make clean
make -r && make install

echo End of $0
ls
