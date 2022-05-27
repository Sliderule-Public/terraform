#! /bin/bash

ENVIRONMENT=$1
REDIS_HOST=$2
REDIS_PORT=$3

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/REDIS_HOST=.*/REDIS_HOST=$REDIS_HOST/" "$ENVIRONMENT.env"
  sed -i '' "s/REDIS_PORT=.*/REDIS_PORT=$REDIS_PORT/" "$ENVIRONMENT.env"
else
  sed -i "s/REDIS_HOST=.*/REDIS_HOST=$REDIS_HOST/" "$ENVIRONMENT.env"
  sed -i "s/REDIS_PORT=.*/REDIS_PORT=$REDIS_PORT/" "$ENVIRONMENT.env"
fi