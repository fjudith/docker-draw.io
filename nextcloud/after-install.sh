#!/bin/bash

docker exec -u www-data nextcloud-app php occ --no-warnings app:install drawio
docker exec -u www-data nextcloud-app php occ --no-warnings config:app:set drawio DrawioUrl --value="$1"
