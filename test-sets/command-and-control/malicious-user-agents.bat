@ECHO OFF

ECHO ===========================================================================
ECHO MALICIOUS UA
ECHO.
ECHO Using malicious user agents to access web sites

ECHO HttpBrowser RAT
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -A "HttpBrowser/1.0" -m3 www.google.com
ECHO Dyre / Upatre
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -A "Wget/1.9+cvs-stable (Red Hat modified)" -m3 www.google.com
ECHO Sality
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -A "Opera/8.81 (Windows NT 6.0; U; en)" -m3 www.google.com
ECHO NJRat
"%CURL%" -s -o /dev/null -I -w "Result: %%{http_code}\n" -A "*<|>*" -m3 www.google.com
