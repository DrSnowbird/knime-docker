# KNIME (latest/4.1) + Java 8 (1.8.0) OpenJDK + Maven 3.6 + Python 3.6 + PIP3 19 + + npm 6 + node 13 + Gradle 6 + X11 (Desktop)

[![](https://images.microbadger.com/badges/image/openkbs/knime-docker.svg)](https://microbadger.com/images/openkbs/knime-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/knime-docker.svg)](https://microbadger.com/images/openkbs/knime-docker "Get your own version badge on microbadger.com")

# Just a suggestion: If you need to run KNIME Studio over Openshift, Kubernetes, or any container cluster platforms  using noVNC from any HTML5 web browsers-capable computers, tablets, mobile phones, or equipments/devices (e.g., maybe your lab special devices), you might want to check out:
* [KNIME over VNC/NoVNC (by openkbs/knime-vnc-docker) ](https://hub.docker.com/r/openkbs/knime-vnc-docker/)

# Components:
* [KNIME Platform](https://www.knime.com/download-knime-analytics-platform-sdk) latest (v 4.1) for Machine Learning & Big Data Analytics
* Ubuntu 18.04 LTS now and we will use Ubuntu 20.04 on or about 2020-04-15 as LTS Docker base image.
* openjdk version "1.8.0_252"
  OpenJDK Runtime Environment (build 1.8.0_252-8u252-b09-1~18.04-b09)
  OpenJDK 64-Bit Server VM (build 25.252-b09, mixed mode)
* Apache Maven 3.6
* Python 3.6 / Python 2.7 + pip 19.3 + Python3 virtual environments (venv, virtualenv, virtualenvwrapper, mkvirtualenv, ..., etc.)
* Node v13 + npm 6 (from NodeSource official Node Distribution)
* Gradle 6
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy, ..., etc.

# Run (recommended for easy-start)
Image is pulled from openksb/knime-docker
```
./run.sh
```
## Where are workspace and data?
- The "./run.sh" will create and map the container's data and workspace directories to the host's directory as below (unless you change ./.env configuration).
- You can copy source data or projects/workflow to these two directory and the KNIME Studio inside the container will have direct access to the files you just copy.

```
$HOME/data-docker/knime-docker
├── data
└── workspace
    └── Example Workflows
        ├── Basic Examples
        ├── Customer Intelligence
        ├── Retail
        ├── Social Media
        ├── TheData
        └── workflowset.meta
```

And, "docker-compose" will use the current git project directory's "./workspace" to map the container's /home/developer/workspace:

```
./.eclipse
./workspace
``` 

**Note: You can copy your KNIME workflow project in and out the workspaces and it is directly mapped into the container's /home/developer/workspace.**

# Build
You can build your own image locally.
```
./build.sh
```

# References
* [KNIME](https://www.knime.com)
* [KNIME Learning Center](https://www.knime.com/resources)
* [KNIME Analytics Platform](https://www.knime.com/download-knime-analytics-platform-sdk)
* [KNIME FAQ](https://www.knime.com/faq#q6)

# See also VNC/noVNC docker-based IDE or Analytics Platform
* [consol/ubuntu-xfce-vnc](https://hub.docker.com/r/consol/ubuntu-xfce-vnc/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/knime-vnc-docker](https://hub.docker.com/r/openkbs/knime-vnc-docker/)

# See Also - docker-based IDE
* [openkbs/atom-docker](https://hub.docker.com/r/openkbs/atom-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-photon-vnc-docker](https://hub.docker.com/r/openkbs/eclipse-photon-vnc-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/intellj-vnc-docker](https://hub.docker.com/r/openkbs/intellij-vnc-docker/)
* [openkbs/knime-vnc-docker (VNC/NoVNC)](https://hub.docker.com/r/openkbs/knime-vnc-docker/)
* [openkbs/knime-docker (X11/Desktop)](https://hub.docker.com/r/openkbs/knime-docker/)
* [openkbs/netbeans10-docker](https://hub.docker.com/r/openkbs/netbeans10-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/rapidminer-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rapidminer-docker)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)
* [openkbs/webstorm-vnc-docker](https://hub.docker.com/r/openkbs/webstorm-vnc-docker/)

# Display X11 Issue
More resource in X11 display of Eclipse on your host machine's OS, please see
* [X11 Display problem](https://askubuntu.com/questions/871092/failed-to-connect-to-mir-failed-to-connect-to-server-socket-no-such-file-or-di)
* [X11 Display with Xhost](http://www.ethicalhackx.com/fix-gtk-warning-cannot-open-display/)

* You might see the warning message in the launching xterm console like below, you can just ignore it. I googles around and some blogs just suggested to ignore since the IDE still functional ok.

# Releases information
```
developer@5292c62873a0:~/workspace$ /usr/scripts/printVersions.sh 
+ echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
+ whereis java
java: /usr/bin/java /usr/share/java /usr/lib/jvm/java-8-openjdk-amd64/bin/java /usr/share/man/man1/java.1.gz
+ echo

+ java -version
openjdk version "1.8.0_252"
OpenJDK Runtime Environment (build 1.8.0_252-8u252-b09-1~18.04-b09)
OpenJDK 64-Bit Server VM (build 25.252-b09, mixed mode)
+ mvn --version
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /usr/apache-maven-3.6.3
Java version: 1.8.0_252, vendor: Private Build, runtime: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "5.3.0-53-generic", arch: "amd64", family: "unix"
+ python -V
Python 2.7.17
+ python3 -V
Python 3.6.9
+ pip --version
pip 20.0.2 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ pip3 --version
pip 20.0.2 from /usr/local/lib/python3.6/dist-packages/pip (python 3.6)
+ gradle --version

Welcome to Gradle 6.0.1!

Here are the highlights of this release:
 - Substantial improvements in dependency management, including
   - Publishing Gradle Module Metadata in addition to pom.xml
   - Advanced control of transitive versions
   - Support for optional features and dependencies
   - Rules to tweak published metadata
 - Support for Java 13
 - Faster incremental Java and Groovy compilation
 - New Zinc compiler for Scala
 - VS2019 support
 - Support for Gradle Enterprise plugin 3.0

For more details see https://docs.gradle.org/6.0.1/release-notes.html


------------------------------------------------------------
Gradle 6.0.1
------------------------------------------------------------

Build time:   2019-11-18 20:25:01 UTC
Revision:     fad121066a68c4701acd362daf4287a7c309a0f5

Kotlin:       1.3.50
Groovy:       2.5.8
Ant:          Apache Ant(TM) version 1.10.7 compiled on September 1 2019
JVM:          1.8.0_252 (Private Build 25.252-b09)
OS:           Linux 5.3.0-53-generic amd64

+ npm -v
6.14.4
+ node -v
v14.0.0
+ cat /etc/lsb-release /etc/os-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.4 LTS"
NAME="Ubuntu"
VERSION="18.04.4 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.4 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```
