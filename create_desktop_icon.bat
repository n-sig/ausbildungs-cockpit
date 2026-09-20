@echo off
setlocal
cd /d "%~dp0"

:: =========================================================================
::  Desktop-Verknuepfung fuer das Ausbildungs-Cockpit
:: =========================================================================
::  Die Verknuepfung zeigt bewusst auf start_cockpit.cmd und NICHT direkt
::  auf dropzone.html. Ein Shortcut auf die HTML-Datei oeffnet sie ueber
::  file:// - dort ist isSecureContext = false und damit sind File System
::  Access, Service Worker, storage.persist() und navigator.clipboard
::  saemtlich gesperrt. Der Starter geht ueber http://localhost:8137 und
::  ist damit ein vollwertiger Secure Context.
:: =========================================================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $sc = $ws.CreateShortcut(\"$([Environment]::GetFolderPath('Desktop'))\Ausbildungs-Cockpit.lnk\"); $sc.TargetPath = (Resolve-Path 'start_cockpit.cmd').Path; $sc.WorkingDirectory = (Get-Location).Path; $sc.IconLocation = (Resolve-Path 'app.ico').Path + ',0'; $sc.Description = 'Ausbildungs-Cockpit ueber http://localhost:8137 starten'; $sc.WindowStyle = 7; $sc.Save()"

if %ERRORLEVEL% NEQ 0 (
    echo   [FEHLER] Verknuepfung konnte nicht erstellt werden.
    pause
    exit /b 1
)

echo.
echo ========================================================
echo   [OK] Desktop-Icon 'Ausbildungs-Cockpit' wurde erstellt.
echo        Ziel: start_cockpit.cmd  -^> http://localhost:8137
echo ========================================================
echo.
pause
