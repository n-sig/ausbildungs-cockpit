# 📥 Transfer Inbox (PC ➔ Laptop)

Ablage für Dateien, die von einem anderen Gerät (Heim-PC, Schul-Laptop) auf den
Arbeitsrechner übertragen werden sollen — Skripte, Notizen, PDFs, Cheatsheets.

### Workflow

1. Datei hier ablegen.
2. Committen und pushen — aus dem Repo-Verzeichnis heraus:
   ```powershell
   git add .
   git commit -m "transfer files"
   git push origin main
   ```
   *(Von einem beliebigen Verzeichnis aus mit `git -C <pfad-zum-repo> …`.)*
3. Auf dem Zielgerät das Cockpit starten (`start_cockpit.cmd`), **Tab 1 — Transfer**.
4. Dort den Ordner-Reiter **Inbox** wählen und bei der gewünschten Datei auf
   **⬇ Download** klicken.
