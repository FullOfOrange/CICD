# --- FROM 명령어가 최상단에 위치하여야 합니다.
FROM node:10.16.3

RUN pwd
COPY node-project/package.json /src/package.json
RUN cd /src; npm install

COPY node-project /src

WORKDIR /src

# --- 꼭 서벅 켜지면 실행할 명령어르 입력해야 합니다.
CMD node index.js
EXPOSE 3000
