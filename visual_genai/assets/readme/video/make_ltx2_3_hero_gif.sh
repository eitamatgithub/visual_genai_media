#!/usr/bin/env bash
# Build three README GIFs from ltx2-3-hero-fin-opt1.mp4 (palette pipeline; tweak FPS/scale if file size hurts).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IN="${SCRIPT_DIR}/ltx2-3-hero-fin-opt1.mp4"
FPS="${FPS:-12}"
MAX_WIDTH="${MAX_WIDTH:-960}"

vf="fps=${FPS},scale=min(${MAX_WIDTH}\\,iw):-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=256:stats_mode=diff[p];[s1][p]paletteuse=dither=bayer:bayer_scale=5"

# Top README hero: 7.5s → 10.5s
ffmpeg -y -i "$IN" -ss 7.5 -t 3 -an -vf "$vf" "${SCRIPT_DIR}/ltx2-3-hero-top.gif"
# "What you can do when you finish" section: 13.5s → 17s
ffmpeg -y -i "$IN" -ss 13.5 -t 3.5 -an -vf "$vf" "${SCRIPT_DIR}/ltx2-3-hero-goals.gif"
# Module 4 intro (README: under Module 4 tagline): 0s → 7s
ffmpeg -y -i "$IN" -ss 0 -t 7 -an -vf "$vf" "${SCRIPT_DIR}/ltx2-3-hero-module3.gif"

echo "Wrote ${SCRIPT_DIR}/ltx2-3-hero-top.gif"
echo "Wrote ${SCRIPT_DIR}/ltx2-3-hero-goals.gif"
echo "Wrote ${SCRIPT_DIR}/ltx2-3-hero-module3.gif"
