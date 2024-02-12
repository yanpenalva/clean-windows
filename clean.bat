@echo off
title Windows Cleanup Script

:: Clear temporary files
echo Clearing temporary files...
del /q /f %temp%\*.*
del /q /f %systemroot%\Temp\*.*
echo Temporary files cleared.

:: Clean up disk
echo Cleaning up disk...
cleanmgr /sagerun:1
echo Disk cleaned up.

:: Clean up Windows Update cache
echo Cleaning up Windows Update cache...
net stop wuauserv
net stop bits
del /q /s /f %systemroot%\SoftwareDistribution\*.*
net start wuauserv
net start bits
echo Windows Update cache cleaned up.

:: Optimize drives
echo Optimizing drives...
defrag C: /U /V
echo Drives optimized.

:: Clean logs and browser cache
echo Cleaning logs and browser cache...
taskkill /F /IM "msedge.exe"
taskkill /F /IM "firefox.exe"
taskkill /F /IM "chrome.exe"
del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\*\Cache\*.*"
del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles\*\cache2\*.*"
del /q /s /f "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\*\Cache\*.*"
echo Logs and browser cache cleaned.

echo Cleanup completed.
pause
