@ECHO OFF

REM Changing working folder back to current directory
%~d0
CD %~dp0
REM Folder changed

REM Check first if Windows XP
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO set vers=%%i %%j
echo %vers% | find "XP" > nul
if %ERRORLEVEL% == 0 goto ver_xp

REM Ask for admin access
if exist "admincheckOK.txt" goto adminOK1
del /Q admincheckOK.vbs
ECHO.
ECHO. Please wait...
echo.Set objShell = CreateObject("Shell.Application") > admincheckOK.vbs
echo.Set FSO = CreateObject("Scripting.FileSystemObject") >> admincheckOK.vbs
echo.strPath = FSO.GetParentFolderName (WScript.ScriptFullName) >> admincheckOK.vbs
echo.If FSO.FileExists(%0) Then >> admincheckOK.vbs
echo. Dim oShell >> admincheckOK.vbs
echo. Set oShell = WScript.CreateObject ("WScript.Shell") >> admincheckOK.vbs
echo. oShell.run "cmd.exe /c echo admincheckOK > admincheckOK.txt" >> admincheckOK.vbs
echo. Set oShell = Nothing >> admincheckOK.vbs
echo. objShell.ShellExecute "cmd.exe", " /c " ^& %0 ^& " ", "", "runas", 1 >> admincheckOK.vbs
echo.Else >> admincheckOK.vbs
echo. MsgBox "Script file not found" >> admincheckOK.vbs
echo.End If >> admincheckOK.vbs
cscript //B admincheckOK.vbs
goto timeend
:adminOK1
del /Q admincheckOK.txt
del /Q admincheckOK.vbs
:ver_xp
REM Admin Access allowed

net stop w32time

echo. Windows Registry Editor Version 5.00 > w32timeMAX.reg
echo. >> w32timeMAX.reg
echo. [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Config] >> w32timeMAX.reg
echo. "MaxNegPhaseCorrection"=dword:ffffffff >> w32timeMAX.reg
echo. "MaxPosPhaseCorrection"=dword:ffffffff >> w32timeMAX.reg
echo. >> w32timeMAX.reg
regedit /s w32timeMAX.reg

net start w32time

w32tm /resync /rediscover
w32tm /resync /rediscover
w32tm /resync /rediscover
w32tm /resync /rediscover
w32tm /resync /rediscover

net stop w32time

echo. Windows Registry Editor Version 5.00 >> w32timeDEFAULT.reg
echo. >> w32timeDEFAULT.reg
echo. [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Config] >> w32timeDEFAULT.reg
echo. "MaxNegPhaseCorrection"=dword:0000d2f0 >> w32timeDEFAULT.reg
echo. "MaxPosPhaseCorrection"=dword:0000d2f0 >> w32timeDEFAULT.reg
echo. >> w32timeDEFAULT.reg
regedit /s w32timeDEFAULT.reg

echo.
echo.
echo. TIME HAS BEEN UPDATED.
echo.
del /Q w32timeMAX.reg
del /Q w32timeDEFAULT.reg
echo.
echo. !!!YOU MAY SHUT THIS WINDOW NOW!!!
echo.
pause

REM Following statement required if Admin access denied
:timeend
del /Q admincheckOK.vbs

::https://jagaroth.livejournal.com/63875.html
