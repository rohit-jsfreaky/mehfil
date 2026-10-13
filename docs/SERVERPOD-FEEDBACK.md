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

### 5. A refresh cut short signs the user out for good (seen on Serverpod Cloud, Flutter web)
- **Date / version** — 13 Oct 2026 · serverpod_auth_core 4.1.0-beta.3 · JWT · Flutter web
- **What happened** — first seen once on a host tab (several tabs open), then reproduced on Serverpod Cloud with a guest:
  two quick reloads while the access token was expiring. The next refresh was refused —
  server log: `refreshAccessToken error=RefreshTokenInvalidSecretException` — the client signed the device out, and
  every call after that failed with "Please sign in" (our app then showed "No signal", which was wrong).
- **Why** — the refresh secret is single-use (rotating). If the page goes away after the server rotated it but before
  the new one is saved (a reload, a closed tab, a phone freezing a background tab), the saved secret is stale forever.
  The client source says as much: "an uncoordinated concurrent refresh from another tab may be treated as credential
  reuse and revoke the session".
- **What I expected** — a short grace window in which the previous refresh secret is still accepted once (common in
  rotating-token designs), or a documented recovery path. For an anonymous account there is no way back in as the same
  user, so the user loses their identity (for us: whose photos are whose).
- **Workaround** — Mehfil gives each guest a recovery key at join (the server stores only its SHA-256). When the
  session is lost, the phone calls `guest.recover(code, guestId, key)` and the server issues a new token for the same
  auth user with `AuthServices.instance.tokenManager.issueToken`. Verified on Cloud: session deleted → reload →
  `/guest/recover` 200 → the same guest's next photo delivered (row + file), no duplicate guest.
- **Suggestion** — a grace window for the previous refresh secret, and a doc section on recovering anonymous users.

### 6. A hand-written `.scloudignore` at the workspace root breaks Cloud builds with "bin/main.dart not found"
- **Date / version** — 13 Oct 2026 · Serverpod CLI 4.1.0-beta.3 (`serverpod cloud deploy`) · Dart workspace from `serverpod quickstart`
- **What happened** — I created `.scloudignore` myself (to ship the git-ignored `mehfil_server/web/app/`). The upload
  worked, then the Cloud build failed: `SERVER_DIR: .` … `RUN dart build cli -t bin/main.dart` →
  `"/app/bin/main.dart" file not found.` The server lives in `mehfil_server/`.
- **Why** — the CLI writes the server's folder to `.scloud/scloud_server_dir`, but every dot-folder is ignored unless
  opted back in. Only the CLI's own `.scloudignore` template opts it back in (`!.scloud/**`), and the CLI writes that
  template **only if no `.scloudignore` exists** (`ScloudIgnore.writeTemplateIfNotExists`). So any hand-written file
  silently drops `.scloud/` from the zip. `--wet-run --show-files` does show `.scloud (ignored)`, but nothing says it is
  required.
- **What I expected** — the CLI always includes the `.scloud/` files it generated itself, whatever the ignore files say
  (or the deploy refuses with "`.scloud/` is ignored, add `!.scloud/**`").
- **Workaround** — deleted my file, let the CLI write its template, then appended our lines to it.
- **Cost** — one failed build (~95 s) and ~20 minutes reading the CLI source (`prepare_project_files.dart`,
  `scloudignore.dart`) to find the cause.

### 7. On Serverpod Cloud's free Starter plan, every future-call method throws `Bad state: FutureCalls is not initialized.`
- **Date / version** — 13 Oct 2026 · Serverpod 4.1.0-beta.3 · Serverpod Cloud, Starter trial (future calls are a Growth feature)
- **What happened** — the same code that passes locally failed on Cloud. `futureCalls.callAtTime(...)` while creating an
  event, and `futureCalls.cancel(identifier)` in "Reveal now", both threw
  `Bad state: FutureCalls is not initialized.` from the generated `future_calls.dart`, and the endpoint returned HTTP 500.
- **What I expected** — a clear, typed error that names the cause (for example "Future calls are disabled on this Cloud
  plan"), and `cancel` of a call that can't exist being a no-op. The pricing page lists the limit, but nothing at
  runtime or in `serverpod cloud deploy` warns that the deployed code uses a disabled feature.
- **Workaround** — Mehfil wraps both calls (`RevealService.schedule` / `unschedule`) and adds a "reveal clock": every
  5 s the server opens any roll whose reveal time has passed, using the same exactly-once reveal. At start-up it probes
  whether future calls work; where they do, the clock waits 45 s past the reveal time, so the future call fires first
  and the clock finds nothing to do.
- **Suggestion** — a typed `FutureCallsDisabledException`, and a deploy-time hint when the generated code contains future
  calls but the plan disables them.

### 8. On Windows, `SERVERPOD_PASSWORD_<name>` environment variables arrive with the name in CAPITALS
- **Date / version** — 13 Oct 2026 · Serverpod 4.1.0-beta.3 · Dart 3.12 on Windows 11
- **What happened** — GitHub CI (Linux) had no `passwords.yaml`, so I gave the tests their auth keys as
  `SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper` etc. To check the fix on my Windows laptop I set the same variables,
  and the tests still failed with "jwtRefreshTokenHashPepper was not found". On Windows `Platform.environment` returns
  every key upper-cased (`SERVERPOD_PASSWORD_MYAPIKEY`), and `PasswordManager._findUserDefinedPasswordsFromEnv` keeps
  the rest of the key as the password name, so the password is stored as `JWTREFRESHTOKENHASHPEPPER`.
- **What I expected** — the same variable to work on every OS, since the docs show mixed-case names
  (`SERVERPOD_PASSWORD_myApiKey`).
- **Workaround** — none needed in production (Linux). For local checks on Windows, put the values in
  `config/passwords.yaml` instead.
- **Suggestion** — on Windows, match the suffix case-insensitively against the password names the code asks for (or
  look keys up through the case-insensitive map rather than iterating its upper-cased entries), and mention it in the
  passwords docs.
