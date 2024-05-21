FROM node:lts-alpine AS builder

WORKDIR /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	npm install -g npm &&\
	npm install puppeteer lighthouse es-main


FROM node:lts-alpine

WORKDIR /app

COPY ./msyh.ttf /usr/share/fonts/msyh.ttf
COPY --from=builder /app/node_modules .

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	apk update && apk add --no-cache ttf-dejavu fontconfig tzdata chromium && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone &&\
	npm install -g npm
	
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium-browser"

CMD ["node", "run.mjs"]
