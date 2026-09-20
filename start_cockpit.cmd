@echo off
setlocal
cd /d "%~dp0"

:: =========================================================================
::  Ausbildungs-Cockpit - 1-Klick-Start ueber http://localhost:8137
:: =========================================================================
::  Warum ueberhaupt ein lokaler Server?
::  Auf file:// ist isSecureContext = false. Damit sind File System Access
::  (Ordner-Anbindung an OneDrive), Service Worker, storage.persist() und
::  navigator.clipboard SAEMTLICH gesperrt. http://localhost gilt dagegen als
::  "potentially trustworthy origin" und ist ein vollwertiger Secure Context.
::
::  WICHTIG - der Port ist Teil des Origins:
::  http://localhost:8137 und http://localhost:8138 sind zwei verschiedene
::  Speicherbereiche. Ein Ausweichen auf einen anderen Port wuerde
::  localStorage, IndexedDB UND die Ordner-Verknuepfung schlagartig leer
::  aussehen lassen - also exakt wie erneuter Datenverlust. Deshalb wird hier
::  bei belegtem Port ABGEBROCHEN statt hochgezaehlt.
:: =========================================================================

set "PORT=8137"
set "URL=http://localhost:%PORT%/dropzone.html"
set "PROBE=http://127.0.0.1:%PORT%/dropzone.html"

echo.
echo   Ausbildungs-Cockpit wird gestartet ...
echo.

:: --- 1. Laeuft BEREITS UNSER Server? -------------------------------------
::  Nicht nur "ist der Port belegt?" pruefen: haelt ihn ein fremder Prozess,
::  wuerde Edge fremden Inhalt unter unserem Origin laden. Deshalb wird gegen
::  die echte URL geprueft.
powershell -NoProfile -Command ^
  "try { $r = Invoke-WebRequest '%PROBE%' -Method Head -TimeoutSec 2 -UseBasicParsing; if ($r.StatusCode -eq 200) { exit 0 } else { exit 1 } } catch { exit 1 }"

if %ERRORLEVEL% EQU 0 (
    echo   [OK] Server laeuft bereits auf Port %PORT%.
    goto :launch
)

:: --- 2. Port belegt, aber nicht von uns? ---------------------------------
powershell -NoProfile -Command ^
  "if (Get-NetTCPConnection -LocalPort %PORT% -State Listen -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo   [ABBRUCH] Port %PORT% ist belegt - aber nicht vom Cockpit-Server.
    echo.
    echo   Der Port gehoert zum Origin. Ein anderer Port haette zur Folge,
    echo   dass alle bisherigen Daten "verschwunden" aussehen.
    echo.
    echo   Belegenden Prozess anzeigen:
    echo     powershell -NoProfile -Command "Get-NetTCPConnection -LocalPort %PORT% -State Listen ^| Select-Object OwningProcess"
    echo.
    pause
    exit /b 1
)

:: --- 3. Python-Server im Hintergrund starten ------------------------------
where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo   [FEHLER] python wurde nicht gefunden ^(PATH^).
    echo   Bitte Python installieren oder den PATH ergaenzen.
    pause
    exit /b 1
)

echo   Starte lokalen Server auf 127.0.0.1:%PORT% ...
start "" /b powershell -NoProfile -WindowStyle Hidden -Command ^
  "Start-Process python -ArgumentList '-m','http.server','%PORT%','-b','127.0.0.1' -WindowStyle Hidden"

:: --- 4. Warten, bis er wirklich antwortet ---------------------------------
::  Ein festes timeout /t 1 ist geraten. Hier wird gewartet, bis der Server
::  tatsaechlich 200 liefert - sonst zeigt Edge beim ersten Start ERR_CONNECTION_REFUSED.
powershell -NoProfile -Command ^
  "$ok=$false; foreach($i in 1..25){ try { $r=Invoke-WebRequest '%PROBE%' -Method Head -TimeoutSec 1 -UseBasicParsing; if($r.StatusCode -eq 200){ $ok=$true; break } } catch {}; Start-Sleep -Milliseconds 200 }; if($ok){exit 0}else{exit 1}"

if %ERRORLEVEL% NEQ 0 (
    echo   [FEHLER] Server antwortet nicht auf %PROBE%.
    pause
    exit /b 1
)
echo   [OK] Server bereit.

:launch
:: --- 5. Edge im App-Modus oeffnen -----------------------------------------
start msedge.exe --app="%URL%"
exit /b 0
