@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
cls
echo The following computers are on (and responding in less than 150mS)

for /f %%c in ('dsquery computer -limit 2000 -o rdn') do @(
 
    ping %%~c -n 1 -w 150 >nul
    if !errorlevel!==0 (
        for /f "tokens=3 delims=: " %%i in ('ping %%~c -n 1 -w 150 ^| find "Reply from"') do set ip=%%i
        echo %%~c - !ip!^
    )

)

pause