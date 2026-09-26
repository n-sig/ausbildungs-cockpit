// =========================================================================
// Ausbildungs-Cockpit | Service Worker (PWA Offline-Cache & Resilience)
// =========================================================================
// WICHTIG - Strategiewechsel:
// Der frühere Stale-While-Revalidate galt für ALLE GET-Requests, also auch
// für dropzone.html. Zusammen mit einem nie wechselnden CACHE_NAME führte das
// dazu, dass nach einer Änderung an der App zuerst die ALTE Fassung aus dem
// Cache kam. Das fühlt sich an wie Datenverlust, ist aber eine veraltete App -
// ein teures Phantom, seit die App über http://localhost läuft und der
// Service Worker dort überhaupt erst aktiv wird.
//
// Jetzt gilt:
//   - Dokument/HTML  -> Network-First (Cache nur als Offline-Rettung)
//   - übrige Assets  -> Stale-While-Revalidate (Icons, Manifest)
// =========================================================================

// v3: Archivdateien werden nicht mehr gecacht - alte Cache-Eintraege mit
// veralteten KW-Dateien fallen beim Aktivieren weg.
// v4: Manifest und app.png entfernt (keine Browser-Installation mehr, der
// Starter oeffnet das App-Fenster selbst).
const CACHE_VERSION = 'v4';
const CACHE_NAME = 'cockpit-cache-' + CACHE_VERSION;
const CORE_ASSETS = [
  './',
  './dropzone.html',
  './app.ico'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(CORE_ASSETS).catch((err) => {
        console.warn('[SW] Pre-cache warning (some assets may be optional):', err);
      });
    }).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => {
          if (key !== CACHE_NAME) {
            console.log('[SW] Clearing old cache:', key);
            return caches.delete(key);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// Ist das der App-Code selbst? Dann niemals aus dem Cache bedienen,
// solange das Netz (hier: der lokale Server) antwortet.
function isAppDocument(req, url) {
  if (req.mode === 'navigate') return true;
  if (req.destination === 'document') return true;
  return /\.html?$/i.test(url.pathname);
}

self.addEventListener('fetch', (event) => {
  const req = event.request;
  const url = new URL(req.url);

  // Strikter Bypass für GitHub REST API und Nicht-GET Aufrufe
  if (req.method !== 'GET' || url.hostname.includes('api.github.com')) {
    return;
  }

  // Archiv- und Nutzerdateien aus der Arbeitskopie: nie aus dem Cache.
  // Stale-While-Revalidate lieferte sonst beim "Aus Archiv laden" zuerst
  // eine alte Fassung einer Wochendatei aus.
  if (url.origin === self.location.origin && /\/0[0-5]_[^/]+\//.test(url.pathname)) {
    return;
  }

  // --- 1. App-Dokument: Network-First -------------------------------------
  // Der lokale Server ist immer da, solange die App läuft. Fällt er aus,
  // rettet der Cache die Sitzung - aber er bestimmt nie den Normalfall.
  if (isAppDocument(req, url)) {
    event.respondWith(
      fetch(req).then((networkResponse) => {
        if (networkResponse && networkResponse.status === 200) {
          const resClone = networkResponse.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(req, resClone));
        }
        return networkResponse;
      }).catch(() => {
        return caches.match(req).then((cached) => {
          return cached || caches.match('./dropzone.html');
        });
      })
    );
    return;
  }

  // --- 2. Übrige Assets: Stale-While-Revalidate ---------------------------
  event.respondWith(
    caches.match(req).then((cachedResponse) => {
      const fetchPromise = fetch(req).then((networkResponse) => {
        if (networkResponse && networkResponse.status === 200) {
          const resClone = networkResponse.clone();
          caches.open(CACHE_NAME).then((cache) => cache.put(req, resClone));
        }
        return networkResponse;
      }).catch(() => {
        // Netzwerk offline: Liefert gespeicherten Cache zurück
        return cachedResponse;
      });

      return cachedResponse || fetchPromise;
    })
  );
});
