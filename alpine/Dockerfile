FROM tomcat:9-jre8-alpine

LABEL maintainer="Florian JUDITH <florian.judith@gmail.com>"

RUN apk add --no-cache \
    openjdk8 apache-ant git patch xmlstarlet certbot curl && \
    cd /tmp && \
    git clone --depth=1 https://github.com/jgraph/drawio.git && \
    cd /tmp/drawio/etc/build && \
    ant war && \
    cd /tmp/drawio/build && \
    mkdir -p $CATALINA_HOME/webapps/draw && \
    unzip /tmp/drawio/build/draw.war -d $CATALINA_HOME/webapps/draw && \
    apk del --purge openjdk8 apache-ant git patch && \
    rm -rf \
        /tmp/drawio

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

# Copy draw.io config files
COPY PreConfig.js PostConfig.js $CATALINA_HOME/webapps/draw/js/
# Copy docker-entrypoint
COPY docker-entrypoint.sh /

WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
