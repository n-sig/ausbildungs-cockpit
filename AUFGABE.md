# Bonus-Aufgabe: Dein eigener Telegram-Bot

**Bau dir einen Telegram-Bot, der Fotos, Dateien und Notizen von deinem Handy in dein Cockpit bringt.**

Es gibt keine Schritt-für-Schritt-Anleitung. Du entscheidest, wie dein Bot aussieht und was er kann. Die KI ist deine Teampartnerin – du hast das Sagen.

← [Zurück zur Anleitung](README.md)

## So hängt alles zusammen

```text
Telegram  →  dein Bot  →  deine Kopie auf GitHub  →  Cockpit
```

Bot und Cockpit reden nie direkt miteinander. **Das Repository ist der Treffpunkt:** Was dein Bot in einen Ordner legt, zeigt das Cockpit in Tab 1 „Transfer“ im passenden Reiter. Neue Dateien siehst du nach einem Klick auf den Aktualisieren-Pfeil über der Dateiliste oder mit F5.

## 5 feste Regeln

1. **Nutze die Ordner des Cockpits** oder neue Ordner (siehe unten).

   | Ordner in deiner Kopie | Reiter im Cockpit |
   |---|---|
   | `05_Transfer_Inbox` | Inbox |
   | `04_Assets_Screenshots` | Screenshots |
   | `02_Berufsschule` | Berufsschule |
   | `03_Betrieb_Notizen` | Betrieb |

2. **Finger weg von `01_Berichtsheft/`** und den Dateien im Hauptordner. Dort arbeitet das Cockpit selbst.
3. **Jeder Dateiname nur einmal**, zum Beispiel `2026-09-26_14-30-05.jpg`. Keine Doppelpunkte, keine Zeichen `\ / * ? " < > | #` und kein Punkt am Anfang. Sonst kann Windows die Datei nicht anlegen oder das Cockpit blendet sie aus. Gibt es den Namen im Ordner schon, lehnt GitHub die Datei ab.
4. **Nur du darfst deinen Bot benutzen.** Sonst kann jeder, der ihn findet, in deine Kopie schreiben.
5. **Tokens gehören nie ins Repository.** Ist doch einer hineingeraten: Token sofort löschen und einen neuen erstellen.

## Neue Ordner

- GitHub kennt keine leeren Ordner. Ein Ordner entsteht erst mit seiner ersten Datei. Soll er leer bleiben, legst du eine leere `.gitkeep` hinein. Das Cockpit blendet sie aus.
- Das Cockpit zeigt neue Ordner nicht von selbst. In Tab 1 auf **+** klicken, Name und Pfad eintragen, zum Beispiel `02_Berufsschule/LF_03`, dann **Hinzufügen**. Mit Auto-Sync erscheint der Reiter nach F5 auch auf deinen anderen Geräten.
- Ein Reiter zeigt nur die Dateien direkt in seinem Ordner. Für jeden Unterordner legst du einen eigenen Reiter an.
- Ordnernamen nur aus A–Z, a–z, 0–9, Leerzeichen, `.`, `_` und `-` (keine Umlaute, kein ß). Am Anfang ein Buchstabe oder eine Zahl, am Ende kein Punkt und kein Leerzeichen, höchstens 6 Ebenen. Andere Namen kann das Cockpit nicht anbinden.

## Was du brauchst

- einen Bot-Token von **@BotFather** in Telegram
- deine Telegram-User-ID
- einen eigenen GitHub-Token für den Bot: Fine-grained, nur für deine Kopie, **Contents: Read and write**. So kannst du ihn einzeln löschen.
- einen Suchbegriff für dich und deine KI: *GitHub REST API – Create or update file contents*

## Deine Level

| Level | Dein Bot kann … |
|---|---|
| Bronze | … ein Foto vom Handy in `05_Transfer_Inbox` ablegen, und du siehst es im Cockpit. |
| Silber | … dich per Knopf den Zielordner wählen lassen und auch Dokumente und Textnotizen annehmen. |
| Gold | … etwas mit KI: Aus einer Sprachnachricht wird Text, aus einem Foto wird Text, der passende Ordner wird vorgeschlagen – oder deine eigene Idee. |
| Rakete | … rund um die Uhr auf einem Server laufen. |

## Wo läuft dein Bot?

- **Auf deinem PC:** Hier baust und testest du am schnellsten. Der Bot läuft aber nur, solange dein PC an ist. Leg ihn in einen eigenen Ordner, nicht in den Ordner deiner Kopie. Sonst holt der Starter des Cockpits keine Änderungen mehr.
- **Auf einem Server** (VPS, Raspberry Pi oder Homelab): Der Bot läuft rund um die Uhr. Das Foto aus der Bahn landet sofort in deiner Kopie, auch wenn dein PC aus ist.

> [!TIP]
> Dein Bot kann neue Nachrichten selbst bei Telegram abholen („Long Polling“). Dann braucht dein Server keinen offenen Port.

## Mit KI bauen

1. **Erst das Ziel, dann der Code.** Gib der KI diese Aufgabe und lass sie zuerst einen Plan machen.
2. **Kleine Schritte.** Nach jedem Schritt testen.
3. **Nichts übernehmen, was du nicht verstehst.** Frag so lange nach, bis du es erklären kannst.

Dein Start-Prompt, zum Kopieren in die KI deiner Wahl:

```text
Ich baue meinen ersten Telegram-Bot und möchte dabei alles verstehen.

Ziel: Der Bot nimmt Fotos, Dateien und Notizen von meinem Handy an und legt sie in mein GitHub-Repository benutzername/ausbildung. Mein Ausbildungs-Cockpit zeigt sie von dort aus an.

Regeln:
- Ordner: 02_Berufsschule, 03_Betrieb_Notizen, 04_Assets_Screenshots, 05_Transfer_Inbox oder neue Ordner (nur A–Z, a–z, 0–9, _ und -)
- Nie in 01_Berichtsheft/ oder in Dateien im Hauptordner schreiben
- Jeder Dateiname nur einmal, zum Beispiel 2026-09-26_14-30-05.jpg (keine Doppelpunkte, keine Zeichen \ / * ? " < > | #, kein Punkt am Anfang)
- Nur meine Telegram-User-ID darf den Bot benutzen
- Keine Tokens im Code oder im Repository

Mach zuerst einen Plan mit kleinen Schritten. Frag mich, welche Programmiersprache ich nehmen möchte und wo der Bot laufen soll. Erklär mir jeden Schritt, bevor wir ihn bauen.
```

## Wann bist du fertig?

Das entscheidest du selbst.

- [ ] Ich schicke etwas vom Handy und sehe es im Cockpit.
- [ ] Nur ich kann meinen Bot benutzen.
- [ ] In meinem Repository liegt kein Token, auch nicht in einem alten Commit.
- [ ] Ich kann in zwei Minuten erklären, wie mein Bot funktioniert.
- [ ] Ich habe schon eine Idee, was er als Nächstes können soll.
