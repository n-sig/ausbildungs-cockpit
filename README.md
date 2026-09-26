# Ausbildungs-Cockpit

Wochenplaner, Berichtsheft, Arbeitszeit und Dateiablage für die Ausbildung. Eine HTML-Datei, die lokal in deinem Browser läuft. Außer GitHub ist kein fremder Server beteiligt.

> [!TIP]
> **Bonus-Aufgabe:** Bau dir einen eigenen Telegram-Bot, der Fotos, Dateien und Notizen von deinem Handy in dein Cockpit bringt. → [Zur Aufgabe](AUFGABE.md)

## Kurz erklärt

- **Eine Datei:** Das Cockpit ist `dropzone.html`. Der Starter öffnet es unter `localhost:8137` in einem App-Fenster deines Browsers.
- **Deine Kopie:** Dieses Repository ist eine Vorlage. Du machst daraus eine eigene, private Kopie. Die Vorlage bleibt unverändert.
- **Deine Daten:** Planer, Arbeitszeiten und Einstellungen liegen im Browser. Dateien und der Abgleich zwischen deinen Geräten liegen in deiner Kopie auf GitHub.

## Einrichten

Der Reihe nach, dauert etwa 20 Minuten.

1. **Eigene Kopie anlegen**

   Oben rechts **Use this template → Create a new repository**. Einen Namen wählen, zum Beispiel `ausbildung`, und **Private** einstellen.

2. **Git und Python installieren**

   Git von [git-scm.com](https://git-scm.com/download/win). Python von [python.org](https://www.python.org/downloads/windows/): den **Windows installer (64-bit)** nehmen und beim Installieren den Haken **Add python.exe to PATH** setzen.

   Danach ein **neues** PowerShell-Fenster öffnen und prüfen. Beide Befehle müssen eine Versionsnummer zeigen:

   ```powershell
   git --version
   python --version
   ```

3. **Kopie auf das Gerät holen**

   In PowerShell eingeben, vorher `benutzername/ausbildung` durch deine Kopie ersetzen:

   ```powershell
   git clone https://github.com/benutzername/ausbildung.git "$HOME/ausbildung"
   ```

   Beim ersten Mal öffnet sich ein GitHub-Anmeldefenster, dort anmelden. Der Befehl legt den Ordner in deinem Benutzerordner an. Nicht nach OneDrive, auf den Desktop oder in „Dokumente“ klonen.

4. **Token erstellen**

   Ein Token ist ein Schlüssel nur für dein Cockpit. Behandle ihn wie ein Passwort.
   - GitHub → Profilbild → **Settings → Developer settings → Personal access tokens → Fine-grained tokens → Generate new token**
   - Token name: zum Beispiel `Cockpit Laptop`. Expiration: länger als die voreingestellten 30 Tage, zum Beispiel ein Jahr.
   - Repository access: **Only select repositories** → deine Kopie
   - Permissions: **Contents → Read and write**
   - Den Token sofort im Passwortmanager speichern. GitHub zeigt ihn nur einmal.

5. **Starten**

   Im Ordner deiner Kopie `start_cockpit.cmd` doppelklicken. Beim ersten Start legt der Starter das Desktop-Icon „Ausbildungs-Cockpit“ an, ab dann startest du darüber. Liegt schon ein Icon mit diesem Namen auf dem Desktop, etwa von einer älteren Kopie, lösch es vorher. Sonst startet es weiter die alte Kopie.

6. **Einrichtungsassistent ausfüllen**

   Beruf, Ausbildungsbeginn und Arbeitszeit eintragen. Auf Seite 4 von 5 kommen Repository (`benutzername/ausbildung`) und Token hinein. „Ordner wählen“ auf dieser Seite überspringen. Zum Schluss auf **Loslegen** klicken.

7. **Testen**

   Screenshot machen (**Win + Shift + S**), ins Cockpit klicken, **Strg + V** drücken und auf **In GitHub hochladen** klicken. Das Bild muss auf GitHub in `04_Assets_Screenshots` auftauchen.

### Weitere Geräte

Nur nötig, wenn du das Cockpit auf mehr als einem Gerät nutzt. Eigene Reiter legst du am besten erst an, wenn alle Geräte eingerichtet sind.

8. Auf dem ersten Gerät unter ⚙️ Einstellungen → GitHub **Entwurf Auto-Sync** einschalten. Oben im Cockpit steht dann „GitHub gesichert ✓“.
9. Auf dem neuen Gerät die Schritte 2 bis 6 wiederholen, mit einem **eigenen Token** für dieses Gerät. Im Assistenten dieselben Werte wie auf dem ersten Gerät eintragen und mit **Loslegen** abschließen, nicht mit **Später**. Danach auch dort Auto-Sync einschalten.

## Ordner

| Ordner | Inhalt |
|---|---|
| `01_Berichtsheft/` | Wochenberichte, legt das Cockpit selbst an |
| `02_Berufsschule/` | Mitschriften und Lernfelder |
| `03_Betrieb_Notizen/` | Praxiswissen und How-tos |
| `04_Assets_Screenshots/` | Bilder und Screenshots, Ziel für Strg + V |
| `05_Transfer_Inbox/` | Ablage vom Handy oder von anderen Geräten |

## Gut zu wissen

- Immer über das Desktop-Icon starten. Dabei holt der Starter Änderungen aus deiner Kopie (`git pull`).
- Im Ordner deiner Kopie nichts von Hand ändern, löschen oder hinzufügen. Sonst holt der Starter keine Änderungen mehr. Dateien lädst du im Cockpit in Tab 1 „Transfer“ hoch.
- Gerät wechseln: warten, bis oben „GitHub gesichert ✓“ steht, das Cockpit schließen und auf dem anderen Gerät neu starten oder **F5** drücken.
- Pro Gerät immer denselben Browser benutzen.
- Gerät verloren? Nur den Token dieses Geräts auf GitHub löschen.
- Sicherung: ab und zu unter ⚙️ Einstellungen → Ausbildung **Exportieren (JSON)** klicken und die Datei außerhalb deiner Kopie aufheben.
- Der Token bleibt im Browser des jeweiligen Geräts und wird nur an GitHub gesendet.
- **Updates:** Gibt es eine neue Version, zeigt das Cockpit oben einen Hinweis. Unter ⚙️ Einstellungen → GitHub → **App-Update** spielst du sie per Klick ein. Ersetzt werden nur die Dateien im Hauptordner (App, Starter, Anleitung), deine Ordner und Daten bleiben unberührt. Danach das Cockpit neu starten, deine anderen Geräte holen sich das Update beim nächsten Start. Es passiert nichts ohne deinen Klick, und es kommen nur veröffentlichte [Releases der Vorlage](https://github.com/n-sig/ausbildungs-cockpit/releases).
