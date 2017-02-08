# Introduction

draw.io (formerly Diagramly) is free online diagram software. You can use it as a flowchart maker, network diagram software, to create UML online, as an ER diagram tool, to design database schema, to build BPMN online, as a circuit diagram maker, and more. draw.io can import .vsdx, Gliffy™ and Lucidchart™ files . 

 # Description
The Dockerfile buils from "php:5-apache (see https://hub.docker.com/_/php/)

**This image does not leverage embedded database**

## Quick Start

Run the container.

```bash
docker run -it --rm -name="draw" -p 80:80 fjudith/draw.io
```

Start a web browser session to http://ip:port/war/index.html?offline=1

> `offline=1` is a security feature that disables support of cloud storage.