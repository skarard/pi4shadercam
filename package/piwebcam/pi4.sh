#!/bin/bash

WIDTH=${STDIN_WIDTH}
HEIGHT=${STDIN_HEIGHT}

gst-launch-1.0 -q v4l2src device=/dev/video0 \
! video/x-raw,width=${WIDTH},height=${HEIGHT},framerate=${FPS}/1,format=YUY2 \
! queue max-size-bytes=460800 leaky=downstream \
! filesink location=/dev/stdout \
| ./uvc-gadget -a -s YUYV -m ${WIDTH}x${HEIGHT} -x -r ${FPS}
