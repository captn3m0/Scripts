#!/bin/bash
YUBIKEY_SERIAL=`cat /home/nemo/.yubikey-serial.txt`
DEVICE_SERIAL=`ykinfo -s | cut -d ' ' -f 2`
LOGFILE="/home/nemo/logs/auth.log"

# We only unlock the device if the key matches
if [[ "$YUBIKEY_SERIAL" -eq "$DEVICE_SERIAL" ]]; then
	echo "`date` unlocked using yubkikey" >> $LOGFILE
	killall i3lock
fi