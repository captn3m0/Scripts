#! /bin/sh

# minimize/restore windows on current desktop
# -----------------------------------
# vermaden [AT] interia [DOT] pl
# http://toya.net.pl/~vermaden/links.htm

CURRENT_DESKTOP=$( wmctrl -d | egrep "^[0-9][ ]{2}\*" | awk '{print $1}' )
WINDOW_LIST=$( wmctrl -l | egrep "^[0-9]x.{8}\ {2}${CURRENT_DESKTOP}" | awk '{print $1}' )

WINDOW_COUNT=0
for WINDOW in ${WINDOW_LIST} ;do
   WINDOW_COUNT=$(( ${WINDOW_COUNT} + 1 ))
done

minimize () {
  for WINDOW in ${WINDOW_LIST}; do
    wmctrl -t ${CURRENT_DESKTOP} -i -r ${WINDOW} -b add,hidden
  done
  }

restore () {
  for WINDOW in ${WINDOW_LIST}; do
    wmctrl -t ${CURRENT_DESKTOP} -i -r ${WINDOW} -b remove,hidden
  done
  }

MINIMIZED=0
for WINDOW in ${WINDOW_LIST}; do
  if xprop -id ${WINDOW} _NET_WM_STATE | grep -q NET_WM_STATE_HIDDEN; then
    MINIMIZED=$(( ${MINIMIZED} + 1 ))
  fi
done

if [ ${MINIMIZED} -eq ${WINDOW_COUNT} ]; then
  restore
else
  minimize
fi

