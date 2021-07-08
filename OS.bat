@echo off
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if /i "%version%" == "10.0" goto t3n
if /i "%version%" == "6.3" goto nime
if /i "%version%" == "6.2" goto ei9ht
if /i "%version%" == "6.1" goto se7en
if /i "%version%" == "6.0" goto s1x
if /i "%version%" == "5.1" goto fine
:t3n
echo Windows 10
pause
cls
goto WIN
:nime
echo Windows 8.1
pause
cls
goto WIN
:ei9ht
echo Windows 8
pause
cls
goto WIN
:se7en
echo Windows 7
pause
cls
goto WIN
:s1x
echo Windows vista
pause
cls
goto WIN
:fine
echo Windows XP
pause
cls
:WIN
rem etc etc
endlocal
