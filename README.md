# Introduction

draw.io (formerly Diagramly) is free online diagram software. You can use it as a flowchart maker, network diagram software, to create UML online, as an ER diagram tool, to design database schema, to build BPMN online, as a circuit diagram maker, and more. draw.io can import .vsdx, Gliffy™ and Lucidchart™ files . 

 # Description
The Dockerfile buils from "tomcat:8-jre7" (see https://hub.docker.com/_/tomcat/)

**This image does not leverage embedded database**

## Quick Start

Run the container.

```bash
docker run -it --rm -name="draw.io" -p 80:80 fjudith/draw.io
```

Start a web browser session to http://ip:port/draw


> `?offline=1` argument is a security feature that disables support of cloud storage.