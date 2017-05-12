FROM tomcat:8-jre7

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.5.8

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-7-jdk ant git patch

# Download
RUN cd /tmp && \
    wget https://github.com/jgraph/draw.io/archive/v${VERSION}.zip && \
    unzip v${VERSION}.zip 

# Patch EmbedServlet2
ADD assets/embed2js.patch /tmp/draw.io-${VERSION}/war/plugins/

RUN cd /tmp/draw.io-${VERSION} && \
    patch -p1 war/plugins/embed2js.patch && \
    cd etc/build && \
    ant war && \
    cd ../../build && \
    cp -rp /tmp/draw.io-${VERSION}/build/draw.war $CATALINA_HOME/webapps/

# Cleanup
RUN rm -r /var/lib/apt/lists/* && \
    rm -rf \
    /tmp/draw.io-${VERSION}.zip \
    /tmp/draw.io-${VERSION}
    

WORKDIR $CATALINA_HOME

EXPOSE 8080

CMD ["catalina.sh", "run"]