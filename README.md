# KNIME Analytics Platform in Docker
[![](https://images.microbadger.com/badges/image/openkbs/knime-docker.svg)](https://microbadger.com/images/openkbs/knime-docker "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/knime-docker.svg)](https://microbadger.com/images/openkbs/knime-docker "Get your own version badge on microbadger.com")
* KNIME (latest/3.7.0 + Java 8 (1.8.0_191) JDK + Maven 3.5 + Python 3.5 + X11

# Components:

* [KNIME Platform](https://www.knime.com/download-knime-analytics-platform-sdk) latest (v 3.7.0) for Machine Learning & Big Data Analytics
* java version "1.8.0_191"
  Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
  Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
* Apache Maven 3.5.3
* Python 3.5.2
* Gradle 4.9
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

# Run (recommended for easy-start)
Image is pulling from openkbs/netbeans
```
./run.sh
```
# Build
You can build your own image locally.
```
./build.sh
```

# (Optional Use) Run Python code
To run Python code 

```bash
docker run --rm openkbs/knime-docker python -c 'print("Hello World")'
```

or,

```bash
mkdir ./data
echo "print('Hello World')" > ./data/myPyScript.py
docker run -it --rm --name some-knime-docker -v "$PWD"/data:/data openkbs/knime-docker python myPyScript.py
```

or,

```bash
alias dpy='docker run --rm openkbs/knime-docker python'
dpy -c 'print("Hello World")'
```
# (Optional Use) Compile or Run java while no local installation needed
Remember, the default working directory, /data, inside the docker container -- treat is as "/".
So, if you create subdirectory, "./data/workspace", in the host machine and
the docker container will have it as "/data/workspace".

```java
#!/bin/bash -x
mkdir ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
alias djavac='docker run -it --rm --name some-jre-mvn-py3 -v '$PWD'/data:/data openkbs/jre-mvn-py3 javac'
alias djava='docker run -it --rm --name some-jre-mvn-py3 -v '$PWD'/data:/data openkbs/jre-mvn-py3 java'

djavac HelloWorld.java
djava HelloWorld
```
And, the output:
```
Hello, World
```
Hence, the alias above, "djavac" and "djava" is your docker-based "javac" and "java" commands and
it will work the same way as your local installed Java's "javac" and "java" commands.

# Reference
* [KNIME](https://www.knime.com)
* [KNIME Analytics Platform](https://www.knime.com/download-knime-analytics-platform-sdk)
* [KNIME FAQ](https://www.knime.com/faq#q6)

# See also docker-based IDE
* [openkbs/rapidminer-docker](https://cloud.docker.com/u/openkbs/repository/docker/openkbs/rapidminer-docker)
* [DrSnowbird/distributedWekaSpark](https://github.com/DrSnowbird/distributedWekaSpark)
* [openkbs/docker-atom-editor](https://hub.docker.com/r/openkbs/docker-atom-editor/)
* [openkbs/eclipse-photon-docker](https://hub.docker.com/r/openkbs/eclipse-photon-docker/)
* [openkbs/eclipse-oxygen-docker](https://hub.docker.com/r/openkbs/eclipse-oxygen-docker/)
* [openkbs/intellj-docker](https://hub.docker.com/r/openkbs/intellij-docker/)
* [openkbs/netbeans9-docker](https://hub.docker.com/r/openkbs/netbeans9-docker/)
* [openkbs/netbeans](https://hub.docker.com/r/openkbs/netbeans/)
* [openkbs/papyrus-sysml-docker](https://hub.docker.com/r/openkbs/papyrus-sysml-docker/)
* [openkbs/pycharm-docker](https://hub.docker.com/r/openkbs/pycharm-docker/)
* [openkbs/scala-ide-docker](https://hub.docker.com/r/openkbs/scala-ide-docker/)
* [openkbs/sublime-docker](https://hub.docker.com/r/openkbs/sublime-docker/)
* [openkbs/webstorm-docker](https://hub.docker.com/r/openkbs/webstorm-docker/)

# Display X11 Issue
More resource in X11 display of Eclipse on your host machine's OS, please see
* [X11 Display problem](https://askubuntu.com/questions/871092/failed-to-connect-to-mir-failed-to-connect-to-server-socket-no-such-file-or-di)
* [X11 Display with Xhost](http://www.ethicalhackx.com/fix-gtk-warning-cannot-open-display/)

* You might see the warning message in the launching xterm console like below, you can just ignore it. I googles around and some blogs just suggested to ignore since the IDE still functional ok.

# Versions
```
JAVA_HOME=/usr/jdk1.8.0_191
java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
Apache Maven 3.5.4 (1edded0938998edf8bf061f1ceb3cfdeccf443fe; 2018-06-17T18:33:14Z)
Maven home: /usr/apache-maven-3.5.4
Java version: 1.8.0_191, vendor: Oracle Corporation, runtime: /usr/jdk1.8.0_191/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "4.15.0-42-generic", arch: "amd64", family: "unix"
Python 2.7.12
Python 3.5.2
pip 18.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)
pip 18.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)

Welcome to Gradle 4.9!

Here are the highlights of this release:
 - Experimental APIs for creating and configuring tasks lazily
 - Pass arguments to JavaExec via CLI
 - Auxiliary publication dependency support for multi-project builds
 - Improved dependency insight report

For more details see https://docs.gradle.org/4.9/release-notes.html


------------------------------------------------------------
Gradle 4.9
------------------------------------------------------------

Build time:   2018-07-16 08:14:03 UTC
Revision:     efcf8c1cf533b03c70f394f270f46a174c738efc

Kotlin DSL:   0.18.4
Kotlin:       1.2.41
Groovy:       2.4.12
Ant:          Apache Ant(TM) version 1.9.11 compiled on March 23 2018
JVM:          1.8.0_191 (Oracle Corporation 25.191-b12)
OS:           Linux 4.15.0-42-generic amd64

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.3 LTS"
NAME="Ubuntu"
VERSION="16.04.3 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.3 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```

