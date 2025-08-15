@echo off
setlocal enabledelayedexpansion
title Windows Cleanup (with final debug)

set "LOGFILE=%TEMP%\cleanup_log.txt"
> "%LOGFILE%" echo ==== Windows Cleanup Log (%date% %time%) ====

set QU=1>nul 2>nul

>nul 2>&1 net session || (echo Run as Administrator. & exit /b 1)

echo [1/9] Temp folders...
del /f /s /q "%TEMP%\*" >>"%LOGFILE%" 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >>"%LOGFILE%" 2>&1
del /f /s /q "%SystemRoot%\Temp\*" >>"%LOGFILE%" 2>&1
for /d %%D in ("%SystemRoot%\Temp\*") do rd /s /q "%%D" >>"%LOGFILE%" 2>&1
echo OK.

echo [2/9] Component store cleanup (DISM)...
Dism.exe /Online /Cleanup-Image /StartComponentCleanup >>"%LOGFILE%" 2>&1
echo OK.

echo [3/9] Windows Update cache...
net stop wuauserv %QU%
net stop bits %QU%
rd /s /q "%SystemRoot%\SoftwareDistribution\Download" >>"%LOGFILE%" 2>&1
md "%SystemRoot%\SoftwareDistribution\Download" %QU%
net start wuauserv %QU%
net start bits %QU%
echo OK.

echo [4/9] Recycle Bin...
powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >>"%LOGFILE%" 2>&1
echo OK.

echo [5/9] Kill browsers...
for %%P in (msedge.exe chrome.exe firefox.exe) do taskkill /F /IM %%P >>"%LOGFILE%" 2>&1
echo OK.

echo [6/9] Browser caches...
for /d %%P in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do (
  rd /s /q "%%~fP\Cache" >>"%LOGFILE%" 2>&1
  rd /s /q "%%~fP\Code Cache" >>"%LOGFILE%" 2>&1
  rd /s /q "%%~fP\GPUCache" >>"%LOGFILE%" 2>&1
  rd /s /q "%%~fP\Service Worker\CacheStorage" >>"%LOGFILE%" 2>&1
)
for /d %%P in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\*") do (
  rd /s /q "%%~fP\Cache" >>"%LOGFILE%" 2>&1
  rd /s /q "%%~fP\Code Cache" >>"%LOGFILE%" 2>&1
  rd /s /q "%%~fP\GPUCache" >>"%LOGFILE%" 2>&1
  rd /s /q "%%~fP\Service Worker\CacheStorage" >>"%LOGFILE%" 2>&1
)
for /d %%P in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do rd /s /q "%%~fP\cache2" >>"%LOGFILE%" 2>&1
for /d %%P in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do rd /s /q "%%~fP\cache2" >>"%LOGFILE%" 2>&1
echo OK.

echo [7/9] Drive optimize...
defrag C: /O >>"%LOGFILE%" 2>&1
echo OK.

echo [8/9] Recent items...
del /f /q "%APPDATA%\Microsoft\Windows\Recent\*" >>"%LOGFILE%" 2>&1
rd /s /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations" >>"%LOGFILE%" 2>&1
rd /s /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations" >>"%LOGFILE%" 2>&1
echo OK.

echo [9/9] Thumbnail cache...
del /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*" >>"%LOGFILE%" 2>&1
echo OK.

echo Extra: Windows Error Reporting...
rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER\ReportQueue" >>"%LOGFILE%" 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER\ReportArchive" >>"%LOGFILE%" 2>&1
rd /s /q "%PROGRAMDATA%\Microsoft\Windows\WER\ReportQueue" >>"%LOGFILE%" 2>&1
rd /s /q "%PROGRAMDATA%\Microsoft\Windows\WER\ReportArchive" >>"%LOGFILE%" 2>&1
echo OK.

:: Show summary
echo.
echo ==== CLEANUP SUMMARY ====
type "%LOGFILE%"
echo =========================
echo.
pause
