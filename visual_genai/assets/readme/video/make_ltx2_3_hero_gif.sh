#!/usr/bin/env bash
# Build README hero GIF from the LTX MP4 (palette pipeline; tweak FPS/scale if file size hurts).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IN="${SCRIPT_DIR}/ltx2-3-hero-fin-opt1.mp4"
OUT="${SCRIPT_DIR}/ltx2-3-hero-fin-opt1.gif"
DURATION_SEC="${DURATION_SEC:-18}"
FPS="${FPS:-12}"
MAX_WIDTH="${MAX_WIDTH:-960}"

ffmpeg -y -i "$IN" -t "$DURATION_SEC" -an \
  -vf "fps=${FPS},scale=${MAX_WIDTH}:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256:stats_mode=diff[p];[s1][p]paletteuse=dither=bayer:bayer_scale=5" \
  "$OUT"

echo "Wrote $OUT"
