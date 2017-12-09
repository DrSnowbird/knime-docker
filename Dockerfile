FROM openkbs/jre-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER ----
## ---- USER_NAME is defined in parent image: openkbs/jre-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}

#########################################################
#### ---- Install: MODIFY two lines below ----
#########################################################
ENV PRODUCT=knime
ENV PRODUCT_VERSION=${PRODUCT}_3.5.0

ENV WORKSPACE=${HOME}/${PRODUCT}-workspace

ENV INSTALL_BASE=/opt
#ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime-latest-linux.gtk.x86_64.tar.gz
#ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/knime_3.5.0.linux.gtk.x86_64.tar.gz
ENV DOWNLOAD_URL=https://download.knime.org/analytics-platform/linux/${PRODUCT_VERSION}.linux.gtk.x86_64.tar.gz

WORKDIR ${INSTALL_BASE}

RUN wget -c ${DOWNLOAD_URL} && \
    tar xvf $(basename ${DOWNLOAD_URL}) && \
    rm $(basename ${DOWNLOAD_URL} )
    
USER ${USER_NAME}

VOLUME ${WORKSPACE}
WORKDIR ${WORKSPACE}
CMD "/opt/${PRODUCT_VERSION}/${PRODUCT}"
