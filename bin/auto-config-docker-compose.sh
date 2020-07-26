#!/bin/bash  -x

################################ Usage #######################################

#### ------------------------------- ####
#### ---- Docker:docker-compose ---- ####
#### ---- App:Specification:    ---- ####
#### ------------------------------- ####

# DOCKER_HOST_IP=10.128.1.123
# DOCKER_HOST_NAME=server01.openkbs.org

## ---------- ##
## -- main -- ##
## ---------- ##

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PROJ_DIR=$(dirname $DIR)

CONTAINER_NAME=$(basename $PROJ_DIR)

## -----------------------
## -- Organization Name --
## -----------------------
ORG_NAME=${ORG_NAME:-openkbs}

TEMPLATE_FILE="docker-compose.yml.template"
TEMPLATE_FILE_PATH=${PROJ_DIR}/${TEMPLATE_FILE}

SED_MAC_FIX="''"

CP_OPTION="--backup=numbered"

## ------------------------------------------
## -- To find the HOST IP for Docker       --
## --  Container to pass into Container    --
## -- This will handle both Unix and MacOS --
## ------------------------------------------
HOST_IP=127.0.0.1
function find_host_ip() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # ...
        HOST_IP=`ip route get 1|grep via | awk '{print $7}'`
        SED_MAC_FIX=
        echo ${HOST_IP}
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        HOST_IP=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | grep -Fv 192.168 | awk '{print $2}'`
        CP_OPTION=
        echo ${HOST_IP}
    fi
}
find_host_ip


#### ---- Docker HOST's IP ----
#DOCKER_HOST_IP=`ip route get 1|grep via | awk '{print $7}'`
DOCKER_HOST_IP=${HOST_IP}
DOCKER_HOST_NAME=`hostname -f`

## -- Variables to initialization:  --

## (whether to use Hostname or not (use IP)
USE_NAME=1

echo "Remaining arguments: $*"

if [ ! -s "${TEMPLATE_FILE_PATH}" ]; then
    echo "*** ERROR: Template file: ${TEMPLATE_FILE_PATH} not found! Abort"
else
    echo "--- OK: Template file: ${TEMPLATE_FILE_PATH} found! Continue ..."
fi

## ------------------------------------------
## -- To replace pattern in a file         --
## ------------------------------------------
function replaceValueInConfig() {
    FILE=${1}
    KEY=${2}
    VALUE=${3}
    search=`cat $FILE|grep "$KEY"`
    if [ "$search" = "" ]; then
        echo "-- Not found: Append into the file"
        echo "$KEY=$VALUE" >> $FILE
    else
        sed -i ${SED_MAC_FIX} 's/^[[:blank:]]*\('$KEY'[[:blank:]]*=\).*/\1'$VALUE'/g' $FILE
    fi
    echo "results (after replacement) with new value:"    
    cat $FILE |grep $KEY
}

files="${TEMPLATE_FILE_PATH}"

cd ${PROJ_DIR}

for f in $files; do
    echo "=============== Generating config file from: $f =================="
    AUTO_GEN_FILE=${f%.*}.AUTO
    echo "...... AUTO_GEN_FILE= $AUTO_GEN_FILE"
    cp $f ${AUTO_GEN_FILE}
    sed -i ${SED_MAC_FIX} "s#{{CONTAINER_NAME}}#$CONTAINER_NAME#g" ${AUTO_GEN_FILE}
    sed -i ${SED_MAC_FIX} "s#{{DOCKER_HOST_IP}}#$DOCKER_HOST_IP#g" ${AUTO_GEN_FILE}
    sed -i ${SED_MAC_FIX} "s#{{DOCKER_HOST_NAME}}#$DOCKER_HOST_NAME#g" ${AUTO_GEN_FILE}
    sed -i ${SED_MAC_FIX} "s#{{ORG_NAME}}#$ORG_NAME#g" ${AUTO_GEN_FILE}
    cat ${AUTO_GEN_FILE}
    #diff $f ${AUTO_GEN_FILE}
    echo "---- Auto-generated file: ${AUTO_GEN_FILE}"
    docker_compose=docker-compose.yml
    if [ -s  ]; then
        if [ ! -d ${docker_compose}.BACKUP ]; then
            mkdir -p ${docker_compose}.BACKUP
        fi
        cp ${CP_OPTION} ${docker_compose} ${docker_compose}.BACKUP/
        echo "... Old ${docker_compose} file is save to: ${docker_compose}.BACKUP/"
        #mv ${docker_compose} ${docker_compose}.BACKUP/${docker_compose}_$(date '+%F').SAVE
        # echo "... Old ${docker_compose} file is save to: ${docker_compose}_$(date '+%F').SAVE"
    fi
    mv ${AUTO_GEN_FILE} ${docker_compose}
done

