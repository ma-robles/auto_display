#! /bin/bash
echo $1
cd /home/pi/anima
ROOT="http://grupo-ioa.atmosfera.unam.mx/pronosticos/productos/WRF/actuales/"	
NVID=0
fd=11
exec 11<filelist.txt
#get images
while IFS='' read -u $fd line || [[ -n "$line" ]]; do
        IFOLDER="$ROOT$line"
        echo "Getting:\n" $IFOLDER
        #get all jpg n folder, no cpy tree structure
        wget -nd -r -l 2 -P ./img/ -A jpg -e robots=off $IFOLDER
        cd img/
        #convert images to video fps=2
        VNAME=$(printf ../anima_%02d.avi $NVID)
        echo "Generating: " $VNAME
        ffmpeg -y -framerate 1 -pattern_type glob -i '*.jpg' -r 25  $VNAME 2>ffmpeg.log
        let NVID=NVID+1
        #delete images
        echo "Deleting images"
        rm -f  *.jpg
        cd ..

done
#close file
<&$fd- 

#NIMAGES=120
#NIMAGES=12
#I=0
#while [ $NIMAGES -gt $I ]; do
    #NSTR=$(printf *%03d.* $I)
    #echo $NSTR
    #montage -geometry 960x540+5+100 $(find  $(cat filelist.txt) -name "$NSTR"  -type f) $1 auto_mos_"$(printf %03d $I)".jpg
    #let I=I+1
#done
#ffmpeg -y -r 1 -i auto_mos_%03d.jpg anima_all.avi
