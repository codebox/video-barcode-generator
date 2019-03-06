# Video Barcode Generator

This shell script extracts still frames from video files, and uses them to generate Video Barcode images like these:

### Star Wars

[![Star Wars Video Barcode](http://codebox.org.uk/assets/images/video-barcodes-script/starwars_small.jpg)](/assets/images/video-barcodes-script/star-wars-video-barcode.jpg "Star Wars Video Barcode")

### The Empire Strikes Back

[![Empire Strikes Back Video Barcode](http://codebox.org.uk/assets/images/video-barcodes-script/empire_small.jpg)](/assets/images/video-barcodes-script/empire-strikes-back-video-barcode.jpg "Empire Strikes Back Video Barcode")

### Return of the Jedi

[![Return of the Jedi Video Barcode](http://codebox.org.uk/assets/images/video-barcodes-script/jedi_small.jpg)](/assets/images/video-barcodes-script/return-of-the-jedi-video-barcode.jpg "Return of the Jedi Video Barcode")</section>

The script should work on Linux and Mac OSX, and has dependencies on [ffmpeg](http://www.ffmpeg.org) and [ImageMagick](http://www.imagemagick.org). It is based on an idea by [Benoit Romito](http://bromito.perso.info.unicaen.fr/wiki/index.php) but uses a different technique to create the images, explained [below](#explained). 


### How it works

The script requires a single command-line argument, which should be the location of the video file for which the barcode is to be generated, for example:</section>

<pre>makebarcode.sh starwars.avi
</pre>

The script extracts still frames from the video at one-second intervals, and saves them as JPEG image files (to change the interval between stills, and therefore the length of the barcode, adjust the STEP variable). Each image is then squashed to be only 1 pixel wide, and 400 pixels high, and these squashed images are stitched together horizontally to form a barcode.
