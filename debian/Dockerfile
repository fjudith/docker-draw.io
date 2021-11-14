# this solves some weird issue with openjdk-11-jdk-headless
# https://github.com/nextcloud/docker/issues/380
FROM openjdk:11-jdk-slim AS build

LABEL FROM=https://github.com/jgraph/docker-drawio/blob/dev/debian/Dockerfile
ARG TAG_VERSION

WORKDIR /tmp/drawio/etc/build/

RUN apt-get update -y \
    && mkdir -p /usr/share/man/man1 \
    && apt-get install -y \
        ant \
        git \
    && cd /tmp \
    && git clone --depth 1 --branch $TAG_VERSION https://github.com/jgraph/drawio.git \
    && ant war


# Final image
FROM tomcat:9-jre11-slim

LABEL maintainer="Florian JUDITH <florian.judith.b@gamil.com"

ARG VCS_REF
ARG VERSION
ARG BUILD_DATE

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Draw.io" \
      org.label-schema.description="diagrams.net, previously draw.io, is an online diagramming web site that delivers the source in this project" \
      org.label-schema.url="https://diagrams.net" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/fjudith/docker-draw.io" \
      org.label-schema.vendor="diagrams.net" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        certbot \
        curl \
        xmlstarlet && \
    apt-get autoremove -y --purge && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

COPY --from=build /tmp/drawio/build/draw.war /tmp

# Extract draw.io war & Update server.xml to set Draw.io webapp to root
RUN mkdir -p $CATALINA_HOME/webapps/draw && \
    unzip /tmp/draw.war -d $CATALINA_HOME/webapps/draw && \
    rm -rf /tmp/draw.war /tmp/drawio && \
    cd $CATALINA_HOME && \
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

# Copy docker-entrypoint
COPY files/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

WORKDIR $CATALINA_HOME

EXPOSE 8080 8443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["catalina.sh", "run"]
