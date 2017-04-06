FROM jetty:9-jre7

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.4.5-1
ENV GOOGLE_API=1.9.9

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-7-jdk wget

# Download Google  Api Engine
RUN cd /tmp/ && \
    wget https://repo1.maven.org/maven2/com/google/appengine/appengine-endpoints/${GOOGLE_API}/appengine-endpoints-${GOOGLE_API}.jar && \
    unzip google-api-client-assembly-${GOOGLE_API}-${GOOGLE_API}.zip

# Download
RUN cd /tmp && \
    wget https://github.com/jgraph/draw.io/releases/download/v${VERSION}/draw.war && \
    cp -rp /tmp/draw.war ${JETTY_BASE}/webapps/

WORKDIR ${JETTY_BASE}

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]