@echo off
pushd %~dp0

:KB2533552
wusa Windows6.1-KB2533552-x64.msu /quiet /norestart

:CLEANUP
cd\
rd /q/s %WINDIR%\Setup\Scripts
