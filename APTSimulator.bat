@ECHO OFF
color 0C
ECHO. 
ECHO ===========================================================================
ECHO   APT Simulator 
ECHO   Florian Roth, v0.4 February 2018
ECHO ===========================================================================

SET CWD=%CD%

:: Config
SET ZIP=%CWD%\helpers\7z.exe
SET CURL=%CWD%\helpers\curl.exe
:: Encrypted archives
SET TOOLARCH=%CWD%\enc-toolset.7z
SET FILEARCH=%CWD%\enc-files.7z
:: Password
SET PASS=aptsimulator
:: Target directories
SET APTDIR=C:\TMP
SET WWWROOT=C:\inetpub\wwwroot

ECHO.
ECHO This program is meant to simulate an APT on the local system by 
ECHO distributing traces of typical APT attacks.
ECHO. 
ECHO 1.) To get the best results, run it as "Administrator"
ECHO 2.) DO NOT run this script on PRODUCTIVE systems as it drops files
ECHO     that may be used by attackers for lateral movement, password dumping
ECHO     and other types of manipulations. 
ECHO 3.) You DO NOT have to deactivate your ANTIVIRUS. Keep it running to see 
ECHO     that it is useless to detect activities of skilled attackers.
ECHO 4.) DO NOT upload contents of this archive to VIRUSTOTAL or a similar 
ECHO     online service as they provide backend views in which researchers and 
ECHO     attackers get access to the uploaded files.
ECHO.

ECHO ===========================================================================
ECHO Let's go ahead ... The next steps will manipulate the local system.
ECHO.
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure to proceed (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

:: Run the test sets

for %%i in (
    "collection"
    "defense-evasion"
    "command-and-control"
    "discovery"
    "execution"
    "persistence"
    "lateral-movement"
    "privilege-escalation"
) do (
    ECHO.
    ECHO ###########################################################################
    ECHO RUNNING SET: %%i
    ECHO.
    for /f "delims=" %%x in ('dir /b /a-d .\test-sets\%%i\*.bat') do call ".\test-sets\%%i\%%x" 
)
GOTO END 

:END
ECHO.
ECHO ===========================================================================
ECHO Finished!
ECHO Check for errors and make sure you opened the command line as 'Administrator'
ECHO.
pause
color 07
endlocal