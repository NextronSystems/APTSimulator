@ECHO OFF

ECHO ===========================================================================
ECHO C2 Access
ECHO.
ECHO Using curl to access well-known C2 addresses

ECHO C2: msupdater.com
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -m3 msupdater.com
ECHO C2: twitterdocs.com
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -m3 twitterdocs.com
ECHO C2: freenow.chickenkiller.com
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -m3 freenow.chickenkiller.com

