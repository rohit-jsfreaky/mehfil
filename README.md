# Mehfil

**The wedding's disposable camera on every guest's phone. It keeps working with no signal, and the whole album opens
for everyone the next morning.** A Flutter app powered by Serverpod.

> After every Indian wedding, the best photos are stuck on 300 guests' phones. Mehfil collects them, even from the
> basement hall with no signal, and reveals the album to everyone the next morning.

▶ **Demo video:** — (link added when uploaded, under 2 minutes)
🌐 **Live:** — (Serverpod Cloud URL added after deploy) · **Android app for hosts:** — (APK link)

*Draft. Every number below comes from a file in [`evidence/`](evidence/). A "—" means we don't have the real number yet.*

---

## Judge it in 90 seconds

1. Open the live guest link on your phone (no app, no account): — 
2. Type a name, turn on airplane mode, take 3 photos. The app says *"3 photos saved on your phone"*.
3. Close the tab. Open the link again, still in airplane mode: the app opens and the 3 photos are still waiting.
4. Turn airplane mode off. The photos send themselves. The couple's live wall counts them, but shows none of them.
5. Host demo login — (added after deploy) → open the event → **Reveal now** → the album appears on your phone.

Or run the proofs yourself against a local server (see [Run it locally](#run-it-locally)):

```bash
dart run mehfil_tools:attacks                 # 10 ways a guest might peek before the reveal
dart run mehfil_tools:proof_reveal_restart setup   # then restart the server, then:
dart run mehfil_tools:proof_reveal_restart check
```

## What we measured (local runs, 13 Oct 2026)

| claim | result | evidence |
|---|---|---|
| Nothing is lost with no signal | 6 photos taken in a browser at phone size: 3 with the network cut, 3 with the server stopped; tab closed and reopened while still offline. Server afterwards: 6 rows synced, 6 files, 6 delivered, 0 lost | [`offline-browser-test-event34-*.json`](evidence/proofs/) |
| Sends the moment signal returns | Server back at 12:07:01 UTC, all 6 photos confirmed by 12:07:11 UTC | same file |
| Nobody sees photos before the reveal | 10 of 10 attacks held, including a second guest running real offline sync and receiving 0 of the first guest's rows | [`attacks-*.json`](evidence/proofs/) |
| The reveal fires after a server restart, once | Server fully stopped and restarted before the reveal time; the reveal fired once, 1.7 s after its time, with all 4 photos | [`reveal-restart-*.json`](evidence/proofs/) |
| Used at a real gathering | — (Wed 14 Oct) | — |

## The problem

Indian weddings run over several days and several functions (Haldi, Mehndi, Sangeet, Shaadi), often in banquet halls,
basements and farmhouses with weak signal. The photos end up scattered across guests' phones and a WhatsApp group,
compressed or never sent. Apps like POV and PartyCam proved people want a "disposable camera" for events, but a 2026
comparison notes: *"Venue Wi-Fi dead zones break the upload flow entirely, since POV has no offline queuing."*
Mehfil is the offline-first version.

## How Serverpod does the real work

| part | what it does | Serverpod piece | where |
|---|---|---|---|
| Shots | each photo's row (who, roll, the phone's "taken at" claim) is written on the phone first, in the guest's own space | **offline sync** (`database: sync`, personal space) | `mehfil_server/lib/src/models/shot.spy.yaml`, `mehfil_flutter/lib/guest/guest_session.dart` |
| Upload queue | the photo bytes wait in the phone's own SQLite (in the browser too) until the server confirms them | **client-side database** (`database: client`) | `pending_upload.spy.yaml` |
| Files | the server checks the SHA-256, stores the photo and a thumbnail in **private** storage, stamps server time | **file storage** + endpoints | `lib/src/shots/shot_endpoint.dart` |
| Live wall | counts climb on the couple's TV as photos land | **streaming** endpoint + server events | `lib/src/wall/` |
| Reveal | the album opens at the set time, even after a restart, exactly once | **future call** `callAtTime` + cancel by identifier | `lib/src/reveal/` |
| Album | at the reveal every guest becomes a read-only member of the event's album space; phones pick it up on the next sync | **offline sync shared spaces + roles** | `reveal_service.dart` |
| Who is who | hosts sign in with email; guests get an anonymous session that only a real QR code can create | **auth** (email + anonymous with the join code as token) | `mehfil_server/lib/server.dart` |

Take Serverpod out and the reveal has nothing to fire it, nothing hides the photos, and nothing carries them off the
phones.

## Run it locally

Requirements: Flutter 3.44.4+ (we used 3.47.7), Serverpod CLI 4.1.0-beta.3 (`dart install serverpod_cli@4.1.0-beta.3`).

```bash
cd mehfil/mehfil_server
serverpod start            # API :8080, web app :8082 (embedded Postgres, no Docker)
```

- Guest link: `http://localhost:8082/e/<CODE>` · Live wall: `http://localhost:8082/wall/<CODE>`
- Make a demo event: `cd mehfil/mehfil_tools && dart run mehfil_tools:demo_event`
- Server tests: `cd mehfil/mehfil_server && dart test` (15 tests)

> If your shell has `PGPORT` set for another project, unset it first; see
> [`docs/SERVERPOD-FEEDBACK.md`](docs/SERVERPOD-FEEDBACK.md) note 1.

## What we learned about Serverpod

Things that went wrong, written down when they happened: [`docs/SERVERPOD-FEEDBACK.md`](docs/SERVERPOD-FEEDBACK.md).

## Honesty

- Every event used in the proofs above is labelled **demo** in the app and in the data.
- "Taken at" comes from the phone's clock and is shown as the phone's claim. Received time, counts and the reveal use
  server time only.
- Not built on purpose: face recognition, AI edits, printing, payments, chat, video.

## AI use

This project was built with AI assistance (Claude Code wrote most of the code; the author reviewed it, ran the
gatherings, made the product decisions and did all git work). Disclosed as the hackathon rules require.
