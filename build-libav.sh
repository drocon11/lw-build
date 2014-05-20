#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d libav ]; then
    mkdir libav
fi
cd libav
if [ ! -d .git ]; then
    git config --global core.autocrlf false
    git clone -v --progress https://github.com/libav/libav.git ./
fi
git pull -v --progress
./configure --prefix="/mingw" --extra-cflags="-fexcess-precision=fast" --enable-memalign-hack --disable-doc --disable-debug --disable-network --disable-programs
#make clean
make -r && make install

echo End of $0
ls
