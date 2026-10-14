"""Transcribe every generated variant that isn't in transcripts.json yet, with HyperFrames' Parakeet model.

    python transcribe_all.py
"""

import json
import subprocess
import tempfile
from pathlib import Path

HERE = Path(__file__).parent
OUT = HERE / "transcripts.json"
done = json.loads(OUT.read_text(encoding="utf-8")) if OUT.exists() else {}
work = Path(tempfile.mkdtemp(prefix="hf-asr-"))
todo = [p for p in sorted((HERE / "takes").glob("*-v[0-9].wav")) if p.name not in done]
print(f"{len(todo)} to transcribe", flush=True)
for i, path in enumerate(todo, 1):
    (work / "transcript.json").unlink(missing_ok=True)  # never reuse the previous clip's transcript
    subprocess.run(["npx", "--yes", "hyperframes@0.8.115", "transcribe", str(path), "-d", str(work), "-e", "parakeet",
                    "-l", "en", "--json"], capture_output=True, shell=True, check=False)
    if not (work / "transcript.json").exists():
        print(f"{i}/{len(todo)} {path.name}: TRANSCRIBE FAILED", flush=True)
        continue
    words = json.loads((work / "transcript.json").read_text(encoding="utf-8"))
    done[path.name] = " ".join(w["text"] for w in words)
    OUT.write_text(json.dumps(done, indent=1), encoding="utf-8")
    print(f"{i}/{len(todo)} {path.name}: {done[path.name]}", flush=True)
