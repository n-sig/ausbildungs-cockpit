# Ausbildungs-Cockpit

Wochenplaner, Berichtsheft, Arbeitszeit und Dateiablage für die Ausbildung. Eine HTML-Datei, die lokal in deinem Browser läuft – ohne fremde Server.

## Einrichten

1. **Eigene Kopie anlegen:** oben rechts **Use this template → Create a new repository**, Sichtbarkeit **Private**.
2. **Git und Python installieren.** Bei Python den Haken **Add python.exe to PATH** setzen.
3. **Klonen**, nicht in einen OneDrive-Ordner:
   ```powershell
   git clone https://github.com/benutzername/ausbildung.git "$HOME/ausbildung"
   ```
4. **Token erstellen:** GitHub → Settings → Developer settings → Fine-grained tokens. Nur deine Kopie, Berechtigung `Contents: Read and write`.
5. **Starten:** `start_cockpit.cmd` doppelklicken. Beim ersten Start legt er ein Desktop-Icon an, ab dann startest du darüber.
6. **Einrichtungsassistent ausfüllen:** in Schritt 4 Repository und Token eintragen, mit **Fertig** abschließen.

**Weitere Rechner:** dort die Schritte 2 bis 6 mit einem eigenen Token wiederholen, im Assistenten dieselben Werte eintragen. Danach auf allen Rechnern ⚙️ Einstellungen → **Entwurf Auto-Sync** einschalten.

## Ordner

| Ordner | Inhalt |
|---|---|
| `01_Berichtsheft/` | Wochenberichte, legt das Cockpit selbst an |
| `02_Berufsschule/` | Mitschriften und Lernfelder |
| `03_Betrieb_Notizen/` | Praxiswissen und How-tos |
| `04_Assets_Screenshots/` | Bilder und Screenshots, Ziel für Strg+V |
| `05_Transfer_Inbox/` | Ablage vom Handy oder von anderen Geräten |

## Gut zu wissen

- Der Token bleibt im Browser des jeweiligen Geräts und wird nur an GitHub gesendet.
- Der Starter holt bei jedem Start Änderungen aus deiner Kopie (`git pull`), aber nur, wenn du lokal nichts geändert hast.
- Neue Versionen erscheinen als [Release im Original](https://github.com/n-sig/ausbildungs-cockpit/releases). Du übernimmst `dropzone.html`, `start_cockpit.cmd` und `sw.js` bewusst selbst. Ein automatischer Download wäre ein Einfallstor, denn die App arbeitet mit deinem Token.
