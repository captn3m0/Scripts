#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

curl -u "$GITHUB_USER:$GITHUB_TOKEN" https://api.github.com/teams/847073/members | jq '.[] | .login' -r > list.txt

rm authorized_keys || true
while read USERID
do
	curl https://github.com/$USERID.keys >> authorized_keys
done < list.txt

rm list.txt