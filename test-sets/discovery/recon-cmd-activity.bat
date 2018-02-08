@ECHO OFF 

ECHO ===========================================================================
ECHO RECON ACTIVITY
ECHO.
ECHO Executes commands that are often used by attackers to get information
ping -n 5 127.0.0.1 > NUL

whoami > "%APTDIR%\sys.txt"
systeminfo >> "%APTDIR%\sys.txt"
net localgroup administrators >> "%APTDIR%\sys.txt"
wmic qfe list full >> "%APTDIR%\sys.txt"
wmic share get >> "%APTDIR%\sys.txt"
