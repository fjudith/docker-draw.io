#!/bin/bash
set -e

LETS_ENCRYPT_ENABLED=${LETS_ENCRYPT_ENABLED:-false}
PUBLIC_URL=${PUBLIC_URL:-'draw.example.com'}
ORGANISATION_UNIT=${ORGANIZATION_UNIT:-'Cloud Native Application'}
ORGANISATION=${ORGANISATION:-'example inc'}
TOWN=${TOWN:-'Paris'}
STATE=${STATE:-'Paris'}
COUNTRY=${COUNTRY:-'FR'}
KEYSTORE_PASS=${KEYSTORE_PASS:-'V3rY1nS3cur3P4ssw0rd'}
KEY_PASS=${KEYSTORE_PASS:-$STORE_PASS}

keytool -genkey -noprompt -alias tomcat -dname "CN='${PUBLIC_URL}', OU=''${ORGANISATION_UNIT}', O='${ORGANISATION}', L='${TOWN}', S='${STATE}', C='${COUNTRY}'" -keystore $CATALINA_HOME/.keystore -storepass "${KEYSTORE_PASS}" -KeySize 2048 -keypass "${KEY_PASS}" -keyalg RSA

keytool -list -keystore $CATALINA_HOME/.keystore -v -storepass "${KEYSTORE_PASS}" > key.check

keytool -certreq -alias tomcat -file request.csr -keystore $CATALINA_HOME/.keystore -storepass "${KEYSTORE_PASS}"

certbot certonly --csr ./request.csr --standalone

keytool -import -trustcacerts -alias tomcat -file 0001_chain.pem -keystore /usr/share/tomcat7/.keystore -storepass "${KEYSTORE_PASS}"

<Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
               maxThreads="150" scheme="https" secure="true"
               clientAuth="false" sslProtocol="TLS" KeystoreFile="$CATALINA_HOME/.keystore" KeystorePass="${KEY_PASS}" />

xmlstarlet ed \
    -P -S -L \
    -i '/Server/Service/Engine/Host/Valve' -t 'elem' -n 'Context' \
exec "$@"