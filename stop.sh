#!/bin/bash

if [ $# -eq 0 ]
then
  docker-compose down --rmi local --remove-orphans
else
  # shellcheck disable=SC2068
  docker-compose rm -fsv $@
fi
