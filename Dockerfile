# --- FROM 명령어가 최상단에 위치하여야 합니다.
FROM node:10.16.3
# --- ARG dir 은 필수로 포함되어야 하는 변수이며,
# --- COPY 명령어의 로컬 파일은 repos 디렉토리에 클론이 됩니다.
# --- dir은 repo/{repository}/ 의 경로로 세팅이 되기에
# --- 항상 ${dir}을 남겨주세요. 예시는 아래와 같습니다.
ARG dir
#------------------------------------------------------#
# 아래에 필요한 명령들을 작성해주세요.

RUN pwd
COPY node-project/package.json /src/package.json
RUN cd /src; npm install

COPY node-project /src

WORKDIR /src
CMD node index.js
EXPOSE 3000
