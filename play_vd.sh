cd /home/pi/anima
pkill omxplayer
omxplayer --win 0,480,486,1265 --crop 500,0,986,650 --loop -b --alpha 198 $(printf anima_%02d.avi $1)
