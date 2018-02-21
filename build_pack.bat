@ECHO OFF
:: APT Simulator Build Script

SET BUILD=.\build\
SET ZIP=.\helpers\7z.exe
SET PASS=aptsimulator
SET ARCHPASS=apt

MKDIR %BUILD%

:: Script
copy APTSimulator.bat %BUILD%
copy welcome.txt %BUILD%

:: HELPERS
del /Q %BUILD%\helpers\*.*
xcopy /S /Y .\helpers %BUILD%\helpers\

:: TEST SETS
rd %BUILD%\test-sets\ /S /Q
xcopy /S /Y .\test-sets %BUILD%\test-sets\

:: TOOLS
:: Compress and encrypt toolset
%ZIP% u -bb3 -t7z -r -mx=9 -mmt=4 -mhe=on -p%PASS% enc-toolset.7z ./toolset/
:: Copy it to the build dir
copy enc-toolset.7z %BUILD%

:: FILES
:: Compress and encrypt workfiles
%ZIP% u -bb3 -t7z -r -mx=9 -mmt=4 -mhe=on -p%PASS% enc-files.7z ./workfiles/
:: Copy it to the build dir
copy enc-files.7z %BUILD%

:: PACK
ren build APTSimulator
del /Q APTSimulator_pw_nextron.zip
%ZIP% a -bb1 -tzip -r -p%ARCHPASS% ./dist/APTSimulator_pw_apt.zip ./APTSimulator/
ren APTSimulator build
