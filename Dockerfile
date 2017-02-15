FROM jetty

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.0.3.7

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openjdk-7-jdk git patch && \
	rm -r /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://github.com/jgraph/draw.io/archive/v${VERSION}.zip && \
    unzip v${VERSION}.zip 

ADD assets/embed2js.patch /tmp/draw.io-${VERSION}/war/plugins/

RUN cd /tmp/draw.io-${VERSION} && \
    patch -p1 war/plugins/embed2js.patch && \
    cd etc/build && \
    ant war && \
    cd ../../build && \
    cp -rp /tmp/draw.io-${VERSION}/build/draw.war $CATALINA_HOME/webapps/

WORKDIR $CATALINA_HOME


EXPOSE 8080

CMD ["catalina.sh", "run"]

