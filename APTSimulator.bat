@ECHO OFF
color 0C
ECHO. 

SET CWD="%~dp0"
cd %CWD%

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

CLS
ECHO ===========================================================================
ECHO WARNING!                                               
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

:MENU
CLS
color 07
ECHO ===========================================================================
TYPE welcome.txt                                                                        
ECHO.
ECHO   Select the test-set that you want to run:
ECHO.
ECHO   0 - RUN EVERY TEST
ECHO   1 - Collection 
ECHO   2 - Command and Control
ECHO   3 - Credential Access 
ECHO   4 - Defense Evasion
ECHO   5 - Discovery
ECHO   6 - Execution 
ECHO   7 - Lateral Movement 
ECHO   8 - Persistence
ECHO   9 - Privilege Escalation
ECHO   E - EXIT
ECHO. 

SET /P M=Your selection (then press ENTER): 
IF %M%==0 SET list="collection" "command-and-control" "credential-access" "defense-evasion" "discovery" "execution" "lateral-movement" "persistence" "privilege-escalation"
IF %M%==1 SET list="collection"
IF %M%==2 SET list="command-and-control"
IF %M%==3 SET list="credential-access"
IF %M%==4 SET list="defense-evasion"
IF %M%==5 SET list="discovery"
IF %M%==6 SET list="execution"
IF %M%==7 SET list="lateral-movement"
IF %M%==8 SET list="persistence"
IF %M%==9 SET list="privilege-escalation"
IF %M%==e GOTO END
IF %M%==E GOTO END

:: Running all test sets
for %%i in (%list%) do (
    ECHO.
    ECHO ###########################################################################
    ECHO RUNNING SET: %%i
    ECHO.
    for /f "delims=" %%x in ('dir /b /a-d .\test-sets\%%i\*.bat') do call ".\test-sets\%%i\%%x"
)
ECHO ===========================================================================
ECHO Finished!
ECHO Check for errors and make sure you opened the command line as 'Administrator'
PAUSE
GOTO MENU 

:END
ECHO.
color 07
endlocal
