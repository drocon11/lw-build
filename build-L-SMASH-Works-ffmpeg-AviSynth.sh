#!/bin/bash -eux

export PKG_CONFIG_PATH=/mingw/lib/pkgconfig

if [ ! -d L-SMASH-Works-ffmpeg ]; then
    mkdir L-SMASH-Works-ffmpeg
fi
cd L-SMASH-Works-ffmpeg
if [ ! -d .git ]; then
    git config --global core.autocrlf false
    git clone -v --progress https://github.com/VFR-maniac/L-SMASH-Works.git ./
fi
git pull -v --progress
cd AviSynth
cat <<__END_OF_TEXT__ >>"LSMASHSourceVCX.sln -Rebuild Release.bat"
set CL=/I..\..\..\..\..\include /I..\..\msinttypes
set LINK="libpthread.a" "libiconv.a" "libswresample.a" /LIBPATH:..\..\..\..\..\i686-w64-mingw32\lib /LIBPATH:..\..\..\..\..\lib\gcc\i686-w64-mingw32\4.8.2 /LIBPATH:..\..\bzip2 /LIBPATH:..\..\..\..\..\lib
"%VS100COMNTOOLS%..\IDE\devenv" %~n0
__END_OF_TEXT__
cmd.exe "/c "LSMASHSourceVCX.sln -Rebuild Release.bat""

echo End of $0
ls
