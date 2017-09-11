FROM tomcat:8-jre8

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=7.3.6

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-8-jdk ant git patch

# Download
RUN cd /tmp && \
    wget https://github.com/jgraph/draw.io/archive/v${VERSION}.zip && \
    unzip v${VERSION}.zip 

# Patch EmbedServlet2
ADD assets/embed2js.patch /tmp/drawio-${VERSION}/war/plugins/

RUN cd /tmp/drawio-${VERSION} && \
    patch -p1 war/plugins/embed2js.patch && \
    cd /tmp/drawio-${VERSION}/etc/build && \
    ant war && \
    cd /tmp/drawio-${VERSION}/build && \
    cp -rp /tmp/drawio-${VERSION}/build/draw.war $CATALINA_HOME/webapps/ROOT.war

# Cleanup
RUN rm -r /var/lib/apt/lists/* && \
    rm -rf \
    /tmp/v${VERSION}.zip \
    /tmp/drawio-${VERSION}
    

WORKDIR $CATALINA_HOME

EXPOSE 8080

CMD ["catalina.sh", "run"]