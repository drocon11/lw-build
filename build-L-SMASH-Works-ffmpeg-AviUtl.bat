@echo off
cd "%~dp0"
copy /y "%~n0.sh" "mingw32\msys\home\%USERNAME%\%~n0.sh"
set START_OPT=
if not "x%~1" == "x" set START_OPT=%~1
set MINTTY_OPT=--hold always
if not "x%~2" == "x" set MINTTY_OPT=%~2
start %START_OPT% mingw32\msys\bin\mintty.exe %MINTTY_OPT% --exec /bin/bash --login -i -c "~/%~n0.sh"
@echo on
