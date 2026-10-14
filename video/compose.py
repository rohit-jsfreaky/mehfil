"""
Builds the Mehfil demo video from the recorded windows (raw/), the title cards (cards/*.png) and the voiceover
(voice/picks.json). One shot per voice line; each shot is as long as its line plus a breath. Where a recording is
sped up to fit, the shot says so ("4x speed"). The WhatsApp button on the host page is blurred (no third-party
marks in the video).

    python compose.py            -> out/mehfil-demo.mp4

Times below are in each scene's own clock (seconds since the scene started, from raw/*/<scene>-timeline.json);
OFFSET turns them into each video file's own time.
"""

import json
import subprocess
from pathlib import Path

HERE = Path(__file__).parent
TAKE = HERE / "raw" / "2026-10-14T06-19-33-388Z"
RESTART = HERE / "raw" / "restart-20261014T120416"
OUT = HERE / "out"
SHOTS = OUT / "shots"
LABELS = OUT / "labels"
FONT = "fonts/HankenGrotesk.ttf"
BG = "0xEEEEF2"
FPS = 30


def webm(folder: Path, name: str = "") -> str:
    files = sorted(folder.glob(f"{name}*.webm"))
    return str(files[0].relative_to(HERE)).replace("\\", "/")


# Video files and the scene time at which each one started.
SRC = {
    "host": (webm(TAKE / "host" / "host"), 0.1),
    "rohit": (webm(TAKE / "rohit" / "rohit"), 8.6),
    "rwall": (webm(TAKE / "rohit" / "wall"), 0.1),
    "isha1": (webm(TAKE / "isha" / "isha", "page@2c59"), 9.1),
    "isha2": (webm(TAKE / "isha" / "isha", "page@e282"), 48.5),
    "iwall": (webm(TAKE / "isha" / "wall"), 0.1),
    "rhost": (webm(TAKE / "reveal" / "host"), 0.1),
    "arohit": (webm(TAKE / "album" / "rohit", "page@cb8b"), 0.1),
    "aisha": (webm(TAKE / "album" / "isha", "page@513e"), 40.9),
    "restart": (webm(RESTART), 0.0),
}

# Where a window sits on the 1920x1080 frame: (x, y, width, height), label at (x, y - 52).
SLOT = {
    "phone_left": (120, 150, 416, 900),
    "wall_right": (600, 230, 1240, 698),
    "phone_center": (752, 150, 416, 900),
    "phone_a": (520, 150, 416, 900),
    "phone_b": (984, 150, 416, 900),
    "wall_full": (240, 150, 1440, 810),
}
# The WhatsApp share button on the host's event page, in the 412x892 window.
WHATSAPP = (114, 300, 92, 92)

# One shot per line: the cards, or windows cut from a scene. Each source is (src, from, to, slot, label).
# "pad" adds seconds to the shot; "blur_from" blurs the WhatsApp button from that scene time on (host windows).
PLAN = [
    {"line": "i1", "card": "i1"},
    {"line": "i2", "card": "i2"},
    {"line": "i3", "card": "i3", "pad": 0.6},
    {"line": "h1", "pad": 0.8, "blur_from": 30.0,
     "src": [("host", 23.0, 34.5, "phone_center", "The host")]},
    {"line": "g1", "src": [("rohit", 16.2, 30.0, "phone_left", "Rohit, a guest · has signal"),
                           ("rwall", 16.2, 30.0, "wall_right", "The couple's live wall")]},
    {"line": "g2", "pad": 0.6, "src": [("rohit", 29.6, 44.5, "phone_left", "Rohit, a guest · has signal"),
                                       ("rwall", 29.6, 44.5, "wall_right", "The couple's live wall")]},
    {"line": "n1", "src": [("isha1", 30.4, 33.6, "phone_left", "Isha, a guest · NO SIGNAL"),
                           ("iwall", 30.4, 33.6, "wall_right", "The couple's live wall")]},
    {"line": "n2", "src": [("isha1", 33.6, 45.4, "phone_left", "Isha, a guest · NO SIGNAL"),
                           ("iwall", 33.6, 45.4, "wall_right", "The couple's live wall")]},
    {"line": "n3", "pad": 0.4, "tab_closed_from": 48.6,
     "src": [("isha1", 45.4, 48.6, "phone_left", "Isha, a guest · NO SIGNAL", "isha2", 52.0),
             ("iwall", 45.4, 52.0, "wall_right", "The couple's live wall")]},
    {"line": "n4", "phone_note": (56.0, 59.8, "Opening the link again…"),
     "src": [("isha2", 56.0, 60.4, "phone_left", "Isha · signal back"),
             ("iwall", 56.0, 60.4, "wall_right", "The couple's live wall")]},
    {"line": "n5", "pad": 2.2, "src": [("iwall", 62.0, 112.0, "wall_full",
                                        "The couple's live wall, once Isha's signal is back")]},
    {"line": "r1", "pad": 0.3, "blur_from": 0,
     "src": [("rhost", 8.4, 13.1, "phone_center", "The host")]},
    {"line": "r2", "pad": 1.6, "src": [("arohit", 6.0, 17.5, "phone_a", "Rohit"),
                                       ("aisha", 47.4, 58.9, "phone_b", "Isha")]},
    {"line": "s1", "src": [("restart", 6.0, 18.0, "wall_full", "Restart test (demo) · album set to open at 12:08 PM")]},
    {"line": "s2", "pad": 1.6, "notes": [(0.0, 0.64, "Live server restarted 12:08:12 PM. Album due 12:08:51 PM."),
                                          (0.64, 1.0, "Opened 12:08:51 PM, by the server, on time.")],
     "src": [("restart", 128.0, 148.0, "wall_full", "Restart test (demo) · the live wall")]},
    {"line": "p1", "card": "p"},
    {"line": "p2", "card": "p"},
    {"line": "p3", "card": "p", "pad": 0.6},
    {"line": "o1", "card": "o", "pad": 1.8},
]
LEAD, GAP = 0.25, 0.35


def run(args: list[str]) -> None:
    subprocess.run(["ffmpeg", "-v", "error", "-y", *args], check=True, cwd=HERE)


def label_file(text: str) -> str:
    LABELS.mkdir(parents=True, exist_ok=True)
    path = LABELS / f"{abs(hash(text))}.txt"
    path.write_text(text, encoding="utf-8")
    return str(path.relative_to(HERE)).replace("\\", "/")


def text(t: str, x, y, size=30, color="0x5B5B66", enable: str = "") -> str:
    en = f":enable='{enable}'" if enable else ""
    return f"drawtext=fontfile={FONT}:textfile={label_file(t)}:x={x}:y={y}:fontsize={size}:fontcolor={color}{en}"


def shot(i: int, step: dict, dur: float) -> Path:
    out = SHOTS / f"{i:02d}-{step['line']}.mp4"
    if "card" in step:
        run(["-loop", "1", "-t", f"{dur:.3f}", "-i", f"cards/{step['card']}.png", "-vf", f"fps={FPS},format=yuv420p",
             "-c:v", "libx264", "-preset", "medium", "-crf", "18", "-threads", "3", str(out.relative_to(HERE))])
        return out

    inputs, chains, layers = ["-f", "lavfi", "-t", f"{dur:.3f}", "-i", f"color=c={BG}:s=1920x1080:r={FPS}"], [], []
    n = 1
    for s in step["src"]:
        key, a, b, slot, name = s[:5]
        speed = (b - a) / dur if len(s) == 5 else (s[6] - a) / dur
        x, y, w, h = SLOT[slot]
        parts = [(key, a, b)] if len(s) == 5 else [(key, a, b), (s[5], b, s[6])]
        tags = []
        for key2, a2, b2 in parts:
            file, offset = SRC[key2]
            inputs += ["-ss", f"{a2 - offset:.3f}", "-t", f"{b2 - a2:.3f}", "-i", file]
            f = f"[{n}:v]setpts=(PTS-STARTPTS)/{speed:.4f},fps={FPS}"
            if "blur_from" in step and key2 in ("host", "rhost"):
                bx, by, bw, bh = WHATSAPP
                start = max(0.0, (step["blur_from"] - a2) / speed)
                f += (f",split[m{n}][c{n}];[c{n}]crop={bw}:{bh}:{bx}:{by},boxblur=14:2[b{n}];"
                      f"[m{n}][b{n}]overlay={bx}:{by}:enable='gte(t,{start:.2f})'")
            f += f",scale={w}:{h}[v{n}]"
            chains.append(f)
            tags.append(f"[v{n}]")
            n += 1
        if len(tags) == 2:  # a tab closed mid-shot: the second file follows the first
            chains.append(f"{tags[0]}{tags[1]}concat=n=2:v=1[v{n}x]")
            tags = [f"[v{n}x]"]
        layers.append((tags[0], x, y, w, h, name, speed))

    base = "[0:v]"
    for k, (tag, x, y, w, h, name, speed) in enumerate(layers):
        nxt = f"[o{k}]"
        chains.append(f"{base}{tag}overlay={x}:{y}:shortest=0:eof_action=repeat{nxt}")
        base = nxt
    draws = []
    for tag, x, y, w, h, name, speed in layers:
        draws.append(text(name, x, y - 46, 30, "0x0E0E12"))
        if speed >= 1.5:
            draws.append(text(f"{round(speed)}× speed", x + w - 120, y + h + 6, 24))
    if "tab_closed_from" in step:
        s = step["src"][0]
        x, y, w, h = SLOT[s[3]]
        at = (step["tab_closed_from"] - s[1]) / ((s[6] - s[1]) / dur)
        draws.append(text("Tab closed", x + w // 2 - 80, y + h // 2 - 20, 36, "0x8A8A96", f"gte(t,{at:.2f})"))
    if "phone_note" in step:
        s = step["src"][0]
        x, y, w, h = SLOT[s[3]]
        speed = (s[2] - s[1]) / dur
        a0, a1, note = step["phone_note"]
        draws.append(text(note, x + 60, y + h // 2 - 20, 30, "0x8A8A96",
                          f"between(t,{(a0 - s[1]) / speed:.2f},{(a1 - s[1]) / speed:.2f})"))
    for f0, f1, note in step.get("notes", []):
        draws.append(text(note, 240, 1000, 34, "0x0E0E12", f"between(t,{f0 * dur:.2f},{f1 * dur:.2f})"))
    chains.append(f"{base}{','.join(draws)},format=yuv420p[out]")
    run([*inputs, "-filter_complex", ";".join(chains), "-map", "[out]", "-t", f"{dur:.3f}", "-r", str(FPS),
         "-c:v", "libx264", "-preset", "medium", "-crf", "18", "-threads", "3", str(out.relative_to(HERE))])
    return out


def main() -> None:
    picks = json.loads((HERE / "voice" / "picks.json").read_text(encoding="utf-8"))["picks"]
    SHOTS.mkdir(parents=True, exist_ok=True)
    t, files, voice = 0.0, [], []
    for i, step in enumerate(PLAN):
        pick = picks[step["line"]]
        dur = LEAD + pick["seconds"] + GAP + step.get("pad", 0.0)
        voice.append((t + LEAD, HERE / "voice" / "takes" / pick["file"]))
        out = shot(i, step, dur)
        files.append(out)
        # Place the next line by the shot's real length, so the voice never drifts from the picture.
        real = float(subprocess.run(["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "csv=p=0",
                                     str(out)], capture_output=True, text=True).stdout.strip())
        print(f"{t:6.2f}s  {step['line']}  {real:.2f}s (planned {dur:.2f}s)", flush=True)
        t += real
    print(f"total {t:.2f}s")

    (OUT / "shots.txt").write_text("".join(f"file 'shots/{f.name}'\n" for f in files), encoding="utf-8")
    run(["-f", "concat", "-safe", "0", "-i", "out/shots.txt", "-c", "copy", "out/picture.mp4"])
    ins, mix = [], []
    for k, (at, wav) in enumerate(voice):
        ins += ["-i", str(wav)]
        ms = int(at * 1000)
        mix.append(f"[{k}:a]aresample=48000,adelay={ms}|{ms}[a{k}]")
    amix = "".join(f"[a{k}]" for k in range(len(voice)))
    run([*ins, "-filter_complex", ";".join(mix) + f";{amix}amix=inputs={len(voice)}:normalize=0,"
         f"loudnorm=I=-16:TP=-1.5:LRA=11,apad[a]", "-map", "[a]", "-t", f"{t:.3f}", "-c:a", "pcm_s16le", "out/voice.wav"])
    run(["-i", "out/picture.mp4", "-i", "out/voice.wav", "-c:v", "copy", "-c:a", "aac", "-b:a", "192k",
         "-t", f"{t:.3f}", "out/mehfil-demo.mp4"])
    print("saved out/mehfil-demo.mp4")


if __name__ == "__main__":
    main()
