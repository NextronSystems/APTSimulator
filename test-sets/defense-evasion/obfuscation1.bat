@ECHO OFF

ECHO ===========================================================================
ECHO OBFUSCATION
ECHO.
ECHO Dropping obfuscated RAR file with JPG extension
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %FILEARCH% -aoa -o"%TEMP%" workfiles\s01.jpg > NUL

