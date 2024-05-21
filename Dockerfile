FROM node:lts-alpine

WORKDIR /app

COPY ./msyh.ttf /usr/share/fonts/msyh.ttf

ENV LANG en_US.UTF-8

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&\
	apk update && apk add --no-cache tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone &&\
	apk add --update ttf-dejavu fontconfig &&\
	npm install -g npm && \
    apk add --no-cache chromium && \
    npm install puppeteer lighthouse es-main &&\
	rm -rf /var/cache/apk/*

ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium-browser"

CMD ["node", "run.mjs"]