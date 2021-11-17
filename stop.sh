#!/bin/bash

# shellcheck disable=SC2068

if [ $# -eq 0 ]
then
  docker-compose down --rmi local --remove-orphans
else
  docker-compose rm -fsv $@
fi
