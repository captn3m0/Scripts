#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

gettoken ()
{
    export "`basename $1`"="$(pass show $1)"
}

# Based on https://gist.github.com/benkulbertis/fff10759c2391b6618dd/
gettoken CloudFlare/CF_KEY
CF_EMAIL="capt.n3m0@gmail.com"

ZONE_IDENTIFIER="624d0d36f927426fdbeef7fb3770ac43"
RECORD_IDENTIFIER="54331eb439163ad2c8a5cefbdc09edef"
RECORD_NAME="me.captnemo.in"

LOG_FILE="/home/nemo/logs/cf-dydns.log"

IP_FILE="/tmp/cfip.txt"
ID_FILE="/home/nemo/.cloudflare.ids"

# LOGGER
log() {
    if [ "$1" ]; then
        echo -e "[$(date)] - $1" >> $LOG_FILE
    fi
}

IP=`ip addr show wlp3s0 | grep -Po 'inet \K[\d.]+'`

log 'initiated check'

if [ -f $IP_FILE ]; then
   OLD_IP=$(cat $IP_FILE)
    if [ $IP == OLD_IP ]; then
        echo "IP has not changed."
        exit 0
    fi
fi

update=$(curl -H "X-Auth-Email:$CF_EMAIL" -H "X-Auth-Key: $CF_KEY" -H "Content-Type: application/json" -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_IDENTIFIER/dns_records/$RECORD_IDENTIFIER" --data "{\"id\":\"$ZONE_IDENTIFIER\",\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$IP\"}")

if [[ $update == *"\"success\":false"* ]]; then
    message="API UPDATE FAILED. DUMPING RESULTS:\n$update"
    log "$message"
    echo -e "$message"
    exit 1
else
    message="IP changed to: $IP"
    echo "$IP" > $IP_FILE
    log "$message"
    echo "$message"
fi
