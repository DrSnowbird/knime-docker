# `Please consider to donate what you can to help UNICEF, WHO, and Red Cross if you like what we provide to you for free. Thanks so much!`
* [`World Health Organization (WHO) COVID-19 Solidarity Response Fund`](https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate)
* [`Help UNICEF’s COVID-19 Response`](https://donate.unicef.org/)
* [`Help Red Cross`](https://www.redcross.org/donate)

# KNIME (latest/4.4.0) + Java 8 (1.8.0) OpenJDK + Maven 3.6 + Python 3.6 + PIP3 20 + npm 7 + node 15 + Gradle 6 + X11 (Desktop)

[![](https://images.microbadger.com/badges/image/openkbs/knime-docker.svg)](https://microbadger.com/images/openkbs/knime-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/knime-docker.svg)](https://microbadger.com/images/openkbs/knime-docker "Get your own version badge on microbadger.com")

## Also, Web-Browser-based (VNC/NoVNC) KNIME Docker: 
* [KNIME over VNC/NoVNC (by openkbs/knime-vnc-docker) ](https://hub.docker.com/r/openkbs/knime-vnc-docker/):
    * Providing users to use KNIME on `any (literally)` HTML5 Web browser-capable computers, laptop, tablets, smartphone phones (iPhone etc.), or lab special devices/equipments with Web Browsers).
    * The KNIME-VNC-docker will be running remote in cloud cluster node.
    * You can deploy KNIME Studio over Openshift, Kubernetes, or any container cluster platforms.

## Join, Share, and Support the Community: 
* [KNIME Blogs](https://www.knime.com/blog)
* [Join the Community at KNIME web site](https://www.knime.com/knime-community)

# Components:
* [KNIME Platform](https://www.knime.com/download-knime-analytics-platform-sdk) latest (v 4.3.2) for Machine Learning & Big Data Analytics
* Ubuntu 18.04 LTS now as LTS Docker base image.
* [Java openkbs/jdk-mvn-py3 - see README.md](https://github.com/DrSnowbird/jdk-mvn-py3/blob/master/README.md)
* [Base Container Image: openkbs/jdk-mvn-py3](https://github.com/DrSnowbird/jdk-mvn-py3)
* [Base Container Image: openkbs/jdk-mvn-py3-x11](https://github.com/DrSnowbird/jdk-mvn-py3-x11)
* [Base Components: OpenJDK, Python 3, PIP, Node/NPM, Gradle, Maven, etc.](https://github.com/DrSnowbird/jdk-mvn-py3#components)
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
See [Release information](https://github.com/DrSnowbird/jdk-mvn-py3#releases-information)

