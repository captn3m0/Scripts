# curl -s http://www.last.fm/user/captn3m0 > /tmp/lastfm.html

current_song=""
if [[ LASTFM_SONG="$(python get_current_track.py)" ]]; then
	current_song="$HOME/.cmus/lastfm.txt"
	echo $(/usr/bin/python get_current_track.py) > $current_song 2>&1
	# echo $(which python) > $current_song
else
	current_song="$HOME/.cmus/now-playing.txt"
fi
cat $current_song
exit 0