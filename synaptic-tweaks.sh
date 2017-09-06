#!/bin/bash

# This file is downloaded from https://www.jabawok.net/?p=100
 
# A tap event happens when the finger is touched and released in  a  time
#       interval shorter than MaxTapTime, and the touch and release coordinates
#       are less than MaxTapMove units apart.  A "touch" event happens when the
#       Z  value goes above FingerHigh, and an "untouch" event happens when the
#       Z value goes below FingerLow.
 
synclient FingerHigh=39
synclient FingerLow=38
synclient MaxTapTime=110
 
#max doubletaptime is limit for detecting a double click or a triple click drag (eg word selection double click then click and drag within this time - increase if you cant triple click drag fast enough)
synclient MaxDoubleTapTime=220
#Timeout  after  a tap to recognize it as a single tap.
synclient SingleTapTimeout=109
#The  ClickTime parameter controls the delay between the button down and
#       button up X events generated in response to a tap event.   A  too  long
#       value  can  cause undesirable autorepeat in scroll bars and a too small
#       value means that visual feedback  from  the  gui  application  you  are
#       interacting  with  is  harder  to  see.
synclient ClickTime=20
 
# 3 finger middle mouse emulation
synclient TapButton3=2
#not really sure if this helps
synclient EmulateMidButtonTime=100
 
#Hysteresis is movement detected before motion events are generated
# increasing this gets rid of "skip" when moving finger while 
# clicking/double clicking - but increases "dead zone" in fine finger movements
# halved with scalefactor 2 - see below
synclient HorizHysteresis=25
synclient VertHysteresis=25
 
#with the below cursor scalefactor we have to reduce these
synclient MinSpeed=0.8
synclient MaxSpeed=3.0
#how fast the the mouse speed changes between minspeed and maxspeed
synclient AccelFactor=0.025