#!/bin/bash
# Usage: Zips given directories into .cbz (Comic Book ZIP) archives of the smame name (eg "folder name.cbz").

COMIC_ROOT="/home/nemo/Downloads/Books/Comics"

cd $COMIC_ROOT

while read comic_dir; do
	if [[ -f "$comic_dir.cbz" ]]; then
		echo "[Exists] $comic_dir.cbz"
	else
		echo "[DL] $comic_dir"
		cbz.sh -k "$comic_dir" > /dev/null
	fi
done < <(find . -mindepth 2 -maxdepth 2 -type d)