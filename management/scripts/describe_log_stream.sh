#!/bin/bash
set -e
if test -f "env_variables.sh"; then
    source env_variables.sh
else 
    echo "no env_variables.sh file found"
    exit 1 
fi


if [ $# -eq 2 ]
  then
    aws logs get-log-events --region $AWS_REGION --profile $PROFILE --log-group-name "/ecs/${COMPANY_KEY}/${ENVIRONMENT_KEY}/${OUR_NAME}-api" --log-stream-name $1 --next-token $2
else 
    aws logs get-log-events --region $AWS_REGION --profile $PROFILE --log-group-name "/ecs/${COMPANY_KEY}/${ENVIRONMENT_KEY}/${OUR_NAME}-api" --log-stream-name $1
fi
