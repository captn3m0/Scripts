# This script is called whenever I press the caps-lock.
# The key-binding is managed by xbindkey
command=`ps -p $(xdotool getactivewindow getwindowpid) -o command= -c`
window=`xdotool getactivewindow`
if [ "$command" = "chrome" ]; then
  xdotool key --window "$window" ctrl+l
elif [ "$command" = "linuxdcpp" ]; then
  xdotool key --window "$window" ctrl+Tab
fi