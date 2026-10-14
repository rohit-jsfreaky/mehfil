# Mehfil

**The wedding's disposable camera on every guest's phone. It keeps working with no signal, and the whole album opens
for everyone the next morning.** A Flutter app powered by Serverpod.

> After every Indian wedding, the best photos are stuck on 300 guests' phones. Mehfil collects them, even from the
> basement hall with no signal, and reveals the album to everyone the next morning.

- ▶ **Demo video (under 2 minutes):** — *TODO: YouTube link after upload*
- 🌐 **Live app:** https://mehfil.serverpod.space (on Serverpod Cloud)
- 📱 **Android app for hosts:** — *TODO: APK link (GitHub Release) before submitting*
- 🔑 **Judges' host login:** `judges@example.com` / `mehfil-judge-2026`
- 🧪 **Demo event code:** `DCPBDR`. It is labelled **demo**. Its photos are generated test images, not real people.

*Every number on this page comes from a file in [`evidence/`](evidence/). A "—" means we don't have that number yet.*

---

## Judge it in 90 seconds

You need a phone and a laptop. No app, no sign-up.

1. **Be a guest.** On your phone, open https://mehfil.serverpod.space/e/DCPBDR. Type any name. Tap **Start shooting**
   and allow the camera.
2. **Shoot with no signal.** Turn on airplane mode. Take 2 photos. The app says **"No signal · keep shooting"** and
   keeps them on the phone.
3. **Close the tab.** Turn airplane mode off. Open the same link again. The photos send by themselves.
4. **Watch the wall.** On your laptop, open https://mehfil.serverpod.space/wall/DCPBDR. The count goes up. No photo is
   shown, only counts. Photos stay hidden until the reveal.
5. **Be the host.** Open https://mehfil.serverpod.space (or the Android app) and sign in with `judges@example.com` /
   `mehfil-judge-2026`. Open "Riya & Arjun (demo)". One roll is already revealed, so you can see its album. The other
   stays hidden until its reveal time.
6. **See a reveal.** Still as the host, create your own event with one roll. Open its guest link on your phone, take
   a photo, then tap **Reveal now**. The photo appears in the phone's **Album** tab.
7. **Try to break it.** Open https://mehfil.serverpod.space/try/DCPBDR. It runs real attacks from your browser
   against the live server (a made-up QR code, asking for a hidden photo, reading the live wall's stream) and shows
   each one being refused.

## What we measured

| claim | result | evidence |
|---|---|---|
| Nothing is lost with no signal | Chrome at phone size. 3 photos with the browser offline, 3 with the server stopped. The tab was closed and reopened while still offline. Server afterwards: 6 rows synced, 6 files, 6 delivered, 0 rows without a file | [`offline-browser-test-event34-1791893317624.json`](evidence/proofs/offline-browser-test-event34-1791893317624.json) |
| Sends as soon as signal returns | Server started at 12:07:01 UTC; all 6 photos were in by 12:07:11 UTC | same file |
| Nobody sees photos before the reveal | **10 of 10 attacks refused on Serverpod Cloud.** One of them is a second guest running real offline sync and getting 0 of the first guest's rows. The same 10 also pass on a local server | [`attacks-1791903685418.json`](evidence/proofs/attacks-1791903685418.json) (Cloud), [`attacks-1791894215637.json`](evidence/proofs/attacks-1791894215637.json) (local) |
| The reveal survives a server restart, and fires once | Local server and its database fully stopped, then started again, before the reveal time. The reveal fired once, 1.7 s after its time, with all 4 photos | [`reveal-restart-1791891144148.json`](evidence/proofs/reveal-restart-1791891144148.json) |
| On Cloud, the reveal opens on time with no client timer | Nobody pressed "Reveal now". The server opened the roll 0 s after its reveal time, once, with all 4 photos in the album | [`reveal-clock-1791904411753.json`](evidence/proofs/reveal-clock-1791904411753.json) |
| Photos sent the real way arrive whole | Judges' demo event: 7 demo guests sent 16 photos (row through offline sync, file through upload). 16 rows, 16 files, 16 delivered | [`judges-demo-seed-event8-1791909132472.json`](evidence/proofs/judges-demo-seed-event8-1791909132472.json) |
| The guest page opens fast | First visit, no cache: 9.3 s to the first frame right after a deploy (cold CDN), **1.24 s** once the CDN is warm. The Flutter engine file went from 5.4 MB to 2.1 MB after we gzipped it | [`first-load-1791906760000.json`](evidence/proofs/first-load-1791906760000.json) |
| Server tests | 25 integration tests pass, on the laptop and on GitHub Actions | [`mehfil_server/test/integration/mehfil_flow_test.dart`](mehfil/mehfil_server/test/integration/mehfil_flow_test.dart), [Tests workflow](.github/workflows/tests.yml) |
| On Cloud, the reveal still fires after the live server restarts | Event made, then the live server restarted (`serverpod cloud deploy --redeploy`). A new server process started 39 s before the reveal time; the album opened 0 s after its time, by the server, with all 4 photos. (Cloud rolls the new server in before the old one stops, and the reveal row doesn't record which one ran it.) | [`restart-reveal-1791959947213.json`](evidence/proofs/restart-reveal-1791959947213.json), [`reveal-clock-1791959947213.json`](evidence/proofs/reveal-clock-1791959947213.json) |
| The video's take is real | The demo video was recorded on the live app: two guests, one with no signal who closed the tab and came back. 7 photos taken, 7 rows and 7 files on the server, 0 lost; the longest wait on the "phone" was 74 s | [`video-take-event12-1791960186321.json`](evidence/proofs/video-take-event12-1791960186321.json) |
| Reopens with no internet | A guest who joined once reloads, or opens the link in a new tab, with no internet: the app opens from the phone (no browser error page), with the camera, shot count and waiting photos. A guest who hasn't joined yet sees "Get signal once to join", and the page carries on by itself when signal returns | [`offline-reload-1791917657000.json`](evidence/proofs/offline-reload-1791917657000.json) (5 screenshots) |
| Works on real phones | Rohit and a second person tested the live app on two real phones, including airplane mode and closing the tab; the photos sent when the signal came back. (No large gathering was run, so we publish no gathering numbers.) | tested by hand, 13 to 14 Oct |

We also kept one failed run on purpose:
[`reveal-clock-1791904302862.FAILED-upload-overlap.json`](evidence/proofs/reveal-clock-1791904302862.FAILED-upload-overlap.json).
The test's own uploads were still running when the reveal time came, so the roll opened with 3 of 4 photos. We fixed
the test so it waits for uploads first. The photo that came late joins the album straight away; a server test covers
that ("a late photo joins the album straight away").

## The problem

Indian weddings run over several days and functions (Haldi, Mehndi, Sangeet, the wedding itself). They are often in
banquet halls, basements and farmhouses with weak signal. Afterwards the photos are scattered across guests' phones and
a WhatsApp group: compressed, or never sent at all.

Apps like POV proved that people want a "disposable camera" for events. But a 2026 comparison (once.film, 26 Aug 2026)
says: *"Venue Wi-Fi dead zones break the upload flow entirely, since POV has no offline queuing."*

Mehfil is the offline-first version.

## How it works

**The host** (the couple or their family) signs in on Android or the web. They create an event, add rolls (say
Mehndi, Sangeet) and set each roll's reveal time. They print one QR code for the event.

**A guest** scans the QR. A web page opens. No app to install, no account form. They type their name and start
shooting. Each roll gives them a limited number of shots, like a real disposable camera.

**With no signal**, every photo is saved on the phone first. It waits there, even if the tab is closed. When signal comes back, it sends itself. A photo counts as "delivered" only when the server has both the
file and its row.

**The live wall** on the couple's screen counts photos and guests as they arrive. It never shows the photos.

**At the reveal time**, the server opens the roll. Every guest's phone gets the album on its next sync.

## How Serverpod does the real work

| part | what it does | Serverpod piece | code |
|---|---|---|---|
| Shots | each photo's row (who, which roll, the phone's "taken at" claim) is written on the phone first, in the guest's own private space | **offline sync**, personal space | [`shot.spy.yaml`](mehfil/mehfil_server/lib/src/models/shot.spy.yaml), [`guest_session.dart`](mehfil/mehfil_flutter/lib/guest/guest_session.dart) |
| Upload queue | the photo bytes wait in the phone's own SQLite (in the browser too, through WASM) until the server confirms them | **client-side database** | [`pending_upload.spy.yaml`](mehfil/mehfil_server/lib/src/models/pending_upload.spy.yaml) |
| Files | the server checks the SHA-256, stores the photo in **private** storage and stamps server time. No storage URL ever leaves the server | **file storage** + an upload endpoint | [`shot_endpoint.dart`](mehfil/mehfil_server/lib/src/shots/shot_endpoint.dart) |
| Live wall | counts climb on the couple's screen as photos land | **streaming** endpoint | [`wall/`](mehfil/mehfil_server/lib/src/wall/) |
| Reveal | the album opens at the set time, after a restart too, exactly once. The host can move the time or press "Reveal now" | **future call** `callAtTime`, cancel by identifier (the roll id), plus a reveal clock (see below) | [`reveal/`](mehfil/mehfil_server/lib/src/reveal/) |
| Album | at the reveal, every guest becomes a read-only member of the event's album space. Phones pick it up on the next sync | **offline sync shared spaces + roles** | [`reveal_service.dart`](mehfil/mehfil_server/lib/src/reveal/reveal_service.dart) |
| Who is who | hosts sign in with email; only email hosts can create events. Guests get an anonymous account, and only a real join code can create one | **auth**: email provider + anonymous provider with the join code as its check | [`server.dart`](mehfil/mehfil_server/lib/server.dart), [`access.dart`](mehfil/mehfil_server/lib/src/core/access.dart) |
| A lost sign-in comes back | if a guest's session is lost, a recovery key saved on their phone signs them back in as the same guest. The server keeps only its SHA-256 | **auth** token manager | [`guest_endpoint.dart`](mehfil/mehfil_server/lib/src/events/guest_endpoint.dart) |
| The web app | the server also serves the guest web app, with the big `.wasm` files gzipped | **web server** routes | [`gzip_wasm_route.dart`](mehfil/mehfil_server/lib/src/web/routes/gzip_wasm_route.dart) |

Take Serverpod out and nothing carries the photos off the phones, nothing hides them, and nothing fires the reveal.

### Future calls and the reveal clock

Mehfil runs on Serverpod Cloud's free **Starter** trial. On Starter, future calls are switched off (they are a Growth
plan feature), and every future-call method throws. So at start-up the server checks whether future calls work:

- **Where they work** (local, or the Growth plan), the reveal is a future call. A reveal clock also runs as a safety
  net. It only acts 45 s after a missed reveal time.
- **Where they don't** (Starter, our live app), the reveal clock checks every 5 s and opens any roll whose time has
  passed. It uses the same exactly-once reveal.

The restart proof above used the future call (local). The Cloud proof used the reveal clock.

## Architecture

```
 guest phone (Flutter web)          host (Android app / web)           couple's TV (web)
 ─ camera, name                     ─ email sign-in                    ─ live wall
 ─ SQLite (WASM): Shot rows         ─ events, rolls, reveal times      ─ streamed counts only
   + upload queue                   ─ QR card, "Reveal now", album
 ─ service worker: opens offline
        │  offline sync + upload             │  endpoints                       │  WebSocket stream
        ▼                                    ▼                                  ▼
 ┌──────────────────────────── Serverpod 4.1 server (Serverpod Cloud) ───────────────────────────┐
 │ endpoints: guest · shot · events · album · wall · judge      auth: email + anonymous (join code) │
 │ offline sync: personal spaces (shots) → album shared space (read-only, at the reveal)            │
 │ reveal: future call / reveal clock  ·  private file storage  ·  Postgres  ·  web server (app)    │
 └───────────────────────────────────────────────────────────────────────────────────────────────────┘
```

Versions: Serverpod 4.1.0-beta.3, serverpod_offline_sync 0.0.11, Flutter 3.47.7.

## Run it locally

You need Flutter 3.44.4 or newer (we used 3.47.7) and the Serverpod CLI 4.1.0-beta.3:

```bash
dart install serverpod_cli@4.1.0-beta.3
```

**Server** (embedded Postgres, no Docker needed):

```bash
cd mehfil/mehfil_server
serverpod start --no-watch      # API on :8080, web app on :8082
```

- Guest link: `http://localhost:8082/e/<CODE>` · live wall: `http://localhost:8082/wall/<CODE>`
- Make a demo event: `cd mehfil/mehfil_tools && dart run mehfil_tools:demo_event`

> If your shell sets `PGPORT` (or other `PG*` variables) for another project, unset them first. They break the
> embedded Postgres. See [`docs/SERVERPOD-FEEDBACK.md`](docs/SERVERPOD-FEEDBACK.md), note 1.

**App** (host on Android or web):

```bash
cd mehfil/mehfil_flutter
flutter run                      # talks to http://localhost:8080 (assets/config.json)
```

**Tests:**

```bash
cd mehfil/mehfil_server
dart test                        # 25 integration tests
```

**Proof scripts** (in `mehfil/mehfil_tools`, against a running server):

```bash
dart run mehfil_tools:attacks                       # the 10 ways to peek before the reveal
dart run mehfil_tools:proof_reveal_restart setup    # then restart the server, then:
dart run mehfil_tools:proof_reveal_restart check
dart run mehfil_tools:proof_reveal_clock            # reveal with no client timer
dart run mehfil_tools:delivery_report --event N     # rows, files and delivered, per guest
```

## CI

GitHub Actions, in [`.github/workflows/`](.github/workflows/):

- **Tests**: `serverpod generate`, then `dart test` against an embedded Postgres.
- **Analyze**: `dart analyze --fatal-infos`.
- **Format**: `dart format --set-exit-if-changed`.
- **Android APK**: builds the host's release APK, pointed at the live server.
- **Deploy**: `serverpod cloud deploy` on a push to the `deploy` branch.

## What we learned about Serverpod

Everything that went wrong, written down the day it happened, with what we expected and how we worked around it:
[`docs/SERVERPOD-FEEDBACK.md`](docs/SERVERPOD-FEEDBACK.md). Some examples: an interrupted token refresh signs a user out
for good, a hand-written `.scloudignore` breaks Cloud builds, future calls throw on the Starter plan, and on Windows
`SERVERPOD_PASSWORD_*` variables arrive with their names in capitals.

## Honesty notes

- The demo event and every event used in the proofs are labelled **demo**. Their photos are generated test images,
  except the video's take and the restart proof, whose photos are frames from two short clips filmed on Rohit's phone.
- The demo video was recorded by a script (Playwright) driving the real live app in phone-size browser windows; each
  guest's camera was fed one of those phone clips, and "no signal" was the browser's offline switch for that one
  window. Sped-up parts say so on screen. Rohit separately tested the same live app on real phones.
- "Taken at" comes from the phone's clock, so the app shows it as the phone's claim. Received time, counts and the
  reveal use server time only.
- The live app is on the free Starter plan, so its reveals come from the reveal clock, not a future call. The future
  call path is proved on a local server (restart proof above).
- The shots-per-roll limit is kept by the app. If one guest shoots on two offline phones, they can go over it. The
  server keeps every photo, because "nothing is lost" comes first.
- Not built, on purpose: face recognition, AI edits or captions, printing, payments, chat, video.

## AI use

Built with AI help, as the hackathon rules ask us to say. **Claude Code (Anthropic) wrote most of the code**, the
tests and the docs. Rohit Kashyap made the product decisions, reviewed the work, tested it on real phones, and did all the
git work.
