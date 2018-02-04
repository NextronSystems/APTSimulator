@ECHO OFF 

ECHO ===========================================================================
ECHO EVENTLOG
ECHO.
ECHO Creating Eventlog Entries indicating the use of password dumpers
ping -n 5 127.0.0.1 > NUL

eventcreate /L System /T Success /ID 100 /D "A service was installed in the system. Service Name:  WCESERVICE Service File Name:  C:\Users\neo\AppData\Local\Temp\0c134c70-2b4d-4cb3-beed-37c5fa0451d0.exe -S Service Type:  user mode service Service Start Type:  demand start Service Account:  LocalSystem"
eventcreate /L System /T Success /ID 101 /D "The WCESERVICE service entered the running state."
