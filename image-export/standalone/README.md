This docker image is standalone image-export-server of draw.io. It is used by draw.io to export mainly to PDF format as well as other images format when mathematical typesetting is enabled

### Adding fonts to improve generated images/PDFs

The docker-compose file bind the `fonts` folder into the running container system fonts. Add your fonts to that folder in order to get matching results of the exported diagrams.

The best option for Windows users is to copy the contents of `Windowsdrive:/Windows/Fonts` into `fonts` folder. These fonts are copyrighted and cannot be re-distributed freely.
