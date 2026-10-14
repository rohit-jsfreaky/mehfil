// Renders cards/*.html to 1920x1080 PNGs.
import { chromium } from 'playwright';
import fs from 'node:fs';
import path from 'node:path';
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });
for (const f of fs.readdirSync('cards').filter((f) => f.endsWith('.html'))) {
  await page.goto('file://' + path.resolve('cards', f));
  await page.evaluate(() => document.fonts.ready);
  await page.waitForTimeout(300);
  await page.screenshot({ path: path.join('cards', f.replace('.html', '.png')) });
  console.log(f);
}
await browser.close();
