# SERVERPOD-FEEDBACK.md — notes for the "Most Valuable Feedback" form

The Serverpod team asked for feedback, especially on offline sync ("We want developers to start
building with it and tell us where it needs improvement"). This prize is per person and needs an
eligible submission plus the feedback form. Write notes here the moment something happens —
don't try to remember at the end.

Format for each note:
- **Date / version** — Serverpod x.y.z, serverpod_offline_sync x.y.z
- **What I tried**
- **What happened** (exact error text, or the surprising behaviour)
- **What I expected**
- **Workaround** (if any)
- **Suggestion**

## Offline sync

## Future calls and recurring tasks

## Streaming

## Web server (Relic) / Flutter web

## Auth

## Serverpod Cloud

## Docs and CLI

## Agent skills / MCP (if used)

---
## Notes (written as they happened)

### 1. Embedded PostgreSQL inherits `PGPORT` and then can't be reached (Windows)
- **Date / version** — 13 Oct 2026 · Serverpod 4.1.0-beta.3 · serverpod_embedded_postgres 4.1.0-beta.3 · Windows 11 · Dart 3.13.5
- **What I tried** — fresh `serverpod quickstart mehfil`, then `serverpod start`.
- **What happened** — `ERROR: Serverpod could not start the local database.` →
  `SocketException: Connection failed (OS Error: No connection could be made because the target machine actively refused
  it, errno = 10061), address = .serverpod\development\run\.s.pgsql.5432, port = 5432`.
  `postgres.log` shows the embedded server came up fine, but on `listening on Unix socket "../run/.s.PGSQL.5433"`.
  My user environment has `PGPORT=5433` (from another project). The spawned `postgres` reads `PGPORT`; the generated
  `postgresql.conf` leaves `#port = 5432` commented out; the Dart side hard-codes `.s.PGSQL.5432`
  (`_pgDefaultPort` in `embedded_postgres_impl.dart`).
- **What I expected** — the embedded database ignores the developer's global libpq variables (it owns its own data dir and
  socket dir, so it should own its port too).
- **Workaround** — start the server with the `PG*` variables removed: `env -u PGPORT -u PGHOST -u PGUSER -u PGDATABASE -u PGPASSWORD serverpod start`.
- **Suggestion** — write `port = 5432` into the generated `postgresql.conf` (or pass `-p 5432`), and/or strip `PG*` from the
  child process environment. The error message could also print the socket path postgres actually reported in its log.
  (Upstream issue drafted: see `docs/upstream/embedded-postgres-pgport.md`.)

### 2. A failed first start leaves an embedded cluster with no database, and later starts don't repair it
- **Date / version** — 13 Oct 2026 · Serverpod 4.1.0-beta.3
- **What happened** — after note 1 crashed the first `serverpod start` inside `_ensureDatabase`, every later start failed
  with `Severity.fatal 3D000: database "mehfil" does not exist` and retried forever ("Retrying to connect to the database
  in 10 seconds"). `initdb` had finished, so the next start treated the cluster as ready and skipped `CREATE DATABASE`.
- **What I expected** — the embedded path re-checks that the configured database exists on every start (it is cheap).
- **Workaround** — delete `mehfil_server/.serverpod/development` (it was empty) and start again.

### 3. `withServerpod` test pods don't wire offline sync the way the generated `Serverpod` class does
- **Date / version** — 13 Oct 2026 · Serverpod 4.1.0-beta.3 · serverpod_offline_sync 0.0.11
- **What happened** — an endpoint that calls `session.offlineSync.spaces.createFor(...)` works on the real server but
  throws in `dart test`: `Bad state: The OfflineSyncEngine has not been initialized for this Serverpod instance.`
  After passing `databaseInterceptor: offlineSyncDatabaseInterceptor` and calling `initializeOfflineSync`, a second
  surprise: `session.db` in tests is a `TestDatabaseProxy`, so `session.db as OfflineSyncDatabase` (needed for
  `transactionForUser` on the server) fails with `type 'TestDatabaseProxy' is not a subtype of type 'OfflineSyncDatabase'`.
- **What I expected** — generated test tools mirror the generated `Serverpod` constructor (interceptor + sync tables),
  and a public server-side accessor such as `session.offlineSyncDb` that works on both.
- **Workaround** — in tests, `databaseInterceptor: offlineSyncDatabaseInterceptor` + `initializeOfflineSync(syncTables:)`;
  in code, `db is OfflineSyncDatabase ? db : offlineSyncDatabaseInterceptor(session, db)`.

### 4. An endpoint named `HostEndpoint` generates a client that doesn't compile
- **Date / version** — 13 Oct 2026 · Serverpod 4.1.0-beta.3
- **What happened** — `serverpod generate` succeeded and `dart analyze` on the server was clean, but any Dart program using
  the client failed: `client.dart:533:12: Error: A value of type 'EndpointHost' can't be assigned to a variable of type
  'String'. host = EndpointHost(this);` — the generated `late final EndpointHost host` collides with
  `ServerpodClientShared.host` (the server URL).
- **What I expected** — the generator rejects (or renames) endpoint names that collide with members of the client base
  class (`host`, `close`, `caller`, ...), the same way it validates model names.
- **Workaround** — renamed it to `EventsEndpoint` (`client.events`).

### 5. (Unconfirmed) a host was signed out after several tabs opened
- **Date / version** — 13 Oct 2026 · serverpod_auth_idp_flutter 4.1.0-beta.3 · JWT · Flutter web
- **What happened** — once, after a host opened two more tabs of the app (live wall, judge page) and ran the judge
  page, the host tab came back signed out. Each tab called `client.auth.initialize()`, which forces a refresh of a
  rotating refresh token, so concurrent refreshes were our first suspect.
- **Status** — NOT reproduced afterwards (sequential tabs and three tabs loading at the same moment both stayed signed
  in, with `restore()` at start-up). Could have been our test timing. Kept as an observation, not a bug report.
- **What we changed anyway** — `client.auth.restore()` at start-up instead of `initialize()`; refresh happens lazily.
- **Question for the team** — is concurrent `refreshAuthKey(force: true)` from several tabs safe with JWT rotation?
