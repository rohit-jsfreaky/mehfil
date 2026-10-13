{{flutter_js}}
{{flutter_build_config}}

// Mehfil uses its own offline worker (mehfil_sw.js, registered in index.html),
// so the app starts without waiting for Flutter's service worker. That wait
// added ~4 s to every open with no signal.
_flutter.loader.load();
