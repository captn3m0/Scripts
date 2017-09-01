#!/bin/bash

# Sets the correct environment variables
# And then calls the corresponding s3-{method} script

readonly DO_SCRIPT_NAME="$(basename $0)"

METHOD=$(echo $DO_SCRIPT_NAME | cut -c4-)

case $METHOD in
	get )	s3-get $@
		;;
	put )   s3-put @?
		;;
esac