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
cd AviSynth
cat <<__END_OF_TEXT__ >"LSMASHSourceVCX.vcxproj.bat"
set CL=/I..\..\..\..\..\include /I..\..\msinttypes
set LINK="libpthread.a" "libiconv.a" "libswresample.a" "libmsvcrt.a" /LIBPATH:..\..\..\..\..\i686-w64-mingw32\lib /LIBPATH:..\..\..\..\..\lib\gcc\i686-w64-mingw32\4.8.2 /LIBPATH:..\..\bzip2 /LIBPATH:..\..\..\..\..\lib
@for /d %%1 in (%SystemRoot%\Microsoft.NET\Framework\v*) do @if exist "%%~1\msbuild.exe" set "MSBUILD=%%~1\msbuild.exe"
"%MSBUILD%" LSMASHSourceVCX.vcxproj /target:Rebuild /property:Configuration=Release;Platform=Win32;PlatformToolset=v100
__END_OF_TEXT__
cmd.exe "/c "LSMASHSourceVCX.vcxproj.bat""

echo End of $0
ls
