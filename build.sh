#!/bin/bash 

# Reference: 
# - https://docs.docker.com/engine/userguide/containers/dockerimages/
# - https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile

DOCKER_IMAGE_REPO="$(basename `pwd`)"
imageTag=${1:-"openkbs/${DOCKER_IMAGE_REPO}"}

docker build --rm -t ${imageTag} \
	-f Dockerfile .

echo "----> Shell into the Container in interactive mode: "
echo "  docker exec -it --name <some-name> /bin/bash"
echo "e.g."
echo "  docker run --name "my-$(basename $imageTag)" /bin/bash "

echo "----> Run: "
echo "  docker run --name <some-name> -it ${imageTag} /bin/bash"
echo "e.g."
echo "  docker run --name "my-$(basename $imageTag)" ${imageTag} "

echo "----> Run in interactive mode: "
echo "  docker run -it --name <some-name> ${imageTag} /bin/bash"
echo "e.g."
echo "  docker run -it --name "my-$(basename $imageTag)" -it ${imageTag} "

echo "----> Build Docker Images again: "
echo "To build again: (there is a dot at the end of the command!)"
echo "  docker build -t ${imageTag} . "
echo
docker images |grep "$imageTag"


