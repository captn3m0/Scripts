#!/bin/bash
xset -b #disable scrot beep
scrot /tmp/screen.png
mogrify -scale 10% -scale 1000% /tmp/screen.png
[[ -f /home/user/images/icons/lock-icon.png ]] && convert /tmp/screen.png /home/user/images/icons/lock-icon-1.png -gravity center -composite -matte /tmp/screen.png
i3lock -e -u -i /tmp/screen.png