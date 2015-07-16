#!/usr/bin/env bash

current_song="$HOME/.cmus/now-playing.txt"
stat="stopped"

while [[ -n "$1" ]]; do
	case "$1" in
		title)  title="$2" ;;
		album)  album="$2" ;;
		artist) artist="$2" ;;
		status) stat="$2" ;;
		file)   file="$2" ;;
		url)    url="$2" ;;
		*) ;;
	esac
	shift; shift
done

msg=""
if [[ "$stat" == "stopped" ]]; then
	msg="stopped"
else
	if [[ -n "$title" ]]; then
		msg="$title"
	else
		if [[ -n "$file" ]]; then
			msg=$(basename "$file")
		else
			msg="<noname>"
		fi
	fi

	[[ -n "$artist" ]]        && msg="$artist / $msg"
	[[ "$stat" == "paused" ]] && msg="$msg [paused]"
fi

echo "$msg" > "$current_song"