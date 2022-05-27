#! /bin/bash

ENVIRONMENT=$1
SQS_QUEUE_NAME=$2
AWS_ACCOUNT_ID=$3
REGION=$4

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/SQS_QUEUE_NAME=.*/SQS_QUEUE_NAME=$SQS_QUEUE_NAME/" "$ENVIRONMENT.env"
  sed -i '' "s/SQS_URL=.*/SQS_URL=https:\/\/sqs.$REGION.amazonaws.com\/$AWS_ACCOUNT_ID\/$SQS_QUEUE_NAME/" "$ENVIRONMENT.env"
else
  sed -i "s/SQS_QUEUE_NAME=.*/SQS_QUEUE_NAME=$SQS_QUEUE_NAME/" "$ENVIRONMENT.env"
  sed -i "s/SQS_URL=.*/SQS_URL=https:\/\/sqs.$REGION.amazonaws.com\/$AWS_ACCOUNT_ID\/$SQS_QUEUE_NAME/" "$ENVIRONMENT.env"
fi