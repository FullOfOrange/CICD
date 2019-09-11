FROM node
COPY ./node-project/package.json /src/package.json
RUN cd /src; npm install
COPY ./node-project /src
EXPOSE 3000
WORKDIR /src

CMD node index.js
