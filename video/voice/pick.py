"""Score every generated variant and pick one per line.

    ../../longtake-video/voice/.venv/Scripts/python.exe pick.py transcripts.json [line ids...]

- trims leading/trailing silence (the clip is placed on its beat, so silence would shift it);
- speaker similarity to reference.wav (Chatterbox's own voice encoder, as in Longtake's similarity.py);
- word check: the transcript (Parakeet, from transcripts.json) must equal the line. Both sides are normalised to
  spoken words (digits to words, "Airloom"/"Erloom" to heirloom, "o3" to "o three") and compared with spaces and
  punctuation removed, so "data set" = "dataset" and "Forward Diff" = "ForwardDiff";
- a statement that comes out as a question (rising end) is rejected;
- among the variants whose words are right, the most similar voice wins. If none is exact, the closest one at 90%
  or more is taken and flagged NEAR, to check by hand.
Writes takes/<id>-v<n>.trim.wav for every variant and picks.json.
"""

import difflib
import json
import re
import sys
from pathlib import Path

import librosa
import numpy as np
import soundfile as sf
import torch
from chatterbox.models.voice_encoder import VoiceEncoder

from make_voiceover import LINES, REFERENCE, SAME_AS

HERE = Path(__file__).parent
SR_EMBED = 16000

ONES = ("zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen "
        "seventeen eighteen nineteen").split()
TENS = "_ _ twenty thirty forty fifty sixty seventy eighty ninety".split()


def say(n: int) -> str:
    if n < 20:
        return ONES[n]
    if n < 100:
        return TENS[n // 10] + ("" if n % 10 == 0 else " " + ONES[n % 10])
    if 2010 <= n <= 2099:  # a year: twenty twenty-five
        return "twenty " + say(n - 2000)
    if n < 1000:
        return ONES[n // 100] + " hundred" + ("" if n % 100 == 0 else " " + say(n % 100))
    return " ".join(ONES[int(d)] for d in str(n))


def spoken(text: str) -> str:
    text = re.sub(r"₹\s*([\d,]+)", r"\1 rupees", text.lower().replace("-", " "))
    text = re.sub(r"\bsurp\b", "serp", text)  # "Surp, A, P, I" is spelled for the voice model; it says SerpApi
    text = re.sub(r"\bserp\s*a\.?\s*p\.?\s*i\b|\bserp\s*api\b|\bserpapi\b", "serp a p i", text)
    text = re.sub(r"\bun paid\b", "unpaid", text)
    text = re.sub(r"(mephil|ma phil|me fill|mafil|mehfill|meh fil)", "mehfil", text)
    text = re.sub(r"server ?(pod|pot|part)", "server pod", text)
    text = text.replace("podcloud", "pod cloud")
    text = re.sub(r"\bfavorite\b", "favourite", text)
    text = re.sub(r"(\d{1,3}),(\d{3})\b", lambda m: f"{say(int(m.group(1)))} thousand {say(int(m.group(2)))}", text)
    text = re.sub(r"\b(\d+):(\d\d)\b", lambda m: f"{say(int(m.group(1)))} minutes {say(int(m.group(2)))} seconds", text)
    text = re.sub(r"([a-z])(\d)", r"\1 \2", text)  # p4 -> p 4
    text = re.sub(r"(\d+)\.(\d+)",
                  lambda m: f"{say(int(m.group(1)))} point {' '.join(ONES[int(d)] for d in m.group(2))}", text)
    text = re.sub(r"\b(\d+)(?:st|nd|rd|th)?\b", lambda m: say(int(m.group(1))), text)
    text = text.replace(" and ", " ")  # "one hundred and four" = "one hundred four"
    return re.sub(r"[^a-z]", "", text)


def statement(heard: str, line: str) -> bool:
    """A statement must not come out as a question (a rising end)."""
    return not (line.rstrip().endswith(".") and heard.rstrip().endswith("?"))


def embed(encoder: VoiceEncoder, wav: np.ndarray) -> np.ndarray:
    e = encoder.embeds_from_wavs([wav], sample_rate=SR_EMBED)[0]
    return e / np.linalg.norm(e)


def main() -> None:
    transcripts = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8")) if len(sys.argv) > 1 else {}
    only = set(sys.argv[2:])
    encoder = VoiceEncoder()
    encoder.load_state_dict(__import__("safetensors.torch", fromlist=["load_file"]).load_file(
        str(HERE / "model" / "ve.safetensors")))
    encoder.eval()
    with torch.no_grad():
        ref, _ = librosa.load(REFERENCE, sr=SR_EMBED)
        ref_e = embed(encoder, ref)
        rows = []
        for path in sorted((HERE / "takes").glob("*-v[0-9].wav")):
            key, var = path.stem.split("-v")
            line_key = SAME_AS.get(key, key)
            if only and line_key not in only:
                continue
            wav, sr = librosa.load(path, sr=None)
            _, (a, b) = librosa.effects.trim(wav, top_db=35)
            pad = int(0.03 * sr)  # keep 30 ms either side so consonants aren't clipped
            trimmed = wav[max(0, a - pad): min(len(wav), b + pad)]
            out = path.with_name(f"{path.stem}.trim.wav")
            sf.write(out, trimmed, sr)
            sim = float(embed(encoder, librosa.resample(trimmed, orig_sr=sr, target_sr=SR_EMBED)) @ ref_e)
            heard = transcripts.get(path.name, "")
            line = LINES[line_key]
            match = difflib.SequenceMatcher(None, spoken(heard), spoken(line)).ratio()
            ok = spoken(heard) == spoken(line) and statement(heard, line)
            rows.append({"line": line_key, "spelled": key, "variant": int(var), "seconds": round(len(trimmed) / sr, 2),
                         "similarity": round(sim, 3), "words_ok": ok, "match": round(match, 3), "heard": heard,
                         "file": out.name})
    picks, near = {}, []
    for key in [k for k in LINES if k not in SAME_AS and (not only or k in only)]:
        cands = [r for r in rows if r["line"] == key]
        good = [r for r in cands if r["words_ok"]]
        best = max(good, key=lambda r: r["similarity"]) if good else None
        is_near = False
        if best is None:
            close = [r for r in cands if r["match"] >= 0.9 and statement(r["heard"], LINES[key])]
            best = max(close, key=lambda r: (r["match"], r["similarity"])) if close else None
            is_near = best is not None
            if is_near:
                near.append(key)
        picks[key] = best
        for r in sorted(cands, key=lambda r: (r["spelled"], r["variant"])):
            mark = ("NEAR" if is_near else "PICK") if best is r else ("    " if r["words_ok"] else "BAD ")
            print(f"{mark} {r['spelled']:4} v{r['variant']}  {r['seconds']:5.2f}s  sim {r['similarity']:.3f}  "
                  f"match {r['match']:.2f}  heard: {r['heard']!r}")
    out = HERE / ("picks-walk.json" if only else "picks.json")
    out.write_text(json.dumps({"lines": LINES, "picks": picks, "near": near, "all": rows}, indent=1), encoding="utf-8")
    missing = [k for k, v in picks.items() if v is None]
    print(f"\nmissing: {missing or 'none'} | near (check by hand): {near or 'none'} -> {out.name}")


if __name__ == "__main__":
    main()
