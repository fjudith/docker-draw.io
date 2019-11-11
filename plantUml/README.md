This docker compose file runs draw.io with plantUml-server. It is used by draw.io to support embedding plantUml generated diagrams directly.

### Adding fonts to improve generated images

The docker-compose file bind the `fonts` folder into the running container system fonts.

The best option for Windows users is to copy the contents of `Windowsdrive:/Windows/Fonts` into `fonts` folder. These fonts are copyrighted and cannot be re-distributed freely.
