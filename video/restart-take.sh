#!/usr/bin/env bash
# The "reveal survives a server restart" take, on the live app.
set -u
cd "$(dirname "$0")"
OUT="raw/restart-$(date +%Y%m%dT%H%M%S)"; mkdir -p "$OUT"
LOG="$OUT/proof.log"; STOP="$OUT/stop"
stamp() { date -u +%Y-%m-%dT%H:%M:%SZ; }

( cd ../mehfil/mehfil_tools && dart run mehfil_tools:proof_reveal_clock \
    --server https://mehfil.api.serverpod.space/ \
    --email judges@example.com --password mehfil-judge-2026 \
    --name "Restart test (demo)" --photos ../../video/photos --delay 240 \
    --restart-note "server restarted with: serverpod cloud deploy --redeploy (times in restart.json)" ) > "$LOG" 2>&1 &
PROOF=$!

for i in $(seq 1 120); do grep -q '^SETUP' "$LOG" && break; sleep 1; done
CODE=$(grep -o 'code=[A-Z0-9]*' "$LOG" | head -1 | cut -d= -f2)
echo "code $CODE at $(stamp)"
node record-wall.mjs "$CODE" "$STOP" "$OUT" &
WALL=$!

sleep 45
R0=$(stamp); echo "restart begins $R0"
powershell.exe -NoProfile -Command "Set-Location D:\my_projects\hackathons\mehfil\mehfil; serverpod cloud deploy --redeploy" > "$OUT/redeploy.log" 2>&1
R1=$(stamp); echo "restart done $R1"
printf '{\n  "restartBegan": "%s",\n  "restartDone": "%s",\n  "command": "serverpod cloud deploy --redeploy"\n}\n' "$R0" "$R1" > "$OUT/restart.json"

wait $PROOF; echo "proof exit $?"
touch "$STOP"; wait $WALL
tail -3 "$LOG"; echo "saved $OUT"
