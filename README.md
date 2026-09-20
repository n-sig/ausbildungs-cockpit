# 🎓 Ausbildungs-Cockpit

Wochenplanung, Zeiterfassung, Berichtsheft-Export und Dateiablage für die Ausbildung — als **eine einzige HTML-Datei**. Keine Installation, kein CDN, kein Build-Schritt, keine Registrierung, kein Server.

Gedacht für Azubis, die ihren Ausbildungsnachweis nicht jeden Freitag aus dem Gedächtnis rekonstruieren wollen.

```cmd
start_cockpit.cmd
```

Mehr braucht es nicht. Beim ersten Start fragt ein kurzer Assistent nach Beruf, Ausbildungsbeginn und Arbeitszeitmodell — danach läuft es.

---

## Was es kann

* **Wochenplaner** mit Tageskarten, Schnellerfassung und Duplikatschutz. Das 52-KW-Radar zeigt auf einen Blick, welche Woche noch offen ist.
* **Zeiterfassung** mit Gleitzeitkonto, Pausenautomatik und frei einstellbarem Wochenmodell (37 h, 38,5 h, 40 h oder individuell).
* **Berichtsheft-Export**: Einzeltage einzeln kopierbar, kompletter Wochennachweis als Markdown, dazu ein fertiger KI-Prompt, der deinen Beruf, deine Sollstunden und deine Fachgebiete einsetzt — mit eingebauter Anonymisierungs-Anweisung.
* **Zeichenlimit-Wächter**: warnt, bevor dein Berichtsheft-Portal den Text abschneidet. Limits sind einstellbar.
* **IHK-Navigator** mit den Lernfeldern deiner Fachrichtung.
* **Dateiablage** mit frei konfigurierbaren Ordner-Reitern, Drag-and-Drop und Screenshot-Upload per <kbd>Strg</kbd>+<kbd>V</kbd>.
* **Undo** über 25 Schritte, <kbd>Strg</kbd>+<kbd>Z</kbd>. Auch für gelöschte Dateien.
* **Dark / Light Mode**, Tastenkürzel, alles <kbd>F5</kbd>-fest.

### Wo deine Daten liegen

Local-First, in dieser Reihenfolge:

1. `localStorage` — sofort und synchron
2. **IndexedDB-Snapshot** — fest aktiv, überlebt Bereinigungen, die nur `localStorage` treffen
3. **Lokaler Ordner** über die File System Access API — eine `.md` pro Woche plus ein Vollbackup, direkt in OneDrive oder einen Obsidian-Vault
4. **GitHub** — optional, standardmäßig aus

Ebene 1 und 2 laufen immer. 3 und 4 sind Zusatzsicherungen, die du im Assistenten oder später in den Einstellungen verknüpfst. Ohne beides funktioniert das Cockpit vollständig.

---

## Loslegen

### Eigene Kopie anlegen

Oben auf **„Use this template" → „Create a new repository"**.

> ⚠️ **Sichtbarkeit auf `Private` stellen.** Ausbildungsnachweise enthalten Angaben über deinen Betrieb und deinen Arbeitsalltag. Die gehören nicht in ein öffentliches Repository.

Dann klonen oder als ZIP herunterladen — und `start_cockpit.cmd` ausführen.

Wer kein GitHub braucht: die Datei `dropzone.html` samt `start_cockpit.cmd`, `sw.js`, `manifest.webmanifest` und den beiden Icons genügt. Alles Weitere ist Ablagestruktur.

Ausführlicher steht das in [`SETUP.md`](SETUP.md).

### Warum ein Starter und kein Doppelklick?

Beim Doppelklick öffnet der Browser die Datei über `file://`. Dort ist `isSecureContext === false`, und damit sind **vier Dinge gleichzeitig gesperrt**:

| gesperrt auf `file://` | Folge im Cockpit |
|---|---|
| File System Access API | keine Ordner-Anbindung an OneDrive / Obsidian |
| Service Worker | keine PWA, kein Offline-Cache |
| `navigator.storage.persist()` | der Browser darf den Speicher jederzeit aufräumen |
| `navigator.clipboard` | kein <kbd>Strg</kbd>+<kbd>V</kbd>-Screenshot-Upload |

`start_cockpit.cmd` startet deshalb einen winzigen lokalen Server (`python -m http.server`) auf `http://localhost:8137` und öffnet den Browser im App-Modus. `http://localhost` gilt als *potentially trustworthy origin* und ist ein vollwertiger Secure Context.

**Der Port ist Teil des Origins.** `:8137` und `:8138` sind für den Browser zwei getrennte Speicherbereiche — ein Ausweichen auf einen freien Port ließe localStorage, IndexedDB *und* die Ordner-Verknüpfung schlagartig leer aussehen, also exakt wie Datenverlust. Der Starter zählt deshalb bei belegtem Port **nicht hoch, sondern bricht ab**.

Voraussetzung ist ein installiertes Python im `PATH`. Jeder andere statische Server tut es auch, solange er auf demselben Port läuft.

---

## Einrichtung

Der Erststart-Assistent fragt fünf Dinge ab, jedes davon überspringbar und später unter **⚙️ Einstellungen** änderbar:

1. **Beruf** — bestimmt die Lernfelder im IHK-Navigator
2. **Eckdaten** — Ausbildungsbeginn, Prüfungstermine (werden vorgeschlagen), Betrieb
3. **Arbeitszeitmodell** — setzt die Tagessollzeiten
4. **Ablage** — lokaler Ordner und / oder GitHub
5. **Ordner-Reiter** — die Reiter in Tab 1

### GitHub verbinden (optional)

Nur nötig für Datei-Upload und Wochenarchivierung im Repository.

1. GitHub → **Settings → Developer Settings → Personal access tokens → Fine-grained tokens**
2. Repository access: **Only select repositories** → dein Ausbildungs-Repository
3. Permissions: **Repository permissions → Contents: Read and write**
4. Token und `benutzername/repository` in **⚙️ Einstellungen → GitHub** eintragen

Das Token bleibt im Browser-Speicher und wird bewusst **nicht** in Datei-Backups geschrieben, damit es nicht über einen synchronisierten Ordner abfließt.

### Ordner-Reiter anpassen

Die Reiter in Tab 1 sind frei konfigurierbar: **⚙️ Einstellungen → Ordner**, oder das **+** am Ende der Reiterleiste.

Pro Reiter Name, Zielpfad und eine optionale Rolle (`Strg+V`-Ziel, Ablage-Ziel). Zeigt ein Reiter auf einen Ordner, den es im Repository noch nicht gibt, legt ein Klick ihn an.

> Den Pfad zu ändern verschiebt **keine** Dateien — der Reiter zeigt danach nur woanders hin.

### Eigenen Beruf ergänzen

Enthalten sind Systemintegration und Anwendungsentwicklung sowie „Anderer Beruf" mit den Lernfeldern 1–9, die im Rahmenlehrplan der IT-Berufe für alle Fachrichtungen gleich sind.

Für eine weitere Fachrichtung reicht ein Eintrag in `BERUF_PRESETS` in `dropzone.html`:

```js
fidp: {
  label: 'Fachinformatiker/-in für Daten- und Prozessanalyse',
  kurz: 'FIDP',
  fachgebiete: 'Datenanalyse, Prozessmodellierung, …',
  lernfelder: LERNFELDER_BASIS.concat([
    { id: 10, year: 3, name: '…' },
    { id: 11, year: 3, name: '…' },
    { id: 12, year: 3, name: '…' }
  ])
}
```

Die Titel stehen in deinem Rahmenlehrplan. Sie sind hier bewusst nicht geraten — falsche Lernfeldbezeichnungen in einem Ausbildungsnachweis sind schlimmer als gar keine. Pull Requests mit belegten Lernfeldern sind willkommen.

---

## Wenn etwas nicht stimmt

### Daten verschwinden beim Schließen des Browsers

Fast immer eine Browser- oder Richtlinien-Einstellung, nicht die App.

**1. `edge://settings/content/cookies`** (Chrome: `chrome://settings/cookies`)

> „Cookies und Websitedaten löschen, wenn alle Fenster geschlossen werden"

Ist der Schalter **an und klickbar**: ausschalten — damit ist es in aller Regel erledigt. Auf derselben Seite lässt sich `http://localhost:8137` als Ausnahme eintragen.

**2. `edge://policy`** — ist der Schalter ausgegraut, steuert ihn eine Unternehmensrichtlinie. Relevant sind:

```
ClearBrowsingDataOnExit            ForceEphemeralProfiles
ClearBrowsingDataOnExitList        DefaultCookiesSetting
SaveCookiesOnExit                  DefaultFileSystemWriteGuardSetting
```

Gegen Richtlinien hilft die App nicht — aber die IndexedDB-Snapshots und der lokale Ordner fangen den Verlust auf. Beide sind deshalb standardmäßig aktiv.

**3. Browser wirklich beenden zum Gegentesten.** Edge läuft nach dem Schließen des letzten Fensters oft im Hintergrund weiter; im Task-Manager prüfen, dass kein `msedge.exe` mehr läuft — sonst misst man ein falsch-positives Ergebnis.

### Nach einer Änderung erscheint die alte Fassung

Kein Datenverlust, sondern der Service-Worker-Cache. Er fährt **Network-First für HTML**: solange der lokale Server antwortet, kommt die App frisch vom Server. Falls doch etwas hängt: <kbd>Strg</kbd>+<kbd>Umschalt</kbd>+<kbd>R</kbd>, oder DevTools → *Application* → *Service Workers* → *Unregister*.

> ⚠️ **Beim Ändern der Asset-Liste aufpassen:** `sw.js` lädt `CORE_ASSETS` per `cache.addAll()` — das ist **atomar**. Ein einziger 404 darin verhindert, dass *überhaupt etwas* gecacht wird, und meldet das nur als `console.warn`. Wer ein Icon entfernt oder umbenennt, muss `CORE_ASSETS` mitziehen **und** `CACHE_VERSION` hochzählen.

### „Port 8137 ist belegt"

Nicht auf einen anderen Port ausweichen (siehe oben) — stattdessen den Prozess finden:

```powershell
Get-NetTCPConnection -LocalPort 8137 -State Listen | Select-Object OwningProcess
```

---

## Mitmachen

`dropzone.html` ist **eine eigenständige Datei**: Vanilla HTML5, modernes CSS, ES6+ — **null CDN, null Libraries, kein Build-Schritt**. Das ist Absicht und keine Bequemlichkeit: das Tool muss hinter restriktiven Unternehmens-Proxies und ohne Internet funktionieren. Bitte diese Grenze beibehalten.

Die Projektregeln stehen in [`AGENTS.md`](AGENTS.md) — sie gelten für Menschen genauso wie für KI-Assistenten.

Besonders willkommen: belegte Lernfelder weiterer Ausbildungsberufe, Übersetzungen, und Berichte darüber, wie sich das Tool in anderen Betrieben schlägt.

---

## Lizenz

[MIT](LICENSE) — nutzen, ändern, weitergeben, gern auch für den ganzen Ausbildungsjahrgang.
