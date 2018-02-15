#!/bin/bash
cd /home/pi/anima
(( PRE=$1-1 ))
if [ 0 -gt $PRE ]; then
        (( PRE+=3 ))
fi
(( POS=$[$[$1+1] % 3] ))
pkill omxplayer
omxplayer --win 0,480,462,1265 --crop 524,0,986,650 --loop -b $(printf anima_%02d.avi $1) &
omxplayer --win 500,0,1486,785 --loop -b $(printf anima_%02d.avi $POS)
echo "pos $POS, val $1, pre $PRE">info.log
