@echo off
cd "%~dp0"

set CSC=
@for /d %%1 in (%SystemRoot%\Microsoft.NET\Framework\v*) do @if exist "%%~1\csc.exe" set "CSC=%%~1\csc.exe"
if "x" == "x%CSC%" (
    echo Requirement: .NET Framework 4.0 or later
    pause
    goto :EOF
)

if not exist "download-file.exe" (
    echo Build download-file.exe ...
    >download-file.cs echo class App{static void Main^(string[] args^){new System.Net.WebClient^(^).DownloadFile^(args[0],args[1]^);}}
    "%CSC%" download-file.cs
    if not exist "download-file.exe" (
        echo Failed to build download-file.exe
        pause
        goto :EOF
    )
)

if not exist "wget.exe" (
    echo Download wget.exe ...
    download-file.exe http://eternallybored.org/misc/wget/wget.exe wget.exe
    if not exist "wget.exe" (
        echo Failed to download wget.exe
        pause
        goto :EOF
    )
)

if not exist "7z920.msi" (
    echo Download 7z920.msi ...
    wget.exe "http://downloads.sourceforge.net/sevenzip/7z920.msi" -O "7z920.msi"
    if not exist "7z920.msi" (
        echo Failed to download 7z920.msi
        pause
        goto :EOF
    )
)

if not exist "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" (
    echo Download i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z ...
    wget.exe "http://downloads.sourceforge.net/mingw-w64/Toolchains%%20targetting%%20Win32/Personal%%20Builds/mingw-builds/4.8.2/threads-posix/sjlj/i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" -O "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z"
    if not exist "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" (
        echo Failed to i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z
        pause
        goto :EOF
    )
)

if not exist "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" (
    echo Download msys+7za+wget+svn+git+mercurial+cvs-rev13.7z ...
    wget.exe "http://downloads.sourceforge.net/mingwbuilds/external-binary-packages/msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" -O "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z"
    if not exist "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" (
        echo Failed to download msys+7za+wget+svn+git+mercurial+cvs-rev13.7z
        pause
        goto :EOF
    )
)

if not exist "7z.exe" (
    echo Extract 7z.exe, 7z.dll from 7z920.msi ...
    if exist "7z920" rmdir /s /q "7z920"
    msiexec /a "7z920.msi" /qb TARGETDIR="%~dp07z920"
    copy /y "7z920\Files\7-Zip\7z.exe" "7z.exe"
    copy /y "7z920\Files\7-Zip\7z.dll" "7z.dll"
    rmdir /s /q "7z920"
    if not exist "7z.exe" (
        echo Failed to extract 7z.exe, 7z.dll from 7z920.msi
        pause
        goto :EOF
    )
)

if not exist "mingw32" (
    echo Extract from i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z ...
    7z.exe x "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" -o"." -y
)

if not exist "mingw32\msys" (
    echo Extract from msys+7za+wget+svn+git+mercurial+cvs-rev13.7z ...
    7z.exe x "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" -o".\mingw32" -y
)

set MINGW32=%CD:\=/%/mingw32
>mingw32\msys\etc\fstab echo %MINGW32% /mingw

mingw32\msys\msys.bat -mintty

exit /b

