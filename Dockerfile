FROM raspbian/stretch
MAINTAINER slytherin9090@gmail.com

RUN apt-get update && apt-get install -y --no-install-recommends \
		build-essential \
		libjpeg8-dev \
		imagemagick \
		libv4l-dev \
		cmake \
		git


RUN apt-get clean \
	&& rm -rf /tmp/* /var/tmp/*  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /mjpg-streamer


RUN git clone https://github.com/jacksonliam/mjpg-streamer.git . && \
		cd mjpg-streamer-experimental && \
		make && \
		make install

EXPOSE 80
CMD mjpg_streamer -i "input_uvc.so -n -f 30" -o "output_http.so -l 0.0.0.0 -p 8080 -w /usr/local/share/mjpg-streamer/www"

