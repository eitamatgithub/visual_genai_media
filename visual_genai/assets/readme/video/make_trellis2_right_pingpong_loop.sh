#!/usr/bin/env bash
ffmpeg -y -ss 00:00:53.5 -i "https://microsoft.github.io/TRELLIS.2/assets/trellis2.mp4" -filter_complex "[0:v]crop=iw*0.45:ih:iw*0.55:0,split[f][r];[r]reverse[rev];[f][rev]concat=n=2:v=1:a=0,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -an -loop 0 assets/readme/video/trellis2_right_pingpong_loop.gif
