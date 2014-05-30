#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d l-smash ]; then
    mkdir l-smash
fi
cd l-smash
if [ ! -d .git ]; then
    git clone -v --progress --config core.autocrlf=false https://github.com/l-smash/l-smash.git ./
fi
git pull -v --progress
./configure --prefix="/mingw"
make clean
make lib && make install-lib

echo End of $0
ls
