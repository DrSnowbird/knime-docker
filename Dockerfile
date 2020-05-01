FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}

#########################################################
#### ---- Build ARG and RUN ENV ----
#########################################################
ARG PRODUCT=${PRODUCT:-knime}
ENV PRODUCT=knime
ENV WORKSPACE=${HOME}/workspace

ARG PRODUCT_VERSION=${PRODUCT_VERSION:-4.1.2}
ENV PRODUCT_VERSION=${PRODUCT_VERSION}

ARG PRODUCT_DIR=${PRODUCT_DIR:-knime_${PRODUCT_VERSION}}
ENV PRODUCT_DIR=${PRODUCT_DIR}

ARG PRODUCT_EXE=${PRODUCT_EXE:-knime}
ENV PRODUCT_EXE=${PRODUCT_EXE}

ARG INSTALL_BASE=${INSTALL_BASE:-/opt}
ENV INSTALL_BASE=${INSTALL_BASE}

## --- Product Version specific ---
# ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime_4.1.1.linux.gtk.x86_64.tar.gz
# ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz
ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/${PRODUCT}_${PRODUCT_VERSION}.linux.gtk.x86_64.tar.gz

WORKDIR ${INSTALL_BASE}

#### ---- Install for application ----
RUN sudo wget -q -c ${DOWNLOAD_URL} && \
    sudo tar xvf $(basename ${DOWNLOAD_URL}) && \
    sudo rm $(basename ${DOWNLOAD_URL} )

#.. libwebkitgtk-3.0-0 causing hub.docker.io build failure. Workaround: disable it.
RUN sudo apt-get update -y && \
    sudo apt-get install -y libwebkitgtk-3.0-common && \
    sudo apt-get install -y libwebkitgtk-3.0-0

VOLUME ${WORKSPACE}

#### ---- Environment for running application ----
USER ${USER_NAME}

ENV WORKSPACE=${HOME}/workspace

USER ${USER_NAME}

WORKDIR ${WORKSPACE}

CMD "${INSTALL_BASE}/${PRODUCT_DIR}/${PRODUCT_EXE}"
#CMD "firefox"

