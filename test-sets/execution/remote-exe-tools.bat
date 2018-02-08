@ECHO OFF

ECHO ===========================================================================
ECHO REMOTE EXECUTION TOOL 
ECHO.
ECHO Dropping a remote execution tool into the APT dir
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\xCmd.exe > NUL
