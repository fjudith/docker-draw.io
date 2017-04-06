FROM jetty:9-jre7

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.4.5-1
ENV GOOGLE_API=1.9.9

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-7-jdk wget

# Download Google  Api Engine
RUN ${JETTY_BASE}/lib/ext/ && \
    wget https://repo1.maven.org/maven2/com/google/appengine/appengine-endpoints/${GOOGLE_API}/appengine-endpoints-${GOOGLE_API}.jar
    

# Download
RUN cd ${JETTY_BASE}/webapps/ && \
    wget https://github.com/jgraph/draw.io/releases/download/v${VERSION}/draw.war

WORKDIR ${JETTY_BASE}

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]