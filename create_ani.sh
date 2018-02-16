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
        #convert images to video fps=25
        VNAME=$(printf ../anima_%02d.avi $NVID)
        echo "Generating: " $VNAME
        ffmpeg -y -framerate 1 -pattern_type glob -i '*.jpg' -r 25 -preset ultrafast -crf 0 $VNAME 2>ffmpeg.log
        let NVID=NVID+1
        #delete images
        echo "Deleting images"
        rm -f  *.jpg
        cd ..

done
#close file
<&$fd- 

