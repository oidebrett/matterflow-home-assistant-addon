ARG BUILD_FROM=homeassistant/amd64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8

WORKDIR /react-template
RUN apk add --update --no-cache nodejs npm dumb-init
COPY /react-template/package.json /react-template/package-lock.json /react-template/
RUN npm install
COPY /react-template/ /react-template/
COPY start.sh /react-template/start.sh
ENTRYPOINT ["/react-template/start.sh"]

LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"
