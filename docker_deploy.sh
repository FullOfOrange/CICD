echo DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin

docker build -t DOCKER_USER/test:0.0.1 .

docker tag $DOCKER_USER/test:0.0.1 $DOCKER_USER/test:latest

docker push $DOCKER_USER/test:0.0.1
docker push $DOCKER_USER/test:latest