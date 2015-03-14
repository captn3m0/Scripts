#!/bin/bash -
set -o nounset

pulseaudio_stream='pulse://alsa_output.pci-0000_00_1b.0.analog-stereo'

echo "rtsp://me.captnemo.in:8554/"|xclip
echo "Copied RTSP url to clipboard. Paste on device"
echo "Starting VLC"
sleep 2

nvlc "pulse://" ":sout=#transcode{vcodec=none,acodec=mpga,ab=128,channels=2,samplerate=44100}:rtp{sdp=rtsp://:8554/}"