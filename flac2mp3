#!/bin/bash

parallel-moreutils -i -j$(nproc) ffmpeg -i {} -qscale:a 0 {}.mp3 -- ./*.flac
rename .flac.mp3 .mp3 ./*.mp3