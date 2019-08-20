#!/bin/bash

BATTINFO=`acpi -b`
BATTERY=/sys/class/power_supply/BAT0
REM=`grep "POWER_SUPPLY_CHARGE_NOW" $BATTERY/uevent | awk -F= '{ print $2 }'`
FULL=`grep "POWER_SUPPLY_CHARGE_FULL_DESIGN" $BATTERY/uevent | awk -F= '{ print $2 }'`
PERCENT=`echo $(( $REM * 100 / $FULL ))`
# Put the below 2 in your crontab
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus
XAUTHORITY=/home/nemo/.Xauthority

echo "Battery is at $PERCENT%"

if [[ `echo $BATTINFO | grep Discharging` && "$PERCENT" -lt "15" ]] ; then
	echo "Not Charging, so alerting"
    DISPLAY=:0.0 /usr/bin/notify-send --urgency=critical "Battery Running Low" "$BATTINFO"
fi