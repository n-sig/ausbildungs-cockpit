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

:: --- 0. Lokalen Stand mit GitHub synchronisieren (falls Git vorhanden) -----
where git >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    if exist ".git" (
        set "GIT_TERMINAL_PROMPT=0"
        git pull --quiet --ff-only >nul 2>&1
    )
)

:: --- 0b. Cockpit im Hintergrund auf Updates pruefen ------------------------
powershell -NoProfile -Command ^
  "$u='https://raw.githubusercontent.com/n-sig/ausbildungs-cockpit/main/dropzone.html';" ^
  "try {" ^
  "  $req = [System.Net.HttpWebRequest]::Create($u);" ^
  "  $req.Method = 'HEAD'; $req.Timeout = 1500;" ^
  "  $res = $req.GetResponse();" ^
  "  $remoteLen = $res.ContentLength; $res.Close();" ^
  "  $localFile = Resolve-Path 'dropzone.html' -ErrorAction SilentlyContinue;" ^
  "  if ($localFile -and $remoteLen -gt 10000) {" ^
  "    $localLen = (Get-Item $localFile).Length;" ^
  "    if ($localLen -ne $remoteLen) {" ^
  "      Invoke-WebRequest $u -OutFile ($localFile.Path + '.new') -TimeoutSec 5 -UseBasicParsing;" ^
  "      if ((Test-Path ($localFile.Path + '.new')) -and (Get-Item ($localFile.Path + '.new')).Length -gt 10000) {" ^
  "        Move-Item ($localFile.Path + '.new') $localFile.Path -Force;" ^
  "        Write-Output '  [UPDATE] dropzone.html wurde auf die neueste Version aktualisiert.';" ^
  "      }" ^
  "    }" ^
  "  }" ^
  "} catch {}"

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

:: --- 2. Port belegt? Pruefen, ob Server gerade hochfaehrt ------------------
powershell -NoProfile -Command ^
  "if (Get-NetTCPConnection -LocalPort %PORT% -State Listen -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }"

if %ERRORLEVEL% EQU 0 (
    echo   Port %PORT% ist belegt. Warte kurz, falls Server gerade startet ...
    powershell -NoProfile -Command ^
      "$ok=$false; foreach($i in 1..8){ Start-Sleep -Milliseconds 250; try { $r=Invoke-WebRequest '%PROBE%' -Method Head -TimeoutSec 1 -UseBasicParsing; if($r.StatusCode -eq 200){ $ok=$true; break } } catch {} }; if($ok){exit 0}else{exit 1}"
    if not errorlevel 1 (
        echo   [OK] Server laeuft bereits auf Port %PORT%.
        goto :launch
    )
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
:: --- 5. Browser im App-Modus oeffnen (Fallback-Kette) ----------------------
::  Prueft der Reihe nach auf Edge, Brave oder Chrome (unterstuetzen alle --app).
::  Wird keiner gefunden, oeffnet der Standard-Browser normal.
set "BROWSER="
for /f "usebackq delims=" %%B in (`powershell -NoProfile -Command ^
  "$candidates = @('msedge.exe', 'brave.exe', 'chrome.exe');" ^
  "foreach ($b in $candidates) {" ^
  "  if ((Test-Path ('HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\' + $b)) -or " ^
  "      (Test-Path ('HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\' + $b)) -or " ^
  "      (Get-Command $b -ErrorAction SilentlyContinue)) { $b; break }" ^
  "}"`) do set "BROWSER=%%B"

if defined BROWSER (
    echo   [OK] Starte %BROWSER% im App-Modus ...
    start "" "%BROWSER%" --app="%URL%"
) else (
    echo   [HINWEIS] Kein Chromium-Browser fuer App-Modus gefunden. Oeffne Standard-Browser ...
    start "" "%URL%"
)
exit /b 0
