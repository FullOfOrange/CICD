# --- FROM 명령어가 최상단에 위치하여야 합니다.
FROM node:10.16.3

RUN pwd
COPY node-project/package.json /src/package.json
# --- 미리 npm install 을 실행할 수 있습니다.
RUN cd /src; npm install

COPY node-project /src

WORKDIR /src

# --- 꼭 서버가 켜지면 실행할 명령어를 입력해야 합니다.
# --- 예를 들면 서버를 켜는 명령어 등등
# --- 이런 run 명령어가 있어야 Docker 가 run 이 되면 서버가 실행됩니다.
CMD node index.js

# --- [필수] 3000번 포트만 지원 가능합니다.
EXPOSE 3000
