// Records the demo video's main story on the LIVE app (mehfil.serverpod.space):
// a host creates an event, two guests join from the link, one shoots with no
// signal, closes the tab, comes back, and the live wall and the album show that
// nothing was lost. Real browsers drive the real app; nothing is mocked.
//
// One scene per run, so the laptop never drives more than two browsers at once
// (run each through scripts/safe-run.ps1, which waits for it to cool between):
//
//   node record.mjs host      → creates the event, starts a new take in raw/
//   node record.mjs rohit     → the wall + Rohit joins and shoots with signal
//   node record.mjs isha      → the wall + Isha shoots with no signal, closes the
//                               tab, the signal comes back, the photos go
//   node record.mjs reveal    → the host opens the album; both guests see it
//   node record.mjs album     → only the guests' part of reveal (album already open)
//
// Each guest's camera "sees" a short clip filmed on Rohit's phone (feeds/), fed
// to Chromium as its camera. "No signal" is the browser's own offline switch
// for that one guest window only. Each person keeps their own browser profile
// between scenes, like a phone keeps its browser.
import { chromium } from 'playwright';
import fs from 'node:fs';
import path from 'node:path';

const SITE = 'https://mehfil.serverpod.space';
const HOST = { email: 'judges@example.com', password: 'mehfil-judge-2026' };
const EVENT_NAME = 'Evening chai (demo)';
const PEOPLE = {
  host: { feed: null },
  rohit: { name: 'Rohit', feed: 'snacks.mjpeg', shots: 3 },
  isha: { name: 'Isha', feed: 'window.mjpeg', shots: 4 },
};
const PHONE = { width: 412, height: 892 };
const WALL = { width: 1280, height: 720 };

const scene = process.argv[2];
const RAW = path.resolve('raw');
const current = path.join(RAW, 'current.txt');
if (scene === 'host') {
  fs.mkdirSync(RAW, { recursive: true });
  fs.writeFileSync(current, new Date().toISOString().replace(/[:.]/g, '-'));
}
const take = path.join(RAW, fs.readFileSync(current, 'utf8').trim());
fs.mkdirSync(take, { recursive: true });
const stateFile = path.join(take, 'state.json');
const state = fs.existsSync(stateFile) ? JSON.parse(fs.readFileSync(stateFile, 'utf8')) : {};

const t0 = Date.now();
const timeline = [];
const mark = (who, what, extra = {}) => {
  const t = (Date.now() - t0) / 1000;
  timeline.push({ t, who, what, ...extra });
  console.log(`${t.toFixed(1).padStart(6)}s  ${who.padEnd(6)} ${what}`);
};
const pause = (s) => new Promise((r) => setTimeout(r, s * 1000));
// Every window this scene opened, so a failure can still save what it shows.
const opened = [];

// A person's own browser, kept between scenes (sign-in, the saved join, the
// photos waiting on the "phone").
async function personal(who, size) {
  const feed = PEOPLE[who].feed;
  const args = ['--use-fake-ui-for-media-stream'];
  if (feed) {
    args.push('--use-fake-device-for-media-stream',
      `--use-file-for-fake-video-capture=${path.resolve('feeds', feed)}`);
  }
  const ctx = await chromium.launchPersistentContext(path.join(take, 'profiles', who), {
    args,
    viewport: size,
    permissions: feed ? ['camera'] : [],
    recordVideo: { dir: path.join(take, scene, who), size },
  });
  opened.push(ctx);
  return ctx;
}

async function wallBrowser() {
  const browser = await chromium.launch();
  const ctx = await browser.newContext({
    viewport: WALL,
    recordVideo: { dir: path.join(take, scene, 'wall'), size: WALL },
  });
  opened.push(ctx);
  return { browser, ctx };
}

// Flutter draws on a canvas; switching its accessibility layer on gives the
// script real buttons and text boxes to press (it changes nothing on screen).
async function open(ctx, who, url, reuse) {
  const page = reuse ?? await ctx.newPage();
  mark(who, 'page opened', { url });
  await page.goto(url);
  await page.waitForSelector('flt-semantics-placeholder', { state: 'attached', timeout: 90000 });
  await page.evaluate(() => document.querySelector('flt-semantics-placeholder').click());
  await pause(1);
  return page;
}

async function type(box, text) {
  await box.click();
  await box.pressSequentially(text, { delay: 120 });
}

async function shoot(page, who, n) {
  for (let i = 0; i < n; i++) {
    await page.getByRole('button', { name: 'Take a photo' }).click();
    mark(who, `photo ${i + 1}`);
    await pause(2.2);
  }
}

async function joinAndShoot(who) {
  const person = PEOPLE[who];
  const ctx = await personal(who, PHONE);
  const page = await open(ctx, person.name, `${SITE}/e/${state.code}`, ctx.pages()[0]);
  await pause(3);
  mark(person.name, 'invitation');
  await type(page.getByRole('textbox', { name: 'So the couple knows who took what' }), person.name);
  await pause(0.8);
  await page.getByRole('button', { name: 'Start shooting' }).click();
  await page.getByRole('button', { name: 'Take a photo' }).waitFor({ timeout: 60000 });
  await pause(3);
  mark(person.name, 'camera live');
  return { ctx, page };
}

const scenes = {
  async host() {
    const ctx = await personal('host', PHONE);
    const host = await open(ctx, 'host', SITE + '/', ctx.pages()[0]);
    await pause(2);
    await type(host.getByRole('textbox', { name: 'Email' }), HOST.email);
    await type(host.getByRole('textbox', { name: 'Password' }), HOST.password);
    await host.getByRole('button', { name: 'Sign in' }).click();
    mark('host', 'signed in');
    await host.getByRole('button', { name: 'New event' }).waitFor({ timeout: 60000 });
    await pause(4);
    await host.getByRole('button', { name: 'New event' }).click();
    mark('host', 'new event form');
    await pause(1.5);
    await type(host.getByRole('textbox', { name: 'Riya & Arjun' }), EVENT_NAME);
    await pause(1.2);
    await host.getByRole('button', { name: /This is a demo event/ }).click();
    await pause(1.5);
    await host.getByRole('button', { name: 'Create event' }).click();
    mark('host', 'event created');
    await host.getByText(/GUEST CODE/i).first().waitFor({ timeout: 60000 });
    await pause(1);
    const snap = await host.locator('body').ariaSnapshot();
    state.code = snap.match(/GUEST CODE\s+([A-Z0-9]{6})/i)?.[1];
    if (!state.code) throw new Error('no guest code on the event page:\n' + snap);
    mark('host', 'code shown', { code: state.code });
    await pause(5);
    await ctx.close();
  },

  async rohit() {
    const wall = await wallBrowser();
    await open(wall.ctx, 'wall', `${SITE}/wall/${state.code}`);
    await pause(4);
    mark('wall', 'wall before');
    const { ctx, page } = await joinAndShoot('rohit');
    await shoot(page, 'Rohit', PEOPLE.rohit.shots);
    await page.getByText(/photos? (are|is) sent/).first().waitFor({ timeout: 60000 });
    mark('Rohit', 'sent');
    await pause(5);
    mark('wall', 'wall climbed');
    await ctx.close();
    await wall.ctx.close();
    await wall.browser.close();
  },

  async isha() {
    const wall = await wallBrowser();
    await open(wall.ctx, 'wall', `${SITE}/wall/${state.code}`);
    await pause(4);
    mark('wall', 'wall before');
    const { ctx, page } = await joinAndShoot('isha');

    // No signal: she keeps shooting; the wall does not move.
    await ctx.setOffline(true);
    mark('Isha', 'NO SIGNAL');
    await pause(2);
    await shoot(page, 'Isha', PEOPLE.isha.shots);
    await pause(3);
    mark('Isha', 'waiting on the phone');
    await pause(4);

    // She closes the tab, still with no signal.
    const spare = await ctx.newPage(); // keeps the browser open, like a phone
    await page.close();
    mark('Isha', 'tab closed');
    await pause(6);

    // Signal back; she opens the link again and the photos go by themselves.
    await ctx.setOffline(false);
    mark('Isha', 'SIGNAL BACK');
    const again = await open(ctx, 'Isha', `${SITE}/e/${state.code}`, spare);
    await again.getByRole('button', { name: 'Take a photo' }).waitFor({ timeout: 60000 });
    mark('Isha', 'camera reopened');
    await again.getByText(/photos? (are|is) sent/).first().waitFor({ timeout: 120000 });
    mark('Isha', 'sent');
    await pause(8);
    mark('wall', 'wall climbed');
    await ctx.close();
    await wall.ctx.close();
    await wall.browser.close();
  },

  async reveal() {
    const hostCtx = await personal('host', PHONE);
    const host = await open(hostCtx, 'host', SITE + '/', hostCtx.pages()[0]);
    const card = host.getByRole('button', { name: new RegExp(EVENT_NAME.replace(/[()]/g, '\\$&')) }).first();
    await card.waitFor({ timeout: 60000 });
    await pause(2);
    await card.click();
    await host.getByRole('button', { name: 'Open now' }).first().waitFor({ timeout: 60000 });
    await pause(3);
    mark('host', 'event page');
    await host.getByRole('button', { name: 'Open now' }).first().click();
    await pause(1.5);
    await host.getByRole('button', { name: 'Open now' }).last().click();
    mark('host', 'album opened');
    await pause(5);
    await hostCtx.close();
    await scenes.album();
  },

  // Both guests open the link again after the reveal: the camera says every
  // function is open, and the album has everyone's photos.
  async album() {
    for (const who of ['rohit', 'isha']) {
      const ctx = await personal(who, PHONE);
      const page = await open(ctx, PEOPLE[who].name, `${SITE}/e/${state.code}`, ctx.pages()[0]);
      await page.getByRole('button', { name: 'Close camera' }).waitFor({ timeout: 60000 });
      await pause(3);
      mark(PEOPLE[who].name, 'all open');
      await page.getByRole('button', { name: 'Close camera' }).click();
      await page.getByRole('button', { name: 'Album', exact: true }).waitFor({ timeout: 60000 });
      await pause(2);
      await page.getByRole('button', { name: 'Album', exact: true }).click();
      mark(PEOPLE[who].name, 'album tab');
      // Stay until every thumbnail has loaded (checked in the video).
      await pause(30);
      await ctx.close();
    }
  },
};

if (!scenes[scene]) {
  console.error(`Scene must be one of: ${Object.keys(scenes).join(', ')}`);
  process.exit(64);
}
if (scene !== 'host' && !state.code) {
  console.error('Run the host scene first.');
  process.exit(65);
}
try {
  await scenes[scene]();
  fs.writeFileSync(path.join(take, `${scene}-timeline.json`), JSON.stringify(timeline, null, 2));
  fs.writeFileSync(stateFile, JSON.stringify(state, null, 2));
  console.log(`scene ${scene} saved in ${take}`);
} catch (e) {
  console.error('FAILED:', e.message);
  let i = 0;
  for (const ctx of opened) {
    for (const page of ctx.pages()) {
      await page.screenshot({ path: path.join(take, `${scene}-FAILED-${i++}.png`) }).catch(() => {});
    }
    await ctx.close().catch(() => {});
  }
  fs.writeFileSync(path.join(take, `${scene}-FAILED.json`), JSON.stringify({ error: e.message, timeline }, null, 2));
  process.exit(1);
}
