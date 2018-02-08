@ECHO OFF 

ECHO ===========================================================================
ECHO NETBIOS Discovery
ECHO.
ECHO Executes nbtscan on the local network
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\nbtscan.exe > NUL

"%APTDIR%\nbtscan.exe" 192.168.1.0/24 > "%APTDIR%\scan1.tmp"
"%APTDIR%\nbtscan.exe" 10.10.0.0/24 > "%APTDIR%\scan2.tmp"
"%APTDIR%\nbtscan.exe" 172.28.29.0/24 > "%APTDIR%\scan3.tmp"

ECHO Dumping sample scan output to the %TEMP% dir in case that no scan returned a result
"%ZIP%" e -p%PASS% %FILEARCH% -aoa -o"%TEMP%" workfiles\out-sc1.tmp > NUL

