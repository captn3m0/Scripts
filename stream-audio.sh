#!/bin/bash -
set -o nounset

pulseaudio_stream='pulse://alsa_output.pci-0000_00_1b.0.analog-stereo'

echo "Copy the following URL and paste in on device: rtsp://me.captnemo.in:8554/"
read -t 5 -p "Hit ENTER or wait ten seconds"
echo "Starting VLC"

nvlc "pulse://" ":sout=#transcode{vcodec=none,acodec=mpga,ab=128,channels=2,samplerate=44100}:rtp{sdp=rtsp://:8554/}"
