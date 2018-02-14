cd /home/pi/anima
pkill omxplayer
omxplayer --loop -b --alpha 198 $(printf anima_%02d.avi $1)
