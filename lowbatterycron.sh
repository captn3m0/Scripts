#!/bin/bash

BATTINFO=`acpi -b`
BATTERY=/sys/class/power_supply/BAT0
REM=`grep "POWER_SUPPLY_CHARGE_NOW" $BATTERY/uevent | awk -F= '{ print $2 }'`
FULL=`grep "POWER_SUPPLY_CHARGE_FULL_DESIGN" $BATTERY/uevent | awk -F= '{ print $2 }'`
PERCENT=`echo $(( $REM * 100 / $FULL ))`

if [[ `echo $BATTINFO | grep Discharging` && "$PERCENT" -lt "10" ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "low battery" "$BATTINFO"
fi