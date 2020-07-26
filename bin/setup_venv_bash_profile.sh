#!/bin/bash

PROJECT_HOME=${1:-my-env}

PYTHON_VERSION=3
#PYTHON_VERSION=3.6

###########################################################################
#### ---------------------- DON'T CHANGE BELOW ----------------------- ####
###########################################################################

#### ---- Detect [python3] is installed ---- ####
#### common location: /usr/bin/python3
VENV_SETUP=`cat ~/.bashrc | grep -i VIRTUALENVWRAPPER_PYTHON`
if [ ! "${VENV_SETUP}" = "" ]; then
    echo ".. virtualenvwrapper alreay has been setup!"
    exit 0
fi

#### ---- Detect [python3] is installed ---- ####
#### common location: /usr/bin/python3
PYTHON_EXE=`which python${PYTHON_VERSION}`
if [ "${PYTHON_EXE}" = "" ]; then
    echo "**** ERROR: Can't find ${PYTHON_EXE} ! .. Abort setup!"
    exit 1
fi

#### ---- Detect [virtualenv] is installed ---- ####
#### common location: /usr/local/bin/virtualenv
VIRTUALENV_EXE=`which virtualenv`
if [ "${VIRTUALENV_EXE}" = "" ]; then
    echo "**** ERROR: Can't find virtualenv executable ! .. Abort setup!"
    exit 1
fi

#### ---- Detect [virtualenvwrapper] is installed ---- ####
#### common location: /usr/local/bin/virtualenvwrapper.sh
#### Or, source /home/developer/.local/bin/virtualenvwrapper.sh
#
if [ -d /home/developer/.local/bin ]; then
    export PATH=$PATH:/home/developer/.local/bin
fi
VIRTUALENVWRAPPER_SHELL=`which virtualenvwrapper.sh`
if [ "${VIRTUALENVWRAPPER_SHELL}" = "" ]; then
    echo "**** ERROR: Can't find virtualenvwrapper.sh script! .. Abort setup!"
    if [ -s /home/developer/.local/bin/virtualenvwrapper.sh ]; then
        VIRTUALENVWRAPPER_SHELL=/home/developer/.local/bin/virtualenvwrapper.sh
    else
        exit 1
    fi
fi

#### ---- Setup User's HOME profile to run virutalenvwrapper shell script ---

cat <<EOF>> ~/.bashrc

#########################################################################
#### ---- Customization for multiple virtual python environment ---- ####
####      (most recommended approach and simple to switch venv)      ####
#########################################################################
#### Ref: https://virtualenvwrapper.readthedocs.io/en/latest/install.html
#### Ref: https://virtualenvwrapper.readthedocs.io/en/latest/command_ref.html
#### mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] ENVNAME

#### ---- root directory for venv setups ---- ####
export WORKON_HOME=~/Envs
echo "WORKON_HOME=\${WORKON_HOME}"
if [ ! -d \$WORKON_HOME ]; then
    mkdir -p \$WORKON_HOME
fi

export VIRTUALENVWRAPPER_PYTHON=${PYTHON_EXE}
export VIRTUALENVWRAPPER_VIRTUALENV=${VIRTUALENV_EXE}

source ${VIRTUALENVWRAPPER_SHELL}

# To create & activate your default venv environment, say, "${PROJECT_HOME}"
echo "------"
unset PYTHONPATH
mkvirtualenv ${PROJECT_HOME:-myvenv}
workon ${PROJECT_HOME:-myvenv}

EOF
