#!/bin/bash -x

set -e

################################ Usage #######################################

#### ------------------------------- ####
#### ---- Docker:docker-compose ---- ####
#### ---- App:Specification:    ---- ####
#### ------------------------------- ####

# DOCKER_HOST_IP=10.128.1.123
# DOCKER_HOST_NAME=server01.openkbs.org

function usage() {
    echo "-----------------------------------------------------------------------------------------------"
    echo "Usage:"
    echo "  $(basename $0) [-i <ip_address>: Use IP Address instead of Hostname]"
    echo "                 [-n <hostname>: Use Hostname instead of IP]"
    echo "                 [-l]: Use localhost,127.0.0.1 as Docker Host's Hostname/IP Address ]"
    echo "-----------------------------------------------------------------------------------------------"
}

## ---------- ##
## -- main -- ##
## ---------- ##

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

countShift=0
function processFlags() {
    moreFlag=1
    while [ $moreFlag -gt 0 ] ; do
      case $1 in
        "-l")
          DOCKER_HOST_IP="127.0.0.1"
          DOCKER_HOST_NAME="localhost"
          TEMPLATE_FILE=".env.template"
          countShift=$((countShift+1))
          shift
          ;;
        "-i")
          DOCKER_HOST_IP=$2
          echo "--- Use the given HOstname or IP address to generate .env file"
          countShift=$((countShift+2))
          shift 2
          ;;
        "-n")
          DOCKER_HOST_NAME=$2
          echo "--- Use the given HOstname or IP address to generate .env file"
          countShift=$((countShift+2))
          shift 2
          ;;
        *)
          moreFlag=0
          usage
          ;;
      esac
    done
}


echo "========> Before processFlags: $*"	

if [ $# -gt 0 ]; then
    echo "$@"
    processFlags "$@"
fi

while [ $countShift -gt 0 ]; do	
    countShift=$((countShift-1))	
    shift 1	
done	
echo "Remaining arguments: $*"

TEMPLATE_FILE_PATH=$1

echo "## ---- check the exsitence of template file: ${TEMPLATE_FILE_PATH}"
if [ ! -s "${TEMPLATE_FILE_PATH}" ]; then
    echo "*** ERROR: Template file: ${TEMPLATE_FILE_PATH} not found! Abort"
    exit 1
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
    # Template file name should be .env.template or docker-compose.yml.template:
    # So, the trailing ".template" will be removed to be used to generate the target file.
    target_filename=${f%%.template} # docker-compose.yml
    if [ -s  ]; then
        if [ ! -d ${target_filename}.BACKUP ]; then
            mkdir -p ${target_filename}.BACKUP
        fi
        cp ${CP_OPTION} ${target_filename} ${target_filename}.BACKUP/
        echo "... Old ${target_filename} file is save to: ${target_filename}.BACKUP/"
        #mv ${target_filename} ${target_filename}.BACKUP/${target_filename}_$(date '+%F').SAVE
        # echo "... Old ${target_filename} file is save to: ${target_filename}_$(date '+%F').SAVE"
    fi
    mv ${AUTO_GEN_FILE} ${target_filename}
done

