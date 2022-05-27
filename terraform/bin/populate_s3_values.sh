#! /bin/bash

ENVIRONMENT=$1
SERVER_BUCKET=$2

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/SERVER_BUCKET=.*/SERVER_BUCKET=$SERVER_BUCKET/" "$ENVIRONMENT.env"
else
  sed -i "s/SERVER_BUCKET=.*/SERVER_BUCKET=$SERVER_BUCKET/" "$ENVIRONMENT.env"
fi