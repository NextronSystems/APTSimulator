@ECHO OFF

ECHO ===========================================================================
ECHO PSEXEC
ECHO.
ECHO Dropping a modified PsExec into the APT dir
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\p.exe > NUL

ECHO Running a cmd.exe as LOCAL_SYSTEM 
ping -n 5 127.0.0.1 > NUL
"%APTDIR%\p.exe" -accepteula -d -s cmd.exe /c systeminfo
