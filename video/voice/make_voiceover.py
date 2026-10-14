"""
The Mehfil video's voiceover in Rohit's own voice: cloned from Longtake's reference.wav with Chatterbox, locally on
the GPU (same setup as Longtake, Heirloom and Unpaid). One WAV per sentence, a few variants each, so pick.py can
choose the one whose words are right and whose voice is closest.

    ../../../longtake-video/voice/.venv/Scripts/python.exe make_voiceover.py           # every line
    ../../../longtake-video/voice/.venv/Scripts/python.exe make_voiceover.py n4 s2     # only these lines

Lines are written the way they are said ("Server pod"). Every fact in them has a file in evidence/proofs/:
seven of seven = video-take-event12-*.json; the restart = restart-reveal-*.json; hidden until the reveal =
attacks-*.json.
"""

import argparse
import subprocess
import time
from pathlib import Path

import torch
import torchaudio as ta
from chatterbox.tts import ChatterboxTTS

HERE = Path(__file__).parent
REFERENCE = HERE.parent.parent.parent / "longtake-video" / "voice" / "reference.wav"
OUT = HERE / "takes"
# Hard links to the Chatterbox weights (the Hugging Face cache's own links broke when it moved, 8 Oct).
MODEL = HERE / "model"

LINES = {
    # intro
    "i1": "After a wedding, the best photos are stuck on the guests' phones.",
    "i2": "And the hall is often a basement, with no signal at all.",
    "i3": "This is Mehfil. The wedding's camera, on every guest's phone.",
    # the host
    "h1": "The host makes an event, and gets one QR code for the tables.",
    # guests join
    "g1": "A guest scans it. There's no app to install. Just a name, and the camera opens.",
    "g2": "Rohit takes three photos. They're sent, and the couple's live wall shows three.",
    # no signal
    "n1": "Isha is in the hall, with no signal.",
    "n2": "She keeps shooting. Her four photos wait on her phone, and the wall doesn't move.",
    "n3": "She even closes the tab.",
    "n4": "When the signal comes back, she opens the link again, and the photos send by themselves.",
    "n5": "Seven photos taken, seven on the server. Nothing lost.",
    # the reveal
    "r1": "Until the album opens, nobody can see anyone else's photos. The server enforces that, not the app.",
    "r2": "The host opens the album, and every guest sees every photo.",
    # restart
    "s1": "The album can also open by itself, the next morning. That time lives on the server, in the database.",
    "s2": "Here, we restarted the live server just before the album was due. It still opened, right on time.",
    # Serverpod
    "p1": "And it's all built on Server pod.",
    "p2": "Offline sync keeps each photo's record on the phone. File storage takes the photo. A stream drives the live "
          "wall. And the server decides when the album opens.",
    "p3": "We tested it on two real phones, in airplane mode. And it's live now, on Server pod Cloud.",
    # outro
    "o1": "Mehfil. Every guest's photos, even from the basement hall.",
}
SAME_AS: dict[str, str] = {}


def gpu_temp() -> int:
    out = subprocess.run(["nvidia-smi", "--query-gpu=temperature.gpu", "--format=csv,noheader"],
                         capture_output=True, text=True).stdout.strip()
    return int(out) if out.isdigit() else 0


def cool_down(limit: int = 66) -> None:
    """This laptop overheats under long GPU work: wait before every take until the GPU is cool again."""
    waited = 0
    while gpu_temp() > limit:
        time.sleep(5)
        waited += 5
    if waited:
        print(f"  cooled {waited}s", flush=True)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("only", nargs="*", help="line ids to make (default: all)")
    parser.add_argument("--variants", type=int, default=2)
    parser.add_argument("--first", type=int, default=1)
    parser.add_argument("--exaggeration", type=float, default=0.45)
    parser.add_argument("--cfg", type=float, default=0.4)
    parser.add_argument("--temperature", type=float, default=0.8)
    args = parser.parse_args()

    device = "cuda" if torch.cuda.is_available() else "cpu"
    print(f"device: {device}", flush=True)
    model = ChatterboxTTS.from_local(MODEL, device)
    OUT.mkdir(exist_ok=True)
    for key in args.only or LINES:
        for v in range(args.first, args.first + args.variants):
            path = OUT / f"{key}-v{v}.wav"
            if path.exists():
                continue
            cool_down()
            torch.manual_seed(7000 + 100 * list(LINES).index(key) + v)
            wav = model.generate(LINES[key], audio_prompt_path=str(REFERENCE), exaggeration=args.exaggeration,
                                 cfg_weight=args.cfg, temperature=args.temperature)
            ta.save(str(path), wav, model.sr)
            print(f"{key} v{v}: {wav.shape[-1] / model.sr:.2f}s -> {path.name}", flush=True)


if __name__ == "__main__":
    main()
