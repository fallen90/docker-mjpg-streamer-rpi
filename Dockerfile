FROM arm32v6/alpine:3.7 as build
MAINTAINER slytherin9090@gmail.com

RUN apk add --update alpine-sdk \
		linux-headers \
		jpeg-dev \
		imagemagick \
		v4l-utils-dev \
		cmake \
		git

WORKDIR /mjpg-streamer

RUN git clone https://github.com/jacksonliam/mjpg-streamer.git . && \
		cd mjpg-streamer-experimental && \
		make


FROM arm32v6/alpine:3.7

RUN apk add --no-cache v4l-utils-dev

WORKDIR /mjpg-streamer

COPY --from=build /mjpg-streamer/mjpg-streamer-experimental .

RUN mv _build/plugins/input_uvc/input_uvc.so /usr/lib && \
	mv _build/plugins/output_http/output_http.so /usr/lib && \
	ln -s /mjpg-streamer/mjpg_streamer /usr/bin/mjpg_streamer

EXPOSE 80

CMD mjpg_streamer -i "input_uvc.so -n -f 30" -o "output_http.so -l 0.0.0.0 -p 80 -w /mjpg-streamer/www"

