# 🤖 Ausbildungs-Cockpit

> **Deine autarke Ausbildungs-Zentrale** – Berichtsheft, Berufsschulnotizen, Praxis-Dokumentation und nahtloser Smartphone-Upload. Privat, werbefrei, ohne fremde Server.

---

## 🚀 In 3 Schritten startklar

### 1. Eigene private Kopie anlegen (30 Sek.)
1. Klicke oben rechts auf **„Use this template“** → **„Create a new repository“**.
2. Wähle einen Namen (z. B. `ausbildung`).
3. **Wichtig:** Wähle als Sichtbarkeit unbedingt **🔒 Private**, damit deine betrieblichen Notizen und Berichte geschützt bleiben.

### 2. Starten (1 Klick)
Klone dein neues Repository auf deinen Rechner (oder lade es unter **Code → Download ZIP** herunter und entpacke es):
* **Desktop-Icon anlegen:** Führe einmalig `create_desktop_icon.bat` aus – das legt dir eine direkte Verknüpfung auf deinen Desktop.
* **Oder direkt starten:** Doppelklicke auf `start_cockpit.cmd`.

*Hinweis: Das Cockpit öffnet sich automatisch als native App in deinem Browser (Edge, Brave oder Chrome). Ein installiertes Python genügt.*

### 3. Mit deinem Repository verbinden (1 Min.)
Beim ersten Start öffnet sich das Cockpit. Trage unter **⚙️ Einstellungen → GitHub** deine Daten ein:
1. Erstelle auf GitHub einen persönlichen Token:  
   **GitHub → Settings → Developer Settings → Personal access tokens → Fine-grained tokens**  
   *(Berechtigung: Repository access = dein Ausbildungs-Repository, Repository permissions = `Contents: Read and write`)*.
2. Trage deinen Token und deinen Repository-Namen (`benutzername/ausbildung`) ein.

**Fertig!** Dein Cockpit ist einsatzbereit.

---

## 📁 Ordnerstruktur im Überblick

Das Repository ist bereits optimal für deine Ausbildung vorstrukturiert:

| Ordner | Zweck |
|---|---|
| `00_Templates/` | Vorlagen für wöchentliche Berichte und strukturierte Notizen |
| `01_Berichtsheft/` | Deine wöchentlichen Ausbildungsnachweise (nach Ausbildungsjahren sortiert) |
| `02_Berufsschule/` | Mitschriften, Lernfelder, Klausurvorbereitung und Tafelbilder |
| `03_Betrieb_Notizen/` | Arbeitsplatz-Dokumentationen, Projekte und Praxishinweise |
| `04_Assets_Screenshots/` | Belege, Bilder und Anhänge |
| `05_Transfer_Inbox/` | **Smartphone-Ablage:** Fotos, Scans und Sprachnotizen vom Handy |

---

## 🔄 Wie deine Daten synchronisiert werden

* **Alles bleibt privat:** Dein GitHub-Token liegt ausschließlich im lokalen Speicher deines Browsers und wird niemals übertragen.
* **Automatischer Abgleich:** Jedes Mal, wenn du `start_cockpit.cmd` (oder dein Desktop-Icon) anklickst, synchronisiert der Starter deine lokalen Dateien automatisch mit GitHub (`git pull`).
* **Smartphone-Upload via Telegram:** Wenn du den optionalen [Telegram Ingestion Bot](https://github.com/n-sig/ausbildung-bot) nutzt, landen Fotos von der Tafel oder Notizen von unterwegs direkt in `05_Transfer_Inbox` – beim nächsten Öffnen des Cockpits am PC sind sie sofort da!
* **Updates der Oberfläche:** Der Starter holt Änderungen nur per `git pull` aus *deinem* Repository – und nur, wenn du lokal nichts geändert hast. Eine neue Version von `dropzone.html` übernimmst du bewusst selbst aus dem [Original-Repository](https://github.com/n-sig/ausbildungs-cockpit). Ein automatischer Download ohne Prüfung wäre ein Einfallstor: die Datei läuft mit Zugriff auf deinen GitHub-Token.
