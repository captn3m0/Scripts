#!/bin/bash
# Shell script to disable (almost) all beeps on Crunchbang Linux
# @author: Akshay Dandekar
# @version: 0 (there will be no other)
# This script is free - do whatever you want with it etc…
# and I am not responsible for the outcome
# Blacklist pcspkr
if [ $(grep -c 'blacklist\ pcspkr' /etc/modprobe.d/pcspkr.conf) -eq 0 ]
	then
		echo 'blacklist pcspkr' | tee -a /etc/modprobe.d/pcspkr.conf
		rmmod pcspkr
	else
		echo "blacklist pcspkr in pcspkr configuration”
fi
#set PC speaker and PC Beep to mute on amixer
amixer set 'PC speaker' 0% mute
amixer set 'PC Beep' 0% mute
# remove gtk application beeps
if [ $(grep -c 'gtk-error-bell\ \=\ 0' /home/$1/.gtkrc-2.0.mine) -eq 0 ]
	then
		echo "gtk-error-bell = 0" >> /home/$1/.gtkrc-2.0.mine
		chmod 755 /home/$1/.gtkrc-2.0.mine
	else
		echo "gtk-error-bell already set to zero”
fi
# remove console beeps in X
if [ $(grep -c 'xset\ b\ off' /home/$1/.config/openbox/autostart.sh) -eq 0 ]
	then
		echo "\n
		# remove console beeps in X –Added by $1 \nxset b off &” >> /home/$1/.config/openbox/autostart.sh
	else
		echo "console beeps already off in autostart script”
fi
# remove bash beeps
sed -i 's/^#\ set\ bell\-style\ none/set\ bell\-style\ none/g' /etc/inputrc
# remove console beeps from the system console
if [ $(grep -c 'setterm\ -blength\ 0' /etc/profile) -eq 0 ]
	then
		echo "setterm -blength 0" >> /etc/profile
		echo "setterm -bfreq 0" >> /etc/profile
	else
		echo "console beeps already off in /etc/profile”
fi
# remove login sound from gdm
if [ $(grep -c 'SoundOnLogin=False' /etc/gdm/gdm.conf) -eq 0 ]
	then
		sed -i 's/\[greeter\]/\[greeter\]\nSoundOnLogin\=False/' /etc/gdm/gdm.conf
	else
		echo "login sound already off from gdm”
fi
