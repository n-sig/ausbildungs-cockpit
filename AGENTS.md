# 🤖 Agent Instructions & Session Continuity

## 🎯 Primary Directive
At the beginning of every session or when resuming work:
1. **Always read `BACKLOG.md`** at the project root to understand current priorities, bug reports, and user-requested enhancements.
2. **Review git history and working tree:** Check `git status` and `git log -n 5 --oneline` to establish continuity with previous sessions across all devices (laptop & desktop).
3. **Execute open tasks** according to the priority order defined in `BACKLOG.md`.

## 🛠️ Tech Stack & Architecture Constraints
- **Single-File Client Web-App:** `dropzone.html` (Vanilla HTML5, modern CSS, ES6+ JavaScript, zero CDN or external library dependencies — the tool must work behind restrictive corporate proxies and firewalls).
- **Data Persistence:** GitHub REST API v3 via Personal Access Token (PAT) + fallback browser storage.
- **No hardcoded personal data:** Occupation, training start, exam dates, working-time model and folder structure all live in `cfg` and are set by the user. Never bake a specific person, employer, occupation or tariff into the code, the defaults or the documentation.
- **Design Philosophy:** Linear / Raycast / GitHub Dark style, clean developer aesthetics, zero patronizing AI slop.
