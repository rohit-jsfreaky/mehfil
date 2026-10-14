// Films the live wall of one event until the stop file appears.
//   node record-wall.mjs <code> <stop-file> <out-dir>
import { chromium } from 'playwright';
import fs from 'node:fs';

const [code, stopFile, outDir] = process.argv.slice(2);
const size = { width: 1280, height: 720 };
const browser = await chromium.launch();
const ctx = await browser.newContext({ viewport: size, recordVideo: { dir: outDir, size } });
const page = await ctx.newPage();
const t0 = Date.now();
await page.goto(`https://mehfil.serverpod.space/wall/${code}`);
fs.writeFileSync(`${outDir}/started.txt`, new Date(t0).toISOString());
while (!fs.existsSync(stopFile)) await new Promise((r) => setTimeout(r, 1000));
await page.waitForTimeout(3000);
await page.screenshot({ path: `${outDir}/last.png` });
await ctx.close();
await browser.close();
