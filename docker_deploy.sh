docker login -u DOCKER_USER -p DOCKER_PASS

docker build -t jdd04026/test:0.0.1 .

docker tag jdd04026/test:0.0.1 jdd04026/test:latest

docker push jdd04026/test:0.0.1
docker push jdd04026/test:latest