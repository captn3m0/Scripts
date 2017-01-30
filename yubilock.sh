#!/bin/bash

LOGFILE="/home/nemo/logs/auth.log"

/usr/bin/systemctl start --no-block i3lock.service
echo "`date` locked using Yubikey $?" >> $LOGFILE