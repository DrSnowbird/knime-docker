#!/bin/bash

################################ Usage #######################################

## ---------- ##
## -- main -- ##
## ---------- ##

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PROJ_DIR=$(dirname $DIR)

cd ${PROJ_DIR}

bin/auto-config-with-template.sh $@ .env.template

