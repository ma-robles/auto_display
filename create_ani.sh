#! /bin/bash
echo $1
#NIMAGES=120
NIMAGES=12
I=0
while [ $NIMAGES -gt $I ]; do
    NSTR=$(printf *%03d.* $I)
    echo $NSTR
    montage -geometry 960x540+5+100 $(find  $(cat filelist.txt) -name "$NSTR"  -type f) $1 auto_mos_"$(printf %03d $I)".jpg
    let I=I+1
done
ffmpeg -y -r 1 -i auto_mos_%03d.jpg anima_all.avi
