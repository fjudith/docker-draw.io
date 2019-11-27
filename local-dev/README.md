This directory is just for local development purpose.
Originally copied from debian/*.

## Additional configuration

Addition to [../README](../README.md), the following variables can be
customized:

* **SERVER_URL_PREFIX**:  base URL for this server
* **EDITOR_UI_DRAW_URL**: viewer URL for a file saved as *.html extention

## How to build

1. customize PreConfig.js.  It is git-ignored.
2. docker build
      > $ docker build -t <tag> .

## Reference

* <https://github.com/maedadev/drawio>
