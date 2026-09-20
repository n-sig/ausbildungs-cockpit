# Copilot Prompt-Leitfaden für den Firmen-Laptop

Nutze diese Prompts in der KI-Assistenz, die dein Betrieb freigegeben hat. Sie sorgen für professionelle, IHK-konforme Formulierungen und stellen sicher, dass keine vertraulichen Daten das Unternehmen verlassen.

---

## 1. Wochenbericht-Generator (Haupt-Prompt)

> **💡 Tipp:** In der `dropzone.html` kannst du oben einfach auf **„🤖 Copilot-Export“** klicken – das Cockpit baut diesen Prompt inklusive aller erfassten Aufgaben der Woche automatisch mit 1 Klick zusammen!

Alternativ kannst du diesen Prompt manuell in Copilot kopieren:

```text
Du bist mein Ausbildungsberater für [DEIN AUSBILDUNGSBERUF].
Ich gebe dir jetzt meine unstrukturierten Tagesnotizen und Aufgaben dieser Woche.

Erstelle daraus bitte:
1. Eine Liste 'Betriebliche Tätigkeiten' mit professionellen IHK-Formulierungen (aktiv formuliert, z.B. "Installation und Konfiguration von...", "Fehleranalyse und Behebung...").
2. Eine Liste 'Berufsschule' (falls Schultage vorhanden sind).
3. Eine tarifkonforme Stundenaufteilung auf genau 37,00 Stunden (Mo–Do jeweils 7,75h bzw. 7h 45m; Fr 6,00h bzw. 6h 00m).
4. Einen kompakten Kopiervorlagen-Textblock, den ich direkt in mein Online-Berichtsheft einfügen kann.

WICHTIGE COMPLIANCE-REGELN:
- Entferne alle internen Hostnamen, IP-Adressen, Passwörter, Ticket-Nummern und Firmen-/Kundennamen.
- Formuliere die Aufgaben neutral und allgemeinverständlich nach dem IHK-Rahmenlehrplan.

Hier sind meine Notizen der Woche:
[HIER DEINE NOTIZEN EINFÜGEN]
```

---

## 2. Einzel-Tätigkeit neutralisieren & aufwerten

Wenn du eine konkrete Aufgabe hattest und nicht weißt, wie man sie formal formuliert:

```text
Formuliere folgende Tätigkeit in 2-3 professionellen, IHK-konformen Stichpunkten für mein Berichtsheft, ohne Firmengeheimnisse zu nennen:

Aufgabe: [z.B. "Habe heute den ganzen Tag an einem Skript gebastelt, weil die Verbindung bei Usern abgebrochen ist"]
```

*Beispiel-Ausgabe von Copilot:*
* *Analyse von Netzwerk-Routingproblemen und Authentifizierungsfehlern im Proxy-Umfeld*
* *Entwicklung von Automatisierungsskripten zur Diagnose von Verbindungsausfällen*
* *Dokumentation der Lösungsansätze für den 1st- und 2nd-Level-Support*

---

## 3. Berufsschul-Zusammenfassung aus Folien / Skripten

Wenn du ein PDF oder Skript aus der Berufsschule hast und die Lerninhalte zusammenfassen willst:

```text
Fasse die Kerninhalte dieses Unterrichtsstoffs in 3 prägnanten Stichpunkten für das IHK-Berichtsheft unter 'Berufsschule' zusammen. Nenne das passende Fachgebiet / Lernfeld.
```
