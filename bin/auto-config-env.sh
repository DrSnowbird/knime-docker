#!/bin/bash  -x

################################ Usage #######################################

#### ---------------------------- ####
#### ---- Docker:Config:.env ---- ####
#### ---- App:Specification: ---- ####
#### ---------------------------- ####

# DOCKER_HOST_IP=10.128.1.123
# DOCKER_HOST_NAME=server01.openkbs.org

## ---------- ##
## -- main -- ##
## ---------- ##

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PROJ_DIR=$(dirname $DIR)

ENV_FILE=".env"
TEMPLATE_FILE=".env.template"
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

## -- Profile Models: --
## 1: LOCAL
## 2: REMOTE
## 3: TEST_SERVER
PROFILE_MODEL=1


countShift=0
function processFlags() {
    moreFlag=1
    while [ $moreFlag -gt 0 ]; do
      case $1 in
        "-l")
          PROFILE_MODEL=1
          TEMPLATE_FILE=".env.template"
          countShift=$((countShift+1))
          shift 1
          ;;
        "-i")
          USE_NAME=0
          echo "--- Use IP address as part of YAML/JSON filename..."
          countShift=$((countShift+1))
          shift 1
          ;;
        "-n")
          USE_NAME=1
          echo "--- Default: --> Use DNS part of YAML/JSON filename..."
          countShift=$((countShift+1))
          shift 1
          ;;
        *)
          moreFlag=0
          echo "... not more flags to process ..."
          ;;
      esac
    done
}

echo "========> Before processFlags: $*"
processFlags $*
while [ $countShift -gt 0 ]; do
    countShift=$((countShift-1))
    shift 1
done
echo "Remaining arguments: $*"

if [ ! -s "${TEMPLATE_FILE_PATH}" ]; then
    echo "*** ERROR: Template file: ${TEMPLATE_FILE_PATH} not found! Abort"
else
    echo "--- OK: Template file: ${TEMPLATE_FILE_PATH} found! Continue ..."
fi

function usage() {
    if [ $# -lt 1 ]; then
        echo "--- Usage: $(basename $0): [-l: local Platforms, -r: remote (default)] [env template file]]"
        echo "No configuration template provided: -- try using default ${TEMPLATE_FILE} instead!"
        if [ $LOCAL_PLATFORM -eq 0 ]; then
            TEMPLATE_FILE_PATH="${PROJ_DIR}/.env.template.remote"
            echo "... Use remote template: ${TEMPLATE_FILE_PATH}"
        fi
        if [ -s ${TEMPLATE_FILE_PATH} ]; then 
            CONFIG_FILES=${TEMPLATE_FILE_PATH}
            echo "... Found default ${TEMPLATE_FILE_PATH} and it will be used!"
        else
            echo "**** ERROR: -- No existing ${TEMPLATE_FILE_PATH} found! Abort!"
            exit 1
        fi
    fi
}
usage $*

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
    sed -i ${SED_MAC_FIX} "s#{{DOCKER_HOST_IP}}#$DOCKER_HOST_IP#g" ${AUTO_GEN_FILE}
    sed -i ${SED_MAC_FIX} "s#{{DOCKER_HOST_NAME}}#$DOCKER_HOST_NAME#g" ${AUTO_GEN_FILE}
    cat ${AUTO_GEN_FILE}
    echo "-------------- Comparing template and auto-generated files: ----------"
    #diff $f ${AUTO_GEN_FILE}
    echo "---- Auto-generated file: ${AUTO_GEN_FILE}"
    if [ -s .env ]; then
        if [ ! -d .env.BACKUP ]; then
            mkdir -p .env.BACKUP
        fi
        cp ${CP_OPTION} .env .env.BACKUP/
        echo "... Old .env file is save to: .env.BACKUP/"
        #mv .env .env.BACKUP/.env_$(date '+%F').SAVE
        # echo "... Old .env file is save to: .env_$(date '+%F').SAVE"
    fi
    mv ${AUTO_GEN_FILE} .env
done

