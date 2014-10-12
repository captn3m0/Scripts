#!/bin/bash
# We use bash to get variable variables to work
# http://stackoverflow.com/questions/10757380/bash-variable-variables

# This script is called whenever I press the caps-lock.
# The key-binding is managed by xbindkey

# Constants
DELAY=200
SLEEP_DELAY=0.2 # Delay in milliseconds
DOUBLE_TAP_SUFFIX="_double_tap"
EPOCH=`date +%s%3N` # This is in milliseconds
LOCK=/tmp/caps_lock_double_tap.lock
source /home/nemo/projects/scripts/caps_lock.cfg

# Get the progam where caps lock was pressed
program=`ps -p $(xdotool getactivewindow getwindowpid) -o command= -c`
window=`xdotool getactivewindow`

if [ -e $LOCK ]; then
  LASTTIME=`cat $LOCK`;
  if [ $EPOCH -le $(($LASTTIME + $DELAY)) ]; then
    program="$program$DOUBLE_TAP_SUFFIX"
    xdotool key --window "$window" ${!program}
  else
    # This is a single click
    sleep $SLEEP_DELAY
    
  fi;
fi

echo "$EPOCH" > $LOCK;