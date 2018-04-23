FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER ----
## ---- USER_NAME is defined in parent image: openkbs/jre-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}

#########################################################
#### ---- Build ARG and RUN ENV ----
#########################################################
ARG PRODUCT=${PRODUCT:-knime}
ENV PRODUCT=knime

ARG PRODUCT_VERSION=${PRODUCT_VERSION:-3.5.3}
ENV PRODUCT_VERSION=${PRODUCT_VERSION}

ARG PRODUCT_DIR=${PRODUCT_DIR:-knime_3.5.3}
ENV PRODUCT_DIR=${PRODUCT_DIR}

ARG PRODUCT_EXE=${PRODUCT_EXE:-knime}
ENV PRODUCT_EXE=${PRODUCT_EXE}

ARG INSTALL_BASE=${INSTALL_BASE:-/opt}
ENV INSTALL_BASE=${INSTALL_BASE}

## --- Product Version specific ---
#ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime_3.5.3.linux.gtk.x86_64.tar
ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/${PRODUCT}_${PRODUCT_VERSION}.linux.gtk.x86_64.tar.gz
## --- Product Latest ---
#ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz
#ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime-${PRODUCT_VERSION}-linux.gtk.x86_64.tar.gz
WORKDIR ${INSTALL_BASE}

#### ---- Install for application ----
RUN wget -c ${DOWNLOAD_URL} && \
    tar xvf $(basename ${DOWNLOAD_URL}) && \
    rm $(basename ${DOWNLOAD_URL} )

#### ---- Environment for running application ----
USER ${USER_NAME}
ENV WORKSPACE=${HOME}/${PRODUCT}-workspace
VOLUME ${WORKSPACE}
WORKDIR ${WORKSPACE}
CMD "/opt/${PRODUCT_DIR}/${PRODUCT_EXE}"
