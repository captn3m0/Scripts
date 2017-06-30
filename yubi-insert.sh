#!/bin/bash
YUBIKEY_SERIAL=`cat /home/nemo/.yubikey-serial.txt`
DEVICE_SERIAL=`ykinfo -s | cut -d ' ' -f 2`
LOGFILE="/home/nemo/logs/auth.log"

export DISPLAY=:0

# We only unlock the device if the key matches
if [[ "$YUBIKEY_SERIAL" -eq "$DEVICE_SERIAL" ]]; then
	echo "`date` unlocked using yubkikey" >> $LOGFILE
	xautolock -unlocknow
fi