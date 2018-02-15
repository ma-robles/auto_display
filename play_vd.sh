cd /home/pi/anima
pkill omxplayer
omxplayer --win 866,0,1366,780 --crop 0,0,500,768 --aspect-mode fill -loop -b --alpha 198 $(printf anima_%02d.avi $1)
