FROM php:5-apache

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV VERSION=6.0.3.7

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends wget unzip && \
	rm -r /var/lib/apt/lists/*

RUN cd /tmp && \
    wget https://github.com/jgraph/draw.io/archive/v${VERSION}.zip && \
    unzip v${VERSION}.zip

RUN cp -rp /tmp/draw.io-${VERSION}/* /var/www/html/ && \
	chown -R www-data:www-data /var/www/html/ && ls -l

EXPOSE 80

CMD ["apache2-foreground"]

