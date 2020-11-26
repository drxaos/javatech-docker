#!/bin/bash
# shellcheck disable=SC2068
bash ./stop.sh $@
docker-compose build $@
bash ./start.sh $@
