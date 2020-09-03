#! /bin/bash
# Usage: Zips given directories into .cbz (Comic Book ZIP) archives of the smame name (eg "folder name.cbz").

remove_flag="m"
recursive_flag="r"
test_flag="T"
compression="9"
open_flag="false"

while getopts "kho" flag
do
	case $flag in
	"k")	#clears remove flag
		echo "Keeping originals."
		remove_flag=""
		;;
	"h")	#print usage
		echo "USAGE: cbz [-k][-h] DIRECTORY ..."
		echo "-h print this help screen"
		echo "-k keep originals"
		exit 0
		;;
	esac
done

echo "Running: zip -$remove_flag$recursive_flag$test_flag$compression out.cbz in -x *.DS_Store *[Tt]humbs.db"

for target in "$@"
do
	if [[ -e $target ]]
	then
		if [[ -d $target ]]
		then
			echo "Archiving \"$target\""
			zip -"$remove_flag$recursive_flag$test_flag$compression" "$target.cbz" "$target" -x "*.DS_Store" "*[Tt]humbs.db"

		else
			echo "\"$target\" is not a directory or not readable. Skipping."
		fi #-d
	else
		echo "\"$target\" does not exist."
	fi
done