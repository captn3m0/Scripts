#!/bin/bash
# video demo at: http://www.youtube.com/watch?v=90xoathBYfk

# written by "mhwombat": https://bbs.archlinux.org/viewtopic.php?id=71938&p=2
# Based on "snippy" by "sessy" 
# (https://bbs.archlinux.org/viewtopic.php?id=71938)
#
# You will also need "dmenu", "xsel" and "xdotool". Get them from your linux
# distro in the usual way.
#
# To use:
# 1. Create the directory ~/.snippy
#
# 2. Create a file in that directory for each snippet that you want.
#    The filename will be used as a menu item, so you might want to
#    omit the file extension when you name the file. 
#
#    TIP: If you have a lot of snippets, you can organise them into 
#    subdirectories under ~/.snippy.
#
#    TIP: The contents of the file will be pasted asis, so if you 
#    don't want a newline at the end when the text is pasted, don't
#    put one in the file.
#
# 3. Bind a convenient key combination to this script.
#
#    TIP: If you're using XMonad, add something like this to xmonad.hs
#      ((mod4Mask, xK_s), spawn "/path/to/snippy")
#
#  Notes: I have disabled GUIPASTE, because that screws up my cursor position
#  and pastes in the wrong place. Instead I just use i3 focus
#
#
DIR=${HOME}/.snippy
APPS="xdotool xsel dmenu"
DMENU_ARGS="-b"
TMPFILE="/tmp/.snippy.tmp"; :>$TMPFILE

CLIPASTE="xdotool key ctrl+v"

# smarty like template engine which executes inline bash in (bashdown) strings (replaces variables with values e.g.)
# @link http://github.com/coderofsalvation/bashdown
# @dependancies: sed cat
# @example: echo 'hi $NAME it is $(date)' | bashdown
# fetches a document and interprets bashsyntax in string (bashdown) templates 
# @param string - string with bash(down) syntax (usually surrounded by ' quotes instead of ")
bashdown(){
  txt="$(cat - )"; lines="$(cat ${DIR}/${FILE} | wc -l )"
  (( lines > 1 )) && enter="\n" || enter=""
  IFS=''; echo "$txt" | while read line; do 
    [[ "$line" =~ '$' ]] && line="$(eval "printf \"$( printf "%s" "$line" | sed 's/"/\\"/g')\"")"; 
    printf -- "$line""$enter"
  done
}

init(){
  for APP in $APPS; do 
    which $APP &>/dev/null || {
      read -p "install the following required utils? : $APPS (y/n)" reply
      [[ "$reply" == "y" ]] && sudo apt-get install ${APPS}; 
    }
  done
  [[ ! -d "$DIR" ]] && { 
    echo -e "created $DIR\n";
    mkdir "$DIR"; 
    printf 'hi it is $(date)' > "$DIR""/test";
  }
  return 0
}

log(){
  echo $1 >> /home/nemo/.log/snippy.log
}

run(){
  cd ${DIR}
  # Use the filenames in the snippy directory as menu entries.
  # Get the menu selection from the user.
  FILE=`find -L .  -type f | grep -v '^\.$' | sed 's!\.\/!!' | /usr/bin/dmenu ${DMENU_ARGS}`
  if [ -f ${DIR}/${FILE} ]; then
    # Put the contents of the selected file into the paste buffer.
    content="$(cat ${DIR}/${FILE} | bashdown)"
    [[ "${#content}" == 0 ]] && printf "${FILE}" > $TMPFILE || printf "%s" "$content" > $TMPFILE
  else
    ${FILE} &> $TMPFILE # execute as bashcommand
  fi

  xclip -selection c < $TMPFILE
  # xsel < $TMPFILE

  focused_window_id="$(xdotool getwindowfocus)"
  i3-msg '[id="$focused_window_id"] focus'
  xdotool key ctrl+v
}

init && run