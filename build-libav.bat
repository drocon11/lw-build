@echo off
cd "%~dp0"
copy /y "%~n0.sh" "mingw32\msys\home\%USERNAME%\%~n0.sh"
start mingw32\msys\bin\mintty.exe --hold always --exec /bin/bash --login -i -c "~/%~n0.sh"
