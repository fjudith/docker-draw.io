FROM node

LABEL maintainer="JGraph Ltd"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        chromium libatk-bridge2.0-0 libgtk-3-0 && \
    mkdir /usr/local/drawio && \
    cd /usr/local/drawio && \
    git clone https://github.com/jgraph/draw-image-export2.git && \
    cd draw-image-export2 && \
    npm install && \
    apt-get remove -y --purge chromium
    
WORKDIR /usr/local/drawio/draw-image-export2

EXPOSE 8000

CMD ["npm", "start"]