[![](https://images.microbadger.com/badges/image/fjudith/draw.io.svg)](https://microbadger.com/images/fjudith/draw.io "Get your own image badge on microbadger.com")
[![Build Status](https://travis-ci.org/fjudith/docker-draw.io.svg?branch=master)](https://travis-ci.org/fjudith/docker-draw.io)
[![Docker Repository on Quay](https://quay.io/repository/fjudith/draw.io/status "Docker Repository on Quay")](https://quay.io/repository/fjudith/draw.io)

# Supported tags and respective Dockerfile links

[`10.2.2`, `latest`](https://github.com/fjudith/docker-draw.io/tree/10.2.2/debian)
[`10.2.2-alpine`, `alpine`](https://github.com/fjudith/docker-draw.io/tree/10.2.2/alpine)

# Introduction

draw.io (formerly Diagramly) is free online diagram software. You can use it as a flowchart maker, network diagram software, to create UML online, as an ER diagram tool, to design database schema, to build BPMN online, as a circuit diagram maker, and more. draw.io can import .vsdx, Gliffy™ and Lucidchart™ files . 

# Description

The Dockerfile builds from `tomcat:9-jre11-slim` and `tomcat:9-jre8-alpine (see https://hub.docker.com/_/tomcat/)

**This image does not leverage embedded database**

# Roadmap

* [x] Deployment as WAR package
* [x] Use Tomcat instead of apache
* [x] Patch with EmbedServlet2
* [x] Self-Signed certificate autogen
* [ ] Let's encrypt certificate autogen
* [x] Support SSL Keystore mount to `/user/local/tomcat/.keystore`

## Quick Start

Run the container.

```bash
docker run -it --rm --name="draw" -p 8080:8080 -p 8443:8443 fjudith/draw.io
```

Start a web browser session to http://localhost:8080/?offline=1&https=0 or https://localhost:8443/?offline=1

If you're running `Docker Toolbox` then start a web browser session to http://192.168.99.100:8080/?offline=1&https=0 or https://192.168.99.100:8443/?offline=1

> `?offline=1` is a security feature that disables support of cloud storage.

## Environment variables

* **LETS_ENCRYPT_ENABLED**: Enables Let's Encrypt certificate instead of self-signed; default `false`
* **PUBLIC_DNS**: DNS domain to be used as certificate "CN" record; default `draw.example.com`
* **ORGANISATION_UNIT**: Organisation unit to be used as certificate "OU" record; default `Cloud Native Application`
* **ORGANISATION**: Organisation name to be used as certificate "O" record; default `example inc`
* **CITY**: City name to be used as certificate "L" record; default `Paris`
* **STATE**: State name to be used as certificate "ST" record; default `Paris`
* **COUNTRY_CODE**: Country code to be used as certificate "C" record; default `FR`
* **KEYSTORE_PASS**: ".keystore"/.jks" store password; default `V3ry1nS3cur3P4ssw0rd`
* **KEY_PASS**: Private key password; default `<ref:KEYSTORE_PASS>`

# Reference

* https://github.com/jgraph/draw.io
* https://github.com/mikitex70/redmine_drawio
