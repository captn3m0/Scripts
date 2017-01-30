#!/bin/bash
cd ~/projects/scripts
xset -b #disable scrot beep
#!/bin/bash

# Now that the rest of the images have been generated
# We can just call it using that
PARAM='--textcolor=00000000 --insidecolor=0000001c --ringcolor=0000003e --linecolor=00000000 --keyhlcolor=ffffff80 --ringvercolor=ffffff00 --insidevercolor=ffffff1c --ringwrongcolor=ffffff55 --insidewrongcolor=ffffff1c'
IMAGE_COMPOSITE="composite_office_lockscreen.png"

i3lock -n $PARAM -i $IMAGE_COMPOSITE
exit

# Dependencies: imagemagick, i3lock-color-git, scrot
function generate_composite_image()
{
	#IMAGE=$(mktemp).png
	IMAGE_BASE="/home/nemo/Pictures/office_screen_lock.png"
	IMAGE_TEMP="/tmp/tmp_lockscreen.png"
	cp $IMAGE_BASE $IMAGE_TEMP
	#scrot $IMAGE

	convert $IMAGE_TEMP -level 0%,100%,0.6 -filter Gaussian -resize 20% -define filter:sigma=1.5 -resize 500% - | composite lockscreen_office.png - -compose over $IMAGE_TEMP

	# try to use a forked version of i3lock with prepared parameters
	i3lock $PARAM -i $IMAGE_TEMP > /dev/null 2>&1

	if [ $? -ne 0 ]; then
	    # We have failed, lets get back to stock one
	    i3lock -i $IMAGE
	fi
}