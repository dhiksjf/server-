@echo off
echo Testing UAC Bypass...
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] This script is NOT running with administrator privileges.
    echo Please run via UACBypass.exe to test elevation.
    pause
    exit /b 1
)

echo [+] Running with administrator privileges.

:: Try to write to a protected location (requires admin)
set TEST_FILE=C:\Windows\System32\drivers\etc\test_uac.txt
echo Created by %USERNAME% at %DATE% %TIME% > %TEST_FILE%
if exist %TEST_FILE% (
    echo [+] Successfully created test file: %TEST_FILE%
    type %TEST_FILE%
) else (
    echo [!] Failed to create test file (should not happen if admin).
)

:: Display current user and group membership
echo.
echo Current user: %USERNAME%
whoami /groups | findstr "S-1-5-32-544" >nul && echo [+] User is in Administrators group.

pause