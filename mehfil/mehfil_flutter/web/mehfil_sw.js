// Mehfil offline shell. A guest who opened the QR link once can reopen it in a
// hall with no signal: the app loads from this cache, and the photos waiting
// on the phone are in its own database (SQLite in the browser), not here.
const CACHE = 'mehfil-shell-v1';

// Big files that only change with a new Flutter/sqlite version: cache first.
const STABLE = [/\/canvaskit\//, /\/sqlite3\.wasm$/, /\/db_worker\.js$/, /\/assets\/fonts\//, /\.ttf$/, /\.otf$/];

self.addEventListener('install', () => self.skipWaiting());

// The page tells us which files it loaded (see index.html). We keep exactly
// those, so a phone never downloads build files the app does not use.
self.addEventListener('message', (event) => {
  const urls = (event.data && event.data.mehfilCache) || [];
  event.waitUntil(
    caches.open(CACHE).then((cache) =>
      Promise.all(
        urls.map((u) =>
          cache.match(u).then((hit) => hit || cache.add(u).catch(() => {})),
        ),
      ),
    ),
  );
});
self.addEventListener('activate', (event) => event.waitUntil(self.clients.claim()));

function timeout(ms) {
  return new Promise((_, reject) => setTimeout(() => reject(new Error('timeout')), ms));
}

async function networkFirst(request, cacheKey) {
  const cache = await caches.open(CACHE);
  try {
    // On one bar of signal, give up after a few seconds and use the cache.
    const response = await Promise.race([fetch(request), timeout(5000)]);
    if (response.ok) cache.put(cacheKey, response.clone());
    return response;
  } catch (err) {
    const cached = await cache.match(cacheKey);
    if (cached) return cached;
    throw err;
  }
}

async function cacheFirst(request) {
  const cache = await caches.open(CACHE);
  const cached = await cache.match(request);
  if (cached) return cached;
  const response = await fetch(request);
  if (response.ok) cache.put(request, response.clone());
  return response;
}

self.addEventListener('fetch', (event) => {
  const request = event.request;
  if (request.method !== 'GET') return;
  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return;

  if (request.mode === 'navigate') {
    // Every page (/e/CODE, /wall/CODE, /) is the same Flutter shell.
    event.respondWith(networkFirst(request, new Request('/index.html')));
    return;
  }
  if (STABLE.some((re) => re.test(url.pathname))) {
    event.respondWith(cacheFirst(request));
    return;
  }
  event.respondWith(networkFirst(request, request));
});
