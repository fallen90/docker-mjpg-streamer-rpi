mjpg-streamer for rpi
=============
> Based raspian stretch and tested on Raspberry PI 1 model B and used for UVC devices like a usb webcam.


Plugins
-------

Input plugins:

* input_file
* input_http
* input_opencv
* input_ptp2
* input_raspicam
* input_uvc

Output plugins:

* output_file
* output_http
* output_rtsp
* output_udp
* output_viewer



Running
-------

    docker run -d -p 0.0.0.0:80 --device=/dev/video0 --name=mjpeg_streamer fallen90/mjpg-streamer-rpi:latest