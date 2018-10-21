#!/bin/bash
set -euo pipefail

export CF_DNS_SERVERS='1.1.1.1 9.9.9.9'

# Based on https://gist.github.com/benkulbertis/fff10759c2391b6618dd/
export CF_KEY=$(pass show CloudFlare/CF_KEY)
export CF_EMAIL="capt.n3m0@gmail.com"

dehydrated --cron