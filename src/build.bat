@echo off

REM Build XED benchmark with latest build of xed kit
pushd . 
cd ..\decoders && call build-xed.bat
popd
set xed=..\decoders\xed\xed
FOR /F " tokens=*" %%i IN ('dir /b /ad-h /od ..\decoders\xed\xed\kits') DO (SET kit=%%i)
(set xedkit=%xed%\kits\%kit%)
cl.exe /Ox /I %xedkit%\include xed-benchmark.c /link /LIBPATH:%xedkit%\lib xed.lib xed-ild.lib



REM Build Capstone
pushd .
cd ..\decoders && call build-capstone.bat
popd
set libs=..\decoders\capstone\capstone\msvc\x64\Release
set inc=..\decoders\capstone\capstone\include
cl.exe /Ox /I %inc% capstone-benchmark.c /link /LTCG /LIBPATH:%libs% capstone.lib

REM For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set tdate=%%c-%%a-%%b)
REM echo %tdate%
