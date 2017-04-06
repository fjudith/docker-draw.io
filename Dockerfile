FROM jetty:9-jre8

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.4.5-1

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-8-jdk

# Download
RUN cd /tmp && \
    wget https://github.com/jgraph/draw.io/releases/download/v${VERSION}/draw.war && \
    cp -rp /tmp/draw.war ${JETTY_BASE}/webapps/

WORKDIR ${JETTY_BASE}

EXPOSE 8080

CMD ["catalina.sh", "run"]