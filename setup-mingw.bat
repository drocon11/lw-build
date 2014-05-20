@echo off
cd "%~dp0"

@for /d %%1 in (%SystemRoot%\Microsoft.NET\Framework\v*) do @if exist "%%~1\csc.exe" set "CSC=%%~1\csc.exe"
if not exist "%CSC%\..\System.IO.Compression.FileSystem.dll" (
    echo Requirement: .NET Framework 4.5 or later
    goto :EOF
)

if not exist "download-file.exe" (
    echo Build download-file.exe ...
    >download-file.cs echo class App{static void Main^(string[] args^){new System.Net.WebClient^(^).DownloadFile^(args[0],args[1]^);}}
    "%CSC%" download-file.cs
    if not exist "download-file.exe" (
        echo Failed to build download-file.exe
        goto :EOF
    )
)

if not exist "extract-to-file.exe" (
    echo Build extract-to-file.exe ...
    >extract-to-file.cs echo using System.IO.Compression;class Program{static void Main^(string[] args^){System.IO.Compression.ZipFile.OpenRead^(args[0]^).GetEntry^(args[1]^).ExtractToFile^(args[1]^);}}
    "%CSC%" /r:System.IO.Compression.dll /r:System.IO.Compression.FileSystem.dll extract-to-file.cs
    if not exist "extract-to-file.exe" (
        echo Failed to build extract-to-file.exe
        goto :EOF
    )
)

if not exist "wget.exe" (
    echo Download wget.exe ...
    download-file.exe http://eternallybored.org/misc/wget/wget.exe wget.exe
    if not exist "wget.exe" (
        echo Failed to download wget.exe
        goto :EOF
    )
)

if not exist "7za920.zip" (
    echo Download 7za920.zip ...
    wget.exe "http://downloads.sourceforge.net/sevenzip/7za920.zip" -O "7za920.zip"
    if not exist "7za920.zip" (
        echo Failed to download 7za920.zip
        goto :EOF
    )
)

if not exist "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" (
    echo Download i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z ...
    wget.exe "http://downloads.sourceforge.net/mingw-w64/Toolchains%%20targetting%%20Win32/Personal%%20Builds/mingw-builds/4.8.2/threads-posix/sjlj/i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" -O "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z"
    if not exist "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" (
        echo Failed to i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z
        goto :EOF
    )
)

if not exist "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" (
    echo Download msys+7za+wget+svn+git+mercurial+cvs-rev13.7z ...
    wget.exe "http://downloads.sourceforge.net/mingwbuilds/external-binary-packages/msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" -O "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z"
    if not exist "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" (
        echo Failed to download msys+7za+wget+svn+git+mercurial+cvs-rev13.7z
        goto :EOF
    )
)

if not exist "7za.exe" (
    echo Extract 7za.exe from 7za920.zip ...
    extract-to-file.exe 7za920.zip 7za.exe
    if not exist "7za.exe" (
        echo Failed to extract 7za.exe from 7za920.zip
        goto :EOF
    )
)

if not exist "mingw32" (
    echo Extract from i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z ...
    7za.exe x "i686-4.8.2-release-posix-sjlj-rt_v3-rev4.7z" -o"." -y
)

if not exist "mingw32\msys" (
    echo Extract from msys+7za+wget+svn+git+mercurial+cvs-rev13.7z ...
    7za.exe x "msys+7za+wget+svn+git+mercurial+cvs-rev13.7z" -o".\mingw32" -y
)

set MINGW32=%CD:\=/%/mingw32
>mingw32\msys\etc\fstab echo %MINGW32% /mingw

mingw32\msys\msys.bat -mintty

exit /b

