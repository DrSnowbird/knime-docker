FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}

#########################################################
#### ---- Install: MODIFY two lines below ----
#########################################################
ENV PRODUCT=knime
#ENV PRODUCT_VERSION=${PRODUCT}-latest
ENV PRODUCT_VERSION=${PRODUCT_VERSION:-${PRODUCT}_3.7.0}
ENV WORKSPACE=${HOME}/workspace

ENV INSTALL_BASE=/opt

ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz
#ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/${PRODUCT_VERSION}-linux.gtk.x86_64.tar.gz

WORKDIR ${INSTALL_BASE}

RUN wget -c ${DOWNLOAD_URL} && \
    tar xvf $(basename ${DOWNLOAD_URL}) && \
    rm $(basename ${DOWNLOAD_URL} )
    
RUN sudo apt-get install -y libwebkitgtk-3.0-0

USER ${USER_NAME}

VOLUME ${WORKSPACE}
WORKDIR ${WORKSPACE}

CMD "${INSTALL_BASE}/${PRODUCT_VERSION}/${PRODUCT}"
#CMD "firefox"
