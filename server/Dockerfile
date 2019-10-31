# --- FROM 명령어가 최상단에 위치하여야 합니다.
FROM node:12.13.0-alpine

COPY package.json /src/package.json
RUN cd /src; npm install

COPY src /src/server
COPY test /src/test
WORKDIR /src

CMD npm run start
EXPOSE 3000
