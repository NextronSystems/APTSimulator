@ECHO OFF

ECHO ===========================================================================
ECHO Suspicious Locations
ECHO Well-known system files in suspicious locations
ECHO.
ECHO Placing a svchost.exe (which is actually srvany.exe) into %PUBLIC%
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%PUBLIC%" toolset\svchost.exe > NUL

ECHO Running the misplaced system file 
ping -n 5 127.0.0.1 > NUL

"%PUBLIC%\svchost.exe"
