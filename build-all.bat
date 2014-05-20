@echo off
cd "%~dp0"
call build-yasm.bat
call build-bzip2.bat
call build-libav.bat
call build-l-smash.bat
call build-L-SMASH-Works-libav-AviUtl.bat
call build-L-SMASH-Works-libav-VapourSynth.bat
