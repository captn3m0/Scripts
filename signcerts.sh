#!/bin/bash
set -euo pipefail

export CF_DNS_SERVERS='1.1.1.1 9.9.9.9'

# Based on https://gist.github.com/benkulbertis/fff10759c2391b6618dd/
export CF_KEY=`gkeyring -n CF_KEY --output secret`
export CF_EMAIL="capt.n3m0@gmail.com"

dehydrated --cron