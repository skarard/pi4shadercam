#!/bin/bash

WIDTH=640
HEIGHT=360
FPS=30

gst-launch-1.0 -q rpicamsrc preview=false \
! video/x-raw,width=${WIDTH},height=${HEIGHT},framerate=${FPS}/1 \
! glupload ! glshader fragment="\"`cat remove-barrel-distortion.frag`\"" ! gldownload \
! videoconvert ! video/x-raw,width=${WIDTH},height=${HEIGHT},framerate=${FPS}/1,format=YUY2 \
! queue max-size-bytes=460800 leaky=downstream \
! filesink location=/dev/stdout \
| ./uvc-gadget -a -s YUYV -m ${WIDTH}x${HEIGHT} -x -r ${FPS}
