#!/bin/bash -x

# Reference: 
# - https://docs.docker.com/engine/userguide/containers/dockerimages/
# - https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} <image_tag>"
fi
MY_DIR=$(dirname "$(readlink -f "$0")")


###################################################
#### ---- Change this only if want to use your own
###################################################
ORGANIZATION=openkbs

###################################################
#### ---- Generate build-arg arguments ----
###################################################
BUILD_ARGS=""
ARGS_DEFINITION_FILE="./docker.env"
## -- ignore entries start with "#" symbol --
function generateBuildArgs() {
    for r in `cat ${ARGS_DEFINITION_FILE} | grep -v '^#'`; do
        echo "entry=$r"
        key=`echo $r | tr -d ' ' | cut -d'=' -f1`
        value=`echo $r | tr -d ' ' | cut -d'=' -f2`
        BUILD_ARGS="${BUILD_ARGS} --build-arg $key=$value"
    done
}
generateBuildArgs
echo "BUILD_ARGS=${BUILD_ARGS}"

###################################################
#### ---- Container package information ----
###################################################
DOCKER_IMAGE_REPO=`echo $(basename $PWD)|tr '[:upper:]' '[:lower:]'|tr "/: " "_" `
imageTag=${1:-"${ORGANIZATION}/${DOCKER_IMAGE_REPO}"}

docker build --rm -t ${imageTag} \
    ${BUILD_ARGS} \
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

