FROM tomcat:8-jre8

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.8.0

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-8-jdk ant git patch xmlstarlet

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

# Update server.xml to set Draw.io webapp to root
RUN cd $CATALINA_HOME && \
    xmlstarlet ed \
    -P -S -L \
    -i '/Server/Service/Engine/Host/Valve' -t 'elem' -n 'Context' \
    -i '/Server/Service/Engine/Host/Context' -t 'attr' -n 'path' -v '/' \
    -i '/Server/Service/Engine/Host/Context[@path="/"]' -t 'attr' -n 'docBase' -v 'draw' \
    -s '/Server/Service/Engine/Host/Context[@path="/"]' -t 'elem' -n 'WatchedResource' -v 'WEB-INF/web.xml' \
    -i '/Server/Service/Engine/Host/Valve' -t 'elem' -n 'Context' \
    -i '/Server/Service/Engine/Host/Context[not(@path="/")]' -t 'attr' -n 'path' -v '/ROOT' \
    -s '/Server/Service/Engine/Host/Context[@path="/ROOT"]' -t 'attr' -n 'docBase' -v 'ROOT' \
    -s '/Server/Service/Engine/Host/Context[@path="/ROOT"]' -t 'elem' -n 'WatchedResource' -v 'WEB-INF/web.xml' \
    conf/server.xml

# Cleanup
RUN rm -r /var/lib/apt/lists/* && \
    rm -rf \
    /tmp/v${VERSION}.zip \
    /tmp/draw.io-${VERSION}
    

WORKDIR $CATALINA_HOME

EXPOSE 8080

CMD ["catalina.sh", "run"]