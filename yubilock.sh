#!/bin/bash

LOGFILE="/home/nemo/logs/auth.log"

/bin/su nemo -c "DISPLAY=:0 /home/nemo/projects/scripts/i3lock.sh" >> $LOGFILE
echo "`date` locked using Yubikey $?" >> $LOGFILE