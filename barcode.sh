#!/bin/bash
 
# Set things up...
INFILE=$1
if [[ -z "$INFILE" || ! -f $INFILE ]]; then
    echo Please supply the location of a video file
    exit 1
fi
OUTFILE=$INFILE.jpg
STEP=1
CURR=1
TMPDIR=./tmp
if [ ! -d $TMPDIR ]; then
    mkdir $TMPDIR
fi
 
# Find the duration of the video, in seconds
LEN_TXT=`ffmpeg -i $INFILE 2>&1|grep Duration|cut -f4 -d' '|cut -f1 -d'.'| sed 's/:0/:/g' | sed 's/:/ \\* 3600 + /'|sed 's/:/ \\* 60 + /'`
let "LEN=$LEN_TXT"
echo "Duration=$LEN seconds"
 
# Ctrl-C to stop
function stopnow(){
    echo Processing halted, re-execute script with the same file to resume
    exit 2
}
trap stopnow 2
 
FILENAME=`basename $INFILE`
 
# Make the thumbnail images, and squash them into vertical bars
while [ $CURR -le $LEN ]
do
    PADDED_NUM=`printf "%05d" $CURR`
    THUMBFILE=$TMPDIR/$FILENAME.$PADDED_NUM.jpg
    BARFILE=$TMPDIR/$FILENAME.bar$PADDED_NUM.jpg
    if [ ! -f $BARFILE ]; then
        echo Processing $CURR of $LEN
        ffmpeg -ss $CURR -i $INFILE -vcodec mjpeg -vframes 1 -y -an -f rawvideo -s 320x240 $THUMBFILE >/dev/null 2>&1
        convert $THUMBFILE -resize 1x400\! $BARFILE >/dev/null 2>&1
    fi   
    let CURR+=STEP
done
 
# Stitch the vertical bars together to make the barcode
convert $TMPDIR/$FILENAME.bar* +append $OUTFILE
 
echo Finished.