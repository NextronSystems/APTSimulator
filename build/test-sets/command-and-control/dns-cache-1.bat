@ECHO OFF

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
